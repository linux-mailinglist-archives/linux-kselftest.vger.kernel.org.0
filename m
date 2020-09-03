Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20425CE96
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Sep 2020 01:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgICX5O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 19:57:14 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:36013 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgICX5O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 19:57:14 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B11B61BF203;
        Thu,  3 Sep 2020 23:57:03 +0000 (UTC)
Date:   Thu, 3 Sep 2020 16:56:59 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-api@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/4] exit: support non-blocking pidfds
Message-ID: <20200903235659.GC210207@localhost>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
 <20200902102130.147672-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902102130.147672-3-christian.brauner@ubuntu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 02, 2020 at 12:21:28PM +0200, Christian Brauner wrote:
> Passing a non-blocking pidfd to waitid() currently has no effect, i.e.  is not
> supported. There are users which would like to use waitid() on pidfds that are
> O_NONBLOCK and mix it with pidfds that are blocking and both pass them to
> waitid().
> The expected behavior is to have waitid() return -EAGAIN for non-blocking
> pidfds and to block for blocking pidfds without needing to perform any
> additional checks for flags set on the pidfd before passing it to waitid().
> Non-blocking pidfds will return EAGAIN from waitid() when no child process is
> ready yet. Returning -EAGAIN for non-blocking pidfds makes it easier for event
> loops that handle EAGAIN specially.
> 
> It also makes the API more consistent and uniform. In essence, waitid() is
> treated like a read on a non-blocking pidfd or a recvmsg() on a non-blocking
> socket.
> With the addition of support for non-blocking pidfds we support the same
> functionality that sockets do. For sockets() recvmsg() supports MSG_DONTWAIT
> for pidfds waitid() supports WNOHANG. Both flags are per-call options. In
> contrast non-blocking pidfds and non-blocking sockets are a setting on an open
> file description affecting all threads in the calling process as well as other
> processes that hold file descriptors referring to the same open file
> description. Both behaviors, per call and per open file description, have
> genuine use-cases.
> 
> The implementation should be straightforward, we simply raise the WNOHANG flag
> when a non-blocking pidfd is passed and when do_wait() returns without finding
> an eligible task and the pidfd is non-blocking we set EAGAIN.  If no child
> process exists non-blocking pidfd users will continue to see ECHILD but if
> child processes exist but have not yet exited users will see EAGAIN.
> 
> A concrete use-case that was brought on-list was Josh's async pidfd library.
> Ever since the introduction of pidfds and more advanced async io various
> programming languages such as Rust have grown support for async event
> libraries. These libraries are created to help build epoll-based event loops
> around file descriptors. A common pattern is to automatically make all file
> descriptors they manage to O_NONBLOCK.
> 
> For such libraries the EAGAIN error code is treated specially. When a function
> is called that returns EAGAIN the function isn't called again until the event
> loop indicates the the file descriptor is ready.  Supporting EAGAIN when
> waiting on pidfds makes such libraries just work with little effort.
> 
> Link: https://lore.kernel.org/lkml/20200811181236.GA18763@localhost/
> Link: https://github.com/joshtriplett/async-pidfd
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Sargun Dhillon <sargun@sargun.me>
> Cc: Jann Horn <jannh@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Suggested-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

With or without the discussed change to WNOHANG behavior for
compatibility:
Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Also, I think you should flip the order of patches 1 and 2, so that
there isn't a one-patch window in kernel history where you can create an
O_NONBLOCK pidfd with pidfd_open but it has no effect. I'd expect
userspace to use pidfd_open accepting or EINVAL-ing the flag as an
indication of whether it'll work.
