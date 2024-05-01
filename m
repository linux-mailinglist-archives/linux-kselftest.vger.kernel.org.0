Return-Path: <linux-kselftest+bounces-9215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DBA8B8C95
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 17:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5638A1F228DC
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F72A131E24;
	Wed,  1 May 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgn55JcK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575713175F;
	Wed,  1 May 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576426; cv=none; b=cAmUBiy57DHdlcnkOe7ciIllkQdcT/XR4Q6HyjQNxv5oopFwU6m2Rn8mRv78DZezKb3zPk+lWgTRNWrdBn3ZYEoRNHx0aGmt7K7xIvXaw54vQrsp1UX2yauU1dJvs3ttkjcqgxE0weJwYhXe8BlBkdp2Xc/WFZh55raIwM8eD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576426; c=relaxed/simple;
	bh=YBjLSMIppWafWg7KldsTZKrs4eG5nttTEthhu+OXRyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boJGeukFb7N+UW2BBSGVsIxTwEitqj8GGT+ENrVjMtX+GmbGFRrWwRwfY8ykEL4txzG37bJC6lNohGpaeQKDx+PKb2WdrwiPK9fGO/uPp3B4L9E/gfjLF8pWhrRyQb/wrsLY5Wndu306inJxHpwUZPl5V/WSGkqsGC1EKqRsPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgn55JcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00153C113CC;
	Wed,  1 May 2024 15:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714576425;
	bh=YBjLSMIppWafWg7KldsTZKrs4eG5nttTEthhu+OXRyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgn55JcKpxb0pLy4qCshQKV2X7q87m847hTuD9aQU5FueGeUjKn1Ewd1x6Fo+tFBn
	 3nf/SbivuIkR97d5ZJe9t1Ux0gtgcFkXcJzYW4o3JXODsxdpWQgRDzPvRUPV9grzXp
	 cQCzyox8PXtHPaou1zC3L7V5TYuKeuLLlPaVVI1QrVbT8dmv/feK/hBr8IdjS7I9Pg
	 sTchsz/A3n3RoeSu6av8EHHa53C+nTj3apISSqsfkTNUgIlAgbiSyk2uGrbhNyWrkD
	 SKWOnfmtdl+v8gfZAbF+ppCC9hJ835PC+7dw24BFM9oiZ7fVQpQjDPaXkYb7boa5Uk
	 ocDWzBfVLm/HA==
Date: Wed, 1 May 2024 08:13:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	Kees Cook <keescook@chromium.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>
Subject: Re: [PATCH] selftests/harness: fix many "format string is empty"
 warnings
Message-ID: <20240501151343.GA1018661@dev-arch.thelio-3990X>
References: <20240501020813.264878-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501020813.264878-1-jhubbard@nvidia.com>

Hi John,

On Tue, Apr 30, 2024 at 07:08:13PM -0700, John Hubbard wrote:
> In order to build with clang at all, in order to see these symptoms, one
> must first apply Valentin Obst's build fix for LLVM [1]. Once that is
> done, then when building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...clang emits a "format string is empty" warning. (gcc also emits a
> similar warning.)

The warning you are describing here sounds like the same exact one that
commit caed8eba2215 ("selftests: kselftest_harness: fix Clang warning
about zero-length format") should have addressed in 6.9-rc5. Is this
patch actually necessary?

> Fix by passing NULL, instead of "", for the msg argument to

Because this text is describing what was done in caed8eba2215...

> ksft_test_result_code(). This removes dozens of warnings and a few
> errors (some tests have -Werror set).
>
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> 
> Cc: Valentin Obst <kernel@valentinobst.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  tools/testing/selftests/kselftest_harness.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index d98702b6955d..456b8694e678 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -1207,8 +1207,10 @@ void __run_test(struct __fixture_metadata *f,
>  	else
>  		diagnostic = "unknown";
>  
> -	ksft_test_result_code(t->exit_code, test_name,
> -			      diagnostic ? "%s" : NULL, diagnostic);
> +	if (diagnostic)
> +		ksft_test_result_code(t->exit_code, test_name, "%s", diagnostic);
> +	else
> +		ksft_test_result_code(t->exit_code, test_name, NULL);

but this diff is not doing that because it is based on a tree that has
caed8eba2215; instead, it appears to be a completely identical
transformation?

Cheers,
Nathan

>  	free(test_name);
>  }
>  
> 
> base-commit: 18daea77cca626f590fb140fc11e3a43c5d41354
> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
> -- 
> 2.45.0
> 

