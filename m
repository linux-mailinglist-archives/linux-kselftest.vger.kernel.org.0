Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157635F98A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Oct 2022 08:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiJJGyZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Oct 2022 02:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiJJGyK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Oct 2022 02:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5548D2AF1
        for <linux-kselftest@vger.kernel.org>; Sun,  9 Oct 2022 23:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665384848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pg5G9VL5CpW466Qb5kzC3fS+GraPCe+CdwnleWArycc=;
        b=PxqPPj6WRP4DACQ8tvnw2PYYjSoCKyuLHpkaU4f7Vuddu1GfYlbPcodz3czGEZ08T7NxRJ
        mxLmzwj8Q4Z8Gkb56uwQdUKkOe6W/C0FDqApEq05bGEHJDQvEuMfek7ckKsryWzxPdsP0l
        CuKdUewKnvy2Snj6y4QM2pd1Ef7ODRk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-fTc0LmnUPCSdgukhJLWnmg-1; Mon, 10 Oct 2022 02:54:06 -0400
X-MC-Unique: fTc0LmnUPCSdgukhJLWnmg-1
Received: by mail-wm1-f71.google.com with SMTP id n6-20020a7bc5c6000000b003c6bbe5d5cfso659623wmk.4
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Oct 2022 23:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pg5G9VL5CpW466Qb5kzC3fS+GraPCe+CdwnleWArycc=;
        b=Zfr/ETdKeqMQCRPZGMkRU9XRmP4gdu9VWPPhkSF83OHNRIGpelyjOrKmI4Bh9mFoub
         584qaYdSBXb9FXD3VwM8XFrEeD7nBIWr+CrT5PEJAbFelRa8fhzG5CmwSTgKSVZiCW26
         wf/+Vv97ltvt9w7J+nbU1ypssFgRXKSHX37+KdjW+J5NLcEf9GgNvpTW+ExozqtXj6pp
         TKek7ruEeb1x9MQXOddlbkGEnMaTLDhMu/F+37A3RSD8YDSUQncaJcViA//HoPd0Ye16
         NM0zwIJl8j9otPQI1e7tInRSqIijIWZMfrp/e10NOVHI74cB2xDJnfPBYFlB7yf2Rs4X
         C59w==
X-Gm-Message-State: ACrzQf30o10x9Iv6c9FX1JZDN/jbiF9BSz8RjArQJyUoLpigIiwhgN/0
        jtOr/2yle3tOvAZ7NLfDjpSWwmsL8iPtzD4YOB0MxVUHgPX4vRs/CTEgZndBP8Lcv5pE7VecOXw
        VWRA4oN5I0bVVsSWpnN4rtiCtEWJc
X-Received: by 2002:a05:600c:4186:b0:3b4:a660:1d29 with SMTP id p6-20020a05600c418600b003b4a6601d29mr18631479wmh.120.1665384845741;
        Sun, 09 Oct 2022 23:54:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7V2dlW9YbkCCzqACXYKambIlk713mlq6z7oXm6nZyP2WjnrSh/2V7hTzCymmXg6z+PUAe1lg==
X-Received: by 2002:a05:600c:4186:b0:3b4:a660:1d29 with SMTP id p6-20020a05600c418600b003b4a6601d29mr18631464wmh.120.1665384845488;
        Sun, 09 Oct 2022 23:54:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:e600:3a4a:f000:b085:4839? (p200300cbc704e6003a4af000b0854839.dip0.t-ipconnect.de. [2003:cb:c704:e600:3a4a:f000:b085:4839])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003b477532e66sm35460629wms.2.2022.10.09.23.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 23:54:05 -0700 (PDT)
Message-ID: <b0ae9fcc-7e2b-dae9-30be-4b6ee248bf97@redhat.com>
Date:   Mon, 10 Oct 2022 08:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH -next v5 2/4] selftests/memory-hotplug: Restore memory
 before exit
Content-Language: en-US
To:     zhaogongyi <zhaogongyi@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc:     "akinobu.mita@gmail.com" <akinobu.mita@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "shuah@kernel.org" <shuah@kernel.org>
References: <f83730eec0b1445fa92d4cf0397d886b@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f83730eec0b1445fa92d4cf0397d886b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08.10.22 03:40, zhaogongyi wrote:
> Hi!
> 
>>
>> On 30.09.22 10:52, zhaogongyi wrote:
>>> Hi!
>>>
>>>>
>>>> On 30.09.22 08:35, Zhao Gongyi wrote:
>>>>> Some momory will be left in offline state when calling
>>>>> offline_memory_expect_fail() failed. Restore it before exit.
>>>>>
>>>>> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
>>>>> ---
>>>>>     .../memory-hotplug/mem-on-off-test.sh         | 21
>>>> ++++++++++++++-----
>>>>>     1 file changed, 16 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
>>>> b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
>>>>> index 1d87611a7d52..91a7457616bb 100755
>>>>> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
>>>>> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
>>>>> @@ -134,6 +134,16 @@ offline_memory_expect_fail()
>>>>>     	return 0
>>>>>     }
>>>>>
>>>>> +online_all_offline_memory()
>>>>> +{
>>>>> +	for memory in `hotpluggable_offline_memory`; do
>>>>> +		if ! online_memory_expect_success $memory; then
>>>>> +			echo "$FUNCNAME $memory: unexpected fail" >&2
>>>>
>>>> Do we need that output?
>>>
>>> In my opinion, if online a memory node failed ,it should be a kernel bug
>> catched, so, I think the output here is needed.
>>
>> But online_memory_expect_success() already prints a warning, no?
> 
> Yes, online_memory_expect_success() already prints a warning, remove the warning in online_all_offline_memory() seems ok,
> 
> My previous consideration was that one more log information would make it easier to locate the wrong location.

Let's keep it simple unless there is real reason to warn twice.

-- 
Thanks,

David / dhildenb

