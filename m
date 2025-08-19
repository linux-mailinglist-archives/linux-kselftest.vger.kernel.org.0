Return-Path: <linux-kselftest+bounces-39267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D123B2B5AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 03:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F093AD875
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 01:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D88126F0A;
	Tue, 19 Aug 2025 01:03:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3694C1CA81;
	Tue, 19 Aug 2025 01:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755565431; cv=none; b=AybWCtAXp9l4tLPiwMbKeYs5/26R0nSpJi87JR0oPTdamg9bnF3Dyb3FcKP7QUcR0Gs5Z4cSzd+rNK2F9D4qbD2wxnSOSv8Dnr6B7z8hwoG0zP/wIqXzNkuPUDup0cPj0RtIL+qvAikjxmlZC6M2x5InZ4o6sv1ILHiooO/Z4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755565431; c=relaxed/simple;
	bh=hKTQRaoNIqjDRqMkHHqIHOMNz8DoDmVCJIZc1XXRr4Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FZZidMXAsUUFVFiO4nGtZ0/XkJwo3j2NoQB/aljNmnMQm/sx7g6V3QeVlEm7aO65NLKAQUYWsGaPJTqd5lSIAzE+2+FLpFCg1ExdRKWOBiP55kD4eTzaJqkvd948pOLvF98OiWSx7/PjHoIeKZvU88ja9J9rhFW4cnl1jiVWDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Cxf9NqzaNolCUAAA--.318S3;
	Tue, 19 Aug 2025 09:03:38 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxM+RfzaNozyRXAA--.4222S3;
	Tue, 19 Aug 2025 09:03:29 +0800 (CST)
Subject: Re: [PATCH] KVM: loongarch: selftests: Remove common tests built by
 TEST_GEN_PROGS_COMMON
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Dong Yang <dayss1224@gmail.com>, pbonzini@redhat.com, shuah@kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, chenhaucai@kernel.org,
 Quan Zhou <zhouquan@iscas.ac.cn>
References: <20250811082453.1167448-1-dayss1224@gmail.com>
 <11d1992d-baf0-fc2f-19d7-b263d15cf64d@loongson.cn>
 <20250818-2e6cf1b89c738f0fb1264811@orel>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <02ad7973-f1d9-573b-8986-9a13e51aa661@loongson.cn>
Date: Tue, 19 Aug 2025 09:01:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250818-2e6cf1b89c738f0fb1264811@orel>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxM+RfzaNozyRXAA--.4222S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur4UKr1fWrW8KFyUCF43CFX_yoW5urWUpr
	WI9F129FW0vrs3Gr1fGw1DZFZFkr9rKF40gF1rtw48Ary5AFs7JF18trW5KFnYqw4UXF4a
	9a4rKwnFvFWDAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
	JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU



On 2025/8/19 上午8:30, Andrew Jones wrote:
> On Mon, Aug 11, 2025 at 06:49:07PM +0800, Bibo Mao wrote:
>> Hi Dong,
>>
>> Thanks for you patch.
>>
>> On 2025/8/11 下午4:24, Dong Yang wrote:
>>> Remove the common KVM test cases already added to TEST_GEN_PROGS_COMMON
>>>    as following:
>>>
>>> 	demand_paging_test
>>> 	dirty_log_test
>>> 	guest_print_test
>>> 	kvm_binary_stats_test
>>> 	kvm_create_max_vcpus
>>> 	kvm_page_table_test
>>> 	set_memory_region_test
>>>
>>> Fixes: a867688c8cbb ("KVM: selftests: Add supported test cases for LoongArch")
>>> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
>>> Signed-off-by: Dong Yang <dayss1224@gmail.com>
>>> ---
>>>    tools/testing/selftests/kvm/Makefile.kvm | 7 -------
>>>    1 file changed, 7 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
>>> index 38b95998e1e6..d2ad85a8839f 100644
>>> --- a/tools/testing/selftests/kvm/Makefile.kvm
>>> +++ b/tools/testing/selftests/kvm/Makefile.kvm
>>> @@ -199,17 +199,10 @@ TEST_GEN_PROGS_riscv += get-reg-list
>>>    TEST_GEN_PROGS_riscv += steal_time
>> TEST_GEN_PROGS_loongarch = $(TEST_GEN_PROGS_COMMON) is missing.
>>
>> BTW irqfd_test in TEST_GEN_PROGS_COMMON fails to run on LoongArch, does this
>> test case pass to run on Riscv?
> 
> It appears to. It outputs the vm mode created and then exits with a zero
> exit code.
Here is output of irqfd test on LoongArch
[root@kvm-131 kvm]# ./irqfd_test
Random seed: 0x6b8b4567
==== Test Assertion Failure ====
   include/kvm_util.h:527: !ret
   pid=4016 tid=4016 errno=11 - Resource temporarily unavailable
      1  0x00000001200027ab: kvm_irqfd at kvm_util.h:527
      2  0x00000001200020d7: main at irqfd_test.c:100
      3  0x00007ffff38a8707: ?? ??:0
      4  0x00007ffff38a87ef: ?? ??:0
      5  0x00000001200023b7: _start at ??:?
   KVM_IRQFD failed, rc: -1 errno: 11 (Resource temporarily unavailable)

The problem is that kernel irqchip is not created with irqfd_test, and 
function kvm_arch_intc_initialized() returns false on LongArch.
/*
  * returns true if the virtual interrupt controller is initialized and
  * ready to accept virtual IRQ. On some architectures virtual interrupt
  * controller is dynamically instantiated and this is not always true.
  */
bool kvm_arch_intc_initialized(struct kvm *kvm);

On LoongArch virtual irqchip is dynamically created by VMM.

Regards
Bibo Mao
> 
> Thanks,
> drew
> 
>>
>> Regards
>> Bibo Mao
>>>    TEST_GEN_PROGS_loongarch += coalesced_io_test
>>> -TEST_GEN_PROGS_loongarch += demand_paging_test
>>>    TEST_GEN_PROGS_loongarch += dirty_log_perf_test
>>> -TEST_GEN_PROGS_loongarch += dirty_log_test
>>> -TEST_GEN_PROGS_loongarch += guest_print_test
>>>    TEST_GEN_PROGS_loongarch += hardware_disable_test
>>> -TEST_GEN_PROGS_loongarch += kvm_binary_stats_test
>>> -TEST_GEN_PROGS_loongarch += kvm_create_max_vcpus
>>> -TEST_GEN_PROGS_loongarch += kvm_page_table_test
>>>    TEST_GEN_PROGS_loongarch += memslot_modification_stress_test
>>>    TEST_GEN_PROGS_loongarch += memslot_perf_test
>>> -TEST_GEN_PROGS_loongarch += set_memory_region_test
>>>    SPLIT_TESTS += arch_timer
>>>    SPLIT_TESTS += get-reg-list
>>>
>>


