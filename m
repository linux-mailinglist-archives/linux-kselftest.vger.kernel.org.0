Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1803340A21
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhCRQYE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 12:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232153AbhCRQXf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 12:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616084613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=awmgNb4ctYwk2SZspMKBw0ygCL7HIEz0Fh/V8VpI2uA=;
        b=F7LMFEmMsZEEQimYIjJuN0dnTSJaStRwzUV0uBZDyDe/WZxv9QNjGWV/EagXqyLkd/p+Gd
        QWc6RmSi+ado2WtqLpJjsLMwL41GBb6GZ6cnesU1yx8FDHsumJG2ZgQVkT5AXFlHm+F6eZ
        51gCBHKwYbn8b1XbLQqVr5v1n/8To4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-P46Om9DfPzWgrk6j4evsrg-1; Thu, 18 Mar 2021 12:23:31 -0400
X-MC-Unique: P46Om9DfPzWgrk6j4evsrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57927102CB88;
        Thu, 18 Mar 2021 16:23:30 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.196.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C4D56064B;
        Thu, 18 Mar 2021 16:23:27 +0000 (UTC)
Date:   Thu, 18 Mar 2021 17:23:24 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kvm/kvm_util: add _vm_ioctl
Message-ID: <20210318162324.wrhb2hg6n4s2th6e@kamzik.brq.redhat.com>
References: <20210318151624.490861-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318151624.490861-1-eesposit@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 18, 2021 at 04:16:23PM +0100, Emanuele Giuseppe Esposito wrote:
> As in kvm_ioctl and _kvm_ioctl, add
> the respective _vm_ioctl for vm_ioctl.
> 
> _vm_ioctl invokes an ioctl using the vm fd,
> leaving the caller to test the result.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 1 +
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 2d7eb6989e83..d53a5f7cad61 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -133,6 +133,7 @@ void vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
>  int _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long ioctl,
>  		void *arg);
>  void vm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
> +int _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg);
>  void kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
>  int _kvm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
>  void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index e5fbf16f725b..b8849a1aca79 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1697,11 +1697,16 @@ void vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
>  {
>  	int ret;
>  
> -	ret = ioctl(vm->fd, cmd, arg);
> +	ret = _vm_ioctl(vm, cmd, arg);
>  	TEST_ASSERT(ret == 0, "vm ioctl %lu failed, rc: %i errno: %i (%s)",
>  		cmd, ret, errno, strerror(errno));
>  }
>  
> +int _vm_ioctl(struct kvm_vm *vm, unsigned long cmd, void *arg)
> +{
> +	return ioctl(vm->fd, cmd, arg);
> +}
> +
>  /*
>   * KVM system ioctl
>   *
> -- 
> 2.29.2
>

With the summary prefix change suggested by Paolo, or even better
'KVM: selftests:' since that's what the majority of patches in KVM
selftests have

Reviewed-by: Andrew Jones <drjones@redhat.com>

