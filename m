Return-Path: <linux-kselftest+bounces-2752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD1F828918
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 16:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2781F249E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AF039FEB;
	Tue,  9 Jan 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6CO+6Nd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4CB39ADE
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jan 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704814571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qz+Q+JrAWYvS9qf/dHeLoqYAlCn6rbjxNXke5nzk1EE=;
	b=T6CO+6NdYxX7qpVhAHUaGCQRm7OZNw2PFzJibXvFAHhj9qA0DNW7Gmv1EsluPUJDxScQGq
	lEdS2ssBFNsYRbi6L+f9KL8TWeAFfOTUe65U0qxQDZ0rh5491BwULVQuBR0wN59QAXdKXi
	cUEBZFFVqte0oM8Wf8Iuj2brFMLQF/M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-NO_d3IXBOFuVg0vMm5u-RQ-1; Tue, 09 Jan 2024 10:36:07 -0500
X-MC-Unique: NO_d3IXBOFuVg0vMm5u-RQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6800714a149so64642806d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jan 2024 07:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704814567; x=1705419367;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qz+Q+JrAWYvS9qf/dHeLoqYAlCn6rbjxNXke5nzk1EE=;
        b=UoBDXcU+Nhgo+cre+LEVphLHLhVMgM1YXEdwO+hY8BMivWI7kqyOTHOhzZZXN4brSQ
         r7qf2cKOxMM1ugyipXna5Ovvwj8tnB08ICJtFZLsqAolfhsTLuAw0KWHVl3ZIwjjeXj0
         mp6IbkrKnqKtThujua4OpmatTdrvgoZaLVZVVdxuMCA2DeiqTHQx37W9TJfVD4N9NyXK
         K6tr+u00yQGhNrDZlmOCHFaEv3pyPlk7ISE9EHPV9v0iUlAb90pRTpPi9S3MebpekiIO
         tJWLKsR8zaNps03mbf85PIlW4HjScgpvjej2p/C1G8D//g1oSPA2xJ/b/Xx6+IjxEn9e
         e7+w==
X-Gm-Message-State: AOJu0Yz0JmeF02fu8512R2812TPC5EaXPSONkVYyiaOS8S6vgUbEtkIa
	G37OBKG4cg2J3gDUi2iDav1u0qis9EsqDv+nvdBPOEAZ+kRJ4s84KAEqzPf2XVnqFE8D4mJugjR
	LQS0uEtLdn4FNpwJqCMDMOto4GRsj6tFHbDo=
X-Received: by 2002:a05:6214:2265:b0:681:1849:9c6f with SMTP id gs5-20020a056214226500b0068118499c6fmr1006020qvb.68.1704814567288;
        Tue, 09 Jan 2024 07:36:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjXC4DqpaaxgJdbTER0Ag1JXtCwg74ti2yIY188/Jz0ndLBxC4V6TDYJt8DOfddWMRDvRGVQ==
X-Received: by 2002:a05:6214:2265:b0:681:1849:9c6f with SMTP id gs5-20020a056214226500b0068118499c6fmr1006013qvb.68.1704814566990;
        Tue, 09 Jan 2024 07:36:06 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id r15-20020a0cf80f000000b00680d1d5a20dsm974838qvn.18.2024.01.09.07.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 07:36:06 -0800 (PST)
Message-ID: <6417e8d1-f768-404a-b21d-6aa897423278@redhat.com>
Date: Tue, 9 Jan 2024 16:36:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marco Pagani <marpagan@redhat.com>
Subject: Re: [PATCH v3] kunit: run test suites only after module
 initialization completes
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
 Shuah Khan <skhan@linuxfoundation.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Rae Moar <rmoar@google.com>, Richard Fitzgerald <rf@opensource.cirrus.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <20231206150729.54604-1-marpagan@redhat.com>
 <CABVgOSnbBzjcb_zt=YJ8p8Rm97s2ZYp=YvjThB_NCZD9BJQaSg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABVgOSnbBzjcb_zt=YJ8p8Rm97s2ZYp=YvjThB_NCZD9BJQaSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-08 08:27, David Gow wrote:
