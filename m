Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F47D9852
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbjJ0MdL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345867AbjJ0MdJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:33:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E1D10DD;
        Fri, 27 Oct 2023 05:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698409983; x=1729945983;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AF9FZzvp/D0GMVEQqKkwvatt27bentPedEfI8Ls3Dls=;
  b=OXekoXg0mbTpRgHYRBkGlpgZOn8tlJm8O4+yusXqihZ+TvDS+KP2Zyit
   jvzPNhgxJdOQVhRo5ERN6sbp7zdXDz+q0vf8UiwFX7tmiAKdLQYkaVtOE
   LXGB6ZyW6kc0C4St4HgZ08smfzv9k+pckUC5/pYPAPsyC5hRo9mWnvmpD
   a1f5q0T5u11HrPiqaVAQnnGhkwpV4i0mj6spVVkjMnC3qHgUaXpty94uC
   tEzl2aH936Wzq8+A1cj5kClRPSL1tcyrFlXCcJ794msmfXzaer+1BpQsE
   wuFEw1W+LfHnqxzaLEHqhkXHrwlyPpSJy17YfUmJWc1+KkjEB0rlai4DE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418877337"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="418877337"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="709398419"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="709398419"
Received: from scoltan-mobl.ger.corp.intel.com ([10.252.33.159])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:33:00 -0700
Date:   Fri, 27 Oct 2023 15:32:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
cc:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/24] selftests/resctrl: Rewrite Cache Allocation
 Technology (CAT) test
In-Reply-To: <kq6qds2hgcg3vlgokgyr4lukm7weuj3thvl7p2panfmk72ovpy@nshm6iva5wfr>
Message-ID: <fb5e1a50-ba7-1ee8-8bf2-bb8b64b27b1@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-17-ilpo.jarvinen@linux.intel.com> <kq6qds2hgcg3vlgokgyr4lukm7weuj3thvl7p2panfmk72ovpy@nshm6iva5wfr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-828398-1698409982=:2740"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-828398-1698409982=:2740
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 27 Oct 2023, Maciej Wieczór-Retman wrote:

