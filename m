Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322EC26DE07
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Sep 2020 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgIQNus (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Sep 2020 09:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgIQNun (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Sep 2020 09:50:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3546C06178A;
        Thu, 17 Sep 2020 06:38:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d4so2002517wmd.5;
        Thu, 17 Sep 2020 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+U0ANCedTXmZ61Vy39O8cbQewFJtCfyUeqxdMzTRfeI=;
        b=aXLBgkvZ+ZfiutVcnS66UN2sRHTXikqw7/zapXEEIDwy0eQeON4QoRRRD6Ao1T8dwV
         7FO3T7eIg7kcILN2sryGMUCwHsECE9/agmSY2853xlLwyTRvkLv3gGq2ZxlgakZ8fpYY
         ff0WMgflSn7Fcfb3twf/Fj/YjLg6S7pj5DnqK0JLe9C0aikZPolN+dEHAE2YPGDuKz9J
         TY9SdL586qjoBuJjU/CgXTbMKZjXAPY1uyUVGbkV+cnO+id+bLX+cknOXGr1weKLGlGP
         IRgyqun/WPUdyJV5Oy9Xh7ZocWZc0u96uSd5f/lIuwhW6MoWB38PaCJOEbJN+WtO/340
         awSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+U0ANCedTXmZ61Vy39O8cbQewFJtCfyUeqxdMzTRfeI=;
        b=ft5bINY4lCsr0wapocG3O+guGWGLDlxXw1A/YrCxzxeDP3FYZ5ZiPosBv2aO9pykQb
         VmQYNgIIjW+552FS1t0Lp0Psc/q2cnpF7m1dBKrGZXpjRK+HNI/aIEQl/CVWjEiPB0OJ
         3UpFmSvEVrIVK0doRoxx4yma3h383VnjTrplelKV2eA/2zeLhyBqnh7ZMEqVY2ZHn/17
         FDYmmNzr/BSF1NufArdVXcxAndnmjxjL9PsFBlkcPnB4cPsxn56z7xWNZgFmL4D/582q
         zIAS641LvRfiDTrCu8hy5tz6kACaKWyv599rUpQR8hWtLn4NesQ9tZUb7wHFo8bZGBd3
         ablA==
X-Gm-Message-State: AOAM530rJ7gj4FQ1FElNJz8IPa3f4mHLaLGAn/1pXeRqXk7oyDiQoiar
        UAdYorgY0SFS14oUnR5PkJBQ97129GH50OrJ4GM=
X-Google-Smtp-Source: ABdhPJz1QhTvKBayChW0luBSxMLyl3aJeFDYaFiBJypZp081zAtDL6V9mW0etuBU1zghbDwqBk4WqA==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr10531746wma.32.1600349886086;
        Thu, 17 Sep 2020 06:38:06 -0700 (PDT)
Received: from [10.127.42.2] ([94.156.155.144])
        by smtp.gmail.com with ESMTPSA id y207sm11911056wmc.17.2020.09.17.06.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 06:38:05 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] kselftests/arm64: add a basic Pointer
 Authentication test
To:     Amit Kachhap <amit.kachhap@arm.com>,
        Boyan Karatotev <boyan.karatotev@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200831110450.30188-1-boyan.karatotev@arm.com>
 <20200831110450.30188-2-boyan.karatotev@arm.com>
 <2e89a5ff-738b-5484-bd00-9ccdeccf9f60@arm.com>
From:   Boyan Karatotev <boian4o1@gmail.com>
Message-ID: <fa24987e-c8e9-0130-d2bc-ec114a729491@gmail.com>
Date:   Thu, 17 Sep 2020 14:38:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2e89a5ff-738b-5484-bd00-9ccdeccf9f60@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 16/09/2020 1:11 pm, Amit Kachhap wrote:
> On 8/31/20 4:34 PM, Boyan Karatotev wrote:
>> PAuth signs and verifies return addresses on the stack. It does so by
>> +
>> +/* check that a corrupted PAC results in SIGSEGV */
>> +TEST_SIGNAL(corrupt_pac, SIGSEGV)
>> +{
>> +    ASSERT_PAUTH_ENABLED();
>> +
>> +    pac_corruptor();
>
> With 8.6-Pauth extension merged in arm tree [1]. It makes sense to
> verify PAC corruption for both SIGSEGV and SIGILL signals.
>
> Code something like below handles both the cases.
>
>
-----------------------------------------------------------------------------------
>
>  int exec_sign_all(struct signatures *signed_vals, size_t val)
> @@ -187,12 +188,29 @@ int exec_sign_all(struct signatures *signed_vals,
> size_t val)
>         return 0;
>  }
>
> -/* check that a corrupted PAC results in SIGSEGV */
> -TEST_SIGNAL(corrupt_pac, SIGSEGV)
> +sigjmp_buf jmpbuf;
> +void pac_signal_handler(int signum, siginfo_t *si, void *uc)
>  {
> -       ASSERT_PAUTH_ENABLED();
> +       if (signum == SIGSEGV || signum == SIGILL) {
> +               siglongjmp(jmpbuf, 1);
> +       }
> +}
> +
> +/* check that a corrupted PAC results in SIGSEGV or SIGILL */
> +TEST(corrupt_pac)
> +{
> +       struct sigaction sa;
>
> -       pac_corruptor();
> +       ASSERT_PAUTH_ENABLED();
> +       if (sigsetjmp(jmpbuf, 1) == 0) {
> +               sa.sa_sigaction = pac_signal_handler;
> +               sa.sa_flags = SA_SIGINFO;
> +               sigemptyset(&sa.sa_mask);
> +               sigaction(SIGSEGV, &sa, NULL);
> +               sigaction(SIGILL, &sa, NULL);
> +               pac_corruptor();
> +               ASSERT_TRUE(0) TH_LOG("SIGSEGV/SIGILL signal did not
> occur");
> +       }
>  }
>
>  /*
> @@ -265,7 +283,7 @@ TEST(single_thread_different_keys)
>
>                 tmp = n_same_single_set(&signed_vals, nkeys);
>
---------------------------------------------------------------------------------------
>
>
>
> Thanks,
> Amit Daniel
>
> [1]:
>
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/ptrauth

Okay, I will add this and post it with the next version.

Regards,
Boyan
