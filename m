Return-Path: <linux-kselftest+bounces-38678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D7EB2065D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 12:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC56417C66E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D9F27F000;
	Mon, 11 Aug 2025 10:51:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE87270ED7;
	Mon, 11 Aug 2025 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909467; cv=none; b=EJQNZiQIeABcx++9zJmjlLrxYGIx45C8pGg7WyBfXp8OCmaN3Vemf3ZcwzuMmtDd9fvV1iZDychzhv4THEzc6OSf4iy8aOsKYUv1tjosZRq0fgjnb5A22G5flqQ62C8KGkm/IY4AoTbeF5rbmg5mBHADffLppDXXVGAyhWjy5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909467; c=relaxed/simple;
	bh=oCocNIgOu43l9PMMMAdWVG/UZpa3tR5OOkjm0GU2wf4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aFVRTxvI32y73uHJCJOGzP2wvI8ycT+kxnm3RJGtiouAL8x1cix4kOnIgVTCVdJokFYo0I/o59Xnp246MdM5cGFRDYc31g95xYaHbaTIJqT/LR5wr7r3B+d92AcMuyS6cna8YJ3prFTqCADuBxUMc8jHTWpt7khy4sZUd6WDpWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxDGsUy5lo828+AQ--.52946S3;
	Mon, 11 Aug 2025 18:51:00 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxQMIRy5loZzdDAA--.48919S3;
	Mon, 11 Aug 2025 18:50:59 +0800 (CST)
Subject: Re: [PATCH] KVM: loongarch: selftests: Remove common tests built by
 TEST_GEN_PROGS_COMMON
To: Dong Yang <dayss1224@gmail.com>, pbonzini@redhat.com, shuah@kernel.org
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenhaucai@kernel.org,
 Quan Zhou <zhouquan@iscas.ac.cn>
References: <20250811082453.1167448-1-dayss1224@gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <11d1992d-baf0-fc2f-19d7-b263d15cf64d@loongson.cn>
Date: Mon, 11 Aug 2025 18:49:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250811082453.1167448-1-dayss1224@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxQMIRy5loZzdDAA--.48919S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF4rKF1rAry7Cr15Xry3KFX_yoW8ZryUpr
	yS9rsFvFy8Zrs7Grn7Gw1DXan2kryqgF4vgF1xtw48Cry5JF48AF10k3s3KFnYq3y0vr4a
	v3WfKrnF9ayDJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
	UUUU=

Hi Dong,

Thanks for you patch.

On 2025/8/11 下午4:24, Dong Yang wrote:
> Remove the common KVM test cases already added to TEST_GEN_PROGS_COMMON
>   as following:
> 
> 	demand_paging_test
> 	dirty_log_test
> 	guest_print_test
> 	kvm_binary_stats_test
> 	kvm_create_max_vcpus
> 	kvm_page_table_test
> 	set_memory_region_test
> 
> Fixes: a867688c8cbb ("KVM: selftests: Add supported test cases for LoongArch")
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Dong Yang <dayss1224@gmail.com>
> ---
>   tools/testing/selftests/kvm/Makefile.kvm | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 38b95998e1e6..d2ad85a8839f 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -199,17 +199,10 @@ TEST_GEN_PROGS_riscv += get-reg-list
>   TEST_GEN_PROGS_riscv += steal_time
>   
TEST_GEN_PROGS_loongarch = $(TEST_GEN_PROGS_COMMON) is missing.

BTW irqfd_test in TEST_GEN_PROGS_COMMON fails to run on LoongArch, does 
this test case pass to run on Riscv?

Regards
Bibo Mao
>   TEST_GEN_PROGS_loongarch += coalesced_io_test
> -TEST_GEN_PROGS_loongarch += demand_paging_test
>   TEST_GEN_PROGS_loongarch += dirty_log_perf_test
> -TEST_GEN_PROGS_loongarch += dirty_log_test
> -TEST_GEN_PROGS_loongarch += guest_print_test
>   TEST_GEN_PROGS_loongarch += hardware_disable_test
> -TEST_GEN_PROGS_loongarch += kvm_binary_stats_test
> -TEST_GEN_PROGS_loongarch += kvm_create_max_vcpus
> -TEST_GEN_PROGS_loongarch += kvm_page_table_test
>   TEST_GEN_PROGS_loongarch += memslot_modification_stress_test
>   TEST_GEN_PROGS_loongarch += memslot_perf_test
> -TEST_GEN_PROGS_loongarch += set_memory_region_test
>   
>   SPLIT_TESTS += arch_timer
>   SPLIT_TESTS += get-reg-list
> 


