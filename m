Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3BA19E32A
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Apr 2020 09:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgDDHEi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Apr 2020 03:04:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27298 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725871AbgDDHEi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Apr 2020 03:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585983875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yPzk8w0218ll4nuJumZge+AAPo+PXyvjBhxekGuY9E=;
        b=DBUv+w6Dhbt3c/rYSE58wvARX//EqJF0dXHcIRpvXLmXT9jIgGc+/FcsXoo/KSlwhzPYc1
        JaOuBG+M6Q0sPvi/QvcJNM7QU2Ofh0spvOVh4vqr/2dUONmfOJ9k9oWQiEgUJKaG9IfxhU
        B3YJ+MP5IQOWdqVPgFeeEsZnK4dvgxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-5ylZkg6TPvqKGzaSvLhe5w-1; Sat, 04 Apr 2020 03:04:33 -0400
X-MC-Unique: 5ylZkg6TPvqKGzaSvLhe5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A98E4107ACC4;
        Sat,  4 Apr 2020 07:04:32 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D24295D9E5;
        Sat,  4 Apr 2020 07:04:25 +0000 (UTC)
Date:   Sat, 4 Apr 2020 09:04:22 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests: kvm: Add vm_get_fd() in kvm_util
Message-ID: <20200404070422.nsgvdiktc477mb6b@kamzik.brq.redhat.com>
References: <20200403172428.15574-1-wainersm@redhat.com>
 <20200403172428.15574-2-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403172428.15574-2-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 03, 2020 at 02:24:27PM -0300, Wainer dos Santos Moschetta wrote:
> Introduces the vm_get_fd() function in kvm_util which returns
> the VM file descriptor.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 1 +
>  tools/testing/selftests/kvm/lib/kvm_util.c     | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index a99b875f50d2..4e122819ee24 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -254,6 +254,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm);
>  unsigned int vm_get_page_size(struct kvm_vm *vm);
>  unsigned int vm_get_page_shift(struct kvm_vm *vm);
>  unsigned int vm_get_max_gfn(struct kvm_vm *vm);
> +int vm_get_fd(struct kvm_vm *vm);
>  
>  unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size);
>  unsigned int vm_num_host_pages(enum vm_guest_mode mode, unsigned int num_guest_pages);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 8a3523d4434f..3e36a1eb8771 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1734,6 +1734,11 @@ unsigned int vm_get_max_gfn(struct kvm_vm *vm)
>  	return vm->max_gfn;
>  }
>  
> +int vm_get_fd(struct kvm_vm *vm)
> +{
> +        return vm->fd;
> +}
> +
>  static unsigned int vm_calc_num_pages(unsigned int num_pages,
>  				      unsigned int page_shift,
>  				      unsigned int new_page_shift,
> -- 
> 2.17.2
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