> On Wed, 6 Dec 2023 at 23:07, Marco Pagani <marpagan@redhat.com> wrote:
>>
>> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
>> kunit_free_suite_set()") fixed a wild-memory-access bug that could have
>> happened during the loading phase of test suites built and executed as
>> loadable modules. However, it also introduced a problematic side effect
>> that causes test suites modules to crash when they attempt to register
>> fake devices.
>>
>> When a module is loaded, it traverses the MODULE_STATE_UNFORMED and
>> MODULE_STATE_COMING states before reaching the normal operating state
>> MODULE_STATE_LIVE. Finally, when the module is removed, it moves to
>> MODULE_STATE_GOING before being released. However, if the loading
>> function load_module() fails between complete_formation() and
>> do_init_module(), the module goes directly from MODULE_STATE_COMING to
>> MODULE_STATE_GOING without passing through MODULE_STATE_LIVE.
>>
>> This behavior was causing kunit_module_exit() to be called without
>> having first executed kunit_module_init(). Since kunit_module_exit() is
>> responsible for freeing the memory allocated by kunit_module_init()
>> through kunit_filter_suites(), this behavior was resulting in a
>> wild-memory-access bug.
>>
>> Commit 2810c1e99867 ("kunit: Fix wild-memory-access bug in
>> kunit_free_suite_set()") fixed this issue by running the tests when the
>> module is still in MODULE_STATE_COMING. However, modules in that state
>> are not fully initialized, lacking sysfs kobjects. Therefore, if a test
>> module attempts to register a fake device, it will inevitably crash.
>>
>> This patch proposes a different approach to fix the original
>> wild-memory-access bug while restoring the normal module execution flow
>> by making kunit_module_exit() able to detect if kunit_module_init() has
>> previously initialized the tests suite set. In this way, test modules
>> can once again register fake devices without crashing.
>>
>> This behavior is achieved by checking whether mod->kunit_suites is a
>> virtual or direct mapping address. If it is a virtual address, then
>> kunit_module_init() has allocated the suite_set in kunit_filter_suites()
>> using kmalloc_array(). On the contrary, if mod->kunit_suites is still
>> pointing to the original address that was set when looking up the
>> .kunit_test_suites section of the module, then the loading phase has
>> failed and there's no memory to be freed.
>>
>> v3:
>> - add a comment to clarify why the start address is checked
>> v2:
>> - add include <linux/mm.h>
>>
>> Fixes: 2810c1e99867 ("kunit: Fix wild-memory-access bug in kunit_free_suite_set()")
>> Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
> 
> Sorry for the delay here: there are enough subtleties here that I
> wanted to double check some things.
> 
> I keep feeling that there has to be a nicer way of doing this, but I
> can't think of one, so let's go with this, since it's fixing a real
> issue.
> 
> I'm a little hesitant about our use of the suite_set.start address as
> an 'is initialised' flag, and depending on it being reallocated via
> kunit_filter_suites(), but since we already depend on that (by always
> using kunit_free_suite_set()), I'm okay with it.
>

I have the same feeling. I spent some thinking about alternative
solutions that did not require adding a flag in the module struct or
restructuring significant portions of the code, but I could not think of
anything better for the moment.

> My only request (other than this needing a rebase, probably on top of
> 6.8) would be to add a comment in kunit_filter_suites() noting that it
> must return a virtual address. That's probably something we should've
> done a while ago, but I can just see this requirement getting
> forgotten.
> 

Sure, I'll do it.

Thanks,
Marco

> Reviewed-by: David Gow <davidgow@google.com>
> 
> 
>>  lib/kunit/test.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>> index 7aceb07a1af9..3263e0d5e0f6 100644
>> --- a/lib/kunit/test.c
>> +++ b/lib/kunit/test.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/panic.h>
>>  #include <linux/sched/debug.h>
>>  #include <linux/sched.h>
>> +#include <linux/mm.h>
>>
>>  #include "debugfs.h"
>>  #include "hooks-impl.h"
>> @@ -775,12 +776,19 @@ static void kunit_module_exit(struct module *mod)
>>         };
>>         const char *action = kunit_action();
>>
>> +       /*
>> +        * Check if the start address is a valid virtual address to detect
>> +        * if the module load sequence has failed and the suite set has not
>> +        * been initialized and filtered.
>> +        */
>> +       if (!suite_set.start || !virt_addr_valid(suite_set.start))
>> +               return;
>> +
>>         if (!action)
>>                 __kunit_test_suites_exit(mod->kunit_suites,
>>                                          mod->num_kunit_suites);
>>
>> -       if (suite_set.start)
>> -               kunit_free_suite_set(suite_set);
>> +       kunit_free_suite_set(suite_set);
>>  }
>>
>>  static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
>> @@ -790,12 +798,12 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
>>
>>         switch (val) {
>>         case MODULE_STATE_LIVE:
>> +               kunit_module_init(mod);
>>                 break;
>>         case MODULE_STATE_GOING:
>>                 kunit_module_exit(mod);
>>                 break;
>>         case MODULE_STATE_COMING:
>> -               kunit_module_init(mod);
>>                 break;
>>         case MODULE_STATE_UNFORMED:
>>                 break;
>>
>> base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
>> --
>> 2.43.0
>>


