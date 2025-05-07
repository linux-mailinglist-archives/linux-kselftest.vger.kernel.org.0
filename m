Return-Path: <linux-kselftest+bounces-32599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9991AAE97D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63151505B11
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF68E211A2A;
	Wed,  7 May 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex6DbSwQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90011FC1D;
	Wed,  7 May 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643524; cv=none; b=Pn1rIV6tpVWFAQ5qVDSfuTNRDVAvrGa1HRRvnOGcL5ejtv0tgT4zbzcD+IXJRJLu4fy4T9QruQuFPa9wabqkCPa4sZ5SX1NoJr22yjxBuRt1o5PUuQjDrgt6u55lcX5hBO2CaTeEq+/aptCSkZsZCDedcCToyBF8+cVBDL6miK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643524; c=relaxed/simple;
	bh=b0Z2CtCQbrS6Cm6Atyr106vvviX+heraGGwK75dEIUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZqsT4/wOjHLGqq0gkEK6BPt1B1JXJ83ZvP2fiWNCO+Ka7SEjGpNG+zxn0wV1ev3fLt3W4Ue/YXbOglcXDTGOe9gUFvY42wJRCap7Ow/Adib9uruu48FzgDGiJkbp/mwjypxTdTM81afD76nTwS9NIQLuuHa0xMHiZj5totcRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex6DbSwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43067C4CEE9;
	Wed,  7 May 2025 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746643524;
	bh=b0Z2CtCQbrS6Cm6Atyr106vvviX+heraGGwK75dEIUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ex6DbSwQi9n8oIBLyX47q8kuQwKQbQ0Wjt1QL7/sSP/5oCsmMIfNneg/7H3Id1bj3
	 vidrjBlo4LT6qTNjkmtOikzCkhVz4lUpuJ78RGUVGcoGUVVZ7p+4/Nt5ZLaKnmsSWv
	 hjwEQwfjKvHsOz+Hz9LUKfJeViO4JflKm2JGHJBzXU+uIlwbaXKY83Ftu00T48m2kv
	 Q9nbjHbKCkZTw3jZk0y+3VmNqyO5hYcLVGvQ+0fSyn7xPXQlzSZf0jfPu2NPQGSVKZ
	 ztGxmYuYjI87tVS60h+jrkYyEEv9MdbA4nB2SInPGC2i0ga2/j5ZIiGid1h9z3yDWn
	 XbfNs0/Ux3oXg==
Date: Wed, 7 May 2025 20:45:15 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <kees@kernel.org>
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
Message-ID: <aBuqO9BVlIV3oA2M@gmail.com>
References: <20250507180852.work.231-kees@kernel.org>
 <20250507181615.1947159-3-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507181615.1947159-3-kees@kernel.org>


* Kees Cook <kees@kernel.org> wrote:

> -	  The STACKLEAK gcc plugin instruments the kernel code for tracking
> +	  The STACKLEAK options instruments the kernel code for tracking

speling.

Also, any chance to fix this terrible name? Should be something like 
KSTACKZERO or KSTACKCLEAR, to tell people that it doesn't leak the 
stack but prevents leaks on the stack by clearing it, and that it's 
about the kernel stack, not any other stack.

Thanks,

	Ingo

