Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA242E0BE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Dec 2020 15:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgLVOhw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Dec 2020 09:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727651AbgLVOhw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Dec 2020 09:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608647785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VOk6E6hPe7usXLD5bNCDmNIcAC8JFXb+4t0X8eR9cr4=;
        b=SJrIVV5eVXvMCpxds2FaAP370gHMJTsymQkasmhElVk1sVj0xk9jEYt07EdPohBfgTrugi
        WoEXSt8aJUhBq+f5U7KQjrsoZuz0MqTcV7yryV/OEnivShpepOIAgDYDhNo2XFmB7WnQuH
        qkD0OcMtZQCvbiX/JrUKPLdvtgWGie8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-6XDxApNmPNKJ09t1PSBSsQ-1; Tue, 22 Dec 2020 09:36:22 -0500
X-MC-Unique: 6XDxApNmPNKJ09t1PSBSsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B74E910054FF;
        Tue, 22 Dec 2020 14:36:20 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24A0D6F977;
        Tue, 22 Dec 2020 14:36:17 +0000 (UTC)
Date:   Tue, 22 Dec 2020 09:36:16 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, josef@toxicpanda.com,
        bvanassche@acm.org, corbet@lwn.net, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, song@kernel.org, dm-devel@redhat.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, agk@redhat.com,
        michael.christie@oracle.com
Subject: Re: [PATCH v1 0/5] dm: dm-user: New target that proxies BIOs to
 userspace
Message-ID: <20201222143616.GB12885@redhat.com>
References: <30d39293-80a4-9ef5-92bb-6b6dec464be3@toxicpanda.com>
 <mhng-2da5b1a2-20f9-4b0e-9ffd-7f60a161ebf0@palmerdabbelt-glaptop>
 <20201222133246.GA5099@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222133246.GA5099@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 22 2020 at  8:32am -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Dec 14, 2020 at 07:00:57PM -0800, Palmer Dabbelt wrote:
> > I haven't gotten a whole lot of feedback, so I'm inclined to at least have some
> > reasonable performance numbers before bothering with a v2.
> 
> FYI, my other main worry beside duplicating nbd is that device mapper
> really is a stacked interface that sits on top of other block device.
> Turning this into something else that just pipes data to userspace
> seems very strange.

I agree.  Only way I'd be interested is if it somehow tackled enabling
much more efficient IO.  Earlier discussion in this thread mentioned
that zero-copy and low overhead wasn't a priority (because it is hard,
etc).  But the hard work has already been done with io_uring.  If
dm-user had a prereq of leaning heavily on io_uring and also enabled IO
polling for bio-based then there may be a win to supporting it.

But unless lower latency (or some other more significant win) is made
possible I just don't care to prop up an unnatural DM bolt-on.

Mike

