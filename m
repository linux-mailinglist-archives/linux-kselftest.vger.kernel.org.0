Return-Path: <linux-kselftest+bounces-2032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A848149BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE03281EE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB3F2E408;
	Fri, 15 Dec 2023 13:54:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53503033B;
	Fri, 15 Dec 2023 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E41BC0012;
	Fri, 15 Dec 2023 13:54:48 +0000 (UTC)
Message-ID: <28128de4-d65e-4358-9224-7c7b840126b4@ghiti.fr>
Date: Fri, 15 Dec 2023 14:54:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tools: selftests: riscv: Fix compile warnings in cbo
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
 <20231123185821.2272504-3-christoph.muellner@vrull.eu>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231123185821.2272504-3-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 23/11/2023 19:58, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
>
> GCC prints a couple of format string warnings when compiling
> the cbo test. Let's follow the recommendation in
> Documentation/printk-formats.txt to fix these warnings.
>
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>   tools/testing/selftests/riscv/hwprobe/cbo.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
> index 50a2cc8aef38..c6a83ab11e22 100644
> --- a/tools/testing/selftests/riscv/hwprobe/cbo.c
> +++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
> @@ -97,7 +97,7 @@ static void test_zicboz(void *arg)
>   	block_size = pair.value;
>   	ksft_test_result(rc == 0 && pair.key == RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE &&
>   			 is_power_of_2(block_size), "Zicboz block size\n");
> -	ksft_print_msg("Zicboz block size: %ld\n", block_size);
> +	ksft_print_msg("Zicboz block size: %llu\n", block_size);
>   
>   	illegal_insn = false;
>   	cbo_zero(&mem[block_size]);
> @@ -121,7 +121,7 @@ static void test_zicboz(void *arg)
>   		for (j = 0; j < block_size; ++j) {
>   			if (mem[i * block_size + j] != expected) {
>   				ksft_test_result_fail("cbo.zero check\n");
> -				ksft_print_msg("cbo.zero check: mem[%d] != 0x%x\n",
> +				ksft_print_msg("cbo.zero check: mem[%llu] != 0x%x\n",
>   					       i * block_size + j, expected);
>   				return;
>   			}
> @@ -201,7 +201,7 @@ int main(int argc, char **argv)
>   	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
>   	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&cpus, 0);
>   	if (rc < 0)
> -		ksft_exit_fail_msg("hwprobe() failed with %d\n", rc);
> +		ksft_exit_fail_msg("hwprobe() failed with %ld\n", rc);
>   	assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
>   
>   	if (pair.value & RISCV_HWPROBE_EXT_ZICBOZ) {


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Alex


