Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC6132968
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 15:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgAGO4S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 09:56:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33652 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727908AbgAGO4S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 09:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578408977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AMsY+5AfULXXQPieaO9m1OwQcv8Xr5ZMsyyOrT8Fw9k=;
        b=bUFCjzqC7th5UypWPVL/1R7VapYKerroS15saH+gE4GAJK5OEumhVeq5moKrYVC2LvXkpt
        GWc5BgGELct9Hj8cJShD1lRICmmLYbMwU/yaI0Mp7fLa07ZwLHvqta7LRB8wisGgwxgNEX
        E5UT1V0IyVvZbPqegwgoXUScMnL9mLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-2BCXJcVsMTWMhcag17A0mg-1; Tue, 07 Jan 2020 09:56:15 -0500
X-MC-Unique: 2BCXJcVsMTWMhcag17A0mg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49303100550E;
        Tue,  7 Jan 2020 14:56:14 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDB4C5D9CA;
        Tue,  7 Jan 2020 14:56:10 +0000 (UTC)
Date:   Tue, 7 Jan 2020 15:56:08 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>
Subject: Re: [PATCH v3 1/8] KVM: selftests: Create a demand paging test
Message-ID: <20200107145608.ogi34nkyh2abdgrq@kamzik.brq.redhat.com>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-2-bgardon@google.com>
 <20200107143334.GF219677@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107143334.GF219677@xz-x1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 07, 2020 at 09:33:34AM -0500, Peter Xu wrote:
> On Mon, Dec 16, 2019 at 01:38:54PM -0800, Ben Gardon wrote:
> > While userfaultfd, KVM's demand paging implementation, is not specific
> > to KVM, having a benchmark for its performance will be useful for
> > guiding performance improvements to KVM. As a first step towards creating
> > a userfaultfd demand paging test, create a simple memory access test,
> > based on dirty_log_test.
> > 
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> 
> It's fine to start with x86-only for this test, but imho it would be
> better to mention that in cover letter, or reply to reviewer comments
> on that you removed aarch64 from previous post.

I'd also prefer that if it's x86-only that it be put in the x86_64
subdirectory and drop the arch #ifdefs. The question is why is it
x86-only for now though? Will it take a lot of work to port it to
other architectures? Or does it just need testing by someone with
the hardware?

Thanks,
drew

