Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EBD7CC624
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbjJQOqy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbjJQOqw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 10:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45F6109
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697553967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi5scT6l+4iUlT8QRaVBn+dMSlBcJjBBl25IBLpxzAY=;
        b=JavJxcsc0Bie8r9fC48Z9IkP2wztH69n9RID4ezv+X0C+6pVO6ipZ3Un2JEtPv7tUgJtDF
        j+C4BXG4+31XdqIsTu1rakdo7qdCsuIke9q/b0WPiHWYDhlYgyaLBGeQsY7kFHOjON45zc
        nE6P3nPJusx1b19MMYDxNaMm3s7qfT4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-8xvXAvf_NOqj56jfoDmNyg-1; Tue, 17 Oct 2023 10:46:00 -0400
X-MC-Unique: 8xvXAvf_NOqj56jfoDmNyg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4196a386347so68205661cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 07:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697553960; x=1698158760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hi5scT6l+4iUlT8QRaVBn+dMSlBcJjBBl25IBLpxzAY=;
        b=l5aWIpviZ9trj98zcgzFo4MFh2iacp98dNpqJ78aGmjJmmcMcr0fo1qCkO6j1iENXW
         6af5RZgm2Wjm05Eg7rcjiGHQ4KAyti2VvM4f5Phe38dOF/QzMO91aRad1CRoEFhBa9xM
         y+uiAnq92gdJgJpqy48tIENeDInvJXOdhRfmzT5KrU22mOpY8MPe2eEc/9UJ/l9EbBd2
         8I9ZEYCXmT4UE6SxX9UFsanhyevZwUkrAOSux5fqX73CVUvx/4aOs1g5BQSBEIX/lhAR
         aPxGiSYUAIDFXPool2ebmc7htakLUVDtZoX8Zc2GPNus98ydGh7RZWPpXcWUio5wveXS
         gsoQ==
X-Gm-Message-State: AOJu0YyrOU8FLvcfoPO+twl6zflyAlkMcxpj5D+SpWWheqxR3xqYAQj+
        BEEM9UZOKYCc4QaGCfDSd9d+YfLDzctbiS0ULKJ4w8ML+O17SQDdFm1VEOtCoUqrT1TNgWgQpqc
        CuHteI4ApSikHAh1Z0FpAJh+/wxDFOzf3Mdo=
X-Received: by 2002:a05:620a:414b:b0:76f:6c6:f080 with SMTP id k11-20020a05620a414b00b0076f06c6f080mr2687491qko.37.1697553959808;
        Tue, 17 Oct 2023 07:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6g/qHKJaMsHPRx921s2dNJzV/sMqvCtVSXhSYzpTDkBNIQKDJV9bqrtNopRV4E/FA4MDpVA==
X-Received: by 2002:a05:620a:414b:b0:76f:6c6:f080 with SMTP id k11-20020a05620a414b00b0076f06c6f080mr2687466qko.37.1697553959481;
        Tue, 17 Oct 2023 07:45:59 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id du19-20020a05620a47d300b007757eddae8bsm708939qkb.62.2023.10.17.07.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 07:45:59 -0700 (PDT)
Message-ID: <e1bc93b2-3b68-4675-b1b3-391bc1e5e5d8@redhat.com>
Date:   Tue, 17 Oct 2023 16:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: run test suites only after module initialization
 completes
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20231016203548.21993-1-marpagan@redhat.com>
 <8f08ef23-bbe1-bebb-eee5-e202c98dbb44@huawei.com>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <8f08ef23-bbe1-bebb-eee5-e202c98dbb44@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2023-10-17 03:28, Jinjie Ruan wrote:
> 
> 
> On 2023/10/17 4:35, Marco Pagani wrote:
>> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
>> kunit_free_suite_set()") is causing all test suites to run (when
>> built as modules) while still in MODULE_STATE_COMING. In that state,
>> test modules are not fully initialized and lack sysfs kobjects.
>> This behavior can cause a crash if the test module tries to register
>> fake devices.
>>
>> This patch restores the normal execution flow, waiting for the module
>> initialization to complete before running the test suites.
>> The issue reported in the commit mentioned above is addressed using
>> virt_addr_valid() to detect if the module loading has failed
>> and mod->kunit_suites has not been allocated using kmalloc_array().
>>
>> Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  lib/kunit/test.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>> index 421f13981412..1a49569186fc 100644
>> --- a/lib/kunit/test.c
>> +++ b/lib/kunit/test.c
>> @@ -769,12 +769,14 @@ static void kunit_module_exit(struct module *mod)
>>  	};
>>  	const char *action = kunit_action();
>>  
>> +	if (!suite_set.start || !virt_addr_valid(suite_set.start))
>> +		return;
>> +
>>  	if (!action)
>>  		__kunit_test_suites_exit(mod->kunit_suites,
>>  					 mod->num_kunit_suites);
> 
> If the module state is from MODULE_STATE_LIVE to MODULE_STATE_GOING, in
> kunit_module_init() the kunit_exec_run_tests() is executed when action
> is NULL whether kunit_filter_suites() succeeds or not.

If kunit_filter_suites() fails in kunit_module_init(), suite_set is
initialized to {0, 0}. Hence, kunit_exec_run_tests() will not execute
the test suites since num_suites = suite_set->end - suite_set->start
equals 0.

> But in kunit_module_exit() __kunit_test_suites_exit() will not be executed when
> action is NULL if kunit_filter_suites() fails.

If kunit_filter_suites() has previously failed in kunit_module_init(),then
kunit_module_exit() will return before calling __kunit_test_suites_exit()
since suite_set.start has previously been set to 0.

>
>>  
>> -	if (suite_set.start)
>> -		kunit_free_suite_set(suite_set);
>> +	kunit_free_suite_set(suite_set);
>>  }
>>  
>>  static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
>> @@ -784,12 +786,12 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
>>  
>>  	switch (val) {
>>  	case MODULE_STATE_LIVE:
>> +		kunit_module_init(mod);
>>  		break;
>>  	case MODULE_STATE_GOING:
>>  		kunit_module_exit(mod);
>>  		break;
>>  	case MODULE_STATE_COMING:
>> -		kunit_module_init(mod);
>>  		break;
>>  	case MODULE_STATE_UNFORMED:
>>  		break;
> 

