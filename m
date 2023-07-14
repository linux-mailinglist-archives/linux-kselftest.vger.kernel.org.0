Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C190753842
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 12:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjGNKfa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjGNKf3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 06:35:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727F7A2;
        Fri, 14 Jul 2023 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689330928; x=1720866928;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ii4cvoqnoqZ+3sJH7xharBOhi935BhebVSR23hdE2OM=;
  b=h+IjKrcDFlwsLVaHyH626qdBADnjTdArmbaXG8fE1kXsZyznUcV1veu5
   MmrTmMzhHnBEyhwFN+KoYYFf3tCty8D0dnHE/ZnBz3pdRplRaOhF7gkr7
   YXBUV2dSmT8Hai0sJ/w5aYtuW53ZmhHI9f7kll0N2kqr+NhECyCWXnzKQ
   F2Gm9s5e4KeATUhsqBIyan8Z8my94TRItqNyWOeqFRjIwMdnc4EXBfL9N
   nlAcoZNvtKKdeFMV2xAWszwdnGsH7LDJPHYz3STyiRueGrFkKJCsBYDCM
   eKH1WnfDNKvdjKKCTsyKpYkHAeXJW8tSacTp6xCjVuEWbBx+NnG8kCTDD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431615806"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="431615806"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="812381155"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="812381155"
Received: from rchauhax-mobl1.gar.corp.intel.com ([10.249.35.123])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:35:25 -0700
Date:   Fri, 14 Jul 2023 13:35:22 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/19] selftests/resctrl: Close perf value read fd on
 errors
In-Reply-To: <a4fa6303-4637-815a-e0fa-57f33babfb10@intel.com>
Message-ID: <c14286ec-807c-8613-a4cc-d8ac733a87a1@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com> <20230713131932.133258-5-ilpo.jarvinen@linux.intel.com> <a4fa6303-4637-815a-e0fa-57f33babfb10@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-782494842-1689327854=:1695"
Content-ID: <a04ebfa5-62bf-328d-457c-43abfcbef33a@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-782494842-1689327854=:1695
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <42226133-5e22-b1fa-fb3-7cc2ac9b62@linux.intel.com>

On Thu, 13 Jul 2023, Reinette Chatre wrote:

> Hi Ilpo,
> 
> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> > Perf event fd (fd_lm) is not closed on some error paths.
> > 
> > Always close fd_lm in get_llc_perf() and add close into an error
> > handling block in cat_val().
> > 
> > Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  tools/testing/selftests/resctrl/cache.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> > index 8a4fe8693be6..ced47b445d1e 100644
> > --- a/tools/testing/selftests/resctrl/cache.c
> > +++ b/tools/testing/selftests/resctrl/cache.c
> > @@ -87,21 +87,20 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
> >  static int get_llc_perf(unsigned long *llc_perf_miss)
> >  {
> >  	__u64 total_misses;
> > +	int ret;
> >  
> >  	/* Stop counters after one span to get miss rate */
> >  
> >  	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
> >  
> > -	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
> > +	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
> > +	close(fd_lm);
> > +	if (ret == -1) {
> >  		perror("Could not get llc misses through perf");
> > -
> >  		return -1;
> >  	}
> >  
> >  	total_misses = rf_cqm.values[0].value;
> > -
> > -	close(fd_lm);
> > -
> >  	*llc_perf_miss = total_misses;
> >  
> >  	return 0;
> > @@ -253,6 +252,7 @@ int cat_val(struct resctrl_val_param *param)
> >  					 memflush, operation, resctrl_val)) {
> >  				fprintf(stderr, "Error-running fill buffer\n");
> >  				ret = -1;
> > +				close(fd_lm);
> >  				break;
> >  			}
> >  
> 
> Instead of fixing these existing patterns I think it would make the code
> easier to understand and maintain if it is made symmetrical.
> Having the perf event fd opened in one place but its close()
> scattered elsewhere has the potential for confusion and making later
> mistakes easy to miss.
> 
> What if perf event fd is closed in a new "disable_llc_perf()" that
> is matched with "reset_enable_llc_perf()" and called
> from cat_val()?
> 
> I think this raises another issue with the test trickery where
> measure_cache_vals() has some assumptions about state based on the
> test name.

I very much agree on the principle here, and thus I already have created 
patches which will do a major cleanup on this area. The cleaned-up code 
has pe_fd local var to cat_val() and handles closing it in cat_val() with 
the usual patterns.

However, the patch is currently resides post L3 CAT test rewrite. 
Backporting the cleanups/refactors into this series would require 
considerable effort due to how convoluted all those n-step cleanup patches 
and L3 CAT test rewrite are in this area. There's just very much to 
cleanup here and L3 rewrite will touch the same areas so its a net 
full of conflicts.

Do you want me to spend the effort to backport them into this series 
(I expect will take some time)?

I currently have these items pending besides this series (in order):
- L3 CAT test rewrite and its preparatory patches
- More cleanups (including the pe_fd cleanup)
- New generalized test framework
- L2 CAT test

-- 
 i.
--8323329-782494842-1689327854=:1695--
