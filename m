Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B03442EC7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Oct 2021 10:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhJOIim (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 04:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235320AbhJOIil (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 04:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634286994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jln/0dXddJnV8Enx7M67nr+qrzZMhGUG5wRmnfwIXgc=;
        b=UIYmKfQoq+D//JocZmJMWHm66XpedmOp0KwdlzeWzaSKyAtklrjMx0Dvu23rvnhCicc3HZ
        9BOjO+lTk2i/e4OVBUEz4TBgN9eOYI6EZRzrBuG4+E4B9wgNsxNfgENdJuM3Oa4eH9GlQC
        HzLVGzMOerEaA+4t6Ngi5Vqtxr3y2mI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-_IJ435cvMBOZ6mAirGtW1g-1; Fri, 15 Oct 2021 04:36:31 -0400
X-MC-Unique: _IJ435cvMBOZ6mAirGtW1g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B31010B3940;
        Fri, 15 Oct 2021 08:36:29 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5326B5BAF8;
        Fri, 15 Oct 2021 08:36:15 +0000 (UTC)
Date:   Fri, 15 Oct 2021 16:36:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YWk9e957Hb+I7HvR@T590>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-12-mcgrof@kernel.org>
 <YWeOJP2UJWYF94fu@T590>
 <YWeR4moCRh+ZHOmH@T590>
 <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 14, 2021 at 05:22:40PM -0700, Luis Chamberlain wrote:
> On Fri, Oct 15, 2021 at 07:52:04AM +0800, Ming Lei wrote:
...
> > 
> > We need to understand the exact reason why there is still cpuhp node
> > left, can you share us the exact steps for reproducing the issue?
> > Otherwise we may have to trace and narrow down the reason.
> 
> See my commit log for my own fix for this issue.

OK, thanks!

I can reproduce the issue, and the reason is that reset_store fails
zram_remove() when unloading module, then the warning is caused.

The top 3 patches in the following tree can fix the issue:

https://github.com/ming1/linux/commits/my_v5.15-blk-dev


Thanks,
Ming

