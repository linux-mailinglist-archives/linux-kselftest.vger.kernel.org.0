Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3BB5FE2CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 21:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiJMTik (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 15:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJMTib (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 15:38:31 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FCA183DAB
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 12:38:26 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r142so2225217iod.11
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/qPChDMs0oj8qrjGozguno+4qFo0qn/A0exuIvNQrY=;
        b=KkWHiT9dlNw9P6CEdY5QNtQ63vDUnz7Xd7/usAAnCerQAn2hChTNNy805ga3ZBL251
         +pnWzGpx2ywYhJe0W2axPKtfMKuykSSfhfynjiXhnG2gcenn8T5K6oqgHAFUt/WjMYIR
         hquxRCW/QOKbpSPMn12hjNQ3NZ32Dpy3KobTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/qPChDMs0oj8qrjGozguno+4qFo0qn/A0exuIvNQrY=;
        b=HX7pfTWwQV/cGdul7EUtlhq7asTcg9nKyan9RCHHm7jMocRw8UmO0Vz+//IbpfGyJv
         86RLRCuv/ImHlMQWpsQ99SlVxb0bsC/H3zbon5Xb75P/kUVr7jdP+jLXROrwYZ7E63DG
         EXFWKZz1P2vmYgYDwEwSzk6/2gA57hv6orpDlKTJb6K2rcizSUXrp/Jpm7crk9MjPa7y
         e/1PZ+JXdJ0HTuDcUiIEe5RyEj/fQYVw107qvMxHG6oDkUqLqo+iSFS2pzddtLfICGMV
         OZDmJKiSQ/hxuI0lhoch9TFc39bBSVUivXA7Dg4Fq70pLqVNj1D0y+pUIQyynaKUWfQp
         YBRQ==
X-Gm-Message-State: ACrzQf2sMOCfUfLg/9y/dpknuWyllnQrzUPBV54E2KdEHY7jSGks2UmJ
        E6/GuJqu2e4skhTICtWmmIm8Mg==
X-Google-Smtp-Source: AMsMyM7/usZtdj1fRr63VhfBK9sMSkZn/jAa7j6TZUtdkqI3+B/FVihyhgYSjPNfFgJNFyhxVBXUrA==
X-Received: by 2002:a05:6602:3c7:b0:6a4:334d:3344 with SMTP id g7-20020a05660203c700b006a4334d3344mr673987iov.21.1665689904625;
        Thu, 13 Oct 2022 12:38:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h5-20020a92d845000000b002fa7b6e9cf5sm184013ilq.31.2022.10.13.12.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 12:38:24 -0700 (PDT)
Message-ID: <a7b3cf86-4578-c23d-7326-4ddf7dcda043@linuxfoundation.org>
Date:   Thu, 13 Oct 2022 13:38:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: hmm_test issues with latest mainline
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
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
 <0e02ace6-2fad-47d2-03b9-d8a46f256097@suse.cz>
 <ecebc355-eff8-0046-3749-8738ed1954de@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ecebc355-eff8-0046-3749-8738ed1954de@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/13/22 12:00, David Hildenbrand wrote:
>>>>> When did that test start failing? Was it still ok for 6.0?
>>>
>>> Didn't test yet, will try, in case it's my system/config specific thing.
>>
>> So it's actually all the same with v6.0 for me. The infinite loops, the test
>> failures, the misreported SKIPs.
>>

I am not seeing infinite loops and seeing 25 failures which could
be skips.

> 
> Is the kernel compiled with support. I have the feeling that we might simply miss kernel support and it's not handled gracefully ...
> 

Here is my config
CONFIG_HMM_MIRROR=y
# CONFIG_TEST_HMM is not set

Okay here is what is going on - hmm_tests are supposed to be run
from test_hmm.sh script. When I run this I see a message that tells
me what to do.

sudo ./test_hmm.sh
./test_hmm.sh: You must have the following enabled in your kernel:
CONFIG_TEST_HMM=m

Running ./hmm_tests gives me all the failures. So it appears running
hmm_tests executable won't work. This is expected as test_hmm.sh does
the right setup before running the test. We have several tests that do
that.

Vlastimil, can you try this and let me know what you see. I will compile
with CONFIG_TEST_HMM=m and let you know what I see on my system.

thanks,
-- Shuah



