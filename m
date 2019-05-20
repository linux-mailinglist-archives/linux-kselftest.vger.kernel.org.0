Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D205D230E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2019 12:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbfETKDM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 May 2019 06:03:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39922 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbfETKDM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 May 2019 06:03:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so11961874wmk.4
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2019 03:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ntBh3gwN9WoX40GwCBpFxX6GBpRNGTL9y6TfLLH0P8Y=;
        b=LpK8Ojh88rwr5++GK00c+41/HuxMFiHfn8ldtGKyCCzVn/ac7yj3FRM5JgVbgydg53
         P2g9ffWLqFMskuOQPDarY2Bq2Hfi7z+FZ64Mjk0RjqMZYCzWFK3ZM714G3GXuMzUGS3X
         8QIPC9iB+rfmZtm36UyiRPIiHLNr43wbGZSmEYNTBHFciGHjR0ePH7WbmpO9oHjQ1oOa
         +WyDojdWDvlRSPoVUeoWJqSFszoqKcJJBMVCp9WnBl2hwB9/ITy6cXpwG6S8rnItFg5v
         o7FZNRTMj3NFZ7Htb1CAITXc4kCjzwh82fwpXDnubPOMXXbDQeLPfTzT9I61RG2tqFsI
         1/yw==
X-Gm-Message-State: APjAAAXSSfSvIjUB4eQwNujGJZOl0+7sZu/zeYozcj9x2pUmoYmxppwZ
        1rqfic7cQEaBXhEhceAu77wSwA==
X-Google-Smtp-Source: APXvYqwCViWNb1nszawZx5mGOC1uWv3OZtGu2OV4T05uHlrHYWk1+jCA3rZNhigRAkrAXmHcizwTeA==
X-Received: by 2002:a1c:cb0e:: with SMTP id b14mr26501343wmg.61.1558346590407;
        Mon, 20 May 2019 03:03:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id g13sm15296462wrw.63.2019.05.20.03.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 03:03:09 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: selftests: Compile code with warnings enabled
To:     Thomas Huth <thuth@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20190517090445.4502-1-thuth@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f998da41-c75d-0afa-02cd-e2e5d8f0f546@redhat.com>
Date:   Mon, 20 May 2019 12:03:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517090445.4502-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/05/19 11:04, Thomas Huth wrote:
> So far the KVM selftests are compiled without any compiler warnings
> enabled. That's quite bad, since we miss a lot of possible bugs this
> way. Let's enable at least "-Wall" and some other useful warning flags
> now, and fix at least the trivial problems in the code (like unused
> variables).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Rebased to kvm/queue
>  - Fix warnings in state_test.c and evmcs_test.c, too
> 
>  tools/testing/selftests/kvm/Makefile                       | 4 +++-
>  tools/testing/selftests/kvm/dirty_log_test.c               | 6 +++++-
>  tools/testing/selftests/kvm/lib/kvm_util.c                 | 3 ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c         | 4 +---
>  tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c   | 1 +
>  tools/testing/selftests/kvm/x86_64/evmcs_test.c            | 7 +------
>  tools/testing/selftests/kvm/x86_64/platform_info_test.c    | 1 -
>  tools/testing/selftests/kvm/x86_64/smm_test.c              | 3 +--
>  tools/testing/selftests/kvm/x86_64/state_test.c            | 7 +------
>  .../selftests/kvm/x86_64/vmx_close_while_nested_test.c     | 5 +----
>  tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c   | 5 ++---
>  11 files changed, 16 insertions(+), 30 deletions(-)

Queued, with a squashed fix to kvm_get_supported_hv_cpuid.

Paolo
