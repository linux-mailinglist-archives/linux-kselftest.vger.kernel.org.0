Return-Path: <linux-kselftest+bounces-19705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E680899DF56
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 09:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DCB28292D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 07:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A6C17DFE3;
	Tue, 15 Oct 2024 07:31:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA69474;
	Tue, 15 Oct 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977492; cv=none; b=fQmNKYN2Uh2XxbUvNXFGGgWRkRzqmlC0O43DWF0z4QAyksxaF5MuB7T82j5/8fOWphq7ytiA8iIq/3e2Qdig4M5FGb2cOUnesaXBjjjeU3jZFsPv5O+Q6IApO+75NEJl/xWMx9D9F/ZNFueXLuXzT5VD8T5TpQ6xhwgonQzlHVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977492; c=relaxed/simple;
	bh=qkl07GsDAQF6Pr/zHIiOpWct36waJvB8FxgzPaEqV0o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G1b5zTnpVAcaKSyN+qxx1CLJFlm/0fmuRtMB7p9O8LYaWLa804et3QD7mLAIX3q8OopzQ7xf+PmKXjSGISsQ3EqVpnAeKZ/kskp+UKiwilwk7Q/9EjfFZU+pymKNw2anAxEuMpW4oxYzpKjI32yH+/INSYyvrur7VOoZskSnpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Axw3BNGg5nrAcdAA--.42145S3;
	Tue, 15 Oct 2024 15:31:25 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMCx3tVLGg5nbKAqAA--.21873S3;
	Tue, 15 Oct 2024 15:31:23 +0800 (CST)
Subject: Re: [PATCH 2/4] kunit: qemu_configs: add LoongArch config
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas.weissschuh@linutronix.de>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
 <20241014-kunit-loongarch-v1-2-1699b2ad6099@linutronix.de>
From: maobibo <maobibo@loongson.cn>
Message-ID: <0de2d738-0ace-3c17-8ee5-cc307725e27b@loongson.cn>
Date: Tue, 15 Oct 2024 15:31:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241014-kunit-loongarch-v1-2-1699b2ad6099@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx3tVLGg5nbKAqAA--.21873S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFWfAF4fKryfuF1ruFyUArc_yoW8Gr1xpr
	WxZay5Kr48KF1fXws7Gryq9FWrGrs2kF42gFW3JryrWrZ8G348uw10g342vFnFy398t3WF
	qFWvqFn0qF1UJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4cdbUU
	UUU

Hi Thomas,

Thanks for work it out on LoongArch.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

On 2024/10/14 下午7:36, Thomas Weißschuh wrote:
> Add a basic config to run kunit tests on LoongArch.
> This requires QEMU 9.1.0 or later for the necessary direct kernel boot
> support.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/kunit/qemu_configs/loongarch.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
> new file mode 100644
> index 0000000000000000000000000000000000000000..e7bb7c07819677dfdefac012821a732555813cae
> --- /dev/null
> +++ b/tools/testing/kunit/qemu_configs/loongarch.py
> @@ -0,0 +1,16 @@
> +from ..qemu_config import QemuArchParams
> +
> +QEMU_ARCH = QemuArchParams(linux_arch='loongarch',
> +			   kconfig='''
> +CONFIG_EFI_STUB=n
> +CONFIG_PCI_HOST_GENERIC=y
> +CONFIG_SERIAL_8250=y
> +CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +''',
> +			   qemu_arch='loongarch64',
> +			   kernel_path='arch/loongarch/boot/vmlinux.elf',
> +			   kernel_command_line='console=ttyS0',
> +			   extra_qemu_params=[
> +					   '-machine', 'virt',
> +					   '-cpu', 'max',])
> 


