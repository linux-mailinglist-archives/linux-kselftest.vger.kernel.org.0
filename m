Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C80D310570
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Feb 2021 08:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhBEHHc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 02:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhBEHHT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 02:07:19 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F66C06178A
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Feb 2021 23:06:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id lw17so6245115pjb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Feb 2021 23:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=MZ4P6Lw/6UiS8JyJfX3U5rtRFO+IqLNE8qsO+NPVXGk=;
        b=fjeV+W4m/Dfueub4G9bVMQnTATX1tYc2umM/k2buTydgbNxkOTmz14dNxg9/wi+TaG
         3R6vlfL+eJiVmyerGorSI9Ot9ISmEGu/a5fp/3Fh+Yi2787Ho3Pj2xUzMysM/BpfJJoE
         R8S/1IAWO6NNC03LRzIMJ1j/OSXeyRTWttpiiVyVzOJ0BiIGv7+Axyxn7VzFzk82O/al
         QtmB+UE9IuL7dWKS3GGaoWGSMcfrFFAPwcH39HdHaXSo6QnY1KK7RbYCsnolBpHH2iM9
         jQXvZGjda+wBfrP8VbfYw0FMQaw59QpSQHNMEFy2VMgLGoPc4p334HZ/uN6+Qru8eZie
         NdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=MZ4P6Lw/6UiS8JyJfX3U5rtRFO+IqLNE8qsO+NPVXGk=;
        b=inQdkuwOczdHVJXoZElmwuzWmN136AJxgwakr/CKnNKUKzeHlwoA/2keWU/SDb676C
         d5YXDH7XsROg5/e9Onb1wblAMpf2cXRWc4/JkLghqgfN0oKf1Jk5EfjYdoVnss/T3BHc
         /Bnc76q5wn45Iu4rQbFebcfEkkNUlD8GUWRoeup/pqB4jkmyTqNRLn9iO2RBtZQpIARW
         G511GIVCFlV3U9/7w+jfVN+hcRNbrbcpY2hcwhelh26fValy23d3KGqQiSwnmwADVo+z
         ncGHKR1NHwBErRE2LInw7FcLHs+hMcwgCxWJ62txmwTP8MDJa+0zsleLKy2PrIIgon0C
         pKDg==
X-Gm-Message-State: AOAM531AQttP9NMVf+siB2rrkmGwUYMQ8tHRaHLrdDvw6rRy5Dd3PpjX
        xmeuy2EEPu3ovqo32HPD5EcwGw==
X-Google-Smtp-Source: ABdhPJy+i1SyBhBl58mdtGk+jbnEdRYyq/TwOIas1FPrSVUyC1ZHmq30hMp0QYPogXZRl4PpMztVyw==
X-Received: by 2002:a17:90b:1c0d:: with SMTP id oc13mr2843615pjb.156.1612508798561;
        Thu, 04 Feb 2021 23:06:38 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t15sm7210137pjy.37.2021.02.04.23.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 23:06:37 -0800 (PST)
Date:   Thu, 04 Feb 2021 23:06:37 -0800 (PST)
X-Google-Original-Date: Thu, 04 Feb 2021 23:06:06 PST (-0800)
Subject:     Re: [PATCH] selftests/vDSO: fix ABI selftest on riscv
In-Reply-To: <20210204145042.7345-1-tklauser@distanz.ch>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        vincenzo.frascino@arm.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tklauser@distanz.ch, shuah@kernel.org
Message-ID: <mhng-1ed0f9e8-84ec-4f2e-ac42-5a608726e2fe@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 04 Feb 2021 06:50:42 PST (-0800), tklauser@distanz.ch wrote:
> Only older versions of the RISC-V GCC toolchain define __riscv__. Check
> for __riscv as well, which is used by newer GCC toolchains. Also set
> VDSO_32BIT based on __riscv_xlen.
>
> Before (on riscv64):
>
> $ ./vdso_test_abi
> [vDSO kselftest] VDSO_VERSION: LINUX_4
> Could not find __vdso_gettimeofday
> Could not find __vdso_clock_gettime
> Could not find __vdso_clock_getres
> clock_id: CLOCK_REALTIME [PASS]
> Could not find __vdso_clock_gettime
> Could not find __vdso_clock_getres
> clock_id: CLOCK_BOOTTIME [PASS]
> Could not find __vdso_clock_gettime
> Could not find __vdso_clock_getres
> clock_id: CLOCK_TAI [PASS]
> Could not find __vdso_clock_gettime
> Could not find __vdso_clock_getres
> clock_id: CLOCK_REALTIME_COARSE [PASS]
> Could not find __vdso_clock_gettime
> Could not find __vdso_clock_getres
> clock_id: CLOCK_MONOTONIC [PASS]
> Could not find __vdso_clock_gettime
> Could not find __vdso_clock_getres
> clock_id: CLOCK_MONOTONIC_RAW [PASS]
> Could not find __vdso_clock_gettime
> Could not find __vdso_clock_getres
> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
> Could not find __vdso_time
>
> After (on riscv32):
>
> $ ./vdso_test_abi
> [vDSO kselftest] VDSO_VERSION: LINUX_4.15
> The time is 1612449376.015086
> The time is 1612449376.18340784
> The resolution is 0 1
> clock_id: CLOCK_REALTIME [PASS]
> The time is 774.842586182
> The resolution is 0 1
> clock_id: CLOCK_BOOTTIME [PASS]
> The time is 1612449376.22536565
> The resolution is 0 1
> clock_id: CLOCK_TAI [PASS]
> The time is 1612449376.20885172
> The resolution is 0 4000000
> clock_id: CLOCK_REALTIME_COARSE [PASS]
> The time is 774.845491269
> The resolution is 0 1
> clock_id: CLOCK_MONOTONIC [PASS]
> The time is 774.849534200
> The resolution is 0 1
> clock_id: CLOCK_MONOTONIC_RAW [PASS]
> The time is 774.842139684
> The resolution is 0 4000000
> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
> Could not find __vdso_time
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  tools/testing/selftests/vDSO/vdso_config.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
> index 6a6fe8d4ff55..6188b16827d1 100644
> --- a/tools/testing/selftests/vDSO/vdso_config.h
> +++ b/tools/testing/selftests/vDSO/vdso_config.h
> @@ -47,10 +47,12 @@
>  #elif defined(__x86_64__)
>  #define VDSO_VERSION		0
>  #define VDSO_NAMES		1
> -#elif defined(__riscv__)
> +#elif defined(__riscv__) || defined(__riscv)
>  #define VDSO_VERSION		5
>  #define VDSO_NAMES		1
> +#if __riscv_xlen == 32
>  #define VDSO_32BIT		1
> +#endif
>  #else /* nds32 */
>  #define VDSO_VERSION		4
>  #define VDSO_NAMES		1

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Not sure if you want this through the RISC-V tree, so I'm leaving it out for
now and assuming it'll go through a kselftest tree.

Thanks!
