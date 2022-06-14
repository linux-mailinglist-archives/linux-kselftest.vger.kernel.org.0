Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4082D54B30B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 16:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiFNOYo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 10:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343534AbiFNOYn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 10:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96A752AE00
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655216680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/W8jZgUnGZP6Qe9nuklShonDb+6U/u9I9QZozewk0A=;
        b=gfXM9rzGWyPv7NpVIPsGIvGoDzThINLzEKPqbmVrYYbQFnE/DtzrBv96jzbslfaingvewC
        TNW2J/58HZGG8hceTKdIPZwLfCvpeODmcTzyJWXxOPoE+JD47yh1oabQc6zkc9L5T3dCmw
        5n2gmZBf52xbggu1GN4I7DsxHpc95VI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-7FH5WVgTMOSBIVhH0poyKw-1; Tue, 14 Jun 2022 10:24:39 -0400
X-MC-Unique: 7FH5WVgTMOSBIVhH0poyKw-1
Received: by mail-wm1-f71.google.com with SMTP id h205-20020a1c21d6000000b0039c96ec500fso216325wmh.8
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jun 2022 07:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c/W8jZgUnGZP6Qe9nuklShonDb+6U/u9I9QZozewk0A=;
        b=AiucsYS7DDz9hEzFMwDTPXMsOkKcEx544GDyCsyVmFaMwJCyGDVpzP7Ymh5PHXqvQM
         EpHpIdj5AWv/W3snZhEHXfWLelBLSqLv8trIkpGptc9PATIaWX/ZQdEIuDxInj0FPFoU
         n47wQX5+y/dmizpTHtOh9C2QUQYmFhOklGocDmxq3T/jeoeO6vJ7IW1UuOZ2k6dnEg3L
         5cjiCCHfVBey7YEbdbh2y5lxQR+A5hlZ4ti55EJwfU8RBh5hx7ALTPrBj0lkcsotMXky
         h5xLLifeBI/uYPtaVQ+CCI7HGod2XJc8dqcMLNTwN6WpwWZv1TNgUb/UArEjr0lv+1ML
         9B0g==
X-Gm-Message-State: AJIora8Rv1kGeSbzTfR5xqKCdS+PNTrLQw2UzEg7HozJC/eJ/8S6SPh6
        9fyFwRaD2FIB956FDVEDO6Y6M8haCfvnOQDg5MM/pFDrG11jHkDg44LfXsIbPl9IYqSqlFGVQTk
        0bt9mcW8QHGyqMo6xu8DhPkwHpkXZ
X-Received: by 2002:adf:a55a:0:b0:219:e574:2ae9 with SMTP id j26-20020adfa55a000000b00219e5742ae9mr5364263wrb.158.1655216678286;
        Tue, 14 Jun 2022 07:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uCDAmT9GjGpaTwIkrS4ralu3DyoBR1ymKq0LMgiqhfqUcmwAISgLlJrM1+isW+D7YDEmGJOw==
X-Received: by 2002:adf:a55a:0:b0:219:e574:2ae9 with SMTP id j26-20020adfa55a000000b00219e5742ae9mr5364228wrb.158.1655216677887;
        Tue, 14 Jun 2022 07:24:37 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-42-114-75.web.vodafone.de. [109.42.114.75])
        by smtp.gmail.com with ESMTPSA id h206-20020a1c21d7000000b0039746638d6esm13583229wmh.33.2022.06.14.07.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 07:24:37 -0700 (PDT)
Message-ID: <36d83871-343d-e8a0-1aed-05bf386f9b1b@redhat.com>
Date:   Tue, 14 Jun 2022 16:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 1/4] KVM: s390: selftests: Use TAP interface in the
 memop test
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-s390@vger.kernel.org
References: <20220531101554.36844-1-thuth@redhat.com>
 <20220531101554.36844-2-thuth@redhat.com>
 <07576ae9-9798-316f-d33e-10c91faeebfb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <07576ae9-9798-316f-d33e-10c91faeebfb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/06/2022 12.38, Janis Schoetterl-Glausch wrote:
> On 5/31/22 12:15, Thomas Huth wrote:
>> The memop test currently does not have any output (unless one of the
>> TEST_ASSERT statement fails), so it's hard to say for a user whether
>> a certain new sub-test has been included in the binary or not. Let's
>> make this a little bit more user-friendly and include some TAP output
>> via the kselftests.h interface.
>>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tools/testing/selftests/kvm/s390x/memop.c | 95 ++++++++++++++++++-----
>>   1 file changed, 77 insertions(+), 18 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
>> index 49f26f544127..e704c6fa5758 100644
>> --- a/tools/testing/selftests/kvm/s390x/memop.c
>> +++ b/tools/testing/selftests/kvm/s390x/memop.c
>> @@ -14,6 +14,7 @@
>>   
> 
> [...]
> 
>>   int main(int argc, char *argv[])
>>   {
>> -	int memop_cap, extension_cap;
>> +	int memop_cap, extension_cap, idx;
>>   
>>   	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
>>   
>> +	ksft_print_header();
>> +
>>   	memop_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP);
>>   	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
>>   	if (!memop_cap) {
>> -		print_skip("CAP_S390_MEM_OP not supported");
>> -		exit(KSFT_SKIP);
>> +		ksft_exit_skip("CAP_S390_MEM_OP not supported.\n");
>>   	}
>>   
>> -	test_copy();
>> -	if (extension_cap > 0) {
>> -		test_copy_key();
>> -		test_copy_key_storage_prot_override();
>> -		test_copy_key_fetch_prot();
>> -		test_copy_key_fetch_prot_override();
>> -		test_errors_key();
>> -		test_termination();
>> -		test_errors_key_storage_prot_override();
>> -		test_errors_key_fetch_prot_override_not_enabled();
>> -		test_errors_key_fetch_prot_override_enabled();
>> -	} else {
>> -		print_skip("storage key memop extension not supported");
>> +	ksft_set_plan(ARRAY_SIZE(testlist));
>> +
>> +	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
>> +		if (testlist[idx].extension >= extension_cap) {
> 
> This is reversed, should be
> 
>     		if (testlist[idx].extension <= extension_cap) {
> or
> 		if (extension_cap >= testlist[idx].extension) {

Drat! The patch is already in Paolo's queue ... could you please send a 
patch to fix this, so that Paolo can either squash it (not sure whether 
that's still feasible) or queue it, too?

> I'd prefer the latter.

Me too.

  Thanks,
   Thomas

