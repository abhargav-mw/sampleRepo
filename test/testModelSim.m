classdef testModelSim < matlab.unittest.TestCase
    %TESTCALC Summary of this class goes here
    %   Detailed explanation goes here
    
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

