Return-Path: <linux-kselftest+bounces-3925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C8F84533B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 09:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAA31C25186
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9F15B0E2;
	Thu,  1 Feb 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEuFoIiG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C84D15AAD4
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Feb 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777848; cv=none; b=sxqL/WCG0pjWcbMIad+wZkoqd4hL20HpO3YYQ6i16kh80wgEIg3IRCaFS7krZL5Ac+xjLGukDCmQzjUiTY9v2n+EVFYqI3KGtrPYA1XhNZMhNG5CRjkQc9i11/Z2M2pRRnSkm7TVAfiYQ/weZe5YvJI6cQ03ZKQ/C36E+go2BI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777848; c=relaxed/simple;
	bh=j3Zd4mKrm216Zi80MFkLzEXQBZt3skOFnFm6RoTNJkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qx+OrEZHmS8oQuIUO9iUnPOFPeA/dV4i0igk8UqW38Kf2h8Dw2kOx9vANFloNCBjXqHkJxjv1N+EnXo5QuLDbQqbO4ZqTR4Kt0ZWZ/AbHdxmQZbrpjdraaV/uYgvC+CszzPlc6SHzcxMnfi8lc/C9iX0pg73Y7KOJCZIljOr3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEuFoIiG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706777845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmH3EWgqG+olCCSdo93j0hjDoEO8xtf6eODTmOyVxmc=;
	b=iEuFoIiG1Bkc0wtbUnhL4mcAg7dcmNMf1qxgf5yhPonQ9KY1FIxYE7onGVpq2f40uFnOIw
	38iygeSMlofcNVyOu5zsb3gmy1v/L0Fwb17JWKudQ1DY0iSDvR/KBwyciG6jcNetk3Mxce
	FShCQi522dchHj1fz06OnpjRxKLGK/4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-8em8AVp6Md2Eh0kSLiqKbQ-1; Thu, 01 Feb 2024 03:57:24 -0500
X-MC-Unique: 8em8AVp6Md2Eh0kSLiqKbQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6da4d130a82so202920b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 00:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777843; x=1707382643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmH3EWgqG+olCCSdo93j0hjDoEO8xtf6eODTmOyVxmc=;
        b=TyzkHjcKFgKlhkrkLjwI/+o3gCCewgjUhDedzPsLvRYmzkOGgeZiJ0ZuvJjLdISKmA
         Vzcf5SoTClvzQnOPA40BXqja79m8EYcjTmtQUh0TZNgfMh5ENbObDNCfHVueoqVXyQST
         f8j5AXgbXEDfjSLFrp4oKnz5A5rS6600BAgdTqMSYeDmUoVUxsf6tnw9eut7IvgAJKUC
         QQTFiCwjVth7xG/WU6vrbQRZ5I6i0VdazjlrGlg4zBHWf3ZpTRhIYD/8zNwy7oBf25zO
         Sjvi9ICYrNXYNX80ewISZpIWYn0+u+BTUeuB0oB6FayfHz0RDbdVl7cyhV5nzMoDpQy3
         twYw==
X-Forwarded-Encrypted: i=0; AJvYcCVLHNkjpJ9mSG9m3dfHZ97D+JZ5UpWQoFj4VLUOmb+DsN091bF/GmRRXb+eZRsQCJea+EjWxJ0BR/VvGULsyVuQPPiMfsdgeKdpflSivFGu
X-Gm-Message-State: AOJu0YydoL3ZbP1WYY8DskrgBKCJMaRIJ9Go1JYymjDM2NjaeXXaOhFZ
	MoW/LsoBC9eNpUPJPjfI2thV+YPoOPBUVrCr2yS3MiqeQMzpkJkGS+d+GrQjRrbX9/R1BGrz5JF
	rUAbed+yeAmPUF/8Rr8S/DpBESTj4Fj1lwTJ99SGvy55+WNz5hGTVL8cBXhNWpcXjog==
