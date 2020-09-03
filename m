Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3435025C3C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 16:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgICO61 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 10:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729083AbgICO6U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 10:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599145098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bAzDqUsZ3/S0Arl+SG6AfwuZzD/9UqKF/7Kwa7yb0iM=;
        b=JcYJKD481mBrUK/yADnlAMQ5VClUde9ixQdnpVhDZVCDNsCuN8lpG4PKwAA/QD7DsCt35Z
        gYCaDPlTo1w/brTFp+fsBP0YPfec8otpTF2UU5efLpEI0pYzzqhlbawZnUWegTbLO3zQuy
        /Ciho6Dxa4y+mSpeXVED1W+xfxrtdsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-QvP6zRKEMW6q3GiEMxQAfg-1; Thu, 03 Sep 2020 10:58:16 -0400
X-MC-Unique: QvP6zRKEMW6q3GiEMxQAfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5F18CF9BB;
        Thu,  3 Sep 2020 14:58:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id CE33186580;
        Thu,  3 Sep 2020 14:58:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  3 Sep 2020 16:58:14 +0200 (CEST)
Date:   Thu, 3 Sep 2020 16:58:09 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Jens Axboe <axboe@kernel.dk>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/4] pidfd: support PIDFD_NONBLOCK in pidfd_open()
Message-ID: <20200903145808.GK4386@redhat.com>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
 <20200902102130.147672-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902102130.147672-2-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Christian, off-topic question...

On 09/02, Christian Brauner wrote:
>
> -static int pidfd_create(struct pid *pid)
> +static int pidfd_create(struct pid *pid, unsigned int flags)
>  {
>  	int fd;
>
>  	fd = anon_inode_getfd("[pidfd]", &pidfd_fops, get_pid(pid),
> -			      O_RDWR | O_CLOEXEC);
> +			      flags | O_RDWR | O_CLOEXEC);

I just noticed this comment above pidfd_create:

	 * Note, that this function can only be called after the fd table has
	 * been unshared to avoid leaking the pidfd to the new process.

what does it mean?

Of course, if fd table is shared then pidfd can "leak" to another process,
but this is true for any file and sys_pidfd_open() doesn't do any check?



In fact I think this helper buys nothing but adds the unnecessary get/put_pid,
we can kill it and change pidfd_open() to do

	SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
	{
		int fd;
		struct pid *p;

		if (flags & ~PIDFD_NONBLOCK)
			return -EINVAL;

		if (pid <= 0)
			return -EINVAL;

		p = find_get_pid(pid);
		if (!p)
			return -ESRCH;

		fd = -EINVAL;
		if (pid_has_task(p, PIDTYPE_TGID)) {
			fd = anon_inode_getfd("[pidfd]", &pidfd_fops, pid,
						flags | O_RDWR | O_CLOEXEC);
		}
		if (fd < 0)
			put_pid(p);
		return fd;
	}

but this is cosmetic and off-topic too.

Oleg.

