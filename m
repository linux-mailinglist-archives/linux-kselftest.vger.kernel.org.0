Return-Path: <linux-kselftest+bounces-21366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A399A9BB028
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 10:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07053B25301
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A78F1ABEDC;
	Mon,  4 Nov 2024 09:47:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031E155392;
	Mon,  4 Nov 2024 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713629; cv=none; b=SW673Ebs6Ca+gOJ09AYkCToPFX1vZEr1NOcx47MJErz6c+Wr0y/9cE2IVl+C3SD+I6R+gSBIeypCmTDBSE5JIz+mOHV+u/kpT1k7d9N7zlDtvOTwS5lW+0mqr2uzYTtysWjuCB6JPSrmJf8tCe+825lWhDhQcYlf1A0j8Fva+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713629; c=relaxed/simple;
	bh=HbQhKt2i3wZbPF02Q7BWtXQCO2Oxr3vB4SwbbfFADSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbL2Yg2YvwasReGtcIEDQDkCYrg7kg/M9fTivRVnELZlRtVmhyrtaLo9WrzMa8nfaTjOu90lK3LP0qwmFC7diTditUbl88R/0K9O6fFTUcRhLITsDKyAAOsCUaQDAWjaKPeIB9sfsBb+vXVGnhrhzpFUV/vwtRMLXCYWAwQaJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4A49iXoP008951;
	Mon, 4 Nov 2024 03:44:33 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4A49iWW9008947;
	Mon, 4 Nov 2024 03:44:32 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Mon, 4 Nov 2024 03:44:31 -0600
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
Message-ID: <20241104094431.GY29862@gate.crashing.org>
References: <20241101191925.1550493-1-hbathini@linux.ibm.com> <20241101205948.GW29862@gate.crashing.org> <1916cb5c-cb3d-427c-bcf0-2c1b905fd6d1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1916cb5c-cb3d-427c-bcf0-2c1b905fd6d1@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i

Hi!

On Mon, Nov 04, 2024 at 02:51:57PM +0530, Hari Bathini wrote:
> On 02/11/24 2:29 am, Segher Boessenkool wrote:
> >On Sat, Nov 02, 2024 at 12:49:25AM +0530, Hari Bathini wrote:
> >>For ppc64le, depending on the kernel configuration used, offset 16
> >>from function start address can also be considered function entry.
> >>Update the test case to accommodate such configurations.
> >
> >(This is true for all ELfv2, not just LE.  For the kernel that is about
> >the same).
> >
> >The LEP and GEP can differ by zero, one, two, four, eight, or sixteen
> >insns (where an insn is four bytes).  Four insns is common, yes, but
> >maybe you can support all?  See the function symbol's st_other field
> >to see what the offset is:
> >0, 1: zero insns, zero bytes
> >N = 2..6: 1 << (N-2) insns, i.e. 1<<N bytes
> >7: reserved
> >
> >(This is the top 3 bits of st_other, the other bits have other meanings).
> >
> >Four insns is common, yes, but by no means the only possibility.
> 
> Hi Segher,
> 
> Querying for function arguments is supported on kprobes only at function
> entry. This is a negative test case where the offset is intentionally
> set beyond function entry while querying for function arguments.
> I guess, simply setting the offset to 20 (vfs_read is anyway
> going to be beyond 5 instructions) instead of 8 for powerpc would
> make all platforms and ABI variants happy?

I have no idea.  What is this "offset" anyway?

This is just the ELFv2 ABI.  No platform can make up its own thing at
all (well, none decided to be gratuitously incompatible, so far).  And
there are no "ABI variants"!

You're just making assumptions here that are based on nothing else but
observations of what is done most of the time.  That might work for a
while -- maybe a long while even! -- but it can easily break down.


Segher

