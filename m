Return-Path: <linux-kselftest+bounces-7997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79768A56A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 17:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619F6283660
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6A279945;
	Mon, 15 Apr 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCY/+aPN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31529414;
	Mon, 15 Apr 2024 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195670; cv=none; b=SfcWY8DshH3Dw8jX1SuxGiM8tHHbL5BaIq1+llL/BJs8E8Alj2MBAe9IhvH8Q45mwSvM3V04B8OkVoPk6Bqqo/yw/rXJFluColOMpZTDnWx3G1TY3NwrnyO14X2nO/Ub3E5ZQRAfczdk5CSmrzvCwL3V5aIi2xBZQtP0lfOzKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195670; c=relaxed/simple;
	bh=N2K0841GuIJ8SV/t+zW+SSNdUh4znSgAVrClu7AbEKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKN29OQw20apaVWaEh0raW3GYe6Y9rXOexyQ8z1tobha4DcaUj3l8TBmXRjsVoQVZGw2T/3QH60KH6C6rD8NK+dbhYz4q07mBIeiIdVvC6q8j1+5j81bDmECnN5CYnnJKc9RPtYZAh2qkqo/Rs8jI6B9LszvhUH0XSi2itn2y/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCY/+aPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F40C2BD10;
	Mon, 15 Apr 2024 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713195669;
	bh=N2K0841GuIJ8SV/t+zW+SSNdUh4znSgAVrClu7AbEKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCY/+aPNDzJ3kJ0ach2dL/tLmcZjIQh+avVO7xzHj1/b2dgaU+m8zBywLawHqUTid
	 Xk5dnjF85kQCG+Vxq49+wj9+qoNNF+j8YbexTvtUrW7LWE37UGgLM1Q0OrH/sujYTB
	 kEwHOh5+tu9UTJEGwgCeRBvfyJ9CYr6QJuVNr54i+U9etjkKf5fea/8wRcl5TY2W9i
	 lN4u3LYkAEGJDwZOwJoyQkMgIAqVfVEEF3Oi5TDeFLipa0vnK5uVRXAbAutJ1ZDWnC
	 TtWt1ppQJUeKPo0dzmjvuRiPxC6vDJ9yBN5iK/NYa3Iu4K8B7JZXjj6TYyKsPbuXfp
	 5HJuEnQIk2MdQ==
Date: Mon, 15 Apr 2024 08:41:07 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, kernel@collabora.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: Mark ksft_exit_fail_perror() as __noreturn
Message-ID: <20240415154107.GA1538232@dev-arch.thelio-3990X>
References: <20240414062653.666919-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414062653.666919-1-usama.anjum@collabora.com>

On Sun, Apr 14, 2024 at 11:26:53AM +0500, Muhammad Usama Anjum wrote:
> Let the compilers (clang) know that this function would just call
> exit() and would never return. It is needed to avoid false positive
> static analysis errors. All similar functions calling exit()
> unconditionally have been marked as __noreturn.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> This patch has been suggested [1] and tested on top of the following
> patches:
> - f07041728422 ("selftests: add ksft_exit_fail_perror()") which is
>   in kselftest tree already
> - ("kselftest: Mark functions that unconditionally call exit() as
>   __noreturn") would appear in tip/timers/urgent
> 
> [1] https://lore.kernel.org/all/8254ab4d-9cb6-402e-80dd-d9ec70d77de5@linuxfoundation.org
> ---
>  tools/testing/selftests/kselftest.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 050c5fd018400..b43a7a7ca4b40 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -372,7 +372,7 @@ static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
>  	exit(KSFT_FAIL);
>  }
>  
> -static inline void ksft_exit_fail_perror(const char *msg)
> +static inline __noreturn void ksft_exit_fail_perror(const char *msg)
>  {
>  #ifndef NOLIBC
>  	ksft_exit_fail_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
> -- 
> 2.39.2
> 
> 

