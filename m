Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C90B2AB374
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Nov 2020 10:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKIJVc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Nov 2020 04:21:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbgKIJVb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Nov 2020 04:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604913690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K265aqwRkcmzfcbANOomdP85FmgsMn39OiD77yNCv64=;
        b=dT6QovIxDPyQIfA4NFfZHywtoGO+cZqzfn74lxWnBn8l8kfkZ2NDgqNDpN+JFghl1Oiyjh
        4EwmGH+o29LM/KHC37AUPElIrsOCQAQ7iDcn9jEGSUZ4nV7jVgR53Oc4nFBiPB40W8R9NE
        g5Cyf3155Llrmxc3PAscRTniBwNnS+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-eDmxmAV-Pqi6Gmdc7Qzbxg-1; Mon, 09 Nov 2020 04:21:28 -0500
X-MC-Unique: eDmxmAV-Pqi6Gmdc7Qzbxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFC55107AFC7;
        Mon,  9 Nov 2020 09:21:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.176])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBF4D5C221;
        Mon,  9 Nov 2020 09:21:20 +0000 (UTC)
Date:   Mon, 9 Nov 2020 10:21:17 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH 0/5] Add a dirty logging performance test
Message-ID: <20201109092117.n3b4socvehku4mwc@kamzik.brq.redhat.com>
References: <20201027233733.1484855-1-bgardon@google.com>
 <9885dac0-ca34-c680-ee44-e1a33e56aa4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9885dac0-ca34-c680-ee44-e1a33e56aa4e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 06, 2020 at 01:48:29PM +0100, Paolo Bonzini wrote:
> On 28/10/20 00:37, Ben Gardon wrote:
> > Currently KVM lacks a simple, userspace agnostic, performance benchmark for
> > dirty logging. Such a benchmark will be beneficial for ensuring that dirty
> > logging performance does not regress, and to give a common baseline for
> > validating performance improvements. The dirty log perf test introduced in
> > this series builds on aspects of the existing demand paging perf test and
> > provides time-based performance metrics for enabling and disabling dirty
> > logging, getting the dirty log, and dirtying memory.
> > 
> > While the test currently only has a build target for x86, I expect it will
> > work on, or be easily modified to support other architectures.
> > 
> > Ben Gardon (5):
> >    KVM: selftests: Factor code out of demand_paging_test
> >    KVM: selftests: Remove address rounding in guest code
> >    KVM: selftests: Simplify demand_paging_test with timespec_diff_now
> >    KVM: selftests: Add wrfract to common guest code
> >    KVM: selftests: Introduce the dirty log perf test
> > 
> >   tools/testing/selftests/kvm/.gitignore        |   1 +
> >   tools/testing/selftests/kvm/Makefile          |   1 +
> >   .../selftests/kvm/demand_paging_test.c        | 230 ++---------
> >   .../selftests/kvm/dirty_log_perf_test.c       | 382 ++++++++++++++++++
> >   .../selftests/kvm/include/perf_test_util.h    | 192 +++++++++
> >   .../testing/selftests/kvm/include/test_util.h |   2 +
> >   tools/testing/selftests/kvm/lib/test_util.c   |  22 +-
> >   7 files changed, 635 insertions(+), 195 deletions(-)
> >   create mode 100644 tools/testing/selftests/kvm/dirty_log_perf_test.c
> >   create mode 100644 tools/testing/selftests/kvm/include/perf_test_util.h
> > 
> 
> Queued, thanks.

Why would you do that? Peter reviewed this, making several comments,
such as not to put non-inline functions in header files. Ben took the
time to respin the series, posting a v2. It makes no sense to pick up
v1 after they put in that additional effort.

drew

