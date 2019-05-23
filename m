Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE6C284C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfEWRUM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 13:20:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731106AbfEWRUM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 13:20:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 597C46EF;
        Thu, 23 May 2019 17:20:12 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C145100200D;
        Thu, 23 May 2019 17:20:06 +0000 (UTC)
Date:   Thu, 23 May 2019 19:20:04 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/9] KVM: selftests: Introduce a VM_MODE_DEFAULT macro
 for the default bits
Message-ID: <20190523172004.yeo5wtugofoh5mid@kamzik.brq.redhat.com>
References: <20190523164309.13345-1-thuth@redhat.com>
 <20190523164309.13345-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523164309.13345-5-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 23 May 2019 17:20:12 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 06:43:04PM +0200, Thomas Huth wrote:
> This will be required later for tests like the kvm_create_max_vcpus
> test that do not use the vm_create_default() function.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util.h      | 6 ++++++
>  tools/testing/selftests/kvm/lib/aarch64/processor.c | 2 +-
>  tools/testing/selftests/kvm/lib/x86_64/processor.c  | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index b8bf961074fe..b6eb6471e6b2 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -43,6 +43,12 @@ enum vm_guest_mode {
>  	NUM_VM_MODES,
>  };
>  
> +#ifdef __aarch64__
> +#define VM_MODE_DEFAULT VM_MODE_P40V48_4K
> +#else
> +#define VM_MODE_DEFAULT VM_MODE_P52V48_4K
> +#endif
> +
>  #define vm_guest_mode_string(m) vm_guest_mode_string[m]
>  extern const char * const vm_guest_mode_string[];
>  
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index fa6cd340137c..596ccaf09cb6 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -226,7 +226,7 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
>  	uint64_t extra_pg_pages = (extra_mem_pages / ptrs_per_4k_pte) * 2;
>  	struct kvm_vm *vm;
>  
> -	vm = vm_create(VM_MODE_P40V48_4K, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
> +	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
>  
>  	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
>  	vm_vcpu_add_default(vm, vcpuid, guest_code);
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index dc7fae9fa424..bb38bbcefac5 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -823,7 +823,7 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, uint64_t extra_mem_pages,
>  	uint64_t extra_pg_pages = extra_mem_pages / 512 * 2;
>  
>  	/* Create VM */
> -	vm = vm_create(VM_MODE_P52V48_4K,
> +	vm = vm_create(VM_MODE_DEFAULT,
>  		       DEFAULT_GUEST_PHY_PAGES + extra_pg_pages,
>  		       O_RDWR);
>  
> -- 
> 2.21.0
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
