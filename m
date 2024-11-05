Return-Path: <linux-kselftest+bounces-21449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69AE9BC8EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 10:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800F81F21562
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA51CF2B2;
	Tue,  5 Nov 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfi6RspQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237E1CCB2D;
	Tue,  5 Nov 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798275; cv=none; b=KX0yq17uuyEHQBkEYUcOEqlfl2thwy4Drg5pTVz+ohemrrYqOn/vfzKkXjefctoFptzcwxeOiZIlI+98jnH2+4U0GfdfeLKRSCQypw+yxVGBt5oor6z6p3bQgvlP5Odkt01IschS/NLw7v+5JTLkN/K8cvIW1Awmi6v+HPWzXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798275; c=relaxed/simple;
	bh=PppMPuX1IoJiZXzC2Ga3sdmBITXwwbZAdf5ssbDPqgA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NAsA9IvVglqUsEHHQZkutsrrXKjqy0QUr+GBWzdc+v8c+DERBRvPCYNQQu4+hbuhIYeEM5vUJe/0kLj5aJcTcdAvsUf/aqUsaBQUuYAt8S1urfdF58psbuuFlgL7vsuHDDNu7Zc3rVW3Im1GdXy28792koMaorgvdaJp40UdrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfi6RspQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5951EC4CECF;
	Tue,  5 Nov 2024 09:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730798275;
	bh=PppMPuX1IoJiZXzC2Ga3sdmBITXwwbZAdf5ssbDPqgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hfi6RspQ9yzPHxU4Z8SstdLhGN/rnX6LAJkaiieADqbpMl6HVGczLaaHYh2XBp0ds
	 tu/4r3fnI7rhU1tmk0uxR5mJsIIHka1X/K75aHrbtdonRXnK1Isad4xsKyh2EJAVEI
	 Xl4Y6crMBZ4iHL7OvaDuEOeJU/PoLMOpeHHlVQcRzjrkd9oMhUlL0f+WOLDd2iAEaK
	 hBhglLxLlklDAgShVUy+l6B9308mTp/dT7nN99BOdDeavHnHYlq6UOAK+dNM41nTok
	 L7JiDXnkvSt6UiIFg/D6FbPW/WVSa+hzSJk16dh7ZRdumhjdSs8cPsseIWBDyFKVIN
	 IFyBATBHX2IpA==
Date: Tue, 5 Nov 2024 18:17:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Naveen N. Rao" <naveen@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] selftests/ftrace: update kprobe syntax error test for
 ppc64le
Message-Id: <20241105181752.74a3d6fa2f06d0adfdf85322@kernel.org>
In-Reply-To: <20241105082018.GA29862@gate.crashing.org>
References: <20241101191925.1550493-1-hbathini@linux.ibm.com>
	<20241101205948.GW29862@gate.crashing.org>
	<1916cb5c-cb3d-427c-bcf0-2c1b905fd6d1@linux.ibm.com>
	<20241104094431.GY29862@gate.crashing.org>
	<245fed6f-5fb4-4925-ba0a-fb2f32e650d0@linux.ibm.com>
	<20241104103615.GZ29862@gate.crashing.org>
	<f7e8243a-a4c8-44ce-ad03-7d232df461ed@linux.ibm.com>
	<20241105082018.GA29862@gate.crashing.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 5 Nov 2024 02:20:18 -0600
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> Hi!
> 
> On Mon, Nov 04, 2024 at 11:06:23PM +0530, Hari Bathini wrote:
> > Seems like a bit of misunderstanding there. Function entry here intends
> > to mean the actual start of function code (function prologue) - after
> > GEP and function profiling sequence (mflr r0; bl mcount).
> 
> What you call "function entry" here simply does not exist.  The compiler
> can -- and ***WILL***, ***DOES*** -- mix up all of that.

Here is the "function entry" means the function address.
Not the prologue. On some architecture, we are sure fixed sequences
right after the function address for ftrace/security. For example,
x86 has an `ENDBR` for security. Thus, even if we tend to put a
probe on the "function entry", kprobes shifts the probe point
forcibly skipping the `ENDBR`. So from the probe callback, the
probed address does not look like the function address (shift
the sizeof(ENDBR)).

However, the ENDBR does nothing from the program point of view, we
can still think of that address as the address of the function.
That is the reason why I introduced arch_kprobe_on_func_entry().

For the other architecture, it might be misunderstood and
could be miss-implemented. In that case, we should fix that.

>  In particular,
> "function prologue" does not exist at all (on any architecture worth
> its salt, including PowerPC), and all instructions you consider part of
> a function prologue might end up anywhere.  The "profiling sequence" is
> part of that btw, and that typically ends up *not* the first thing in
> the function, not the first thing after the LEP (register saves are
> earlier often, they are generated in that order in the first place,
> but they can (and will) be moved if that schedules better).
> 
> > Function arguments can be accessed with kprobe only while setting a
> > probe at an address the kernel treats as function start address.
> 
> That is a silly assumption to make.  There is no guarantee you can
> access function arguments *at all*, we're not in 1975 anymore.  You
> *need* to look at debug information if you want to deal with anything
> about your high-level language program.  Looking at the machine code
> can only tell you about the machine state, whatever is in registers
> etc.

Yeah, understood. So the `$arg*` here does not guarantee to access
arguments, but the best effort to do that. And it fully depends on
regs_get_kernel_argument(). Thus `$arg*` works only where the
regs_get_kernel_argument() can return most likely function argument
value from `pt_regs`. That is where we call "function entry" in
this context.

And since it checks the function entry by arch_kprobe_on_func_entry()
this test fails on powerpc because it returns true if the offset from
the kallsyms symbol address is less than 8/16 bytes.


> 
> > Note that the test case pass criteria here is setting probe to fail by
> > providing an address (sym+offset) beyond the function start address.
> > 
> > And in this specific test case (with "vfs_read+8", where vfs_read is
> > the symbol and '8' is the offset), the test case was failing on powerpc
> > because setting the probe at 'sym+8' was succeeding, as anywhere between
> > 'sym' to 'sym+16' is treated as function start address on powerpc:
> 
> Yeah, fragile tests sometimes break.  Changing a randomly chosen number
> to some other randomly chosen number will not fix the problem (but you
> can postpone having to deal with it, sure!)

Yeah, sorry about the test case. Actually `+8` is also not a good number
for x86 too since we are not sure whether the address is an instruction
boundary or not. In that case it may report another error and failed.

Thank you,

> 
> 
> Segher


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

