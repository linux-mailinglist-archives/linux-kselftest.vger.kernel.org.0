Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1563460EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhCWOEm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 10:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231876AbhCWOEY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 10:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616508262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vxsGWWqSMrKfNxVOuIK22nNbCbQd+8H7DiNIZtQneS8=;
        b=UwUGSazaUXaBJlzDMIJsdBDkfjEaCV8VIOAuH4ccHE4GSPsDIszTsAyA2yaxZfwPr3TA3T
        7QWDSJZz1YJYzpG5yZc86DzDkn3OFsMz6iIUx2DzF62HIIxwsMbcKDdSIDw2D2bCEe/HSt
        dMZaeHBsXRJWLACXdpSSBp5awGhOJc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-eSjqDlG7Nwy-6LahJk0MOg-1; Tue, 23 Mar 2021 10:04:21 -0400
X-MC-Unique: eSjqDlG7Nwy-6LahJk0MOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A66B388AF0E;
        Tue, 23 Mar 2021 14:03:55 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13F8C5D6D7;
        Tue, 23 Mar 2021 14:03:44 +0000 (UTC)
Date:   Tue, 23 Mar 2021 15:03:41 +0100
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
Subject: Re: [RFC PATCH v5 02/10] tools headers: Add a macro to get HUGETLB
 page sizes for mmap
Message-ID: <20210323140341.nkikwolwzpu6ectp@kamzik.brq.redhat.com>
References: <20210323135231.24948-1-wangyanan55@huawei.com>
 <20210323135231.24948-3-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323135231.24948-3-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


$SUBJECT says "tools headers", but this is actually changing
a UAPI header and then copying the change to tools.

Thanks,
drew

On Tue, Mar 23, 2021 at 09:52:23PM +0800, Yanan Wang wrote:
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
> index f55bc680b5b0..d72df73b182d 100644
> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -41,4 +41,6 @@
>  #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>  
> +#define MAP_HUGE_PAGE_SIZE(x) (1ULL << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
> +
>  #endif /* _UAPI_LINUX_MMAN_H */
> diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
> index f55bc680b5b0..d72df73b182d 100644
> --- a/tools/include/uapi/linux/mman.h
> +++ b/tools/include/uapi/linux/mman.h
> @@ -41,4 +41,6 @@
>  #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>  
> +#define MAP_HUGE_PAGE_SIZE(x) (1ULL << ((x >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK))
> +
>  #endif /* _UAPI_LINUX_MMAN_H */
> -- 
> 2.19.1
> 

