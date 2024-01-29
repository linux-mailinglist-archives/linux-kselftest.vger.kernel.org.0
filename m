Return-Path: <linux-kselftest+bounces-3678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D283FBCE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 02:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70E2284BDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 01:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9D0D28D;
	Mon, 29 Jan 2024 01:28:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BE8DDA3;
	Mon, 29 Jan 2024 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706491698; cv=none; b=Ay4EtrPd6RbNsSK9zEYE7H/fI/R/Jgm0U0PmRmOkdi3HwKYLBWYG3F5l5hU+AhBpPJ6wj/cm+4CfFjlxUbdrcX/q9ymwEuyn3arhXezazb/R30cSfnuouW0g93s0VpndgfynMwebOuQZrc7jIBrJr1xj3BZ591esXLaDC7505Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706491698; c=relaxed/simple;
	bh=Lw72eSf10rqs9M4ILP3RajtxyQIU+eHOGp7ZrHxu5Vw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TuDZ011Jdy1ihKghDsORvxVR8S/+XejnW9umPqOtjzPzQpIfnyYMnn5eFaxCEH8c9IAAGJ1z1Adqe9H3qtwbAY+XiLiTL8fC6NH5iCOvlrNi2+q0yHfSMsLOIicMzB1CBo7zVdEz8dcGLxcVr+5mINE5pG94fq8Uct3kS15I/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8DxJ+gn_7ZlmpMHAA--.4333S3;
	Mon, 29 Jan 2024 09:28:07 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc8k_7ZliAskAA--.13536S3;
	Mon, 29 Jan 2024 09:28:06 +0800 (CST)
Subject: Re: [PATCH v6 4/4] KVM: selftests: Add test cases for LoongArch
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240125015420.1960090-1-maobibo@loongson.cn>
 <20240125015420.1960090-5-maobibo@loongson.cn> <ZbQV75Q-N_cJLhj6@google.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <2b3c7e2a-b748-5635-3f8d-71323a53b28d@loongson.cn>
Date: Mon, 29 Jan 2024 09:28:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZbQV75Q-N_cJLhj6@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxDc8k_7ZliAskAA--.13536S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XF48JFWfKFykuw45uFW3urX_yoWfZFXEqF
	4av3s7CrWkZ3WYqF48tw15CF4aqa1DXF4fZFZxtr1fXFWUJa13AFWkur95ArySqFZ5J39I
	kF4vkF1Y9rWUuosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUU
	U



On 2024/1/27 上午4:28, Sean Christopherson wrote:
> On Thu, Jan 25, 2024, Bibo Mao wrote:
>> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
>> index 075b80dbe237..7b09e59296be 100644
>> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
>> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
>> @@ -333,7 +333,7 @@ static void test_invalid_memory_region_flags(void)
>>   	struct kvm_vm *vm;
>>   	int r, i;
>>   
>> -#if defined __aarch64__ || defined __x86_64__
>> +#if defined __aarch64__ || defined __x86_64__ || __loongarch__
> 
> I assume that last one wants to be "defined __loongarch__"
Good catch, it should be "defined __loongarch__". And I will refresh
the patch in the next version.

Regards
Bibo Mao
> 
>>   	supported_flags |= KVM_MEM_READONLY;
>>   #endif
>>   
>> -- 
>> 2.39.3
>>


