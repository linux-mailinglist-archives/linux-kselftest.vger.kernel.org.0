Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB9819C498
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbgDBOol (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 10:44:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50593 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726927AbgDBOol (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 10:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585838680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMHlFOxjLmTTxfH+GAjNPgGZ5VoYA74W6D+Nq8wo4cs=;
        b=b22TN22Oa6gPkMGFT8nGgP3y4LFROAJVCDHBRBTERMlQxEDMdkYZ2Xos6K2KemgbHXHux+
        lkwMH6YgUJRUYa5+STzEvd0+y6iStH1cwI0kVpAIf8ouxgklpw82l5Gz75Ncy4aaRP635r
        3sSwBf4kYH7k4F253pkCYb3QSC/szNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-bQDUJto2Ota_85vMO6-Ncg-1; Thu, 02 Apr 2020 10:44:38 -0400
X-MC-Unique: bQDUJto2Ota_85vMO6-Ncg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CE0A800D53;
        Thu,  2 Apr 2020 14:44:37 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A73360BF3;
        Thu,  2 Apr 2020 14:44:29 +0000 (UTC)
Date:   Thu, 2 Apr 2020 16:44:26 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        david@redhat.com
Subject: Re: [PATCH 2/2] selftests: kvm: Add mem_slot_test test
Message-ID: <20200402144426.okukaw6af7olpn5f@kamzik.brq.redhat.com>
References: <20200330204310.21736-1-wainersm@redhat.com>
 <20200330204310.21736-3-wainersm@redhat.com>
 <20200402090029.pc6w6iqikgthflhq@kamzik.brq.redhat.com>
 <e6676068-3214-f9bf-832b-889facc8b091@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6676068-3214-f9bf-832b-889facc8b091@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 02, 2020 at 10:56:18AM -0300, Wainer dos Santos Moschetta wrote:
> 
> On 4/2/20 6:00 AM, Andrew Jones wrote:
> > On Mon, Mar 30, 2020 at 05:43:10PM -0300, Wainer dos Santos Moschetta wrote:
> > > This patch introduces the mem_slot_test test which checks
> > > an VM can have added memory slots up to the limit defined in
> > > KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
> > > verify it fails as expected.
> > > 
> > > Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> > > ---
> > >   tools/testing/selftests/kvm/.gitignore      |  1 +
> > >   tools/testing/selftests/kvm/Makefile        |  3 +
> > >   tools/testing/selftests/kvm/mem_slot_test.c | 92 +++++++++++++++++++++
> > >   3 files changed, 96 insertions(+)
> > >   create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c
> > > 
> > BTW, in kvm/queue we also now have
> > 
> > x86_64/set_memory_region_test.c
> > 
> > I wonder if we shouldn't try to make x86_64/set_memory_region_test.c
> > arch-neutral and then integrate this new test with it.
> 
> When I started work on this test I called it "add_max_mem_slots" but then I
> realized it could be rather a suite for other tests, so it was renamed. So
> yes, I think we can try to merge those memory region tests altogether.
> 
> I'm about to send a v2 where I address all your comments and hopefully we
> can use as the base for such as integration. Makes sense?

OK, but there's no rush (at least for me) for v2. If you want to look at
integration for v2 and send it later, then I'm fine with waiting.

Thanks,
drew
> 
> Thanks!
> 
> - Wainer
> 
> 
> > 
> > Thanks,
> > drew
> 

