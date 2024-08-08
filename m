Return-Path: <linux-kselftest+bounces-15024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342AB94BD21
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 14:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073881C227D9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94E218C346;
	Thu,  8 Aug 2024 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="hc4vZEWs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1AE18C33F;
	Thu,  8 Aug 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119221; cv=pass; b=oNofKVVrMQzBMkkxJ27vkb1R6AjSvZ+diZqrYrwT2iCHhsMH9ylWDv1ICV+M8pw0cPeK2VqY8z0fQS7ussKD6nos9L69M+Jvfnxd3M+Et//5jo8aibv6i0wgpKmkc6AyzQMTuA46RlNwRDhIofE52MmHGLnymJbXHViUR49YQXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119221; c=relaxed/simple;
	bh=QzvagPocBMPggTIX12bFJFKHgxeSG5y1VbNlylh5auc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Soj1nZTZBViavvEpXPNIg6KurQs/dlrHR8G/o/uyafkkX/Rv12RZk9Hf6ILvHwdsfdm5aQo6x9jYH3gjWq+dOl7wOT3VGGowZouQ8o0xiMcePoW1zNXAHcbJYA5zz73m6mteR+FNez7pYCWUmbTe6W80PScsb3QbHP85aO0Kx+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=hc4vZEWs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723119202; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U99jicL82PCU1jrffm1R1ZbeESCSBg/8lvQ+9bAGyhCmzFLK0lOej7eAPYmikE5k2CDYBkVcRH4N0Bd48CqlRQMbuHPyujEEE4zJIMvPee2wsuZLeLyuYBs2BPNyqyIDtcGB+e8EIRLEsvGl5kXWrd2x/Wn4mtujfglO5sJE/7g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723119202; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hq/XaxzCcWVgtRDvj+CIXL2RHMKW1r7R6H31mG379zE=; 
	b=JfvEGCaD/+W1DgbcT7VRX3rbOkuysH0VlxtIKeTABn9/hUMhQuyt/3NaP4X/FQ5OedHm6o1+qialv/cwuT3NLlzrJTOHQeG7Ud3BdRYqwdi/lyI/Fc91wMqUJU9v+QgL45ixs9cng3VhTI82v22acGhOvkhS5JYoL7CewN//wCs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723119202;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hq/XaxzCcWVgtRDvj+CIXL2RHMKW1r7R6H31mG379zE=;
	b=hc4vZEWshPSf5fKC1bwqzBqN7xmtwi1FLpzXxR3rylQKjyy5i15u3YGWNUMzJQ/R
	LwjUDHplhxD7lyuMKt8dAIQn8fg6spylzDwfEy9iMJm57LBS1HUuFK59BKTrwW37WLY
	0Im6RWethigeqy0zCVLaEsfu1ku5u6Ufw70F4Hwk=
Received: by mx.zohomail.com with SMTPS id 1723119200600165.83064247266782;
	Thu, 8 Aug 2024 05:13:20 -0700 (PDT)
Message-ID: <c2aaa06e-e86d-4af9-bce4-6067e53cdf39@collabora.com>
Date: Thu, 8 Aug 2024 17:13:12 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, kernel@collabora.com, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests: kvm: fix mkdir error when building for
 non-supported arch
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
References: <20240806121029.1199794-1-usama.anjum@collabora.com>
 <6a3b2f3c-b733-4f64-a550-2f7dcbaf7cb7@linuxfoundation.org>
 <ca500f5c-57e7-43bc-9a1a-015021582af2@collabora.com>
 <5703a55a-95ab-44ee-a070-2bca6e9e23bc@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <5703a55a-95ab-44ee-a070-2bca6e9e23bc@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Adding Sean

On 8/7/24 11:33 AM, Muhammad Usama Anjum wrote:
> On 8/7/24 11:08 AM, Muhammad Usama Anjum wrote:
>> On 8/6/24 9:00 PM, Shuah Khan wrote:
>>> On 8/6/24 06:10, Muhammad Usama Anjum wrote:
>>>> The mkdir generates an error when kvm suite is build for non-supported
>>>
>>> built
>>> unsupported
>>>
>>>> architecture such as arm. Fix it by ignoring the error from mkdir.
>>>>
>>>> mkdir: missing operand
>>>> Try 'mkdir --help' for more information.
>>>
>>> Simply suppressing the message isn't a good fix. Can you investigate
>>> a bit more on why mkdir is failing and the architectures it is failing
>>> on?
>>>
>>> This change simply suppresses the error message and continues - Should
>>> this error end the build process or not run mkdir to begin with by
>>> checking why $(sort $(dir $(TEST_GEN_PROGS)))) results in an empty
>>> string?
>> The tests are specified on per architecture basis. As KVM isn't supported on arm, there are no tests in TEST_GEN_PROGS and it is empty. While lib.mk infrastructure has support to ignore and not build anything in such cases, the Makefile's behaviour isn't robust enough.
>>
>> I think the better fix would be to check if TEST_GEN_PROGS isn't empty and then call mkdir. I'll reiterate and send the fix.
> 
> Waiting on Paolo's response before sending the following fix. Maybe he
> has better idea here.
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -317,7 +317,9 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
>  $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>  	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
> 
> -$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
> +ifneq ($(strip $(TEST_GEN_PROGS)),)
> +$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
> +endif
>  $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
>  $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
>  $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
Do you agree with the fix or is there better fix? Please feel free to
jump in to propose better fix here.

> 
> 
>>
>>>
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>>   tools/testing/selftests/kvm/Makefile | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>>>> index 48d32c5aa3eb7..8ff46a0a8d1cd 100644
>>>> --- a/tools/testing/selftests/kvm/Makefile
>>>> +++ b/tools/testing/selftests/kvm/Makefile
>>>> @@ -317,7 +317,7 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
>>>>   $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>>>>       $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
>>>>   -$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
>>>> +$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))) > /dev/null 2>&1)
>>>>   $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
>>>>   $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
>>>>   $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
>>>
>>>
>>> thanks,
>>> -- Shuah
>>
> 

-- 
BR,
Muhammad Usama Anjum


