Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3F813443C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2020 14:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgAHNpb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jan 2020 08:45:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51413 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727221AbgAHNpb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jan 2020 08:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578491129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dG3i7yuSZ3ug5whVQjbMvnjTRjDpvRHXJetJ3lD56EE=;
        b=N3TS9AjqM8uIVPjkito7dT+fJXqhfHDfNRMjXlcPDta56ptjS5BXxqqRoPfNnHHgpVLHBB
        lVjznGD4WDrSEerDJDaNuTuRa7+qh4qIRr0maXxUhqZ33KEM9XWnSWrZoiBq3MqKqtJCsi
        XZzcZHW4kW2SzmE9wS8cTuZV97CpP44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-D-99LmD1OlaSQU5Xry_7AQ-1; Wed, 08 Jan 2020 08:45:28 -0500
X-MC-Unique: D-99LmD1OlaSQU5Xry_7AQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31D8E107ACC4;
        Wed,  8 Jan 2020 13:45:27 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99FC47C34A;
        Wed,  8 Jan 2020 13:45:22 +0000 (UTC)
Date:   Wed, 8 Jan 2020 14:45:20 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>
Subject: Re: [PATCH v3 1/8] KVM: selftests: Create a demand paging test
Message-ID: <20200108134520.zcrg6bx6urv4zxea@kamzik.brq.redhat.com>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-2-bgardon@google.com>
 <20200107143334.GF219677@xz-x1>
 <20200107145608.ogi34nkyh2abdgrq@kamzik.brq.redhat.com>
 <CANgfPd8_ei0WdF7t73TPveCAh1ifSp9p1B6BOkL32A+499nz=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd8_ei0WdF7t73TPveCAh1ifSp9p1B6BOkL32A+499nz=Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 07, 2020 at 10:41:55AM -0800, Ben Gardon wrote:
> I'll try to implement Drew's suggestion re: syncing global variables
> and then looking up CPU ID. If I can do that I'll upload another patch
> set for s390, aarch64, and x86. If I can't I'll move this test to the
> x86 subdirectory.
> 
> I apologize for not responding to the comments on the previous version
> of this patch set. I'm still learning the mailing list etiquette. In
> the future is it preferable that I reply to those comments when I
> upload a new patch set addressing them, or should I add a note in the
> new patch emails about the comments I addressed in that update?

It's typically enough to just create a changelog in the cover letter.
E.g.

v3:
 - Added ...
 - Dropped ...
 - Fixed ...
 - Picked up r-b's

v2:
 - Added ...
 - Dropped ...
 - Fixed ...
 - Picked up r-b's

> 
> I don't have any aarch64 or s390 hardware handy to test on so I'll try
> to move support for those architectures to separate commits at the end
> of the series, and mark them untested.

I'll test on aarch64, and I can also provide fixes if necessary.

Thanks,
drew

> 
> Thank you for your quick responses!
> 
> On Tue, Jan 7, 2020 at 6:56 AM Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Tue, Jan 07, 2020 at 09:33:34AM -0500, Peter Xu wrote:
> > > On Mon, Dec 16, 2019 at 01:38:54PM -0800, Ben Gardon wrote:
> > > > While userfaultfd, KVM's demand paging implementation, is not specific
> > > > to KVM, having a benchmark for its performance will be useful for
> > > > guiding performance improvements to KVM. As a first step towards creating
> > > > a userfaultfd demand paging test, create a simple memory access test,
> > > > based on dirty_log_test.
> > > >
> > > > Signed-off-by: Ben Gardon <bgardon@google.com>
> > >
> > > It's fine to start with x86-only for this test, but imho it would be
> > > better to mention that in cover letter, or reply to reviewer comments
> > > on that you removed aarch64 from previous post.
> >
> > I'd also prefer that if it's x86-only that it be put in the x86_64
> > subdirectory and drop the arch #ifdefs. The question is why is it
> > x86-only for now though? Will it take a lot of work to port it to
> > other architectures? Or does it just need testing by someone with
> > the hardware?
> >
> > Thanks,
> > drew
> >
> 

