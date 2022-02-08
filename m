Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0086B4ACD23
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiBHBGP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiBHAYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 19:24:32 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940DDC061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 16:24:29 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id z7so12578495ilb.6
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 16:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vgz3vJoxRCjSxOnu8bDTDSG6VAB8AKydsEfZW+RiuBU=;
        b=B5KTjIHd8JJqHtNAMC1PzjEXLhYAW2XGJzTUChMhTd6LR06BDZAjdj3VR8ZJl39Lhr
         UwjfvA8N+T9GscLNPUjTnG9su+HIUOkeeROhdU9c70mhjFhpbXH038YJob6suCbeGYtT
         C2cZOtAaQX3X8zHX7grA+riPzBbXH6x3G8Z+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vgz3vJoxRCjSxOnu8bDTDSG6VAB8AKydsEfZW+RiuBU=;
        b=fKY+ecGaj4zAWXMiK5u6neOve4Jlrw2yN4NS3C0VeOwwo0/J9L9iWkvrd9UNAg1fYE
         lGqd3vb7D6aq47BWJ1BmkOr0VHtrjdzMusCIeaHINdysvhU5yI+P23u3vroskV59aY3i
         HRkoxb2bZWVTA6MVzTLgCXbIoKlc1m7gZ7olMU7AqlIglc0jhOyuYFPyWghGnplN5IuH
         z++Np+0okK3aiGyiS7coPVwP6L0eU+mthb9G5RNyKW+39rWE0oNjVib9YLronuWZc32n
         OL0KCo/M6NYIkUHE0+bP5L8Rh+YThszTUIjqqSpRbZWar6YV/1Ay1ultNLd4nlqRiRex
         iZow==
X-Gm-Message-State: AOAM530CdbFPRuGI3ak4yWmYTJbIfIOoNJk6+co61ycezmmJQmDDoW6T
        sGKy2h2w49l3Vv3xlquAD91UuA==
X-Google-Smtp-Source: ABdhPJxhj/ObwJzAC/vSnKWt7hzqF0me2g8ZGst3fT1kLBYK5mtfxm3nxbacAfWRZVou8UtBvqjbNg==
X-Received: by 2002:a92:5208:: with SMTP id g8mr963001ilb.310.1644279868967;
        Mon, 07 Feb 2022 16:24:28 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id t2sm2986140ilp.49.2022.02.07.16.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 16:24:28 -0800 (PST)
Subject: Re: [PATCH v11 33/40] kselftest/arm64: Extend vector configuration
 API tests to cover SME
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
 <20220207152109.197566-34-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <32b86e20-8a4e-42ac-f5d9-188f1d80e412@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 17:24:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207152109.197566-34-broonie@kernel.org>
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
> Provide RDVL helpers for SME and extend the main vector configuration tests
> to cover SME.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/fp/.gitignore   |  1 +
>   tools/testing/selftests/arm64/fp/Makefile     |  3 ++-
>   tools/testing/selftests/arm64/fp/rdvl-sme.c   | 14 ++++++++++++++
>   tools/testing/selftests/arm64/fp/rdvl.S       | 10 ++++++++++
>   tools/testing/selftests/arm64/fp/rdvl.h       |  1 +
>   tools/testing/selftests/arm64/fp/vec-syscfg.c | 10 ++++++++++
>   6 files changed, 38 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sme.c
> 
> diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
> index c50d86331ed2..6e9a610c5e5d 100644
> --- a/tools/testing/selftests/arm64/fp/.gitignore
> +++ b/tools/testing/selftests/arm64/fp/.gitignore
> @@ -1,5 +1,6 @@
>   fp-pidbench
>   fpsimd-test
> +rdvl-sme
>   rdvl-sve
>   sve-probe-vls
>   sve-ptrace
> diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
> index 95f0b877a060..a224fff8082b 100644
> --- a/tools/testing/selftests/arm64/fp/Makefile
> +++ b/tools/testing/selftests/arm64/fp/Makefile
> @@ -3,7 +3,7 @@
>   CFLAGS += -I../../../../../usr/include/
>   TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
>   TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
> -	rdvl-sve \
> +	rdvl-sme rdvl-sve \
>   	sve-test sve-stress \
>   	vlset
>   
> @@ -13,6 +13,7 @@ fp-pidbench: fp-pidbench.S asm-utils.o
>   	$(CC) -nostdlib $^ -o $@
>   fpsimd-test: fpsimd-test.o asm-utils.o
>   	$(CC) -nostdlib $^ -o $@
> +rdvl-sme: rdvl-sme.o rdvl.o
>   rdvl-sve: rdvl-sve.o rdvl.o
>   sve-ptrace: sve-ptrace.o
>   sve-probe-vls: sve-probe-vls.o rdvl.o
> diff --git a/tools/testing/selftests/arm64/fp/rdvl-sme.c b/tools/testing/selftests/arm64/fp/rdvl-sme.c
> new file mode 100644
> index 000000000000..49b0b2e08bac
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/fp/rdvl-sme.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <stdio.h>
> +
> +#include "rdvl.h"
> +
> +int main(void)
> +{
> +	int vl = rdvl_sme();
> +
> +	printf("%d\n", vl);
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/arm64/fp/rdvl.S b/tools/testing/selftests/arm64/fp/rdvl.S
> index c916c1c9defd..20dc29996dc6 100644
> --- a/tools/testing/selftests/arm64/fp/rdvl.S
> +++ b/tools/testing/selftests/arm64/fp/rdvl.S
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   // Copyright (C) 2021 ARM Limited.
>   
> +#include "sme-inst.h"
> +
>   .arch_extension sve
>   
>   .globl rdvl_sve
> @@ -8,3 +10,11 @@ rdvl_sve:
>   	hint	34			// BTI C
>   	rdvl	x0, #1
>   	ret
> +
> +.globl rdvl_sme
> +rdvl_sme:
> +	hint	34			// BTI C
> +
> +	rdsvl	0, 1
> +
> +	ret
> diff --git a/tools/testing/selftests/arm64/fp/rdvl.h b/tools/testing/selftests/arm64/fp/rdvl.h
> index 7c9d953fc9e7..5d323679fbc9 100644
> --- a/tools/testing/selftests/arm64/fp/rdvl.h
> +++ b/tools/testing/selftests/arm64/fp/rdvl.h
> @@ -3,6 +3,7 @@
>   #ifndef RDVL_H
>   #define RDVL_H
>   
> +int rdvl_sme(void);
>   int rdvl_sve(void);
>   
>   #endif
> diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
> index c90658811a83..9bcfcdc34ee9 100644
> --- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
> +++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
> @@ -51,6 +51,16 @@ static struct vec_data vec_data[] = {
>   		.prctl_set = PR_SVE_SET_VL,
>   		.default_vl_file = "/proc/sys/abi/sve_default_vector_length",
>   	},
> +	{
> +		.name = "SME",
> +		.hwcap_type = AT_HWCAP2,
> +		.hwcap = HWCAP2_SME,
> +		.rdvl = rdvl_sme,
> +		.rdvl_binary = "./rdvl-sme",
> +		.prctl_get = PR_SME_GET_VL,
> +		.prctl_set = PR_SME_SET_VL,
> +		.default_vl_file = "/proc/sys/abi/sme_default_vector_length",
> +	},
>   };
>   
>   static int stdio_read_integer(FILE *f, const char *what, int *val)
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
