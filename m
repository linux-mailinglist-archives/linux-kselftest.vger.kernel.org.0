Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFB5338B52
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 12:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhCLLPp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 06:15:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36515 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233332AbhCLLPd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 06:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615547732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXSshFQeFLOgp+frZhl0j2pqci63p2uc+L6BvWuJgGc=;
        b=hDDtuFwYah/+0re7f5q2Mg20ylFw/vom8fS/r1aFgwaGKd7vv+usAwVckgVhbFGvQpiaAx
        HqWcdTg/zCXKBP+Dy1cQ4d/Jf/f+iFVu7yp+gY1FcAHVTgdTfd5AlZLzrzjV69+c+PKCme
        DcZA27BdRGzu3zng6jGDwJM/qqgE2zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-QvrsFBn2OPm5U9RfuB7OUg-1; Fri, 12 Mar 2021 06:15:30 -0500
X-MC-Unique: QvrsFBn2OPm5U9RfuB7OUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27152100C691;
        Fri, 12 Mar 2021 11:15:28 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 991C17A8CA;
        Fri, 12 Mar 2021 11:14:59 +0000 (UTC)
Date:   Fri, 12 Mar 2021 12:14:56 +0100
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
Subject: Re: [RFC PATCH v4 2/9] tools headers: Add a macro to get HUGETLB
 page sizes for mmap
Message-ID: <20210312111456.ukxss6uxu3frqmiu@kamzik.brq.redhat.com>
References: <20210302125751.19080-1-wangyanan55@huawei.com>
 <20210302125751.19080-3-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302125751.19080-3-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 02, 2021 at 08:57:44PM +0800, Yanan Wang wrote:
> We know that if a system supports multiple hugetlb page sizes,
> the desired hugetlb page size can be specified in bits [26:31]
> of the flag arguments. The value in these 6 bits will be the
> shift of each hugetlb page size.
> 
> So add a macro to get the page size shift and then calculate the
> corresponding hugetlb page size, using flag x.
> 
> Cc: Ben Gardon <bgardon@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Ben Gardon <bgardon@google.com>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  include/uapi/linux/mman.h       | 2 ++
>  tools/include/uapi/linux/mman.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> index f55bc680b5b0..8bd41128a0ee 100644
> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -41,4 +41,6 @@
>  #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>  
> +#define MAP_HUGE_PAGE_SIZE(x) (1 << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))

Needs to be '1ULL' to avoid shift overflow when given MAP_HUGE_16GB.

Thanks,
drew

> +
>  #endif /* _UAPI_LINUX_MMAN_H */
> diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
> index f55bc680b5b0..8bd41128a0ee 100644
> --- a/tools/include/uapi/linux/mman.h
> +++ b/tools/include/uapi/linux/mman.h
> @@ -41,4 +41,6 @@
>  #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>  
> +#define MAP_HUGE_PAGE_SIZE(x) (1 << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
> +
>  #endif /* _UAPI_LINUX_MMAN_H */
> -- 
> 2.23.0
> 

