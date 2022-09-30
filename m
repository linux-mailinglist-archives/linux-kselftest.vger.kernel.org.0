Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D2B5F06F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiI3I4T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 04:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiI3I4S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 04:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D3510501C
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664528177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H1917BFrSGG49QIpV583BBnZoc9EFPAGT5mhF0PR/tU=;
        b=JPUsfPc99llorBRfR/+3HViE7OCnqX+qXx560WiibeVQzEihnrrHUG7k5+PzZvaI9KC1y/
        1cRNnOG3KDygv03q4hMKDm4WHFYu24GbL001Uwe3jWcGC0Cn5l8vR4M74HufSPqwqE7Xsy
        AEQXQHsuZIvDq2rSqXeGwZOrM7kLz8g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-449-0tdbj3TSNUCbXcx8EW0Fuw-1; Fri, 30 Sep 2022 04:56:10 -0400
X-MC-Unique: 0tdbj3TSNUCbXcx8EW0Fuw-1
Received: by mail-wr1-f69.google.com with SMTP id m3-20020adfc583000000b0022cd60175bbso1322119wrg.6
        for <linux-kselftest@vger.kernel.org>; Fri, 30 Sep 2022 01:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=H1917BFrSGG49QIpV583BBnZoc9EFPAGT5mhF0PR/tU=;
        b=fzAYORRN7TtNho/nQu0XFi0VoMUTljWqCC/sUfLw9hR+BRrfa1yOKBRMxmFQAA4csH
         xZ71Obf2NzbheP2i5x2q8ZoAq2VcXgcc5nkPyobz+gXYnD4tohjtlE+rcQhUITcmxCu+
         /axsbFsybMEXzXjrDozWnolEIRNeBtzkCbU/eYCqCLsWhtFCz82KBauVFNbqsiiWMsKg
         lz3y4rq5pVw1cyzNxF03vuA30PJVAvofr9OnWLZkmOl9h9Kcj0/74HFDIcEiQJv+yNDo
         lE8Mw2XPSplkDi43tmvwsrC7SoIV8wR7AK6qOGKEdLSiO4X++F2eu879ajGoLAnNRSzu
         8K0w==
X-Gm-Message-State: ACrzQf3PE9v8sWe2jYMtyETv9lPG/xzWSH/KQlYWPcanCZgFdO5sIXq4
        CRgcAj8tL9Kw6XseCyeFoEt+IALQowmN1MQr4Z1CLMXbAZqsNavBug0G2A3SMwZRP/knXtznmhK
        iPAr/2KwYt1rs0/8AvfVSlbdYiHDm
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr5117363wrr.472.1664528169080;
        Fri, 30 Sep 2022 01:56:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7bQ1YcgDeDZMxCbvzQfLrr5IFUFVFRr9mPvR/s+XRlHVHTlaxAi2okTKjOec5tY8fb3K/KtQ==
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr5117355wrr.472.1664528168832;
        Fri, 30 Sep 2022 01:56:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:c00:48b:b68a:f9e0:ebce? (p200300cbc70c0c00048bb68af9e0ebce.dip0.t-ipconnect.de. [2003:cb:c70c:c00:48b:b68a:f9e0:ebce])
        by smtp.gmail.com with ESMTPSA id z6-20020adfec86000000b0022b1d74dc56sm1478618wrn.79.2022.09.30.01.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 01:56:08 -0700 (PDT)
Message-ID: <f34ee8be-f27d-3ea6-459a-534a52b71387@redhat.com>
Date:   Fri, 30 Sep 2022 10:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
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
References: <276cce524b1146119f8a0e9ec00a2ba9@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <276cce524b1146119f8a0e9ec00a2ba9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30.09.22 10:52, zhaogongyi wrote:
> Hi!
> 
>>
>> On 30.09.22 08:35, Zhao Gongyi wrote:
>>> Some momory will be left in offline state when calling
>>> offline_memory_expect_fail() failed. Restore it before exit.
>>>
>>> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
>>> ---
>>>    .../memory-hotplug/mem-on-off-test.sh         | 21
>> ++++++++++++++-----
>>>    1 file changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
>> b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
>>> index 1d87611a7d52..91a7457616bb 100755
>>> --- a/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
>>> +++ b/tools/testing/selftests/memory-hotplug/mem-on-off-test.sh
>>> @@ -134,6 +134,16 @@ offline_memory_expect_fail()
>>>    	return 0
>>>    }
>>>
>>> +online_all_offline_memory()
>>> +{
>>> +	for memory in `hotpluggable_offline_memory`; do
>>> +		if ! online_memory_expect_success $memory; then
>>> +			echo "$FUNCNAME $memory: unexpected fail" >&2
>>
>> Do we need that output?
> 
> In my opinion, if online a memory node failed ,it should be a kernel bug catched, so, I think the output here is needed.

But online_memory_expect_success() already prints a warning, no?

-- 
Thanks,

David / dhildenb

