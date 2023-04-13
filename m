Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E424A6E0A7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 11:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjDMJrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 05:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMJrb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 05:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70FC30DA
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681379210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iCTBmwGQFLvB6UaldhuBxZeRb9uCZUZOS/xxYNdSmt0=;
        b=YLDOql+EgOn+5CM4R0ftCWfu7CJtJum8MFJGPg8vttxYU45zifYUpYQvmzSr6J9hIS03Ao
        HjNkMsh2pBaLhmDb8bkFh19vMstDsNCRkwk0aTDRFYBH1yUHcwKuAXZlo5bm9bzRagnrrD
        lxliJ69aEhOoyvHCccsfXJO9BVvP6BQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-1f7Fd9feMq2hmS4ZArMy1g-1; Thu, 13 Apr 2023 05:46:49 -0400
X-MC-Unique: 1f7Fd9feMq2hmS4ZArMy1g-1
Received: by mail-wr1-f72.google.com with SMTP id q9-20020adfab09000000b002f513905032so757999wrc.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 02:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681379208; x=1683971208;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCTBmwGQFLvB6UaldhuBxZeRb9uCZUZOS/xxYNdSmt0=;
        b=jlrAdQS6OqAkUH/9zoOD/Pv0PAFQn0yNRz6FW9mKCV/IPU1DBMTo7xE8N3jg/TqeBg
         Xl7JZ2VjPNx9LTIuDQebNHECHdHP5BxuIVv3J5Pc1RHL1uTukMvdZUMm/rdmkAga0F0H
         WQEJ3axA6MzK1HNQpWCsszetWAG1QYUeg8klpHcz8KeIJ7V5dyXrtZydCQ7YvoEQHuZH
         WOKlLArcZss+wU/mI0TeGs+ikCCZ8sGThY785B6qiIcbZ4+AhefPUXEX+8JYIMH9XzNH
         mRMr2Z2ztYGd3q0kw11nKDyEaOBs3xi6rz7Hg9e0pAPlEkhpjk8OyfGyZQtHsm7bdya+
         Nzsw==
X-Gm-Message-State: AAQBX9fiY6vcMziAvGz5mX9Dl1xxQQ7C0TXq1Usb46TamsINL7/jPdt+
        64IYIUcGYaRFXHlmF14ugWcpZ161IobqVuR3uRxbUEu28vPB+NwtA2822Z15+R5jOkjXEP+H7Tw
        /SQtACRnvhon5HMUy3R585Vkq5tcM
X-Received: by 2002:a5d:4442:0:b0:2cf:efa5:5322 with SMTP id x2-20020a5d4442000000b002cfefa55322mr4515449wrr.14.1681379208100;
        Thu, 13 Apr 2023 02:46:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y0dfzQ/GU/ltT6SSlL7hGmv5lYqtgb9Li35jHEYNjMcMNtHsLmpEA2OWUwSuUqRcCIu8nxaQ==
X-Received: by 2002:a5d:4442:0:b0:2cf:efa5:5322 with SMTP id x2-20020a5d4442000000b002cfefa55322mr4515428wrr.14.1681379207734;
        Thu, 13 Apr 2023 02:46:47 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d438d000000b002cff06039d7sm901837wrq.39.2023.04.13.02.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 02:46:47 -0700 (PDT)
Message-ID: <2b8024d7-3526-6710-5ddb-9c0852bc299d@redhat.com>
Date:   Thu, 13 Apr 2023 11:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 1/3] mm: add new api to enable ksm per process
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230412031648.2206875-1-shr@devkernel.io>
 <20230412031648.2206875-2-shr@devkernel.io>
 <b3bac995-0d87-a4d7-b261-9cbe3aa901af@redhat.com>
 <qvqw1qkpavxn.fsf@devbig1114.prn1.facebook.com>
 <30b948fe-7983-39dd-9565-9f92ffd9101b@redhat.com>
 <33f18dde-8ff8-5ec6-9bee-3c1900c2bd83@redhat.com>
 <qvqwcz48zxed.fsf@devbig1114.prn1.facebook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <qvqwcz48zxed.fsf@devbig1114.prn1.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12.04.23 21:55, Stefan Roesch wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 12.04.23 20:41, David Hildenbrand wrote:
>>> [...]
>>>> That will work.
>>>>> work? IOW, not exporting ksm_add_mm() and not passing a flag to __ksm_enter() --
>>>>> it would simply set MMF_VM_MERGEABLE ?
>>>>>
>>>>
>>>> ksm_add_mm() is also used in prctl (kernel/sys.c). Do you want to make a
>>>> similar change there?
>>> Yes.
>>>
>>>>>> + *
>>>>>> + * @vma:  Pointer to vma
>>>>>> + */
>>>>>> +void ksm_add_vma(struct vm_area_struct *vma)
>>>>>> +{
>>>>>> +	struct mm_struct *mm = vma->vm_mm;
>>>>>> +
>>>>>> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
>>>>>> +		__ksm_add_vma(vma);
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * ksm_add_vmas - Mark all vma's of a process as mergeable
>>>>>> + *
>>>>>> + * @mm:  Pointer to mm
>>>>>> + */
>>>>>> +void ksm_add_vmas(struct mm_struct *mm)
>>>>>
>>>>> I'd suggest calling this
>>>>>
>>>> I guess you forgot your name suggestion?
>>> Yeah, I reconsidered because the first idea I had was not particularly
>>> good. Maybe
>>> ksm_enable_for_all_vmas()
>>> But not so sure. If you think the "add" terminology is a good fit, keep
>>> it like that.
>>> Thanks for bearing with me :)
>>>
>>
>> I briefly played with your patch to see how much it can be simplified.
>> Always enabling ksm (setting MMF_VM_MERGEABLE) before setting
>> MMF_VM_MERGE_ANY might simplify things. ksm_enable_merge_any() [or however it should
>> be called] and ksm_fork() contain the interesting bits.
>>
>>
>> Feel free to incorporate what you consider valuable (uncompiled,
>> untested).
>>
> I added most of it. The only change is that I kept ksm_add_vmas as a
> static function, otherwise I need to define the VMA_ITERATOR at the top
> of the function.


Makes sense. I'll review patch #3 later, so we can hopefully get this 
into the 6.4 merge window after letting it rest at least some days in -next.

-- 
Thanks,

David / dhildenb

