Return-Path: <linux-kselftest+bounces-37435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A40B07833
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A545A188E7D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D620321D583;
	Wed, 16 Jul 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcLJt75D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE859199EAD;
	Wed, 16 Jul 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676360; cv=none; b=JhwZHlihs3OheHpikYRFpS+z/c2j9ELbIs+gt4rzOqGVKtUAbDQ3Elxv/w8lhUaLSUwk4Nw2Z0U/dQWVq6/4+Z0VANSAGBmqmsg16AuFPlhbtMIPyPTW4czSvl18wSy/0FlK8M3Ifg3INfgA7o/fX4TTvHlIRy8B7YaheGnTz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676360; c=relaxed/simple;
	bh=iJjFq4iVDGYBdl/PZSOEsMEM1mXkUuP5CDCnmv+x5iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBnO7w9f6q3bltZ126l6uZZ0OxKhxc3VzHxvS150iWv3VS5JHbCA9akszSsZIkXg8iCfJPZbgmtAB8mH00lvLssVQ9vPVvBPNiDueWrUTemqOHmDNAFcoVlCmqSzE/EcwvYj+lc7jV+6e4yn7upmq71vfu06oyx8f8bd0i9k8TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcLJt75D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38826C4CEE7;
	Wed, 16 Jul 2025 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752676360;
	bh=iJjFq4iVDGYBdl/PZSOEsMEM1mXkUuP5CDCnmv+x5iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcLJt75D/DW/MlFyAUTWtTUzB6QAiaDZeAAjWqHkfpzfRwXMvVmnqiq1c+u2KcRrF
	 fp3qcx49V/ukjwBn30bsl59TW9WTFpM94EGO34UNpB326jceYocRqUM2Icp4iF0fvG
	 E9L/TtPMXfQo3P6Nw0hA479m31iIu+nR38syDHtNlU0tPo3mThQo0/k7LdusVLxXYb
	 0oWWj0G7+i+WRG6w/+NlfL1iZNhWxOwz2j4zyt0lzhENxneqiIC1aE2U4CpPwfr88w
	 rdbsLKlQeBLycDuEKk8SE1NvhPlyY/agkmXou3M447hBA7K/ssiNDzEBUy2DfAdqra
	 dVK/Je3ytAjQA==
Date: Wed, 16 Jul 2025 07:32:39 -0700
From: Kees Cook <kees@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 3/6] kunit: test: Export kunit_attach_mm()
Message-ID: <202507160731.5F7752691@keescook>
References: <20250714185321.2417234-1-ynaffit@google.com>
 <20250714185321.2417234-4-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714185321.2417234-4-ynaffit@google.com>

On Mon, Jul 14, 2025 at 11:53:16AM -0700, Tiffany Yang wrote:
> Tests can allocate from virtual memory using kunit_vm_mmap(), which
> transparently creates and attaches an mm_struct to the test runner if
> one is not already attached. This is suitable for most cases, except for
> when the code under test must access a task's mm before performing an
> mmap. Expose kunit_attach_mm() as part of the interface for those
> cases. This does not change the existing behavior.
> 
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---
>  include/kunit/test.h   | 12 ++++++++++++
>  lib/kunit/user_alloc.c |  4 ++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 39c768f87dc9..d958ee53050e 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -531,6 +531,18 @@ static inline char *kunit_kstrdup(struct kunit *test, const char *str, gfp_t gfp
>   */
>  const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp);
>  
> +/**
> + * kunit_attach_mm() - Create and attach a new mm if it doesn't already exist.
> + *
> + * Allocates a &struct mm_struct and attaches it to @current. In most cases, call
> + * kunit_vm_mmap() without calling kunit_attach_mm() directly. Only necessary when
> + * code under test accesses the mm before executing the mmap (e.g., to perform
> + * additional initialization beforehand).
> + *
> + * Return: 0 on success, -errno on failure.
> + */

Yay kern-doc! :)

> +int kunit_attach_mm(void);
> +
>  /**
>   * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
>   * @test: The test context object.
> diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
> index 46951be018be..b8cac765e620 100644
> --- a/lib/kunit/user_alloc.c
> +++ b/lib/kunit/user_alloc.c
> @@ -22,8 +22,7 @@ struct kunit_vm_mmap_params {
>  	unsigned long offset;
>  };
>  
> -/* Create and attach a new mm if it doesn't already exist. */
> -static int kunit_attach_mm(void)
> +int kunit_attach_mm(void)
>  {
>  	struct mm_struct *mm;
>  
> @@ -49,6 +48,7 @@ static int kunit_attach_mm(void)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(kunit_attach_mm);
>  
>  static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
>  {
> -- 
> 2.50.0.727.gbf7dc18ff4-goog

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

