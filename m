Return-Path: <linux-kselftest+bounces-37773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B713B0CB92
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 22:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8283D544907
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 20:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C523AB9C;
	Mon, 21 Jul 2025 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZTE06mj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5B155CB3;
	Mon, 21 Jul 2025 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129017; cv=none; b=p3GqEjVGAMJh9cWySdtMWJq3XRp4wmrZuFhJD1GLujShljEWs0UNoTC466bD6vxyGyMOp9JwwSn/8eMesHRTA5l+w8AG9cUoPlpyaj6XfZUEd0pVXgQWY0NT7JmldOSx8SdeHfx7rErkbX0o0vBxptcZM7a3hh0gVv0lWcBImz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129017; c=relaxed/simple;
	bh=fPCjBlrmUPA5mvNxfbJDvZCN5253HcHDupts84ahHrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrhjNNFXcHRqG3MQzhmHlvKtKEvhFvo0F4qKVd1TpEnyc86cbQgqgoW/E6dT1Z6cATP32YwPaADwwPX5nO8gFsbRp6cIBvexyAi9OZLF4035We+ghRNfqFHd1VQHP7ju2Ba1C+5EEV/F3oLZqCsOa2yqOSSwPpwmd8SfXqhN+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZTE06mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CE8C4CEED;
	Mon, 21 Jul 2025 20:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753129016;
	bh=fPCjBlrmUPA5mvNxfbJDvZCN5253HcHDupts84ahHrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZTE06mjfY3FbIlctpmaahVfBx8Ck81gl137LyK4mbMGhbJDdxgZK/YFqcRxcFs7I
	 GSierzely0mYMlZOPybWzDeEuexgHHZCVMrKRQVScg0f6wZVQdH2kKnBn8v5iEkUBG
	 jInQsZ0hyXk5meA5zT3I3fawRxEQdh2lWF2cvNxAQJ6enBocyTvzyTdbcth8dqtAQ4
	 RSLNhSDI3SFe5TsIggOzjkufSSyP0wrf5sYgxy2kZQU3dHKQdvUYaYQmdoc+hS4nj+
	 Rtw5TFIHe5eVMNmLMGYA80ueWZYHFnY0QHmC6Q6vRsAqK6arssfT0eivyT08pwrLsE
	 K9Qv9Noqniu9g==
Date: Mon, 21 Jul 2025 13:16:56 -0700
From: Kees Cook <kees@kernel.org>
To: Nicolas Schier <nicolas.schier@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 01/13] stackleak: Rename STACKLEAK to KSTACK_ERASE
Message-ID: <202507211315.5164A33E@keescook>
References: <20250717231756.make.423-kees@kernel.org>
 <20250717232519.2984886-1-kees@kernel.org>
 <20250721-spiked-adamant-hyrax-eea284@lindesnes>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-spiked-adamant-hyrax-eea284@lindesnes>

On Mon, Jul 21, 2025 at 10:02:36PM +0200, Nicolas Schier wrote:
> On Thu, Jul 17, 2025 at 04:25:06PM -0700, Kees Cook wrote:
> > In preparation for adding Clang sanitizer coverage stack depth tracking
> > that can support stack depth callbacks:
> > 
> > - Add the new top-level CONFIG_KSTACK_ERASE option which will be
> >   implemented either with the stackleak GCC plugin, or with the Clang
> >   stack depth callback support.
> > - Rename CONFIG_GCC_PLUGIN_STACKLEAK as needed to CONFIG_KSTACK_ERASE,
> >   but keep it for anything specific to the GCC plugin itself.
> > - Rename all exposed "STACKLEAK" names and files to "KSTACK_ERASE" (named
> >   for what it does rather than what it protects against), but leave as
> >   many of the internals alone as possible to avoid even more churn.
> > 
> > While here, also split "prev_lowest_stack" into CONFIG_KSTACK_ERASE_METRICS,
> > since that's the only place it is referenced from.
> > 
> > Suggested-by: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: <x86@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: <linux-doc@vger.kernel.org>
> > Cc: <linux-arm-kernel@lists.infradead.org>
> > Cc: <kvmarm@lists.linux.dev>
> > Cc: <linux-riscv@lists.infradead.org>
> > Cc: <linux-s390@vger.kernel.org>
> > Cc: <linux-efi@vger.kernel.org>
> > Cc: <linux-hardening@vger.kernel.org>
> > Cc: <linux-kbuild@vger.kernel.org>
> > Cc: <linux-security-module@vger.kernel.org>
> > Cc: <linux-kselftest@vger.kernel.org>
> > ---
> >  arch/Kconfig                                  |  4 +--
> >  arch/arm/Kconfig                              |  2 +-
> >  arch/arm64/Kconfig                            |  2 +-
> >  arch/riscv/Kconfig                            |  2 +-
> >  arch/s390/Kconfig                             |  2 +-
> >  arch/x86/Kconfig                              |  2 +-
> >  security/Kconfig.hardening                    | 36 ++++++++++---------
> >  arch/arm/boot/compressed/Makefile             |  2 +-
> >  arch/arm64/kernel/pi/Makefile                 |  2 +-
> >  arch/arm64/kvm/hyp/nvhe/Makefile              |  2 +-
> >  arch/riscv/kernel/pi/Makefile                 |  2 +-
> >  arch/riscv/purgatory/Makefile                 |  2 +-
> >  arch/x86/purgatory/Makefile                   |  2 +-
> 
> Did you miss arch/loongarch/Kconfig by accident?
> 
> $ git grep -Hrne ARCH_STACKLEAK
> arch/loongarch/Kconfig:127:     select HAVE_ARCH_STACKLEAK

Oh! Yes, I missed that when I rebased to v6.16 (which added loongarch
support for stackleak). Thanks for catching that!

-- 
Kees Cook

