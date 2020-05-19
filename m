Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EBA1D9D95
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 19:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgESRLa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 13:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgESRLa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 13:11:30 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6286920709;
        Tue, 19 May 2020 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589908289;
        bh=AhoIJIhI20EELQu2FCFvcJtbYqUj+WKPqBjlG6rzH7g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Kl2YChZrd4IHZJAYhBvYynKdRg25g1P+rI7Sh3kRvohAKji2xq+9bGiAanen+lDCt
         dcrRMw8SdCLmiVWhGCDCZ67nAtZSe7mP+4rZXdFacBeMoZR5cooYe4rMAqtQ7Ywm3V
         Rfach0W5hfPC4Pnuy+Ion7DOZ2vubJbupTji6a1k=
Subject: Re: [PATCH 3/3] selftests: vdso: Add a selftest for vDSO getcpu()
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200505174728.46594-1-broonie@kernel.org>
 <20200505174728.46594-4-broonie@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <dff4dfbd-f3f1-d683-5dac-4404e9023b2e@kernel.org>
Date:   Tue, 19 May 2020 11:11:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505174728.46594-4-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mark,

On 5/5/20 11:47 AM, Mark Brown wrote:
> Provide a very basic selftest for getcpu() which similarly to our existing
> test for gettimeofday() looks up the function in the vDSO and prints the
> results it gets if the function exists and succeeds.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/vDSO/.gitignore       |  1 +
>   tools/testing/selftests/vDSO/Makefile         |  3 +-
>   .../testing/selftests/vDSO/vdso_test_getcpu.c | 50 +++++++++++++++++++
>   3 files changed, 53 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/vDSO/vdso_test_getcpu.c
> 
> diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
> index 74f49bd5f6dd..5eb64d41e541 100644
> --- a/tools/testing/selftests/vDSO/.gitignore
> +++ b/tools/testing/selftests/vDSO/.gitignore
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   vdso_test
>   vdso_test_gettimeofday
> +vdso_test_getcpu
>   vdso_standalone_test_x86
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index ae15d700b62e..0069f2f83f86 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -4,7 +4,7 @@ include ../lib.mk
>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>   
> -TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday
> +TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
>   ifeq ($(ARCH),x86)
>   TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
>   endif
> @@ -18,6 +18,7 @@ endif
>   
>   all: $(TEST_GEN_PROGS)
>   $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
> +$(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
>   $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
>   	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
>   		vdso_standalone_test_x86.c parse_vdso.c \
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
> new file mode 100644
> index 000000000000..a9dd3db145f3
> --- /dev/null
> +++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vdso_test_getcpu.c: Sample code to test parse_vdso.c and vDSO getcpu()
> + *
> + * Copyright (c) 2020 Arm Ltd
> + */
> +
> +#include <stdint.h>
> +#include <elf.h>
> +#include <stdio.h>
> +#include <sys/auxv.h>
> +#include <sys/time.h>
> +
> +#include "../kselftest.h"
> +#include "parse_vdso.h"
> +
> +const char *version = "LINUX_2.6";
> +const char *name = "__vdso_getcpu";
> +
> +struct getcpu_cache;
> +typedef long (*getcpu_t)(unsigned int *, unsigned int *,
> +			 struct getcpu_cache *);
> +
> +int main(int argc, char **argv)
> +{
> +	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);

WARNING: Missing a blank line after declarations
WARNING: Missing a blank line after declarations
#135: FILE: tools/testing/selftests/vDSO/vdso_test_getcpu.c:27:
+	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+	if (!sysinfo_ehdr) {

WARNING: Missing a blank line after declarations
#143: FILE: tools/testing/selftests/vDSO/vdso_test_getcpu.c:35:
+	getcpu_t get_cpu = (getcpu_t)vdso_sym(version, name);
+	if (!get_cpu) {

WARNING: Missing a blank line after declarations
#150: FILE: tools/testing/selftests/vDSO/vdso_test_getcpu.c:42:
+	long ret = get_cpu(&cpu, &node, 0);
+	if (ret == 0) {

Please send v2 for this one.

thanks,
-- Shuah

