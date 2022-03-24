Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246474E6290
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Mar 2022 12:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiCXLkY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Mar 2022 07:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiCXLkX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Mar 2022 07:40:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E8950E1B;
        Thu, 24 Mar 2022 04:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648121931; x=1679657931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3tsCmgC6U00CO6K3RhtJOUWh8jRiqevIzhkyWbUV+Po=;
  b=Iq4EqoTdcfznxYQziJL9j8T77wZRQyDp295S+4wt4xxPTPY25oOgF5+p
   c3GPeLryvmpfxULCZfeSRHImz2UZI8U2qq2r80IjeB0suLjBRCFNsmevp
   Z/tOPZb5v7ed83pjKcSr3iBFB20YFBJ+IYZ2j0jVI2Ky69rr799jkOwKE
   MHFWyHFy6qlWYARGXXm1cGBtTFald8lh+ZdD3rgsUrx6lwhalcVejLbOl
   Hhuwq8GqAMHPnJ5pM4udzHHweG93Afgr1WaijGWHsR4w8+txKtWJY9ar+
   Zfv8oo+87/THZrwcweuufidKL9pXzLcWq9X/mx3VUjeO5rhRBkQLmU3Mm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258541675"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="258541675"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 04:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="544607394"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2022 04:38:48 -0700
Date:   Thu, 24 Mar 2022 19:37:13 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Heng Su <heng.su@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v8 1/1] selftests/x86/xstate: Add xstate test cases for
 XSAVE feature
Message-ID: <YjxX6dnTTQD+Rq9C@xpf.sh.intel.com>
References: <cover.1646999762.git.pengfei.xu@intel.com>
 <4268a0203fd6e42a31bde3254ee50dd93fd233ea.1646999762.git.pengfei.xu@intel.com>
 <eb0c4940-569b-656f-424c-4248929cc74c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb0c4940-569b-656f-424c-4248929cc74c@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-03-24 at 03:06:50 -0700, Chang S. Bae wrote:
> On 3/16/2022 5:40 AM, Pengfei Xu wrote:
> > 
> > +static inline void check_cpuid_xsave_availability(void)
> > +{
> > +	uint32_t eax, ebx, ecx, edx;
> > +
> > +	/*
> > +	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
> > +	 * support for the XSAVE feature set, including
> > +	 * XGETBV.
> > +	 */
> > +	__cpuid_count(1, 0, eax, ebx, ecx, edx);
> > +	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
> > +		fatal_error("cpuid: no CPU xsave support");
> > +	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
> > +		fatal_error("cpuid: no OS xsave support");
> 
> We need to skip the test when XSAVE is not available. See the point here:
> https://lore.kernel.org/lkml/8735j8aa9g.ffs@tglx/
> 
  Yes, it's better, will skip and exit if CPU doesn't support XSAVE or OS
  XSAVE.
  Thanks for suggestion!

  BR.
  -- Pengfei

> Thanks,
> Chang
> 
> 
