Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2810A7524C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjGMOOS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjGMOOR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101572702
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689257576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/nnrivJjCXjlWiXJUfPLOop1LXmbzPVIWYgCWPNVXA=;
        b=VeXLLqAkc7LKF1j3WMHiayQthFpebQn8jUyff1gEhkw2Bb5VjTOYoVa+uPS42UYe4ZnFzf
        fZKP3zRAXTfXOcN9BS9qZW4J4aatyBWYodX1zei/IAcEiMcLVXVYX5nSCHVjcg1XFIM0XZ
        mMpS5XN8EHzddu4W9pBJa9gPGKbZHnQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-VYaaYyFoO8u3hrPCAYB-Pw-1; Thu, 13 Jul 2023 10:12:51 -0400
X-MC-Unique: VYaaYyFoO8u3hrPCAYB-Pw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31444df0fafso447224f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 07:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257552; x=1691849552;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/nnrivJjCXjlWiXJUfPLOop1LXmbzPVIWYgCWPNVXA=;
        b=kS9bgbxaYEUdy2FExRf1gWTDzkf5RlpRgw7oBzxQN+AFyOlw7SPNdUBPE0akzopRsL
         IFZRSd3+b1ARrJ7eQzRjobxlyEM5rT6KvdfVMgUmPdrnIWmR6NKcW0LJye4rs1FNFRbJ
         NDmUP3lyxN2P4x5wfEnRZmVQG1yDIKVWIY22vlYg5Ggl/w6BQALHdGzbrrI/k3ncweph
         RFVvrGweCdsQdsE0a2VR+owulonDhBAC5FonyeL53OS8qpOgsU0Lax/TSuOQAwS31Fhd
         vyAXXEADtslO7TxSx5PYsLW2divcnli0DGBN23HpKFkKE0ZfMJiKE4It12JhbWAqYmMk
         FWdg==
X-Gm-Message-State: ABy/qLbFwCJMLznt6l4IneLh5nF42YY/CnQgSpONYBfdXw5NCVZaVLdo
        a1xiA0qduv3r35JqPLyCwgpUTKsoHaZTVTyrdttB3+zaA0EcD1Pspk4X3GAFdGgLQN6C/X2349v
        FF4UDhnfoBGDA5us4bU+sBg7K7qSp
X-Received: by 2002:a05:6000:12c7:b0:315:94ea:31ad with SMTP id l7-20020a05600012c700b0031594ea31admr1865781wrx.66.1689257552060;
        Thu, 13 Jul 2023 07:12:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWNh5gZnV4JtCol9lSOLwX0rF7KydONdLi+U9y34fnkgItDimt2DDoKS0RlZOnXZYcC33AAg==
X-Received: by 2002:a05:6000:12c7:b0:315:94ea:31ad with SMTP id l7-20020a05600012c700b0031594ea31admr1865755wrx.66.1689257551677;
        Thu, 13 Jul 2023 07:12:31 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23613.dip0.t-ipconnect.de. [79.242.54.19])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d684d000000b00314315071bbsm8126744wrw.38.2023.07.13.07.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:12:31 -0700 (PDT)
Message-ID: <373e7e67-6ccc-5508-6937-6ea5a3eed5ea@redhat.com>
Date:   Thu, 13 Jul 2023 16:12:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 3/9] selftests/mm: Skip soft-dirty tests on arm64
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-4-ryan.roberts@arm.com>
 <cf3c237e-69c8-dd6e-26fc-fe19de910813@redhat.com>
 <773cc0a8-24b8-7fcb-2980-7676fc772014@arm.com>
 <3c566e28-c7ad-7ba8-4583-619266282387@redhat.com>
