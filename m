Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA76341715
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 09:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhCSIHj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 04:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234181AbhCSIHR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 04:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616141237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Skqo6f9yW8lK62SqKGHOk+G8drCEfkExBud4qudsccw=;
        b=Py3IaICHV1IBCvgJr1SRNqCNhSYy+/mgWsR3pIAT4BjkRTlpadJ2THVoW9fvM9LvS5AzKX
        rgB8SYzSfG6wsf+P1cmcILpeWkMhAvA1RvSR+yCSzIUS6WTpEnfpSeC/WoSLqnmB/hza9g
        R9tVQVega2nkIdZhIs5MgJAvEjYBJZ0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-fqDQkIoMMxKpF6akHH304Q-1; Fri, 19 Mar 2021 04:07:15 -0400
X-MC-Unique: fqDQkIoMMxKpF6akHH304Q-1
Received: by mail-ej1-f70.google.com with SMTP id si4so17997668ejb.23
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 01:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Skqo6f9yW8lK62SqKGHOk+G8drCEfkExBud4qudsccw=;
        b=AHr/in3qWUzfgLtJghfM9qcK9m02t8yotap4aSpWhD+mMLHhdZnLQ2KH3AnGAZzZcL
         VbKs2721cp7IMEBAmtypYagcL/Zmg7O8p5+wppBuV20g86jnKhph5i9PCPg5q4ltJ1Rk
         clk9BI+SSembGiJqfUr29TukihPa3XTJFKCvav5mJ1sQnzRrdAbYKcwuTUOvYx2jNJ4B
         hfWgY6EfNl7cB1J+l+BDbyeTzFCheMiNP6qFJVSyOowGASfs4k7JzSYfnHOeVBAUjQ4e
         KDqo4CxNn44qSMB+6OGfoUwMD1Ez9armTuD1RnyHf3otCThHlPMFCiRRE3QqWdf/b9a6
         tlvQ==
X-Gm-Message-State: AOAM533wH1QYKue9vV0FYePOOffBg2vpDT4Q60TeAcxcTyD1SsYmS0aE
        bO3kovyBTRubSn8z7kLQ3vD/Yx12SfsSlzOXP85CgnuA4T4wNZmBiKxk1BKC4w1XwfRbIkPY/N+
        LwRK5edfDkx61aK4K47aXW5DhS+pa
X-Received: by 2002:a17:906:4955:: with SMTP id f21mr3064172ejt.74.1616141234395;
        Fri, 19 Mar 2021 01:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkhvLmdglHhe4zfW02VmKkQ4vHdspPb/cEApNgMloEmZsu3PphEPl8SexenPqbp0wXWjtuqQ==
X-Received: by 2002:a17:906:4955:: with SMTP id f21mr3064155ejt.74.1616141234243;
        Fri, 19 Mar 2021 01:07:14 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.135])
        by smtp.gmail.com with ESMTPSA id r17sm3311246ejz.109.2021.03.19.01.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 01:07:13 -0700 (PDT)
Subject: Re: [PATCH] selftests/kvm: add get_msr_index_features
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210318145629.486450-1-eesposit@redhat.com>
 <20210318170316.6vah7x2ws4bimmdf@kamzik.brq.redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <52d09cdf-3819-0cd8-5812-387febaa1ab3@redhat.com>
Date:   Fri, 19 Mar 2021 09:07:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318170316.6vah7x2ws4bimmdf@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Andrew,

Thank you for the feedback (also in v1).

On 18/03/2021 18:03, Andrew Jones wrote:
> On Thu, Mar 18, 2021 at 03:56:29PM +0100, Emanuele Giuseppe Esposito wrote:
>> Test the KVM_GET_MSR_FEATURE_INDEX_LIST
>> and KVM_GET_MSR_INDEX_LIST ioctls.
>>
>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>> ---
>>   tools/testing/selftests/kvm/.gitignore        |   1 +
>>   tools/testing/selftests/kvm/Makefile          |   1 +
>>   .../kvm/x86_64/get_msr_index_features.c       | 124 ++++++++++++++++++
>>   3 files changed, 126 insertions(+)
>>   create mode 100644 tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
>>
>> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
>> index 32b87cc77c8e..d99f3969d371 100644
>> --- a/tools/testing/selftests/kvm/.gitignore
>> +++ b/tools/testing/selftests/kvm/.gitignore
>> @@ -5,6 +5,7 @@
>>   /s390x/resets
>>   /s390x/sync_regs_test
>>   /x86_64/cr4_cpuid_sync_test
>> +/x86_64/get_msr_index_features
>>   /x86_64/debug_regs
>>   /x86_64/evmcs_test
>>   /x86_64/get_cpuid_test
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index a6d61f451f88..c748b9650e28 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -39,6 +39,7 @@ LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
>>   LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
>>   
>>   TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
>> +TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
> 
> Maybe we should give up trying to keep an alphabetic order.

My bad, I did not notice that it was in alphabetic order.

> 
>>   TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
>>   TEST_GEN_PROGS_x86_64 += x86_64/get_cpuid_test
>>   TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
>> diff --git a/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c b/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
>> new file mode 100644
>> index 000000000000..ad9972d99dfa
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/get_msr_index_features.c
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Test that KVM_GET_MSR_INDEX_LIST and
>> + * KVM_GET_MSR_FEATURE_INDEX_LIST work as intended
>> + *
>> + * Copyright (C) 2020, Red Hat, Inc.
>> + */
>> +#include <fcntl.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <sys/ioctl.h>
>> +
>> +#include "test_util.h"
>> +#include "kvm_util.h"
>> +#include "processor.h"
>> +#include "../lib/kvm_util_internal.h"
> 
> I'm not sure why the original kvm selftests authors decided to do this
> internal stuff, but we should either kill that or avoid doing stuff like
> this.

I need this include because of the KVM_DEV_PATH macro, to get the kvm_fd.
No other reason for including it in this test.
>> +
>> +static int kvm_num_feature_msrs(int kvm_fd, int nmsrs)
>> +{
>> +	struct kvm_msr_list *list;
>> +	int r;
>> +
>> +	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
>> +	list->nmsrs = nmsrs;
>> +	r = ioctl(kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, list);
>> +	TEST_ASSERT(r == -1 && errno == E2BIG,
>> +		"Unexpected result from KVM_GET_MSR_FEATURE_INDEX_LIST probe, r: %i",
>> +				r);
> 
> Weird indentation. I'd just leave it up on the last line. We don't care
> about long lines.

Ok. I wanted avoid warnings from the checkpatch script.

Paolo, do you want me to send v2 with fixed indentation or you already 
took care of it? I'll be happy to do so.

Emanuele

