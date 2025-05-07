Return-Path: <linux-kselftest+bounces-32602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA466AAEC43
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9731A4C6A75
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 19:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5092428E592;
	Wed,  7 May 2025 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adEj+Biz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE421CC45;
	Wed,  7 May 2025 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646621; cv=none; b=bqWjTynZMzumvVhLjyE1zTvvj+9uH60p9ydf+sLZKwMufwHpHfney2eklMjIeKW6r6LuLPtco5I6vXgqOfMKwEtGH3gqA6q9zL5xYq7MI/Z/zj0VY+oLO3OeREUZfGFIJ0/EaA0dmoDJRcK8+FJXrX1K1M1a4kpr1tJOVti3uv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646621; c=relaxed/simple;
	bh=lrmfyWvnM3QwZX0jYJbUO8H9wEWYYrgJ7OaSlLyzEgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osIWWmvriGyCwX8SkF8zPAmgUJcIDSZBnczE2Vw/Ibzir0VG0DGdW2rhudJ/pLHx2bmGuK0Na8fPMm7A/Je45MbaAtRXuwItA9w+FBvN/1W3BS7GXanHV2XlYNKnY6lM+oHb4PRIEw4SmEaUn+W+sVP0DkoRKzVgtEIA0mafM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adEj+Biz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E255C4CEE2;
	Wed,  7 May 2025 19:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746646620;
	bh=lrmfyWvnM3QwZX0jYJbUO8H9wEWYYrgJ7OaSlLyzEgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adEj+BizyWGNYyIo5IgqAqEZv/fYXZwSE6hbDf5r3NKhwW3FLQgI40vKpeqr1qBIi
	 IZDndlHbUJsmMjZPIhKjr1vMIOoZKzeRi75y8DBhxxBZDfHtMl5G87s1YS59Qu+Ug4
	 M7Bd8RMx150oxVdRPqbjZT3zqbIrQnLuMvM6qTrxZk/EfDbL67wtKqXgIbFWPEDM89
	 DcDfZ5Z0nwBba+lNW31VpiwbKaAyT0t8v2xXiOirP3Vp0Jk/WTHKbdpIiWsfFgeiMy
	 0JoJj15rZjQPlqTneT7LfTJA1TcyUyBRShtC50Ov3mP3saiJ7e6dD1qYk/yJOU4tuu
	 7pjj9Ujhx261Q==
Date: Wed, 7 May 2025 12:36:57 -0700
From: Kees Cook <kees@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 3/8] stackleak: Rename CONFIG_GCC_PLUGIN_STACKLEAK to
 CONFIG_STACKLEAK
Message-ID: <202505071236.AC25A6CC2@keescook>
References: <20250507180852.work.231-kees@kernel.org>
 <20250507181615.1947159-3-kees@kernel.org>
 <aBuqO9BVlIV3oA2M@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBuqO9BVlIV3oA2M@gmail.com>

On Wed, May 07, 2025 at 08:45:15PM +0200, Ingo Molnar wrote:
> 
> * Kees Cook <kees@kernel.org> wrote:
> 
> > -	  The STACKLEAK gcc plugin instruments the kernel code for tracking
> > +	  The STACKLEAK options instruments the kernel code for tracking
> 
> speling.

Thanks!

> Also, any chance to fix this terrible name? Should be something like 
> KSTACKZERO or KSTACKCLEAR, to tell people that it doesn't leak the 
> stack but prevents leaks on the stack by clearing it, and that it's 
> about the kernel stack, not any other stack.

Yeah, better to name it for what it does rather than want to protects
against. The internal naming for what it does is "stack erase", so
perhaps KSTACK_ERASE ?

-Kees

-- 
Kees Cook

