Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BA54ACDF4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiBHBXf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245733AbiBHBXM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 20:23:12 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A051C05399F
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 17:21:01 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id o10so12724060ilh.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 17:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kd+mZQkgkkn/Tv4WdZGQ/KIEa73QgXSSGBk+g1lPWwo=;
        b=b9miSaaDoTlRUq8wj+4UCzLsMLwnPXsplBZ6NE5K9/Hc6gBtKhUMOt3MBvFmNAMZ7y
         ULdbDGWpSVcy1ko5YFo2gssYl7D+zxHrydftYeaQ7JORCTgL9Xur8UIXe6quCn7JyTsJ
         BrmqbVfKUPWFei9HKvTUl2RlFpuZ2SQpA2LME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kd+mZQkgkkn/Tv4WdZGQ/KIEa73QgXSSGBk+g1lPWwo=;
        b=pMsqGi3fRzxnaLseaTxIc1l7wUj1t9rNGb5Culmx5szPhTKGaOhqWbsjcJE+6v0EKi
         5SJ0rzEiYi63fW228p5wlLBd752hFqYfoC1aQOxbvPSRzgAmcphs5ss8CtG53uaC/Wc8
         7Wo98zB1361no3o2BCiEiiFqIyHJ2pz7dVwHUQI8xZLKK3HZqU3ErGs/SfwOPp79naco
         iDpSmfdfM055xQLTFHJb5cXvzy5WtvP/DoeiCq5yBferMTaxPTP028WDp4NbLl7P4brV
         K9dvwc/Dm0nWYZ9fVmV6Mfub78ku9emnf1nPfjeilwT2XrCgGBk52lrNlC+GIwAlGZwA
         0Udw==
X-Gm-Message-State: AOAM533KfS3i+3kuBay6vPMWXMro5KROx1qtkgnQStZpdDFSFoCJHsQY
        rrh5TiIKt2YcocEzKvWUTjC9LQ==
X-Google-Smtp-Source: ABdhPJyz17vnt9tqNnyska0hhxzUg+/rdXl9E+g69qWV8V7guYXGGiiEDOMTrslokSSK0CGBvNq98g==
X-Received: by 2002:a92:c8c4:: with SMTP id c4mr1020408ilq.222.1644283260513;
        Mon, 07 Feb 2022 17:21:00 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id k1sm6984769iov.6.2022.02.07.17.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 17:21:00 -0800 (PST)
Subject: Re: [PATCH v11 39/40] kselftest/arm64: Add coverage for the ZA ptrace
 interface
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
 <20220207152109.197566-40-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8d1e2d2c-106c-10e6-cdaf-9bdd0d882263@linuxfoundation.org>
Date:   Mon, 7 Feb 2022 18:20:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220207152109.197566-40-broonie@kernel.org>
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
> Add some basic coverage for the ZA ptrace interface, including walking
> through all the vector lengths supported in the system.  Unlike SVE
> doing syscalls does not discard the ZA state so when we set data in ZA
> we run the child process briefly, having it add one to each byte in ZA
> in order to validate that both the vector size and data are being read
> and written as expected when the process runs.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/fp/.gitignore  |   1 +
>   tools/testing/selftests/arm64/fp/Makefile    |   3 +-
>   tools/testing/selftests/arm64/fp/za-ptrace.c | 354 +++++++++++++++++++
>   3 files changed, 357 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/arm64/fp/za-ptrace.c
> 
> diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
> index ead3197e720b..d98d3d48b504 100644
> --- a/tools/testing/selftests/arm64/fp/.gitignore
> +++ b/tools/testing/selftests/arm64/fp/.gitignore
> @@ -8,4 +8,5 @@ sve-test
>   ssve-test
>   vec-syscfg
>   vlset
> +za-ptrace
>   za-test
> diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
> index 38d2d0d5a0eb..807a8faf8d57 100644
> --- a/tools/testing/selftests/arm64/fp/Makefile
> +++ b/tools/testing/selftests/arm64/fp/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   CFLAGS += -I../../../../../usr/include/
> -TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
> +TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg za-ptrace
>   TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
>   	rdvl-sme rdvl-sve \
>   	sve-test sve-stress \
> @@ -27,5 +27,6 @@ vec-syscfg: vec-syscfg.o rdvl.o
>   vlset: vlset.o
>   za-test: za-test.o asm-utils.o
>   	$(CC) -nostdlib $^ -o $@
> +za-ptrace: za-ptrace.o
>   
>   include ../../lib.mk
> diff --git a/tools/testing/selftests/arm64/fp/za-ptrace.c b/tools/testing/selftests/arm64/fp/za-ptrace.c
> new file mode 100644
> index 000000000000..692c82624855
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/fp/za-ptrace.c
> @@ -0,0 +1,354 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 ARM Limited.
> + */
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/auxv.h>
> +#include <sys/prctl.h>
> +#include <sys/ptrace.h>
> +#include <sys/types.h>
> +#include <sys/uio.h>
> +#include <sys/wait.h>
> +#include <asm/sigcontext.h>
> +#include <asm/ptrace.h>
> +
> +#include "../../kselftest.h"
> +
> +/* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
> +#ifndef NT_ARM_ZA
> +#define NT_ARM_ZA 0x40c
> +#endif
> +
> +#define EXPECTED_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
> +
> +static void fill_buf(char *buf, size_t size)
> +{
> +	int i;
> +
> +	for (i = 0; i < size; i++)
> +		buf[i] = random();
> +}
> +
> +static int do_child(void)
> +{
> +	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
> +		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
> +
> +	if (raise(SIGSTOP))
> +		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
> +
> +	return EXIT_SUCCESS;
> +}
> +
> +static struct user_za_header *get_za(pid_t pid, void **buf, size_t *size)
> +{
> +	struct user_za_header *za;
> +	void *p;
> +	size_t sz = sizeof(*za);
> +	struct iovec iov;
> +
> +	while (1) {
> +		if (*size < sz) {
> +			p = realloc(*buf, sz);
> +			if (!p) {
> +				errno = ENOMEM;
> +				goto error;

Do we free buf in error path? Didn't see it in error handling below.

> +			}
> +
> +			*buf = p;
> +			*size = sz;
> +		}
> +
> +		iov.iov_base = *buf;
> +		iov.iov_len = sz;
> +		if (ptrace(PTRACE_GETREGSET, pid, NT_ARM_ZA, &iov))
> +			goto error;
> +
> +		za = *buf;
> +		if (za->size <= sz)
> +			break;
> +
> +		sz = za->size;
> +	}
> +
> +	return za;
> +
> +error:

Free buf?

> +	return NULL;
> +}
> +

Rest looked okay.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
