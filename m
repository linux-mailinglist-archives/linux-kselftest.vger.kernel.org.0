Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E37338BEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 12:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhCLLxM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 06:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231611AbhCLLws (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 06:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615549968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WTtzULOcDADt97XqLhkhLSSVvbCZDZRphO+4a+rZO/I=;
        b=hJg4JUWS9sAuHwWQKI1vMk7eM9yvg3uEi7EaPMmhpXLyXANbXQpn+BtUQpPQJHWHmaA/F5
        irCha5GPOesj6FE+TxSTdu2xf+ITNcRX7fSBfcJNil4BrZt4nUJB3xIiZBh9GJhRZlTkeq
        9bw1GoqCq60X20r5HXnw0RPActW81Mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-9juX39EFMvqmolD1dAZi9A-1; Fri, 12 Mar 2021 06:52:46 -0500
X-MC-Unique: 9juX39EFMvqmolD1dAZi9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6D4F10866A3;
        Fri, 12 Mar 2021 11:52:44 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AECA60657;
        Fri, 12 Mar 2021 11:52:36 +0000 (UTC)
Date:   Fri, 12 Mar 2021 12:52:28 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        wanghaibin.wang@huawei.com, yezengruan@huawei.com,
        yuzenghui@huawei.com
Subject: Re: [RFC PATCH v4 8/9] KVM: selftests: Adapt
 vm_userspace_mem_region_add to new helpers
Message-ID: <20210312115228.p5l26ukkn2xfwevz@kamzik.brq.redhat.com>
References: <20210302125751.19080-1-wangyanan55@huawei.com>
 <20210302125751.19080-9-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302125751.19080-9-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 02, 2021 at 08:57:50PM +0800, Yanan Wang wrote:
> With VM_MEM_SRC_ANONYMOUS_THP specified in vm_userspace_mem_region_add(),
> we have to get the transparent hugepage size for HVA alignment. With the
> new helpers, we can use get_backing_src_pagesz() to check whether THP is
> configured and then get the exact configured hugepage size.
> 
> As different architectures may have different THP page sizes configured,
> this can get the accurate THP page sizes on any platform.
> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 28 +++++++---------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

