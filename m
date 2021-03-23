Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B467234611A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 15:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhCWOMc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 10:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230500AbhCWOM0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 10:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616508746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/9sarbVkCs8Zh6rYFgdnW5tjm74WgRKnUWy7R0BGsw=;
        b=RQq20wd00b5ECQhHe2BL/0cEU4LzbIm4Yz37Znvtp5+8b9D1tewpA+sNeCwwznEN6TeMv3
        ds1VgLnb0dtRaIiEKQFOXqjXpO8IVquvP7UGHHLig2yv6zRu9S5cdOldG4uPm2uMYIxnjj
        PpxTsns8CH9cf4hlVUEqM5ZB/k/+Coc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-fKx9bUDpMI6CjKxP0ohcNQ-1; Tue, 23 Mar 2021 10:12:23 -0400
X-MC-Unique: fKx9bUDpMI6CjKxP0ohcNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83CF787A82A;
        Tue, 23 Mar 2021 14:12:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DE075C1C5;
        Tue, 23 Mar 2021 14:12:11 +0000 (UTC)
Date:   Tue, 23 Mar 2021 15:12:08 +0100
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
Subject: Re: [RFC PATCH v5 08/10] KVM: selftests: List all hugetlb src types
 specified with page sizes
Message-ID: <20210323141208.3mmnznn4glzd3inz@kamzik.brq.redhat.com>
References: <20210323135231.24948-1-wangyanan55@huawei.com>
 <20210323135231.24948-9-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323135231.24948-9-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 23, 2021 at 09:52:29PM +0800, Yanan Wang wrote:
> With VM_MEM_SRC_ANONYMOUS_HUGETLB, we currently can only use system
> default hugetlb pages to back the testing guest memory. In order to
> add flexibility, now list all the known hugetlb backing src types with
> different page sizes, so that we can specify use of hugetlb pages of the
> exact granularity that we want. And as all the known hugetlb page sizes
> are listed, it's appropriate for all architectures.
> 
> Besides, the helper get_backing_src_pagesz() is added to get the
> granularity of different backing src types(anonumous, thp, hugetlb).
> 
> Suggested-by: Ben Gardon <bgardon@google.com>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  .../testing/selftests/kvm/include/test_util.h |  18 ++-
>  tools/testing/selftests/kvm/lib/kvm_util.c    |   2 +-
>  tools/testing/selftests/kvm/lib/test_util.c   | 109 ++++++++++++++++--
>  3 files changed, 116 insertions(+), 13 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