> On 2023-10-24 at 12:26:26 +0300, Ilpo Järvinen wrote:
> >CAT test spawns two processes into two different control groups with
> >exclusive schemata. Both the processes alloc a buffer from memory
> >matching their allocated LLC block size and flush the entire buffer out
> >of caches. Since the processes are reading through the buffer only once
> >during the measurement and initially all the buffer was flushed, the
> >test isn't testing CAT.
> >
> >Rewrite the CAT test to allocate a buffer sized to half of LLC. Then
> >perform a sequence of tests with different LLC alloc sizes starting
> >from half of the CBM bits down to 1-bit CBM. Flush the buffer before
> >each test and read the buffer twice. Observe the LLC misses on the
> >second read through the buffer. As the allocated LLC block gets smaller
> >and smaller, the LLC misses will become larger and larger giving a
> >strong signal on CAT working properly.
> >
> >The new CAT test is using only a single process because it relies on
> >measured effect against another run of itself rather than another
> >process adding noise. The rest of the system is allocated the CBM bits
> >not used by the CAT test to keep the test isolated.
> >
> >Replace count_bits() with count_contiguous_bits() to get the first bit
> >position in order to be able to calculate masks based on it.
> >
> >This change has been tested with a number of systems from different
> >generations.
> >
> >Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> >Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >---
> > tools/testing/selftests/resctrl/cat_test.c  | 286 +++++++++-----------
> > tools/testing/selftests/resctrl/fill_buf.c  |   6 +-
> > tools/testing/selftests/resctrl/resctrl.h   |   5 +-
> > tools/testing/selftests/resctrl/resctrlfs.c |  44 +--
> > 4 files changed, 137 insertions(+), 204 deletions(-)
> >
> >diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> >index e71690a9bbb3..7518c520c5cc 100644
> >--- a/tools/testing/selftests/resctrl/cat_test.c
> >+++ b/tools/testing/selftests/resctrl/cat_test.c
> >@@ -11,65 +11,68 @@
> > #include "resctrl.h"
> > #include <unistd.h>
> > 
> >-#define RESULT_FILE_NAME1	"result_cat1"
> >-#define RESULT_FILE_NAME2	"result_cat2"
> >+#define RESULT_FILE_NAME	"result_cat"
> > #define NUM_OF_RUNS		5
> >-#define MAX_DIFF_PERCENT	4
> >-#define MAX_DIFF		1000000
> > 
> > /*
> >- * Change schemata. Write schemata to specified
> >- * con_mon grp, mon_grp in resctrl FS.
> >- * Run 5 times in order to get average values.
> >+ * Minimum difference in LLC misses between a test with n+1 bits CBM mask to
> >+ * the test with n bits. With e.g. 5 vs 4 bits in the CBM mask, the minimum
> >+ * difference must be at least MIN_DIFF_PERCENT_PER_BIT * (4 - 1) = 3 percent.
> >+ *
> >+ * The relationship between number of used CBM bits and difference in LLC
> >+ * misses is not expected to be linear. With a small number of bits, the
> >+ * margin is smaller than with larger number of bits. For selftest purposes,
> >+ * however, linear approach is enough because ultimately only pass/fail
> >+ * decision has to be made and distinction between strong and stronger
> >+ * signal is irrelevant.
> >  */
> >-static int cat_setup(struct resctrl_val_param *p)
> >-{
> >-	char schemata[64];
> >-	int ret = 0;
> >-
> >-	/* Run NUM_OF_RUNS times */
> >-	if (p->num_of_runs >= NUM_OF_RUNS)
> >-		return END_OF_TESTS;
> >-
> >-	if (p->num_of_runs == 0) {
> >-		sprintf(schemata, "%lx", p->mask);
> >-		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
> >-				     p->resctrl_val);
> >-	}
> >-	p->num_of_runs++;
> >-
> >-	return ret;
> >-}
> >+#define MIN_DIFF_PERCENT_PER_BIT	1
> > 
> > static int show_results_info(__u64 sum_llc_val, int no_of_bits,
> >-			     unsigned long cache_span, unsigned long max_diff,
> >-			     unsigned long max_diff_percent, unsigned long num_of_runs,
> >-			     bool platform)
> >+			     unsigned long cache_span, long min_diff_percent,
> >+			     unsigned long num_of_runs, bool platform,
> >+			     __s64 *prev_avg_llc_val)
> > {
> > 	__u64 avg_llc_val = 0;
> >-	float diff_percent;
> >-	int ret;
> >+	float avg_diff;
> >+	int ret = 0;
> > 
> > 	avg_llc_val = sum_llc_val / num_of_runs;
> >-	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
> >+	if (*prev_avg_llc_val) {
> >+		float delta = (__s64)(avg_llc_val - *prev_avg_llc_val);
> > 
> >-	ret = platform && abs((int)diff_percent) > max_diff_percent;
> >+		avg_diff = delta / *prev_avg_llc_val;
> >+		ret = platform && (avg_diff * 100) < (float)min_diff_percent;
> > 
> >-	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
> >-		       ret ? "Fail:" : "Pass:", max_diff_percent);
> >+		ksft_print_msg("%s Check cache miss rate changed more than %.1f%%\n",
> >+			       ret ? "Fail:" : "Pass:", (float)min_diff_percent);
> 
> Shouldn't "Fail" and "Pass" be flipped in the ternary operator? Or the condition
> sign above "<" should be ">"?

I must not touch ret ? "Fail:" : "Pass:" logic, it's the correct way 
around. If I'd touch it, it'd break what the calling code assumes about 
the return value.

(More explanation below).

> Now it looks like if (avg_diff * 100) is smaller than the min_diff_percent the
> test is supposed to fail but the text suggests it's the other way around.
>
> I also ran this selftest and that's the output:
> 
> # Pass: Check cache miss rate changed more than 3.0%
> # Percent diff=45.8
> # Number of bits: 4
> # Average LLC val: 322489
> # Cache span (lines): 294912
> # Pass: Check cache miss rate changed more than 2.0%
> # Percent diff=38.0
> # Number of bits: 3
> # Average LLC val: 445005
> # Cache span (lines): 221184
> # Pass: Check cache miss rate changed more than 1.0%
> # Percent diff=27.2
> # Number of bits: 2
> # Average LLC val: 566145
> # Cache span (lines): 147456
> # Pass: Check cache miss rate changed more than 0.0%
> # Percent diff=18.3
> # Number of bits: 1
> # Average LLC val: 669657
> # Cache span (lines): 73728
> ok 1 CAT: test
> 
> The diff percentages are much larger than the thresholds they're supposed to
> be within and the test is passed.

No, the whole test logic is changed dramatically by this patch and 
failure logic is reverse now because of it. Note how I also altered these 
things:

- MAX_DIFF_PERCENT -> MIN_DIFF_PERCENT_PER_BIT
- max_diff_percent -> min_diff_percent
- "cache miss rate within" -> "cache miss rate changed more than"

The new CAT test measures the # of cache misses (or in case of L2 CAT 
test, LLC accesses which is used as a proxy for L2 misses). Then it takes 
one bit away from the allocation mask and repeats the measurement.

If the # of LLC misses changes more than min_diff_precent when the 
number of bits in the allocation was changed, it is a strong indicator CAT 
is working like it should. Based on your numbers above, I'm extremely 
confident CAT works as expected!

I know for a fact that when the selftest is bound to a wrong resource id 
(which actually occurs on broadwell's with CoD enabled without one of the 
later patches in this series), this test is guaranteed to fail 100%, 
there's no noticeable difference measured in LLC misses in that case.

> >@@ -143,54 +168,64 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
> > 	if (ret)
> > 		return ret;
> > 
> >+	buf = alloc_buffer(span, 1);
> >+	if (buf == NULL)
> 
> Similiar to patch 01/24, wouldn't this:
> 	if (!buf)
> be better?

I've already changed this based on the comment you made against 1/24 :-).

-- 
 i.

--8323329-828398-1698409982=:2740--
