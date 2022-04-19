Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A462A5076BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 19:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354629AbiDSRsA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 13:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344857AbiDSRr6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 13:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0B6664D1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650390311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIbd+9/ujIgy/587mPK12BUlw+gv3FwEVww95EhOZhc=;
        b=b04N+a0P2XUSA86Nj7M1RZ0RrZXISXmB7lvwhRaa4G3b0QTlI2jukDU3oqHEmN/gGrvlwW
        7B9h8sO3ugX62gSI6GXfI5x/8WNQ2FnVUitvBBZhWLdfR3eAJXziKmzQpaNL82Jq1S2HTZ
        GyPJ4KdcgycvBIbK7R0Ao9McFay6MBc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-3r0PqllnNl6J8-zYXSEmYg-1; Tue, 19 Apr 2022 13:45:09 -0400
X-MC-Unique: 3r0PqllnNl6J8-zYXSEmYg-1
Received: by mail-wm1-f69.google.com with SMTP id d13-20020a05600c3acd00b0038ff865c043so1667531wms.3
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 10:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CIbd+9/ujIgy/587mPK12BUlw+gv3FwEVww95EhOZhc=;
        b=asm3KHMsre7k3b7rOx3ekScrgfxAEJRefnJHGWPAN9pnW9BuDBdn8ZR7CXhiMiOWUX
         gQ/iHZyIVox1DxFb3DN74wgsgWseCrKwQ/B2Li+F0PPF9W9NlqqlnCXL6nNyENqtToa4
         WPiMb9Qpjn855yF4/rL5pmLZ8zanqDtDaUE6h33oSWZdIpymO29JxNzjLAVFIbhkqEVb
         F0W7LqS6MdWqdAD51EZKN6GfhVhMaCRh+2BsPEEDEgB/rnHhbNPOmFfBYec6FyTzRI0O
         D3j0tHs/68r5rS77MghQIC+yL80LljMLBOhZMDGTQl0ARoZuHmxL/vXvh5IznKbx3bUn
         UH6Q==
X-Gm-Message-State: AOAM530dNWRUMaHXU6i6XoLAxN2ZwTbVI1C0qI96ie6y2SWRm7obmXlQ
        TKAQJeovKODUivN/LYY1zY/v/C2Z+0TXYB1yb3rfik1Y7fpFwYuhMfh6KjnPSomS/FJjhRSDZcE
        qEqU5LEIAXyomzIgIYvlFQeqdfcX8
X-Received: by 2002:a1c:a185:0:b0:392:206d:209d with SMTP id k127-20020a1ca185000000b00392206d209dmr16849532wme.168.1650390308382;
        Tue, 19 Apr 2022 10:45:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/q6xzI4l79WNqJp4QrxQovesx47Z6kxd94l2NB9OHznkozrBCR/2cZw/3pLy6rdL1bbtQkw==
X-Received: by 2002:a1c:a185:0:b0:392:206d:209d with SMTP id k127-20020a1ca185000000b00392206d209dmr16849514wme.168.1650390308129;
        Tue, 19 Apr 2022 10:45:08 -0700 (PDT)
Received: from [192.168.8.102] (dynamic-046-114-170-162.46.114.pool.telefonica.de. [46.114.170.162])
        by smtp.gmail.com with ESMTPSA id v188-20020a1cacc5000000b0038e9c60f0e7sm16397144wme.28.2022.04.19.10.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 10:45:07 -0700 (PDT)
Message-ID: <c44de70a-60e3-65b6-14a7-3e4400f3084b@redhat.com>
Date:   Tue, 19 Apr 2022 19:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/4] KVM: s390: selftests: Use TAP interface in the tprot
 test
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
References: <20220414105322.577439-1-thuth@redhat.com>
 <20220414105322.577439-4-thuth@redhat.com>
 <20220414135110.6b2baead@p-imbrenda>
 <03f62ec7-2f7f-1f90-3029-d93713ab5afc@redhat.com>
 <baa53445-b4de-7a05-24f5-46fa38e61666@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <baa53445-b4de-7a05-24f5-46fa38e61666@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/04/2022 14.33, Janis Schoetterl-Glausch wrote:
