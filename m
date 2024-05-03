Return-Path: <linux-kselftest+bounces-9347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C128BA7CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 09:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7051F22173
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3331474B4;
	Fri,  3 May 2024 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxipH9+D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E74146D47
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721468; cv=none; b=cJkHXRugGLhZ8WFeCXLtHORoQ6t34Y/vYg1wvifNK5yluKoxqB4GLJ1zhMUPmiEbsDtRxbusWos3/zGCkvZf9PL6mvlwBPB7eSPUgRs3HYV/N5hI3wpQAUrzGsjN+d4WqDThi5xAHyjEA+aN8Iv9HYDHbq5te6Wy0howCHGdV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721468; c=relaxed/simple;
	bh=LHo8e5MgzEpABxZMmyiDu+cre42cy1wLl6f0BueObXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhCzbSIkU5r/bM4TpxPLSOQikquauHzCgFvS4Dpt9D1yjhUkt4PiWIhqDLs6mAxklYmjKfNem0d0sKZxNkSCODE6sZDGKsASLX5LlZZh4GI7ccVroEsVfW3GfH+orZRWXjwXRYceihuEZzCvxhVrJ52GEnjAn5g1qZWu/ny5FxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxipH9+D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714721465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kay3G1XsLA4JleZx3Fv2uRt6GLaRElqrFFYQVMsBqFo=;
	b=PxipH9+DHbM8Ol3kSbTEVCWOKQrd9oWxQJjLaEFkyiKxpGn4FPOlaWtCXN8anVt3A1uwec
	eae5cojVSnu5XENWntKOk6kuuAesXMRP1z10nQr7LHO+HnohH8Jst44SyO8Dd26+64XZ6g
	NaEapgY4Nh0S5xFPe3+NRnxTgyPVtgY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-RIhCrOfrMhO9_PVe_5av8Q-1; Fri, 03 May 2024 03:31:03 -0400
X-MC-Unique: RIhCrOfrMhO9_PVe_5av8Q-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ee17b4a78cso7592999a34.2
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 00:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714721462; x=1715326262;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kay3G1XsLA4JleZx3Fv2uRt6GLaRElqrFFYQVMsBqFo=;
        b=U9yffwRajSr807OO01FRVKJPb+trWfFAsd2tPih/azbPZRVtLGs4pQwfRM01o6veZt
         2Xxk1ItXNKXTS64gNYtnD43hY5Ku2fGN40iC1xe94iZjgMijkQLdaUQlHXar2lNgYzPK
         lyLOcyz36k3BBcA3ksn3rQl/mxhS0X35Qs9/tWsU7ohXNrc6y2Y8CEAHfvrT664Dl3cT
         MwOmDpWMLQYaF+hvfK8Sm5uAp96qFB13MUYn1+Pi69421/lmZncrwXPEPi49tjEPV4CM
         PTB7kNfFjK6bRI+fz+o4rMVcNkrtRtMRq0sibKKE4M0riPWa6VKPlOQcIBl62IgDFdRq
         Dehw==
X-Forwarded-Encrypted: i=1; AJvYcCUaEBTcaxLEv1U0g6T8SOnezhjEX0YNv2SOdOQ9GGN2YbZ4v7ZVryrGQu39r+EJgxyZASjnNsXuBvy3Ovg1OC0cg8+BM3rejnlx6nZKh4eN
X-Gm-Message-State: AOJu0YzX7qMisMqENWE1v9AuIpRXoQGTfMas9X9Q2ixjJQxv/JVFwYgk
	4qAaD/1PBkuqSgr3hive06+bZhQFvQj9HNePPJhZYkQbobxlflvGG2sgk+MZ/Y/K+qLiOINRnqa
	lPZdGtnBw1jsDaWTBNt6rfsktuhfWrknK/+pKxf4w6A1bYTRcQ2mxKjjhBSP5hMbUmQ==
X-Received: by 2002:a05:6830:3149:b0:6ee:5560:4031 with SMTP id c9-20020a056830314900b006ee55604031mr2614741ots.38.1714721462112;
        Fri, 03 May 2024 00:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGxYIIkxGIgyH8aktHNZwF1zguXlgnaHiw5tGDmBHmpDDHgKQ6H7EwBYU2hX/95eHSN7chVg==
X-Received: by 2002:a05:6830:3149:b0:6ee:5560:4031 with SMTP id c9-20020a056830314900b006ee55604031mr2614728ots.38.1714721461701;
        Fri, 03 May 2024 00:31:01 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de. [109.43.179.34])
        by smtp.gmail.com with ESMTPSA id c23-20020ae9e217000000b0078d5fdc929fsm1013411qkc.104.2024.05.03.00.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 00:31:01 -0700 (PDT)
