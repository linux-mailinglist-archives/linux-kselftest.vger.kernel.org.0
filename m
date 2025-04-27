Return-Path: <linux-kselftest+bounces-31742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70617A9E489
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 22:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC043BAF73
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 20:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D52C1DE4CE;
	Sun, 27 Apr 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNlFUp2Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133A8BEE;
	Sun, 27 Apr 2025 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745784564; cv=none; b=lCwUpzijZeDZmVdKJP9L2hUwUVPpfN9OgLhXfwBbjfKdfjskqvYj/2Ih7laEZfQk5+d+MMA/rJOyArsfhvfo2xr3usuuKAFzwIjiOZOQh9mnG6ZImHIFX6+07HZ6r4LnhRsDCuLjvs73AoUkVU8tlFmHHmjSg2k96qOFcpqsgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745784564; c=relaxed/simple;
	bh=cyAWRy1ZItg2HcrNetKV+vqy8St8eP2ZUjTcuYHJSuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNi7JHAbugVHq0Z1/rD4PGlENWjktb6wj5cpvf41NR6bn2ne1J7gBl0HF6XLATvQUQ6io8xcZRVmMgT2QdexCJGMv2CwL9b2Ix9k3gNnNtjd3PzxZ3Wfk4M5R+BraVRdo+8qCSQMumcgPfbZQ5LGt8El9OPnw8Uw+RfB4aubL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNlFUp2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F41C4CEE3;
	Sun, 27 Apr 2025 20:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745784562;
	bh=cyAWRy1ZItg2HcrNetKV+vqy8St8eP2ZUjTcuYHJSuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNlFUp2Z/aHDfUR9EcugJDhm6avbnRDcqssCOsKkEWGUJChDTURDuskwMVd7B4tKZ
	 RgLHmyI5w0h/NzWB/ggewk25bwxUfq1Hw0bASvmIk7nSLs/+UaX44Vsv2z7Q9kwg64
	 IQcHyx5hR3dAzbrRdKyrjp1fi4z3+8oW3kzRhxQsekbW2zmBxd1V/FQ/bTUKGJfx7+
	 cqWUtIAyANF3UOcpGQM5WkzEbNcNwBSgy/4xAVPCBjm5fdSBX03U6FKav/ZYYVqsHZ
	 yLqmEI1RbG3gthaN5RmSB0VgD8HGKXUtxO5pdvW/XVxPQ3x4cd0zasXQoQHGfAfn7u
	 GjcNkllx2ccVA==
Date: Sun, 27 Apr 2025 16:09:16 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Cc: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, rust-for-linux@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Laight <david.laight.linux@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, x86@kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kunit: fix longest symbol length test
Message-ID: <20250427200916.GA1661412@ax162>
References: <20250427191009.6179-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250427191009.6179-1-sergio.collado@gmail.com>

Hi Sergio,

On Sun, Apr 27, 2025 at 09:10:09PM +0200, Sergio González Collado wrote:
> The kunit test that checks the longests symbol length [1], has triggered
> warnings in some CI pilelines when symbol prefixes are used [2]. The test
> is adjusted to depend on !CONFIG_PREFIX_SYMBOLS as sujested in [3].
> 
> [1] https://lore.kernel.org/rust-for-linux/CABVgOSm=5Q0fM6neBhxSbOUHBgNzmwf2V22vsYC10YRBT=kN1g@mail.gmail.com/T/#t
> [2] https://lore.kernel.org/all/20250328112156.2614513-1-arnd@kernel.org/T/#u
> [3] https://lore.kernel.org/all/ycgbf7jcq7nc62ndqiynogt6hkabgl3hld4uyelgo7rksylf32@oysq7jpchtp4/
> 
> Fixes: c104c16073b7 ("Kunit to check the longest symbol length")
> Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
> ---
>  lib/Kconfig.debug                | 2 +-
>  lib/tests/longest_symbol_kunit.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f9051ab610d5..6937dedce04d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2885,7 +2885,7 @@ config FORTIFY_KUNIT_TEST
>  
>  config LONGEST_SYM_KUNIT_TEST
>  	tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
> -	depends on KUNIT && KPROBES
> +	depends on KUNIT && KPROBES && !CONFIG_PREFIX_SYMBOLS

This should be !PREFIX_SYMBOLS, otherwise it would be looking for a
CONFIG_CONFIG_PREFIX_SYMBOLS not to exist, which will always be true.

This solution does not appear to take into account Peter's comment
around how kCFI will prefix these symbols as well? Should it depend on
!CFI_CLANG as well?

https://lore.kernel.org/20250411065054.GM9833@noisy.programming.kicks-ass.net/

>  	default KUNIT_ALL_TESTS
>  	help
>  	  Tests the longest symbol possible
> diff --git a/lib/tests/longest_symbol_kunit.c b/lib/tests/longest_symbol_kunit.c
> index e3c28ff1807f..b183fb92d1b2 100644
> --- a/lib/tests/longest_symbol_kunit.c
> +++ b/lib/tests/longest_symbol_kunit.c
> @@ -3,8 +3,7 @@
>   * Test the longest symbol length. Execute with:
>   *  ./tools/testing/kunit/kunit.py run longest-symbol
>   *  --arch=x86_64 --kconfig_add CONFIG_KPROBES=y --kconfig_add CONFIG_MODULES=y
> - *  --kconfig_add CONFIG_RETPOLINE=n --kconfig_add CONFIG_CFI_CLANG=n
> - *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=n
> + *  --kconfig_add CONFIG_CPU_MITIGATIONS=n
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> base-commit: f1a3944c860b0615d0513110d8cf62bb94adbb41
> -- 
> 2.39.2
> 

