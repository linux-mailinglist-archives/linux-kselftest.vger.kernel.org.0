Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1265A6D4E9D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjDCRDh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 13:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjDCRDg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 13:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D502B2D5E
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680541362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kM3dwgQ9HVMfQOAjj/i3eYxZUwtH+i5WmR63AuQM8dg=;
        b=BYCbDK+EqT7fK/tAJXEg3bbvoTObzS0WJ7/rylsDWad7Na1IWFSS5Xnq6nWsI/BNsz/+vu
        fpCq5eVgiL8sRQa7aRkb45NfxVa2vVu2A0O1xO8yRpRzz6KBn+ZqNUdkD17LcijWNJATVv
        UTOCXwEJCTtwUAVxUir9ODpLBEhX55g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-_ca0_8G_MVGspPB95KB3WQ-1; Mon, 03 Apr 2023 13:02:39 -0400
X-MC-Unique: _ca0_8G_MVGspPB95KB3WQ-1
Received: by mail-wm1-f70.google.com with SMTP id q21-20020a05600c46d500b003ee570749f7so15044952wmo.7
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 10:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680541358;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kM3dwgQ9HVMfQOAjj/i3eYxZUwtH+i5WmR63AuQM8dg=;
        b=utx29V2bgpvM9g5OCLGOgnZvyXqsyK5SxMc0+8aB2UG1UvVb9k9S+ZOuXRgq3FFh5U
         BM1lP1Lq/wz5K2rGXywJH1a9qjOLAPBf74b6R2qHiSF7my17/zoey2qBc+bLWuoFX1yZ
         srpHYaK8FLCKCkdxxFGiD+3qIK+U8WQ9Vy12Mk8ckH2Zb0RF+3w8cMWhXiPXNXQ186Bq
         bOKQpmj/Yxgfy+gRABYsO9//6KtfE497aZREaNpwbsvtF3kt86AYKqcW2UbjW4a0PWpF
         NOIO8h23krfp1VMMUm3lQwbFhRhFOJ7PQRjM4qo0S6xvT3EsIh/GuuIV554VV5Nt6A0V
         Q2AQ==
X-Gm-Message-State: AAQBX9e+X4yEWCMLcm8wPmNGbOMwCW4jM+ro8vDXDBItHZAzGoRiZiHn
        N+MXaFM1vKcbSq46QPZCV+BFNwdxqUClvmalOZHllm0W92Nn8j1GjOz5My5WeGKZUTyR0Ol0rPX
        fWXULYrYYkIBCTon/55Lk99w+M8Wg
X-Received: by 2002:a5d:440e:0:b0:2e5:6441:2d16 with SMTP id z14-20020a5d440e000000b002e564412d16mr9153088wrq.42.1680541358588;
        Mon, 03 Apr 2023 10:02:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350bNyO+IrhEkypzMTwynN0OpO/ura/HmTqPcjZWbU5s0lV7LLf87+mbZZXdKp58mVrklwo0Ylg==
X-Received: by 2002:a5d:440e:0:b0:2e5:6441:2d16 with SMTP id z14-20020a5d440e000000b002e564412d16mr9153076wrq.42.1680541358251;
        Mon, 03 Apr 2023 10:02:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b002e6423cb207sm9071350wrv.112.2023.04.03.10.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 10:02:37 -0700 (PDT)
Message-ID: <0235770b-eb37-88e0-9350-a2d9c0cf9c32@redhat.com>
Date:   Mon, 3 Apr 2023 19:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230310182851.2579138-2-shr@devkernel.io>
 <7ed4308d-b400-d2bb-b539-3fe418862ab8@redhat.com>
 <qvqwpm8ludx2.fsf@dev0134.prn3.facebook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/3] mm: add new api to enable ksm per process
In-Reply-To: <qvqwpm8ludx2.fsf@dev0134.prn3.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03.04.23 17:50, Stefan Roesch wrote:
>> I guess the interpreter could enable it (like a memory allocator could enable it
>> for the whole heap). But I get that it's much easier to enable this per-process,
>> and eventually only when a lot of the same processes are running in that
>> particular environment.
>>
> 
> We don't want it to get enabled for all workloads of that interpreter,
> instead we want to be able to select for which workloads we enable KSM.
> 

Right.

