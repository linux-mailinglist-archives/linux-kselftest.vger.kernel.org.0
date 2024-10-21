Return-Path: <linux-kselftest+bounces-20289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0A9A70E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 19:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A321F1F212FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 17:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0881EABDA;
	Mon, 21 Oct 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXgyR2wX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C341B1EABC2
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531184; cv=none; b=Q4JiqVz8r3XNWzfwMEfmlOMrUzYcOfA9Rd48uU/PpOQV4TKZFt8fNDFnRGXXT6At6spxtk30WB8YY3g/UMKiJQqlxeoP3cd511kpaC0YmNW+5J1eYuvraNADPy4iMtuQU7UCLY3IKAfYxiFej5tGzmHixqhRC3W8Nit0uNtRFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531184; c=relaxed/simple;
	bh=tiWcGz/xjhXfgcJ1cihsOzYbVkw2f48yxSQeFEQ/jVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqkvY603E7Avn/WtaVotDMY2BGXF0R1ytVGMRxX2BxHm2gWU7RDrhxz9AWlAiOicpKx6bXLPd6f/ynHAYyoy/a+2qOVYItuGhkPFOZMgDQKMWdPk9wvr6K/EhCBKQ8Xg4XXwI2qtXG7yl4nBHT4/4F5oIKfpCOi6M9/M14w1nko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXgyR2wX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB037C4CEC3;
	Mon, 21 Oct 2024 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729531184;
	bh=tiWcGz/xjhXfgcJ1cihsOzYbVkw2f48yxSQeFEQ/jVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXgyR2wXk4rzx1jsLFIZEMqnheGakQpNqOYPBze8diTWLkxvdYgmXWeCvY0yeIBNO
	 aGFnMO+zrr8dTcV6FsfTd4kFaERJFsHYrAwUKzsniVu881+AGB64r/QsiSvALCdT0m
	 4YOB0RSDzb+RL9GDhMzWRzXm215DhX5tsLD19SZDt1g00LKaQMBK36UKO6ZAXku9g/
	 3vLy32jsnXCzIG8oktHgFhgkPPGMzbts/vTvVwl1VSRXqH78/ANkUggn9RL4Artcy7
	 5DryMcQROcxMTjwvZqKzGKKiBFXlG5CNfaOAP1yjRaFqOzx2mgpACGHvDUuLLizjzb
	 SHKEK/tCSDRRw==
Date: Mon, 21 Oct 2024 18:19:38 +0100
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com,
	broonie@kernel.org, dave.hansen@linux.intel.com,
	jeffxu@chromium.org, joey.gouly@arm.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, x86@kernel.org,
	pierre.langlois@arm.com
Subject: Re: [PATCH 0/5] Improve arm64 pkeys handling in signal delivery
Message-ID: <20241021171937.GA26179@willie-the-truck>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <ZxEx5aXPX2mHngoB@e133380.arm.com>
 <627c1297-8151-43d1-b46b-a962301b18fa@arm.com>
 <ZxZXnM9vUj+tex/z@e133380.arm.com>
 <ZxZzfMV0dbjJ55UD@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZzfMV0dbjJ55UD@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Oct 21, 2024 at 04:30:04PM +0100, Catalin Marinas wrote:
> On Mon, Oct 21, 2024 at 02:31:08PM +0100, Dave P Martin wrote:
> > > > On Thu, Oct 17, 2024 at 02:39:04PM +0100, Kevin Brodsky wrote:
> > > >> This series is a follow-up to Joey's Permission Overlay Extension (POE)
> > > >> series [1] that recently landed on mainline. The goal is to improve the
> > > >> way we handle the register that governs which pkeys/POIndex are
> > > >> accessible (POR_EL0) during signal delivery. As things stand, we may
> > > >> unexpectedly fail to write the signal frame on the stack because POR_EL0
> > > >> is not reset before the uaccess operations. See patch 3 for more details
> > > >> and the main changes this series brings.
> > > >>
> > > >> A similar series landed recently for x86/MPK [2]; the present series
> > > >> aims at aligning arm64 with x86. Worth noting: once the signal frame is
> > > >> written, POR_EL0 is still set to POR_EL0_INIT, granting access to pkey 0
> > > >> only. This means that a program that sets up an alternate signal stack
> > > >> with a non-zero pkey will need some assembly trampoline to set POR_EL0
> > > >> before invoking the real signal handler, as discussed here [3].
> [...]
> > Memory with a non-zero pkey cannot be used 100% portably, period, and
> > having non-RW(X) permissions on pkey 0 at any time is also not
> > portable, period.  So I'm not sure that having libc magically guess
> > what userspace's pkeys policy is supposed to be based on racily digging
> > metadata out of /proc/self/maps or a cache of it etc. would be such a
> > good idea.
> 
> I agree that changing RWX overlay permission for pkey 0 to anything else
> is a really bad idea. We can't prevent it but we shouldn't actively try
> to work around it in the kernel either. With the current signal ABI, I
> don't think we should support anything other than pkey 0 for the stack.
> Since the user shouldn't change the pkey 0 RWX overlay permission
> anyway, I don't think we should reset POR_EL0 _prior_ to writing the
> signal frame. The best we can do is document it somewhere.
> 
> So on patch 3 I'd only ensure that we have POR_EL0_INIT when invoking
> the signal handler and not when performing the uaccess. If the uaccess
> fails, we'd get a fatal SIGSEGV. The user may have got it already if it
> made the stack read-only.

Hmm, but based on what Kevin's saying, this would mean actively choosing
a different ABI than what x86 is trying to get to.

> Currently the primary use of pkeys is for W^X and signal stacks
> shouldn't fall into this category. If we ever have a strong case for
> non-zero pkeys on the signal stack, we'll need to look into some new
> ABI. I'm not sure about SS_* flags though, I think the signal POR_EL0
> should be associated with the sigaction rather than the stack (the
> latter would just be mapped by the user with the right pkey, the kernel
> doesn't need to know which, only what POR_EL0 is needed by the handler).
> 
> Until such case turns up, I'd not put any effort into ABI improvements.

Kevin -- do you know what prompted x86 to want the pkey to be reset early
in signal delivery? Perhaps such a use-case already exists.

> I can think of some light compartmentalisation where we have a pkey
> that's "privileged" and all threads have a POR_EL0 that prevents access
> to that pkey. The signal handler would have more permissive rights to
> that privileged pkey. I'd not proactively add support for this though.

I'd not proactively diverge from other architectures, either :p

Will

