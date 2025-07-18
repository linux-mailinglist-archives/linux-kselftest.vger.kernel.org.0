Return-Path: <linux-kselftest+bounces-37557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BEB0A1D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 13:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBCB3B3B07
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 11:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F2E2D780C;
	Fri, 18 Jul 2025 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8N985kT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6AE28B41A;
	Fri, 18 Jul 2025 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837733; cv=none; b=bmU7dcUS/kmqizw3rM3/On5WSZb1Xr7nYvxMRYtUB+8rxhtb2hvhAeKsb2bSyrGLLBruX4+6FZ1WC2uShwy4ziiv3mlNEGl0+n0+6XgOYTSB4o/vaO5cLD5jCNLmOg5ea0mKNSxZ0DdtNwKN2XkC8CAiTvtgydZyH84UCzdbJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837733; c=relaxed/simple;
	bh=z3gndaGJcN2hgsC7vt0hd7Xv3Nt3ExEva3jSiEJodDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8U33/gZAIGFbC22qeWk+9Akb7kwIGE0TWfD0p70WbC3oFe+qBjf1cGHSYK/0zL5fB4IKItYuaZQvaAkzaPkyT11/VxG/mEG4kCl5nKqK8rQxG06GMBEG9Hi/iMawN7qNIXfAd2TMkircPU292hxhJI4OPit1XSxyvDb4pPq9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8N985kT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833A3C4CEEB;
	Fri, 18 Jul 2025 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752837733;
	bh=z3gndaGJcN2hgsC7vt0hd7Xv3Nt3ExEva3jSiEJodDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8N985kTHPLNugtnVOg+RXuGHqT+Zz+SodSw21j8A2XMNGSyAS2qLmGjRtdbzVdfe
	 IFIMulnZKrhgbpw3w3A/wIDLW7jS+0lr7ib7SjYztz4624iM9GPyVasvL+ut1PbsP5
	 GATm09kiT/gS55onS8uWpLtxEReQqqli+IZv1Yy9PgkTsUWUEC0/zWoIWjaqVIVhco
	 SkIA3BmQ+Qhzd2LQH9Ep7QagVHdJoHE7Ob0JsgkdtSsXlR4nkYf283TsM9C81gdIQ2
	 5WVhkuIH1cek7XJyrnqpNFcrBlNvDicGrWLCZv53/xtUyuqeVZlNXH4XKH4CTgNd7Z
	 8s9kw2QnTs+AQ==
Date: Fri, 18 Jul 2025 12:22:04 +0100
From: Will Deacon <will@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Oza Pawandeep <quic_poza@quicinc.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 06/13] arm64: Handle KCOV __init vs inline mismatches
Message-ID: <aHouXI5-tyQw78Ht@willie-the-truck>
References: <20250717231756.make.423-kees@kernel.org>
 <20250717232519.2984886-6-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717232519.2984886-6-kees@kernel.org>

Hey Kees,

On Thu, Jul 17, 2025 at 04:25:11PM -0700, Kees Cook wrote:
> When KCOV is enabled all functions get instrumented, unless
> the __no_sanitize_coverage attribute is used. To prepare for
> __no_sanitize_coverage being applied to __init functions, we
> have to handle differences in how GCC's inline optimizations get
> resolved. For arm64 this requires forcing one function to be inline
> with __always_inline.

Please can you spell out the issue a bit more here? From the description
you've given, I can't figure out why acpi_get_enable_method() is the
only function that needs fixing up so I worry that this could be
fragile.

Thanks,

Will

