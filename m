Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA2867B7CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 18:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjAYRDK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 12:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjAYRDJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 12:03:09 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9302C7A9C
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 09:03:08 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id c66so3328124iof.12
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 09:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPVWLTo+vaeF5iEwBOSiPYaPy6VvLY/Th6ssTGMUgl8=;
        b=XOj66zypoWrEmuT3uRLp5WqdKG6YJzZ3bYzEf7icQnSt11h1lgop4iFwYvZd8XSkLW
         DOhCCX2b/oAh3+Zn2Wbf8yTMBPyg4qQ9WvSXZfvlA5GXw24XQUibg3s70nBhgzVL4VWI
         9dRgvzEHF/Z525nzrcj5BsWnP3zhkK2xeMpf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPVWLTo+vaeF5iEwBOSiPYaPy6VvLY/Th6ssTGMUgl8=;
        b=GQBRq27GOdPCXK0FPRhVzQD26kPjwG2J/mSZCSYv6XMYtNiclJm961Gd0KK0Zj+N6k
         EIoRk1L7uTZqQera7AuswT7rGBTvDk4xJIQGcPPbYpPAOonnqwDStT8gY0h/fLOMMReM
         tfFVuM4fMvWp9zAero6hjdGwLhStjfduyoKd5ME7tmLZ9lLLuQe0Yaf2niKBU52HBSwE
         /SCrrFvqZhtGrJLt2zfcUVnJEaFYC/gOPDmUvb92IscoSwwvX1F/h48dPLLM8v+acgtQ
         fmo0yah62yc8OlbOeuFDVgytBVBroCYXpyrwaN2rXX/DYLtFzFOEoXSX6c2MOgCkHFep
         BZXw==
X-Gm-Message-State: AFqh2kqO2yesuw5GGa1LErWT8Enso+iMtE4B9B0EQuMnSN/8fMMGW8wd
        GXy8YT1e066kh919fwjupvmIHg==
X-Google-Smtp-Source: AMrXdXvTzdx9bV9nfBVmDShQ+Q25befjEqOGzUdAdd2h+zE8uQH1JTh2YMA7BjTp1cddc+oR3ewuZA==
X-Received: by 2002:a5e:dd04:0:b0:6dd:f251:caf7 with SMTP id t4-20020a5edd04000000b006ddf251caf7mr4676393iop.0.1674666187811;
        Wed, 25 Jan 2023 09:03:07 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p1-20020a0566022b0100b006ddb3b698ffsm1597921iov.23.2023.01.25.09.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 09:03:07 -0800 (PST)
Message-ID: <c38ba6b9-b748-cf84-92bd-d29211b10f24@linuxfoundation.org>
Date:   Wed, 25 Jan 2023 10:03:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] selftests: amd-pstate: Don't delete source files via
 Makefile
To:     Doug Smythies <dsmythies@telus.net>,
        'Huang Rui' <ray.huang@amd.com>, sedat.dilek@gmail.com,
        li.meng@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
 <000601d92db7$39e9d0b0$adbd7210$@telus.net>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <000601d92db7$39e9d0b0$adbd7210$@telus.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/21/23 09:41, Doug Smythies wrote:
> Revert the portion of a recent Makefile change that incorrectly
> deletes source files when doing "make clean".
> 
> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
> v2: fix address list.
> ---
>   tools/testing/selftests/amd-pstate/Makefile | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 5f195ee756d6..5fd1424db37d 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -7,11 +7,6 @@ all:
>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> 
> -ifeq (x86,$(ARCH))
> -TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> -TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> -endif
> -

This looks good - Do you need these files to run this test and if so
do these need to installed when the test is run on a test system?

Now applied to linux-kselftest fixes. I will send this up for the next
rc.

thanks,
-- Shuah