Organization: Red Hat
In-Reply-To: <3c566e28-c7ad-7ba8-4583-619266282387@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13.07.23 16:09, David Hildenbrand wrote:
> On 13.07.23 16:03, Ryan Roberts wrote:
>> On 13/07/2023 14:56, David Hildenbrand wrote:
>>> On 13.07.23 15:54, Ryan Roberts wrote:
>>>> arm64 does not support the soft-dirty PTE bit. However there are tests
>>>> in `madv_populate` and `soft-dirty` which assume it is supported and
>>>> cause spurious failures to be reported when preferred behaviour would be
>>>> to mark the tests as skipped.
>>>>
>>>> Unfortunately, the only way to determine if the soft-dirty dirty bit is
>>>> supported is to write to a page, then see if the bit is set in
>>>> /proc/self/pagemap. But the tests that we want to conditionally execute
>>>> are testing precicesly this. So if we introduced this feature check, we
>>>> could accedentally turn a real failure (on a system that claims to
>>>> support soft-dirty) into a skip.
>>>>
>>>> So instead, do the check based on architecture; for arm64, we report
>>>> that soft-dirty is not supported. This is wrapped up into a utility
>>>> function `system_has_softdirty()`, which is used to skip the whole
>>>> `soft-dirty` suite, and mark the soft-dirty tests in the `madv_populate`
>>>> suite as skipped.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>     tools/testing/selftests/mm/madv_populate.c | 18 +++++++++++++-----
>>>>     tools/testing/selftests/mm/soft-dirty.c    |  3 +++
>>>>     tools/testing/selftests/mm/vm_util.c       | 17 +++++++++++++++++
>>>>     tools/testing/selftests/mm/vm_util.h       |  1 +
>>>>     4 files changed, 34 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/madv_populate.c
>>>> b/tools/testing/selftests/mm/madv_populate.c
>>>> index 60547245e479..5a8c176d7fec 100644
>>>> --- a/tools/testing/selftests/mm/madv_populate.c
>>>> +++ b/tools/testing/selftests/mm/madv_populate.c
>>>> @@ -232,6 +232,14 @@ static bool range_is_not_softdirty(char *start, ssize_t
>>>> size)
>>>>         return ret;
>>>>     }
>>>>
>>>> +#define ksft_test_result_if_softdirty(cond, ...)    \
>>>> +do {                            \
>>>> +    if (system_has_softdirty())            \
>>>> +        ksft_test_result(cond, __VA_ARGS__);    \
>>>> +    else                        \
>>>> +        ksft_test_result_skip(__VA_ARGS__);    \
>>>> +} while (0)
>>>> +
>>>>     static void test_softdirty(void)
>>>>     {
>>>>         char *addr;
>>>> @@ -246,19 +254,19 @@ static void test_softdirty(void)
>>>>
>>>>         /* Clear any softdirty bits. */
>>>>         clear_softdirty();
>>>> -    ksft_test_result(range_is_not_softdirty(addr, SIZE),
>>>> +    ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
>>>>                  "range is not softdirty\n");
>>>>
>>>>         /* Populating READ should set softdirty. */
>>>>         ret = madvise(addr, SIZE, MADV_POPULATE_READ);
>>>> -    ksft_test_result(!ret, "MADV_POPULATE_READ\n");
>>>> -    ksft_test_result(range_is_not_softdirty(addr, SIZE),
>>>> +    ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_READ\n");
>>>> +    ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
>>>>                  "range is not softdirty\n");
>>>>
>>>>         /* Populating WRITE should set softdirty. */
>>>>         ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
>>>> -    ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
>>>> -    ksft_test_result(range_is_softdirty(addr, SIZE),
>>>> +    ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_WRITE\n");
>>>> +    ksft_test_result_if_softdirty(range_is_softdirty(addr, SIZE),
>>>>                  "range is softdirty\n");
>>>
>>> We probably want to skip the whole test_*softdirty* test instead of adding this
>>> (IMHO suboptimal) ksft_test_result_if_softdirty.
>>
>> Yeah I thought about doing it that way, but then the output just looks like
>> there were fewer tests and they all passed. But thinking about it now, I guess
>> the TAP header outputs the number of planned tests and the number of tests
>> executed are fewer, so a machine parser would still notice. I just don't like
>> that it outputs skipped:0.
>>
>> But it a lightly held view. Happy to just do:
>>
>> 	if (system_has_softdirty())
>> 		test_softdirty()
>>
>> If you insist. ;-)
> 
> diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
> index 60547245e479..33fda0337b32 100644
> --- a/tools/testing/selftests/mm/madv_populate.c
> +++ b/tools/testing/selftests/mm/madv_populate.c
> @@ -266,12 +266,16 @@ static void test_softdirty(void)
>    
>    int main(int argc, char **argv)
>    {
> +       int nr_tests = 16;
>           int err;
>    
>           pagesize = getpagesize();
>    
> +       if (system_has_softdirty())
> +               nr_tests += 5;
> +
>           ksft_print_header();
> -       ksft_set_plan(21);
> +       ksft_set_plan(nr_tests);
>    
>           sense_support();
>           test_prot_read();
> @@ -279,7 +283,8 @@ int main(int argc, char **argv)
>           test_holes();
>           test_populate_read();
>           test_populate_write();
> -       test_softdirty();
> +       if (system_has_softdirty())
> +               test_softdirty();
>    
>           err = ksft_get_fail_cnt();
>           if (err)
> 
> 

Oh, and if you want to have the skip, then you can think about 
converting test_softdirty() to only perform a single ksft_test_result(), 
and have a single skip on top.

All cleaner IMHO than ksft_test_result_if_softdirty ;)

-- 
Cheers,

David / dhildenb

