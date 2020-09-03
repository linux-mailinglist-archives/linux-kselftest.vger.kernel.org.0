Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8F425C2B2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgICOdA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 10:33:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41722 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729278AbgICObg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 10:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599143495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7bJQ7h2myCkqnHq7O24s1ZUYNalRzEYrGJNorlqx6s=;
        b=AUQSdRQH4PcxdN9PdwZG90owQKwPJdYPuqvLCDhROwZiIx7r8b+du7e3yYN/9U8SGiNvQB
        OpOVwCVZfMKTSZMKXALpY2EKYv7Hr/9KvhisrFBIiQPLypIJ5J3P3e+hDZYpJHYCOOoXhP
        qcjJGMQfimR7Xh8FWxk9FmEB5TvQ/V8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-nWV_P8BGM4aUcJJCqxZSZw-1; Thu, 03 Sep 2020 10:31:33 -0400
X-MC-Unique: nWV_P8BGM4aUcJJCqxZSZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6248C425E8;
        Thu,  3 Sep 2020 14:31:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id 14BDB1055803;
        Thu,  3 Sep 2020 14:31:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  3 Sep 2020 16:31:31 +0200 (CEST)
Date:   Thu, 3 Sep 2020 16:31:25 +0200
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
Message-ID: <20200903143124.GJ4386@redhat.com>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
 <20200902102130.147672-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902102130.147672-2-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
>  	if (fd < 0)
>  		put_pid(pid);
>  
> @@ -565,7 +567,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
>  	int fd;
>  	struct pid *p;
>  
> -	if (flags)
> +	if (flags & ~PIDFD_NONBLOCK)
>  		return -EINVAL;
>  
>  	if (pid <= 0)
> @@ -576,7 +578,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
>  		return -ESRCH;
>  
>  	if (pid_has_task(p, PIDTYPE_TGID))
> -		fd = pidfd_create(p);
> +		fd = pidfd_create(p, flags);
>  	else
>  		fd = -EINVAL;
>  

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

