Return-Path: <linux-kselftest+bounces-21445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD959BC7EC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 09:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB492859CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3BF18E356;
	Tue,  5 Nov 2024 08:23:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48856762D2;
	Tue,  5 Nov 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730795010; cv=none; b=cjbPWxCicfeTS/2M7jfiVUGKuhFrWE2TlJmpK8oU7wwsS07OcWZ+zapwU5t5Ab5aIt06Ig43MDIpTUPSUmXu4AiEM3PCf3LTM8r6ggJqNOI0Cb4VJDtbWW5ajgq9bEEaM8Q0zm6Hbn4KDLwBffMIqG2usdTMWFDGM9xOzjNzb6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730795010; c=relaxed/simple;
	bh=UJqpPbGVgW/KtFagbKhgamo0nZStPQFRmJJZ6AeiT84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mapO+Xfusigd/8PsAm3ywmhkcPPjgKdqSJ5mJkMK+h3JucT4PsVZGfra4I4q709LJm7yuXN4B/3fush0ZnvXsQsU7lRbspBz6YNRPsCkVgnb2KzNhyO2sWMq3Rtf6fp8hEZaoktl3SSRFsJhiPqfkkF24zA5FYwl7R36grcRt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4A58KJ5r012914;
	Tue, 5 Nov 2024 02:20:20 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4A58KISZ012909;
	Tue, 5 Nov 2024 02:20:18 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 5 Nov 2024 02:20:18 -0600
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
Message-ID: <20241105082018.GA29862@gate.crashing.org>
References: <20241101191925.1550493-1-hbathini@linux.ibm.com> <20241101205948.GW29862@gate.crashing.org> <1916cb5c-cb3d-427c-bcf0-2c1b905fd6d1@linux.ibm.com> <20241104094431.GY29862@gate.crashing.org> <245fed6f-5fb4-4925-ba0a-fb2f32e650d0@linux.ibm.com> <20241104103615.GZ29862@gate.crashing.org> <f7e8243a-a4c8-44ce-ad03-7d232df461ed@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e8243a-a4c8-44ce-ad03-7d232df461ed@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i

Hi!

On Mon, Nov 04, 2024 at 11:06:23PM +0530, Hari Bathini wrote:
> Seems like a bit of misunderstanding there. Function entry here intends
> to mean the actual start of function code (function prologue) - after
> GEP and function profiling sequence (mflr r0; bl mcount).

What you call "function entry" here simply does not exist.  The compiler
can -- and ***WILL***, ***DOES*** -- mix up all of that.  In particular,
"function prologue" does not exist at all (on any architecture worth
its salt, including PowerPC), and all instructions you consider part of
a function prologue might end up anywhere.  The "profiling sequence" is
part of that btw, and that typically ends up *not* the first thing in
the function, not the first thing after the LEP (register saves are
earlier often, they are generated in that order in the first place,
but they can (and will) be moved if that schedules better).

> Function arguments can be accessed with kprobe only while setting a
> probe at an address the kernel treats as function start address.

That is a silly assumption to make.  There is no guarantee you can
access function arguments *at all*, we're not in 1975 anymore.  You
*need* to look at debug information if you want to deal with anything
about your high-level language program.  Looking at the machine code
can only tell you about the machine state, whatever is in registers
etc.

> Note that the test case pass criteria here is setting probe to fail by
> providing an address (sym+offset) beyond the function start address.
> 
> And in this specific test case (with "vfs_read+8", where vfs_read is
> the symbol and '8' is the offset), the test case was failing on powerpc
> because setting the probe at 'sym+8' was succeeding, as anywhere between
> 'sym' to 'sym+16' is treated as function start address on powerpc:

Yeah, fragile tests sometimes break.  Changing a randomly chosen number
to some other randomly chosen number will not fix the problem (but you
can postpone having to deal with it, sure!)


Segher

