Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7784039FDAF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhFHRcH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 13:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233219AbhFHRcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 13:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623173413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZADhY34QxbAWeVPZSSTJzfEf/Pqd0pAVw+/FdLcIyQU=;
        b=cs1PK9mqSKO7YVnSxXQuK25lRxcnE31QbXJMDRpxQ7Zv9uAVHY+q1OQF1cmNoeQQkFrvRX
        45WlcLPRZ6jDfHvLp4DVCGyQzkpcbXzBYc58nbMvT/MDM0zswKkNjODM+pvWx+yJKHN1gp
        QcAdOXl/Qnkb/TvxfmedcI67dQ8NgC4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-s7DCfv0nPLCeIA_VCyK6fg-1; Tue, 08 Jun 2021 13:30:12 -0400
X-MC-Unique: s7DCfv0nPLCeIA_VCyK6fg-1
Received: by mail-wr1-f71.google.com with SMTP id s8-20020adff8080000b0290114e1eeb8c6so9710470wrp.23
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jun 2021 10:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZADhY34QxbAWeVPZSSTJzfEf/Pqd0pAVw+/FdLcIyQU=;
        b=P5JjG1/bw/cm49eae+RJ7+TWDQY9akXC5CBYvm8k0j/ZrmFaH8bQgDfs6oa6MhZ1yh
         PP+nsYV3bq/WWMkT07zcw1jR8SAe7zfKH3+Ws6weBz6p0rKro8e7hX3pgKmTWl08fzkp
         wUBwr8KxhpI1hAnjV6U1bCCabIAAWnM+gj3GKHpBujkPLlRUoSpEhlFrrWKp2/cJuw7g
         QiIZozgm/wgql4I+ppgxGbRtVrUtPhoXCCCrr1YnNOjmrhxvfpm0OiOk7tUQkKcNS7Wk
         biYTQGNha0XXg8/lrn3RWqikKfEP69GV2T4xcxmNc5W8E91BsayYeUEdeK2EO/IeXiK8
         hxHA==
X-Gm-Message-State: AOAM530GRkfU54KjzlSi7VMnxm0OnvNM8wdf9zT902/z7txw46jW4scl
        bP3P3VXtqVDXmx2s+qnCUMDO6iT/bKQZlR6L+zZlruCAd6f8SmHKd/7hVJb7e4QlaAaIgn1DM4b
        sE2wlR4RG1OKBcoAMy8pWprqj07s8
X-Received: by 2002:a5d:5987:: with SMTP id n7mr23701560wri.293.1623173410944;
        Tue, 08 Jun 2021 10:30:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz40mbd8fjVHRDKS+HMzx5jGfFR8kWG56bZIuciz3ZdDkAg81UwMsWueng2sQtHOd4/13M5eQ==
X-Received: by 2002:a5d:5987:: with SMTP id n7mr23701539wri.293.1623173410780;
        Tue, 08 Jun 2021 10:30:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p5sm21535583wrd.25.2021.06.08.10.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 10:30:10 -0700 (PDT)
Subject: Re: [PATCH 0/3] Restore extra_mem_pages and add slot0_mem_pages
To:     Zhenzhong Duan <zhenzhong.duan@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        maciej.szmigiero@oracle.com, drjones@redhat.com, shuah@kernel.org
References: <20210608233816.423958-1-zhenzhong.duan@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <356f17eb-8357-9863-6655-d1a737e587fd@redhat.com>
Date:   Tue, 8 Jun 2021 19:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210608233816.423958-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09/06/21 01:38, Zhenzhong Duan wrote:
> (39fe2fc96694 "selftests: kvm: make allocation of extra memory take effect")
> changed the meaning of extra_mem_pages and treated it as slot0 memory size.
> 
> In fact extra_mem_pages is used for non-slot0 memory size, there is no custom
> slot0 memory size support. See discuss in https://lkml.org/lkml/2021/6/3/551
> for more details.
> 
> This patchset restores extra_mem_pages's original meaning and adds support for
> custom slot0 memory with a new parameter slot0_mem_pages.

Because the two reverts are so small, I squashed everything in a single 
patch with the following message:

     Until commit 39fe2fc96694 ("selftests: kvm: make allocation of extra
     memory take effect", 2021-05-27), parameter extra_mem_pages was used
     only to calculate the page table size for all the memory chunks,
     because real memory allocation happened with calls of
     vm_userspace_mem_region_add() after vm_create_default().

     Commit 39fe2fc96694 however changed the meaning of extra_mem_pages to
     the size of memory slot 0.  This makes the memory allocation more
     flexible, but makes it harder to account for the number of
     pages needed for the page tables.  For example, memslot_perf_test
     has a small amount of memory in slot 0 but a lot in other slots,
     and adding that memory twice (both in slot 0 and with later
     calls to vm_userspace_mem_region_add()) causes an error that
     was fixed in commit 000ac4295339 ("selftests: kvm: fix overlapping
     addresses in memslot_perf_test", 2021-05-29)

     Since both uses are sensible, add a new parameter slot0_mem_pages
     to vm_create_with_vcpus() and some comments to clarify the meaning of
     slot0_mem_pages and extra_mem_pages.  With this change,
     memslot_perf_test can go back to passing the number of memory
     pages as extra_mem_pages.

Paolo

> Run below command, all 39 tests passed.
> # make -C tools/testing/selftests/ TARGETS=kvm run_tests
> 
> Zhenzhong Duan (3):
>    Revert "selftests: kvm: make allocation of extra memory take effect"
>    Revert "selftests: kvm: fix overlapping addresses in
>      memslot_perf_test"
>    selftests: kvm: Add support for customized slot0 memory size
> 
>   .../testing/selftests/kvm/include/kvm_util.h  |  7 +--
>   .../selftests/kvm/kvm_page_table_test.c       |  2 +-
>   tools/testing/selftests/kvm/lib/kvm_util.c    | 47 +++++++++++++++----
>   .../selftests/kvm/lib/perf_test_util.c        |  2 +-
>   .../testing/selftests/kvm/memslot_perf_test.c |  2 +-
>   5 files changed, 45 insertions(+), 15 deletions(-)
> 

