Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3EF25CE7C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Sep 2020 01:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgICXuj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 19:50:39 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55969 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgICXuh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 19:50:37 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id ECDD6C0005;
        Thu,  3 Sep 2020 23:50:27 +0000 (UTC)
Date:   Thu, 3 Sep 2020 16:50:24 -0700
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
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/4] pidfd: support PIDFD_NONBLOCK in pidfd_open()
Message-ID: <20200903235024.GA210207@localhost>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
 <20200902102130.147672-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902102130.147672-2-christian.brauner@ubuntu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 02, 2020 at 12:21:27PM +0200, Christian Brauner wrote:
> Introduce PIDFD_NONBLOCK to support non-blocking pidfd file descriptors.
> 
> Ever since the introduction of pidfds and more advanced async io various
> programming languages such as Rust have grown support for async event
> libraries. These libraries are created to help build epoll-based event loops
> around file descriptors. A common pattern is to automatically make all file
> descriptors they manage to O_NONBLOCK.
> 
> For such libraries the EAGAIN error code is treated specially. When a function
> is called that returns EAGAIN the function isn't called again until the event
> loop indicates the the file descriptor is ready. Supporting EAGAIN when
> waiting on pidfds makes such libraries just work with little effort. In the
> following patch we will extend waitid() internally to support non-blocking
> pidfds.
> 
> This introduces a new flag PIDFD_NONBLOCK that is equivalent to O_NONBLOCK.
> This follows the same patterns we have for other (anon inode) file descriptors
> such as EFD_NONBLOCK, IN_NONBLOCK, SFD_NONBLOCK, TFD_NONBLOCK and the same for
> close-on-exec flags.
> 
> Link: https://lore.kernel.org/lkml/20200811181236.GA18763@localhost/
> Link: https://github.com/joshtriplett/async-pidfd
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Sargun Dhillon <sargun@sargun.me>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>
