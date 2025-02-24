Return-Path: <linux-kselftest+bounces-27349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A821DA4247B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 15:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF233A5577
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5285814B080;
	Mon, 24 Feb 2025 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UO5sOIvM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qbjrieea"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C42713B298;
	Mon, 24 Feb 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408118; cv=none; b=nFX5WKkZOhiX8+uUbeakVLlvwK4v5c7+nbDYVbwjYELf+i2ze382JnBs0WqGXWVLe/CN8Br0n4dHUmH77VjJGk76nKq9iezI0mMDYzA1xPQtuSMQjP2xk0l4+a9+vBHehj4BUAPQkaxCXNms8L8a2zClWm5K6qz+sCojxqO/NCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408118; c=relaxed/simple;
	bh=gs0CCeRL6myGvXdX8g0juhC+zWs6/HdyuF8Wem9m4SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvAl2gLHky/X2JQBxCzQagksASqnY2JUB/8KY9vb0zsTkIHOmefnh6X3xznUhbX2wNcl17PZl1uSWmAgrbdT5urizH7w8oFlrTlFXECEwbv7UbcjCuqfr5Rj6NJOpX7BHCiDFTRkmsvMuiwUKY/5xy3vLGnD8bE9AE6RYhIh9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UO5sOIvM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qbjrieea; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Feb 2025 15:41:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740408114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qst4I5C+fBiRdrcq+Nq/EQ/MFz4i7PJXz7K31DJjAFU=;
	b=UO5sOIvMo27SCcl5POLOdN17FEhJ0IBgsA7p2uvWdvO68GV/epYCwlnRvfpdIqPfanoye9
	gDuV2rTCT4L/v0B483f+Tooa9PWQZkflWvhGWMqoV3nDZWR4amjej3fiCwp5aXEV5WeBY/
	dTRd+htXaG3dKkRlRIsSPgFCsv+Z9AiGAHdGqyVnQUxQ988OfFG1qP9RSFUTwxpypoBXEQ
	ofjnc7f/5oIyf6Zxyyt5osGbUcVZXBC1bjwVcgJlHXoX/tt1Fy8ZcWa8EX/BdU627zUBeQ
	mgWZCpskA8Bk7LgEEyif941cqiwtZ7TU7yIo66WCmJVH21A20nbFwExqb8Ybwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740408114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qst4I5C+fBiRdrcq+Nq/EQ/MFz4i7PJXz7K31DJjAFU=;
	b=QbjrieeakqbpTtJLYrgh+XbLfbcXlPWmdp7e1sIe4Vm4Th4/Erub8o+eEw/cokEU7ibNLd
	UVmELv+QdQLQSXBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH 13/16] selftests: vDSO: parse_vdso: Make compatible with
 nolibc
Message-ID: <20250224154007-bb3ab855-7a9d-43ba-851c-054a5c4fe324@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <20250203-parse_vdso-nolibc-v1-13-9cb6268d77be@linutronix.de>
 <20250222102426.GA13708@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250222102426.GA13708@1wt.eu>

On Sat, Feb 22, 2025 at 11:24:26AM +0100, Willy Tarreau wrote:
> On Mon, Feb 03, 2025 at 10:05:14AM +0100, Thomas Weißschuh wrote:
> > nolibc does not provide this header, instead its definitions are
> > available unconditionally.
> 
> Please think about reminding which one you're talking about so that a
> simple "git log" shows what header you're talking about (limits.h)
> without requiring to also see the patch itself.

Ack.

> BTW, I think that limits.h is common enough that we could probably
> provide it as well with nolibc to ease porting (and the current patch
> is a good example of this). Maybe it could simply start by including
> stdint.h to provide the various limits we rely on. I remember that in
> the early days of nolibc-test we had to exclude it as well for nolibc.
>
> What do you think? The less we need to patch programs to insert #ifndef
> NOLIBC, the better.

Sounds good, I'll do that for v2.
Given that any nolibc header always also includes the global nolibc.h,
I think limits.h can directly include nolibc.h.
 
> Cheers,
> Willy

