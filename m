Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3AE6EB059
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjDURMU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjDURMT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 13:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D115A2B
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682097084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWRo2mphM3DxKyp/++X+gPOFeElhZDx6hgzjY51IZDg=;
        b=B9Tr4AynPY1kzIJ2y6dj4rOXib3DFA6o8u4AojFxIJXpB/54vGgo2GpmHYZ3OkdeYH4MOF
        B5tO56XZ3C43bomBGKL3X/35BE1R8z7DFofWAA+Ws821K3deE+/Jog+wJtiMcdz8yDSqUf
        eh196qXxNXxgyAt3DrmoFkf4ybMNjIE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-njENU8_aMU2weFVsD7d3ag-1; Fri, 21 Apr 2023 13:11:22 -0400
X-MC-Unique: njENU8_aMU2weFVsD7d3ag-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2f6632b85fcso634195f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 10:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682097081; x=1684689081;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWRo2mphM3DxKyp/++X+gPOFeElhZDx6hgzjY51IZDg=;
        b=CGhlePoIhKjqllK0pr7O1BPIcGC1Dd9siGJmvw6kvYTo82yQERq6rcucVPNe47joS9
         aiJziwGCKRR9+h+WQYwYYbmlesjRpDYooQGNSP3fidYR4HVwa5yJFiejAvzI4tyD1J3L
         D36IsEVGXfCFvzTTV5OTFECsMiWDCN8V8PILst8AHRWWLuOAqD31AQ4irgYbsOsAg15b
         eJmTRCSjh/UaU0d3VGSoyVateiYjk/SCGKaurYQ/4uGdwf8MUpMVNa1owurwcj/mqeyf
         1/9lKyiJGP0l7fpw8vZ1PcXapYbvrvbp3kXPATvC7xFUnhADy9rV3OnUrCs8q+22cqhq
         n2Xw==
X-Gm-Message-State: AAQBX9d6QbKC25HfMQoyHQG9Lv9LQVpAaQLhIQBytf/C8fUu5RIpLJYB
        6W51razf3o8w52IcQbu55lF7xmzWDr/2YCfpAXatsYdxYHagshL86WoVgWHp8ssTPVuh0KwONic
        USpxHxh8rA0zRxstoUowc7FDIerkd
X-Received: by 2002:adf:e803:0:b0:2f7:a333:8cab with SMTP id o3-20020adfe803000000b002f7a3338cabmr4492297wrm.71.1682097081561;
        Fri, 21 Apr 2023 10:11:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350bsq8+YPeUjrndub6ownOF/tiFFET/YGjPbfOV6Mb70hmtCtimUhpMYaW36xci21zDFE8HHmg==
X-Received: by 2002:adf:e803:0:b0:2f7:a333:8cab with SMTP id o3-20020adfe803000000b002f7a3338cabmr4492269wrm.71.1682097081087;
        Fri, 21 Apr 2023 10:11:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6a00:e38f:c852:dc11:9146? (p200300cbc7176a00e38fc852dc119146.dip0.t-ipconnect.de. [2003:cb:c717:6a00:e38f:c852:dc11:9146])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003f191c9c4b0sm2323556wmc.11.2023.04.21.10.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 10:11:19 -0700 (PDT)
Message-ID: <d476d75d-74a8-9cad-a60e-4b5ecb149719@redhat.com>
Date:   Fri, 21 Apr 2023 19:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
 <20230418152849.505124-2-david@redhat.com>
 <qvqwr0sei6sl.fsf@devbig1114.prn1.facebook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] mm/ksm: unmerge and clear VM_MERGEABLE when
 setting PR_SET_MEMORY_MERGE=0
In-Reply-To: <qvqwr0sei6sl.fsf@devbig1114.prn1.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[...]

>>
> nit:
> can we do:
> 
>      if (arg2)
>     	error = ksm_enable_merge_any(me->mm);
> 	else
>     	error = ksm_disable_merge_any(me->mm);
> 	mmap_write_unlock(me->mm);
> 	break;

Indeed, thanks.

> 
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index a959e8925413..813f7fbc1832 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -2520,6 +2520,22 @@ static void __ksm_add_vma(struct vm_area_struct *vma)
>>   		vm_flags_set(vma, VM_MERGEABLE);
>>   }
>>
>> +static int __ksm_del_vma(struct vm_area_struct *vma)
>> +{
>> +	int err;
>> +
>> +	if (!(vma->vm_flags & VM_MERGEABLE))
>> +		return 0;
>> +
>> +	if (vma->anon_vma) {
>> +		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	vm_flags_clear(vma, VM_MERGEABLE);
>> +	return 0;
>> +}
>>   /**
>>    * ksm_add_vma - Mark vma as mergeable if compatible
>>    *
>> @@ -2542,6 +2558,20 @@ static void ksm_add_vmas(struct mm_struct *mm)
>>   		__ksm_add_vma(vma);
>>   }
>>
>> +static int ksm_del_vmas(struct mm_struct *mm)
>> +{
>> +	struct vm_area_struct *vma;
>> +	int err;
>> +
>> +	VMA_ITERATOR(vmi, mm, 0);
>> +	for_each_vma(vmi, vma) {
>> +		err = __ksm_del_vma(vma);
>> +		if (err)
>> +			return err;
>> +	}
>> +	return 0;
>> +}
>> +
>>   /**
>>    * ksm_enable_merge_any - Add mm to mm ksm list and enable merging on all
>>    *                        compatible VMA's
>> @@ -2569,6 +2599,23 @@ int ksm_enable_merge_any(struct mm_struct *mm)
>>   	return 0;
>>   }
>>
>> +int ksm_disable_merge_any(struct mm_struct *mm)
>>
> 
> I understand we want to keep the name "symmetric" with
> ksm_enable_merge_any, but it also unmerges the ksm pages. Do we want to
> reflect that in the function name?

ksm_disable_merge_any_umerge() is suboptimal.

As ksm_disable_merge_any() now reverts what ksm_enable_merge_any() ended 
up doing, I think it's just fine.

(it would be a different story if we'd be using "set" / "clear" 
terminology instead of "enable" / "disable").

We can describe that in the comment.

> 
> Can we add a comment for the function?

Can do for symmetry with ksm_enable_merge_any().

But note that I don't think documentation for functions is of any help 
when it takes longer to read the documentation than to read+understand 
the actual code.

> 
>> +{
>> +	int err;
>> +
>> +	if (!test_bit(MMF_VM_MERGE_ANY, &mm->flags))
>> +		return 0;
>> +
>> +	err = ksm_del_vmas(mm);
>> +	if (err) {
>> +		ksm_add_vmas(mm);
>> +		return err;
>> +	}
>> +
>> +	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>>
> 
> We only clear the MMF_VM_MERGE_ANY flag if there are no errors. Is this

I think this is the behavior we want. We tried to disable KSM for the 
process (previously enabled via the prctl), but cannot disable KSM. So 
we rollback our changes and return an error.

This is similar to trying to set MADV_UNMERGEABLE but failing. We leave 
the bit set.

> what we want? This means that if the process creates new memory regions
> they would still be marked as mergeable.

Yes, we failed the operation so we keep everything unchanged.

-- 
Thanks,

David / dhildenb

