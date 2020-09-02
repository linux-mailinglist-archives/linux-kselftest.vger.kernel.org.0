Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863BE25A94B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 12:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIBKXW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 06:23:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49488 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBKXU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 06:23:20 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kDPvB-00069F-FI; Wed, 02 Sep 2020 10:23:17 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Jens Axboe <axboe@kernel.dk>, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 0/4] Support non-blocking pidfds
Date:   Wed,  2 Sep 2020 12:21:26 +0200
Message-Id: <20200902102130.147672-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Passing a non-blocking pidfd to waitid() currently has no effect, i.e.
is not supported. There are users which would like to use waitid() on
pidfds that are O_NONBLOCK and mix it with pidfds that are blocking and
both pass them to waitid().
The expected behavior is to have waitid() return -EAGAIN for
non-blocking pidfds and to block for blocking pidfds without needing to
perform any additional checks for flags set on the pidfd before passing
it to waitid().
Non-blocking pidfds will return EAGAIN from waitid() when no child
process is ready yet. Returning -EAGAIN for non-blocking pidfds makes it
easier for event loops that handle EAGAIN specially.

It also makes the API more consistent and uniform. In essence, waitid()
is treated like a read on a non-blocking pidfd or a recvmsg() on a
non-blocking socket.
With the addition of support for non-blocking pidfds we support the same
functionality that sockets do. For sockets() recvmsg() supports
MSG_DONTWAIT for pidfds waitid() supports WNOHANG. Both flags are
per-call options. In contrast non-blocking pidfds and non-blocking
sockets are a setting on an open file description affecting all threads
in the calling process as well as other processes that hold file
descriptors referring to the same open file description. Both behaviors,
per call and per open file description, have genuine use-cases.

A concrete use-case that was brought on-list (see [1]) was Josh's async
pidfd library. Ever since the introduction of pidfds and more advanced
async io various programming languages such as Rust have grown support
for async event libraries. These libraries are created to help build
epoll-based event loops around file descriptors. A common pattern is to
automatically make all file descriptors they manage to O_NONBLOCK.

For such libraries the EAGAIN error code is treated specially. When a
function is called that returns EAGAIN the function isn't called again
until the event loop indicates the the file descriptor is ready.
Supporting EAGAIN when waiting on pidfds makes such libraries just work
with little effort.

Thanks!
Christian

[1]: https://lore.kernel.org/lkml/20200811181236.GA18763@localhost/

Christian Brauner (4):
  pidfd: support PIDFD_NONBLOCK in pidfd_open()
  exit: support non-blocking pidfds
  tests: port pidfd_wait to kselftest harness
  tests: add waitid() tests for non-blocking pidfds

 include/uapi/linux/pidfd.h                 |  12 +
 kernel/exit.c                              |  15 +-
 kernel/pid.c                               |  12 +-
 tools/testing/selftests/pidfd/pidfd.h      |   4 +
 tools/testing/selftests/pidfd/pidfd_wait.c | 298 +++++++++------------
 5 files changed, 157 insertions(+), 184 deletions(-)
 create mode 100644 include/uapi/linux/pidfd.h


base-commit: d012a7190fc1fd72ed48911e77ca97ba4521bccd
-- 
2.28.0

