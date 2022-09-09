Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E95B3BB1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 17:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiIIPSQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 11:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiIIPSO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 11:18:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63096103D;
        Fri,  9 Sep 2022 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662736693; x=1694272693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=haUPK2ttPHNt1xW1w7VWVrCTNsYVPPjWj9wJccCH4DQ=;
  b=YLBI2hbhMPiRBo+WxwSvlrToueHBfUaKcXUESedL1Iqyf5Ariw3R5SnW
   hi8fs7e5Gg+rHTZsXoJwd1gK2ysaZvQYG+I3u1u/pf4VFwIsHszHv149+
   4unOA26bFQ1hBWu9T72pICAur5H5kQKXalikkqWnMjJAdUFBT011q3Swf
   ZkpxCoMhCRsyq1US7HGfesgUgreRdvHwCT4aJEo1/ptACuXAErALYpK05
   USwvQe+0GrtSsushw9Mt6FT2n+cPk1T+LAxZta++l2UKxW4HzbkJmaRvZ
   C6RTwUq4vh0Bkr7dKxgg74cVtrDv5PiwhvVsANKvuuxlNXQs7TGWnnkMf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="296233661"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="296233661"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 08:18:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="611087499"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.25.143])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 08:18:06 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     igt-dev@lists.freedesktop.org
Cc:     linux-kselftest@vger.kernel.org, daniel@ffwll.ch,
        kunit-dev@googlegroups.com, magalilemes00@gmail.com,
        maira.canal@usp.br, dlatypov@google.com, n@nfraprado.net,
        linux-kernel@vger.kernel.org, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, davidgow@google.com,
        tales.aparecida@gmail.com, skhan@linuxfoundation.org,
        andrealmeid@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        brendanhiggins@google.com, twoerner@gmail.com,
        Isabella Basso <isabbasso@riseup.net>
