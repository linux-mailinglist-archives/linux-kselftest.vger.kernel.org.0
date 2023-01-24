Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C148E678E41
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 03:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjAXCbi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 21:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAXCbh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 21:31:37 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D59EF0;
        Mon, 23 Jan 2023 18:31:32 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 2FDF282EF0;
        Tue, 24 Jan 2023 02:31:25 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674527492;
        bh=IW8oyeE4wu7owMW/4DM/ie2HFK4Drs3s2h6ZsTjIYy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AE1p2m2+ZBx54M+Ncmx4HVGgVeCo9bIR+b/BZXnehiQrGCthkOydJj2Ocu8KuZbGj
         ReXquTvKq5ECYdEGHqpyQM53W3kvSszOgdT7XGz5UDIKSKCjPlqNycXzMmQ4RpGiXp
         ab9/+neJJFX8dz9thbgW5EDgSKkfZHEMK3TDYdUFEu6qGw2WG+NQ5O62GuoqPriHVX
         ucWMlRpmqZA9x8kQUWKjsguEF4oZrpdMEltNBGW/7hCurZiky9M0fTxf4VpyCwKoK2
         432ZOM/DjbQnIxVuuKbocvlw+6qTUqlD8A0cs028vx6DpR6O8omPTTB+/sUuz+qbL6
         263dXJA7ZxU1Q==
Date:   Tue, 24 Jan 2023 09:31:22 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86 Mailing List <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/2] selftests/x86: sysret_rip: Handle syscall in
 a FRED system
Message-ID: <Y89C+h4Fz4tvjbx5@biznet-home.integral.gnuweeb.org>
References: <SA1PR11MB673498933098295BFC7C2900A8CB9@SA1PR11MB6734.namprd11.prod.outlook.com>
 <b6e36a5c-6f5e-eda6-54ad-a0c20eb00402@intel.com>
 <25b96960-a07e-a952-5c23-786b55054126@zytor.com>
 <fb1cab9f-a373-38e6-92e6-456332010653@gnuweeb.org>
 <F554C5FE-5074-410A-B0B5-EFE983D57946@zytor.com>
 <Y88bhrDoPw5tOyKu@biznet-home.integral.gnuweeb.org>
 <509443c8-e0fd-935f-63d8-7264f5dd3c05@zytor.com>
 <20230124002625.581323-1-ammarfaizi2@gnuweeb.org>
 <20230124002625.581323-2-ammarfaizi2@gnuweeb.org>
 <8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f5c24df-514d-5d89-f58f-ec8c3eb1e049@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 05:40:23PM -0800, H. Peter Anvin wrote:
> On 1/23/23 16:26, Ammar Faizi wrote:
> > +
> > +static long do_syscall(long nr_syscall, unsigned long arg1, unsigned long arg2,
> > +		       unsigned long arg3, unsigned long arg4,
> > +		       unsigned long arg5, unsigned long arg6)
> > +{
> > +	register unsigned long r11 asm("%r11");
> > +	register unsigned long r10 asm("%r10");
> > +	register unsigned long r8 asm("%r8");
> > +	register unsigned long r9 asm("%r9");
> > +	unsigned long rcx, rbx;
> > +
> > +	r11 = r11_sentinel;
> > +	rcx = rcx_sentinel;
> > +	r10 = arg4;
> > +	r8 = arg5;
> > +	r9 = arg6;
> > +
> > +	asm volatile (
> > +		"movq	-8(%%rsp), %%r12\n\t"	/* Don't clobber redzone. */
> > +		"pushq	%[rflags_sentinel]\n\t"
> > +		"popf\n\t"
> > +		"movq	%%r12, -8(%%rsp)\n\t"
> > +		"leaq	1f(%%rip), %[rbx]\n\t"
> > +		"syscall\n"
> > +		"1:"
> > +
> > +		: "+a" (nr_syscall),
> > +		  "+r" (r11),
> > +		  "+c" (rcx),
> > +		  [rbx] "=b" (rbx)
> > +
> > +		: [rflags_sentinel] "g" (rflags_sentinel),
> > +		  "D" (arg1),	/* %rdi */
> > +		  "S" (arg2),	/* %rsi */
> > +		  "d" (arg3),	/* %rdx */
> > +		  "r" (r10),
> > +		  "r" (r8),
> > +		  "r" (r9)
> > +
> > +		: "r12", "memory"
> > +	);
> > +
> > +	/*
> > +	 * Test that:
> > +	 *
> > +	 * - "syscall" in a FRED system doesn't clobber %rcx and %r11.
> > +	 * - "syscall" in a non-FRED system sets %rcx=%rip and %r11=%rflags.
> > +	 *
> > +	 */
> > +	assert(check_regs_result(r11, rcx, rbx) != REGS_ERROR);
> > +	return nr_syscall;
> > +}
> > +
> 
> So as per Andrew's comment, add:
> 
> register void * rsp asm("%rsp");
> 
> ...
> 
> "+r" (rsp)	/* clobber the redzone */
> 
> ... as the right way to avoid redzone problems.

Fixed in v2.

-- 
Ammar Faizi

