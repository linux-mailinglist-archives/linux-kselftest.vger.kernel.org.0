Return-Path: <linux-kselftest+bounces-21469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58899BD632
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740F7283B5C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 19:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530D621315C;
	Tue,  5 Nov 2024 19:54:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF818212EF8;
	Tue,  5 Nov 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730836489; cv=none; b=C34SfQT1/QIg5ZqTlk+O55iLPykG97C7vATjhHWpA7qw6pZTVlmSK82rGNk7JNOxUWjDKAVXAkiqNAzxl+4QKToKQEqYFIz+GEa5MDkDeSWx/Yti/4KLzDmgvoHKrzXcAPglMLzBYRl/yfcxO/AEqoDnGuXKS1HZudu9ni0auQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730836489; c=relaxed/simple;
	bh=VeYfp2hmYu+Muh1vIFhI12FMxTSkf/bdGLtpCElCHTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnicxcbKQNjp0vJvZC/vVI35EgcwQiSr3502rw8cSj3/KvyfCN2/PSzWCskixhEoJaqcFUyi1GAQht9B+Viz8nTv7ot58gYYd+odYB/zFWJCNKhL98l5vSGwcBRlSWQSyyE2vmNF9oadLYYHLt2qr3VNvRYl6kARl7gLHWuNX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4A5Jq94A022745;
	Tue, 5 Nov 2024 13:52:09 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4A5Jq8Ge022742;
	Tue, 5 Nov 2024 13:52:08 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 5 Nov 2024 13:52:08 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Naveen N. Rao" <naveen@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] selftests/ftrace: update kprobe syntax error test for ppc64le
Message-ID: <20241105195208.GC29862@gate.crashing.org>
References: <20241101191925.1550493-1-hbathini@linux.ibm.com> <20241101205948.GW29862@gate.crashing.org> <1916cb5c-cb3d-427c-bcf0-2c1b905fd6d1@linux.ibm.com> <20241104094431.GY29862@gate.crashing.org> <245fed6f-5fb4-4925-ba0a-fb2f32e650d0@linux.ibm.com> <20241104103615.GZ29862@gate.crashing.org> <f7e8243a-a4c8-44ce-ad03-7d232df461ed@linux.ibm.com> <20241105082018.GA29862@gate.crashing.org> <20241105181752.74a3d6fa2f06d0adfdf85322@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105181752.74a3d6fa2f06d0adfdf85322@kernel.org>
User-Agent: Mutt/1.4.2.3i

Hi!

On Tue, Nov 05, 2024 at 06:17:51PM +0900, Masami Hiramatsu wrote:
> On Tue, 5 Nov 2024 02:20:18 -0600
> Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > On Mon, Nov 04, 2024 at 11:06:23PM +0530, Hari Bathini wrote:
> > > Seems like a bit of misunderstanding there. Function entry here intends
> > > to mean the actual start of function code (function prologue) - after
> > > GEP and function profiling sequence (mflr r0; bl mcount).
> > 
> > What you call "function entry" here simply does not exist.  The compiler
> > can -- and ***WILL***, ***DOES*** -- mix up all of that.
> 
> Here is the "function entry" means the function address.

"Function entry point".  "Function entry" can mean whatever nebulous
thing done at the start of a function :-)

You're free to use your own terminology of course, but it help to use
standard names for standard things!

> Not the prologue.

But that is literally what Hari said, so it confused me.

> On some architecture, we are sure fixed sequences
> right after the function address for ftrace/security. For example,
> x86 has an `ENDBR` for security. Thus, even if we tend to put a
> probe on the "function entry", kprobes shifts the probe point
> forcibly skipping the `ENDBR`. So from the probe callback, the
> probed address does not look like the function address (shift
> the sizeof(ENDBR)).

On almmost all architectures and ABIs the prologues aren't so very
fixed, which is a good thing, because typically the compiler can
make things better in some way (typically faster or smaller code).  Or
other parts of the toolchain can, the loader or dynamic loader often.

> However, the ENDBR does nothing from the program point of view, we
> can still think of that address as the address of the function.
> That is the reason why I introduced arch_kprobe_on_func_entry().

Understood.

> For the other architecture, it might be misunderstood and
> could be miss-implemented. In that case, we should fix that.
> 
> >  In particular,
> > "function prologue" does not exist at all (on any architecture worth
> > its salt, including PowerPC), and all instructions you consider part of
> > a function prologue might end up anywhere.  The "profiling sequence" is
> > part of that btw, and that typically ends up *not* the first thing in
> > the function, not the first thing after the LEP (register saves are
> > earlier often, they are generated in that order in the first place,
> > but they can (and will) be moved if that schedules better).
> > 
> > > Function arguments can be accessed with kprobe only while setting a
> > > probe at an address the kernel treats as function start address.
> > 
> > That is a silly assumption to make.  There is no guarantee you can
> > access function arguments *at all*, we're not in 1975 anymore.  You
> > *need* to look at debug information if you want to deal with anything
> > about your high-level language program.  Looking at the machine code
> > can only tell you about the machine state, whatever is in registers
> > etc.
> 
> Yeah, understood. So the `$arg*` here does not guarantee to access
> arguments, but the best effort to do that. And it fully depends on

Is that GDB syntax?  Or what else?

> regs_get_kernel_argument(). Thus `$arg*` works only where the
> regs_get_kernel_argument() can return most likely function argument
> value from `pt_regs`. That is where we call "function entry" in
> this context.
> 
> And since it checks the function entry by arch_kprobe_on_func_entry()
> this test fails on powerpc because it returns true if the offset from
> the kallsyms symbol address is less than 8/16 bytes.
> 
> > > Note that the test case pass criteria here is setting probe to fail by
> > > providing an address (sym+offset) beyond the function start address.
> > > 
> > > And in this specific test case (with "vfs_read+8", where vfs_read is
> > > the symbol and '8' is the offset), the test case was failing on powerpc
> > > because setting the probe at 'sym+8' was succeeding, as anywhere between
> > > 'sym' to 'sym+16' is treated as function start address on powerpc:
> > 
> > Yeah, fragile tests sometimes break.  Changing a randomly chosen number
> > to some other randomly chosen number will not fix the problem (but you
> > can postpone having to deal with it, sure!)
> 
> Yeah, sorry about the test case. Actually `+8` is also not a good number
> for x86 too since we are not sure whether the address is an instruction
> boundary or not. In that case it may report another error and failed.

So what is it that the testcase really wants to test for?

Thanks for explaining the context somewhat, I know nothing (except all
details about ELFv2 and the other PowerPC ABIs :-) ), it helped :-)


Segher

