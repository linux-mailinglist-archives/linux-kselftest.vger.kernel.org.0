Return-Path: <linux-kselftest+bounces-48038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36403CEC886
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 21:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04D0D3004CE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 20:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF4B29E0F7;
	Wed, 31 Dec 2025 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RUVkNPRf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149C3A1E63
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767213085; cv=none; b=f/+1OlGENkGEtT36feaf3z6VqEi6my3Xrs5cSfoA6cgeL/5HXAVbPyGLuRqBN2kOUfTdHaOzi4RhgP9jhUbGYO68C8eHa2rzC61LGBHHhkBqtMaMxTTvntZlro9JgzqDzdNRR5dB55aIRiesKr1VKMBE6e5Ebx0zeRQXuyE52Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767213085; c=relaxed/simple;
	bh=rpAyc043Ax5VQr8+dHc0LhLszXtoHwy4eiOIzYipxz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHjWW3VzjnNuj7tt5XLYOqkauvNkqYF+vftyyHXcGl/DzofsauhiEGEY6HLfIzCEdRWMWuuNincqj9tfFNRkOQbP2VmoEs5TXoOUOB3yL/kKPRf8sADy+TK5L5hfZZKDA3PscqpVU99WSA4HOBLo/64CT5wxmtPPR/asr59+uJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RUVkNPRf; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so4004721fac.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 12:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767213082; x=1767817882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CkgP3P/JOmmU4SQIzQRxbAxKStjjkyO+o9UMdLOwKAc=;
        b=RUVkNPRfWqbhfLO854COIcA8bXTFtX6KXcjMzI4zy8s2QmINan+FBFrjzmqtsfosxu
         QKMhMcKmbUKprwQNtYvH0VOUHpkGTGkfUDoyc9Z8AMhrT+Gh7KJC6qcizbkByyMpKZio
         rVQggbpBUDPQdtDiVuJr9lZh/fd2HyYAgeMlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767213082; x=1767817882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkgP3P/JOmmU4SQIzQRxbAxKStjjkyO+o9UMdLOwKAc=;
        b=JhDaP8r22gVLgJTQIlTK6MohYsbi1oaqjHeukIu2d9BPvMpG7GZ5tR67tEKM6WgoNu
         83HOWKrnpSRaPLBmR9Zz40UVXuSd/Q+1ZnK+Ew31J0ybdOAhZ4Ofdlapcly8glls8EY0
         +Ry9mfFh4cpQUpb+B6eSoZ5ojMhrGE5w3K0liuyZqyHe+QujIeK2LGijX/FLPxZ/kXKM
         AVjd43lXGl9YMVaGyEDPiy9bio+fYwcjQ6Bodx+RIYPxH5+FvhgtijVPafNPk+mi6i1i
         NEgDle8jn0ITYuK1A782M/BvtMbnkUupQqxVQA0DeW9qbP7h02pRsko80mpUd6ZNOq4/
         sj8w==
X-Forwarded-Encrypted: i=1; AJvYcCXIFz/hrUaLWGbGcOA9EphTfMi0OI1o9gX5fv5WmGSOOl1ZLlo86LLyP5j1MnwQwYowkCh0YR+HBigf61/HafY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYASWFMpT3JICkkcw201Mrv17eo9AS0hUBFC7bL6zb4ctCofF
	MDu1XNAZoMNWRmq0sU2kW/eyMC68oPWCQRP5J15C9PlevcnfvQVnAZgNNp7VTYmpB0E=
X-Gm-Gg: AY/fxX5a1Q7DovvPIYZYwvGxbU+HrrQ7Ar6axLoOUnwrHPxC5LhOJayVXHOO5tz6DSd
	ymHlAvfR3SwHoaqUwvRHm5TJ9xVKY3llSv49pNG6VSClbNMYutFi+UR0NiH80+EsNhnhJ7R/KCQ
	uMm3gKq7hMjuVpLyjCyolByZnx/ST0FywOnb44rtxgPK21/1hCbE0uh3Zv6sjOOVIEiSfFO6S3G
	AAkH9Amjp2trJEN28WfG/II+NpYBkJzfmeW9YTtqn7EsEtREztNqFvQ5H8IEWXfRWQnfxf3QXBi
	uVAvKRestoH6ndG6vft1KSqNRnXdJ/rRKoVfw8/6f/c38x+jaNZ8lt9daTgJdJYfaasPeDq/j4A
	HAwadp0rPRF/CDSWVnbx8oWp3aYNEbqxMiQaVDdXHOKNMHvDPB+PAp92QxZ5pEsZhtQqPCTzXly
	zPZEJXBp/aERFutRaWKOl3lAtvliN0Me8iYw==
