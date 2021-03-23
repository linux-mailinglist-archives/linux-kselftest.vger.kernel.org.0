Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E68A34610A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 15:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhCWOIs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 10:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbhCWOIQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 10:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616508495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UX1wWuXrQQyIUDqW54U/sMyEQTlMEB2HoQOh/hCP6fM=;
        b=M6LGkkMni8QkS+j2v7vzpbsmv4Y8EOTZzjwobtBrcarrfO4UTopgodVogPyHof2rAElrEt
        e/0yOHLxLB1ACnhypc/G33xSPfW+c61ZRDQMEZd3bnpvXqNbfnfPz1jzCJF7AqFIr7dQOc
        X4j0l4jSFTCrGDhCR1WLFQLSHGgxw+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-W6YLLq2qMNGvDS32cfJI2A-1; Tue, 23 Mar 2021 10:08:13 -0400
X-MC-Unique: W6YLLq2qMNGvDS32cfJI2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B7B98189CB;
        Tue, 23 Mar 2021 14:08:12 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ACAB694CC;
        Tue, 23 Mar 2021 14:07:45 +0000 (UTC)
Date:   Tue, 23 Mar 2021 15:07:42 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com
Subject: Re: [RFC PATCH v5 06/10] KVM: selftests: Add a helper to get system
 configured THP page size
Message-ID: <20210323140742.5nubgjbwvqe7c52f@kamzik.brq.redhat.com>
References: <20210323135231.24948-1-wangyanan55@huawei.com>
 <20210323135231.24948-7-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323135231.24948-7-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 23, 2021 at 09:52:27PM +0800, Yanan Wang wrote:
> If we want to have some tests about transparent hugepages, the system
> configured THP hugepage size should better be known by the tests, which
> can be used for kinds of alignment or guest memory accessing of vcpus...
> So it makes sense to add a helper to get the transparent hugepage size.
> 
> With VM_MEM_SRC_ANONYMOUS_THP specified in vm_userspace_mem_region_add(),
> we now stat /sys/kernel/mm/transparent_hugepage to check whether THP is
> configured in the host kernel before madvise(). Based on this, we can also
> read file /sys/kernel/mm/transparent_hugepage/hpage_pmd_size to get THP
> hugepage size.
> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  .../testing/selftests/kvm/include/test_util.h |  2 ++
>  tools/testing/selftests/kvm/lib/test_util.c   | 29 +++++++++++++++++++
>  2 files changed, 31 insertions(+)


Reviewed-by: Andrew Jones <drjones@redhat.com>

