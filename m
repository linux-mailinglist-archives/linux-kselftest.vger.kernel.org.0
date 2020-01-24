Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63576147EFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 11:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAXKtz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 05:49:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50513 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729992AbgAXKty (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 05:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579862993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ewCrWzbjd/xfavGLkDFLJZm0rsCoA772YL+6ee+m1Y8=;
        b=dAE6J2Zm8Wkm61ripTis5QyQfEDc/CHt5LzmlEutB79xi8edYLO23tppFh/zgNXcsWwfYo
        uFYFv77+K/iZQ5wenOWcqBJXQO0M5iE8SSZaapP+9YhdQ9n0o9XS5IWRTaSYQ5tPlBJ7ai
        ixffhUtUHb4XUc3fY9hIi6iBS4u3CNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-M3Hk-twYPbmA3PWUsqo1aQ-1; Fri, 24 Jan 2020 05:49:51 -0500
X-MC-Unique: M3Hk-twYPbmA3PWUsqo1aQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A00010CE79E;
        Fri, 24 Jan 2020 10:49:50 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C07560BEC;
        Fri, 24 Jan 2020 10:49:46 +0000 (UTC)
Date:   Fri, 24 Jan 2020 11:49:43 +0100
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
Message-ID: <20200124104943.6abkjzegmewnoeiv@kamzik.brq.redhat.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-8-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123180436.99487-8-bgardon@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 23, 2020 at 10:04:33AM -0800, Ben Gardon wrote:
...
> -static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
> -				uint64_t extra_mem_pages, void *guest_code)
> +#define PAGE_SHIFT_4K  12
> +#define PTES_PER_4K_PT 512
> +
> +static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
> +				uint64_t vcpu_memory_bytes)
>  {
>  	struct kvm_vm *vm;
> -	uint64_t extra_pg_pages = extra_mem_pages / 512 * 2;
> +	uint64_t pages = DEFAULT_GUEST_PHY_PAGES;
> +
> +	/* Account for a few pages per-vCPU for stacks */
> +	pages += DEFAULT_STACK_PGS * vcpus;
> +
> +	/*
> +	 * Reserve twice the ammount of memory needed to map the test region and
> +	 * the page table / stacks region, at 4k, for page tables. Do the
> +	 * calculation with 4K page size: the smallest of all archs. (e.g., 64K
> +	 * page size guest will need even less memory for page tables).
> +	 */
> +	pages += (2 * pages) / PTES_PER_4K_PT;
> +	pages += ((2 * vcpus * vcpu_memory_bytes) >> PAGE_SHIFT_4K) /
> +		 PTES_PER_4K_PT;

pages needs to be rounded up to the next multiple of 16 in order for this
to work on aarch64 machines with 64k pages.

Thanks,
drew

