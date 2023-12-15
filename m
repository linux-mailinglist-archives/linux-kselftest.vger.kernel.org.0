Return-Path: <linux-kselftest+bounces-2030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD28149AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1FF5B21547
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEF92E3FB;
	Fri, 15 Dec 2023 13:52:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D83032A;
	Fri, 15 Dec 2023 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B162F1C0004;
	Fri, 15 Dec 2023 13:52:33 +0000 (UTC)
Message-ID: <d0cd4629-9f12-4251-8dd5-274c093476b3@ghiti.fr>
Date: Fri, 15 Dec 2023 14:52:33 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tools: selftests: riscv: Fix compile warnings in
 hwprobe
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
 <20231123185821.2272504-2-christoph.muellner@vrull.eu>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231123185821.2272504-2-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 23/11/2023 19:58, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
>
> GCC prints a couple of format string warnings when compiling
> the hwprobe test. Let's follow the recommendation in
> Documentation/printk-formats.txt to fix these warnings.
>
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>   tools/testing/selftests/riscv/hwprobe/hwprobe.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/riscv/hwprobe/hwprobe.c b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
> index c474891df307..abb825811c70 100644
> --- a/tools/testing/selftests/riscv/hwprobe/hwprobe.c
> +++ b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
> @@ -29,7 +29,7 @@ int main(int argc, char **argv)
>   		/* Fail if the kernel claims not to recognize a base key. */
>   		if ((i < 4) && (pairs[i].key != i))
>   			ksft_exit_fail_msg("Failed to recognize base key: key != i, "
> -					   "key=%ld, i=%ld\n", pairs[i].key, i);
> +					   "key=%lld, i=%ld\n", pairs[i].key, i);
>   
>   		if (pairs[i].key != RISCV_HWPROBE_KEY_BASE_BEHAVIOR)
>   			continue;
> @@ -37,7 +37,7 @@ int main(int argc, char **argv)
>   		if (pairs[i].value & RISCV_HWPROBE_BASE_BEHAVIOR_IMA)
>   			continue;
>   
> -		ksft_exit_fail_msg("Unexpected pair: (%ld, %ld)\n", pairs[i].key, pairs[i].value);
> +		ksft_exit_fail_msg("Unexpected pair: (%lld, %llu)\n", pairs[i].key, pairs[i].value);
>   	}
>   
>   	out = riscv_hwprobe(pairs, 8, 0, 0, 0);

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Alex