X-Google-Smtp-Source: AGHT+IFZAkPcKJ2uTeFxS+roZ678AbK78d+9mfwo6bn/TTYmxsIJ+R5E5wssgjSFb8Ze3mX//4DEXQ==
X-Received: by 2002:a05:6870:d691:b0:3f5:d9b0:567e with SMTP id 586e51a60fabf-3fda5666a5cmr18296581fac.14.1767213082037;
        Wed, 31 Dec 2025 12:31:22 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaabbadacsm22960637fac.15.2025.12.31.12.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 12:31:21 -0800 (PST)
Message-ID: <3ee8406b-1789-4a18-8637-120fc0c62a99@linuxfoundation.org>
Date: Wed, 31 Dec 2025 13:31:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/harness: Use helper to avoid zero-size memset
 warning
To: Wake Liu <wakel@google.com>, tglx@linutronix.de, kees@kernel.org,
 shuah@kernel.org, nathan@kernel.org
Cc: luto@amacapital.net, wad@chromium.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <871plslxsw.ffs@tglx> <20251224084120.249417-1-wakel@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251224084120.249417-1-wakel@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 01:41, Wake Liu wrote:
> When building kselftests with a toolchain that enables source
> fortification (e.g., Android's build environment, which uses
> -D_FORTIFY_SOURCE=3), a build failure occurs in tests that use an
> empty FIXTURE().
> 
> The root cause is that an empty fixture struct results in
> `sizeof(self_private)` evaluating to 0. The compiler's fortification
> checks then detect the `memset()` call with a compile-time constant size
> of 0, issuing a `-Wuser-defined-warnings` which is promoted to an error
> by `-Werror`.
> 
> An initial attempt to guard the call with `if (sizeof(self_private) > 0)`
> was insufficient. The compiler's static analysis is aggressive enough
> to flag the `memset(..., 0)` pattern before evaluating the conditional,
> thus still triggering the error.
> 
> To resolve this robustly, this change introduces a `static inline`
> helper function, `__kselftest_memset_safe()`. This function wraps the
> size check and the `memset()` call. By replacing the direct `memset()`
> in the `__TEST_F_IMPL` macro with a call to this helper, we create an
> abstraction boundary. This prevents the compiler's static analyzer from
> "seeing" the problematic pattern at the macro expansion site, resolving
> the build failure.
> 
> Build Context:
> Compiler: Android (14488419, +pgo, +bolt, +lto, +mlgo, based on r584948) clang version 22.0.0 (https://android.googlesource.com/toolchain/llvm-project 2d65e4108033380e6fe8e08b1f1826cd2bfb0c99)
> Relevant Options: -O2 -Wall -Werror -D_FORTIFY_SOURCE=3 -target i686-linux-android10000
> 
> Test: m kselftest_futex_futex_requeue_pi
> 
> Change-Id: If4fdfe6ffcbe9736fbd8f66b2453e8cbbb95e25e

I removed this before applying. In the future remove these
before sending the patch - running checkpatch.pl prompts
you to remove it.

> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>   tools/testing/selftests/kselftest_harness.h | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 3f66e862e83eb..159cd6729af33 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -70,6 +70,12 @@
>   
>   #include "kselftest.h"
>   
> +static inline void __kselftest_memset_safe(void *s, int c, size_t n)
> +{
> +	if (n > 0)
> +		memset(s, c, n);
> +}
> +
>   #define TEST_TIMEOUT_DEFAULT 30
>   
>   /* Utilities exposed to the test definitions */
> @@ -416,7 +422,7 @@
>   				self = mmap(NULL, sizeof(*self), PROT_READ | PROT_WRITE, \
>   					MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
>   			} else { \
> -				memset(&self_private, 0, sizeof(self_private)); \
> +				__kselftest_memset_safe(&self_private, 0, sizeof(self_private)); \
>   				self = &self_private; \
>   			} \
>   		} \


Applied to linux-kselftest fixes branch for next rc.

thanks,
-- Shuah