X-Received: by 2002:a05:6a20:160f:b0:19c:a8bf:cd8a with SMTP id l15-20020a056a20160f00b0019ca8bfcd8amr4380744pzj.6.1706777842868;
        Thu, 01 Feb 2024 00:57:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTFKwk/btSV/URCvdNmfvTLLCCyn2J86wXYURGOxFkP60VZpTwKUeSS6vccvZLBAnMS5i/pQ==
X-Received: by 2002:a05:6a20:160f:b0:19c:a8bf:cd8a with SMTP id l15-20020a056a20160f00b0019ca8bfcd8amr4380731pzj.6.1706777842524;
        Thu, 01 Feb 2024 00:57:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUP/ZIaNn49n5TVAR93hXxAwxjFEqEJt4iHPuOJgKwEjVloTkbnBVGpepDMZwP7FegNvKVoxj9riCBjxnnhojfbyPR9TGdcIyKENxVf03w30ZLoGFsf1nuH7zly7RWLiI0V8KZVmkbfH07smSntsCCYZYP+DDWQU1+Hmat3VqEYJbXLWzIrYOSbQhQ2erhMv+ccDRg4W26EmkMN555UWF4MegUUDvhBFe09n/brWh+bZXflVeTWO+ydsBnoAFTECQ==
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jh21-20020a170903329500b001d951b9ce37sm765467plb.273.2024.02.01.00.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:57:22 -0800 (PST)
Message-ID: <510f3534-b076-4d23-b4b8-361c1f872d57@redhat.com>
Date: Thu, 1 Feb 2024 16:57:19 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: selftests: Fix the dirty_log_test semaphore
 imbalance
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Xu <peterx@redhat.com>
References: <20231117052210.26396-1-shahuang@redhat.com>
 <ZbQVRX3V1P-ZE2Wf@google.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZbQVRX3V1P-ZE2Wf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

Thanks for your reviewing.

