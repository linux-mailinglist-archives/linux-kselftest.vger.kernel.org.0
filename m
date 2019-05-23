Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2CA28567
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 19:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfEWR4X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 13:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731206AbfEWR4X (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 13:56:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAAE9300414E;
        Thu, 23 May 2019 17:56:22 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1729C1001E6C;
        Thu, 23 May 2019 17:56:17 +0000 (UTC)
Date:   Thu, 23 May 2019 19:56:15 +0200
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
Subject: Re: [PATCH 8/9] KVM: s390: Do not report unusabled IDs via
 KVM_CAP_MAX_VCPU_ID
Message-ID: <20190523175615.fowi5tc73nwso6tm@kamzik.brq.redhat.com>
References: <20190523164309.13345-1-thuth@redhat.com>
 <20190523164309.13345-9-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523164309.13345-9-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 23 May 2019 17:56:22 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 23, 2019 at 06:43:08PM +0200, Thomas Huth wrote:
> KVM_CAP_MAX_VCPU_ID is currently always reporting KVM_MAX_VCPU_ID on all
> architectures. However, on s390x, the amount of usable CPUs is determined
> during runtime - it is depending on the features of the machine the code
> is running on. Since we are using the vcpu_id as an index into the SCA
> structures that are defined by the hardware (see e.g. the sca_add_vcpu()
> function), it is not only the amount of CPUs that is limited by the hard-
> ware, but also the range of IDs that we can use.
> Thus KVM_CAP_MAX_VCPU_ID must be determined during runtime on s390x, too.
> So the handling of KVM_CAP_MAX_VCPU_ID has to be moved from the common
> code into the architecture specific code, and on s390x we have to return
> the same value here as for KVM_CAP_MAX_VCPUS.
> This problem has been discovered with the kvm_create_max_vcpus selftest.
> With this change applied, the selftest now passes on s390x, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/mips/kvm/mips.c       | 3 +++
>  arch/powerpc/kvm/powerpc.c | 3 +++
>  arch/s390/kvm/kvm-s390.c   | 1 +
>  arch/x86/kvm/x86.c         | 3 +++
>  virt/kvm/arm/arm.c         | 3 +++
>  virt/kvm/kvm_main.c        | 2 --
>  6 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 6d0517ac18e5..0369f26ab96d 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -1122,6 +1122,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_MAX_VCPUS:
>  		r = KVM_MAX_VCPUS;
>  		break;
> +	case KVM_CAP_MAX_VCPU_ID:
> +		r = KVM_MAX_VCPU_ID;
> +		break;
>  	case KVM_CAP_MIPS_FPU:
>  		/* We don't handle systems with inconsistent cpu_has_fpu */
>  		r = !!raw_cpu_has_fpu;
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 3393b166817a..aa3a678711be 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -657,6 +657,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_MAX_VCPUS:
>  		r = KVM_MAX_VCPUS;
>  		break;
> +	case KVM_CAP_MAX_VCPU_ID:
> +		r = KVM_MAX_VCPU_ID;
> +		break;
>  #ifdef CONFIG_PPC_BOOK3S_64
>  	case KVM_CAP_PPC_GET_SMMU_INFO:
>  		r = 1;
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 8d6d75db8de6..871d2e99b156 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -539,6 +539,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		break;
>  	case KVM_CAP_NR_VCPUS:
>  	case KVM_CAP_MAX_VCPUS:
> +	case KVM_CAP_MAX_VCPU_ID:
>  		r = KVM_S390_BSCA_CPU_SLOTS;
>  		if (!kvm_s390_use_sca_entries())
>  			r = KVM_MAX_VCPUS;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 536b78c4af6e..09a07d6a154e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3122,6 +3122,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_MAX_VCPUS:
>  		r = KVM_MAX_VCPUS;
>  		break;
> +	case KVM_CAP_MAX_VCPU_ID:
> +		r = KVM_MAX_VCPU_ID;
> +		break;
>  	case KVM_CAP_PV_MMU:	/* obsolete */
>  		r = 0;
>  		break;
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 90cedebaeb94..7eeebe5e9da2 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -224,6 +224,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_MAX_VCPUS:
>  		r = KVM_MAX_VCPUS;
>  		break;
> +	case KVM_CAP_MAX_VCPU_ID:
> +		r = KVM_MAX_VCPU_ID;
> +		break;
>  	case KVM_CAP_MSI_DEVID:
>  		if (!kvm)
>  			r = -EINVAL;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f0d13d9d125d..c09259dd6286 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3146,8 +3146,6 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>  	case KVM_CAP_MULTI_ADDRESS_SPACE:
>  		return KVM_ADDRESS_SPACE_NUM;
>  #endif
> -	case KVM_CAP_MAX_VCPU_ID:
> -		return KVM_MAX_VCPU_ID;
>  	case KVM_CAP_NR_MEMSLOTS:
>  		return KVM_USER_MEM_SLOTS;
>  	default:
> -- 
> 2.21.0
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
