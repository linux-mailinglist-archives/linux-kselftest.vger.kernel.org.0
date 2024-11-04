Return-Path: <linux-kselftest+bounces-21370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B479BB14D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FC11C21392
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17141B2198;
	Mon,  4 Nov 2024 10:38:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0701B394C;
	Mon,  4 Nov 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716717; cv=none; b=RIPxT81VOgu9O99Qi82D0hI2DLAcsw2c0JT4VuDiG2rnQ+alDS7YIQPxd63F3gcU2U4eAUPtIa9f7aatf01JkB2Sl1TKx6bbZYLgJ1o2HD8SkfGa6C8y6rTDiKrqnyVSkXHypRZ+2S1hZxv9sjBot3E4ZWPHKdgYHkYni/NvadU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716717; c=relaxed/simple;
	bh=HGPGB0Mg253q0yrFI7BDnmDh/7TP1a+ibRRnqp9yLT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoEXvYmS9rQ26lQ7JmVBsbM7iqO9oBjitB5ZXt0o1t7hokT/0iEIR1YYoDf6GdT+9F+kS3kCJ25TlJqrpC5kw1XznK/4eGzaMWx+zufI6IfUKJ7zTmiQzkAVXQOv0DnKtLIEUzAtQcOdFf6WRyNGaE9mHek2WGALHrS2xywpikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4A4AaIGG013804;
	Mon, 4 Nov 2024 04:36:18 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4A4AaGdn013795;
	Mon, 4 Nov 2024 04:36:16 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Mon, 4 Nov 2024 04:36:15 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Naveen N. Rao" <naveen@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] selftests/ftrace: update kprobe syntax error test for ppc64le
Message-ID: <20241104103615.GZ29862@gate.crashing.org>
References: <20241101191925.1550493-1-hbathini@linux.ibm.com> <20241101205948.GW29862@gate.crashing.org> <1916cb5c-cb3d-427c-bcf0-2c1b905fd6d1@linux.ibm.com> <20241104094431.GY29862@gate.crashing.org> <245fed6f-5fb4-4925-ba0a-fb2f32e650d0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <245fed6f-5fb4-4925-ba0a-fb2f32e650d0@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i

Hi!

On Mon, Nov 04, 2024 at 03:40:26PM +0530, Hari Bathini wrote:
> On 04/11/24 3:14 pm, Segher Boessenkool wrote:
> >On Mon, Nov 04, 2024 at 02:51:57PM +0530, Hari Bathini wrote:
> >>On 02/11/24 2:29 am, Segher Boessenkool wrote:
> >>>On Sat, Nov 02, 2024 at 12:49:25AM +0530, Hari Bathini wrote:
> >>>>For ppc64le, depending on the kernel configuration used, offset 16
> >>>>from function start address can also be considered function entry.
> >>>>Update the test case to accommodate such configurations.
> >>>
> >>>(This is true for all ELfv2, not just LE.  For the kernel that is about
> >>>the same).
> >>>
> >>>The LEP and GEP can differ by zero, one, two, four, eight, or sixteen
> >>>insns (where an insn is four bytes).  Four insns is common, yes, but
> >>>maybe you can support all?  See the function symbol's st_other field
> >>>to see what the offset is:
> >>>0, 1: zero insns, zero bytes
> >>>N = 2..6: 1 << (N-2) insns, i.e. 1<<N bytes
> >>>7: reserved
> >>>
> >>>(This is the top 3 bits of st_other, the other bits have other meanings).
> >>>
> >>>Four insns is common, yes, but by no means the only possibility.
> >>
> >>Hi Segher,
> >>
> >>Querying for function arguments is supported on kprobes only at function
> >>entry. This is a negative test case where the offset is intentionally
> >>set beyond function entry while querying for function arguments.
> >>I guess, simply setting the offset to 20 (vfs_read is anyway
> >>going to be beyond 5 instructions) instead of 8 for powerpc would
> >>make all platforms and ABI variants happy?
> >
> >I have no idea.  What is this "offset" anyway?
> 
> offset (in bytes) from function start address..

But what is there?

> >This is just the ELFv2 ABI.  No platform can make up its own thing at
> >all (well, none decided to be gratuitously incompatible, so far).  And
> >there are no "ABI variants"!
> 
> The test case applies for ABIv1 & ABIv2. All ppc32 & ppc64 platforms..

Hrm.  So you allow essentially random entry points on other ABIs to
work?

> >You're just making assumptions here that are based on nothing else but
> >observations of what is done most of the time.  That might work for a
> >while -- maybe a long while even! -- but it can easily break down.
> 
> Hmmm.. I understand that you want the test case to read st_other field
> but would you rather suggest an offset of 64?

I have no idea what "offset" means here.

> Is a GEP of 8/16 instructions going to be true anytime soon or is it
> true already for some cases? The reason I ask that is some kprobe/ftrace
> code in the kernel might need a bit of re-look if that is the case.

An entry point has no instructions at all.  Oh, you mean the code at
the GEP.

The LEP can already be all the allowed distances after the GEP.  And
the .localentry GAS directive already supports all those distances
always.  Not a lot of code written in assembler does use that, and
certainly GCC does not use a lot of the freedom it has here, but it
could (and so could assembler programmers).  Typically people will want
to make the code here as short as possible, and there are restrictions
on what is *allowed* to be done here anyway (ld, the link editor, can
change this code after all!), so it is not too likely you will ever see
big code at the GEP often, but times change, etc.


Segher

