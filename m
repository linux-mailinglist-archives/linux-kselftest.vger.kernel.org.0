Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A56147E96
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 11:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbgAXKQs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 05:16:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25928 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731519AbgAXKQs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 05:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579861007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=clkZ2gXXFwJDpQlIi06uV2IcUP7tHBHQsiUkFdhgpPs=;
        b=HLE8unColsJ0wlLSkb7JcJDqTgYBaK+691xzC9I13+3QkoBnXcCRE7xHHgC1mT1B0RVFmx
        eip8BOBzuvu0FKktbJE73Am3oc36P9vH/8xnf8rT7+Ttyha5iChQom7El7IisWcw08x+nC
        sPBMEDeBEQJ913/tBS0logpZ+ufCoUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-T1d-EHoEPRSHUCmwZwUu_Q-1; Fri, 24 Jan 2020 05:16:45 -0500
X-MC-Unique: T1d-EHoEPRSHUCmwZwUu_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13C41DBA3;
        Fri, 24 Jan 2020 10:16:44 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E473D5DA60;
        Fri, 24 Jan 2020 10:16:39 +0000 (UTC)
Date:   Fri, 24 Jan 2020 11:16:37 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 07/10] KVM: selftests: Support multiple vCPUs in
 demand paging test
Message-ID: <20200124101637.4ppqzq7fxrd4ospw@kamzik.brq.redhat.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-8-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123180436.99487-8-bgardon@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 23, 2020 at 10:04:33AM -0800, Ben Gardon wrote:
> Most VMs have multiple vCPUs, the concurrent execution of which has a
> substantial impact on demand paging performance. Add an option to create
> multiple vCPUs to each access disjoint regions of memory.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  .../selftests/kvm/demand_paging_test.c        | 255 ++++++++++++------
>  1 file changed, 172 insertions(+), 83 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 9e2a5f7dfa140..2002032df32cc 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -24,8 +24,6 @@
>  #include "kvm_util.h"
>  #include "processor.h"
>  
> -#define VCPU_ID				1
> -
>  /* The memory slot index demand page */
>  #define TEST_MEM_SLOT_INDEX		1
>  
> @@ -34,6 +32,14 @@
>  
>  #define DEFAULT_GUEST_TEST_MEM_SIZE (1 << 30) /* 1G */
>  
> +#ifdef PRINT_PER_VCPU_UPDATES
> +#define PER_VCPU_DEBUG(...) DEBUG(__VA_ARGS__)
> +#else
> +#define PER_VCPU_DEBUG(...)
> +#endif
> +
> +#define MAX_VCPUS 512
> +
>  /*
>   * Guest/Host shared variables. Ensure addr_gva2hva() and/or
>   * sync_global_to/from_guest() are used when accessing from
> @@ -67,18 +73,25 @@ struct vcpu_args {
>  	struct kvm_vm *vm;
>  };
>  
> -static struct vcpu_args vcpu_args;
> +static struct vcpu_args vcpu_args[MAX_VCPUS];
>  
>  /*
>   * Continuously write to the first 8 bytes of each page in the demand paging
>   * memory region.
>   */
> -static void guest_code(void)
> +static void guest_code(uint32_t vcpu_id)
>  {
> -	uint64_t gva = vcpu_args.gva;
> -	uint64_t pages = vcpu_args.pages;
> +	uint64_t gva;
> +	uint64_t pages;
>  	int i;
>  
> +	/* Return to signal error if vCPU args data structure is courrupt. */
> +	if (vcpu_args[vcpu_id].vcpu_id != vcpu_id)
> +		return;

This should be GUEST_ASSERT(vcpu_args[vcpu_id].vcpu_id == vcpu_id), which
will do a UCALL_ABORT when it fails. Otherwise we're returning to where?
Likely we'll get an exception of some sort when we return to nothing,
but that's not a very clean way to die.

Thanks,
drew

