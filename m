Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB3C500CBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbiDNMEz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 08:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235738AbiDNMEy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 08:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68EDBB863
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649937748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3FMxX8GyVoS8mf6ZxYvPq6BenaD/e/QdsrS7P4PzMs=;
        b=VghNnlGJ5Y+6ARhdv2X5z3j4n7GK1u+uKUVbWMAcGrRoYKc8zIYO+0JJtBMuzEchkNV33p
        UF+D8Su/u9EZ3xWd3rY3FHUNs4kL/gNwS1ywUwx5YXtLoolCVtcHbb0l/0i7eJPBoKFCE7
        N6R0suo+CG7rc33p24/eVm/EFVBTz8w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-sas3eGfuMc6-pt0CxEm3cQ-1; Thu, 14 Apr 2022 08:02:27 -0400
X-MC-Unique: sas3eGfuMc6-pt0CxEm3cQ-1
Received: by mail-wr1-f70.google.com with SMTP id j67-20020adf9149000000b00203e6b7d151so791347wrj.13
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Apr 2022 05:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z3FMxX8GyVoS8mf6ZxYvPq6BenaD/e/QdsrS7P4PzMs=;
        b=H1kI1xX8hYQ2qXg1w52juYpez5OEDpGlBe0SGkgtUgePxllKWEEhcB5PXILgymvNad
         lVn2Ezgt8R1JugmT9hElDe20fVmEyOMWheUqvItQkifj4n09k0YW6lLBhfpQ3a22WLsx
         M0HbOOxFaGp3fMFMoZzJRlBtcYNMQPaDVD8gjALQhy76LkGzMA2EPa95SmGsaW/23064
         HToZZI3P6LPHdCCCt64Ytf7P4olWuA2Vw68zC+ujmGl828dUnzvaU3JbyHrJik7983Y1
         zgQxSXzAhD4qJ2b2/FmcYalNW66OEGRPAsAUdLbDQwnFyWuKvmsJbEg83gFCXh/yIotY
         szoA==
X-Gm-Message-State: AOAM5306C0b5SchTZsWg/XiHdN0xc5xJpnpZyBNpJj2Wy+upAXZH0zuR
        P9xia2xaqTNzOBIlchaRiXuFb2k02SsgxqYoOuFsS4YV9/2mUrTXhIdjpOqVO1R+e4m+tfcgenM
        stk/EffN+4laZgX8JmW+x1aQMNv84
X-Received: by 2002:a5d:434e:0:b0:207:a48e:a99a with SMTP id u14-20020a5d434e000000b00207a48ea99amr1881969wrr.250.1649937746164;
        Thu, 14 Apr 2022 05:02:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnemt8GV6C+iUV4Xujnf7yfMt3Y2E26lDSV3mnOBMJsHfd0I9Yp1JsK0iCHFs148mOqJpc6A==
X-Received: by 2002:a5d:434e:0:b0:207:a48e:a99a with SMTP id u14-20020a5d434e000000b00207a48ea99amr1881947wrr.250.1649937745864;
        Thu, 14 Apr 2022 05:02:25 -0700 (PDT)
Received: from [10.33.192.232] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id n32-20020a05600c3ba000b0038ed068052fsm1920811wms.19.2022.04.14.05.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 05:02:25 -0700 (PDT)
Message-ID: <20d27b46-fe1f-4a80-0dba-e0ce5df934c9@redhat.com>
Date:   Thu, 14 Apr 2022 14:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/4] KVM: s390: selftests: Use TAP interface in the
 sync_regs test
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>
References: <20220414105322.577439-1-thuth@redhat.com>
 <20220414105322.577439-3-thuth@redhat.com>
 <20220414133950.20a84eef@p-imbrenda>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220414133950.20a84eef@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/04/2022 13.39, Claudio Imbrenda wrote:
