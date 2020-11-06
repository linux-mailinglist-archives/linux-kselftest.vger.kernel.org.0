Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11262A9669
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Nov 2020 13:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgKFMsi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 07:48:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbgKFMsi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 07:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604666916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fao4KMOqn+uulqi3mzvMkaD+mwMVE/JWlzH/5NImJR4=;
        b=dSVUIQzbkjUDqSl7w2c+dSZS+Qqi5H5YzaK//tgRcc55151GQ0v/jA4ZXXF4gMCsGjxa6U
        4YAI/IVSmtuXbBBMCRWN+GnMzWveKRtMHyO4XLqT/c10V7MBrtoS1yiH3SBwidYpM3mBex
        Nb9sBlLJDOvEBdaGNQxrTxLRVCZ+bRA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-fTWS-AtBNoiRPwVu1LnqqA-1; Fri, 06 Nov 2020 07:48:32 -0500
X-MC-Unique: fTWS-AtBNoiRPwVu1LnqqA-1
Received: by mail-ed1-f72.google.com with SMTP id b16so481269edn.6
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Nov 2020 04:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fao4KMOqn+uulqi3mzvMkaD+mwMVE/JWlzH/5NImJR4=;
        b=RO6NtkqHpnNIkXPwZQytuj+QVBYbnPuUQfxbALhlzAO5KVffmHUzddAWi3p+HDjdln
         oD0bKgtwLsxmHn68Qwyp05+MfWU46CQByJ8pWgSWH6UFAJ7EbGgYuuXvDoy1D9G/Zzzd
         hp1Tm81vCI6N31sFEFlZmRfSIYjpWZGdwz9hmi26/5hKbjt150pChzvB4EQ3GUHqdBv3
         C8k6KE8XToEEgMNIvR0qOORtBRGuE2RUFijzRBoT4QBOmtWJbHDntXvymuwvMam1RSWt
         4RfeCoQvTs7DEHgtBpaE0vigt7+7JsBlfAuTn+ksuXbrfa8N+jEGYS2KTuXHK5exTmSH
         cAYA==
X-Gm-Message-State: AOAM531NRlFVbv9glubYqgjN7FS9dvrbGgYE2dGd7YHNjmobzpX7wFYL
        Xi5JupdF5ctm0OStsnroLlgKOxW0B1hwDjGJmtNClBoiV4tFitsZ+5feocTzkjlX/QnBzo1hKiw
        Z1bZuWQz85+VcnLqzvb5saIFQKWw5
X-Received: by 2002:aa7:ce8c:: with SMTP id y12mr1876620edv.185.1604666911725;
        Fri, 06 Nov 2020 04:48:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+qrHIsz6EZ4+6NT1qdcVqkWBc6OhibP9Z6DHzMgDc3REn9xKnp2X+uiU+FAEGBS+tsUJsow==
X-Received: by 2002:aa7:ce8c:: with SMTP id y12mr1876610edv.185.1604666911555;
        Fri, 06 Nov 2020 04:48:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id h23sm1002481edv.69.2020.11.06.04.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 04:48:30 -0800 (PST)
Subject: Re: [PATCH 0/5] Add a dirty logging performance test
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
References: <20201027233733.1484855-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9885dac0-ca34-c680-ee44-e1a33e56aa4e@redhat.com>
Date:   Fri, 6 Nov 2020 13:48:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027233733.1484855-1-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 28/10/20 00:37, Ben Gardon wrote:
> Currently KVM lacks a simple, userspace agnostic, performance benchmark for
> dirty logging. Such a benchmark will be beneficial for ensuring that dirty
> logging performance does not regress, and to give a common baseline for
> validating performance improvements. The dirty log perf test introduced in
> this series builds on aspects of the existing demand paging perf test and
> provides time-based performance metrics for enabling and disabling dirty
> logging, getting the dirty log, and dirtying memory.
> 
> While the test currently only has a build target for x86, I expect it will
> work on, or be easily modified to support other architectures.
> 
> Ben Gardon (5):
>    KVM: selftests: Factor code out of demand_paging_test
>    KVM: selftests: Remove address rounding in guest code
>    KVM: selftests: Simplify demand_paging_test with timespec_diff_now
>    KVM: selftests: Add wrfract to common guest code
>    KVM: selftests: Introduce the dirty log perf test
> 
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/demand_paging_test.c        | 230 ++---------
>   .../selftests/kvm/dirty_log_perf_test.c       | 382 ++++++++++++++++++
>   .../selftests/kvm/include/perf_test_util.h    | 192 +++++++++
>   .../testing/selftests/kvm/include/test_util.h |   2 +
>   tools/testing/selftests/kvm/lib/test_util.c   |  22 +-
>   7 files changed, 635 insertions(+), 195 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/dirty_log_perf_test.c
>   create mode 100644 tools/testing/selftests/kvm/include/perf_test_util.h
> 

Queued, thanks.

Paolo

