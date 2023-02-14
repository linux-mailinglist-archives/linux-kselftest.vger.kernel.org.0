Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA11C695F42
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 10:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjBNJc4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 04:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjBNJcx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 04:32:53 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F51BC7;
        Tue, 14 Feb 2023 01:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676367170; x=1707903170;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Onlcy7QQO80yii92ZJvABavj0SZQtjlUtLPVlgLzcCY=;
  b=RvY/fY97JPy4gXtK/Lg7fWb4hRaxBCnU+05p2bgmRV2d60nwIER/q0Mt
   xtMKUAxy/NGX/GPGl8vIweotbQsD5Xuucv4waAjfCMPTgc+MRCm9QKc5d
   /WKAYobBV0Qa+gUWXSeOyJqn3brdIpgdKSbhlkyurrsvgPBiaixCgqMW0
   N1SQL6pdIO+rINHtiqjlcU67Izk1W63q1m5EdDYyLuKlkjS1F2Vbm53h4
   J5I0sY4f9njWbdW7oHdkIhO24NwDLGd/n+VuNo20WoSuO7lRw3K8lPwMj
   3dTtIXP5uc4XBFm5qqiMfEyTXx5AiqQrmwlILoXRMWrUxP7AeqMchIGEk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="314764095"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="314764095"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 01:32:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="793051410"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="793051410"
Received: from asmit6-mobl2.ger.corp.intel.com ([10.249.37.52])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 01:32:41 -0800
Date:   Tue, 14 Feb 2023 11:32:38 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH 1/4] selftests/resctrl: Return error if memory is not
 allocated
In-Reply-To: <88a819d7-b236-aed5-7cb8-6659e3f9f405@intel.com>
Message-ID: <a4b44d-23f8-6df1-e494-908fbd43b732@linux.intel.com>
References: <20230208093016.20670-1-ilpo.jarvinen@linux.intel.com> <20230208093016.20670-2-ilpo.jarvinen@linux.intel.com> <88a819d7-b236-aed5-7cb8-6659e3f9f405@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2038729652-1676364299=:1771"
Content-ID: <1d6fd8c-35d5-d468-262f-699973de7a7d@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2038729652-1676364299=:1771
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <736451c9-5ee2-695-b468-b08c94eae95@linux.intel.com>

On Mon, 13 Feb 2023, Reinette Chatre wrote:

> I do not see a why two patch series are needed for
> the resctrl fixes. It may make it easier for everybody if
> it is handled as one patch series (with fixes first)?

Ok, I can put the fixes and cleanups into one series.

> On 2/8/2023 1:30 AM, Ilpo Järvinen wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > 
> > malloc_and_init_memory() in fill_buf isn't checking if memalign()
> > successfully allocated memory or not before accessing the memory.
> > 
> > Check the return value of memalign() and return NULL if allocating
> > aligned memory fails.
> > 
> > Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> Missing your Signed-off-by?

These were intentionally. When I didn't modify the original patch at 
all during forward porting it, I just kept the original From and SoB as 
is. But from the doc you pointed me to, I see now x86 wants also handlers 
sobs.

> > ---
> >  tools/testing/selftests/resctrl/fill_buf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> > index 56ccbeae0638..f4880c962ec4 100644
> > --- a/tools/testing/selftests/resctrl/fill_buf.c
> > +++ b/tools/testing/selftests/resctrl/fill_buf.c
> > @@ -68,6 +68,8 @@ static void *malloc_and_init_memory(size_t s)
> >  	size_t s64;
> >  
> >  	void *p = memalign(PAGE_SIZE, s);
> 
> This may also be a good time to stop using an obsolete call?

Sure, I can add another patch to change that to posix_memalign().

> > +	if (!p)
> > +		return p;
> 
> Could you please return NULL explicitly?

I'll change it.

Thanks for you comments.

-- 
 i.
--8323329-2038729652-1676364299=:1771--
