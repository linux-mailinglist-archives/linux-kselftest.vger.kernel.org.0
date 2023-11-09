Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028067E652F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 09:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjKIIW7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 03:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjKIIWw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 03:22:52 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E02D6D
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Nov 2023 00:22:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32da4180ca2so96921f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Nov 2023 00:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699518168; x=1700122968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6L9e4FIZCW/cWI4CMkVwxfgtOwMhyuLQGfalUNr9zJ8=;
        b=nG+dhpYAbbJZyRNC2Wak13uNZxEqdTUSqGMnOHmXtTmasKq14ClI/aS/e799jUTKTm
         mbdA5tipoyTQL8Ka3SuRkJu23pu860+Ud2EssCO9ZbhkHJ1hXjCmf2SRstu8L5eUu3Ua
         J03A8udw3KqVQb9DWNQKVb5vKax6Jls2pKHMvUkWt+4YJOaKftdHQTXcv4qqxiV8zraj
         YSVbuz6qq9Yi+PZMGhiVghy7JSItzWHCgvtO9GwEmWW3IJgIuYNktPnPAXO9xH55pNcF
         IGJywKV1mXPm5EuFiFXfPp2deRVuBxFrDof2eZsm2zsAMBtm5LCio+g+u2u2BCgg6iWn
         hcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699518168; x=1700122968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6L9e4FIZCW/cWI4CMkVwxfgtOwMhyuLQGfalUNr9zJ8=;
        b=XaJ7MrPDwtZNWt9KK3+rM3+6iEk/p9zxuNxVqM8GdMAaj84LuI9Yl2Ac6r8jTjUoN6
         at8nQBvUfCCqo/slL3jTAZ+73C/va4Jm/BuC3krMN2xTHjo9Yte81o3xTmm3Xe6AyQqn
         MOSU1q2XTyWjrnQJDnr2jfgDsGYQir0l2fiQ9ZS1r8UXjwluVAWh3sKZMzpPrgIHuZl5
         ZYYXD+sBN+h98uJCAa8LNi75UxSsnhhB1w2mpibwCdATM0XgtCH+JVDNlIufdITxH4An
         qOpH5hqd6xBPxk+Y+gbIvrSRUq1rtpS3z6mUfMqoNko7fTyLNDA3bFTGvu3no61wEQ0m
         74+A==
X-Gm-Message-State: AOJu0YyntKL5V9RZH6BmBcNqX/nVJU7FtBnYS1nTNpnsfrxewIQa1ML8
        JZ7J/AQameiMXI6gyFWdg2xhKQ==
X-Google-Smtp-Source: AGHT+IHK4jz0hvKjL1UU+txgQCeQzgbTv4KRpSfNHNu6mKMYO3jCYjwyh6vF0R5mbSffwlvJKf1efA==
X-Received: by 2002:a5d:6dae:0:b0:32f:8372:dfe8 with SMTP id u14-20020a5d6dae000000b0032f8372dfe8mr3193845wrs.1.1699518168015;
        Thu, 09 Nov 2023 00:22:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:87b4:87b9:6476:5df7? ([2a01:e0a:999:a3a0:87b4:87b9:6476:5df7])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000100600b0031984b370f2sm6817227wrx.47.2023.11.09.00.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 00:22:47 -0800 (PST)
Message-ID: <ef980c24-6901-4bb3-8a1b-5902675e7851@rivosinc.com>
Date:   Thu, 9 Nov 2023 09:22:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: sud_test: return correct emulated syscall
 value on RISC-V
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     shuah@kernel.org, krisman@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <mhng-bd15a99e-2c1e-4f0e-95ff-b6f14fe26681@palmer-ri-x1c9>
Content-Language: en-US
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <mhng-bd15a99e-2c1e-4f0e-95ff-b6f14fe26681@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 09/11/2023 04:26, Palmer Dabbelt wrote:
> On Wed, 13 Sep 2023 07:07:11 PDT (-0700), cleger@rivosinc.com wrote:
>> Currently, the sud_test expects the emulated syscall to return the
>> emulated syscall number. This assumption only works on architectures
>> were the syscall calling convention use the same register for syscall
>> number/syscall return value. This is not the case for RISC-V and thus
>> the return value must be also emulated using the provided ucontext.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  tools/testing/selftests/syscall_user_dispatch/sud_test.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>> b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>> index b5d592d4099e..1b5553c19700 100644
>> --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>> +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>> @@ -158,6 +158,14 @@ static void handle_sigsys(int sig, siginfo_t
>> *info, void *ucontext)
>>
>>      /* In preparation for sigreturn. */
>>      SYSCALL_DISPATCH_OFF(glob_sel);
>> +
>> +    /*
>> +     * Modify interrupted context returned value according to syscall
>> +     * calling convention
>> +     */
>> +#if defined(__riscv)
>> +    ((ucontext_t*)ucontext)->uc_mcontext.__gregs[REG_A0] =
>> MAGIC_SYSCALL_1;
>> +#endif
>>  }
>>
>>  TEST(dispatch_and_return)
> 
> I'm not sure if I'm just tired, but it took me a while to figure out why
> this was necessary.  I think this is a better explanation:

I think it's because this mechanism does not behave like other syscalls
at all and the classic calling convention does not really apply...

> 
>    diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
> b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>    index b5d592d4099e..a913fd90cfa3 100644
>    --- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>    +++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
>    @@ -158,6 +158,16 @@ static void handle_sigsys(int sig, siginfo_t
> *info, void *ucontext)
>            /* In preparation for sigreturn. */
>         SYSCALL_DISPATCH_OFF(glob_sel);
>    +    /*
>    +     * The tests for argument handling assume that `syscall(x) ==
> x`.  This
>    +     * is a NOP on x86 because the syscall number is passed in %rax,
> which
>    +     * happens to also be the function ABI return register.  Other
>    +     * architectures may need to swizzle the arguments around.
>    +     */

Indeed, that is more clear. Should I send a v2 ?

>    +#if defined(__riscv)
>    +    (ucontext_t*)ucontext)->uc_mcontext.__gregs[REG_A0] =
>    +        (ucontext_t*)ucontext)->uc_mcontext.__gregs[REG_A7];
>    +#endif
>     }
>        TEST(dispatch_and_return)
> 
> but also
> 
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> as I agree this is correct.
> 
> also: wouldn't arm64 also need to move x8 into x0 here, for essentially
> the same reason as we do?

Yes, as well as for a bunch of other architectures. I suspect this has
only been tested on x86. AFAIK, this feature is mainly for wine usage
which then makes sense for x86 and games.

Thanks,

Clément

