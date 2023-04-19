Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA86E78C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Apr 2023 13:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjDSLlM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Apr 2023 07:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDSLlL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Apr 2023 07:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6055E55AD
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Apr 2023 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681904422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d94kMyGvyZL17XK7WKirw3h92EHgohkqQ/7jeLjX7+U=;
        b=RStd1pjj0sWU/Vfgzkb5oQpz76DGWeIy1DNBZwXsburYYmYqT9uXVlDjILVkIWbnAiuiAw
        JGTWghniQTXJgmip2M4EztVy68M0lUinzw47oihJTa1z7B4H3ZjL2Nuip5xSOMwfLGyPYY
        ClgeFgPqE7KQQudXTr/0TZlkWpsJnXc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-yNcisQuKMSKZ6RKAbqxU0Q-1; Wed, 19 Apr 2023 07:40:21 -0400
X-MC-Unique: yNcisQuKMSKZ6RKAbqxU0Q-1
Received: by mail-wm1-f69.google.com with SMTP id g6-20020a05600c310600b003ee69edec16so1001182wmo.5
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Apr 2023 04:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681904420; x=1684496420;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d94kMyGvyZL17XK7WKirw3h92EHgohkqQ/7jeLjX7+U=;
        b=dP9SrRaXxK0xdyxv4OX/SOvLLhS8BAzzrllQq8TwXn8cc3VTRC2xVljwDXpni4yMZ9
         tpHbOC+cj6ZNel/JBlDqDowvISZt8C98NVF7CmnHvtzsu6oitxe+7nZC+9unOM3y5t39
         TZuXmV74wcktJJEA+7ubgCRvHibKGSgJvU771v7BHPWCsV9OcckiiFld+BPkvropvGVh
         xxvqVazdxiBrIT7fswSSByi9z1+UZUqIFHiLmr6g5FKZhhp/Iao2Fur28L+Do+FwUyGg
         fKNiMhORhCsM9UnqplxxnYKd0ru93ojksRZzBRrwZ5x73AqMY70QtKjVmo+73YVFPN/z
         cUXw==
X-Gm-Message-State: AAQBX9dSlXufqgxE0njprM6ZmxLb0I6Q3duBT0dNcxn2xbQHxGob/GI0
        tDRvPGjEny4b0Cpb1vIuNIffUXw3AuIWvs83UaMQH6a0tXTOTGGm0Sj1j6JZUEC2uMikLMTdyg7
        /x5/XoOZ5Fs+VE0UmN3CVYJB8XTA9
X-Received: by 2002:a05:600c:ac4:b0:3f1:6ead:34fe with SMTP id c4-20020a05600c0ac400b003f16ead34femr11020928wmr.26.1681904419994;
        Wed, 19 Apr 2023 04:40:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350YgwHEzMmaB06GSpMni85LlmtPmKFDMOVPBAvCAxul+liaggVeQse0nWLU2InZIpdyZOr8tAg==
X-Received: by 2002:a05:600c:ac4:b0:3f1:6ead:34fe with SMTP id c4-20020a05600c0ac400b003f16ead34femr11020914wmr.26.1681904419705;
        Wed, 19 Apr 2023 04:40:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:7b00:7c52:a5fa:8004:96fd? (p200300cbc70b7b007c52a5fa800496fd.dip0.t-ipconnect.de. [2003:cb:c70b:7b00:7c52:a5fa:8004:96fd])
        by smtp.gmail.com with ESMTPSA id d17-20020a056000115100b002fa6929eb83sm7870151wrx.21.2023.04.19.04.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:40:19 -0700 (PDT)
Message-ID: <743c4686-43aa-15fa-5989-af9a43a783f9@redhat.com>
Date:   Wed, 19 Apr 2023 13:40:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 3/3] mm/ksm: move disabling KSM from s390/gmap code to
 KSM code
To:     Janosch Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Roesch <shr@devkernel.io>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
 <20230418152849.505124-4-david@redhat.com>
 <42df1c58-f0bf-5dd8-03db-ee2fa28d7c1b@linux.ibm.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <42df1c58-f0bf-5dd8-03db-ee2fa28d7c1b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19.04.23 13:39, Janosch Frank wrote:
> On 4/18/23 17:28, David Hildenbrand wrote:
>> Let's factor out actual disabling of KSM. The existing
>> "mm->def_flags &= ~VM_MERGEABLE;" was essentially a NOP and can be dropped,
>> because def_flags should never include VM_MERGEABLE. Note that we don't
>> currently prevent re-enabling KSM.
>>
>> This should now be faster in case KSM was never enabled, because we only
>> conditionally iterate all VMAs. Further, it certainly looks cleaner.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    arch/s390/mm/gmap.c | 20 +-------------------
>>    include/linux/ksm.h |  6 ++++++
>>    mm/ksm.c            | 11 +++++++++++
>>    3 files changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index 0949811761e6..dfe905c7bd8e 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -2585,30 +2585,12 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
>>    
>>    int gmap_mark_unmergeable(void)
>>    {
>> -	struct mm_struct *mm = current->mm;
>> -	struct vm_area_struct *vma;
>> -	unsigned long vm_flags;
>> -	int ret;
>> -	VMA_ITERATOR(vmi, mm, 0);
>> -
>>    	/*
>>    	 * Make sure to disable KSM (if enabled for the whole process or
>>    	 * individual VMAs). Note that nothing currently hinders user space
>>    	 * from re-enabling it.
>>    	 */
> 
> Is that still true?

Yes. We'd need another per-MM bit to stop it from getting re-enabled.

> 
> My KSM knowledge is nearly zero but from what I can see the patch looks
> ok to me:
> Acked-by: Janosch Frank <frankja@linux.ibm.net>


Thanks!

-- 
Thanks,

David / dhildenb

