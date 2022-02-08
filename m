Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC51C4ACD6F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbiBHBGZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbiBHAkL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 19:40:11 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5625C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 16:40:10 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y84so19254505iof.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 16:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DXeBvPGPhYY+G0mgsEODvq+5edCNWHsu13flglIZ8UM=;
        b=PouLRfqDZfaw1BrQsKzh+xn99PLlR1bC33CV3R7yMYhNxvRWiYU/etVWr0UHoioj0L
         6g/cfYNtG27eRKW9sUplUKo4Ixiz0JVr1GVnaNCS4RbPY5IVon3GpPzQ36L4NjTu6tOL
         WCDDTQKmh7tBNLSGVFY4SqUv7dN6QprlpBePQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DXeBvPGPhYY+G0mgsEODvq+5edCNWHsu13flglIZ8UM=;
        b=TiO3iz1u/FEWcEQQFX41d6iGYnCmlflmjnfUoJoJuhaLCEJ+kG7BWv1q5fqqsbm/zc
         lXdlME1zCewGjD6AqfNdEVmxAqfMFKs8nGwfzswXS3ju3r3yQoYFLiIbNidgt+VgZYNF
         8xmzFEa/62TGU0GDVHC9evg5F3IK++psP/a2Al/u79uVxdI32PUYUYN0swZMTQU8DR8c
         n1icnLUo5LeMNxw7rzb+rRyqvnVl0TDRBlAgvrTDqFFenQ6K2t6Ef+eh1NFn6NWsG0Nd
         hUkTtrjLsdedaj/y6AXrpYqIyD0c9mfjuDbuqa9PsuPAlmxf8+jzMdCFLj8xNPJIJVTB
         OV+w==
X-Gm-Message-State: AOAM533S5xuHQ9KeES/KjlLN1w5BTEx0gYwVGp67Vv0wRUt2TWWwo1tW
        sZrlfKcmG/XU2R3zc1x1Z4i48g==
X-Google-Smtp-Source: ABdhPJzeX0vLAAWRHPBAbA5cgmSlTkcN8+zoFIZE6KO/H/cq6RdFUbzERhuo/trd9mdX5FzHSG3mrw==
X-Received: by 2002:a05:6638:14cb:: with SMTP id l11mr1058327jak.292.1644280810350;
        Mon, 07 Feb 2022 16:40:10 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id m12sm7043930iow.54.2022.02.07.16.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 16:40:09 -0800 (PST)
Subject: Re: [PATCH v11 34/40] kselftest/arm64: sme: Provide streaming mode
 SVE stress test
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-35-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3b173e0e-7651-b820-26c4-37d1cbe94224@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 17:40:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207152109.197566-35-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/7/22 8:21 AM, Mark Brown wrote:
> One of the features of SME is the addition of streaming mode, in which we
> have access to a set of streaming mode SVE registers at the SME vector
> length. Since these are accessed using the SVE instructions let's reuse
> the existing SVE stress test for testing with a compile time option for
> controlling the few small differences needed:
> 
>   - Enter streaming mode immediately on starting the program.
>   - In streaming mode FFR is removed so skip reading and writing FFR.
> 
> In order to avoid requiring a cutting edge toolchain with SME support
> use the op/CR form for specifying SVCR.

A few words or pointer to op/CR form would help as education for
people that aren't familiar with the form (self included).

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/fp/.gitignore  |  1 +
>   tools/testing/selftests/arm64/fp/Makefile    |  3 +
>   tools/testing/selftests/arm64/fp/ssve-stress | 59 ++++++++++++++++++++
>   tools/testing/selftests/arm64/fp/sve-test.S  | 20 +++++++
>   4 files changed, 83 insertions(+)
>   create mode 100644 tools/testing/selftests/arm64/fp/ssve-stress
> 
> diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
> index 6e9a610c5e5d..5729a5b1adfc 100644
> --- a/tools/testing/selftests/arm64/fp/.gitignore
> +++ b/tools/testing/selftests/arm64/fp/.gitignore
> @@ -5,5 +5,6 @@ rdvl-sve
>   sve-probe-vls
>   sve-ptrace
>   sve-test
> +ssve-test
>   vec-syscfg
>   vlset
> diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
> index a224fff8082b..e6643c9b0474 100644
> --- a/tools/testing/selftests/arm64/fp/Makefile
> +++ b/tools/testing/selftests/arm64/fp/Makefile
> @@ -5,6 +5,7 @@ TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
>   TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
>   	rdvl-sme rdvl-sve \
>   	sve-test sve-stress \
> +	ssve-test ssve-stress \
>   	vlset
>   
>   all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
> @@ -19,6 +20,8 @@ sve-ptrace: sve-ptrace.o
>   sve-probe-vls: sve-probe-vls.o rdvl.o
>   sve-test: sve-test.o asm-utils.o
>   	$(CC) -nostdlib $^ -o $@
> +ssve-test: sve-test.S asm-utils.o
> +	$(CC) -DSSVE -nostdlib $^ -o $@
>   vec-syscfg: vec-syscfg.o rdvl.o
>   vlset: vlset.o
>   
> diff --git a/tools/testing/selftests/arm64/fp/ssve-stress b/tools/testing/selftests/arm64/fp/ssve-stress
> new file mode 100644
> index 000000000000..e2bd2cc184ad
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/fp/ssve-stress
> @@ -0,0 +1,59 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright (C) 2015-2019 ARM Limited.
> +# Original author: Dave Martin <Dave.Martin@arm.com>
> +
> +set -ue
> +
> +NR_CPUS=`nproc`
> +
> +pids=
> +logs=
> +
> +cleanup () {
> +	trap - INT TERM CHLD
> +	set +e
> +
> +	if [ -n "$pids" ]; then
> +		kill $pids
> +		wait $pids
> +		pids=
> +	fi
> +
> +	if [ -n "$logs" ]; then
> +		cat $logs
> +		rm $logs
> +		logs=
> +	fi
> +}
> +
> +interrupt () {
> +	cleanup
> +	exit 0
> +}
> +
> +child_died () {
> +	cleanup
> +	exit 1

Is this a failure condition?

> +}
> +

With the comments explained or addressed:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
