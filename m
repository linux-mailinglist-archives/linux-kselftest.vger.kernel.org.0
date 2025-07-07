Return-Path: <linux-kselftest+bounces-36678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E653CAFAFE8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 11:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D416B046
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B4C28C2B6;
	Mon,  7 Jul 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VOKYxamp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB7428A3F7;
	Mon,  7 Jul 2025 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881125; cv=none; b=nMXfzyPYMHrJDVg2E/MySyk3JhPmaX2gfeFXzrpWX0JrN5NY2cDDUF48XNtnmAd+sDcOzfG7DSj3qkRllw159FGnOtfqpNiDy+gHi3w7XrLFeqmH5PiJL2WV1tvL0nE81Ww0nUJp71GGZNjoJoq3xrg24TxalKZyxEAZqOSQHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881125; c=relaxed/simple;
	bh=eGMGtY8ZcvE6kdxR6zf4DXyrCWsxcR1zoU1mF8oQHX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjFEgNXx7dnngEVE+PIIW+YSWWzo9BNselKW/PDoba4XBh+k1bDVtt9aBJ3Tt17ozU4IPF4OoJpeXXDbgSL82p2HtpM7BGlOaI+ixvGwhRyUhe+8b4G0M3kxLl5jzkqc9FSbrUeo2MWwSytk+GWJaDB+NtD6ipJi88KJ8ZloJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VOKYxamp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bnHKyhC36yAuLX6uSscvM/f8yvBTgryKRaB9hZf72J0=; b=VOKYxampysmmx2FpOmvFeZFZXE
	XcNrfBP8l94SJG34Dudptd7RmDgg37N4vlfUEQib8MprbM9hkVELnKTysNyRPiBPOjvM+DTEH/N6T
	nfvaueNhTRCbMKthYwv7UlRPJcwmGOPr6x8eGOTCI8cUTr8E1t/l5dmnSg54clW0O+Ly8jO4wHNet
	lXxAXneCdBKL6B5tbqTGgbK2dKchFD8x5NsIXnDTawEj9SD2J0zJjIK5C3v4kYQg5q1dRzrBbEzme
	C2LYaSPsFWP3CPkbFdC3jiw0lHFsHzq1UL/4s85SZju3E0a5iErt128zyI5yEFDZeFOXVadcqDM1e
	IF0X/RtQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYiJ2-00000008Rd3-3z0o;
	Mon, 07 Jul 2025 09:38:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 689DD300399; Mon, 07 Jul 2025 11:38:36 +0200 (CEST)
Date: Mon, 7 Jul 2025 11:38:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Cc: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
	rust-for-linux@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nathan Chancellor <nathan@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, x86@kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] kunit: fix longest symbol length test
Message-ID: <20250707093836.GC1099709@noisy.programming.kicks-ass.net>
References: <20250706201855.232451-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250706201855.232451-1-sergio.collado@gmail.com>

On Sun, Jul 06, 2025 at 10:18:55PM +0200, Sergio González Collado wrote:
> The kunit test that checks the longests symbol length [1], has triggered
> warnings in some pilelines when symbol prefixes are used [2][3]. The test
> will to depend on !PREFIX_SYMBOLS and !CFI_CLANG as sujested in [4] and
> on !GCOV_KERNEL.
> 
> [1] https://lore.kernel.org/rust-for-linux/CABVgOSm=5Q0fM6neBhxSbOUHBgNzmwf2V22vsYC10YRBT=kN1g@mail.gmail.com/T/#t
> [2] https://lore.kernel.org/all/20250328112156.2614513-1-arnd@kernel.org/T/#u
> [3] https://lore.kernel.org/rust-for-linux/bbd03b37-c4d9-4a92-9be2-75aaf8c19815@infradead.org/T/#t
> [4] https://lore.kernel.org/linux-kselftest/20250427200916.GA1661412@ax162/T/#t
> 
> Reviewed-by: Rae Moar <rmoar@google.com>
> Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  lib/Kconfig.debug                | 1 +
>  lib/tests/longest_symbol_kunit.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ebe33181b6e6..4a75a52803b6 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2885,6 +2885,7 @@ config FORTIFY_KUNIT_TEST
>  config LONGEST_SYM_KUNIT_TEST
>  	tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
>  	depends on KUNIT && KPROBES
> +	depends on !PREFIX_SYMBOLS && !CFI_CLANG && !GCOV_KERNEL
>  	default KUNIT_ALL_TESTS
>  	help
>  	  Tests the longest symbol possible
> diff --git a/lib/tests/longest_symbol_kunit.c b/lib/tests/longest_symbol_kunit.c
> index e3c28ff1807f..9b4de3050ba7 100644
> --- a/lib/tests/longest_symbol_kunit.c
> +++ b/lib/tests/longest_symbol_kunit.c
> @@ -3,8 +3,7 @@
>   * Test the longest symbol length. Execute with:
>   *  ./tools/testing/kunit/kunit.py run longest-symbol
>   *  --arch=x86_64 --kconfig_add CONFIG_KPROBES=y --kconfig_add CONFIG_MODULES=y
> - *  --kconfig_add CONFIG_RETPOLINE=n --kconfig_add CONFIG_CFI_CLANG=n
> - *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=n
> + *  --kconfig_add CONFIG_CPU_MITIGATIONS=n --kconfig_add CONFIG_GCOV_KERNEL=n
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> base-commit: 772b78c2abd85586bb90b23adff89f7303c704c7

So this will obviously 'work'. But what I don't understand is the
purpose of this test. Why can't we amend the test itself to use
KSYM_NAME_LEN-8 (or whatever the actual magic value is) and recognise
that we don't have full control over the symbol names; despite using C.