> On Thu, 14 Apr 2022 12:53:20 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The sync_regs test currently does not have any output (unless one
>> of the TEST_ASSERT statement fails), so it's hard to say for a user
>> whether a certain new sub-test has been included in the binary or
>> not. Let's make this a little bit more user-friendly and include
>> some TAP output via the kselftests.h interface.
>> To be able to distinguish the different sub-tests more easily, we
>> also break up the huge main() function here in more fine grained
>> parts.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   .../selftests/kvm/s390x/sync_regs_test.c      | 86 ++++++++++++++-----
>>   1 file changed, 65 insertions(+), 21 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> index caf7b8859a94..d5ddcbb82d12 100644
>> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> @@ -21,6 +21,7 @@
>>   #include "test_util.h"
>>   #include "kvm_util.h"
>>   #include "diag318_test_handler.h"
>> +#include "kselftest.h"
>>   
>>   #define VCPU_ID 5
>>   
>> @@ -74,27 +75,9 @@ static void compare_sregs(struct kvm_sregs *left, struct kvm_sync_regs *right)
>>   #define TEST_SYNC_FIELDS   (KVM_SYNC_GPRS|KVM_SYNC_ACRS|KVM_SYNC_CRS|KVM_SYNC_DIAG318)
>>   #define INVALID_SYNC_FIELD 0x80000000
>>   
>> -int main(int argc, char *argv[])
>> +void test_read_invalid(struct kvm_vm *vm, struct kvm_run *run)
>>   {
>> -	struct kvm_vm *vm;
>> -	struct kvm_run *run;
>> -	struct kvm_regs regs;
>> -	struct kvm_sregs sregs;
>> -	int rv, cap;
>> -
>> -	/* Tell stdout not to buffer its content */
>> -	setbuf(stdout, NULL);
>> -
>> -	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
>> -	if (!cap) {
>> -		print_skip("CAP_SYNC_REGS not supported");
>> -		exit(KSFT_SKIP);
>> -	}
>> -
>> -	/* Create VM */
>> -	vm = vm_create_default(VCPU_ID, 0, guest_code);
>> -
>> -	run = vcpu_state(vm, VCPU_ID);
>> +	int rv;
>>   
>>   	/* Request reading invalid register set from VCPU. */
>>   	run->kvm_valid_regs = INVALID_SYNC_FIELD;
>> @@ -110,6 +93,11 @@ int main(int argc, char *argv[])
>>   		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
>>   		    rv);
>>   	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
>> +}
>> +
>> +void test_set_invalid(struct kvm_vm *vm, struct kvm_run *run)
>> +{
>> +	int rv;
>>   
>>   	/* Request setting invalid register set into VCPU. */
>>   	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
>> @@ -125,6 +113,13 @@ int main(int argc, char *argv[])
>>   		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
>>   		    rv);
>>   	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
>> +}
>> +
>> +void test_req_and_verify_all_valid_regs(struct kvm_vm *vm, struct kvm_run *run)
>> +{
>> +	struct kvm_sregs sregs;
>> +	struct kvm_regs regs;
>> +	int rv;
>>   
>>   	/* Request and verify all valid register sets. */
>>   	run->kvm_valid_regs = TEST_SYNC_FIELDS;
>> @@ -146,6 +141,13 @@ int main(int argc, char *argv[])
>>   
>>   	vcpu_sregs_get(vm, VCPU_ID, &sregs);
>>   	compare_sregs(&sregs, &run->s.regs);
>> +}
>> +
>> +void test_set_and_verify_various_reg_values(struct kvm_vm *vm, struct kvm_run *run)
>> +{
>> +	struct kvm_sregs sregs;
>> +	struct kvm_regs regs;
>> +	int rv;
>>   
>>   	/* Set and verify various register values */
>>   	run->s.regs.gprs[11] = 0xBAD1DEA;
>> @@ -180,6 +182,11 @@ int main(int argc, char *argv[])
>>   
>>   	vcpu_sregs_get(vm, VCPU_ID, &sregs);
>>   	compare_sregs(&sregs, &run->s.regs);
>> +}
>> +
>> +void test_clear_kvm_dirty_regs_bits(struct kvm_vm *vm, struct kvm_run *run)
>> +{
>> +	int rv;
>>   
>>   	/* Clear kvm_dirty_regs bits, verify new s.regs values are
>>   	 * overwritten with existing guest values.
>> @@ -200,8 +207,45 @@ int main(int argc, char *argv[])
>>   	TEST_ASSERT(run->s.regs.diag318 != 0x4B1D,
>>   		    "diag318 sync regs value incorrect 0x%llx.",
>>   		    run->s.regs.diag318);
>> +}
>> +
>> +struct testdef {
>> +	const char *name;
>> +	void (*test)(struct kvm_vm *vm, struct kvm_run *run);
>> +} testlist[] = {
>> +	{ "read invalid", test_read_invalid },
>> +	{ "set invalid", test_set_invalid },
>> +	{ "request+verify all valid regs", test_req_and_verify_all_valid_regs },
>> +	{ "set+verify various regs", test_set_and_verify_various_reg_values },
>> +	{ "clear kvm_dirty_regs bits", test_clear_kvm_dirty_regs_bits },
>> +};
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	static struct kvm_run *run;
>> +	static struct kvm_vm *vm;
>> +	int idx;
>> +
>> +	/* Tell stdout not to buffer its content */
>> +	setbuf(stdout, NULL);
>> +
>> +	if (!kvm_check_cap(KVM_CAP_SYNC_REGS))
>> +		ksft_exit_skip("CAP_SYNC_REGS not supported");
> 
> I'm not an expert on the TAP format, but wouldn't it be more meaningful
> to print the header first? (like you do in the previous patch)

It shouldn't matter much, without the header, TAP version 12 will be used:

  https://testanything.org/tap-specification.html

With header, it switches to version 13:

  https://testanything.org/tap-version-13-specification.html

But the "1..0" lines (which signal a complete skip) are part of both 
versions, so we should be fine here.

(but I can also move it in case I have to respin anyway)

  Thomas

