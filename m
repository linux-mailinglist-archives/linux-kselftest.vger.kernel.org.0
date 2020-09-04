Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE8025D676
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Sep 2020 12:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgIDKhf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Sep 2020 06:37:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35595 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbgIDKaW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Sep 2020 06:30:22 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kE8z6-0001vn-BT; Fri, 04 Sep 2020 10:30:20 +0000
Date:   Fri, 4 Sep 2020 12:30:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Josh Triplett <josh@joshtriplett.org>
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
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Support non-blocking pidfds
Message-ID: <20200904103019.6tmbfuzzmj7r5vup@wittgenstein>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
 <20200903235855.GD210207@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903235855.GD210207@localhost>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 03, 2020 at 04:58:55PM -0700, Josh Triplett wrote:
> On Wed, Sep 02, 2020 at 12:21:26PM +0200, Christian Brauner wrote:
> > Hi,
> > 
> > Passing a non-blocking pidfd to waitid() currently has no effect, i.e.
> > is not supported. There are users which would like to use waitid() on
> > pidfds that are O_NONBLOCK and mix it with pidfds that are blocking and
> > both pass them to waitid().
> > The expected behavior is to have waitid() return -EAGAIN for
> > non-blocking pidfds and to block for blocking pidfds without needing to
> > perform any additional checks for flags set on the pidfd before passing
> > it to waitid().
> > Non-blocking pidfds will return EAGAIN from waitid() when no child
> > process is ready yet. Returning -EAGAIN for non-blocking pidfds makes it
> > easier for event loops that handle EAGAIN specially.
> > 
> > It also makes the API more consistent and uniform. In essence, waitid()
> > is treated like a read on a non-blocking pidfd or a recvmsg() on a
> > non-blocking socket.
> > With the addition of support for non-blocking pidfds we support the same
> > functionality that sockets do. For sockets() recvmsg() supports
> > MSG_DONTWAIT for pidfds waitid() supports WNOHANG. Both flags are
> > per-call options. In contrast non-blocking pidfds and non-blocking
> > sockets are a setting on an open file description affecting all threads
> > in the calling process as well as other processes that hold file
> > descriptors referring to the same open file description. Both behaviors,
> > per call and per open file description, have genuine use-cases.
> > 
> > A concrete use-case that was brought on-list (see [1]) was Josh's async
> > pidfd library. Ever since the introduction of pidfds and more advanced
> > async io various programming languages such as Rust have grown support
> > for async event libraries. These libraries are created to help build
> > epoll-based event loops around file descriptors. A common pattern is to
> > automatically make all file descriptors they manage to O_NONBLOCK.
> > 
> > For such libraries the EAGAIN error code is treated specially. When a
> > function is called that returns EAGAIN the function isn't called again
> > until the event loop indicates the the file descriptor is ready.
> > Supporting EAGAIN when waiting on pidfds makes such libraries just work
> > with little effort.
> 
> Thanks for the patch series, Christian!
> 
> This will make it much easier to use pidfd in non-blocking event loops.
> 
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Thank you and thanks for your input on a bunch of other stuff as well. :)

Christian
