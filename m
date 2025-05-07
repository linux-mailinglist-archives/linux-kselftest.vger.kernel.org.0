Return-Path: <linux-kselftest+bounces-32603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D315AAEC51
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 21:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A882D7B1E48
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 19:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D03128E59F;
	Wed,  7 May 2025 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1SqsDxB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2DE1714B3;
	Wed,  7 May 2025 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646798; cv=none; b=P+loQ7Rf3ixmUZRyh/pMNnaegh7deQENdXfqFOamWbN/NyvTxXfsmJNVcW+h3kp0CCs6JmfwBTTvZstPP0gpgXYopmUZGLOMtDDy6jC6F7td4VlKhqV1utT5kvEIc0wpa/mVW18jYKLnRXhx3WPN2cxT0DTT/xVlzfM4yRA/UDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646798; c=relaxed/simple;
	bh=5I7Y42gv0Xc24O6cWYZHG0MvTqIyPfed5hpojVV46Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXPW9zEpl8KlEWWKnwa5MunoNr+YZgmHiqsk0Ui/hwgw274qZ78fegm0CKnlrFyQihtWK8UzLCHiUc1j2pdVap2FMdUBBP4xD6dqYzZuRkpep0RdmreV2Oowf4VLp7v4cn/pm+oXxg5vFtYei3N8Bs218H19sVFLiuZedKHLYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1SqsDxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DA0C4CEE2;
	Wed,  7 May 2025 19:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746646796;
	bh=5I7Y42gv0Xc24O6cWYZHG0MvTqIyPfed5hpojVV46Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u1SqsDxB/g600BTu4sky4DKUVjfl1oDoOHSjos3OglBUO3r5ziZEUSYrGhQEJbIGc
	 /hgDGGywWZjMgVHBWxIKFxid7W3NlXGhudDVowJiD8A7xtMyHlDtVXGX4dR2D++Xv3
	 BSgZR4gzpPkvKRUJ3mqOJY76mhFzdikOJ1pam4u+BpTPzRaGrv+6RT1oIQ2SfBv0eK
	 6yflLpCPdfQXrNcxLl52iB/aS5GNE124Nm8Llx95t7b46xZUQIJi/xCMvyN/LsRTGn
	 zqQ1gCN6R7qB0uIhywhZ7QC1LmeWo55N1MJoJW7lvm+Lhk4UkrEorBUDm9BVmEvaZj
	 /eDEXU4AwO0ng==
Date: Wed, 7 May 2025 21:39:48 +0200
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
Message-ID: <aBu3BNS60PEw5Uwu@gmail.com>
References: <20250507180852.work.231-kees@kernel.org>
 <20250507181615.1947159-3-kees@kernel.org>
 <aBuqO9BVlIV3oA2M@gmail.com>
 <202505071236.AC25A6CC2@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505071236.AC25A6CC2@keescook>


* Kees Cook <kees@kernel.org> wrote:

> On Wed, May 07, 2025 at 08:45:15PM +0200, Ingo Molnar wrote:
> > 
> > * Kees Cook <kees@kernel.org> wrote:
> > 
> > > -	  The STACKLEAK gcc plugin instruments the kernel code for tracking
> > > +	  The STACKLEAK options instruments the kernel code for tracking
> > 
> > speling.
> 
> Thanks!
> 
> > Also, any chance to fix this terrible name? Should be something like 
> > KSTACKZERO or KSTACKCLEAR, to tell people that it doesn't leak the 
> > stack but prevents leaks on the stack by clearing it, and that it's 
> > about the kernel stack, not any other stack.
> 
> Yeah, better to name it for what it does rather than want to protects
> against. The internal naming for what it does is "stack erase", so
> perhaps KSTACK_ERASE ?

That's even better, and I like the word separation as well. Thanks!

	Ingo

