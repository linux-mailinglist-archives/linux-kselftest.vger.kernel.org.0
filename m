Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F380433885
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 16:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhJSOlb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 10:41:31 -0400
Received: from foss.arm.com ([217.140.110.172]:49976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhJSOla (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 10:41:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA49C2F;
        Tue, 19 Oct 2021 07:39:17 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43D0A3F70D;
        Tue, 19 Oct 2021 07:39:16 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:39:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 04/42] arm64/sve: Make access to FFR optional
Message-ID: <20211019135853.GA4938@lakrids.cambridge.arm.com>
References: <20211018190858.2119209-1-broonie@kernel.org>
 <20211018190858.2119209-5-broonie@kernel.org>
 <20211019101447.GA13251@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019101447.GA13251@willie-the-truck>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 19, 2021 at 11:14:47AM +0100, Will Deacon wrote:
> On Mon, Oct 18, 2021 at 08:08:20PM +0100, Mark Brown wrote:
> >  SYM_FUNC_START(sve_flush_live)
> > -	cbz		x0, 1f	// A VQ-1 of 0 is 128 bits so no extra Z state
> > +	cbz		x1, 1f	// A VQ-1 of 0 is 128 bits so no extra Z state
> >  	sve_flush_z
> > -1:	sve_flush_p_ffr
> > +1:	cbz		x0, 2f
> > +	sve_flush_p
> > +2:	sve_flush_ffr
> >  	ret

> > @@ -962,7 +962,7 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
> >  		unsigned long vq_minus_one =
> >  			sve_vq_from_vl(current->thread.sve_vl) - 1;
> >  		sve_set_vq(vq_minus_one);
> > -		sve_flush_live(vq_minus_one);
> > +		sve_flush_live(true, vq_minus_one);
> 
> What does the pcs say about passing bools in registers? Can we guarantee
> that false is a 64-bit zero?

Per usual rules, bits [63:8] can be arbitrary -- AAPCS64 leaves it to the callee
to extend values, with the upper bits being arbitrary, and it maps _Bool/bool
to unsigned char, which covers bits [7:0].

So a bool false in a register is not guaranteed to be a 64-bit zero. But
since it *is* guarnateed to be either 0 or 1, we can use TBZ/TBNZ
instead of CBZ/CBNZ. Either that, or extend it to a wider type in the
function prototype.

The test below shows clang and GCC both agree with that (though this old
GCC seems to do unnecessary zero extension as a caller):

| [mark@gravadlaks:~]% cat bool.c       
| #include <stdbool.h>
| 
| void callee_bool(bool b);
| 
| void callee_unsigned_int(unsigned int i);
| 
| void caller_unsigned_long(unsigned long l)
| {
|         unsigned long tmp = l & 0xffffffff;
| 
|         if (tmp)
|                 callee_unsigned_int(tmp);
|         else
|                 callee_bool(tmp);
| }
| 
| unsigned long bool_to_unsigned_long(bool b)
| {
|         return b;
| }
| [mark@gravadlaks:~]% gcc --version    
| gcc (Debian 8.3.0-6) 8.3.0
| Copyright (C) 2018 Free Software Foundation, Inc.
| This is free software; see the source for copying conditions.  There is NO
| warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
| 
| [mark@gravadlaks:~]% gcc -c bool.c -O3
| [mark@gravadlaks:~]% objdump -d bool.o
| 
| bool.o:     file format elf64-littleaarch64
| 
| 
| Disassembly of section .text:
| 
| 0000000000000000 <caller_unsigned_long>:
|    0:   34000040        cbz     w0, 8 <caller_unsigned_long+0x8>
|    4:   14000000        b       0 <callee_unsigned_int>
|    8:   52800000        mov     w0, #0x0                        // #0
|    c:   14000000        b       0 <callee_bool>
| 
| 0000000000000010 <bool_to_unsigned_long>:
|   10:   92401c00        and     x0, x0, #0xff
|   14:   d65f03c0        ret
| [mark@gravadlaks:~]% clang --version    
| clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
| Target: aarch64-unknown-linux-gnu
| Thread model: posix
| InstalledDir: /usr/bin
| [mark@gravadlaks:~]% clang -c bool.c -O3
| [mark@gravadlaks:~]% objdump -d bool.o  
| 
| bool.o:     file format elf64-littleaarch64
| 
| 
| Disassembly of section .text:
| 
| 0000000000000000 <caller_unsigned_long>:
|    0:   34000040        cbz     w0, 8 <caller_unsigned_long+0x8>
|    4:   14000000        b       0 <callee_unsigned_int>
|    8:   14000000        b       0 <callee_bool>
| 
| 000000000000000c <bool_to_unsigned_long>:
|    c:   92400000        and     x0, x0, #0x1
|   10:   d65f03c0        ret

Thanks,
Mark.