On 1/27/24 04:25, Sean Christopherson wrote:
> +Peter
> 
> On Fri, Nov 17, 2023, Shaoqin Huang wrote:
>> When execute the dirty_log_test on some aarch64 machine, it sometimes
>> trigger the ASSERT:
>>
>> ==== Test Assertion Failure ====
>>    dirty_log_test.c:384: dirty_ring_vcpu_ring_full
>>    pid=14854 tid=14854 errno=22 - Invalid argument
>>       1  0x00000000004033eb: dirty_ring_collect_dirty_pages at dirty_log_test.c:384
>>       2  0x0000000000402d27: log_mode_collect_dirty_pages at dirty_log_test.c:505
>>       3   (inlined by) run_test at dirty_log_test.c:802
>>       4  0x0000000000403dc7: for_each_guest_mode at guest_modes.c:100
>>       5  0x0000000000401dff: main at dirty_log_test.c:941 (discriminator 3)
>>       6  0x0000ffff9be173c7: ?? ??:0
>>       7  0x0000ffff9be1749f: ?? ??:0
>>       8  0x000000000040206f: _start at ??:?
>>    Didn't continue vcpu even without ring full
>>
>> The dirty_log_test fails when execute the dirty-ring test, this is
>> because the sem_vcpu_cont and the sem_vcpu_stop is non-zero value when
>> execute the dirty_ring_collect_dirty_pages() function. When those two
>> sem_t variables are non-zero, the dirty_ring_wait_vcpu() at the
>> beginning of the dirty_ring_collect_dirty_pages() will not wait for the
>> vcpu to stop, but continue to execute the following code. In this case,
>> before vcpu stop, if the dirty_ring_vcpu_ring_full is true, and the
>> dirty_ring_collect_dirty_pages() has passed the check for the
>> dirty_ring_vcpu_ring_full but hasn't execute the check for the
>> continued_vcpu, the vcpu stop, and set the dirty_ring_vcpu_ring_full to
>> false. Then dirty_ring_collect_dirty_pages() will trigger the ASSERT.
>>
>> Why sem_vcpu_cont and sem_vcpu_stop can be non-zero value? It's because
>> the dirty_ring_before_vcpu_join() execute the sem_post(&sem_vcpu_cont)
>> at the end of each dirty-ring test. It can cause two cases:
>>
>> 1. sem_vcpu_cont be non-zero. When we set the host_quit to be true,
>>     the vcpu_worker directly see the host_quit to be true, it quit. So
>>     the log_mode_before_vcpu_join() function will set the sem_vcpu_cont
>>     to 1, since the vcpu_worker has quit, it won't consume it.
>> 2. sem_vcpu_stop be non-zero. When we set the host_quit to be true,
>>     the vcpu_worker has entered the guest state, the next time it exit
>>     from guest state, it will set the sem_vcpu_stop to 1, and then see
>>     the host_quit, no one will consume the sem_vcpu_stop.
>>
>> When execute more and more dirty-ring tests, the sem_vcpu_cont and
>> sem_vcpu_stop can be larger and larger, which makes many code paths
>> don't wait for the sem_t. Thus finally cause the problem.
>>
>> To fix this problem, we can wait a while before set the host_quit to
>> true, which gives the vcpu time to enter the guest state, so it will
>> exit again. Then we can wait the vcpu to exit, and let it continue
>> again, then the vcpu will see the host_quit. Thus the sem_vcpu_cont and
>> sem_vcpu_stop will be both zero when test finished.
>>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>> v1->v2:
>>    - Fix the real logic bug, not just fresh the context.
>>
>> v1: https://lore.kernel.org/all/20231116093536.22256-1-shahuang@redhat.com/
>> ---
>>   tools/testing/selftests/kvm/dirty_log_test.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
>> index 936f3a8d1b83..a6e0ff46a07c 100644
>> --- a/tools/testing/selftests/kvm/dirty_log_test.c
>> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
>> @@ -417,7 +417,8 @@ static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu, int ret, int err)
>>   
>>   static void dirty_ring_before_vcpu_join(void)
>>   {
>> -	/* Kick another round of vcpu just to make sure it will quit */
>> +	/* Wait vcpu exit, and let it continue to see the host_quit. */
>> +	dirty_ring_wait_vcpu();
>>   	sem_post(&sem_vcpu_cont);
>>   }
>>   
>> @@ -719,6 +720,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>>   	struct kvm_vm *vm;
>>   	unsigned long *bmap;
>>   	uint32_t ring_buf_idx = 0;
>> +	int sem_val;
>>   
>>   	if (!log_mode_supported()) {
>>   		print_skip("Log mode '%s' not supported",
>> @@ -726,6 +728,11 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>>   		return;
>>   	}
>>   
>> +	sem_getvalue(&sem_vcpu_stop, &sem_val);
>> +	assert(sem_val == 0);
>> +	sem_getvalue(&sem_vcpu_cont, &sem_val);
>> +	assert(sem_val == 0);
> 
> Never use bare assert() in selftests, they'll either get compiled out or IIRC,
> will cause the test to silently exit if they fail.  Either do nothing, or use
> TEST_ASSERT().
> 

Sure. I will replace them with TEST_ASSERT().

>> +
>>   	/*
>>   	 * We reserve page table for 2 times of extra dirty mem which
>>   	 * will definitely cover the original (1G+) test range.  Here
>> @@ -825,6 +832,13 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>>   		sync_global_to_guest(vm, iteration);
>>   	}
>>   
>> +	/*
>> +	 *
>> +	 * Before we set the host_quit, let the vcpu has time to run, to make
>> +	 * sure we consume the sem_vcpu_stop and the vcpu consume the
>> +	 * sem_vcpu_cont, to keep the semaphore balance.
>> +	 */
>> +	usleep(p->interval * 1000);
> 
> Please no.  "Wait for a while" is never a complete solution for fixing races.
> In rare cases, adding a delay might be the only sane workaround, but I doubt that's
> the case here.

If that's the case. I guess I should keep the current solution. Except 
you have any better solution, please let me know.

Thanks,
Shaoqin

> 

-- 
Shaoqin