> On 4/14/22 14:08, Thomas Huth wrote:
>> On 14/04/2022 13.51, Claudio Imbrenda wrote:
>>> On Thu, 14 Apr 2022 12:53:21 +0200
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>> The tprot test currently does not have any output (unless one of
>>>> the TEST_ASSERT statement fails), so it's hard to say for a user
>>>> whether a certain new sub-test has been included in the binary or
>>>> not. Let's make this a little bit more user-friendly and include
>>>> some TAP output via the kselftests.h interface.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    tools/testing/selftests/kvm/s390x/tprot.c | 12 +++++++++++-
>>>>    1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
>>>> index c097b9db495e..a714b4206e95 100644
>>>> --- a/tools/testing/selftests/kvm/s390x/tprot.c
>>>> +++ b/tools/testing/selftests/kvm/s390x/tprot.c
>>>> @@ -8,6 +8,7 @@
>>>>    #include <sys/mman.h>
>>>>    #include "test_util.h"
>>>>    #include "kvm_util.h"
>>>> +#include "kselftest.h"
>>>>      #define PAGE_SHIFT 12
>>>>    #define PAGE_SIZE (1 << PAGE_SHIFT)
>>>> @@ -69,6 +70,7 @@ enum stage {
>>>>        STAGE_INIT_FETCH_PROT_OVERRIDE,
>>>>        TEST_FETCH_PROT_OVERRIDE,
>>>>        TEST_STORAGE_PROT_OVERRIDE,
>>>> +    NUM_STAGES            /* this must be the last entry */
> 
> You could move STAGE_END down and use that instead.
> 
>>>>    };
>>>>      struct test {
>>>> @@ -196,6 +198,7 @@ static void guest_code(void)
>>>>        }                                    \
>>>>        ASSERT_EQ(uc.cmd, UCALL_SYNC);                        \
>>>>        ASSERT_EQ(uc.args[1], __stage);                        \
>>>> +    ksft_test_result_pass("" #stage "\n");                    \
>>>>    })
>>>>      int main(int argc, char *argv[])
>>>> @@ -204,6 +207,9 @@ int main(int argc, char *argv[])
>>>>        struct kvm_run *run;
>>>>        vm_vaddr_t guest_0_page;
>>>>    +    ksft_print_header();
>>>> +    ksft_set_plan(NUM_STAGES - 1);    /* STAGE_END is not counted, thus - 1 */
>>>> +
>>>>        vm = vm_create_default(VCPU_ID, 0, guest_code);
>>>>        run = vcpu_state(vm, VCPU_ID);
>>>>    @@ -213,7 +219,7 @@ int main(int argc, char *argv[])
>>>>          guest_0_page = vm_vaddr_alloc(vm, PAGE_SIZE, 0);
>>>>        if (guest_0_page != 0)
>>>> -        print_skip("Did not allocate page at 0 for fetch protection override tests");
>>>> +        ksft_print_msg("Did not allocate page at 0 for fetch protection override tests\n");
>>>
>>> will this print a skip, though?
>>
>> No, it's now only a message.
>>
>>> or you don't want to print a skip because then the numbering in the
>>> planning doesn't match anymore?
>>
>> Right.
>>
>>> in which case, is there an easy way to fix it?
>>
>> Honestly, this part of the code is a little bit of a riddle to me - I wonder why this was using "print_skip()" at all, since the HOST_SYNC below is executed anyway... so this sounds rather like a warning message to me that says that the following test might not work as expected, instead of a real test-is-skipped message?
>>
>> Janis, could you please clarify the intention here?
> 
> Both the host and the guest check the same condition independently, the host just to print the message,
> then the guest is run and skips those stages.

Ok.

However, I'm not sure how to make this use ksft_test_result_skip() in a nice 
way now, though, without makeing the macro way uglier ...
I'll have a try, but if that does not work out I'd suggest to simply keep 
the ksft_print_msg() here instead.

  Thomas

