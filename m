Return-Path: <linux-kselftest+bounces-19706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8C999DF58
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 09:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449551F222BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56C2179972;
	Tue, 15 Oct 2024 07:32:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D652AE94;
	Tue, 15 Oct 2024 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977524; cv=none; b=qBtHtbHeSoy3ud8o/Q//oomgGDp1SB+QOOgbzR/pY31TqAkeHG7ygOF6ypeCzmo6f4VSWvUxGlcYTxqS7zhbdWTeZurf0CeQPT8GvL1bmyJ4iPTWif7V1Qsr/x6WFc3qJoPPJpWSGPwVSnUVHMTdI04fwM+2yaD3YuR8E94T6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977524; c=relaxed/simple;
	bh=XvC7Z8cSiXh6eCoO1h2M5BikZzrqcBMKoBxig6SJup4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pjBqR2TGLITHeAQVTP9dQlGEASje4cVXFhMXz+L1GXZ2YHNTzapSMcMzVftxwLjSiv1IT4/I3AyrARkBTUfBYjc9eflILo2Z2LDjgkUkiuee5RZ5KRZ7HhGiSStRXNjqfSFDwAhF8MPkfeFJZWxquumWTqVng6Z6ko9IMkQfXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxfWtuGg5nAggdAA--.41608S3;
	Tue, 15 Oct 2024 15:31:58 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMDxL9ZsGg5ntKAqAA--.3118S3;
	Tue, 15 Oct 2024 15:31:56 +0800 (CST)
Subject: Re: [PATCH 4/4] kunit: qemu_configs: loongarch: Enable shutdown
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas.weissschuh@linutronix.de>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
 <20241014-kunit-loongarch-v1-4-1699b2ad6099@linutronix.de>
From: maobibo <maobibo@loongson.cn>
Message-ID: <1fde4047-45cf-f6f2-7fd4-f0d6eb5d6de3@loongson.cn>
Date: Tue, 15 Oct 2024 15:31:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241014-kunit-loongarch-v1-4-1699b2ad6099@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxL9ZsGg5ntKAqAA--.3118S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF43tF4rZr47JF4fZrWkAFc_yoW8XF1kpr
	Z7ZF90gF1rGF1fXr4xGryqgFZ5WrsrArW2gFW3JryrurZ3Jw1rur18t3sFqasFga98tayF
	qFZ2q3WYgF1UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j873
	kUUUUU=

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

On 2024/10/14 下午7:36, Thomas Weißschuh wrote:
> QEMU for LoongArch does not yet support shutdown/restart through ACPI.
> Use the pvpanic driver to enable shutdowns.
> This requires 9.1.0 for shutdown support in pvpanic, but that is the
> requirement of kunit on LoongArch anyways.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/kunit/qemu_configs/loongarch.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
> index e7bb7c07819677dfdefac012821a732555813cae..1d2b780fbd5c0bde20aa6a5cd1217d0b3b443a93 100644
> --- a/tools/testing/kunit/qemu_configs/loongarch.py
> +++ b/tools/testing/kunit/qemu_configs/loongarch.py
> @@ -4,13 +4,16 @@ QEMU_ARCH = QemuArchParams(linux_arch='loongarch',
>   			   kconfig='''
>   CONFIG_EFI_STUB=n
>   CONFIG_PCI_HOST_GENERIC=y
> +CONFIG_PVPANIC=y
> +CONFIG_PVPANIC_PCI=y
>   CONFIG_SERIAL_8250=y
>   CONFIG_SERIAL_8250_CONSOLE=y
>   CONFIG_SERIAL_OF_PLATFORM=y
>   ''',
>   			   qemu_arch='loongarch64',
>   			   kernel_path='arch/loongarch/boot/vmlinux.elf',
> -			   kernel_command_line='console=ttyS0',
> +			   kernel_command_line='console=ttyS0 kunit_shutdown=poweroff',
>   			   extra_qemu_params=[
>   					   '-machine', 'virt',
> +					   '-device', 'pvpanic-pci',
>   					   '-cpu', 'max',])
> 


