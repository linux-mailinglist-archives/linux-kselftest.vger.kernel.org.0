Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891D976B5A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 15:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjHANV3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 09:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjHANV2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 09:21:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3557F10C3;
        Tue,  1 Aug 2023 06:21:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B830661593;
        Tue,  1 Aug 2023 13:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B10BC433C7;
        Tue,  1 Aug 2023 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690896086;
        bh=rhZs8WvpeDdD/lD7n3xXs2aoj3z1VB7E4PDP0oU22EE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TPWfXHS17ip7EH8JQAphBzmLWL5eFSgkJJTLLMTAbdVxHPI8AgP5eTCauW1vuR/wF
         EZ5sKnojzysZCIT1MzEfxx0KEBOonbmR5cZN2Gq1wXl3AvUo4HD5y+MwOLtV8a9ZEu
         KDZkxFsILSLB2BRDtbq+MiVvw7AbH+hsCr3LNhHHwUE+3eT6v6NGErLbJaC+dGc9ex
         MPfj+2rvCcGFxrq6px/itwngoJ56sc8iTwIV2skbqEuu6pwXzZhmVT1y6lrN05t2Zk
         zySMZ1CDI993In29OnpByKe4F4uuwiU0blcvA6oLgT+BYJvkuGh2CGObbEm46wIC4n
         A0uq0BwAAz++A==
Date:   Tue, 1 Aug 2023 15:21:20 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        igt-dev@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] kunit: Make 'list' action available to kunit
 test modules
Message-ID: <20230801152120.3f53f876@coco.lan>
In-Reply-To: <20230731141021.2854827-7-janusz.krzysztofik@linux.intel.com>
References: <20230731141021.2854827-5-janusz.krzysztofik@linux.intel.com>
        <20230731141021.2854827-7-janusz.krzysztofik@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em Mon, 31 Jul 2023 16:10:24 +0200
Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com> escreveu:

> Results from kunit tests reported via dmesg may be interleaved with other
> kernel messages.  When parsing dmesg for modular kunit results in real
> time, external tools, e.g., Intel GPU tools (IGT), may want to insert
> their own test name markers into dmesg at the start of each test, before
> any kernel message related to that test appears there, so existing upper
> level test result parsers have no doubt which test to blame for a specific
> kernel message.  Unfortunately, kunit reports names of tests only at their
> completion (with the exeption of a not standarized "# Subtest: <name>"
> header above a test plan of each test suite or parametrized test).
> 
> External tools could be able to insert their own "start of the test"
> markers with test names included if they new those names in advance.
> Test names could be learned from a list if provided by a kunit test
> module.
> 
> There exists a feature of listing kunit tests without actually executing
> them, but it is now limited to configurations with the kunit module built
> in and covers only built-in tests, already available at boot time.
> Moreover, switching from list to normal mode requires reboot.  If that
> feature was also available when kunit is built as a module, userspace
> could load the module with action=list parameter, load some kunit test
> modules they are interested in and learn about the list of tests provided
> by those modules, then unload them, reload the kunit module in normal mode
> and execute the tests with their lists already known.
> 
> Extend kunit module notifier initialization callback with a processing
> path for only listing the tests provided by a module if the kunit action
> parameter is set to "list".  For ease of use, submit the list in the
> format of a standard KTAP report, with SKIP result from each test case,
> giving "list mode" as the reason for skipping.  For each test suite
> provided by a kunit test module, make such list of its test cases also
> available via kunit debugfs for the lifetime of the module.  For user
> convenience, make the kunit.action parameter visible in sysfs.

It sounds interesting to have a modprobe option to just list the
tests without excecuting.

> 
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> ---
>  include/kunit/test.h |  1 +
>  lib/kunit/executor.c | 19 +++++++++++++------
>  lib/kunit/test.c     | 30 +++++++++++++++++++++++++++++-
>  3 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 23120d50499ef..6d693f21a4833 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -237,6 +237,7 @@ static inline void kunit_set_failure(struct kunit *test)
>  }
>  
>  bool kunit_enabled(void);
> +const char *kunit_action(void);
>  
>  void kunit_init_test(struct kunit *test, const char *name, char *log);
>  
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 74982b83707ca..d1c0616569dfd 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -12,19 +12,26 @@
>  extern struct kunit_suite * const __kunit_suites_start[];
>  extern struct kunit_suite * const __kunit_suites_end[];
>  
> +static char *action_param;
> +
> +module_param_named(action, action_param, charp, 0400);
> +MODULE_PARM_DESC(action,
> +		 "Changes KUnit executor behavior, valid values are:\n"
> +		 "<none>: run the tests like normal\n"
> +		 "'list' to list test names instead of running them.\n");

Help message sounded confusing. What about adding a boolean modprobe
parameter, like "list_tests"?

> +
> +const char *kunit_action(void)
> +{
> +	return action_param;
> +}
> +
>  #if IS_BUILTIN(CONFIG_KUNIT)
>  
>  static char *filter_glob_param;
> -static char *action_param;
>  
>  module_param_named(filter_glob, filter_glob_param, charp, 0);
>  MODULE_PARM_DESC(filter_glob,
>  		"Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
> -module_param_named(action, action_param, charp, 0);
> -MODULE_PARM_DESC(action,
> -		 "Changes KUnit executor behavior, valid values are:\n"
> -		 "<none>: run the tests like normal\n"
> -		 "'list' to list test names instead of running them.\n");
>  
>  /* glob_match() needs NULL terminated strings, so we need a copy of filter_glob_param. */
>  struct kunit_test_filter {
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index a29ca1acc4d81..413d9fd364a8d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -674,6 +674,27 @@ int kunit_run_tests(struct kunit_suite *suite)
>  }
>  EXPORT_SYMBOL_GPL(kunit_run_tests);
>  
> +static void kunit_list_suite(struct kunit_suite *suite)
> +{
> +	struct kunit_case *test_case;
> +
> +	kunit_print_suite_start(suite);
> +
> +	kunit_suite_for_each_test_case(suite, test_case) {
> +		struct kunit test = { .param_value = NULL, .param_index = 0 };
> +
> +		kunit_init_test(&test, test_case->name, test_case->log);
> +
> +		kunit_print_ok_not_ok(&test, true, KUNIT_SKIPPED,
> +				      kunit_test_case_num(suite, test_case),
> +				      test_case->name, "list mode");
> +	}
> +
> +	kunit_print_ok_not_ok((void *)suite, false, KUNIT_SKIPPED,
> +			      kunit_suite_counter++,
> +			      suite->name, "list mode");
> +}
> +
>  static void kunit_init_suite(struct kunit_suite *suite)
>  {
>  	kunit_debugfs_create_suite(suite);
> @@ -688,6 +709,7 @@ bool kunit_enabled(void)
>  
>  int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites)
>  {
> +	const char *action = kunit_action();
>  	unsigned int i;
>  
>  	if (!kunit_enabled() && num_suites > 0) {
> @@ -699,7 +721,13 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>  
>  	for (i = 0; i < num_suites; i++) {
>  		kunit_init_suite(suites[i]);
> -		kunit_run_tests(suites[i]);
> +
> +		if (!action)
> +			kunit_run_tests(suites[i]);
> +		else if (!strcmp(action, "list"))
> +			kunit_list_suite(suites[i]);
> +		else
> +			pr_err("kunit: unknown action '%s'\n", action);
>  	}
>  
>  	static_branch_dec(&kunit_running);

The remaining code LGTM.


Thanks,
Mauro
