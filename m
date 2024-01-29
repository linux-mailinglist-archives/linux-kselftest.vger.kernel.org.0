Return-Path: <linux-kselftest+bounces-3679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815AD83FC54
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 03:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EE61F2148E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 02:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D46EECC;
	Mon, 29 Jan 2024 02:41:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE75DDD7;
	Mon, 29 Jan 2024 02:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706496094; cv=none; b=UhVNi7XZSYF8W31aRgfdLMK65HNhLGOfAiZS14GgBbzPzpi8lE5sut2lpxr8tahW+fGPzBI9/USMzKr3KXQ32/zGJWLQ16NMYUHRzy6lAJYoRnyD4BJEvVg5Bx1uZuOp1lUJ1hhfBRJ68IX9E0U2lhqN2nZ/sW7hLXWSVDpcXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706496094; c=relaxed/simple;
	bh=BZnih3B4LHOUfu+8lJbv8SbVzOo9wGNFWAuJnC18Guw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sRJ/9Q/DCg4/rRVZK7pyuJj7J8utw9PpSQ4B4m6qp+4JbZdgZS3vPSWINQNAZ0OjuT6COCvpfIRTTHCtLkzfeBYB8gxPQxXWiz8PlzOWyaRhK4ZHslMCq5ZetJ5Usy2EduHEVwf/b0EI+XGQng6S6grNkNze2WsOhKeXcVIH8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8CxmehZELdlLJgHAA--.4481S3;
	Mon, 29 Jan 2024 10:41:29 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf89WELdl_jokAA--.13380S3;
	Mon, 29 Jan 2024 10:41:28 +0800 (CST)
Subject: Re: [PATCH v6 0/4] VM: selftests: Add LoongArch support
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240125015420.1960090-1-maobibo@loongson.cn>
 <ZbQW0yfI08qwXcfQ@google.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <cd42d246-896d-56a9-8dc3-6c998695aad2@loongson.cn>
Date: Mon, 29 Jan 2024 10:41:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZbQW0yfI08qwXcfQ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxf89WELdl_jokAA--.13380S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrWruFWxAr17CF1fKw4fXrc_yoW8CF18pa
	yvk3WrKr48KF1xAF93X34vqr1ft3Z2kF4Iy3WaqryUZw47tr1xJw1xKF97Ca43Z3s5XryF
	va4Ig3W3W3WUJacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
	UUUU=



On 2024/1/27 上午4:32, Sean Christopherson wrote:
> On Thu, Jan 25, 2024, Bibo Mao wrote:
>> ---
>> Tianrui Zhao (4):
>>    KVM: selftests: Add KVM selftests header files for LoongArch
>>    KVM: selftests: Add core KVM selftests support for LoongArch
>>    KVM: selftests: Add ucall test support for LoongArch
>>    KVM: selftests: Add test cases for LoongArch
>>
>>   tools/testing/selftests/kvm/Makefile          |  16 +
>>   .../selftests/kvm/include/kvm_util_base.h     |   5 +
>>   .../kvm/include/loongarch/processor.h         | 133 +++++++
>>   .../selftests/kvm/include/loongarch/ucall.h   |  20 ++
>>   .../selftests/kvm/lib/loongarch/exception.S   |  59 ++++
>>   .../selftests/kvm/lib/loongarch/processor.c   | 332 ++++++++++++++++++
>>   .../selftests/kvm/lib/loongarch/ucall.c       |  38 ++
>>   .../selftests/kvm/set_memory_region_test.c    |   2 +-
>>   8 files changed, 604 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/testing/selftests/kvm/include/loongarch/processor.h
>>   create mode 100644 tools/testing/selftests/kvm/include/loongarch/ucall.h
>>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/exception.S
>>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/processor.c
>>   create mode 100644 tools/testing/selftests/kvm/lib/loongarch/ucall.c
> 
> I did a *very* quick read through and didn't see anything egregious.  I really
> hope that someday we can deduplicate much of the ARM/RISC-V/LoongArch code, but
> that's no reason to hold up getting selftests support merged.
> 
kvm seltests for LoongArch originally comes from ARM64, especially ucall 
and page table walk code. And LoongArch kvm actually benefits much from 
open source code, we will deduplicate some ARM/RISC-V/LoongArch kvm 
selftests code when LoongArch KVM is basically supported.

Regards
Bibo Mao



