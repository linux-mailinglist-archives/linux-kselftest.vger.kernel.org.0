Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0178A3255E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Feb 2021 19:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhBYS44 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Feb 2021 13:56:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230371AbhBYS4x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Feb 2021 13:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614279327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V2KuMziu842JMfiM/AqGMgt14XmhOnxGCT/IAIzioz4=;
        b=OZVjJQ4/VhcVSWCVKtHUDBLVu6lhQ3eh0mez+x13YRgE4WzT8peO+lTj37l3dRsJbc8Y0m
        dVWyY19Gsdlz467Gcn+jvdRqnQBlbtJEab3cMq3J3dnq8rpRmjJ3H29xcu6jMFYG0ve1Wt
        F8hJJX0I08xbBKvD5rmczsoAaj9lwqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-lUrrAByYOcuxgzJK52RQTg-1; Thu, 25 Feb 2021 13:55:23 -0500
X-MC-Unique: lUrrAByYOcuxgzJK52RQTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CFC01083E8F;
        Thu, 25 Feb 2021 18:55:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 729D860C16;
        Thu, 25 Feb 2021 18:55:09 +0000 (UTC)
Date:   Thu, 25 Feb 2021 19:55:06 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Peter Xu <peterx@redhat.com>,
        Marc Zyngier <maz@kernel.org>, wanghaibin.wang@huawei.com,
        yuzenghui@huawei.com
Subject: Re: [RFC PATCH v2 3/7] KVM: selftests: Make a generic helper to get
 vm guest mode strings
Message-ID: <20210225185506.r54k2z6e6xual7ag@kamzik.brq.redhat.com>
References: <20210225055940.18748-1-wangyanan55@huawei.com>
 <20210225055940.18748-4-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225055940.18748-4-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 25, 2021 at 01:59:36PM +0800, Yanan Wang wrote:
> For generality and conciseness, make an API which can be used in all
> kvm libs and selftests to get vm guest mode strings. And the index i
> is checked in the API in case of possiable faults.
> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  4 +--
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 29 ++++++++++++-------
>  2 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 2d7eb6989e83..f52a7492f47f 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -68,9 +68,6 @@ enum vm_guest_mode {
>  #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
>  #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
>  
> -#define vm_guest_mode_string(m) vm_guest_mode_string[m]
> -extern const char * const vm_guest_mode_string[];
> -
>  struct vm_guest_mode_params {
>  	unsigned int pa_bits;
>  	unsigned int va_bits;
> @@ -84,6 +81,7 @@ int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
>  int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
>  		    struct kvm_enable_cap *cap);
>  void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
> +const char *vm_guest_mode_string(uint32_t i);
>  
>  struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
>  void kvm_vm_free(struct kvm_vm *vmp);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index d787cb802b4a..cc22c4ab7d67 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -141,17 +141,24 @@ static void vm_open(struct kvm_vm *vm, int perm)
>  		"rc: %i errno: %i", vm->fd, errno);
>  }
>  
> -const char * const vm_guest_mode_string[] = {
> -	"PA-bits:52,  VA-bits:48,  4K pages",
> -	"PA-bits:52,  VA-bits:48, 64K pages",
> -	"PA-bits:48,  VA-bits:48,  4K pages",
> -	"PA-bits:48,  VA-bits:48, 64K pages",
> -	"PA-bits:40,  VA-bits:48,  4K pages",
> -	"PA-bits:40,  VA-bits:48, 64K pages",
> -	"PA-bits:ANY, VA-bits:48,  4K pages",
> -};
> -_Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
> -	       "Missing new mode strings?");
> +const char *vm_guest_mode_string(uint32_t i)
> +{
> +	static const char * const strings[] = {
> +		[VM_MODE_P52V48_4K]	= "PA-bits:52,  VA-bits:48,  4K pages",
> +		[VM_MODE_P52V48_64K]	= "PA-bits:52,  VA-bits:48, 64K pages",
> +		[VM_MODE_P48V48_4K]	= "PA-bits:48,  VA-bits:48,  4K pages",
> +		[VM_MODE_P48V48_64K]	= "PA-bits:48,  VA-bits:48, 64K pages",
> +		[VM_MODE_P40V48_4K]	= "PA-bits:40,  VA-bits:48,  4K pages",
> +		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
> +		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
> +	};
> +	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
> +		       "Missing new mode strings?");
> +
> +	TEST_ASSERT(i < NUM_VM_MODES, "Guest mode ID %d too big", i);
> +
> +	return strings[i];
> +}
>  
>  const struct vm_guest_mode_params vm_guest_mode_params[] = {
>  	{ 52, 48,  0x1000, 12 },
> -- 
> 2.19.1
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

