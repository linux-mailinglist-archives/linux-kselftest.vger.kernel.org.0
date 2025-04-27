Return-Path: <linux-kselftest+bounces-31724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6051A9DED6
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 05:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D087A3C53
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Apr 2025 03:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6581E231E;
	Sun, 27 Apr 2025 03:43:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62784A00;
	Sun, 27 Apr 2025 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745725409; cv=none; b=T0Fa1b6FxISkdnor1iDgsSI1KuqkHVeUAKDIwT3KMBysh8wSjmPFvBsBpWsLdmlqqikyt1aXQ5P+J6KwxB8NWXB1cp+yxwe8LK5TSAu4RRjKe0mPV9wgg/6B06rERX+SD5t1g5UIjaLTFlLcc7uwYrBLiEBm6dpp+0PcAmD5dWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745725409; c=relaxed/simple;
	bh=UM0I+UTBRS4HXc0oTrQwxl9z8J4KqabmORxfiB11FCg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Jz6wW7VrGqw40bzwT1Q7X0ObhKK7VMLYDOcQaD958TQEu+GPTjXuO2qpXbX5awN9t4v8V7ptNS1hGEo4vAAF2RCHWKRDsr8gM68ayU/Jt8Joadl8GSQbx6DlUL1nCF6zKm4tjetsXJdk4huZ0hv0M4Y3v4+cm04aoPm+SZnZvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8CxieDapw1omA_HAA--.23845S3;
	Sun, 27 Apr 2025 11:43:22 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMDx_MTXpw1oMvuXAA--.50512S3;
	Sun, 27 Apr 2025 11:43:21 +0800 (CST)
Subject: Re: [PATCH v10 2/5] KVM: selftests: Add KVM selftests header files
 for LoongArch
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250421073110.2259397-1-maobibo@loongson.cn>
 <20250421073110.2259397-3-maobibo@loongson.cn> <aAwqAM2JKxpsSWfu@google.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <55135103-9bdf-6f22-9648-0664263ba00b@loongson.cn>
Date: Sun, 27 Apr 2025 11:42:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aAwqAM2JKxpsSWfu@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx_MTXpw1oMvuXAA--.50512S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
	AS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF
	0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07j1WlkUUUUU=



On 2025/4/26 上午8:34, Sean Christopherson wrote:
> On Mon, Apr 21, 2025, Bibo Mao wrote:
>> Add KVM selftests header files for LoongArch, including processor.h
>> and kvm_util_base.h.
> 
> Nit, kvm_util_arch.h, not kvm_util_base.h.  I only noticed because I still have
> nightmares about kvm_util_base.h. :-)
Nice catch, will refresh in next version.
And thanks for your reviewing.

Regards
Bibo Mao


