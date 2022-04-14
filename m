Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBF5500CC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 14:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbiDNMKu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 08:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiDNMKt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 08:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DD9D1DA79
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649938103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdEPQ+wG3Peh5GfZ+GSOH74X+dUYxypPpelcJ9DVnmI=;
        b=acEDEdm+HFnuC97MmBobahhZ0VEJUrg/DQLfiHhQkPZKCeubXN2nwxrnj+n0RxF/g4fjQJ
        XPVwJ5X75yDSiYoWmF6Z5QxaT7Rv4LF0XVDu6b6jbdZvn/2nj6tfbTvypgaw+A6YAD86+G
        GjXMFpP/oa6vLPs0N7iWaivDvBl2qNY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-HIGpph5VNHWqsqI8GUfrYA-1; Thu, 14 Apr 2022 08:08:22 -0400
X-MC-Unique: HIGpph5VNHWqsqI8GUfrYA-1
Received: by mail-wr1-f71.google.com with SMTP id 65-20020adf8147000000b00207982c3692so795833wrm.15
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 05:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TdEPQ+wG3Peh5GfZ+GSOH74X+dUYxypPpelcJ9DVnmI=;
        b=Xs3ZX+f648bOlIXMuNZBrGHVK3fwnEOuc7mvzGTC09jFo5L5EZedpIrYmbJhHydKDY
         pGSn/0RVk4RzNlCF2BtA7P8/4rOfn7nzC4KY7V9K9IAL6P0qCs+QsjoU/k62KFwbWUqO
         76tv33i3XcY1bpRYtJXbFjAx02aw5PauqrY9TbmmuJrKEXe+lU5dmhK0rpUCqAZxNeLf
         Vgz6telBuERXoEBrXrYGTm2gLodKGqfhSPVjjUemqdBWe1gFGGTaJFtYsnqf7bjAlcd2
         jOTH9ZZfZxArUiaBqa0eY0d7Ef6caUgobQe17466vWx7Nq2ZoSxnh44jaThckFmJ9eeo
         S2Dw==
X-Gm-Message-State: AOAM533KHZOKd8jR1fHqs1+ZjJDz4Y8+sot7H+fdwzIT9aZqykQm1SQp
        fJA+d+f11rGyBjVRFFnZH/TjocfDKo2XWLPsdv75FF5/6p1GgDhCnTKzD6FDXgOpN8XIxQVtJBW
        5N/PBudiHQdWFg2nmLZy+MJMA2jlY
X-Received: by 2002:a5d:5982:0:b0:207:aba9:663 with SMTP id n2-20020a5d5982000000b00207aba90663mr1891754wri.670.1649938101001;
        Thu, 14 Apr 2022 05:08:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUhSzTr++Kzbz2LwNG/6DzQYVDbN5UKzODQH5RchAHdnNaseLGeV/0xMg0Ul5vY1VzNfHloA==
X-Received: by 2002:a5d:5982:0:b0:207:aba9:663 with SMTP id n2-20020a5d5982000000b00207aba90663mr1891731wri.670.1649938100771;
        Thu, 14 Apr 2022 05:08:20 -0700 (PDT)
Received: from [10.33.192.232] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id m7-20020adfe0c7000000b002060e7bbe49sm2042226wri.45.2022.04.14.05.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 05:08:20 -0700 (PDT)
Message-ID: <03f62ec7-2f7f-1f90-3029-d93713ab5afc@redhat.com>
Date:   Thu, 14 Apr 2022 14:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] KVM: s390: selftests: Use TAP interface in the tprot
 test
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>
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
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220414135110.6b2baead@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/04/2022 13.51, Claudio Imbrenda wrote:
> On Thu, 14 Apr 2022 12:53:21 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The tprot test currently does not have any output (unless one of
>> the TEST_ASSERT statement fails), so it's hard to say for a user
>> whether a certain new sub-test has been included in the binary or
>> not. Let's make this a little bit more user-friendly and include
>> some TAP output via the kselftests.h interface.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tools/testing/selftests/kvm/s390x/tprot.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
>> index c097b9db495e..a714b4206e95 100644
>> --- a/tools/testing/selftests/kvm/s390x/tprot.c
>> +++ b/tools/testing/selftests/kvm/s390x/tprot.c
>> @@ -8,6 +8,7 @@
>>   #include <sys/mman.h>
>>   #include "test_util.h"
>>   #include "kvm_util.h"
>> +#include "kselftest.h"
>>   
>>   #define PAGE_SHIFT 12
>>   #define PAGE_SIZE (1 << PAGE_SHIFT)
>> @@ -69,6 +70,7 @@ enum stage {
>>   	STAGE_INIT_FETCH_PROT_OVERRIDE,
>>   	TEST_FETCH_PROT_OVERRIDE,
>>   	TEST_STORAGE_PROT_OVERRIDE,
>> +	NUM_STAGES			/* this must be the last entry */
>>   };
>>   
>>   struct test {
>> @@ -196,6 +198,7 @@ static void guest_code(void)
>>   	}									\
>>   	ASSERT_EQ(uc.cmd, UCALL_SYNC);						\
>>   	ASSERT_EQ(uc.args[1], __stage);						\
>> +	ksft_test_result_pass("" #stage "\n");					\
>>   })
>>   
>>   int main(int argc, char *argv[])
>> @@ -204,6 +207,9 @@ int main(int argc, char *argv[])
>>   	struct kvm_run *run;
>>   	vm_vaddr_t guest_0_page;
>>   
>> +	ksft_print_header();
>> +	ksft_set_plan(NUM_STAGES - 1);	/* STAGE_END is not counted, thus - 1 */
>> +
>>   	vm = vm_create_default(VCPU_ID, 0, guest_code);
>>   	run = vcpu_state(vm, VCPU_ID);
>>   
>> @@ -213,7 +219,7 @@ int main(int argc, char *argv[])
>>   
>>   	guest_0_page = vm_vaddr_alloc(vm, PAGE_SIZE, 0);
>>   	if (guest_0_page != 0)
>> -		print_skip("Did not allocate page at 0 for fetch protection override tests");
>> +		ksft_print_msg("Did not allocate page at 0 for fetch protection override tests\n");
> 
> will this print a skip, though?

No, it's now only a message.

> or you don't want to print a skip because then the numbering in the
> planning doesn't match anymore?

Right.

> in which case, is there an easy way to fix it?

Honestly, this part of the code is a little bit of a riddle to me - I wonder 
why this was using "print_skip()" at all, since the HOST_SYNC below is 
executed anyway... so this sounds rather like a warning message to me that 
says that the following test might not work as expected, instead of a real 
test-is-skipped message?

Janis, could you please clarify the intention here?

  Thomas

>>   	HOST_SYNC(vm, STAGE_INIT_FETCH_PROT_OVERRIDE);
>>   	if (guest_0_page == 0)
>>   		mprotect(addr_gva2hva(vm, (vm_vaddr_t)0), PAGE_SIZE, PROT_READ);
>> @@ -224,4 +230,8 @@ int main(int argc, char *argv[])
>>   	run->s.regs.crs[0] |= CR0_STORAGE_PROTECTION_OVERRIDE;
>>   	run->kvm_dirty_regs = KVM_SYNC_CRS;
>>   	HOST_SYNC(vm, TEST_STORAGE_PROT_OVERRIDE);
>> +
>> +	kvm_vm_free(vm);
>> +
>> +	ksft_finished();
>>   }
> 