Subject: Re: [igt-dev] [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility for KUnit
Date:   Fri, 09 Sep 2022 17:18:03 +0200
Message-ID: <2101392.KlZ2vcFHjT@jkrzyszt-mobl1.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220829000920.38185-4-isabbasso@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net> <20220829000920.38185-4-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Isabella,

On Monday, 29 August 2022 02:09:19 CEST Isabella Basso wrote:
> This adds functions for both executing the tests as well as parsing (K)TAP
> kmsg output, as per the KTAP spec [1].
> 
> [1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
> 
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  lib/igt_kmod.c | 290 +++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/igt_kmod.h |   2 +
>  2 files changed, 292 insertions(+)
> 
> diff --git a/lib/igt_kmod.c b/lib/igt_kmod.c
> index 97cac7f5..93cdfcc5 100644
> --- a/lib/igt_kmod.c
> +++ b/lib/igt_kmod.c
> @@ -25,6 +25,7 @@
>  #include <signal.h>
>  #include <errno.h>
>  #include <sys/utsname.h>
> +#include <limits.h>
>  
>  #include "igt_aux.h"
>  #include "igt_core.h"
> @@ -32,6 +33,8 @@
>  #include "igt_sysfs.h"
>  #include "igt_taints.h"
>  
> +#define BUF_LEN 4096
> +
>  /**
>   * SECTION:igt_kmod
>   * @short_description: Wrappers around libkmod for module loading/unloading
> @@ -713,6 +716,293 @@ void igt_kselftest_get_tests(struct kmod_module *kmod,
>  	kmod_module_info_free_list(pre);
>  }
>  
> +/**
> + * lookup_value:
> + * @haystack: the string to search in
> + * @needle: the string to search for
> + *
> + * Returns: the value of the needle in the haystack, or -1 if not found.
> + */
> +static long lookup_value(const char *haystack, const char *needle)
> +{
> +	const char *needle_rptr;
> +	char *needle_end;
> +	long num;
> +
> +	needle_rptr = strcasestr(haystack, needle);
> +
> +	if (needle_rptr == NULL)
> +		return -1;
> +
> +	/* skip search string and whitespaces after it */
> +	needle_rptr += strlen(needle);
> +
> +	num = strtol(needle_rptr, &needle_end, 10);
> +
> +	if (needle_rptr == needle_end)
> +		return -1;
> +
> +	if (num == LONG_MIN || num == LONG_MAX)
> +		return 0;
> +
> +	return num > 0 ? num : 0;
> +}
> +
> +static int find_next_tap_subtest(char *record, char *test_name,
> +				 bool is_subtest)
> +{
> +	const char *name_lookup_str,
> +	      *lend, *version_rptr, *name_rptr;
> +	long test_count;
> +
> +	name_lookup_str = "test: ";
> +
> +	version_rptr = strcasestr(record, "TAP version ");
> +	name_rptr = strcasestr(record, name_lookup_str);
> +
> +	/*
> +	 * total test count will almost always appear as 0..N at the beginning
> +	 * of a run, so we use it as indication of a run
> +	 */
> +	test_count = lookup_value(record, "..");
> +
> +	/* no count found, so this is probably not starting a (sub)test */
> +	if (test_count < 0) {
> +		if (name_rptr != NULL) {
> +			if (test_name[0] == '\0')
> +				strncpy(test_name,
> +					name_rptr + strlen(name_lookup_str),
> +					BUF_LEN);
> +			else if (strcmp(test_name, name_rptr + strlen(name_lookup_str)) == 0)
> +				return 0;
> +			else
> +				test_name[0] = '\0';
> +
> +		}
> +		return -1;
> +	}
> +
> +	/*
> +	 * "(K)TAP version XX" should be the first line on all (sub)tests as per
> +	 * https://www.kernel.org/doc/html/latest/dev-tools/ktap.html#version-lines
> +	 * but actually isn't, as it currently depends on whoever writes the
> +	 * test to print this info
> +	 */
> +	if (version_rptr == NULL)
> +		igt_info("Missing test version string\n");
> +
> +	if (name_rptr == NULL) {
> +		/* we have to keep track of the name string, as it might be
> +		 * contained in a line read previously */
> +		if (test_name[0] == '\0') {
> +			igt_info("Missing test name string\n");
> +
> +			if (is_subtest)
> +				igt_info("Running %ld subtests...\n", test_count);
> +			else
> +				igt_info("Running %ld tests...\n", test_count);
> +		} else {
> +			lend = strchrnul(test_name, '\n');
> +
> +			if (*lend == '\0') {
> +				if (is_subtest)
> +					igt_info("Executing %ld subtests in: %s\n",
> +						 test_count, test_name);
> +				else
> +					igt_info("Executing %ld tests in: %s\n",
> +						 test_count, test_name);
> +				return test_count;
> +			}
> +
> +			if (is_subtest)
> +				igt_info("Executing %ld subtests in: %.*s\n",
> +					 test_count, (int)(lend - test_name),
> +					 test_name);
> +			else
> +				igt_info("Executing %ld tests in: %.*s\n",
> +					 test_count, (int)(lend - test_name),
> +					 test_name);
> +			test_name[0] = '\0';
> +		}
> +	} else {
> +		name_rptr += strlen(name_lookup_str);
> +		lend = strchrnul(name_rptr, '\n');
> +		/*
> +		 * as the test count comes after the test name we need not check
> +		 * for a long line again
> +		 */
> +		if (is_subtest)
> +			igt_info("Executing %ld subtests in: %.*s\n",
> +				 test_count, (int)(lend - name_rptr),
> +				 name_rptr);
> +		else
> +			igt_info("Executing %ld tests in: %.*s\n",
> +				 test_count, (int)(lend - name_rptr),
> +				 name_rptr);
> +	}
> +
> +	return test_count;
> +}
> +
> +static void parse_kmsg_for_tap(const char *lstart, char *lend,
> +			       int *sublevel, bool *failed_tests)
> +{
> +	const char *nok_rptr, *comment_start, *value_parse_start;
> +
> +	nok_rptr = strstr(lstart, "not ok ");
> +	if (nok_rptr != NULL) {
> +		igt_warn("kmsg> %.*s\n",
> +			 (int)(lend - lstart), lstart);
> +		*failed_tests = true;
> +		return;
> +	}
> +
> +	comment_start = strchrnul(lstart, '#');
> +
> +	/* check if we're still in a subtest */
> +	if (*comment_start != '\0') {
> +		comment_start++;
> +		value_parse_start = comment_start;
> +
> +		if (lookup_value(value_parse_start, "fail: ") > 0) {
> +			igt_warn("kmsg> %.*s\n",
> +				 (int)(lend - comment_start), comment_start);
> +			*failed_tests = true;
> +			(*sublevel)--;
> +			return;
> +		}
> +	}
> +
> +	igt_info("kmsg> %.*s\n",
> +		 (int)(lend - lstart), lstart);
> +}
> +
> +static void igt_kunit_subtests(int fd, char *record,
> +			       int *sublevel, bool *failed_tests)

This function looks like nothing but a KTAP parser.  It doesn't perform any 
operations required for execution of kunit tests.  Shouldn't we better name it 
like igt_ktap_parser or something like that?  Besides, I would move that 
parser code to a separate source file.

> +{
> +	char test_name[BUF_LEN + 1], *lend;
> +
> +	lend = NULL;
> +	test_name[0] = '\0';
> +	test_name[BUF_LEN] = '\0';
> +
> +	while (*sublevel >= 0) {
> +		const char *lstart;
> +		ssize_t r;
> +
> +		if (lend != NULL && *lend != '\0')
> +			lseek(fd, (int) (lend - record), SEEK_CUR);
> +
> +		r = read(fd, record, BUF_LEN);
> +
> +		if (r <= 0) {
> +			switch (errno) {
> +			case EINTR:
> +				continue;
> +			case EPIPE:
> +				igt_warn("kmsg truncated: too many messages. \
> +					 You may want to increase log_buf_len \
> +					 in your boot options\n");
> +				continue;
> +			case !EAGAIN:
> +				igt_warn("kmsg truncated: unknown error (%m)\n");something 

If the intention here is to display this warning only in other cases but 
EAGAIN error then that won't work as intended.

> +				*sublevel = -1;

Shouldn't *sublevel be also set to -1 in all cases but EINTR and EPIPE, 
whether EAGAIN or anything else?

Other than that, please use /* fallthrough */ marking if you intentionally 
omit break;

> +			default:
> +				break;
> +			}
> +			break;
> +		}
> +
> +		lend = strchrnul(record, '\n');
> +
> +		/* in case line > 4096 */
> +		if (*lend == '\0')
> +			continue;

That means we are free to ignore initial fragments of lines exceeding 4096 
characters, but still will be looking at trailing fragments of those lines.  
This approach seems sub-optimal to me.  Wouldn't it be more convenient if we 
used line buffered I/O instead of read()?

> +
> +		if (find_next_tap_subtest(record, test_name, *sublevel > 0) != -1)
> +			(*sublevel)++;
> +
> +		if (*sublevel > 0) {
> +			lstart = strchrnul(record, ';');
> +
> +			if (*lstart == '\0') {
> +				igt_warn("kmsg truncated: output malformed (%m)\n");
> +				igt_fail(IGT_EXIT_FAILURE);
> +			}
> +
> +			lstart++;
> +			while (isspace(*lstart))
> +				lstart++;
> +
> +			parse_kmsg_for_tap(lstart, lend, sublevel, failed_tests);
> +		}
> +	}
> +
> +	if (*failed_tests || *sublevel < 0)
> +		igt_fail(IGT_EXIT_FAILURE);
> +	else
> +		igt_success();
> +}
> +
> +/**
> + * igt_kunit:
> + * @module_name: the name of the module
> + * @opts: options to load the module
> + *
> + * Loads the kunit module, parses its dmesg output, then unloads it
> + */
> +void igt_kunit(const char *module_name, const char *opts)
> +{
> +	struct igt_ktest tst;
> +	char record[BUF_LEN + 1];
> +	bool failed_tests = false;
> +	int sublevel = 0;
> +
> +	record[BUF_LEN] = '\0';
> +
> +	/* get normalized module name */
> +	if (igt_ktest_init(&tst, module_name) != 0) {
> +		igt_warn("Unable to initialize ktest for %s\n", module_name);
> +		return;
> +	}
> +
> +	if (igt_ktest_begin(&tst) != 0) {

Since igt_ktest_begin() as is calls igt_require() then it may be used only 
from inside an igt_fixture or igt_subtest block.  If the intention is to call
igt_kunit() from an igt_subtest block, unlike igt_kselftest() which has 
igt_fixture and igt_subtest blocks placed in its body, please document that.

> +		igt_warn("Unable to begin ktest for %s\n", module_name);
> +
> +		igt_ktest_fini(&tst);
> +		return;
> +	}
> +
> +	if (tst.kmsg < 0) {
> +		igt_warn("Could not open /dev/kmsg");
> +		goto unload;
> +	}
> +
> +	if (lseek(tst.kmsg, 0, SEEK_END)) {
> +		igt_warn("Could not seek the end of /dev/kmsg");
> +		goto unload;
> +	}
> +
> +	/* The kunit module is required for running any kunit tests */
> +	if (igt_kmod_load("kunit", NULL) != 0) {
> +		igt_warn("Unable to load kunit module\n");
> +		goto unload;
> +	}
> +
> +	if (igt_kmod_load(module_name, opts) != 0) {
> +		igt_warn("Unable to load %s module\n", module_name);
> +		goto unload;
> +	}
> +
> +	igt_kunit_subtests(tst.kmsg, record, &sublevel, &failed_tests);

What's the point of passing that many temporary variable pointers to 
igt_kunit_subtests() if we are not interested here in content of any of those 
variables after the function returns?  That function could perfectly use its 
own local variables for storing that data.

Besides, my comment about not using igt_require() outside of igt_fixture or 
igt_subtest blocks also applies to igt_fail() and igt_success() called from
igt_kunit_subtests().

Anyway, related to my comment about naming that function a parser, I think the 
best approach would be for that parser to return a generic set of results from 
kunit execution, then we could feed that data into an IGT specific handler 
that would convert them to IGT results (SUCCESS, FAIL, or SKIP) as if returned 
by a set of IGT dynamic subtests.

Thanks,
Janusz
 
> +unload:
> +	igt_kmod_unload("kunit", 0);
> +
> +	igt_ktest_end(&tst);
> +
> +	igt_ktest_fini(&tst);
> +}
> +
>  static int open_parameters(const char *module_name)
>  {
>  	char path[256];
> diff --git a/lib/igt_kmod.h b/lib/igt_kmod.h
> index ceb10cd0..737143c1 100644
> --- a/lib/igt_kmod.h
> +++ b/lib/igt_kmod.h
> @@ -45,6 +45,8 @@ int __igt_i915_driver_unload(char **whom);
>  int igt_amdgpu_driver_load(const char *opts);
>  int igt_amdgpu_driver_unload(void);
>  
> +void igt_kunit(const char *module_name, const char *opts);
> +
>  void igt_kselftests(const char *module_name,
>  		    const char *module_options,
>  		    const char *result_option,
> 




