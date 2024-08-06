Return-Path: <linux-kselftest+bounces-14827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F639948831
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 06:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E39B21B14
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 04:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20E31BA885;
	Tue,  6 Aug 2024 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV67uOxS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78CF13BC11;
	Tue,  6 Aug 2024 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722917162; cv=none; b=Bo66vBUcfCiLMsS5tmxO9SJfgExbf+HxumhBwmGCevRLVOEdbUkjQOkdr7Tks2z+Nz2Hfpv7Mi/PSgimidTlBQv3osItVEcAuA1tG+351fOUBjpp1tcL6WJwdnrbigbTZSbJ+U7NptdLwqoYgRxKDXhl1/94uSN09Zq2sy/A0TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722917162; c=relaxed/simple;
	bh=zthMYi5whGTYCixA97k0CFISLk8x5aAZu/+fkQBgnQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U37fWAWi6hofwVxdVwbk1bLGz1HPcYfPzzfCOnubj/ZW1u9p0OiKj2xS9ALVZRu7Rqq/YsgQNHtiZ6+H5FntxLBaklhdzqz7WF5/u+TnBo9JnCGBDk0lLbkcJBCQVoMP3lPtUVg7za45AWfDMgFZIpr9x53mzUMbF3OF9Urgj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV67uOxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD9DC32786;
	Tue,  6 Aug 2024 04:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722917162;
	bh=zthMYi5whGTYCixA97k0CFISLk8x5aAZu/+fkQBgnQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iV67uOxSzYlDEdHVyJvBogitQzZlH7yc+aVnTQBAuCHSzBOCUrWzcZ+NcSeyEIwou
	 lL8gZ4PHKKiftK9Mbwu9xRMf4g8OkG/+m4q64OobQDk5iQnnSBOK+MlSl/Ws0NnEm7
	 aT1L74f/wHpR8Etmye8p5c238aEeA8O4/WAuZiwCm6ZTtpdGhcOxMimD7iJJ+bsheQ
	 1G2spWE/zhJj7NIcnbv4sjcHyN5eHLLJqB9o/iH/6tIs+JeMqVe0I/FVK79r11jMKf
	 zsBRM7eBqYa9SwxAltIEuhIjAgu7SpT+U7nzM3GQJTeZhjK0A2R/QSeHom/SWqG6uD
	 z/HFZv+oGpXBg==
Date: Mon, 5 Aug 2024 21:06:01 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>, Nico Pache <npache@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: Fix kunit_kstrdup_const() with modules
Message-ID: <202408052100.74A2316C27@keescook>
References: <20240806020136.3481593-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806020136.3481593-1-davidgow@google.com>

On Tue, Aug 06, 2024 at 10:01:34AM +0800, David Gow wrote:
> In commit 7d3c33b290b1 ("kunit: Device wrappers should also manage driver name"),
> the kunit_kstrdup_const() and kunit_kfree_const() were introduced as an
> optimisation of kunit_kstrdup(), which only copy/free strings from the
> kernel rodata.
> 
> However, these are inline functions, and is_kernel_rodata() only works
> for built-in code. This causes problems in two cases:
> - If kunit is built as a module, __{start,end}_rodata is not defined.
> - If a kunit test using these functions is built as a module, it will
>   suffer the same fate.
> 
> Restrict the is_kernel_rodata() case to when KUnit is built as a module,
> which fixes the first case, at the cost of losing the optimisation.
> 
> Also, make kunit_{kstrdup,kfree}_const non-inline, so that other modules
> using them will not accidentally depend on is_kernel_rodata(). If KUnit
> is built-in, they'll benefit from the optimisation, if KUnit is not,
> they won't, but the string will be properly duplicated.

I wonder if this series should be refreshed:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/hardening/is_rodata

We gained is_kernel_rodata() and is_kernel_ro_after_init() since this
original proposal, which is what the proposed core_kernel_rodata()
checks.

It adds a is_module_rodata...() check, so with the is_kernel_*() checks,
it's possible to do a check across the entire kernel and all modules.

-Kees

> 
> (And fix a couple of typos in the doc comment, too.)
> 
> Reported-by: Nico Pache <npache@redhat.com>
> Closes: https://lore.kernel.org/all/CAA1CXcDKht4vOL-acxrARbm6JhGna8_k8wjYJ-vHONink8aZ=w@mail.gmail.com/
> Fixes: 7d3c33b290b1 ("kunit: Device wrappers should also manage driver name")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  include/kunit/test.h | 16 +++-------------
>  lib/kunit/test.c     | 19 +++++++++++++++++++
>  2 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index da9e84de14c0..5ac237c949a0 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -489,11 +489,7 @@ static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp
>   * Calls kunit_kfree() only if @x is not in .rodata section.
>   * See kunit_kstrdup_const() for more information.
>   */
> -static inline void kunit_kfree_const(struct kunit *test, const void *x)
> -{
> -	if (!is_kernel_rodata((unsigned long)x))
> -		kunit_kfree(test, x);
> -}
> +void kunit_kfree_const(struct kunit *test, const void *x);
>  
>  /**
>   * kunit_kstrdup() - Duplicates a string into a test managed allocation.
> @@ -527,16 +523,10 @@ static inline char *kunit_kstrdup(struct kunit *test, const char *str, gfp_t gfp
>   * @gfp: flags passed to underlying kmalloc().
>   *
>   * Calls kunit_kstrdup() only if @str is not in the rodata section. Must be freed with
> - * kunit_free_const() -- not kunit_free().
> + * kunit_kfree_const() -- not kunit_kfree().
>   * See kstrdup_const() and kunit_kmalloc_array() for more information.
>   */
> -static inline const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp)
> -{
> -	if (is_kernel_rodata((unsigned long)str))
> -		return str;
> -
> -	return kunit_kstrdup(test, str, gfp);
> -}
> +const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp);
>  
>  /**
>   * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index e8b1b52a19ab..089c832e3cdb 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -874,6 +874,25 @@ void kunit_kfree(struct kunit *test, const void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(kunit_kfree);
>  
> +void kunit_kfree_const(struct kunit *test, const void *x)
> +{
> +#if !IS_MODULE(CONFIG_KUNIT)
> +	if (!is_kernel_rodata((unsigned long)x))
> +#endif
> +		kunit_kfree(test, x);
> +}
> +EXPORT_SYMBOL_GPL(kunit_kfree_const);
> +
> +const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp)
> +{
> +#if !IS_MODULE(CONFIG_KUNIT)
> +	if (is_kernel_rodata((unsigned long)str))
> +		return str;
> +#endif
> +	return kunit_kstrdup(test, str, gfp);
> +}
> +EXPORT_SYMBOL_GPL(kunit_kstrdup_const);
> +
>  void kunit_cleanup(struct kunit *test)
>  {
>  	struct kunit_resource *res;
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
> 

-- 
Kees Cook

