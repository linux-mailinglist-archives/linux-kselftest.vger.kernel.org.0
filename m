Return-Path: <linux-kselftest+bounces-21388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B19BB8F7
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 16:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C2A1C2081B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1488D1BC9EE;
	Mon,  4 Nov 2024 15:27:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2413C827;
	Mon,  4 Nov 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734028; cv=none; b=cyqLi5vwcwXO2lSiVKnmsP/l90uOcOZXjIAvz3dyLifTMAPsn47YVXpnAgnIff4nonoBo0EJA81CecCCcw5xsiRFZq9JPTX44ftprdnKIM6a4vtifU7HB+ryYKahYfm8fj+Aqn6R1P5dcgMChISd/lyJNOuW89zMC0al24AJI7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734028; c=relaxed/simple;
	bh=vY0rBH99vGqCYCoZ8m5NHbbAj/+DeHnaysoxqekFov8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EotfordXswP6Ql6OXgzi30Q05NUDV/BIFkF4+I7zzb1ceRTLAqsFvhbhWjMFx6Jdzf6b3EfPIEWtd9cXbolYySwiZfTA5Y8/sweQhFva8l7N6JiC51839vZTqu3eRd98GTkazUAqux2PH2XGoETB90C7nMqNglJqvVoq1HO0qX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6E8C4CECE;
	Mon,  4 Nov 2024 15:27:06 +0000 (UTC)
Date: Mon, 4 Nov 2024 10:27:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, "Naveen N. Rao" <naveen@kernel.org>, lkml
 <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] selftests/ftrace: update kprobe syntax error test for
 ppc64le
Message-ID: <20241104102704.7c20dc0b@gandalf.local.home>
In-Reply-To: <20241104103615.GZ29862@gate.crashing.org>
References: <20241101191925.1550493-1-hbathini@linux.ibm.com>
	<20241101205948.GW29862@gate.crashing.org>
	<1916cb5c-cb3d-427c-bcf0-2c1b905fd6d1@linux.ibm.com>
	<20241104094431.GY29862@gate.crashing.org>
	<245fed6f-5fb4-4925-ba0a-fb2f32e650d0@linux.ibm.com>
	<20241104103615.GZ29862@gate.crashing.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 04:36:15 -0600
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > >>Querying for function arguments is supported on kprobes only at function
> > >>entry. This is a negative test case where the offset is intentionally
> > >>set beyond function entry while querying for function arguments.
> > >>I guess, simply setting the offset to 20 (vfs_read is anyway
> > >>going to be beyond 5 instructions) instead of 8 for powerpc would
> > >>make all platforms and ABI variants happy?  
> > >
> > >I have no idea.  What is this "offset" anyway?  
> > 
> > offset (in bytes) from function start address..  
> 
> But what is there?

Function start address is what kallsyms returns. That is:

  grep function /proc/kallsyms

> 
> > >This is just the ELFv2 ABI.  No platform can make up its own thing at
> > >all (well, none decided to be gratuitously incompatible, so far).  And
> > >there are no "ABI variants"!  
> > 
> > The test case applies for ABIv1 & ABIv2. All ppc32 & ppc64 platforms..  
> 
> Hrm.  So you allow essentially random entry points on other ABIs to
> work?
> 
> > >You're just making assumptions here that are based on nothing else but
> > >observations of what is done most of the time.  That might work for a
> > >while -- maybe a long while even! -- but it can easily break down.  
> > 
> > Hmmm.. I understand that you want the test case to read st_other field
> > but would you rather suggest an offset of 64?  
> 
> I have no idea what "offset" means here.

The offset is the number of bytes from the address that is returned by
kallsyms.


> 
> > Is a GEP of 8/16 instructions going to be true anytime soon or is it
> > true already for some cases? The reason I ask that is some kprobe/ftrace
> > code in the kernel might need a bit of re-look if that is the case.  
> 
> An entry point has no instructions at all.  Oh, you mean the code at
> the GEP.
> 
> The LEP can already be all the allowed distances after the GEP.  And
> the .localentry GAS directive already supports all those distances
> always.  Not a lot of code written in assembler does use that, and
> certainly GCC does not use a lot of the freedom it has here, but it
> could (and so could assembler programmers).  Typically people will want
> to make the code here as short as possible, and there are restrictions
> on what is *allowed* to be done here anyway (ld, the link editor, can
> change this code after all!), so it is not too likely you will ever see
> big code at the GEP often, but times change, etc.


This is all determined by the kernel. It's considered a function entry by
the function:

   arch_kprobe_on_func_entry()

Which on PowerPC has:

static bool arch_kprobe_on_func_entry(unsigned long offset)
{
#ifdef CONFIG_PPC64_ELF_ABI_V2
#ifdef CONFIG_KPROBES_ON_FTRACE
        return offset <= 16;
#else
        return offset <= 8;
#endif
#else
        return !offset;
#endif  
}

So, being greater than 16 on powerpc with config CONFIG_PPC64_ELF_ABI_V2
set, would work. If that function changes, then the test needs to change.

-- Steve

