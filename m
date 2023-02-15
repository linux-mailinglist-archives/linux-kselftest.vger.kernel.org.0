Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDC2697A1B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 11:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjBOKmj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 05:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjBOKmh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 05:42:37 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A8937558;
        Wed, 15 Feb 2023 02:42:36 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.183.231])
        by gnuweeb.org (Postfix) with ESMTPSA id E76A3830B9;
        Wed, 15 Feb 2023 10:42:29 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1676457755;
        bh=ca8bG178e59OpF+OaCvDlTsF5YL0MZS6S+rlzEPMn2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEjg7p1UjNTruASToVkm4BEwv4AYXpbV0jzlkk7YFvFzp0+X5eUoaaIGHl+37vPPX
         LULM0ZhrFeUw0XUkij76j9H6gX5feTTsOBxphpEFnaSnCF7gc4cwCp82xzVmTWY/1L
         Azif9KP6MJE2+FL6yIkja+naVQhrIHzI1h3WPp9dgsMuvoVUCBRuwxTaoV/A1uxKbZ
         g/edxRFtsP0QDG4Fzx1U6OPnQs+eBdHHqZx21mtf2NTstE77tMPKs/BIT3ylo7raaU
         zMviz9AuJ73pw7+f3qm+zBCwg3zsNldZLY5m5wSq1Q7cUOVwej/dFeujevlxQ4jRQY
         I7PhLnLdBNDew==
Date:   Wed, 15 Feb 2023 17:42:25 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Xin Li <xin3.li@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/2] selftests/x86: sysret_rip: Handle syscall in
 a FRED system
Message-ID: <Y+y3EabhG5p3b8iZ@biznet-home.integral.gnuweeb.org>
References: <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com>
 <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org>
 <509443c8-e0fd-935f-63d8-7264f5dd3c05@zytor.com>
 <20230124002625.581323-1-ammarfaizi2@gnuweeb.org>
 <20230124002625.581323-2-ammarfaizi2@gnuweeb.org>
 <8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com>
 <Y9LdwVX9BaZA7zmA@biznet-home.integral.gnuweeb.org>
 <0b57d2ab-14e0-14a0-adf3-3186fd2f5282@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b57d2ab-14e0-14a0-adf3-3186fd2f5282@citrix.com>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 15, 2023 at 09:17:23AM +0000, Andrew Cooper wrote:
> On 26/01/2023 8:08 pm, Ammar Faizi wrote:
> > What did I do wrong?
> 
> Well this is a fine mess...
> 
> https://godbolt.org/z/MaPM7s8qr does the right thing, but is now
> contrary to the prior discussion regarding calls in asm, which concluded
> that the "+r"(rsp) was the way to go.

Does that also mean the ASM_CALL_CONSTRAINT macro in
arch/x86/include/asm/asm.h macro is wrong?

That macro adds a "+r"(rsp) constraint, and we assume it's safe to
execute the "call" instruction with that constraint in an inline
Assembly.

I am not sure what "+r" (rsp) actually does. And if we are now
complaining, "+r" (rsp) doesn't work. Since when it works? Or at least,
where is that rule written?  I couldn't find any GCC or Clang version
that does it right with the "+r" (rsp) constraint (from a quick playing
with that godbolt link).

> Furthermore GCC regressed in 9.0 and emits:
> 
>   warning: listing the stack pointer register 'rsp' in a clobber list is
> deprecated [-Wdeprecated]
> 
> which might be the intention of the developers, but is wrong seeing as
> this is the only way to say "I modify the redzone" to the compiler...

Yeah, adding "rsp" to the clobber list works. But sadly, it's deprecated
in GCC. Not sure what the reason is.

I think the most straightforward and safest way, for now, is: "Don't
clobber the red zone from the inline asm.".

I will use the previous approach to avoid red-zone clobbering in the
next revision. That's by adding "r12" to the clobber list and preserving
the red zone content in "%r12". 

-- 
Ammar Faizi

