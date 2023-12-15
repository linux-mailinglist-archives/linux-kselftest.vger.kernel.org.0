Return-Path: <linux-kselftest+bounces-2028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5370D81498A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867221C222F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C192C852;
	Fri, 15 Dec 2023 13:44:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED72F840;
	Fri, 15 Dec 2023 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DA31FF80F;
	Fri, 15 Dec 2023 13:44:25 +0000 (UTC)
Message-ID: <30f8bb02-5271-4a6a-9f59-12382b6e41a0@ghiti.fr>
Date: Fri, 15 Dec 2023 14:44:25 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tools: selftests: riscv: Fix compile warnings in
 vector tests
Content-Language: en-US
To: Christoph Muellner <christoph.muellner@vrull.eu>,
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Shuah Khan <shuah@kernel.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andrew Jones <ajones@ventanamicro.com>, Evan Green <evan@rivosinc.com>,
 Xiao Wang <xiao.w.wang@intel.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andy Chiu <andy.chiu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
 <20231123185821.2272504-5-christoph.muellner@vrull.eu>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231123185821.2272504-5-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 23/11/2023 19:58, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
>
> GCC prints a couple of format string warnings when compiling
> the vector tests. Let's follow the recommendation in
> Documentation/printk-formats.txt to fix these warnings.
>
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>   tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 2 +-
>   tools/testing/selftests/riscv/vector/vstate_prctl.c     | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
> index 66764edb0d52..1dd94197da30 100644
> --- a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
> +++ b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
> @@ -27,7 +27,7 @@ int main(void)
>   
>   	datap = malloc(MAX_VSIZE);
>   	if (!datap) {
> -		ksft_test_result_fail("fail to allocate memory for size = %lu\n", MAX_VSIZE);
> +		ksft_test_result_fail("fail to allocate memory for size = %d\n", MAX_VSIZE);
>   		exit(-1);
>   	}
>   
> diff --git a/tools/testing/selftests/riscv/vector/vstate_prctl.c b/tools/testing/selftests/riscv/vector/vstate_prctl.c
> index b348b475be57..8ad94e08ff4d 100644
> --- a/tools/testing/selftests/riscv/vector/vstate_prctl.c
> +++ b/tools/testing/selftests/riscv/vector/vstate_prctl.c
> @@ -68,7 +68,7 @@ int test_and_compare_child(long provided, long expected, int inherit)
>   	}
>   	rc = launch_test(inherit);
>   	if (rc != expected) {
> -		ksft_test_result_fail("Test failed, check %d != %d\n", rc,
> +		ksft_test_result_fail("Test failed, check %d != %ld\n", rc,
>   				      expected);
>   		return -2;
>   	}
> @@ -87,7 +87,7 @@ int main(void)
>   	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
>   	rc = riscv_hwprobe(&pair, 1, 0, NULL, 0);
>   	if (rc < 0) {
> -		ksft_test_result_fail("hwprobe() failed with %d\n", rc);
> +		ksft_test_result_fail("hwprobe() failed with %ld\n", rc);
>   		return -1;
>   	}
>   


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Alex


