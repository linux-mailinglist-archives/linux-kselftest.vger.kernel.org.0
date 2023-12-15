Return-Path: <linux-kselftest+bounces-2029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80BB81499D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9BE1C209FA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B244F2E3F3;
	Fri, 15 Dec 2023 13:50:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC92DB88;
	Fri, 15 Dec 2023 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04DB12000E;
	Fri, 15 Dec 2023 13:50:47 +0000 (UTC)
Message-ID: <0b4f729b-fe97-4a42-b00c-d3e908cb3839@ghiti.fr>
Date: Fri, 15 Dec 2023 14:50:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tools: selftests: riscv: Fix compile warnings in mm
 tests
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
 <20231123185821.2272504-6-christoph.muellner@vrull.eu>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231123185821.2272504-6-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 23/11/2023 19:58, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
>
> When building the mm tests with a riscv32 compiler, we see a range
> of shift-count-overflow errors from shifting 1UL by more than 32 bits
> in do_mmaps(). Since, the relevant code is only called from code that
> is gated by `__riscv_xlen == 64`, we can just apply the same gating
> to do_mmaps().
>
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>   tools/testing/selftests/riscv/mm/mmap_test.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/riscv/mm/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
> index 9b8434f62f57..2e0db9c5be6c 100644
> --- a/tools/testing/selftests/riscv/mm/mmap_test.h
> +++ b/tools/testing/selftests/riscv/mm/mmap_test.h
> @@ -18,6 +18,8 @@ struct addresses {
>   	int *on_56_addr;
>   };
>   
> +// Only works on 64 bit
> +#if __riscv_xlen == 64
>   static inline void do_mmaps(struct addresses *mmap_addresses)
>   {
>   	/*
> @@ -50,6 +52,7 @@ static inline void do_mmaps(struct addresses *mmap_addresses)
>   	mmap_addresses->on_56_addr =
>   		mmap(on_56_bits, 5 * sizeof(int), prot, flags, 0, 0);
>   }
> +#endif /* __riscv_xlen == 64 */
>   
>   static inline int memory_layout(void)
>   {


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Alex


