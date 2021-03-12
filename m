Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15BA338B84
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 12:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhCLLcH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 06:32:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40095 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232054AbhCLLba (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 06:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615548689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnEUCW5aueL9lmi6RpcZkUrWB8ToCz0vwpvteqJSyZU=;
        b=atNu6jpLoNUgA8HiiIuIvqqFYfVnNwx+fhShoeWWTF3mBkha7zTwefDWkck/rScLq6eb5f
        RvYhDKxPZcC2mophEGR8fohGzn+RIkrd7n6z5t3sQPCWqd2RcVaRLqiFdK/z9Mg8GNH5QD
        DtlYcNJ9LQqjD6t+yzVWRR4BRMOTN/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-Lctk7kSHNpqHbHLGS4NcvQ-1; Fri, 12 Mar 2021 06:31:26 -0500
X-MC-Unique: Lctk7kSHNpqHbHLGS4NcvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEE92107ACCA;
        Fri, 12 Mar 2021 11:31:23 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9904219C71;
        Fri, 12 Mar 2021 11:31:15 +0000 (UTC)
Date:   Fri, 12 Mar 2021 12:31:12 +0100
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
Subject: Re: [RFC PATCH v4 5/9] KVM: selftests: Add a helper to get system
 configured THP page size
Message-ID: <20210312113112.laarzqhkslroagha@kamzik.brq.redhat.com>
References: <20210302125751.19080-1-wangyanan55@huawei.com>
 <20210302125751.19080-6-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302125751.19080-6-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 02, 2021 at 08:57:47PM +0800, Yanan Wang wrote:
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
>  tools/testing/selftests/kvm/lib/test_util.c   | 36 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index b7f41399f22c..ef24c76ba89a 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -78,6 +78,8 @@ struct vm_mem_backing_src_alias {
>  	enum vm_mem_backing_src_type type;
>  };
>  
> +bool thp_configured(void);
> +size_t get_trans_hugepagesz(void);
>  void backing_src_help(void);
>  enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
>  
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index c7c0627c6842..f2d133f76c67 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -10,6 +10,7 @@
>  #include <limits.h>
>  #include <stdlib.h>
>  #include <time.h>
> +#include <sys/stat.h>
>  #include "linux/kernel.h"
>  
>  #include "test_util.h"
> @@ -117,6 +118,41 @@ const struct vm_mem_backing_src_alias backing_src_aliases[] = {
>  	{"anonymous_hugetlb", VM_MEM_SRC_ANONYMOUS_HUGETLB,},
>  };
>  
> +bool thp_configured(void)
> +{
> +	int ret;
> +	struct stat statbuf;
> +
> +	ret = stat("/sys/kernel/mm/transparent_hugepage", &statbuf);
> +	TEST_ASSERT(ret == 0 || (ret == -1 && errno == ENOENT),
> +		    "Error in stating /sys/kernel/mm/transparent_hugepage: %d",
> +		    errno);

TEST_ASSERT will already output errno's string. Is that not sufficient? If
not, I think extending TEST_ASSERT to output errno too would be fine.

> +
> +	return ret == 0;
> +}
> +
> +size_t get_trans_hugepagesz(void)
> +{
> +	size_t size;
> +	char buf[16];
> +	FILE *f;
> +
> +	TEST_ASSERT(thp_configured(), "THP is not configured in host kernel");
> +
> +	f = fopen("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "r");
> +	TEST_ASSERT(f != NULL,
> +		    "Error in opening transparent_hugepage/hpage_pmd_size: %d",
> +		    errno);

Same comment as above.

> +
> +	if (fread(buf, sizeof(char), sizeof(buf), f) == 0) {
> +		fclose(f);
> +		TEST_FAIL("Unable to read transparent_hugepage/hpage_pmd_size");
> +	}
> +
> +	size = strtoull(buf, NULL, 10);

fscanf with %lld?

> +	return size;
> +}
> +
>  void backing_src_help(void)
>  {
>  	int i;
> -- 
> 2.23.0
> 

Thanks,
drew

