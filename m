Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3951EF6D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jun 2020 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgFELxa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 07:53:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33335 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726324AbgFELxa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 07:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591358009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pGyELxbF0eQqbKEOHz3POJpaeXtgZXY/zRXdlzYoB44=;
        b=S2h1C+2WClvGHVsmMbT27RDz3XvQJ88abBzjGeSTSVnyyglEUmyRYlrQUbzT8CxPRpDJbx
        EocVLfmiGbpHEhK+RjXxl09PTeFq0iPZS9A9w/FLMewv7YUTJTa0TCboWZ9qbhUaTaTykV
        GuSw0Iu/oDAbs4Yxox+DV9NXV4E0bXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-VM0TQu05MA-8hLE1cJ9cqw-1; Fri, 05 Jun 2020 07:53:27 -0400
X-MC-Unique: VM0TQu05MA-8hLE1cJ9cqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF8219057A0;
        Fri,  5 Jun 2020 11:53:26 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 175FA6292E;
        Fri,  5 Jun 2020 11:53:20 +0000 (UTC)
Date:   Fri, 5 Jun 2020 13:53:16 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Gardon <bgardon@google.com>, Shuah Khan <shuah@kernel.org>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: delete some dead code
Message-ID: <20200605115316.z5tavmf5rjobypve@kamzik.brq.redhat.com>
References: <20200605110048.GB978434@mwanda>
 <9f20e25d-599d-c203-e3d4-905b122ef5a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f20e25d-599d-c203-e3d4-905b122ef5a3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 05, 2020 at 01:16:59PM +0200, Paolo Bonzini wrote:
> On 05/06/20 13:00, Dan Carpenter wrote:
> > The "uffd_delay" variable is unsigned so it's always going to be >= 0.
> > 
> > Fixes: 0119cb365c93 ("KVM: selftests: Add configurable demand paging delay")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  tools/testing/selftests/kvm/demand_paging_test.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> > index 360cd3ea4cd67..4eb79621434e6 100644
> > --- a/tools/testing/selftests/kvm/demand_paging_test.c
> > +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> > @@ -615,8 +615,6 @@ int main(int argc, char *argv[])
> >  			break;
> >  		case 'd':
> >  			uffd_delay = strtoul(optarg, NULL, 0);
> > -			TEST_ASSERT(uffd_delay >= 0,
> > -				    "A negative UFFD delay is not supported.");
> >  			break;
> >  		case 'b':
> >  			vcpu_memory_bytes = parse_size(optarg);
> > 
> 
> The bug is that strtoul is "impossible" to use correctly.  The right fix
> would be to have a replacement for strtoul.

The test needs an upper limit. It obviously doesn't make sense to ever
want a ULONG_MAX usec delay. What's the maximum number of usecs we should
allow?

Thanks,
drew

