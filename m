Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FA46D9817
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 15:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbjDFNYb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 09:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237372AbjDFNYa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 09:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E4AA5EA
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680787395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7Hmzr+9HB3Bn94tWpFODla1b+fc9Td8o9IH5wnZAGQ=;
        b=IJvuZi5AGySZtZ3n1D6T3KlRccHp5Bia6smlFHQRFNXtde/WIFEWtu+hlc1xbxNR8/1AdG
        /lvZokz/UXcnZ5kmIjvgXtFB+i1CU9q1ni0k7tFTzJ+Mheh83jGJMlMm0EDo4q1jSjnUSg
        5qNJqCpGiF2X8kR/9lWRUwsHB2lzLfQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-OBkiyz1rOiKT2kEp8YRUIA-1; Thu, 06 Apr 2023 09:23:14 -0400
X-MC-Unique: OBkiyz1rOiKT2kEp8YRUIA-1
Received: by mail-wm1-f69.google.com with SMTP id o37-20020a05600c512500b003edd119ec9eso18323547wms.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Apr 2023 06:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680787393; x=1683379393;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7Hmzr+9HB3Bn94tWpFODla1b+fc9Td8o9IH5wnZAGQ=;
        b=m7nsvjrHMuv313YAg6kx+S7tB5XOP0b59S8ZT2K5s0qyAONTOecy8YjilbAZmQP3IU
         l70bqnQfW2BTXzPySpwMG8WvMVS3lrY7K6aGZaZ0bksRuXbzd/Sh9eWshCWhVb7oHhm8
         GbrEaaEUban1xbluNKzhuX2dA5rM9LmbcsB0Uo74l0bAFLC1V2RF8rA2gzXHsgxLFjne
         GRY2S7fCIaTqOgzbiYyj5+wxPdhhG/cYNIAjq/0i9L0Qvj3uU93mcIymfMhNlKzjeSAq
         7L/udZKnR5205oKZu2x6wBvhCTJxz2MjaEHHf2gkMU7caAdRl3eT+Gn/RyivpMUptrvG
         89ZQ==
X-Gm-Message-State: AAQBX9dBvg3znM7p7OE3iCJMDHZbZ6wxcbh/CktvExBVo/VbNU4ABcTs
        P9OeKjJsCIgMyHASy6sDog8VFkWmWfEEJ4hze8UoFQ5EBOASPugMSbUL7wsGbgZ/HIClSfhEPx0
        hD+npFMKWhyJgBq60mCHTY0dknBmJVx2Qdp4X
X-Received: by 2002:a05:600c:2216:b0:3e2:1dac:b071 with SMTP id z22-20020a05600c221600b003e21dacb071mr4319557wml.13.1680787392951;
        Thu, 06 Apr 2023 06:23:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350YcbkiaS8MTBR4JZ3ECj8Euw4BG/3vHhNsIZuEhi84AOHoHz8xwwrzQdwYxnoyhI8a3PQ+54g==
X-Received: by 2002:a05:600c:2216:b0:3e2:1dac:b071 with SMTP id z22-20020a05600c221600b003e21dacb071mr4319547wml.13.1680787392649;
        Thu, 06 Apr 2023 06:23:12 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600c451000b003ef66c89af0sm8750890wmo.0.2023.04.06.06.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:23:12 -0700 (PDT)
Message-ID: <e7a930f6-feba-29a4-7c48-ae7d8108c7dc@redhat.com>
Date:   Thu, 6 Apr 2023 15:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 2/3] mm: add new KSM process and sysfs knobs
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230310182851.2579138-3-shr@devkernel.io>
 <ce494e5a-3540-d6ad-4e9c-0bb49c7e1e1b@redhat.com>
 <qvqw8rf6uicf.fsf@dev0134.prn3.facebook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <qvqw8rf6uicf.fsf@dev0134.prn3.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>>
>> Often, when you have to start making a list of things that a patch does, it
>> might make sense to split some of the items into separate patches such that you
>> can avoid lists and just explain in list-free text how the pieces in the patch
>> fit together.
>>
>> I'd suggest splitting this patch into logical pieces. For example, separating
>> the general profit calculation/exposure from the per-mm profit and the per-mm
>> ksm type indication.
>>
> 
> Originally these were individual patches. If I recall correctly Johannes
> Weiner wanted them as one patch. I can certainly split them again.

That's why I remember that v1 contained more patches :)

Again, just my opinion on patches that require a description in form of 
a list ...

> 
>>> Link: https://lkml.kernel.org/r/20230224044000.3084046-3-shr@devkernel.io
>>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Rik van Riel <riel@surriel.com>
>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>
>>
>> [...]
>>
>>>    KSM_ATTR_RO(pages_volatile);
>>>    @@ -3280,6 +3305,21 @@ static ssize_t zero_pages_sharing_show(struct kobject
>>> *kobj,
>>>    }
>>>    KSM_ATTR_RO(zero_pages_sharing);
>>>    +static ssize_t general_profit_show(struct kobject *kobj,
>>> +				   struct kobj_attribute *attr, char *buf)
>>> +{
>>> +	long general_profit;
>>> +	long all_rmap_items;
>>> +
>>> +	all_rmap_items = ksm_max_page_sharing + ksm_pages_shared +
>>> +				ksm_pages_unshared + pages_volatile();
>>
>> Are you sure you want to count a config knob (ksm_max_page_sharing) into that
>> formula? I yet have to digest what this calculation implies, but it does feel
>> odd.
>>
> 
> This was a mistake. I wanted ksm_pages_sharing instead of
> ksm_max_page_sharing.
> 
>>
>> Further, maybe just avoid pages_volatile(). Expanding the formula (excluding
>> ksm_max_page_sharing for now):
>>
>>
>> all_rmap = ksm_pages_shared + ksm_pages_unshared + pages_volatile();
>>
>> -> expand pages_volatile() (ignoring the < 0 case)
>>
>> all_rmap = ksm_pages_shared + ksm_pages_unshared + ksm_rmap_items -
>> ksm_pages_shared - ksm_pages_sharing - ksm_pages_unshared;
>>
>> -> simplify
>>
>> all_rmap = ksm_rmap_items + ksm_pages_sharing;
>>
> I'll simplify it.


Cool.

-- 
Thanks,

David / dhildenb

