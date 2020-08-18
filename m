Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCB52485E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Aug 2020 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHRNR7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Aug 2020 09:17:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:25225 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgHRNR6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Aug 2020 09:17:58 -0400
IronPort-SDR: uHYqtMT/M54AWW3BlBdHudQ2bJfUXkwXJqXao1hiF/ZWyWdwh5sV9dB8oouSfV6GHWcVmJpZ8t
 oBje9+COTsgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="155976632"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="155976632"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 06:17:48 -0700
IronPort-SDR: uFtynHMcWZI6xURtD/H07dODdvGvzmqr+/TXJuel2NcLbuEW6vESpjCzFGXlEtgS+ppjkQop7l
 e3uQW/TWUsgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="296839664"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2020 06:17:46 -0700
Date:   Tue, 18 Aug 2020 21:25:26 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        shuah@kernel.org, peterx@redhat.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: kvm: Fix an unexpected failure with newer gcc
 compiler
Message-ID: <20200818132525.GA14830@local-michael-cet-test.sh.intel.com>
References: <20200814132105.5122-1-weijiang.yang@intel.com>
 <20200817164238.GD22407@linux.intel.com>
 <7ad0f9fa-bb57-4c19-475b-3439d7a61bcd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad0f9fa-bb57-4c19-475b-3439d7a61bcd@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 17, 2020 at 07:19:17PM +0200, Paolo Bonzini wrote:
> On 17/08/20 18:42, Sean Christopherson wrote:
> > On Fri, Aug 14, 2020 at 09:21:05PM +0800, Yang Weijiang wrote:
> >> If debug_regs.c is built with newer gcc, e.g., 8.3.1 on my side, then the generated
> >> binary looks like over-optimized by gcc:
> >>
> >> asm volatile("ss_start: "
> >>              "xor %%rax,%%rax\n\t"
> >>              "cpuid\n\t"
> >>              "movl $0x1a0,%%ecx\n\t"
> >>              "rdmsr\n\t"
> >>              : : : "rax", "ecx");
> >>
> >> is translated to :
> >>
> >>   000000000040194e <ss_start>:
> >>   40194e:       31 c0                   xor    %eax,%eax     <----- rax->eax?
> >>   401950:       0f a2                   cpuid
> >>   401952:       b9 a0 01 00 00          mov    $0x1a0,%ecx
> >>   401957:       0f 32                   rdmsr
> >>
> >> As you can see rax is replaced with eax in taret binary code.
> > 
> > It's an optimization.  `xor rax, rax` and `xor eax, eax` yield the exact
> > same result, as writing the lower 32 bits of a GPR in 64-bit mode clears
> > the upper 32 bits.  Using the eax variant avoids the REX prefix and saves
> > a byte of code.
> 
> I would have expected that from binutils though, not GCC.
> 
> > Use `xor %%eax, %%eax`.  That should always generate a 2 byte instruction.
> > Encoding a 64-bit operation would technically be legal, but I doubt any
> > compiler would do that in practice.
> 
> Indeed, and in addition the clobbers are incorrect since they miss rbx
> and rdx.  I've sent a patch.
>
Thanks Paolo and Sean for the feedback!

> Paolo
