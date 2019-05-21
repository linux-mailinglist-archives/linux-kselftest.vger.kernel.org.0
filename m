Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5A255CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2019 18:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfEUQlq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 May 2019 12:41:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40376 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfEUQlq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 May 2019 12:41:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id 15so3572907wmg.5
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2019 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QRw4dWFrlFKNeC2Hv6jFCNR7pmJ9ZVloUzzaJsWHe3k=;
        b=DrUfMEDjMCX/F/kpAns9Xje6tAglSh3UhG5Ut0HpXQH/i/WF067F5FUZoHtyFcz92J
         B9zO7Q3xmWBLCoBBlKTKoCtUiQsaTMx3Npeppmj4pHHAb15DBLIi9tECGzeTa0qz68HY
         5SJCekbjPP909njq82OecOWv07W5VLYr5VkHE6sbSe+2o5Mw73nXEvvOijdE8vUJH9BM
         uSenbJ2wN1Uv1xiE6qAy9CpI8LAAlCfwF/dLDfgYTm5Xge0CjqlWt1lxcYk7Ou9/XL7L
         lIMEXS/i0lcGD5hbzAqtPxjiA1/NY2p62maSbnW0JtvlH3GgYQ9nmlSCeM60N0klvzp1
         geRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QRw4dWFrlFKNeC2Hv6jFCNR7pmJ9ZVloUzzaJsWHe3k=;
        b=juRtyiGikF4AVam3ksGp+jBCOL+OnIuGsLRKIBvgFV4+TUKuZDflEifYm7/4vZgJVx
         SWmrbb8D09VgcqjYDF9pyi+IXF9MVIh+dvpFHvhMh0hMCfx9Uti+JSvpsT0uIT2sLmSl
         Kcn7qdDOC0Szm8v8t0rlG85neeJHKOUtd7N5B8al2axoRSrXdG/EaAH98L4YZ+YNt0oe
         ExNDKxYrCbqDc3FaGg2A2deONkiRsPSrZCOE9dAYMy8+T01Va62gxKDxJMfEtclM8OKR
         Ygvia3XPADv8tMhVbO+lZ/rFJgj/d11o9TVWnlgCPXjaysV/7KQdEC5HJW96zWkEogTQ
         1P6g==
X-Gm-Message-State: APjAAAXPHo+Qgbuoz12UjcY5HjNGnlNsRKFTcd/SpQejAYa2fkepxwEC
        7Ob5zskcB2QzN6CadFOlYHMBcg==
X-Google-Smtp-Source: APXvYqy9lGE6AuIM688BrnvZ7pn7z99PmptY1DxlEejau1I+HdIPSmSJeaZzuDaCQae7Ot/VplE6/A==
X-Received: by 2002:a7b:c40e:: with SMTP id k14mr3957899wmi.114.1558456904711;
        Tue, 21 May 2019 09:41:44 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id q14sm7089531wrx.86.2019.05.21.09.41.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 09:41:44 -0700 (PDT)
Date:   Tue, 21 May 2019 18:41:42 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        jannh@google.com, fweimer@redhat.com, oleg@redhat.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, arnd@arndb.de,
        shuah@kernel.org, tkjos@android.com, ldv@altlinux.org,
        miklos@szeredi.hu, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/2] open: add close_range()
Message-ID: <20190521164141.rbehqnghiej3gfua@brauner.io>
References: <20190521150006.GJ17978@ZenIV.linux.org.uk>
 <20190521113448.20654-1-christian@brauner.io>
 <28114.1558456227@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28114.1558456227@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 21, 2019 at 05:30:27PM +0100, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > Umm...  That's going to be very painful if you dup2() something to MAX_INT and
> > then run that; roughly 2G iterations of bouncing ->file_lock up and down,
> > without anything that would yield CPU in process.
> > 
> > If anything, I would suggest something like
> > 
> > 	fd = *start_fd;
> > 	grab the lock
> >         fdt = files_fdtable(files);
> > more:
> > 	look for the next eviction candidate in ->open_fds, starting at fd
> > 	if there's none up to max_fd
> > 		drop the lock
> > 		return NULL
> > 	*start_fd = fd + 1;
> > 	if the fscker is really opened and not just reserved
> > 		rcu_assign_pointer(fdt->fd[fd], NULL);
> > 		__put_unused_fd(files, fd);
> > 		drop the lock
> > 		return the file we'd got
> > 	if (unlikely(need_resched()))
> > 		drop lock
> > 		cond_resched();
> > 		grab lock
> > 		fdt = files_fdtable(files);
> > 	goto more;
> > 
> > with the main loop being basically
> > 	while ((file = pick_next(files, &start_fd, max_fd)) != NULL)
> > 		filp_close(file, files);
> 
> If we can live with close_from(int first) rather than close_range(), then this
> can perhaps be done a lot more efficiently by:

Yeah, you mentioned this before. I do like being able to specify an
upper bound to have the ability to place fds strategically after said
upper bound.
I have used this quite a few times where I know that given task may have
inherited up to m fds and I want to inherit a specific pipe who's fd I
know. Then I'd dup2(pipe_fd, <upper_bound + 1>) and then close all
other fds. Is that too much of a corner case?

Christian
