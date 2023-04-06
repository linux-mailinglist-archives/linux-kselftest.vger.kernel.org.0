Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0C6D9AB1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 16:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbjDFOmC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbjDFOlt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 10:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AAECA0A
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680791940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j895ymwzo5cFUK4EnI2MaN8LhhF7WBFR4yyDeDEaR/E=;
        b=WUY0OWrAQpngkqCKEL6vymLQmsWR9dRK8GCrBFyLPgrzcZ8yHosQz1D58ce/LjZrbezkQ/
        +iIgWe1ZbR29526lqP76FWNIkVN6Yf3jvaeUuT3vgwCUEgB5NeRx9P6Wq2BLyKmUozRXwc
        74j5YvISvi2NIIKB8KQhVroHSfoRtS4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-2zNvxyssPOSoqDTGGj0R7Q-1; Thu, 06 Apr 2023 10:32:41 -0400
X-MC-Unique: 2zNvxyssPOSoqDTGGj0R7Q-1
Received: by mail-wr1-f70.google.com with SMTP id h5-20020adfaa85000000b002dc1cdac53fso55145wrc.5
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Apr 2023 07:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680791560; x=1683383560;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j895ymwzo5cFUK4EnI2MaN8LhhF7WBFR4yyDeDEaR/E=;
        b=IsS+kk3eVpYdsg+EKG8GajYhAA0Wqc7zOzR2wDCNaNpFxZKasNad7rL0Aksgfk0ft1
         n25A74tT4i+OEVPYkQF+iX9KDCjdv8qciNPOLnI+hM41x8nUK2Xbj8hO5+2/RfH8sc9j
         Kv6ZY25DuZos2wpKGGnU/hi+sUTWpbf3wz6t7DAvjQ+vwkPCQiqN6y/d2SFDXDwykTwg
         CS9s6MZAZPdM3lS6hkNNXrgEg4dasgHd+zCmnocKRO0rn0QK36FZEGel1A8tGxjzTFCp
         obHNrO0VQtb/0hfZdeyX9iapNuGUsqiEmf2aA+rn+yqxbEtneTmU4PVs8foy6IF8Vdw4
         hFIg==
X-Gm-Message-State: AAQBX9fiHclWZybYhYG9g6me7ZceGqhsnj7LKDrnGEuAt8tvRYwtnCTd
        3l2xnuV0E7csO8zGml0sDoLzmt/Ikf+7hvCNMzEBMDPM/jMg+iyjWJUMRLsuwVXhcRmjrTvcHDQ
        dxfkr4GOH+JoH4lVYZIbfzFC9vIrl+kr5NZI+
X-Received: by 2002:adf:e807:0:b0:2db:9ccf:f9f5 with SMTP id o7-20020adfe807000000b002db9ccff9f5mr7281888wrm.0.1680791560106;
        Thu, 06 Apr 2023 07:32:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZQFqd68J323693RzSjFbAIGhMIx+Sk7+HCdTARcTO1jXA82EQy191Q5dTyk14QuMR9BHz7KQ==
X-Received: by 2002:adf:e807:0:b0:2db:9ccf:f9f5 with SMTP id o7-20020adfe807000000b002db9ccff9f5mr7281865wrm.0.1680791559754;
        Thu, 06 Apr 2023 07:32:39 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id a15-20020a5d4d4f000000b002cfe685bfd6sm1881580wru.108.2023.04.06.07.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 07:32:38 -0700 (PDT)
Message-ID: <a4994de5-973e-8df9-bb23-d74659641070@redhat.com>
Date:   Thu, 6 Apr 2023 16:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        linux-mm@kvack.org, riel@surriel.com, mhocko@suse.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230310182851.2579138-3-shr@devkernel.io>
 <ce494e5a-3540-d6ad-4e9c-0bb49c7e1e1b@redhat.com>
 <qvqw8rf6uicf.fsf@dev0134.prn3.facebook.com>
 <e7a930f6-feba-29a4-7c48-ae7d8108c7dc@redhat.com>
 <20230406141619.GB35884@cmpxchg.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 2/3] mm: add new KSM process and sysfs knobs
In-Reply-To: <20230406141619.GB35884@cmpxchg.org>
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

On 06.04.23 16:16, Johannes Weiner wrote:
> On Thu, Apr 06, 2023 at 03:23:11PM +0200, David Hildenbrand wrote:
>>>>
>>>> Often, when you have to start making a list of things that a patch does, it
>>>> might make sense to split some of the items into separate patches such that you
>>>> can avoid lists and just explain in list-free text how the pieces in the patch
>>>> fit together.
>>>>
>>>> I'd suggest splitting this patch into logical pieces. For example, separating
>>>> the general profit calculation/exposure from the per-mm profit and the per-mm
>>>> ksm type indication.
>>>>
>>>
>>> Originally these were individual patches. If I recall correctly Johannes
>>> Weiner wanted them as one patch. I can certainly split them again.
>>
>> That's why I remember that v1 contained more patches :)
>>
>> Again, just my opinion on patches that require a description in form of a
>> list ...
> 
> My concern was the initial splitting of patch 1. I found it easier to
> review with the new prctl() being one logical change, and fully
> implemented in one go. The changelog is still in the form of a list,
> but it essentially enumerates diff hunks that make up the interface.
> 
> No objection to splitting out the multiple sysfs knobs, though!
> 
> The strategy I usually follow is this:
> 
> 1. Split out changes based on user-visible behavior (new prctl(), new
>     sysfs knob)
> 
> 2. Extract changes made along the way that have stand-alone value in
>     existing code (bug fixes, simplifying/documenting tricky sections,
>     cleanups).
> 
> 3. Split out noisy prep work such as renames and refactors that make
>     the user-visible functional changes more difficult to understand.
> 
> and then order the series into sections 2, 3, and 1.
> 

I agree. The most important part is the "logical change" part. Once it's 
down to a list of 3 items or so for a single commit we can usually 
express it like (just an example that does no longer apply due to 
pages_volatile() not being required) the following when combining items 
1+2+3 from the list:

"
Let's expose the general KSM profit via sysfs and document that new 
toggle. [add details about that and especially why we are doing that]

As we need the number of volatile pages to calculate the general KSM 
profit, factor out existing functionality into a helper.
"

Much easier to read.

-- 
Thanks,

David / dhildenb

