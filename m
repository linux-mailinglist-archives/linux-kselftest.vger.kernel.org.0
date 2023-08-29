Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6578C4C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 15:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbjH2NFb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 09:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbjH2NFQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 09:05:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E0E1B1;
        Tue, 29 Aug 2023 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693314312; x=1724850312;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MSJgDnjhkZLLZZe7es1EfRNxUqapCJrO1TyqZtge+XU=;
  b=VR0If8nJcbabXQeqQBrYEtYgi1uya49a5/A7FmqFEl4xozbHyxVkmn1j
   KuAqFxchtlMeUxHfCEoDcpzndmA5W+5W6d2iyCtfsoLCylPX0qrx/Q3Hq
   YZi+uN4HmCz5WDkWp8xYY7C2YlKR7HFGUKMaaL7ZjlZeAMWvFd46xWQB/
   dpIkA2uCVjAZqgsy2JJBAu7NCdUg1OAaCIidHJC+HwjEkpmhRwQK5Kl55
   KjZTjKYnem30E3V3/NnLpzITkHsz6iMpu34BLsa9J30dEVJApWJp8EAwl
   dtpmgMiOwqJn2Da/EmIuYehfyH5BVovZ5uMmABd1YRQgMY8lIGa+0U8NS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461724760"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="461724760"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="738693325"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="738693325"
Received: from tgodea-mobl.ger.corp.intel.com ([10.251.214.174])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 06:04:31 -0700
Date:   Tue, 29 Aug 2023 16:04:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH v3 7/7] selftests/resctrl: Cleanup benchmark argument
 parsing
In-Reply-To: <eetulhaho6ci25ahafo5qn4hag2ldnztnerxpmtuvh6vp2qlfn@lkazlrcje5sl>
Message-ID: <f31c39-41ce-2dc2-26e7-62466abdac2@linux.intel.com>
References: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com> <20230823131556.27617-8-ilpo.jarvinen@linux.intel.com> <eetulhaho6ci25ahafo5qn4hag2ldnztnerxpmtuvh6vp2qlfn@lkazlrcje5sl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1582552241-1693314274=:1757"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1582552241-1693314274=:1757
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 29 Aug 2023, Maciej Wieczór-Retman wrote:
> On 2023-08-23 at 16:15:56 +0300, Ilpo Järvinen wrote:
> >Benchmark argument is handled by custom argument parsing code which is
> >more complicated than it needs to be.
> >
> >Process benchmark argument within the normal getopt() handling and drop
> >entirely unnecessary ben_ind and has_ben variables. If -b is not given,
> >setup the default benchmark command right after the switch statement
> >and make -b to goto over it while it terminates the getopt() loop.
> >
> >Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> >---
> > .../testing/selftests/resctrl/resctrl_tests.c | 71 ++++++++++---------
> > 1 file changed, 36 insertions(+), 35 deletions(-)
> >
> >diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> >index 94516d1f4307..ae9001ef7b0a 100644
> >--- a/tools/testing/selftests/resctrl/resctrl_tests.c
> >+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> >@@ -169,28 +169,35 @@ static void run_cat_test(int cpu_no, int no_of_bits)
> > 
> > int main(int argc, char **argv)
> > {
> >-	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
> >-	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
> >+	bool mbm_test = true, mba_test = true, cmt_test = true;
> >+	int c, cpu_no = 1, i, no_of_bits = 0;
> > 	const char *benchmark_cmd[BENCHMARK_ARGS];
> >-	int ben_ind, tests = 0;
> > 	char *span_str = NULL;
> > 	bool cat_test = true;
> > 	char *skip_reason;
> >+	int tests = 0;
> > 	int ret;
> > 
> >-	for (i = 0; i < argc; i++) {
> >-		if (strcmp(argv[i], "-b") == 0) {
> >-			ben_ind = i + 1;
> >-			argc_new = ben_ind - 1;
> >-			has_ben = true;
> >-			break;
> >-		}
> >-	}
> >-
> >-	while ((c = getopt(argc_new, argv, "ht:b:n:p:")) != -1) {
> >+	while ((c = getopt(argc, argv, "ht:b:n:p:")) != -1) {
> > 		char *token;
> > 
> > 		switch (c) {
> >+		case 'b':
> >+			/*
> >+			 * First move optind back to the (first) optarg and
> >+			 * then build the benchmark command using the
> >+			 * remaining arguments.
> >+			 */
> >+			optind--;
> >+			if (argc - optind >= BENCHMARK_ARGS - 1)
> >+				ksft_exit_fail_msg("Too long benchmark command");
> 
> Isn't this condition off by two?
> 
> I did some testing and the maximum amount of benchmark arguments is 62
> while the array of const char* has 64 spaces. Is it supposed to have
> less than the maximum capacity?
> 
> Wouldn't something like this be more valid with BENCHMARK_ARGS equal to
> 64? :
> 			if (argc - optind > BENCHMARK_ARGS)

Certainly not off by two as the array must be NULL terminated but it seems 
to be off-by-one (to the safe direction), yes.

-- 
 i.

--8323329-1582552241-1693314274=:1757--
