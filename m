Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB7146FA02
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 05:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhLJEuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Dec 2021 23:50:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:61553 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhLJEuR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Dec 2021 23:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639111602; x=1670647602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pYXkxQBkXerI1IL9jyXU6VvxSJJeLlDg2n1TNUUzekU=;
  b=hDlVJUpSmChgl31f7EeozTyJN7jAii+OnFWnRZJBVHcmFg+/pKwmYI3r
   JC/3CKK3GQ9ZIdohFyhvxYMPzDFPid/7dnwRmGJKE6iBGOIe2QCw8Q1LD
   +JFLG2ZwDPdufEFomYA5kehhz9G+DPyjgkpdI4xA3zUWsATNSYawnK/40
   DeccZ8Kio4DRPSsO/eHM5SonksItWfUU1dIUOqSBKfcCFTGFmJZFTYDRV
   Sq71phNLCgk6VMhovIlTiOpHsie6s1erlUi2mzb4o48lF4p/Had36wWRO
   v6TBX9nawXY6fm2gk1fuPhMCPrBhR7rYq3qGpUtKnvSZA7PUZPfiBnF4A
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238075526"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="238075526"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 20:46:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="516609277"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga008.jf.intel.com with ESMTP; 09 Dec 2021 20:46:39 -0800
Date:   Fri, 10 Dec 2021 12:47:30 +0800
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
Message-ID: <YbLb4k3KKYD2TE/6@xpf.sh.intel.com>
References: <cover.1638513720.git.pengfei.xu@intel.com>
 <3f02d300118abfb581d85519b733a2db2bb44b10.1638513720.git.pengfei.xu@intel.com>
 <3f59a9d9-27e6-e6b2-98ff-c18924979cc4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f59a9d9-27e6-e6b2-98ff-c18924979cc4@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 2021-12-09 at 10:22:42 -0800, Dave Hansen wrote:
> On 12/2/21 11:32 PM, Pengfei Xu wrote:
> > +void populate_xstate_regs(void)
> > +{
> > +	set_fpu_reg();
> > +	set_avx2_ymm();
> > +	set_avx512_opmask();
> > +	set_pkru_xstate();
> > +}
> 
> Pengfei, as I mentioned several times, XMM and YMM registers are not
> preserved across function calls.  This only works by chance.  The
> compiler is free to clobber them at basically any time between when they
> are populated and the XSAVE happens.

Thanks for suggestions!
Sorry, I read the link https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf
I have removed the XMM registers check as XMM registers are not preserved
across function calls in above doc mentioned:
"
Register     | Usage                       | Preserved across function calls
%xmm0–%xmm1  | used to pass and return floating point arguments | No
%xmm2–%xmm7  | used to pass floating point arguments | No
%xmm8–%xmm15 | temporary registers | No
%mmx0–%mmx7  | temporary registers | No
"

It seems that the reason why the contents of the XMM register changed by chance
is:
As printf for example, after "printf" Glibc function:
do_lookup_x is triggered by printf:
"
0x00007ffff7fd5538 in do_lookup_x () from /lib64/ld-linux-x86-64.so.2  ->
   0x00007ffff7fd55d7 <+1367>:  e8 94 7b 01 00  callq  0x7ffff7fed170 <strcmp>
...
   0x00007ffff7fee1af <+4159>:  90      nop
   0x00007ffff7fee1b0 <+4160>:  66 0f ef c0     pxor   %xmm0,%xmm0
   0x00007ffff7fee1b4 <+4164>:  66 0f 6f 17     movdqa (%rdi),%xmm2
=> 0x00007ffff7fee1b8 <+4168>:  66 0f 6f 0e     movdqa (%rsi),%xmm1
   0x00007ffff7fee1bc <+4172>:  66 0f 74 c1     pcmpeqb %xmm1,%xmm0
"  And after printf, xmm1 and xmm2 value was changed.
And seems some other glibc function will use XMM registers also.

YMM will not be preserved across function calls, but I'm not sure whether
some Glibc will use YMM.
I will remove YMM xstates check until there is some other better way for YMM
test or it's confirmed YMM will not be used by Glibc.

I think PKRU and AVX512 opmask will not be affected in the test.
PKRU xstate will not be affected by registers, and Glibc will not use AVX512
instructions.

How about the following changes:
Will remove set_avx2_ymm() and will only check XSAVE_MASK_FP, XSAVE_MASK_OPMASK
and XSAVE_MASK_PKRU xstates after signal handling and process switch,
xstates will be controlled by XSAVE_TEST_MASK:
"
#define XSAVE_TEST_MASK (XSAVE_MASK_FP | XSAVE_MASK_YMM | XSAVE_MASK_OPMASK \
			| XSAVE_MASK_PKRU)
"
will change to
"
#define XSAVE_TEST_MASK (XSAVE_MASK_FP | XSAVE_MASK_OPMASK | XSAVE_MASK_PKRU)
"

FP will be used only by user space, and seems Glibc will not use FP in general.
This is the xstates position for FP, XMM, Header, YMM, AVX512 opmask and PKRU:
It could be saved by xsave instruction, and mask could control which part
will be saved(Header will be saved as mandatory):
FP               (0-159 bytes)
XMM              (160-415 bytes)
Reserved         (416-511 bytes  SDM vol1 13.4.1)
Header_used      (512-527 bytes)
Headed_reserved  (528-575 bytes must 00, otherwise xrstor will #GP)

YMM           (Offset:CPUID.(EAX=0D,ECX=2).EBX  Size:CPUID(EAX=0D,ECX=2).EAX)
AVX512 opmask (Offset:CPUID.(EAX=0D,ECX=5).EBX  Size:CPUID(EAX=0D,ECX=5).EAX)
PKRU          (Offset:CPUID.(EAX=0D,ECX=9).EBX  Size:CPUID(EAX=0D,ECX=9).EAX)


Thanks!
BR.