Message-ID: <25cc89b7-822f-4735-bec5-59458ec18a49@redhat.com>
Date: Fri, 3 May 2024 09:30:57 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: selftests: Use TAP interface in the
 set_memory_region test
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <20240426114552.667346-1-thuth@redhat.com>
 <ZjPrlLNNGNh2mOmW@google.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZjPrlLNNGNh2mOmW@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/05/2024 21.37, Sean Christopherson wrote:
> On Fri, Apr 26, 2024, Thomas Huth wrote:
>> Use the kselftest_harness.h interface in this test to get TAP
>> output, so that it is easier for the user to see what the test
>> is doing. (Note: We are not using the KVM_ONE_VCPU_TEST_SUITE()
>> macro here since these tests are creating their VMs with the
>> vm_create_barebones() function, not with vm_create_with_one_vcpu())
>>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v2:
>>   - Rebase to linux-next branch
>>   - Make "loops" variable static
>>   - Added Andrew's Reviewed-by
>>
>>   .../selftests/kvm/set_memory_region_test.c    | 86 +++++++++----------
>>   1 file changed, 42 insertions(+), 44 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
>> index 68c899d27561..a5c9bee5235a 100644
>> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
>> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
>> @@ -16,6 +16,7 @@
>>   #include <test_util.h>
>>   #include <kvm_util.h>
>>   #include <processor.h>
>> +#include "kselftest_harness.h"
>>   
>>   /*
>>    * s390x needs at least 1MB alignment, and the x86_64 MOVE/DELETE tests need a
>> @@ -38,6 +39,8 @@ extern const uint64_t final_rip_end;
>>   
>>   static sem_t vcpu_ready;
>>   
>> +static int loops;
> 
> ...
> 
>> -static void test_add_overlapping_private_memory_regions(void)
>> +TEST(add_overlapping_private_memory_regions)
>>   {
>>   	struct kvm_vm *vm;
>>   	int memfd;
>>   	int r;
>>   
>> -	pr_info("Testing ADD of overlapping KVM_MEM_GUEST_MEMFD memory regions\n");
>> +	if (!has_cap_guest_memfd())
>> +		SKIP(return, "Missing KVM_MEM_GUEST_MEMFD / KVM_X86_SW_PROTECTED_VM");
> 
> I like that we can actually report sub-tests as being skipped, but I don't like
> having multiple ways to express requirements.  And IMO, this is much less readable
> than TEST_REQUIRE(has_cap_guest_memfd());
> 
> AIUI, each test runs in a child process, so TEST_REQUIRE() can simply exit(), it
> just needs to avoid ksft_exit_skip() so that a sub-test doesn't spit out the full
> test summary.
> 
> And if using exit() isn't an option, setjmp()+longjmp() will do the trick (I got
> that working for KVM_ONE_VCPU_TEST() before I realized tests run as a child).
> 
> The below is lightly tested, but I think it does what we want?

Not quite ... for example, if I force vmx_pmu_caps_test to skip the last 
test, I get:

TAP version 13
1..5
# Starting 5 tests from 1 test cases.
#  RUN           vmx_pmu_caps.guest_wrmsr_perf_capabilities ...
#            OK  vmx_pmu_caps.guest_wrmsr_perf_capabilities
ok 1 vmx_pmu_caps.guest_wrmsr_perf_capabilities
#  RUN           vmx_pmu_caps.basic_perf_capabilities ...
#            OK  vmx_pmu_caps.basic_perf_capabilities
ok 2 vmx_pmu_caps.basic_perf_capabilities
#  RUN           vmx_pmu_caps.fungible_perf_capabilities ...
#            OK  vmx_pmu_caps.fungible_perf_capabilities
ok 3 vmx_pmu_caps.fungible_perf_capabilities
#  RUN           vmx_pmu_caps.immutable_perf_capabilities ...
#            OK  vmx_pmu_caps.immutable_perf_capabilities
ok 4 vmx_pmu_caps.immutable_perf_capabilities
#  RUN           vmx_pmu_caps.lbr_perf_capabilities ...
ok 5 # SKIP - Requirement not met: host_cap.lbr_format && 0
#            OK  vmx_pmu_caps.lbr_perf_capabilities
ok 5 vmx_pmu_caps.lbr_perf_capabilities
# PASSED: 5 / 5 tests passed.
# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

As you can see, the "ok 5" line is duplicated now, once marked with "# SKIP" 
and once as successfull. I don't think that this is valid TAP anymore?

> I also think we would effectively forbid direct use of TEST().  Partly because
> it's effectively necessary to use TEST_REQUIRE(), but also so that all tests will
> have an existing single point of contact if we need/want to make similar changes
> in the future.

Ok, but I wrote in the patch description, KVM_ONE_VCPU_TEST_SUITE() does not 
work for the set_memory_region test since it does not like to have a 
pre-defined vcpu ... so if we want to forbid TEST(), I assume we'd need 
another macro like KVM_BAREBONE_TEST_SUITE() ?

Not sure whether I really like it, though, since I'd prefer if we could keep 
the possibility to use the original selftest macros (for people who are 
already used to those macros from other selftests).

  Thomas


