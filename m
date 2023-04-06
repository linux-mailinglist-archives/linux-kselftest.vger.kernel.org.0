Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0666C6D9440
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjDFKiB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbjDFKiA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 06:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EB64C08
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680777433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=423478JseWRK/OIWA57RxO1tirntH0tu+VKBSXmpanY=;
        b=L5HWIXbH0OkhQmuCVAhSLnj4A6OEDEAFaQtIJIjlcspzA54ABICWnuRs/6LBT2SLsKSDTB
        EoHDKcz4KgN8N2wjnJjj99qDmQFvYqvfH4YGJgmX3so5WKE9AIGQo91bk+IvNsOdHCYoC/
        y5caqq6qDT8c3UWlgVpSy8BlCrROuAM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-wzaob5cXNkykqPyuAfm1ow-1; Thu, 06 Apr 2023 06:37:12 -0400
X-MC-Unique: wzaob5cXNkykqPyuAfm1ow-1
Received: by mail-wm1-f72.google.com with SMTP id l18-20020a05600c1d1200b003ef7b61e2fdso12464842wms.4
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Apr 2023 03:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680777431; x=1683369431;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=423478JseWRK/OIWA57RxO1tirntH0tu+VKBSXmpanY=;
        b=KIdE4OQwPD35E30fiTyHrXA7JB/RlS1WrQRFMnXpBW4fa2ZIyaxFLr3dE8VzReIfNp
         DRe9tNz00V4IS1Le7kGQ2S5buBNP53lfktOjXDgzJpr3hpS8KumtvxLt5ixAqMf2x6Fe
         tEVGDvTZvcQX8zg4p57HX09MkwBzLzzMxg0EkAvctbdQABppzShpVbcWFUMUX170OnhV
         FlmJNmGTnewgpG4Dw1VEBcDlsrd3hZFuGPHtkP7lnhH/e0eCWUqV54+S21NbrRzl6AZB
         6v4yAoR6pLQ44EatY0fKh1ix8NxYUvYZF8Zr3HHzZLrqrv9sGVH6y96rLN4/x+94wtI7
         A3dw==
X-Gm-Message-State: AAQBX9ekHQtOaBnvZIXt0w5Qd4HQ1LwwfPOntEYtE3CXDEcE0cgaF5tD
        HkJmY+W7JOEh6AeB66311HUeN0mTJmehotnCgrW2WSWQqpWCQNVHVcAsbkWU3kB14XKGJmiv33m
        s4+LpZO97X2eg0xj5ugmPDHegE83r2M/ZgpgC
X-Received: by 2002:a7b:c7d8:0:b0:3ed:5eed:5581 with SMTP id z24-20020a7bc7d8000000b003ed5eed5581mr3942743wmk.2.1680777431420;
        Thu, 06 Apr 2023 03:37:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350aIyM0TcVhaj7W+9nD4Lz3z92JY+LKul/IOeBeufdoitNg+9FX0dX7oN1tJR4ioomqtEfNlug==
X-Received: by 2002:a7b:c7d8:0:b0:3ed:5eed:5581 with SMTP id z24-20020a7bc7d8000000b003ed5eed5581mr3942713wmk.2.1680777430995;
        Thu, 06 Apr 2023 03:37:10 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c029000b003ef71d541cbsm1226611wmk.1.2023.04.06.03.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 03:37:10 -0700 (PDT)
Message-ID: <35c413a1-02df-21c0-99e1-2e143c945ae4@redhat.com>
Date:   Thu, 6 Apr 2023 12:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] selftests/mm: fix memory leak in child_memcmp_fn
Content-Language: en-US
To:     Feng Jiang <jiangfeng@kylinos.cn>, akpm@linux-foundation.org,
        shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Xie <xieming@kylinos.cn>
References: <20230404031234.78272-1-jiangfeng@kylinos.cn>
 <5c415fa5-1637-883d-8136-fc4280274406@redhat.com>
 <6e74d3f5-b792-7576-2340-fb4d67490a6b@kylinos.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6e74d3f5-b792-7576-2340-fb4d67490a6b@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06.04.23 04:01, Feng Jiang wrote:
> On 2023/4/4 15:31, David Hildenbrand wrote:
>> On 04.04.23 05:12, Feng Jiang wrote:
>>> The allocated memory should be freed on return.
>>>
>>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
>>> Suggested-by: Ming Xie <xieming@kylinos.cn>
>>> ---
>>>    tools/testing/selftests/mm/cow.c | 9 ++++++++-
>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/cow.c
>>> b/tools/testing/selftests/mm/cow.c
>>> index 0eb2e8180aa5..c0dd2dfca51b 100644
>>> --- a/tools/testing/selftests/mm/cow.c
>>> +++ b/tools/testing/selftests/mm/cow.c
>>> @@ -162,6 +162,10 @@ static int child_memcmp_fn(char *mem, size_t size,
>>>    {
>>>        char *old = malloc(size);
>>>        char buf;
>>> +    int ret;
>>> +
>>> +    if (!old)
>>> +        return -ENOMEM;
>>>          /* Backup the original content. */
>>>        memcpy(old, mem, size);
>>> @@ -172,7 +176,10 @@ static int child_memcmp_fn(char *mem, size_t size,
>>>            ;
>>>          /* See if we still read the old values. */
>>> -    return memcmp(old, mem, size);
>>> +    ret = memcmp(old, mem, size);
>>> +    free(old);
>>> +
>>> +    return ret;
>>>    }
>>>      static int child_vmsplice_memcmp_fn(char *mem, size_t size,
>>
>> NAK, the whole point of this function is that the child process will
>> exit immediately after executing this function, cleaning up
>> automatically.
>>
> Hi David, thanks very much for your review and I think you are right.
> 
> While the OS provides a cleanup mechanism to underwrite this, I think it
> makes sense for the application to ensure that its own logic is complete
> and correct.

Maybe on a per-testcase basis (which we do), such that each testcase 
leaves the process in a clean slate for the next test case. But not for 
such simplistic things where an exit() immediately follows. If we'd want 
to cleanup any state before we call exit(), we'd end up in a  lot of 
unnecessarily over-complicating the code.

Just look at how many exit()/ksft_exit_fail_msg()/... we have in our 
test cases. Cleaning up in these cases would be close to madness ;)

-- 
Thanks,

David / dhildenb

