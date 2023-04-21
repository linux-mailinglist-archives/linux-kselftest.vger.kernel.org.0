Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491D16EB033
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 19:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjDURID (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 13:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjDURH7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 13:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD313590
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682096821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7lG6rnmj15jmZA/ctqiBLvmqWQqJhRL1h9zNRtPjNc=;
        b=gFzh9RAc/MQGsmqu5leBq8PrETrWyL/I7ZTEiViN0IgeUxFZBoXPt6iabMz3fOxI+rbyJy
        Bc2eKFME+yD/JMM4Ah47YVqSMrCqgml35dzCI7+GrzUZFC6E2Ne9MnvIMhI3PeigtZEmRz
        q5J9cNvKmBx14jmL9ERb1QKHBNyZuic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-Z90uT2yaMF-6Ws8-VSt6eQ-1; Fri, 21 Apr 2023 12:52:17 -0400
X-MC-Unique: Z90uT2yaMF-6Ws8-VSt6eQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f187a7a626so6943185e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 09:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682095936; x=1684687936;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7lG6rnmj15jmZA/ctqiBLvmqWQqJhRL1h9zNRtPjNc=;
        b=BPbHWwu/rfFnKh1eAwGFr9elc5FEVX+nE7lAZ29CspI4hnhZPdrKfDVRNZ3saoCoOU
         2cYJ7Z0SVUAU0Fbqs0E8LLws2IV+hnyKEtu3J/AzZFuQLuofoSMuNzErnFfTdkuHXAY/
         9yrj4BWehr/MLKf7I+9j4Wtb3/FxdpUvCfFNxC+nNLcmWLbHvMXDD+voa0a4qdpTPFex
         uY2lKqsaGQVIEp22nqOGcE4bN6cLjc1beqxnrd3oQicYnft7Re4Me+vDDECHIpza54YY
         uNzmY9jdm6dD1ebBZowqZh1DMaAtnO7D2sjg0+DuRuH2BW4LnKISr5z2M2qvTGeaFdrI
         0yBQ==
X-Gm-Message-State: AAQBX9frbLmYIC5CG0RjP2kUUhOMxAInrgSugerMA4YfyA+dh4C6edz+
        J+RT2Lqud0slRdoyGITmpAf195bfVoAZmIlfUENBvGvBNaKmQnR3XgLRi8nj83NKY1ZUtsNNlYN
        wZ/qxdjHB82XvfyDyGaErTNQjCt1z
X-Received: by 2002:a1c:7c12:0:b0:3ed:b048:73f4 with SMTP id x18-20020a1c7c12000000b003edb04873f4mr2736908wmc.5.1682095936531;
        Fri, 21 Apr 2023 09:52:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350bSHPKE6vIxCUj+TpuUuTs1BivJ3Z9mU324hkuK5BcAE6z0tQXv0+PyZQ0F1Y1047SGWTZwnw==
X-Received: by 2002:a1c:7c12:0:b0:3ed:b048:73f4 with SMTP id x18-20020a1c7c12000000b003edb04873f4mr2736885wmc.5.1682095936116;
        Fri, 21 Apr 2023 09:52:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6a00:e38f:c852:dc11:9146? (p200300cbc7176a00e38fc852dc119146.dip0.t-ipconnect.de. [2003:cb:c717:6a00:e38f:c852:dc11:9146])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b003f17e37ce60sm8676540wmo.47.2023.04.21.09.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:52:15 -0700 (PDT)
Message-ID: <14d89518-0c11-7bfb-0c72-329a834ba1a1@redhat.com>
Date:   Fri, 21 Apr 2023 18:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
 <20230418152849.505124-4-david@redhat.com>
 <qvqwildqi62z.fsf@devbig1114.prn1.facebook.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/3] mm/ksm: move disabling KSM from s390/gmap code to
 KSM code
In-Reply-To: <qvqwildqi62z.fsf@devbig1114.prn1.facebook.com>
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

>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index 0949811761e6..dfe905c7bd8e 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -2585,30 +2585,12 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
>>
>>   int gmap_mark_unmergeable(void)
>>   {
>> -	struct mm_struct *mm = current->mm;
>> -	struct vm_area_struct *vma;
>> -	unsigned long vm_flags;
>> -	int ret;
>> -	VMA_ITERATOR(vmi, mm, 0);
>> -
>>   	/*
>>   	 * Make sure to disable KSM (if enabled for the whole process or
>>   	 * individual VMAs). Note that nothing currently hinders user space
>>   	 * from re-enabling it.
>>   	 */
>> -	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
>> -
>> -	for_each_vma(vmi, vma) {
>> -		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
>> -		vm_flags = vma->vm_flags;
>> -		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
>> -				  MADV_UNMERGEABLE, &vm_flags);
>> -		if (ret)
>> -			return ret;
>> -		vm_flags_reset(vma, vm_flags);
>> -	}
>> -	mm->def_flags &= ~VM_MERGEABLE;
>>
> 

Hi Stefan,

> This clears the def_flags struct member, however, in ksm_disable() we
> clear the __flags struct member. Is this a problem?

The patch description contains a comment regarding def_flags: "The 
existing "mm->def_flags &= ~VM_MERGEABLE;" was essentially a NOP and can 
be dropped, because def_flags should never include VM_MERGEABLE."

We keep clearing the MADV_UNMERGEABLE flag from MADV_UNMERGEABLE. In the 
old code, ksm_madvise() would have cleared it from local vm_flags and 
vm_flags_reset() would have modified vma->vm_flags. Now we clear it 
directly via vm_flags_clear(vma, VM_MERGEABLE);


Long story short, the mm->def_flags code as wrong and most probably 
copied from thp_split_mm() where we do:
	mm->def_flags |= VM_NOHUGEPAGE;
Which makes more sense.

Thanks!

-- 
Thanks,

David / dhildenb

