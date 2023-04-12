Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15356DFDCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 20:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDLSmU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjDLSmT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 14:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E2A2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681324886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3VT9Kq9nmC5BmqMQE6Z+3ROnKmsf5SjqX4tT+cT2cg=;
        b=FbzNaiSlndLw4u7s24ToI5I9VOEWIFqdHdUKA0wPf3NgjzOixPmKC+cBgdRU7qg5w3DSnu
        EylsyHEAEq/7l3wOKJwimDRdeNZ8bdgvVZYygwYTuvyRpd0YbaR+hgwZ/Hgqw3MmW2jnuX
        NsmbOxEdIyj5a3qsmjS0vcFzwSVchqU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-kZsKYvYmNeWxKR9dNssykg-1; Wed, 12 Apr 2023 14:41:19 -0400
X-MC-Unique: kZsKYvYmNeWxKR9dNssykg-1
Received: by mail-wm1-f70.google.com with SMTP id q19-20020a05600c46d300b003ef69894934so4356557wmo.6
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 11:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681324878; x=1683916878;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3VT9Kq9nmC5BmqMQE6Z+3ROnKmsf5SjqX4tT+cT2cg=;
        b=igAQ5cjY1pWiVMYfWN8A6BvrXUDxhy6EV2df1CNOu2ZGp61nPbe7H+xfOLBC0908Ht
         j9Tfo2OKmj1PKvRkAF2SG6zpLmpvtmRi8eM5LF+t+uTDTvOlJtdmvf+91OfoCxDx3A+u
         2uIZtN17fnYnoIYIypr6tU7xSsxeq5NhQUoHEkAmsQhwtr7XBK6CrPiwXdhJu79x84tS
         nVuvTSwIXucYz7ndmdPy1pTdvrBDAE0IWjhAMwcIZES4+jqEUroyCNfMLEik+p0Z1Q0B
         BcLSaZ5oPLpK9+vxegISGwQUF70nTX8JsLZZtKzyvjf9K9JD3Q2z0MsAA3pez4WAmmGp
         BpTQ==
X-Gm-Message-State: AAQBX9dKapQCpXn9jsVm8B4q8sQLMtOCyG1sJfDEpcKACwnyhLaJtZl0
        N0Jq7s2GF773BNMoM1ku9z90+9Ry/atWTtxIamjOhFsqY7/dRudrxLanLmgAanqkAevipJIXHBr
        Udedp++tKiIyz+oJoUJP2x35bgTU+
X-Received: by 2002:a5d:6b85:0:b0:2f0:2e3a:cc00 with SMTP id n5-20020a5d6b85000000b002f02e3acc00mr7416013wrx.17.1681324878291;
        Wed, 12 Apr 2023 11:41:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350b/QgGGwNJsH1wFuhM7bfB/1noybwNgk32aStiwxtIwKDydODiL5wj6bsintL3P/ESaIIORFg==
X-Received: by 2002:a5d:6b85:0:b0:2f0:2e3a:cc00 with SMTP id n5-20020a5d6b85000000b002f02e3acc00mr7415997wrx.17.1681324877919;
        Wed, 12 Apr 2023 11:41:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id k18-20020adff292000000b002f013fb708fsm502627wro.4.2023.04.12.11.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 11:41:17 -0700 (PDT)
Message-ID: <30b948fe-7983-39dd-9565-9f92ffd9101b@redhat.com>
Date:   Wed, 12 Apr 2023 20:41:16 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <qvqw1qkpavxn.fsf@devbig1114.prn1.facebook.com>
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

[...]
> That will work.
>> work? IOW, not exporting ksm_add_mm() and not passing a flag to __ksm_enter() --
>> it would simply set MMF_VM_MERGEABLE ?
>>
> 
> ksm_add_mm() is also used in prctl (kernel/sys.c). Do you want to make a
> similar change there?

Yes.

>>> + *
>>> + * @vma:  Pointer to vma
>>> + */
>>> +void ksm_add_vma(struct vm_area_struct *vma)
>>> +{
>>> +	struct mm_struct *mm = vma->vm_mm;
>>> +
>>> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
>>> +		__ksm_add_vma(vma);
>>> +}
>>> +
>>> +/**
>>> + * ksm_add_vmas - Mark all vma's of a process as mergeable
>>> + *
>>> + * @mm:  Pointer to mm
>>> + */
>>> +void ksm_add_vmas(struct mm_struct *mm)
>>
>> I'd suggest calling this
>>
> I guess you forgot your name suggestion?

Yeah, I reconsidered because the first idea I had was not particularly 
good. Maybe

ksm_enable_for_all_vmas()

But not so sure. If you think the "add" terminology is a good fit, keep 
it like that.


Thanks for bearing with me :)

-- 
Thanks,

David / dhildenb

