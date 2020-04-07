Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E211A0962
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Apr 2020 10:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDGIdG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 04:33:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23455 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726393AbgDGIdF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 04:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586248384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tq+OpIRxnn+Zk8S9fkUt7kbbJEzkzq8nr2igicyRqKM=;
        b=G3Ws1Ks9nz4u+Ij0wGHlRoGf52VSmR1YNoZaYdfWfCjxbMH4ZPdjD+FCTFfOjyYI1Bjq7S
        pymJJQk5+Xt+df0U/PG0QKQKxTmQ8sW1oxQSC8X2U/t6bhVYkCoKggQLbfEXH2+VMSshzs
        YzltTZgYN5AjgJCabNrJTfdGb8/iKPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-9m_XtjzwNRWLGIgdO_C1CA-1; Tue, 07 Apr 2020 04:33:02 -0400
X-MC-Unique: 9m_XtjzwNRWLGIgdO_C1CA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9638818FF663;
        Tue,  7 Apr 2020 08:33:01 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C54BD60BE1;
        Tue,  7 Apr 2020 08:32:54 +0000 (UTC)
Date:   Tue, 7 Apr 2020 10:32:51 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests: kvm: Add mem_slot_test test
Message-ID: <20200407083251.3zgjscwhldcm5hce@kamzik.brq.redhat.com>
References: <20200403172428.15574-1-wainersm@redhat.com>
 <20200403172428.15574-3-wainersm@redhat.com>
 <20200404073240.grcsylznemd3pmxz@kamzik.brq.redhat.com>
 <64a47faa-74f5-60ad-9b74-8c295072c719@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a47faa-74f5-60ad-9b74-8c295072c719@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 06, 2020 at 02:10:53PM -0300, Wainer dos Santos Moschetta wrote:
> 
> On 4/4/20 4:32 AM, Andrew Jones wrote:
> > On Fri, Apr 03, 2020 at 02:24:28PM -0300, Wainer dos Santos Moschetta wrote:
> > > This patch introduces the mem_slot_test test which checks
> > > an VM can have added memory slots up to the limit defined in
> > > KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
> > > verify it fails as expected.
> > > 
> > > Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> > > ---
> > >   tools/testing/selftests/kvm/.gitignore      |  1 +
> > >   tools/testing/selftests/kvm/Makefile        |  3 +
> > >   tools/testing/selftests/kvm/mem_slot_test.c | 85 +++++++++++++++++++++
> > >   3 files changed, 89 insertions(+)
> > >   create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c
> > > 
> > > diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> > > index 16877c3daabf..232f24d6931a 100644
> > > --- a/tools/testing/selftests/kvm/.gitignore
> > > +++ b/tools/testing/selftests/kvm/.gitignore
> > > @@ -22,3 +22,4 @@
> > >   /dirty_log_test
> > >   /kvm_create_max_vcpus
> > >   /steal_time
> > > +/mem_slot_test
> > > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > > index 712a2ddd2a27..69b44178f48b 100644
> > > --- a/tools/testing/selftests/kvm/Makefile
> > > +++ b/tools/testing/selftests/kvm/Makefile
> > > @@ -33,12 +33,14 @@ TEST_GEN_PROGS_x86_64 += demand_paging_test
> > >   TEST_GEN_PROGS_x86_64 += dirty_log_test
> > >   TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
> > >   TEST_GEN_PROGS_x86_64 += steal_time
> > > +TEST_GEN_PROGS_x86_64 += mem_slot_test
> > >   TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
> > >   TEST_GEN_PROGS_aarch64 += demand_paging_test
> > >   TEST_GEN_PROGS_aarch64 += dirty_log_test
> > >   TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
> > >   TEST_GEN_PROGS_aarch64 += steal_time
> > > +TEST_GEN_PROGS_aarch64 += mem_slot_test
> > kvm selftests has a bad case of OCD when it comes to lists of tests. In
> > the .gitignore and the Makefile we keep our tests in alphabetical order.
> > Maybe we should stop, because it's a bit annoying to maintain, but my
> > personal OCD won't allow it to be on my watch. Please fix the above
> > three lists.
> 
> I will fix it on v3.
> 
> Kind of related... has ever been discussed a naming convention for kvm
> selftests? It would allow the use of regex on both .gitignore and
> Makefile...and bye-bye those sorted lists.

It's never been discussed that I know of. Feel free to send an RFC if
you'd like to kick off the discussion :-)

Thanks,
drew