> 
>>> 1. New options for prctl system command
>>>      This patch series adds two new options to the prctl system call.
>>>      The first one allows to enable KSM at the process level and the second
>>>      one to query the setting.
>>>      The setting will be inherited by child processes.
>>>      With the above setting, KSM can be enabled for the seed process of a
>>>      cgroup and all processes in the cgroup will inherit the setting.
>>> 2. Changes to KSM processing
>>>      When KSM is enabled at the process level, the KSM code will iterate
>>>      over all the VMA's and enable KSM for the eligible VMA's.
>>>      When forking a process that has KSM enabled, the setting will be
>>>      inherited by the new child process.
>>>      In addition when KSM is disabled for a process, KSM will be disabled
>>>      for the VMA's where KSM has been enabled.
>>
>> Do we want to make MADV_MERGEABLE/MADV_UNMERGEABLE fail while the new prctl is
>> enabled for a process?
> 
> I decided to allow enabling KSM with prctl even when MADV_MERGEABLE,
> this allows more flexibility.

MADV_MERGEABLE will be a nop. But IIUC, MADV_UNMERGEABLE will end up 
calling unmerge_ksm_pages() and clear VM_MERGEABLE. But then, the next 
KSM scan will merge the pages in there again.

Not sure if that flexibility is worth having.

[...]


>>> @@ -2661,6 +2662,32 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>>    	case PR_SET_VMA:
>>>    		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>>>    		break;
>>> +#ifdef CONFIG_KSM
>>> +	case PR_SET_MEMORY_MERGE:
>>> +		if (!capable(CAP_SYS_RESOURCE))
>>> +			return -EPERM;
>>> +
>>> +		if (arg2) {
>>> +			if (mmap_write_lock_killable(me->mm))
>>> +				return -EINTR;
>>> +
>>> +			if (!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags))
>>> +				error = __ksm_enter(me->mm, MMF_VM_MERGE_ANY);
>>
>> Hm, I think this might be problematic if we alread called __ksm_enter() via
>> madvise(). Maybe we should really consider making MMF_VM_MERGE_ANY set
>> MMF_VM_MERGABLE instead. Like:
>>
>> error = 0;
>> if(test_bit(MMF_VM_MERGEABLE, &me->mm->flags))
>> 	error = __ksm_enter(me->mm);
>> if (!error)
>> 	set_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
>>
> 
> If we make that change, we would no longer be able to distinguish
> if MMF_VM_MERGEABLE or MMF_VM_MERGE_ANY have been set.

Why would you need that exactly? To cleanup? See below.

> 
>>> +			mmap_write_unlock(me->mm);
>>> +		} else {
>>> +			__ksm_exit(me->mm, MMF_VM_MERGE_ANY);
>>
>> Hm, I'd prefer if we really only call __ksm_exit() when we really exit the
>> process. Is there a strong requirement to optimize disabling of KSM or would it
>> be sufficient to clear the MMF_VM_MERGE_ANY flag here?
>>
> Then we still have the mm_slot allocated until the process gets
> terminated.

Which is the same as using MADV_UNMERGEABLE, no?

> 
>> Also, I wonder what happens if we have another VMA in that process that has it
>> enabled ..
>>
>> Last but not least, wouldn't we want to do the same thing as MADV_UNMERGEABLE
>> and actually unmerge the KSM pages?
>>
> Do you want to call unmerge for all VMA's?

The question is what clearing MMF_VM_MERGE_ANY is supposed to do. If 
it's supposed to disable KSM (like MADV_UNMERGEABLE) would, then I guess 
you should go over all VMA's and unmerge.

Also, it depend on how you want to handle VM_MERGABLE with 
MMF_VM_MERGE_ANY. If MMF_VM_MERGE_ANY would not set VM_MERGABLE, then 
you'd only unmerge where VM_MERGABLE is not set. Otherwise, you'd 
unshare everywhere where VM_MERGABLE is set (and clear VM_MERGABLE) 
while at it.

Unsharing when clearing MMF_VM_MERGE_ANY might be the right thing to do 
IMHO.


I guess the main questions regarding implementation are:

1) Do we want setting MMF_VM_MERGE_ANY to set VM_MERGABLE on all
    candidate VMA's (go over all VMA's and set VM_MERGABLE). Then,
    clearing MMF_VM_MERGE_ANY would simply unmerge and clear VM_MERGABLE
    on all VMA's.

2) Do we want to make MMF_VM_MERGE_ANY imply MMF_VM_MERGABLE. You could
    still disable KSM (__ksm_exit()) during clearing MMF_VM_MERGE_ANY
    after going over all VMA's (where you might want to unshare already
    either way).

I guess the code will end up simpler if you make MMF_VM_MERGE_ANY simply 
piggy-back on MMF_VM_MERGABLE + VM_MERGABLE. I might be wrong, of course.

-- 
Thanks,

David / dhildenb

