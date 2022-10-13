Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047245FDEFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJMRaX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 13:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJMRaN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 13:30:13 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A2ADFA5
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 10:29:48 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id o65so1934700iof.4
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fT64XeG+Xp7CtB2NYEREkqT6LH6syUwPmfpl29qc4G8=;
        b=Z3usybDGwg1eXknYWj7+HF8+VHl1hrW5HYau86mWSdpbd8C+2lOQscf7G3e/xtFPiw
         KPXWmUzR5o3TnW9iuQXm/mBPbQq2cvPC3+kKPhiitLCD0mfR1qj8eNng6fqMPn4oUEdz
         BccdEZ1mnQbk8yIHuL+o5J7hyZSNi/06CBhBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fT64XeG+Xp7CtB2NYEREkqT6LH6syUwPmfpl29qc4G8=;
        b=lkihXan6pv7LFoRUla8Nf2RlPpMPULQyJwV/RyQZfxdrC4FRfyKdYXPZyu/ENKIwMN
         4tkmbHI789jRDZ6MddEPyWn8meK6ivix0vT1B2FeUrVzkKoMJj+UkTPk+TZ33H8fFfM0
         kD1eMy/vXkVl44wvR7vehWaue2RtxQtVhfj98VQBXtlEEUI3AxSVNl3/ENbL4MCVd6xc
         NFmuzkXyM+hWFK3H33z7f3DWkjxyaJowMVvPaTPQ6qT8T6UkQyeyf1G9ck28wobXkhJp
         MbZrpsslhdn1hhPiWHRdbLZaKnoj3oaLtCBfu2016VLaO46RAWsSEYDOSqetyLRnGSTN
         Rwfg==
X-Gm-Message-State: ACrzQf2K+64RL8r2Tm9KaFu5zGIe8bIW6ZkViVveekQUQ1XmUHLQWc2z
        s5FZew4qdlsVaFImJuqXEbWzMA==
X-Google-Smtp-Source: AMsMyM6yVCSd/bZ1cMUJHp7lgg3Kj5H0R32jQYOjF8nuCbGAwYX1VfdvG9PDrRhWDnoLrXEa65OC+g==
X-Received: by 2002:a6b:f117:0:b0:6bb:fa86:920d with SMTP id e23-20020a6bf117000000b006bbfa86920dmr476808iog.180.1665682187117;
        Thu, 13 Oct 2022 10:29:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a10-20020a056602148a00b006aed243a244sm94442iow.54.2022.10.13.10.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 10:29:46 -0700 (PDT)
Message-ID: <479aec54-fa65-2031-e891-332af275e067@linuxfoundation.org>
Date:   Thu, 13 Oct 2022 11:29:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: hmm_test issues with latest mainline
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
 <7e2e6679-3205-3540-f522-9eaed2940559@redhat.com>
 <44fcecda-31a4-7288-1848-63003dfe0a7d@linuxfoundation.org>
 <04114304-7b35-d42f-0155-087e3b6237c6@suse.cz>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <04114304-7b35-d42f-0155-087e3b6237c6@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/13/22 11:12, Vlastimil Babka wrote:
> On 10/13/22 19:10, Shuah Khan wrote:
>> On 10/13/22 11:01, David Hildenbrand wrote:
>>> On 13.10.22 18:54, Vlastimil Babka wrote:
>>>> Hi,
>>>>
>>>> I've been trying the hmm_tests as of today's commit:
>>>>
>>>> a185a0995518 ("Merge tag 'linux-kselftest-kunit-6.1-rc1-2' ...)
>>>>
>>>> and run into several issues that seemed worth reporting.
>>>>
>>>> First, it seems the FIXTURE_TEARDOWN(hmm) in
>>>> tools/testing/selftests/vm/hmm-tests.c
>>>> using ASSERT_EQ(ret, 0); can run into an infinite loop of reporting the
>>>> assertion failure. Dunno if it's a kselftests issue or it's a bug to
>>>> use asserts in teardown. I hacked it up like this locally to proceed:
>>>>
>>>> --- a/tools/testing/selftests/vm/hmm-tests.c
>>>> +++ b/tools/testing/selftests/vm/hmm-tests.c
>>>> @@ -154,6 +154,11 @@ FIXTURE_TEARDOWN(hmm)
>>>>    {
>>>>        int ret = close(self->fd);
>>>> +    if (ret != 0) {
>>>> +        fprintf(stderr, "close returned (%d) fd is (%d)\n", ret,self->fd);
>>>> +        exit(1);
>>>> +    }
>>>> +
>>>>        ASSERT_EQ(ret, 0);
>>>>        self->fd = -1;
>>>>    }
>>>>
>>>> Next, there are some tests that fail (and thus also trigger the issue above)
>>>>
>>>> #  RUN           hmm.hmm_device_private.exclusive ...
>>>> # hmm-tests.c:1702:exclusive:Expected ret (-16) == 0 (0)
>>>> close returned (-1) fd is (3)
>>>> # exclusive: Test failed at step #1
>>>> #          FAIL  hmm.hmm_device_private.exclusive
>>>> not ok 20 hmm.hmm_device_private.exclusive
>>>> #  RUN           hmm.hmm_device_private.exclusive_mprotect ...
>>>> # hmm-tests.c:1756:exclusive_mprotect:Expected ret (-16) == 0 (0)
>>>> close returned (-1) fd is (3)
>>>> # exclusive_mprotect: Test failed at step #1
>>>> #          FAIL  hmm.hmm_device_private.exclusive_mprotect
>>>> not ok 21 hmm.hmm_device_private.exclusive_mprotect
>>>> #  RUN           hmm.hmm_device_private.exclusive_cow ...
>>>> # hmm-tests.c:1809:exclusive_cow:Expected ret (-16) == 0 (0)
>>>> close returned (-1) fd is (3)
>>>> # exclusive_cow: Test failed at step #1
>>>> #          FAIL  hmm.hmm_device_private.exclusive_cow
>>>> not ok 22 hmm.hmm_device_private.exclusive_cow
>>>>
>>>>
>>>
>>> When did that test start failing? Was it still ok for 6.0?
> 
> Didn't test yet, will try, in case it's my system/config specific thing.
> 
>>>
>>
>> commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f (tag: v6.0, linux/master)
>>
>> # FAILED: 25 / 50 tests passed.
>> # Totals: pass:25 fail:25 xfail:0 xpass:0 skip:0 error:0
>>
>> Looks good to me.
> 
> Hmm but there's 25 that failed? Or are those also misreported SKIPs?
> 

Likely the case. Here is an observation. All of these FAILs are coming
from line 141 which is FIXTURE_SETUP. See the result:

# hmm-tests.c:141:open_close:Expected self->fd (-1) >= 0 (0)
# open_close: Test terminated by assertion
#          FAIL  hmm.hmm_device_private.open_close
not ok 1 hmm.hmm_device_private.open_close

However the code is:

FIXTURE_SETUP(hmm)
{
         self->page_size = sysconf(_SC_PAGE_SIZE);
         self->page_shift = ffs(self->page_size) - 1;

         self->fd = hmm_open(variant->device_number);
         if (self->fd < 0 && hmm_is_coherent_type(variant->device_number))
                 SKIP(exit(0), "DEVICE_COHERENT not available");

Note: It is SKIP(). It appears it will be reported as fail unless both of
the above conditions are true. Perhaps this check should be either of these
conditions is true, it is skip.

         ASSERT_GE(self->fd, 0);
}


Looks like this test could a review to see if all these conditions should
be a FAIL or SKIP. This problem exists in 6.0.

thanks,
-- Shuah




