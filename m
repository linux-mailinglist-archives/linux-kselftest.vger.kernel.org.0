Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496795FDEAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 19:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJMRK1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 13:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJMRKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 13:10:23 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6583F51A2E
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 10:10:22 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id u2so1290357ilv.6
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ut3IJn5YguVAJiDT/xFMzy3gQTlor63h4VFTKLUbEM=;
        b=gMylnowM8qSEF/HMJHGiCE+pUDilZbKsRldVwVMAOh0snrqdIFzSsmneMfCnMM1Uzv
         QzdixvWh9sFxoNJ95cf6VKuGAxUSDNhR3W5EA9wh6F8M6RaKOqPe5td8XLnmkI/nh4RU
         hxYPgKdlliwKs1tqrgshhehCVPguLCJQZ6X/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ut3IJn5YguVAJiDT/xFMzy3gQTlor63h4VFTKLUbEM=;
        b=avTtvR9RkxrtMn/2gXB5c8pVPfvNK1ojnQyolkXmojLZ0NazQgJxvYayeltibvZirS
         PlxmsqhzGDO9wAm2ns0GW7M7UbYeTGtcVYYtvJXCQg0TzPqFUGpoxFTflZcynJySCCzK
         bXtY0o8jQvtOfItjjV10hM96b1X5lc4HaGGCUMJPxYmOrAcxOKBj2H/BB0TWVYAiHYmw
         fV+SNzEfSKiqQNgBeKRPC4Qh7nVB07mUseYeVFFy2JVG1QibRuw65Y2Lye/0rm0R38q3
         FOpW7WPEs+d6FtxzpTFxFfgtmq2UnL2bJDi9qYt9736fSQ5yqSeNslyeUuHE9gk4fkTT
         BRww==
X-Gm-Message-State: ACrzQf14p1dNEeBO8U8QUceO9SWxfuMZAk23ewHY7s/5oVcwWoHdLyuo
        2EH83m3rmO1ISpQSLmWwB0BMwQ==
X-Google-Smtp-Source: AMsMyM4shy0V/vvJOp5C+M3fzvgjfTV95CCS8UuwUOggKtwayh2zIvYOI8000Mw4vcCZnbtj9mByHA==
X-Received: by 2002:a05:6e02:1c87:b0:2fa:d3d7:8a29 with SMTP id w7-20020a056e021c8700b002fad3d78a29mr481628ill.179.1665681021505;
        Thu, 13 Oct 2022 10:10:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z19-20020a056638241300b0035a578870a4sm157756jat.129.2022.10.13.10.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 10:10:20 -0700 (PDT)
Message-ID: <44fcecda-31a4-7288-1848-63003dfe0a7d@linuxfoundation.org>
Date:   Thu, 13 Oct 2022 11:10:20 -0600
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
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <7e2e6679-3205-3540-f522-9eaed2940559@redhat.com>
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

On 10/13/22 11:01, David Hildenbrand wrote:
> On 13.10.22 18:54, Vlastimil Babka wrote:
>> Hi,
>>
>> I've been trying the hmm_tests as of today's commit:
>>
>> a185a0995518 ("Merge tag 'linux-kselftest-kunit-6.1-rc1-2' ...)
>>
>> and run into several issues that seemed worth reporting.
>>
>> First, it seems the FIXTURE_TEARDOWN(hmm) in
>> tools/testing/selftests/vm/hmm-tests.c
>> using ASSERT_EQ(ret, 0); can run into an infinite loop of reporting the
>> assertion failure. Dunno if it's a kselftests issue or it's a bug to
>> use asserts in teardown. I hacked it up like this locally to proceed:
>>
>> --- a/tools/testing/selftests/vm/hmm-tests.c
>> +++ b/tools/testing/selftests/vm/hmm-tests.c
>> @@ -154,6 +154,11 @@ FIXTURE_TEARDOWN(hmm)
>>   {
>>       int ret = close(self->fd);
>> +    if (ret != 0) {
>> +        fprintf(stderr, "close returned (%d) fd is (%d)\n", ret,self->fd);
>> +        exit(1);
>> +    }
>> +
>>       ASSERT_EQ(ret, 0);
>>       self->fd = -1;
>>   }
>>
>> Next, there are some tests that fail (and thus also trigger the issue above)
>>
>> #  RUN           hmm.hmm_device_private.exclusive ...
>> # hmm-tests.c:1702:exclusive:Expected ret (-16) == 0 (0)
>> close returned (-1) fd is (3)
>> # exclusive: Test failed at step #1
>> #          FAIL  hmm.hmm_device_private.exclusive
>> not ok 20 hmm.hmm_device_private.exclusive
>> #  RUN           hmm.hmm_device_private.exclusive_mprotect ...
>> # hmm-tests.c:1756:exclusive_mprotect:Expected ret (-16) == 0 (0)
>> close returned (-1) fd is (3)
>> # exclusive_mprotect: Test failed at step #1
>> #          FAIL  hmm.hmm_device_private.exclusive_mprotect
>> not ok 21 hmm.hmm_device_private.exclusive_mprotect
>> #  RUN           hmm.hmm_device_private.exclusive_cow ...
>> # hmm-tests.c:1809:exclusive_cow:Expected ret (-16) == 0 (0)
>> close returned (-1) fd is (3)
>> # exclusive_cow: Test failed at step #1
>> #          FAIL  hmm.hmm_device_private.exclusive_cow
>> not ok 22 hmm.hmm_device_private.exclusive_cow
>>
>>
> 
> When did that test start failing? Was it still ok for 6.0?
> 

commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f (tag: v6.0, linux/master)

# FAILED: 25 / 50 tests passed.
# Totals: pass:25 fail:25 xfail:0 xpass:0 skip:0 error:0

Looks good to me.

Possible change in 6.1 and we have to time fix them all. :)

thanks,
-- Shuah
