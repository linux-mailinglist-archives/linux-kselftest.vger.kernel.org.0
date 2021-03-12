Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD198338BD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 12:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhCLLuA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 06:50:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231734AbhCLLtx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 06:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615549793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVVdjyBIJ09TLfhuhHdRm1wrvlytMeufmR/jytc+Ass=;
        b=TEtpXyyOpR+PMEPPh530hlxS2peg/obRrnfZF46hEUVtfR0bw8oouBwiDvkRkHwpqqqNtX
        3jcSbCK9OmG8HqJy6QN5NoACsiB66DbRjajS1od3+DT82HPjCSHTkU4pxp4FH0P+EDjH9J
        +Xeg4kYOe/LTIesgW6j/iQC0UzjPdKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-4PoxsIvZPqaS-gXziSY6_A-1; Fri, 12 Mar 2021 06:49:51 -0500
X-MC-Unique: 4PoxsIvZPqaS-gXziSY6_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24B3F808259;
        Fri, 12 Mar 2021 11:49:49 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81AD05DDAD;
        Fri, 12 Mar 2021 11:49:41 +0000 (UTC)
Date:   Fri, 12 Mar 2021 12:49:38 +0100
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
Subject: Re: [RFC PATCH v4 7/9] KVM: selftests: List all hugetlb src types
 specified with page sizes
