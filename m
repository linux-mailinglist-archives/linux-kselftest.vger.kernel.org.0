Return-Path: <linux-kselftest+bounces-11235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A14468FC367
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 08:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFA7282907
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 06:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6D921C19F;
	Wed,  5 Jun 2024 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZiIOGz4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E63DABE7;
	Wed,  5 Jun 2024 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717568834; cv=none; b=lcGyltRD/aWY4cO8eY5blCtyhoC9xjiq5bsosthsqhVxXQr8xV2ZISwoDeqH3qMnMdI5IzzJel6YLaGkcAikOpJ/3hBWvkaCl9JfT4b3Lim9VX/OZ3aXkq8cVdc9CXiZZ11/XWPZ3rsvtXQ4A+09pBjIRvlR9l7DdiIX4FVc924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717568834; c=relaxed/simple;
	bh=Wd9zHKEWoslbcFRSGouPKc8Ft0c6guz9BhPzn40/nuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPPDug9y700z4G+rSZlMdObwzDSeKg8viWBSXMp6aIIaYYY/Tk9R5KKatjOtSm6u0I2HaWGr/fiX6XAVvfMlBPpP+zGHa+YMhGKdoDAd6p/6vxpCeyeO49LctMPvwDLKzW1EUjTNoML+61NBCG1WxD6n22VUHtCLMNM/A9IdSz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZiIOGz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7580BC3277B;
	Wed,  5 Jun 2024 06:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717568834;
	bh=Wd9zHKEWoslbcFRSGouPKc8Ft0c6guz9BhPzn40/nuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZiIOGz4mAcMqlnKuBer+zLB4OUW3wdfc5gosaOSBEw1eL/POE2vzP7s0WNUWMtHV
	 NENT1uic9AFL30H5ImFRf+cc48gSmBZiGejFv69bhfZEv704LjBZ3170vgq3QZB3kq
	 ve2nk3H4BVGOkx0JY1pyez7Qws7SWdYg/1qU0/0zF9Wx6IDGDm9l+uKPXI3JDSzuaB
	 wWnont51qD49rNlt3+HwY+R5H2PQCLFdaYLFxvGplL62pD6yl3wRyujWW+sEmY6ype
	 GD3RV4aM/E9Ig3RfZOwqQJnXys9jE9ef5xvFiEitlcrlAwGk8pE6VrjT0wfBlko3oO
	 jqGnnh1ga6tRw==
Date: Tue, 4 Jun 2024 23:27:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/timers: Guard LONG_MAX / LONG_MIN defines
Message-ID: <20240605062711.GG279426@thelio-3990X>
References: <20240604231219.444603-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604231219.444603-1-edliaw@google.com>

On Tue, Jun 04, 2024 at 11:12:18PM +0000, Edward Liaw wrote:
> Add ifndef guards around LONG_MAX / LONG_MIN defines. When building with
> Android bionic, these macros are redefined because bionic's time.h will
> include linux/time.h, which includes limit.h.
> 
> INFO: From Compiling common/tools/testing/selftests/timers/valid-adjtimex.c:
> common/tools/testing/selftests/timers/valid-adjtimex.c:107:9: warning: 'LONG_MAX' macro redefined [-Wmacro-redefined]
>   107 | #define LONG_MAX (~0UL>>1)
>       |         ^
> prebuilts/clang/host/linux-x86/clang-r522817/lib/clang/18/include/limits.h:47:9: note: previous definition is here
>    47 | #define LONG_MAX  __LONG_MAX__
>       |         ^
> common/tools/testing/selftests/timers/valid-adjtimex.c:108:9: warning: 'LONG_MIN' macro redefined [-Wmacro-redefined]
>   108 | #define LONG_MIN (-LONG_MAX - 1)
>       |         ^
> prebuilts/clang/host/linux-x86/clang-r522817/lib/clang/18/include/limits.h:52:9: note: previous definition is here
>    52 | #define LONG_MIN  (-__LONG_MAX__ -1L)
>       |         ^
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  tools/testing/selftests/timers/valid-adjtimex.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
> index d500884801d8..3d9f1baff86e 100644
> --- a/tools/testing/selftests/timers/valid-adjtimex.c
> +++ b/tools/testing/selftests/timers/valid-adjtimex.c
> @@ -102,8 +102,12 @@ long outofrange_freq[NUM_FREQ_OUTOFRANGE] = {
>  	 1000 * SHIFTED_PPM,
>  };
>  
> +#ifndef LONG_MAX
>  #define LONG_MAX (~0UL>>1)
> +#endif
> +#ifndef LONG_MIN
>  #define LONG_MIN (-LONG_MAX - 1)
> +#endif
>  
>  long invalid_freq[NUM_FREQ_INVALID] = {
>  	LONG_MAX,
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 

