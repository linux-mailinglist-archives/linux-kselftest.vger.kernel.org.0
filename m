Return-Path: <linux-kselftest+bounces-1297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8DF8074EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 17:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C28281C49
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24794776D;
	Wed,  6 Dec 2023 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JUP9Q7hQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DCB12F
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 08:29:02 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d9a1dd6fdcso521110a34.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701880142; x=1702484942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5ZbGGmoH/lFlZhMRZN1vjFtS/EFqjm5PsB2wakbCe8=;
        b=JUP9Q7hQu9MmC8qT+pvq4Rvvq1eyIaYqOLTyljMFCuaeJS7pJri5kF+MfbVN26lg8h
         NbQAtypwudwKwgAnl4F2e4YIGPKgeXQvCYWKRhvhrePNzfDBNQjnAmx3w0yttDn3Oh3u
         ELEA6s41uIP/aJhbtXh+sPC9yDZT9uIzzw8hYMBOlmldIVohtdFSayFtHKXNaNvqL5pG
         9tblrpZ2IEvFHK9wSOzSLLFgV4RzVHl/wk4ZebAjuD4uzFEHnsFLXVCabYheSQxM0mcF
         YHN8LrpFy1MRsuxZMFzIztIK7s5iEy3vvBvlIQEWH2LK3ZJgZDe+ojzcDzEyyNwMYljO
         5Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880142; x=1702484942;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5ZbGGmoH/lFlZhMRZN1vjFtS/EFqjm5PsB2wakbCe8=;
        b=Xnqs2o26XhRlAGSKKkyLaXyY0rfnwUiDgQBzAUr4x22VubiVw8FQH2f9DgioYnwwPH
         22a4RJ82+Ti0iKTE/HtzuHOvWm6yCtMBlNV1af/BxXZQFzU9fA7VzSl+al3VKb2dwvlo
         P3oGWloww+7nCSCs0UBpI3E0uyfDvImzRZZXukEJ4MT5/L3Ru7urWohw5CQmdLCS2OKr
         ShUMwkHcLdPJdeJt9uQNq93tUI3UVgrLLNvk0QGJ2LbDr412lT2dWtC5xknjDuZUDOZg
         QwiqG/hm27k8SnTR7RQH5SRhh+IRXDD5qzPniw5dRZUJSRt7YWiYNMWRf4FeqnmoOWfA
         qOBQ==
X-Gm-Message-State: AOJu0YzS7HpkSTjEEeRpFB88mfFHz5BBlJQM8D+/zz9K0f+MaJiGB97F
	fuVuSfNrQ7F/O/T1o5LP0j0I3Q==
X-Google-Smtp-Source: AGHT+IGn8NLklrz8gfLpf4ZROBA91oSNRaf0+Ba33U1gJX5IEC3OyhkihvKkTQRDR3ZHIRtV5+wHCg==
X-Received: by 2002:a9d:6385:0:b0:6d9:9ed9:f0e0 with SMTP id w5-20020a9d6385000000b006d99ed9f0e0mr559336otk.14.1701880141802;
        Wed, 06 Dec 2023 08:29:01 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id c25-20020a9d6859000000b006d9a0bf775asm24697oto.7.2023.12.06.08.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:29:01 -0800 (PST)
Date: Wed, 06 Dec 2023 08:29:01 -0800 (PST)
X-Google-Original-Date: Wed, 06 Dec 2023 08:28:59 PST (-0800)
Subject:     Re: [PATCH v2] selftests: sud_test: return correct emulated syscall value on RISC-V
In-Reply-To: <20231206134438.473166-1-cleger@rivosinc.com>
CC: shuah@kernel.org, krisman@collabora.com, linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, cleger@rivosinc.com,
  Bjorn Topel <bjorn@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: cleger@rivosinc.com, tglx@linutronix.de
Message-ID: <mhng-bd5d2bdb-99ab-464a-a043-bdfc34b96b71@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 06 Dec 2023 05:44:37 PST (-0800), cleger@rivosinc.com wrote:
> Currently, the sud_test expects the emulated syscall to return the
> emulated syscall number. This assumption only works on architectures
> were the syscall calling convention use the same register for syscall
> number/syscall return value. This is not the case for RISC-V and thus
> the return value must be also emulated using the provided ucontext.
>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> ---
>
> Changes in V2:
>  - Changes comment to be more explicit
>  - Use A7 syscall arg rather than hardcoding MAGIC_SYSCALL_1
>
> ---
>  .../selftests/syscall_user_dispatch/sud_test.c     | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> index b5d592d4099e..d975a6767329 100644
> --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> @@ -158,6 +158,20 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
>
>  	/* In preparation for sigreturn. */
>  	SYSCALL_DISPATCH_OFF(glob_sel);
> +
> +	/*
> +	 * The tests for argument handling assume that `syscall(x) == x`. This
> +	 * is a NOP on x86 because the syscall number is passed in %rax, which
> +	 * happens to also be the function ABI return register.  Other
> +	 * architectures may need to swizzle the arguments around.
> +	 */
> +#if defined(__riscv)
> +/* REG_A7 is not defined in libc headers */
> +# define REG_A7 (REG_A0 + 7)
> +
> +	((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A0] =
> +			((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A7];
> +#endif
>  }
>
>  TEST(dispatch_and_return)

Thanks.

Thomas: looks like you picked up all the commits that touched this?  No 
rush on my end, just LMK if you want me to pick it up -- I'm going to 
leave it alone for now.

