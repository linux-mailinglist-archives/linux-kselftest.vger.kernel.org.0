Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA90F4712AB
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Dec 2021 09:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhLKIBT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Dec 2021 03:01:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:63117 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhLKIBS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Dec 2021 03:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639209678; x=1670745678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nhJa2cx6wlZzdGgObbJGTb+l0F8TzfJR/Xyj6x9syFc=;
  b=bsufjbrB0H6s7jRKHdJ4TjjN9/GpySJo6G7KJ/nhJbjsCBMV56D5biqL
   1+2mA7858D9kFevlBdklNdpFZdxjUDE7yYG+QwgVeUg07vb8yFV9OHMNH
   vtXWjX3zmLP7ILOBlw7td5M+fldHMrOLNgSrOChiTltZd8oVvU5I3G3BQ
   UWAIVJIJGSMRjGIrqDJh4EnE4a4IrQvKLaE+jrIi487s8A6DoeikeA4z0
   Dx+5Hs3sFU6TT/QG3Qfd5mRI1nIAulAqizzI/dX0CK4qt1H3coBqV7Abb
   SAAV37eJv6hk+7oB5htmb8caam3BQ6gGs4wI7goi2bcUphkI6bCQ5+aZ6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="299302524"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="299302524"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 00:01:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="681021371"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga005.jf.intel.com with ESMTP; 11 Dec 2021 00:01:15 -0800
Date:   Sat, 11 Dec 2021 16:02:06 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Heng Su <heng.su@intel.com>, Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH v5 1/2] selftests/x86: add xsave test during and
 after signal handling
Message-ID: <YbRa/hyZIkQ4h3YL@xpf.sh.intel.com>
References: <cover.1638513720.git.pengfei.xu@intel.com>
 <3f02d300118abfb581d85519b733a2db2bb44b10.1638513720.git.pengfei.xu@intel.com>
 <3f59a9d9-27e6-e6b2-98ff-c18924979cc4@intel.com>
 <YbLb4k3KKYD2TE/6@xpf.sh.intel.com>
 <a271fd86-c618-ced1-e848-c0649b003a16@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a271fd86-c618-ced1-e848-c0649b003a16@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 2021-12-10 at 08:48:08 -0800, Dave Hansen wrote:
> On 12/9/21 8:47 PM, Pengfei Xu wrote:
> > How about the following changes:
> > Will remove set_avx2_ymm() and will only check XSAVE_MASK_FP, XSAVE_MASK_OPMASK
> > and XSAVE_MASK_PKRU xstates after signal handling and process switch,
> 
> First and foremost, the whole point of these tests is to ensure that the
> kernel is properly maintaining register state.  Removing registers from
> the test moves *away* from the primary goal of this test.
> 
 Thanks for suggestion!
 Actually, I already removed any useless libc function before and after
 xsave action, only left the test action between xsave action:
"
	XSAVE(xsave_buf2, XSAVE_TEST_MASK);
	do raise signal or fork test
	XSAVE(xsave_buf3, XSAVE_TEST_MASK);
"
  I found that after fork() function in virtual machine, XMM0 or XMM1 register
will be used and changed.
  But in YMM xstate, I haven't see signal handline and fork action will use
and change YMM regiseters in the test. Seems we could keep YMM xstate test.
  Seems it needs some other better way for XMM xstate.

> Second, you just listed three states there.  Have you considered looking
> at whether those have the same problem as the XMM/YMM registers?  Please do.
> 
  I have tested FP, AVX512 opmask and pkru xstates on different platforms and
virtual machine, gdb these 3 xstates with fork and signal handling even printf,
above 3 functions will not use and change above 3 xstates. I used previous
xsave instruction tests to get the results.

> Third (and I've also suggested this before), we should explicitly tell
> the compiler not to use the FPU registers.  This is what the kernel
> does, and it's what allows us to, for instance, make function calls in
> the kernel without clobbering userspace content in XSAVE-managed registers.
> 
> If we did that, then we would only have to worry about calls to things
> *outside* of the test program, like libc.
  Thanks! Yes, I will add "float a = 0.12, b = 0.34; a = a + b;" to tell
libc process, float points has been used.
  Seems if there is no addition, subtraction, multiplication or division,
there is no change in FP xstate compared with no float definition. If there
is above operation, mxcsr(xstate offset 0x18-0x1b bytes)will change from 801f
to a01f. Rounding control bit change from 00 to 01.

Thanks!
BR.