Message-ID: <20210312114938.zfwnux3kwz44fd2i@kamzik.brq.redhat.com>
References: <20210302125751.19080-1-wangyanan55@huawei.com>
 <20210302125751.19080-8-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302125751.19080-8-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 02, 2021 at 08:57:49PM +0800, Yanan Wang wrote:
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
>  .../testing/selftests/kvm/include/test_util.h | 18 +++++-
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  2 +-
>  tools/testing/selftests/kvm/lib/test_util.c   | 59 +++++++++++++++----
>  3 files changed, 66 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index e087174eefe5..fade3130eb01 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -71,16 +71,32 @@ enum vm_mem_backing_src_type {
>  	VM_MEM_SRC_ANONYMOUS,
>  	VM_MEM_SRC_ANONYMOUS_THP,
>  	VM_MEM_SRC_ANONYMOUS_HUGETLB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_16KB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_64KB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_512KB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_1MB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_8MB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_16MB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_32MB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_256MB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_512MB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB,
> +	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
> +	NUM_SRC_TYPES,
>  };
>  
>  struct vm_mem_backing_src_alias {
>  	const char *name;
> -	enum vm_mem_backing_src_type type;
> +	uint32_t flag;
>  };
>  
>  bool thp_configured(void);
>  size_t get_trans_hugepagesz(void);
>  size_t get_def_hugetlb_pagesz(void);
> +const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
> +size_t get_backing_src_pagesz(uint32_t i);
>  void backing_src_help(void);
>  enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
>  
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index cc22c4ab7d67..b91c8e3a7ee1 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -757,7 +757,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>  	region->mmap_start = mmap(NULL, region->mmap_size,
>  				  PROT_READ | PROT_WRITE,
>  				  MAP_PRIVATE | MAP_ANONYMOUS
> -				  | (src_type == VM_MEM_SRC_ANONYMOUS_HUGETLB ? MAP_HUGETLB : 0),
> +				  | vm_mem_backing_src_alias(src_type)->flag,
>  				  -1, 0);
>  	TEST_ASSERT(region->mmap_start != MAP_FAILED,
>  		    "test_malloc failed, mmap_start: %p errno: %i",
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index 80d68dbd72d2..df8a42eff1f8 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -11,6 +11,7 @@
>  #include <stdlib.h>
>  #include <time.h>
>  #include <sys/stat.h>
> +#include <linux/mman.h>
>  #include "linux/kernel.h"
>  
>  #include "test_util.h"
> @@ -112,12 +113,6 @@ void print_skip(const char *fmt, ...)
>  	puts(", skipping test");
>  }
>  
> -const struct vm_mem_backing_src_alias backing_src_aliases[] = {
> -	{"anonymous", VM_MEM_SRC_ANONYMOUS,},
> -	{"anonymous_thp", VM_MEM_SRC_ANONYMOUS_THP,},
> -	{"anonymous_hugetlb", VM_MEM_SRC_ANONYMOUS_HUGETLB,},
> -};
> -
>  bool thp_configured(void)
>  {
>  	int ret;
> @@ -180,22 +175,64 @@ size_t get_def_hugetlb_pagesz(void)
>  	return 0;
>  }
>  
> +const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
> +{
> +	static const struct vm_mem_backing_src_alias aliases[] = {
> +		{ "anonymous",               0                            },
> +		{ "anonymous_thp",           0                            },
> +		{ "anonymous_hugetlb",       MAP_HUGETLB                  },
> +		{ "anonymous_hugetlb_16kb",  MAP_HUGETLB | MAP_HUGE_16KB  },
> +		{ "anonymous_hugetlb_64kb",  MAP_HUGETLB | MAP_HUGE_64KB  },
> +		{ "anonymous_hugetlb_512kb", MAP_HUGETLB | MAP_HUGE_512KB },
> +		{ "anonymous_hugetlb_1mb",   MAP_HUGETLB | MAP_HUGE_1MB   },
> +		{ "anonymous_hugetlb_2mb",   MAP_HUGETLB | MAP_HUGE_2MB   },
> +		{ "anonymous_hugetlb_8mb",   MAP_HUGETLB | MAP_HUGE_8MB   },
> +		{ "anonymous_hugetlb_16mb",  MAP_HUGETLB | MAP_HUGE_16MB  },
> +		{ "anonymous_hugetlb_32mb",  MAP_HUGETLB | MAP_HUGE_32MB  },
> +		{ "anonymous_hugetlb_256mb", MAP_HUGETLB | MAP_HUGE_256MB },
> +		{ "anonymous_hugetlb_512mb", MAP_HUGETLB | MAP_HUGE_512MB },
> +		{ "anonymous_hugetlb_1gb",   MAP_HUGETLB | MAP_HUGE_1GB   },
> +		{ "anonymous_hugetlb_2gb",   MAP_HUGETLB | MAP_HUGE_2GB   },
> +		{ "anonymous_hugetlb_16gb",  MAP_HUGETLB | MAP_HUGE_16GB  },
> +	};
> +	_Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
> +		       "Missing new backing src types?");
> +
> +	TEST_ASSERT(i < NUM_SRC_TYPES, "Backing src type ID %d too big", i);
> +
> +	return &aliases[i];
> +}
> +
> +size_t get_backing_src_pagesz(uint32_t i)
> +{
> +	uint32_t flag = vm_mem_backing_src_alias(i)->flag;
> +
> +	if (i == VM_MEM_SRC_ANONYMOUS)
> +		return getpagesize();
> +	if (i == VM_MEM_SRC_ANONYMOUS_THP)
> +		return get_trans_hugepagesz();
> +	if (i == VM_MEM_SRC_ANONYMOUS_HUGETLB)
> +		return get_def_hugetlb_pagesz();

nit: a switch would look nicer (IMHO)

> +
> +	return MAP_HUGE_PAGE_SIZE(flag);
> +}
> +
>  void backing_src_help(void)
>  {
>  	int i;
>  
>  	printf("Available backing src types:\n");
> -	for (i = 0; i < ARRAY_SIZE(backing_src_aliases); i++)
> -		printf("\t%s\n", backing_src_aliases[i].name);
> +		for (i = 0; i < NUM_SRC_TYPES; i++)
> +			printf("\t%s\n", vm_mem_backing_src_alias(i)->name);

What happened with the indentation here?

>  }
>  
>  enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name)
>  {
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(backing_src_aliases); i++)
> -		if (!strcmp(type_name, backing_src_aliases[i].name))
> -			return backing_src_aliases[i].type;
> +	for (i = 0; i < NUM_SRC_TYPES; i++)
> +		if (!strcmp(type_name, vm_mem_backing_src_alias(i)->name))
> +			return i;
>  
>  	backing_src_help();
>  	TEST_FAIL("Unknown backing src type: %s", type_name);
> -- 
> 2.23.0
>

Otherwise

Reviewed-by: Andrew Jones <drjones@redhat.com>

