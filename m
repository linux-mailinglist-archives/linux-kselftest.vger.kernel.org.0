Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCBCB13446F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2020 15:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgAHOAI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jan 2020 09:00:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53433 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727546AbgAHOAI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jan 2020 09:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578492007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LhAq3h7VQwMWx8ihMD40ZfIUUirmqsJ+eD0EacS+0NE=;
        b=i3TvIquN1rV4CZ+Z5sPbo3z49AHeU7kPhM4a4Jpyx7L5xbYt3NiSeSkfb9bzAiEBeLWxYN
        rKiIyKqDseuT1onpmN8Fpu61vboNMu7z6x1eSfOoGv1AZzi4oCTofX4TQJjCGSfVvhRPKZ
        FAkZWlT90ys1KDDFm8OOGdZhaWmFkwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-ztw0LAM0O3qaF-sYDtfooQ-1; Wed, 08 Jan 2020 09:00:06 -0500
X-MC-Unique: ztw0LAM0O3qaF-sYDtfooQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5C6F100550E;
        Wed,  8 Jan 2020 14:00:04 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7222D5D9E5;
        Wed,  8 Jan 2020 14:00:00 +0000 (UTC)
Date:   Wed, 8 Jan 2020 14:59:57 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 5/8] KVM: selftests: Pass args to vCPU instead of
 using globals
Message-ID: <20200108135957.4milt3brij7lvfd3@kamzik.brq.redhat.com>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-6-bgardon@google.com>
 <20200107152341.rtfmciob5ly6nnjj@kamzik.brq.redhat.com>
 <CANgfPd9aCcN8BJDkkDuC2=3Po3f6BQ6q7JkQfL7n+giDCySu7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd9aCcN8BJDkkDuC2=3Po3f6BQ6q7JkQfL7n+giDCySu7A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 07, 2020 at 10:26:10AM -0800, Ben Gardon wrote:
> On Tue, Jan 7, 2020 at 7:23 AM Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Mon, Dec 16, 2019 at 01:38:58PM -0800, Ben Gardon wrote:
> > > In preparation for supporting multiple vCPUs in the demand paging test,
> > > pass arguments to the vCPU instead of syncing globals to it.
> >
> > This will only work if we don't spill parameters onto the stack and all
> > data we want to pass fit in registers.
> 
> That's a great point. I'll see about using globals and deriving the
> cpu ID to look up args. In your pseudocode below I see you use
> arch_get_cpu_id, but I don't believe this function exists in selftests
> and I don't have the knowledge off the top of my head to implement it
> for s390 and aarch64. Do you have any pointers for implementing such a
> function?

Yeah, I never posted the patches that I used this approach on. For aarch64
my "arch_get_cpu_id", which was actually just open-coded in guest_code,
was something similar to this

 /* We only look at the first two affinity levels for now. */
 int arch_get_cpu_id(void)
 {
     uint64_t mpidr_el1, aff1, aff0;
     asm volatile("mrs %0, mpidr_el1" : "=r" (mpidr_el1));
     aff0 = mpidr_el1 & 0xf;
     aff1 = (mpidr_el1 >> 8) & 0xff;
     return aff1 * 16 + aff0;
 }

Thanks,
drew

