Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB640246D14
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Aug 2020 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgHQQo2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Aug 2020 12:44:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:9535 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388942AbgHQQml (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Aug 2020 12:42:41 -0400
IronPort-SDR: G/mvlPr0YEVJMQSW3lC7tu1tUoPN1z4awacrZokwdT+LhPPi0DYgTa4+1fZODSbg1nibE2rWBV
 m8YYYuZ4fcdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="155837544"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="155837544"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:42:39 -0700
IronPort-SDR: ltuQkmVJs+n7F9YPld+E7pKAdJGKal06TEtUMPoSF5+9iDdqVHPFsO0n0Dt4w+BXDRZG+Z4GWP
 707tjQZCV7gg==
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="440922800"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:42:39 -0700
Date:   Mon, 17 Aug 2020 09:42:38 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        peterx@redhat.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: kvm: Fix an unexpected failure with newer gcc
 compiler
Message-ID: <20200817164238.GD22407@linux.intel.com>
References: <20200814132105.5122-1-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814132105.5122-1-weijiang.yang@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 14, 2020 at 09:21:05PM +0800, Yang Weijiang wrote:
> If debug_regs.c is built with newer gcc, e.g., 8.3.1 on my side, then the generated
> binary looks like over-optimized by gcc:
> 
> asm volatile("ss_start: "
>              "xor %%rax,%%rax\n\t"
>              "cpuid\n\t"
>              "movl $0x1a0,%%ecx\n\t"
>              "rdmsr\n\t"
>              : : : "rax", "ecx");
> 
> is translated to :
> 
>   000000000040194e <ss_start>:
>   40194e:       31 c0                   xor    %eax,%eax     <----- rax->eax?
>   401950:       0f a2                   cpuid
>   401952:       b9 a0 01 00 00          mov    $0x1a0,%ecx
>   401957:       0f 32                   rdmsr
> 
> As you can see rax is replaced with eax in taret binary code.

It's an optimization.  `xor rax, rax` and `xor eax, eax` yield the exact
same result, as writing the lower 32 bits of a GPR in 64-bit mode clears
the upper 32 bits.  Using the eax variant avoids the REX prefix and saves
a byte of code.

> But if I replace %%rax with %%r8 or any GPR from r8~15, then I get below
> expected binary:
> 
> 0000000000401950 <ss_start>:
>   401950:       45 31 ff                xor    %r15d,%r15d

This is not replacing %rax with %r15, it's replacing it with %r15d, which
is the equivalent of %eax.  But that's beside the point.  Encoding GPRs
r8-r15 requires a REX prefix, so even though you avoid REX.W you still need
REX.R, and thus end up with a 3 byte instruction.

>   401953:       0f a2                   cpuid

Note, CPUID consumes EAX.  It doesn't look like the code actually consumes
the CPUID output, but switching to r15 is at best bizarre.

>   401955:       b9 a0 01 00 00          mov    $0x1a0,%ecx
>   40195a:       0f 32                   rdmsr
> 
> The difference is the length of xor instruction(2 Byte vs 3 Byte),
> so this makes below hard-coded instruction length cannot pass runtime check:
> 
>         /* Instruction lengths starting at ss_start */
>         int ss_size[4] = {
>                 3,              /* xor */   <-------- 2 or 3?
>                 2,              /* cpuid */
>                 5,              /* mov */
>                 2,              /* rdmsr */
>         };
> Note:
> Use 8.2.1 or older gcc, it generates expected 3 bytes xor target code.
> 
> I use the default Makefile to build the binaries, and I cannot figure out why this
> happens, so it comes this patch, maybe you have better solution to resolve the
> issue. If you know how things work in this way, please let me know, thanks!

Use `xor %%eax, %%eax`.  That should always generate a 2 byte instruction.
Encoding a 64-bit operation would technically be legal, but I doubt any
compiler would do that in practice.
