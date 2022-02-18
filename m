Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E102C4BC197
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 22:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbiBRVPE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 16:15:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiBRVPE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 16:15:04 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F662311B4
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 13:14:46 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e79so9059258iof.13
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 13:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9OJSdScnlbqpsx7gaJ1EijvzjcTEFHzFZ0fM3gifr4w=;
        b=dUgNSlLWGXT4unbLz8g8o5jQ8/MxeQtzYmmIDBsG5micBWdhRpq+Ji2CN//xHH3X9D
         ZPhzKJTYpnIUKT1ylKeEpOe5VjddgiFhQBLqss/osdPBItEIgO5P1t3Gluoy01xUy9rg
         S+entrnn5pscyIAFXpJCrQBlzm9RYt9upIgu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9OJSdScnlbqpsx7gaJ1EijvzjcTEFHzFZ0fM3gifr4w=;
        b=XyMwD0xkJnxBQxYSRu3eSirYD8ZwTIdMGxAH1jk6Z1DaBLLg3nYaBaBaEQsd1QuZzw
         W5i9Flg11UgoJOinXcYG6X8kGoysLVGyLIQn7P/I0nCdmwKMIs1KdwxVG5BhlpZUOLyk
         qTmR5bNAHRkYI+68svsZwwWqOd08PdoDGemB5ZiOSEqNy7riX9aprjX6LQOdSkRC91Vu
         vuMCC8HT0btn4HUFFCVieePA4d5473L68l5wMxTiMs1FHV2Pa+mfwpvbEK0aYgGp6MtF
         cM28RR0WT6f3CS6HdZaYSpHNN3NXBulsBg5tCc+m1f7QmdCda4zA8gl1izWmOjKZaJUe
         8x6Q==
X-Gm-Message-State: AOAM530yQAKxnAhceIq4GAoJvm98AK/fYt9pWVZGlkV9DkvDmjW1NDYb
        4sdEVUd9O8HRVymIqoBQRktBBA==
X-Google-Smtp-Source: ABdhPJy0+aMr8b7NsG7Xs0Tk4hWTZWPnjtQrNL2yG6p6Z6xUkLKb0IpxDzj5q62nEtwY0m/d1hG3wA==
X-Received: by 2002:a02:9529:0:b0:314:5808:5de2 with SMTP id y38-20020a029529000000b0031458085de2mr6401382jah.68.1645218885917;
        Fri, 18 Feb 2022 13:14:45 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id m4sm4166132iln.48.2022.02.18.13.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 13:14:45 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: s390: selftests: Test vm and vcpu memop with
 keys
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220217145336.1794778-1-scgl@linux.ibm.com>
 <20220217145336.1794778-3-scgl@linux.ibm.com>
 <7d0b5b03-21f4-0402-779a-788d4bd58071@linuxfoundation.org>
 <2af9c3a9-e5a1-484b-9c1e-693a25993cdb@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <eb5c437a-032b-f710-4254-beed32088456@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 14:14:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2af9c3a9-e5a1-484b-9c1e-693a25993cdb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/18/22 5:14 AM, Janis Schoetterl-Glausch wrote:
> On 2/17/22 18:54, Shuah Khan wrote:
>> On 2/17/22 7:53 AM, Janis Schoetterl-Glausch wrote:
>>> Test storage key checking for both vm and vcpu MEM_OP ioctls.
>>> Test both error and non error conditions.
>>>
>>
>> This patch seems to combine restructuring the code and new code.
>> e,g test_errors() was added in the last patch, only to be redone
>> in this patch with test_errors split into test_common_errors()
>>
>> Doing restructure in a separate patch and then adding new code
>> makes it easier to review and also keep them simpler patches.
>>
>> Please split the code in these two patches to just do restructure
>> and then add new code.
>>
>> I also would like to have good reasons to change existing code and
>> make them into macros.
>>   
>>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>>> ---
>>>    tools/testing/selftests/kvm/s390x/memop.c | 342 +++++++++++++++++++++-
>>>    1 file changed, 328 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
>>> index 4510418d73e6..bc12a9238967 100644
>>> --- a/tools/testing/selftests/kvm/s390x/memop.c
>>> +++ b/tools/testing/selftests/kvm/s390x/memop.c
>>> @@ -201,6 +201,8 @@ static int err_memop_ioctl(struct test_vcpu vcpu, struct kvm_s390_mem_op *ksmo)
>>>    #define PAGE_SHIFT 12
>>>    #define PAGE_SIZE (1ULL << PAGE_SHIFT)
>>>    #define PAGE_MASK (~(PAGE_SIZE - 1))
>>> +#define CR0_FETCH_PROTECTION_OVERRIDE    (1UL << (63 - 38))
>>> +#define CR0_STORAGE_PROTECTION_OVERRIDE    (1UL << (63 - 39))
>>>      #define ASSERT_MEM_EQ(p1, p2, size) \
>>>        TEST_ASSERT(!memcmp(p1, p2, size), "Memory contents do not match!")
>>> @@ -235,6 +237,11 @@ static struct test_default test_default_init(void *guest_code)
>>>        return t;
>>>    }
>>>    +static vm_vaddr_t test_vaddr_alloc(struct test_vcpu vm, size_t size, vm_vaddr_t vaddr_min)
>>> +{
>>> +    return vm_vaddr_alloc(vm.vm, size, vaddr_min);
>>> +}
>>> +
>>
>> What is the value of adding a new routine that simply calls another?
> 
> I just found the vm.vm confusing/ugly and wanted to hide it,
> I'm not married to that idea, tho.
> 
>> Do you see this routine changing in the future to do more?
> 
> No.
>>


Let's drop it the new routine then.

thanks,
-- Shuah

