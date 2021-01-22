classdef testModelSim < matlab.unittest.TestCase
    %TESTMODELSIM Summary of this class goes here
    %   Detailed explanation goes here
    properties
        temp;
        ogDir;
    end
    methods(TestClassSetup)
        function testClassSetup(testCase)
            sltest.testmanager.clear;
            sltest.testmanager.clearResults;
            testCase.ogDir = pwd;
            testCase.temp = fullfile(pwd, 'temp');
            mkdir(testCase.temp);
            matlab.unittest.fixtures.PathFixture(testCase.temp);
            cd(testCase.temp);
        end
    end
    
    methods(TestClassTeardown)
        function teardown(testCase)
            sltest.testmanager.clear;
            sltest.testmanager.clearResults;
            sltest.testmanager.close;
            A = dir(testCase.temp);
            for k = 3:length(A)
                delete([testCase.temp  filesep A(k).name])
            end
            cd(testCase.ogDir);
            rmdir(testCase.temp);
        end
    end
    
    methods(Test)
        function testSquare(testCase)
            %TESTCALC Construct an instance of this class
            %   Detailed explanation goes here
            tf = sltest.testmanager.TestFile('test.mldatx');
            ts = tf.getTestSuites;
            tc = ts.getTestCases;
            tc.setProperty('model', 'sampleModel.slx');
            captureBaselineCriteria(tc,'baseline_API.mat',true);
            res = tc.run();
            testCase.verifyEqual(res.Outcome, sltest.testmanager.TestResultOutcomes.Passed);
        end
    end
end

