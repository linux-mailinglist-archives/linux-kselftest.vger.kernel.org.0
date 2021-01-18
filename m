Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129E42FA895
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Jan 2021 19:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407088AbhARSUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jan 2021 13:20:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389885AbhARSUV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jan 2021 13:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610993932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9nzdbHs9DnXZuwfCrxQgg5xsyFMv8U3zDctTnTYZOsA=;
        b=S0JRkSkJnSuMAntQ1nbBfn3Hn76a97MSeTlWm+w1RSDAcUaZGUpWo8oRXFWQwvkLf8DPqp
        b1hC34NjPRXozzuUiYjc2D8ojar8TGqBfFV9DS+bWifM3C6MGSVZGcjPt7j7a2JL2ADTKC
        T5ylfeHcSO534mZVPjuWqOJUfHLCiWo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-EICjrHqZO8S-p2Lr01CdRA-1; Mon, 18 Jan 2021 13:18:48 -0500
X-MC-Unique: EICjrHqZO8S-p2Lr01CdRA-1
Received: by mail-wr1-f70.google.com with SMTP id l10so8309142wry.16
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 10:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9nzdbHs9DnXZuwfCrxQgg5xsyFMv8U3zDctTnTYZOsA=;
        b=KE/KteGHkkVK2Dv68YP4P13qZM39lycXSysNYJY9vG9kUuYfRyEQG7SOqxFsbHElo9
         ydATZVMRHR2E55j15uDmXk25g7LiuJ/9yLVoJ3i+jg7GS8Q2ITBfa6OnIh86G1PwF9ka
         h73TCqoU+eZXJ0KEE6HXMJZWVJzG1h1ni6wrquugdTfYSMLcAYFlrcC5tTt7kJNN35OS
         ZN6bx2zqjtjTab5x0BO4H4EO2RH53d0RoF+9WegggJOjym7jqbu/FKQ2b0B5bsizy1QJ
         oaPBMfZC9FIdkzr2WLO9iFG5hm3hc881C1reGOC/IlxQEiPMirya9wrZs6JvcAxf9GSf
         qA7Q==
X-Gm-Message-State: AOAM530bmHheHYT96QYS1EBsHLTXcolfs6K4J7CoZuYxUx6b+xKooQil
        24yKEJH37phCvxrI6FE73WDRmKQG0BYAl86Qh3quIoN1M+oZYQg+eAgk3W6ed0s+31RoGe6GhHm
        A3RtUHP8SmJPbSLQ43X6lk0JK/Sqb
X-Received: by 2002:adf:ca0c:: with SMTP id o12mr755555wrh.154.1610993927426;
        Mon, 18 Jan 2021 10:18:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1+2GeM/1qZYRcP6dljE5LJB1kHaItKj7JwS5ZOhG3A410YI5REfRSqIG8QmHU2Hq01eib7g==
X-Received: by 2002:adf:ca0c:: with SMTP id o12mr755525wrh.154.1610993927121;
        Mon, 18 Jan 2021 10:18:47 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b10sm245322wmj.5.2021.01.18.10.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 10:18:46 -0800 (PST)
Subject: Re: [PATCH 0/6] KVM: selftests: Perf test cleanups and memslot
 modification test
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>, Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>
References: <20210112214253.463999-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <583b1769-0f35-8f77-8570-2cc41612e4d4@redhat.com>
Date:   Mon, 18 Jan 2021 19:18:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112214253.463999-1-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/01/21 22:42, Ben Gardon wrote:
> This series contains a few cleanups that didn't make it into previous
> series, including some cosmetic changes and small bug fixes. The series
> also lays the groundwork for a memslot modification test which stresses
> the memslot update and page fault code paths in an attempt to expose races.
> 
> Tested: dirty_log_perf_test, memslot_modification_stress_test, and
> 	demand_paging_test were run, with all the patches in this series
> 	applied, on an Intel Skylake machine.
> 
> 	echo Y > /sys/module/kvm/parameters/tdp_mmu; \
> 	./memslot_modification_stress_test -i 1000 -v 64 -b 1G; \
> 	./memslot_modification_stress_test -i 1000 -v 64 -b 64M -o; \
> 	./dirty_log_perf_test -v 64 -b 1G; \
> 	./dirty_log_perf_test -v 64 -b 64M -o; \
> 	./demand_paging_test -v 64 -b 1G; \
> 	./demand_paging_test -v 64 -b 64M -o; \
> 	echo N > /sys/module/kvm/parameters/tdp_mmu; \
> 	./memslot_modification_stress_test -i 1000 -v 64 -b 1G; \
> 	./memslot_modification_stress_test -i 1000 -v 64 -b 64M -o; \
> 	./dirty_log_perf_test -v 64 -b 1G; \
> 	./dirty_log_perf_test -v 64 -b 64M -o; \
> 	./demand_paging_test -v 64 -b 1G; \
> 	./demand_paging_test -v 64 -b 64M -o
> 
> 	The tests behaved as expected, and fixed the problem of the
> 	population stage being skipped in dirty_log_perf_test. This can be
> 	seen in the output, with the population stage taking about the time
> 	dirty pass 1 took and dirty pass 1 falling closer to the times for
> 	the other passes.
> 
> Note that when running these tests, the -o option causes the test to take
> much longer as the work each vCPU must do increases proportional to the
> number of vCPUs.
> 
> You can view this series in Gerrit at:
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/7216
> 
> Ben Gardon (6):
>    KVM: selftests: Rename timespec_diff_now to timespec_elapsed
>    KVM: selftests: Avoid flooding debug log while populating memory
>    KVM: selftests: Convert iterations to int in dirty_log_perf_test
>    KVM: selftests: Fix population stage in dirty_log_perf_test
>    KVM: selftests: Add option to overlap vCPU memory access
>    KVM: selftests: Add memslot modification stress test
> 
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/demand_paging_test.c        |  40 +++-
>   .../selftests/kvm/dirty_log_perf_test.c       |  72 +++---
>   .../selftests/kvm/include/perf_test_util.h    |   4 +-
>   .../testing/selftests/kvm/include/test_util.h |   2 +-
>   .../selftests/kvm/lib/perf_test_util.c        |  25 ++-
>   tools/testing/selftests/kvm/lib/test_util.c   |   2 +-
>   .../kvm/memslot_modification_stress_test.c    | 211 ++++++++++++++++++
>   9 files changed, 307 insertions(+), 51 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/memslot_modification_stress_test.c
> 

Queued, thanks.

Paolo

