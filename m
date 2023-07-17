Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CAE7563CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjGQNHR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjGQNHR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:07:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8C3C7;
        Mon, 17 Jul 2023 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599236; x=1721135236;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gG4+L6/n9BpXjqaZ8By7jM8Mfd9yDo/AWXxOxB0yb9o=;
  b=LOeO3c23gDuc76HVmLC1X49R+JklEE8ml9yoYbqrXLsnM9UZwI5T6O3I
   qSqrO9p1OyvwXv2YNwvNuQ4YMv7IfswzxtO/tiAvuR19Mq/+sKVtM4Kr6
   Lp2UanefEbXQIXLoyfdW92M9QXO9WiiTq7IZXfjGXt+u7+BjcCm1pTNPt
   Oh30P0CWHFPBoCVVSj7BAq+vpfNHdrnVqUSmh7ZYAQd08xKQcL5j9YL2j
   15D0NPDkcIOj4OeUNCc2iw/ehyTgr0a0abmE9txcmKD6+ZbXdqmLttK8l
   VtMg3AkZGgurUln+I+hIoRLJ6S8Nll2484nFQnd7s349qMw6xcqEfDZW0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="396751639"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="396751639"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="847280436"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="847280436"
Received: from dkravtso-mobl1.ccr.corp.intel.com ([10.252.45.233])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:05:50 -0700
Date:   Mon, 17 Jul 2023 16:05:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/19] selftests/resctrl: Close perf value read fd on
 errors
In-Reply-To: <4531fca1-2f3b-0c08-351b-f8e06c5f9f5c@intel.com>
Message-ID: <8b904781-c5d-8164-b8dc-903d412330fd@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com> <20230713131932.133258-5-ilpo.jarvinen@linux.intel.com> <a4fa6303-4637-815a-e0fa-57f33babfb10@intel.com> <c14286ec-807c-8613-a4cc-d8ac733a87a1@linux.intel.com>
 <4531fca1-2f3b-0c08-351b-f8e06c5f9f5c@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1678409849-1689599152=:20605"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1678409849-1689599152=:20605
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 14 Jul 2023, Reinette Chatre wrote:
> On 7/14/2023 3:35 AM, Ilpo Järvinen wrote:
> > On Thu, 13 Jul 2023, Reinette Chatre wrote:
> >> On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> >>> Perf event fd (fd_lm) is not closed on some error paths.
> >>>
> >>> Always close fd_lm in get_llc_perf() and add close into an error
> >>> handling block in cat_val().
> >>>
> >>> Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
> >>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >>> ---
> >>>  tools/testing/selftests/resctrl/cache.c | 10 +++++-----
> >>>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
> >>> index 8a4fe8693be6..ced47b445d1e 100644
> >>> --- a/tools/testing/selftests/resctrl/cache.c
> >>> +++ b/tools/testing/selftests/resctrl/cache.c
> >>> @@ -87,21 +87,20 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
> >>>  static int get_llc_perf(unsigned long *llc_perf_miss)
> >>>  {
> >>>  	__u64 total_misses;
> >>> +	int ret;
> >>>  
> >>>  	/* Stop counters after one span to get miss rate */
> >>>  
> >>>  	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
> >>>  
> >>> -	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
> >>> +	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
> >>> +	close(fd_lm);
> >>> +	if (ret == -1) {
> >>>  		perror("Could not get llc misses through perf");
> >>> -
> >>>  		return -1;
> >>>  	}
> >>>  
> >>>  	total_misses = rf_cqm.values[0].value;
> >>> -
> >>> -	close(fd_lm);
> >>> -
> >>>  	*llc_perf_miss = total_misses;
> >>>  
> >>>  	return 0;
> >>> @@ -253,6 +252,7 @@ int cat_val(struct resctrl_val_param *param)
> >>>  					 memflush, operation, resctrl_val)) {
> >>>  				fprintf(stderr, "Error-running fill buffer\n");
> >>>  				ret = -1;
> >>> +				close(fd_lm);
> >>>  				break;
> >>>  			}
> >>>  
> >>
> >> Instead of fixing these existing patterns I think it would make the code
> >> easier to understand and maintain if it is made symmetrical.
> >> Having the perf event fd opened in one place but its close()
> >> scattered elsewhere has the potential for confusion and making later
> >> mistakes easy to miss.
> >>
> >> What if perf event fd is closed in a new "disable_llc_perf()" that
> >> is matched with "reset_enable_llc_perf()" and called
> >> from cat_val()?
> >>
> >> I think this raises another issue with the test trickery where
> >> measure_cache_vals() has some assumptions about state based on the
> >> test name.
> > 
> > I very much agree on the principle here, and thus I already have created 
> > patches which will do a major cleanup on this area. The cleaned-up code 
> > has pe_fd local var to cat_val() and handles closing it in cat_val() with 
> > the usual patterns.
> > 
> > However, the patch is currently resides post L3 CAT test rewrite. 
> > Backporting the cleanups/refactors into this series would require 
> > considerable effort due to how convoluted all those n-step cleanup patches 
> > and L3 CAT test rewrite are in this area. There's just very much to 
> > cleanup here and L3 rewrite will touch the same areas so its a net 
> > full of conflicts.
> > 
> > Do you want me to spend the effort to backport them into this series 
> > (I expect will take some time)?
> 
> Considering the "Fixes" tag, having a smaller fix that can easily
> be backported would be ideal so I am ok with deferring a bigger
> rework.
> 
> I do think this fix can be made more robust with a couple of small
> changes that should not introduce significant conflicts:
> * initialize fd_lm to -1 

> * do not close() fd_lm in get_llc_perf() but instead move its
>   close() to at exit of cat_val().

I changed the test to only close the fd in cat_val() which is the 
direction the later refactor/cleanup changes (not in this series) was 
moving anyway.

> * add check in get_llc_perf() that it does not attempt ioctl()
>   on "fd_lm == -1" (later addition would be error checking of
>   the ioctl())

The other two things suggested seem unnecessary and I've not implemented 
them, I don't thinkg fd_lm can be -1 at ioctl(). Given this code is going 
to be replaced soonish, putting any extra "safety" effort into it now 
seems waste of time.

-- 
 i.
--8323329-1678409849-1689599152=:20605--
