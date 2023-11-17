Return-Path: <linux-kselftest+bounces-236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17167EEB59
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 04:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E81280E13
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 03:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B7853A6;
	Fri, 17 Nov 2023 03:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVvqw9jt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BFFD4A
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 19:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700191179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAKFfPiqJuGzP2s6H3e1McPERpD8hKdLrmeMzG7k6Hw=;
	b=ZVvqw9jt6GUS5tj0UDDAfa87si02ENsPtHXsKcFQSuzKXgk0aI8xouf0PMkFE3MLaUWCTv
	mgdEBaAPuKb5oEKce2li79DPxVQA1ZJUfOjeHRVdNGL0HgbJ0706I4jSeC9CClJVxxGhKa
	nglKTzbIn2Mu4L7px5JOe58W6nW3nfI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-XvN8ka-2Oc27TMpOyqe6BQ-1; Thu, 16 Nov 2023 22:19:37 -0500
X-MC-Unique: XvN8ka-2Oc27TMpOyqe6BQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6b2df09dcdcso516435b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Nov 2023 19:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700191176; x=1700795976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAKFfPiqJuGzP2s6H3e1McPERpD8hKdLrmeMzG7k6Hw=;
        b=EEW47c6PvMh3iLfqr25g8HHqsE98N5mGWz/y3z5J4VoVpeD4G48GOE0hGiIdfvKTRN
         yMnndgISdYJ+kiJhqeYGiPyXjIa1PH5Bs4nDtssGmRoYsol8wP7NIqhT25rZc6BTtkrT
         7WT938HDCEHO6aHXctWy4wPjAtt9i3VkNzVMiB70zUiSRmbQvRfrnP5ddje/9/L0KFlq
         K4JVHxbKGLWuNDKt13Yjl+Hv5MWXxih1fvbHRDSOXogBADxkI3hGHI6SxoJaTU4fAbNZ
         /WwKLtMdEHMRLrfjcNOn4CJbGlUQEpbR/zQLg4ioBo3n6a7Z71wPXY7ohpUoCzfmbM/m
         CG0w==
X-Gm-Message-State: AOJu0YyWBONxWCYPkUDkPiODiXXMPSKiEP/iBL/BCcn37uZK9xpDlTc1
	tUN9Zw1KzL5c2AW82DMElOKTs9I5VRPWfV8iq2L7lUtTAAwVbXHOvqjqbcV1c9VC0qoeQ3nQaQ5
	a2MEJLnBNdC0SG885BWiZsZzMYxDT
X-Received: by 2002:a05:6a00:8998:b0:6b3:c72d:b01 with SMTP id hx24-20020a056a00899800b006b3c72d0b01mr8240467pfb.1.1700191176691;
        Thu, 16 Nov 2023 19:19:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfpURZkDv/ezuJd6cSD4adKTKntnTXg/JeSPEJHMKPZoI8mQ8dl34F8ROKL9i11G2GXcaKFg==
X-Received: by 2002:a05:6a00:8998:b0:6b3:c72d:b01 with SMTP id hx24-20020a056a00899800b006b3c72d0b01mr8240451pfb.1.1700191176340;
        Thu, 16 Nov 2023 19:19:36 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id it14-20020a056a00458e00b006c8721330fesm455416pfb.74.2023.11.16.19.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 19:19:35 -0800 (PST)
Message-ID: <041416db-1cb5-e84f-ce44-9d06707970a8@redhat.com>
Date: Fri, 17 Nov 2023 11:19:32 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] KVM: selftests: Initalize sem_vcpu_[cont|stop] before
 each test in dirty_log_test
Content-Language: en-US
To: Oliver Upton <oliver.upton@linux.dev>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231116093536.22256-1-shahuang@redhat.com>
 <ZVaxXJ4xUW1eyQEL@thinky-boi>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZVaxXJ4xUW1eyQEL@thinky-boi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 11/17/23 08:18, Oliver Upton wrote:
> Hi Shaoqin,
> 
> On Thu, Nov 16, 2023 at 04:35:36AM -0500, Shaoqin Huang wrote:
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
>> Fix this problem is easy, simply initialize the sem_t before every test.
>> Thus whatever the state previous test left, it won't interfere the next
>> test.
> 
> In your changelog you describe what sounds like a semaphore imbalance at
> the time of test completion, yet your proposed fix is to just clobber
> the error and start fresh.
> 

Yes. It's a semaphore imbalance problem.

> Why not nip it at the bud and fix the logic bug instead?

I have another patch which fix the logic bug, I will send it out later.

> 

-- 
Shaoqin


