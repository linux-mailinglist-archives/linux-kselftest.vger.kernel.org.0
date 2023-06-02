Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B727203BA
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 15:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjFBNvI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 09:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjFBNvI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 09:51:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1934136;
        Fri,  2 Jun 2023 06:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685713866; x=1717249866;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Jou8NJa4PMD3hg2/IZSFNEroRYPh0O3Ceo84qQTSaVo=;
  b=bdmbsZF2nw2fRD+XAb4DPD0ois8FZULIVxmY//HeawS5qomJY9AuN3wh
   xhBRmNkX0fTtPCaSGPL8PPhGvR6DpwQ9HO5kIX3jspJ56CcR8h0Crmyn+
   o32YbXE6aZG3BheNk9SDxDBbQfjwDPBMNIIWJrDrjQjBUri8EzNa9mxRB
   j+6l4xJV3YfCkRwlNUeuo0EWnaWhyy2kES5ncJU0NKlhxP0ym0O5PO3ee
   JyXvBI6TzgVdvAZpbRMxr87a+6huR0+YEUrObVfrixV8G8zEGVAbIlvW/
   kyMwcxe9wrrvfDt2kcpw+LpmKCWXy8C6N8O6RaAmV0CqTXFT2fHbnYNdm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="340498690"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="340498690"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="954508328"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="954508328"
Received: from rspatil-mobl3.gar.corp.intel.com ([10.251.208.112])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 06:51:03 -0700
Date:   Fri, 2 Jun 2023 16:51:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order
 to defeat prefetch optimizations
In-Reply-To: <TYAPR01MB6330025B5E6537F94DA49ACB8B499@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Message-ID: <6d9933e7-63a4-dcb0-9128-12bcf77bb725@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com> <20230418114506.46788-22-ilpo.jarvinen@linux.intel.com> <OSZPR01MB6328F2713E40CC7D383035A48B489@OSZPR01MB6328.jpnprd01.prod.outlook.com> <c21fb16d-d3ad-bbcb-daed-28f153b64525@linux.intel.com>
 <TYAPR01MB6330025B5E6537F94DA49ACB8B499@TYAPR01MB6330.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1056856236-1685608788=:2050"
Content-ID: <de12fff4-bf18-6158-4b48-bcef256c804d@linux.intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1056856236-1685608788=:2050
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <7e3d44f9-f469-a266-3c4e-5881ec25e4ca@linux.intel.com>

On Thu, 1 Jun 2023, Shaopeng Tan (Fujitsu) wrote:
>
> > > > When reading memory in order, HW prefetching optimizations will
> > > > interfere with measuring how caches and memory are being accessed.
> > > > This adds noise into the results.
> > > >
> > > > Change the fill_buf reading loop to not use an obvious in-order
> > > > access using multiply by a prime and modulo.
> > > >
> > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > ---
> > > >  tools/testing/selftests/resctrl/fill_buf.c | 17 ++++++++++-------
> > > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/resctrl/fill_buf.c
> > > > b/tools/testing/selftests/resctrl/fill_buf.c
> > > > index 7e0d3a1ea555..049a520498a9 100644
> > > > --- a/tools/testing/selftests/resctrl/fill_buf.c
> > > > +++ b/tools/testing/selftests/resctrl/fill_buf.c
> > > > @@ -88,14 +88,17 @@ static void *malloc_and_init_memory(size_t s)
> > > >
> > > >  static int fill_one_span_read(unsigned char *start_ptr, unsigned
> > > > char
> > > > *end_ptr)  {
> > > > -	unsigned char sum, *p;
> > > > -
> > > > +	unsigned int size = (end_ptr - start_ptr) / (CL_SIZE / 2);
> > > > +	unsigned int count = size;
> > > > +	unsigned char sum;
> > > > +
> > > > +	/*
> > > > +	 * Read the buffer in an order that is unexpected by HW prefetching
> > > > +	 * optimizations to prevent them interfering with the caching pattern.
> > > > +	 */
> > > >  	sum = 0;
> > > > -	p = start_ptr;
> > > > -	while (p < end_ptr) {
> > > > -		sum += *p;
> > > > -		p += (CL_SIZE / 2);
> > > > -	}
> > > > +	while (count--)
> > > > +		sum += start_ptr[((count * 59) % size) * CL_SIZE / 2];
> > >
> > > Could you please elaborate why 59 is used?
> > 
> > The main reason is that it's a prime number ensuring the whole buffer gets read.
> > I picked something that doesn't make it to wrap on almost every iteration.
> 
> Thanks for your explanation. It seems there is no problem.
> 
> Perhaps you have already tested this patch in your environment and got a 
> test result of "ok".  

Yes, it was tested :-) and all looked fine here. But my testing was more 
focused on the systems which come with CAT and on all those, this change 
clearly improved MBA/MBM results (they became almost always diff=0 except 
for the smallest ones in the MBA test).

> Because HW prefetching does not work well,
> the IMC counter fluctuates a lot in my environment,
> and the test result is "not ok". 
>
> In order to ensure this test set runs in any environments and gets "ok",
> would you consider changing the value of MAX_DIFF_PERCENT of each test?
> or changing something else?
>
> ```
> Environment:
>  Kernel: 6.4.0-rc2
>  CPU: Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz
> 
> Test result(MBM as an example):
> # # Starting MBM BW change ...
> # # Mounting resctrl to "/sys/fs/resctrl"
> # # Benchmark PID: 8671
> # # Writing benchmark parameters to resctrl FS
> # # Write schema "MB:0=100" to resctrl FS
> # # Checking for pass/fail
> # # Fail: Check MBM diff within 5%
> # # avg_diff_per: 9%
> # # Span in bytes: 262144000
> # # avg_bw_imc: 6202
> # # avg_bw_resc: 5585
> # not ok 1 MBM: bw change

Oh, I see. It seems that these CPUs break the trend and get much worse 
and more unstable for some reason. It might be that some i9 I recently 
got a lkp report from could have the same problem. I'll look more into 
this, thanks a lot for testing and bringing it up.

So to answer your question above, I've no intention to tweak 
MAX_DIFF_PERCENT because of this issue but I'll instead try to improve the 
approach to defeat the HW prefetcher.

If HW prefetcher is not defeated, the CAT test LLC misses have a slowly 
converging ramp which is not very useful unless number of runs is 
increased by much (and perhaps the first samples dropped entirely). So
it is kinda needed and it would be nice if an approach that is non-HW 
specific could be used for this.

It will probably take some time... Should I send a v3 with only the fixes 
and useful refactors at the head of this series while I try to sort these 
problems with the test changes out?


-- 
 i.
--8323329-1056856236-1685608788=:2050--
