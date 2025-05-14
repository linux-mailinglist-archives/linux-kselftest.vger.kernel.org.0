Return-Path: <linux-kselftest+bounces-32969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B3AB777B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 23:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A633AA84E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD5D1DE3D6;
	Wed, 14 May 2025 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lXbo8ag7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCB4315E;
	Wed, 14 May 2025 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256491; cv=none; b=i9I7KqxBmtkZcflwEqjO2BZv6uslUp59s94lLJo9JhR6zZK8wE5cPnOD38tpKvItEWB4MOzPQyB60yt7yeU38LzKgffcehfVL52i/NhNEsSYmD0pCqEjeftBzyA2RY9rHPsxp9WodSnw1f7yCtfGDA4gLS7Oc5P7beKM17ownE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256491; c=relaxed/simple;
	bh=CB3Ad6mgToV6hh1GgMFPiDPcWP/zRFhbDxZnk1Yvo6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajmbWAeMlhCrEgcj9pQoP7e40X0qpFXmKXZi4BvNUtY19FTv8MprM1t2YcFrpNFttFAo/sDSmEu9xtTsb/Mc9Jy1e6p3xf24KqvaX+wc+fyxa9SLdmpfNW3opSiBmm0M5ubh87/or8aOv6nlU0XYWsldaYnGqHvd2AJ95ecIbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lXbo8ag7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=lAIdy454XbaXaej3KXWl+gEwgCrQJzmng6S5f2eeKu4=; b=lXbo8ag7E3PJ8tXHqgv2/o0yu/
	gGllwhzoogkUwxO07aEp4DUs8K354A90TRA3GWGMVifOmgdceXMNJjAS47GAyx5ZuU9VBRGyglJ9a
	F+3IS0VoXjYWvylJfrrolmnCNGAiv3W0BjCi3YUU86Z0xMUZeadK7/xsMomKzM4mH1csf2e+CyG9a
	opkgk8t7rASW/iLfF3SoVnsMZ+lOiLUaDtjUxtSi8ZGFbqlImoG+OraUB/brhgEK1t3UWZ2+Xkt5J
	2BgzuBC4i7c53xBdqxZ3UDd02N/CJnGCey/XVMJY4qT77SiEy9QvnPG3p4FeFHx4UjOzTubHj7Ogu
	8oqNLq4Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uFJDP-0000000HJ2a-2U3u;
	Wed, 14 May 2025 21:01:21 +0000
Message-ID: <30b8e7c2-3a70-4728-b633-b24c99a8d025@infradead.org>
Date: Wed, 14 May 2025 14:00:29 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kunit: fix longest symbol length test
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: rust-for-linux@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 David Laight <david.laight.linux@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>, x86@kernel.org,
 linux-kbuild@vger.kernel.org
References: <20250514192416.12635-1-sergio.collado@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250514192416.12635-1-sergio.collado@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/14/25 12:24 PM, Sergio González Collado wrote:
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


Works for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> v2 -> v3: added dependency on !GCOV_KERNEL (to avoid __gcov_ prefix)
> ---
> v1 -> v2: added dependency on !CFI_CLANG as suggested in [3], removed
> 	CONFIG_ prefix
> ---
>  lib/Kconfig.debug                | 1 +
>  lib/tests/longest_symbol_kunit.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f9051ab610d5..e55c761eae20 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2886,6 +2886,7 @@ config FORTIFY_KUNIT_TEST
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
> base-commit: 1a80a098c606b285fb0a13aa992af4f86da1ff06

-- 
~Randy

