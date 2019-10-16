Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD92DD9729
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406226AbfJPQYQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 12:24:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406222AbfJPQYQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 12:24:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEB2130860C1;
        Wed, 16 Oct 2019 16:24:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 803E35D9CD;
        Wed, 16 Oct 2019 16:24:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 16 Oct 2019 18:24:13 +0200 (CEST)
Date:   Wed, 16 Oct 2019 18:24:09 +0200
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
Message-ID: <20191016162408.GB31585@redhat.com>
References: <20191015141332.4055-1-christian.brauner@ubuntu.com>
 <20191016153606.2326-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016153606.2326-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 16 Oct 2019 16:24:16 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16, Christian Brauner wrote:
>
> +static inline bool task_alive(struct pid *pid, enum pid_type type)
> +{
> +	return !hlist_empty(&pid->tasks[type]);
> +}

So you decided to add a helper ;) OK, but note that its name is very
confusing and misleading. Even more than pid_alive() we already have.

What does "alive" actually mean? Say, task_alive(pid, PIDTYPE_SID) == F
after fork(). Then it becomes T if this task does setsid().

And why task_ if it accepts pid+pid_type? May be pid_has_task() or
something like this...

OK, since I can't suggest a better name I won't really argue. Feel free
to add my reviewed-by to this series.

Oleg.

