Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9E81D0F54
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 May 2020 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbgEMKIC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 May 2020 06:08:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58020 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730822AbgEMKIC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 May 2020 06:08:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04D9v9fG045516;
        Wed, 13 May 2020 10:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=zh+ju+WNq1j5AnnK3rpfvSbazZugblVvLDrXBXcH7XE=;
 b=oUGjqk6UZAPzpqEv9yyrP8WFD//+fGvhhWBmKUFp6CCMWLEdaLIc3jcmZ0jKq6kgTp5c
 cIzKvXkfsbzz6MbiwIFhomd6wSgNxxl59SkuPGCCP6VJ1L4Jo8puNG6Trjti23vyS7Lg
 GqyRd/BF+PRmfY8BoMZFCHmXby4Kyp7BffDFi+wRPyIvXwQUL3iL+WtIAhBqmxnT16Qd
 rKVng8Xc38qGGKaKDw8cB85M587eDHj3RXdsdSAHKLSkmn+aht0rAaxA1dtTGbP8PcQv
 qB2r3udvOqnabod6xpGTiGfxwZbxdVRGR+VBOMp3KTfJT1bV6Lunn2OD94TQkbMJUpb8 Eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3100xwk8n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 10:07:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DA4VqG089980;
        Wed, 13 May 2020 10:07:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3100yksfxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 10:07:55 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DA7rtY023466;
        Wed, 13 May 2020 10:07:53 GMT
