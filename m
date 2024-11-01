Return-Path: <linux-kselftest+bounces-21323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 170009B99CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 22:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13431F2210A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 21:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C91E2609;
	Fri,  1 Nov 2024 21:02:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF1D1CB317;
	Fri,  1 Nov 2024 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494940; cv=none; b=mjtxijVFwFuB2m103USykXKJvX9vc3o3m6KJEON2Of9Y1RfsPEWkqTvP94qJ7AaXWwTRuLJmB36vKUbYDXt3sOQLKrhG7lSt5XP0VJajIVSqCZkp7fdZjRvLMNaqW3NiF5kYZDnEkfUL1Y72eYcbie9mJtC2LjcwTGEYasEU+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494940; c=relaxed/simple;
	bh=LcBHZ4smrRp3YSFRMUbqN4yQqU7ZJwubFk4p8f/2UPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbO0VO1iP31e4HejL78RiloFXln0QoiAVfgPyn3VmUqGY/u/vp9piAh4Z+sysP6+gKcaVcHG/9Wf/ohDEbKOBYSvXhWgTEt5SmP7dac1fBNOifiUJkilwFyNBAU6RdtubWUzkqXNj9ho/DAumfUQmauGZzZ4gva/jhnYffGL/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4A1KxpG2021265;
	Fri, 1 Nov 2024 15:59:51 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4A1Kxnst021262;
	Fri, 1 Nov 2024 15:59:49 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 1 Nov 2024 15:59:48 -0500
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
Message-ID: <20241101205948.GW29862@gate.crashing.org>
References: <20241101191925.1550493-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101191925.1550493-1-hbathini@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i

Hi!

On Sat, Nov 02, 2024 at 12:49:25AM +0530, Hari Bathini wrote:
> For ppc64le, depending on the kernel configuration used, offset 16
> from function start address can also be considered function entry.
> Update the test case to accommodate such configurations.

(This is true for all ELfv2, not just LE.  For the kernel that is about
the same).

The LEP and GEP can differ by zero, one, two, four, eight, or sixteen
insns (where an insn is four bytes).  Four insns is common, yes, but
maybe you can support all?  See the function symbol's st_other field
to see what the offset is:
0, 1: zero insns, zero bytes
N = 2..6: 1 << (N-2) insns, i.e. 1<<N bytes
7: reserved

(This is the top 3 bits of st_other, the other bits have other meanings).

Four insns is common, yes, but by no means the only possibility.


Segher

