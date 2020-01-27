Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6FC149FFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2020 09:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgA0Ij7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 03:39:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29792 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727312AbgA0Ij5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 03:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580114396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZpHT1b7QCYEtUyEDfU19kPPlvCGn/zK+5IB3O5NWZGA=;
        b=hu48JLsKvnPccHlFswfy85bdQNq9z3Ew1oNuxEqDZLI1jeuffKBVHxoCNdStRifzBVypoR
        diI0fGm1riXk7cDuRLeHyGRdN/2s2jxZd/OCcWot3451DIDLrryJrMoW4vFGyLsXT3i0yW
        jLmQO/4FgFJHPjmqH4cncQFdsJB4ajw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-oduXl9jDMwWRIXAuH1lgfQ-1; Mon, 27 Jan 2020 03:39:54 -0500
X-MC-Unique: oduXl9jDMwWRIXAuH1lgfQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F81E477;
        Mon, 27 Jan 2020 08:39:53 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16DB45DA7B;
        Mon, 27 Jan 2020 08:39:48 +0000 (UTC)
Date:   Mon, 27 Jan 2020 09:39:46 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 07/10] KVM: selftests: Support multiple vCPUs in
 demand paging test
Message-ID: <20200127083946.wxdmo2sfauns75j6@kamzik.brq.redhat.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-8-bgardon@google.com>
 <20200124104943.6abkjzegmewnoeiv@kamzik.brq.redhat.com>
 <df86f0da-366d-bb20-d1d0-125697c660a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df86f0da-366d-bb20-d1d0-125697c660a8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 25, 2020 at 10:39:20AM +0100, Paolo Bonzini wrote:
> On 24/01/20 11:49, Andrew Jones wrote:
> >> +
> >> +	/*
> >> +	 * Reserve twice the ammount of memory needed to map the test region and
> >> +	 * the page table / stacks region, at 4k, for page tables. Do the
> >> +	 * calculation with 4K page size: the smallest of all archs. (e.g., 64K
> >> +	 * page size guest will need even less memory for page tables).
> >> +	 */
> >> +	pages += (2 * pages) / PTES_PER_4K_PT;
> >> +	pages += ((2 * vcpus * vcpu_memory_bytes) >> PAGE_SHIFT_4K) /
> >> +		 PTES_PER_4K_PT;
> > pages needs to be rounded up to the next multiple of 16 in order for this
> > to work on aarch64 machines with 64k pages.
> 
> I think this is best done with a generic function that does the rounding
> and an arch-specific function that returns the page size.  Can you send
> a patch to implement this?
>

Sure. Will do.

Thanks,
drew 

