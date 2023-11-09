Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821657E6299
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 04:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjKID0i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 22:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjKID0h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 22:26:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37AE1BEF
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Nov 2023 19:26:35 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc29f39e7aso3012705ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Nov 2023 19:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699500395; x=1700105195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SL43KqdoOApMZsa3YMezQNkvoYmYG9YJ6cT/naFj7n0=;
        b=0uYz7R1JoaKNf6DVQzg8oUlsaTbw54ZeweD2rTeXnGm4H1NH5jOstTo0ZjJBQeRgHQ
         R2+yyZJuLZhMgXoevavAxCFp4q9NPrW0MVbDCZOVLP6/UnmRkH9sIrYDmg3//vMJyEbS
         3OZKRepAyvCtQ1fDGxVc7KIBqFydhcyvqlZftyo6AkiUnd+IB33M16/H1SPWiDxvqGTK
         KrMk64mvtW7WBhaByy+JY0l3Ts9iBrsxIsdetykOQwPmzVDbvyiCi5AE3Vjr4Rc8kCgC
         4vVK8HrRM+GYpm/MjnrYcqoXD5fwONOkNVkFZdomrR/Vcc5SCygDIu3owhMYc9eSOq0A
         Sz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699500395; x=1700105195;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SL43KqdoOApMZsa3YMezQNkvoYmYG9YJ6cT/naFj7n0=;
        b=Q72dBU2uiR9h1tVT2zpTBDZun+usl+ZtRGcAw6R7iGAbvt13CXgjAj4gx2hDQG0v4E
         O7RjLoyl3nz4rWcKewVdIiu/01yLDQdY4aEXA+PsYYLMReOnCmoGf7FEukQPPyV4q/We
         Ulx8ie+uV+TTMd90/3Nv30wNYZjUjx7I3Lst4W/+oIF3uSWwkP5QIHCdfXV/MSb5u5BV
         GSuyFrgsz40GCXgAiKAaZ9ztvsATau1mzwD4DLgdH5PcwaoYV/ntD/C06HVhqUGWlwTI
         ZqgSBqfiticZBaVR2aYznSn7xaqaVSd+a0BFXccCWbN67ch65U1zvN+IIu26FqiG0sSi
         1B+A==
X-Gm-Message-State: AOJu0YyVOss6EInUf9UrvNtzyOXFmKAxLY5ZNvtnFDO4X8MXXcZK9VFN
        B9zo0kylQGPfNHQkViY7b2hYtQ==
X-Google-Smtp-Source: AGHT+IGr7vGXKEc3TQWEMfgM2CHVvt0ly+Zqz32FmWgjh6G8g9LT1+KY6vb72CQ295XvF9UU+LAVYQ==
X-Received: by 2002:a17:902:ee89:b0:1cc:87f8:96ab with SMTP id a9-20020a170902ee8900b001cc87f896abmr4072748pld.38.1699500394683;
        Wed, 08 Nov 2023 19:26:34 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b001bbb25dd3a7sm2388288plb.187.2023.11.08.19.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 19:26:34 -0800 (PST)
Date:   Wed, 08 Nov 2023 19:26:34 -0800 (PST)
X-Google-Original-Date: Wed, 08 Nov 2023 19:26:29 PST (-0800)
Subject:     Re: [PATCH] selftests: sud_test: return correct emulated syscall value on RISC-V
In-Reply-To: <20230913140711.266975-1-cleger@rivosinc.com>
CC:     shuah@kernel.org, krisman@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, cleger@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     cleger@rivosinc.com
Message-ID: <mhng-bd15a99e-2c1e-4f0e-95ff-b6f14fe26681@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 13 Sep 2023 07:07:11 PDT (-0700), cleger@rivosinc.com wrote:
> Currently, the sud_test expects the emulated syscall to return the
> emulated syscall number. This assumption only works on architectures
> were the syscall calling convention use the same register for syscall
> number/syscall return value. This is not the case for RISC-V and thus
> the return value must be also emulated using the provided ucontext.
>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  tools/testing/selftests/syscall_user_dispatch/sud_test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> index b5d592d4099e..1b5553c19700 100644
> --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> @@ -158,6 +158,14 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
>
>  	/* In preparation for sigreturn. */
>  	SYSCALL_DISPATCH_OFF(glob_sel);
> +
> +	/*
> +	 * Modify interrupted context returned value according to syscall
> +	 * calling convention
> +	 */
> +#if defined(__riscv)
> +	((ucontext_t*)ucontext)->uc_mcontext.__gregs[REG_A0] = MAGIC_SYSCALL_1;
> +#endif
>  }
>
>  TEST(dispatch_and_return)

I'm not sure if I'm just tired, but it took me a while to figure out why 
this was necessary.  I think this is a better explanation:

    diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
    index b5d592d4099e..a913fd90cfa3 100644
    --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
    +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
    @@ -158,6 +158,16 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
    
     	/* In preparation for sigreturn. */
     	SYSCALL_DISPATCH_OFF(glob_sel);
    +	/*
    +	 * The tests for argument handling assume that `syscall(x) == x`.  This
    +	 * is a NOP on x86 because the syscall number is passed in %rax, which
    +	 * happens to also be the function ABI return register.  Other
    +	 * architectures may need to swizzle the arguments around.
    +	 */
    +#if defined(__riscv)
    +	(ucontext_t*)ucontext)->uc_mcontext.__gregs[REG_A0] =
    +		(ucontext_t*)ucontext)->uc_mcontext.__gregs[REG_A7];
    +#endif
     }
    
     TEST(dispatch_and_return)

but also

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

as I agree this is correct.

also: wouldn't arm64 also need to move x8 into x0 here, for essentially 
the same reason as we do?
