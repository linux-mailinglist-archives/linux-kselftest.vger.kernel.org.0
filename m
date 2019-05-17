Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF26E2165F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2019 11:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfEQJlP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 May 2019 05:41:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54196 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfEQJlO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 May 2019 05:41:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id 198so6267966wme.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2019 02:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KxRunkTcWCXBXkqMmtp06kfjOty1pFHCahqZCzEUiJM=;
        b=nMYoUfC565swY+uypRJ+cwCYNxz6hSLY7m5IVIa6rv9z8TqWur90PeMJ6GtzXMosmY
         G/+XaxuS5jALTJzOI9RzsNEvj8iK7MMOh1eTdqHWO+4aA/CpGe4PuR+J5T7ZiP/tB1LW
         dPheK74VQmNjgbk3/L+IL3tdwjH67bYS89TzHw8V/feI7AiVDkTRjrEdU6ANPUIg1wl3
         0tmnf/K8Sam0qoce1AqgHbrVPo50DWO16qz3Q04MH0W5o3jIHe95zQ7NnPahkSz2wtIu
         S3RsX7R1HQwYa+HuqCbR7Mz19o+rJ6DeU8drAe1bRo5ft/7obmTWfbjGzmMOdUD2DooB
         fXYg==
X-Gm-Message-State: APjAAAXKFldvf/P6tuF0lQJpUPGNCv9G5BahH1fkelQLeyxhMk/JzYE9
        NYJoDe3gbUK5z1fXlx2MeN2WUA==
X-Google-Smtp-Source: APXvYqynKo0ZK83iexNrTTI233jg0pcjdFXYNk3oowX/WJJeDSY4aa0A3Lf2hs9mlXOehdBNipV1xQ==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr29244537wmc.28.1558086072451;
        Fri, 17 May 2019 02:41:12 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 17sm10116301wrk.91.2019.05.17.02.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 02:41:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: selftests: Compile code with warnings enabled
In-Reply-To: <20190517093000.GO16681@xz-x1>
References: <20190517090445.4502-1-thuth@redhat.com> <20190517093000.GO16681@xz-x1>
Date:   Fri, 17 May 2019 11:41:11 +0200
Message-ID: <8736ldquyw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Fri, May 17, 2019 at 11:04:45AM +0200, Thomas Huth wrote:
>> So far the KVM selftests are compiled without any compiler warnings
>> enabled. That's quite bad, since we miss a lot of possible bugs this
>> way. Let's enable at least "-Wall" and some other useful warning flags
>> now, and fix at least the trivial problems in the code (like unused
>> variables).
>> 
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2:
>>  - Rebased to kvm/queue
>>  - Fix warnings in state_test.c and evmcs_test.c, too
>
> I still see these warnings (probably because the hyperv_cpuid.c is a
> new test):
>
> In file included from x86_64/hyperv_cpuid.c:18:
> x86_64/hyperv_cpuid.c: In function ‘test_hv_cpuid’:
> x86_64/hyperv_cpuid.c:61:33: warning: suggest parentheses around comparison in operand of ‘==’ [-Wparentheses]
>    TEST_ASSERT(entry->padding[0] == entry->padding[1]
>                ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> include/test_util.h:32:15: note: in definition of macro ‘TEST_ASSERT’
>   test_assert((e), #e, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
>                ^
> x86_64/hyperv_cpuid.c:62:8: warning: suggest parentheses around comparison in operand of ‘==’ [-Wparentheses]
>    TEST_ASSERT(entry->padding[0] == entry->padding[1]
>                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         == entry->padding[2] == 0,
>         ^~~~~~~~~~~~~~~~~~~~
> include/test_util.h:32:15: note: in definition of macro ‘TEST_ASSERT’
>   test_assert((e), #e, __FILE__, __LINE__, fmt, ##__VA_ARGS__)

There's a fix from Dan Carpenter on the list:
https://marc.info/?l=kernel-janitors&m=155783012012532&w=2

>                ^
> x86_64/hyperv_cpuid.c: In function ‘kvm_get_supported_hv_cpuid’:
> x86_64/hyperv_cpuid.c:93:6: warning: unused variable ‘ret’ [-Wunused-variable]
>   int ret;
>       ^~~
>
> The first two seem to be real bugs in the test code, and the 3rd one
> might need a cleanup too.

-- 
Vitaly
