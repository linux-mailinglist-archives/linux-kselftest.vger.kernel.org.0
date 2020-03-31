Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD16198D7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Mar 2020 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCaHxM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Mar 2020 03:53:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22667 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726636AbgCaHxL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Mar 2020 03:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585641189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iSH8M0zcab1cNkiV4UELPul1CGDjNENFoeHyEZgGIB8=;
        b=RncBEKCmjdcVEy1PD3YaLCjj+WVL316v7X14NnhVURfMsDl5wbiFvv4ujuIddfvLFZaMDo
        4DSFG56UNik3cmNxpCQxU0tjJ1Mou0G6qU5OvJknDWySV23f8vGtLT4mvJWBu8v01tUFuh
        xcqdD4vrzrPDYwp6bxiM9XAcu6276S0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-bZ0Wb73oM6-k8C_NCQRfsA-1; Tue, 31 Mar 2020 03:53:07 -0400
X-MC-Unique: bZ0Wb73oM6-k8C_NCQRfsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DF4B8017CC;
        Tue, 31 Mar 2020 07:53:06 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F30760BE0;
        Tue, 31 Mar 2020 07:52:58 +0000 (UTC)
Date:   Tue, 31 Mar 2020 09:52:55 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        david@redhat.com
Subject: Re: [PATCH 1/2] selftests: kvm: Add vm_get_fd() in kvm_util
Message-ID: <20200331075255.w3kas64ogasqj6yq@kamzik.brq.redhat.com>
References: <20200330204310.21736-1-wainersm@redhat.com>
 <20200330204310.21736-2-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330204310.21736-2-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 30, 2020 at 05:43:09PM -0300, Wainer dos Santos Moschetta wrote:
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
> index ae0d14c2540a..aa4a70f969ed 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -163,6 +163,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm);
>  unsigned int vm_get_page_size(struct kvm_vm *vm);
>  unsigned int vm_get_page_shift(struct kvm_vm *vm);
>  unsigned int vm_get_max_gfn(struct kvm_vm *vm);
> +unsigned int vm_get_fd(struct kvm_vm *vm);
>  
>  struct kvm_userspace_memory_region *
>  kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index a6dd0401eb50..0961986c0d74 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1703,3 +1703,8 @@ unsigned int vm_get_max_gfn(struct kvm_vm *vm)
>  {
>  	return vm->max_gfn;
>  }
> +
> +unsigned int vm_get_fd(struct kvm_vm *vm)
> +{
> +	return vm->fd;
> +}
> -- 
> 2.17.2
>

Please use an int instead of 'unsigned int' to match the fd type.

Thanks,
drew 

