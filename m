Return-Path: <linux-kselftest+bounces-39866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96BB3496A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 19:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2672A5E94
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A260305E29;
	Mon, 25 Aug 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIeNjfNj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6EC23FC49;
	Mon, 25 Aug 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144566; cv=none; b=b83Q2hBpnkhwxfNzRMCs6V3kCQpMHmWr4RU5SO7mwYUOMtUpM4MtU1YWAXYK0EUWf1ps+rf4RnevBJ+GQAS6p2OtIH5N9+3UVVBuIEv8UW8amhKDfhBi2iYG5RQ3Pmat/SgqWhCM8kKFGasj26+AwRZU/A80ZM4T11MZIAsqukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144566; c=relaxed/simple;
	bh=Sqcd8MEqSlMASqnsEkumIOPR2m+rpUpw+A+V+vT4TsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKbPNn0w9eXJbwWFCnT/WT1Fn4gh2jNi4WKDZkMg8tlWU87Hs7Q5rGfvjdwqqBUeLjZVCrbxxUJO5QVUTHU6le/qGGOYkJQ1jpFaw/J9d9mjRD9n/UZu03thT2SDsEs6yIodxt/22CvAADijt89bJ7WCspNE8XSRiNKQLg/dDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIeNjfNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FF2C4CEED;
	Mon, 25 Aug 2025 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756144565;
	bh=Sqcd8MEqSlMASqnsEkumIOPR2m+rpUpw+A+V+vT4TsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIeNjfNj00zeKgf0Og7lA2loxROwUE3fH6uOMDJ3K+jDI83IgjRxdaOjzu7ljogBP
	 J6Px4d+nA+xR9ahivgOI9TcsYxAEG/3h+8ZXoUg5b+e8MJSYLZ5Fobb2m4nvFq2PQ9
	 OTCZ6DfeEgM5dHrvrKr2n6BQRyg02zOA3ld/PkEks+akE61w+fZHRv0vhb4mjTu7/f
	 ++Gp+qHy2gd0W5MZSepJs4JrSjM0UjjP9PQ3XVqx6de++TjWiaeOa17UVx3C93JmgU
	 if6kvhKq28ZUDUW2qbTNJrWLhAlPH1eYrl8lSaN5MpCEzs68Q4icvOZlR55xUVI5rG
	 vmYA4uQgtTmEg==
Date: Mon, 25 Aug 2025 10:56:05 -0700
From: Kees Cook <kees@kernel.org>
To: Wake Liu <wakel@google.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: improve backwards compatibility for
 older kernels
Message-ID: <202508251051.E222C34D2F@keescook>
References: <20250807174613.1895006-1-wakel@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807174613.1895006-1-wakel@google.com>

On Fri, Aug 08, 2025 at 01:46:13AM +0800, Wake Liu wrote:
> This commit introduces checks for kernel version and seccomp filter flag
> support to the seccomp selftests. It also includes conditional header
> inclusions using __GLIBC_PREREQ.
> 
> Some tests were gated by kernel version, and adjustments were made for
> flags introduced after kernel 5.4. This ensures the selftests can run
> and pass correctly on kernel versions 5.4 and later, preventing failures
> due to features not present in older kernels.
> 
> The use of __GLIBC_PREREQ ensures proper compilation and functionality
> across different glibc versions in a mainline Linux kernel context.
> While it might appear redundant in specific build environments due to
> global overrides, it is crucial for upstream correctness and portability.
> 
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 108 ++++++++++++++++--
>  1 file changed, 99 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 61acbd45ffaa..9b660cff5a4a 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -13,12 +13,14 @@
>   * we need to use the kernel's siginfo.h file and trick glibc
>   * into accepting it.
>   */
> +#if defined(__GLIBC__) && defined(__GLIBC_PREREQ)
>  #if !__GLIBC_PREREQ(2, 26)
>  # include <asm/siginfo.h>
>  # define __have_siginfo_t 1
>  # define __have_sigval_t 1
>  # define __have_sigevent_t 1
>  #endif
> +#endif
>  
>  #include <errno.h>
>  #include <linux/filter.h>
> @@ -300,6 +302,26 @@ int seccomp(unsigned int op, unsigned int flags, void *args)
>  }
>  #endif
>  
> +int seccomp_flag_supported(int flag)
> +{
> +	/*
> +	 * Probes if a seccomp filter flag is supported by the kernel.
> +	 *
> +	 * When an unsupported flag is passed to seccomp(SECCOMP_SET_MODE_FILTER, ...),
> +	 * the kernel returns EINVAL.
> +	 *
> +	 * When a supported flag is passed, the kernel proceeds to validate the
> +	 * filter program pointer. By passing NULL for the filter program,
> +	 * the kernel attempts to dereference a bad address, resulting in EFAULT.
> +	 *
> +	 * Therefore, checking for EFAULT indicates that the flag itself was
> +	 * recognized and supported by the kernel.
> +	 */
> +	if (seccomp(SECCOMP_SET_MODE_FILTER, flag, NULL) == -1 && errno == EFAULT)
> +		return 1;
> +	return 0;
> +}

I like this!

> +
>  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>  #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
>  #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> @@ -2436,13 +2458,12 @@ TEST(detect_seccomp_filter_flags)
>  		ASSERT_NE(ENOSYS, errno) {
>  			TH_LOG("Kernel does not support seccomp syscall!");
>  		}
> -		EXPECT_EQ(-1, ret);
> -		EXPECT_EQ(EFAULT, errno) {
> -			TH_LOG("Failed to detect that a known-good filter flag (0x%X) is supported!",
> -			       flag);
> -		}
>  
> -		all_flags |= flag;
> +		if (seccomp_flag_supported(flag))
> +			all_flags |= flag;
> +		else
> +			TH_LOG("Filter flag (0x%X) is not found to be supported!",
> +			       flag);

So I've pushed back on "backward compatible" changes to this selftest
because I want it to be validating the _latest_ seccomp. This allows for
expected flags to be missing.

Is there perhaps a way that the backward compat checking could be a
commandline flag or something? That way by default it looks strictly the
more current seccomp features.

-Kees

-- 
Kees Cook