Received: from dhcp-10-175-168-15.vpn.oracle.com (/10.175.168.15)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 03:07:53 -0700
Date:   Wed, 13 May 2020 11:07:44 +0100 (BST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     David Gow <davidgow@google.com>
cc:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Marco Elver <elver@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kunit: Support skipped tests
In-Reply-To: <20200513042956.109987-1-davidgow@google.com>
Message-ID: <alpine.LRH.2.21.2005131039280.16613@localhost>
References: <20200513042956.109987-1-davidgow@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130090
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 12 May 2020, David Gow wrote:

> This is a proof-of-concept to support "skipping" tests.
>

Really glad to see skip support; nice work!
 
> The kunit_mark_skipped() macro marks the current test as "skipped", with
> the provided reason. The kunit_skip() macro will mark the test as
> skipped, and abort the test.
> 
> The TAP specification supports this "SKIP directive" as a comment after
> the "ok" / "not ok" for a test. See the "Directives" section of the TAP
> spec for details:
> https://testanything.org/tap-specification.html#directives
>

My first thought before consulting this was the right answer is
to expand the kunit status from a bool to include skipped as
a possiblility (making it an "enum kunit_status") but the the,
above seems to classify skipping as a directive with a reason,
while the test status is still reported as "ok".

Despite that, I wonder if having test status as an enum still
might make sense?  kunit_status_to_string() would still render
KUNIT_SKIPPED as "ok" in such a case, but having the skipped
state in status might make computing if the plan line should
print "skipped" easier (if all subtests have status == KUNIT_SKIPPED).
Taking that approach might also be more extensible; implementing
TODO and other directives would become much easier.

So instead of having a kunit_skip() macro, we could possibly
rework kunit_print_ok_not_ok() to be something like
kunit_print_status(), with a status enum value and an optional
directive string.  That way, adding new status values would
be simply a case of adding to the enum and specifying 
an associated string value ("ok" for skip, "not ok" for
TODO, etc). Plus a KUNIT_SKIPPED status could easily
progagate up from the tests to the plan result line
(all tests have status == SKIPPED => plan status = SKIPPED).

Would that work? Thanks!

Alan

> kunit_tool will parse this SKIP directive, and renders skipped tests in
> yellow and counts them. Skipped tests do not affect the result for a
> suite.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Following on from discussions about the KCSAN test[1], which requires a
> multi-core/processor system to make sense, it would be useful for tests
> to be able to mark themselves as "skipped", where tests have runtime
> dependencies which aren't met.
> 
> As a proof-of-concept, this patch doesn't implement some things which
> we'd ideally like to have (e.g., non-static "reasons" for skipping the
> test, maybe some SKIP macros akin to the EXPECT and ASSERT ones), and
> the implementation is still pretty hacky, but I though I'd put this out
> there to see if there are any thoughts on the concept in general.
> 
> Cheers,
> -- David
> 
> [1]: https://lkml.org/lkml/2020/5/5/31
> 
>  include/kunit/test.h                | 12 ++++++++++++
>  lib/kunit/kunit-example-test.c      |  7 +++++++
>  lib/kunit/test.c                    | 23 ++++++++++++++++-------
>  tools/testing/kunit/kunit_parser.py | 21 +++++++++++++++++----
>  4 files changed, 52 insertions(+), 11 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9b0c46a6ca1f..7817c5580b2c 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -178,6 +178,7 @@ struct kunit_suite {
>  	/* private - internal use only */
>  	struct dentry *debugfs;
>  	char *log;
> +	const char *skip_directive;
>  };
>  
>  /**
> @@ -213,6 +214,8 @@ struct kunit {
>  	 * protect it with some type of lock.
>  	 */
>  	struct list_head resources; /* Protected by lock. */
> +
> +	const char *skip_directive;
>  };
>  
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
> @@ -391,6 +394,15 @@ void kunit_cleanup(struct kunit *test);
>  
>  void kunit_log_append(char *log, const char *fmt, ...);
>  
> +#define kunit_mark_skipped(test_or_suite, reason)			\
> +	(test_or_suite)->skip_directive = "SKIP " reason
> +
> +#define kunit_skip(test_or_suite, reason)				\
> +	do {								\
> +		kunit_mark_skipped(test_or_suite, reason);		\
> +		kunit_try_catch_throw(&((test_or_suite)->try_catch));	\
> +	} while (0)
> +
>  /*
>   * printk and log to per-test or per-suite log buffer.  Logging only done
>   * if CONFIG_KUNIT_DEBUGFS is 'y'; if it is 'n', no log is allocated/used.
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index be1164ecc476..998401a61458 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -29,6 +29,12 @@ static void example_simple_test(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
>  }
>  
> +static void example_skip_test(struct kunit *test)
> +{
> +	kunit_skip(test, "this test should be skipped");
> +	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
> +}
> +
>  /*
>   * This is run once before each test case, see the comment on
>   * example_test_suite for more information.
> @@ -52,6 +58,7 @@ static struct kunit_case example_test_cases[] = {
>  	 * test suite.
>  	 */
>  	KUNIT_CASE(example_simple_test),
> +	KUNIT_CASE(example_skip_test),
>  	{}
>  };
>  
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index ccb2ffad8dcf..84b9be3a8da7 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -79,10 +79,12 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>  				  bool is_test,
>  				  bool is_ok,
>  				  size_t test_number,
> -				  const char *description)
> +				  const char *description,
> +				  const char *directive)
>  {
>  	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
>  	struct kunit *test = is_test ? test_or_suite : NULL;
> +	const char *directive_header = directive ? " # " : "";
>  
>  	/*
>  	 * We do not log the test suite results as doing so would
> @@ -93,13 +95,16 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
>  	 * representation.
>  	 */
>  	if (suite)
> -		pr_info("%s %zd - %s\n",
> +		pr_info("%s %zd - %s%s%s\n",
>  			kunit_status_to_string(is_ok),
> -			test_number, description);
> +			test_number, description,
> +			directive_header, directive ? directive : "");
>  	else
> -		kunit_log(KERN_INFO, test, KUNIT_SUBTEST_INDENT "%s %zd - %s",
> +		kunit_log(KERN_INFO, test,
> +			  KUNIT_SUBTEST_INDENT "%s %zd - %s%s%s",
>  			  kunit_status_to_string(is_ok),
> -			  test_number, description);
> +			  test_number, description,
> +			  directive_header, directive ? directive : "");
>  }
>  
>  bool kunit_suite_has_succeeded(struct kunit_suite *suite)
> @@ -122,7 +127,8 @@ static void kunit_print_subtest_end(struct kunit_suite *suite)
>  	kunit_print_ok_not_ok((void *)suite, false,
>  			      kunit_suite_has_succeeded(suite),
>  			      kunit_suite_counter++,
> -			      suite->name);
> +			      suite->name,
> +			      suite->skip_directive);
>  }
>  
>  unsigned int kunit_test_case_num(struct kunit_suite *suite,
> @@ -232,6 +238,7 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
>  	if (test->log)
>  		test->log[0] = '\0';
>  	test->success = true;
> +	test->skip_directive = NULL;
>  }
>  EXPORT_SYMBOL_GPL(kunit_init_test);
>  
> @@ -357,7 +364,8 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>  
>  	kunit_print_ok_not_ok(&test, true, test_case->success,
>  			      kunit_test_case_num(suite, test_case),
> -			      test_case->name);
> +			      test_case->name,
> +			      test.skip_directive);
>  }
>  
>  int kunit_run_tests(struct kunit_suite *suite)
> @@ -378,6 +386,7 @@ EXPORT_SYMBOL_GPL(kunit_run_tests);
>  static void kunit_init_suite(struct kunit_suite *suite)
>  {
>  	kunit_debugfs_create_suite(suite);
> +	suite->skip_directive = NULL;
>  }
>  
>  int __kunit_test_suites_init(struct kunit_suite **suites)
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 64aac9dcd431..ecfc8ee1da2f 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -43,6 +43,7 @@ class TestCase(object):
>  class TestStatus(Enum):
>  	SUCCESS = auto()
>  	FAILURE = auto()
> +	SKIPPED = auto()
>  	TEST_CRASHED = auto()
>  	NO_TESTS = auto()
>  
> @@ -107,6 +108,8 @@ def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
>  
>  OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
>  
> +OK_NOT_OK_SKIP = re.compile(r'^[\s]*(ok|not ok) [0-9]+ - (.*) # SKIP (.*)$')
> +
>  OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
>  
>  OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
> @@ -124,6 +127,10 @@ def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
>  	if match:
>  		test_case.log.append(lines.pop(0))
>  		test_case.name = match.group(2)
> +		skip_match = OK_NOT_OK_SKIP.match(line)
> +		if skip_match:
> +			test_case.status = TestStatus.SKIPPED
> +			return True
>  		if test_case.status == TestStatus.TEST_CRASHED:
>  			return True
>  		if match.group(1) == 'ok':
> @@ -190,9 +197,9 @@ def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
>  		return TestStatus.TEST_CRASHED
>  	elif left == TestStatus.FAILURE or right == TestStatus.FAILURE:
>  		return TestStatus.FAILURE
> -	elif left != TestStatus.SUCCESS:
> +	elif left != TestStatus.SUCCESS and left != TestStatus.SKIPPED:
>  		return left
> -	elif right != TestStatus.SUCCESS:
> +	elif right != TestStatus.SUCCESS and right != TestStatus.SKIPPED:
>  		return right
>  	else:
>  		return TestStatus.SUCCESS
> @@ -281,10 +288,13 @@ def parse_run_tests(kernel_output) -> TestResult:
>  	total_tests = 0
>  	failed_tests = 0
>  	crashed_tests = 0
> +	skipped_tests = 0
>  	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
>  	for test_suite in test_result.suites:
>  		if test_suite.status == TestStatus.SUCCESS:
>  			print_suite_divider(green('[PASSED] ') + test_suite.name)
> +		elif test_suite.status == TestStatus.SKIPPED:
> +			print_suite_divider(yellow('[SKIPPED] ') + test_suite.name)
>  		elif test_suite.status == TestStatus.TEST_CRASHED:
>  			print_suite_divider(red('[CRASHED] ' + test_suite.name))
>  		else:
> @@ -293,6 +303,9 @@ def parse_run_tests(kernel_output) -> TestResult:
>  			total_tests += 1
>  			if test_case.status == TestStatus.SUCCESS:
>  				print_with_timestamp(green('[PASSED] ') + test_case.name)
> +			elif test_case.status == TestStatus.SKIPPED:
> +				skipped_tests += 1
> +				print_with_timestamp(yellow('[SKIPPED] ') + test_case.name)
>  			elif test_case.status == TestStatus.TEST_CRASHED:
>  				crashed_tests += 1
>  				print_with_timestamp(red('[CRASHED] ' + test_case.name))
> @@ -306,6 +319,6 @@ def parse_run_tests(kernel_output) -> TestResult:
>  	print_with_timestamp(DIVIDER)
>  	fmt = green if test_result.status == TestStatus.SUCCESS else red
>  	print_with_timestamp(
> -		fmt('Testing complete. %d tests run. %d failed. %d crashed.' %
> -		    (total_tests, failed_tests, crashed_tests)))
> +		fmt('Testing complete. %d tests run. %d failed. %d crashed. %d skipped.' %
> +		    (total_tests, failed_tests, crashed_tests, skipped_tests)))
>  	return test_result
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 
> 
