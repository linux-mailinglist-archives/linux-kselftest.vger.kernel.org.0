Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3DBDA7D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 10:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439246AbfJQIyW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 04:54:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439155AbfJQIyV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 04:54:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F11C118C426E;
        Thu, 17 Oct 2019 08:54:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D9AA5D9D5;
        Thu, 17 Oct 2019 08:54:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 17 Oct 2019 10:54:19 +0200 (CEST)
Date:   Thu, 17 Oct 2019 10:54:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, aarcange@redhat.com,
        akpm@linux-foundation.org, christian@kellner.me, cyphar@cyphar.com,
        elena.reshetova@intel.com, guro@fb.com, jannh@google.com,
        ldv@altlinux.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        peterz@infradead.org, shuah@kernel.org, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 1/5] pidfd: verify task is alive when printing fdinfo
Message-ID: <20191017085414.GC17513@redhat.com>
References: <20191015141332.4055-1-christian.brauner@ubuntu.com>
 <20191016153606.2326-1-christian.brauner@ubuntu.com>
 <20191016162408.GB31585@redhat.com>
 <20191016163107.5zwt6fmjyd5mkqqw@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016163107.5zwt6fmjyd5mkqqw@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Thu, 17 Oct 2019 08:54:21 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16, Christian Brauner wrote:
>
> On Wed, Oct 16, 2019 at 06:24:09PM +0200, Oleg Nesterov wrote:
> >
> > And why task_ if it accepts pid+pid_type? May be pid_has_task() or
> > something like this...
>
> Given what I said above that might be a decent name.
>
> >
> > OK, since I can't suggest a better name I won't really argue. Feel free
> > to add my reviewed-by to this series.
>
> No, naming is important. Thanks for being picky about that too and I'll
> happily resend. :)

Thanks ;) May be pid_in_use() ? Up to you, anything which starts with pid_
looks better to me than task_alive().

Oleg.

