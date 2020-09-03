Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3412F25C58D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Sep 2020 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgICPiv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Sep 2020 11:38:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37292 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICPiv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Sep 2020 11:38:51 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kDrK4-00029t-Nm; Thu, 03 Sep 2020 15:38:48 +0000
Date:   Thu, 3 Sep 2020 17:38:47 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
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
        Jens Axboe <axboe@kernel.dk>, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/4] exit: support non-blocking pidfds
Message-ID: <20200903153847.zvi5dzwj6v4eap6i@wittgenstein>
References: <20200902102130.147672-1-christian.brauner@ubuntu.com>
 <20200902102130.147672-3-christian.brauner@ubuntu.com>
 <20200903142241.GI4386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903142241.GI4386@redhat.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 03, 2020 at 04:22:42PM +0200, Oleg Nesterov wrote:
> On 09/02, Christian Brauner wrote:
> >
> > It also makes the API more consistent and uniform. In essence, waitid() is
> > treated like a read on a non-blocking pidfd or a recvmsg() on a non-blocking
> > socket.
> > With the addition of support for non-blocking pidfds we support the same
> > functionality that sockets do. For sockets() recvmsg() supports MSG_DONTWAIT
> > for pidfds waitid() supports WNOHANG.
> 
> What I personally do not like is that waitid(WNOHANG) returns zero or EAGAIN
> depending on f_flags & O_NONBLOCK... This doesn't match recvmsg(MSG_DONTWAIT)
> and doesn't look consistent to me.

It's not my favorite thing either but async event loops are usually
modeled around EAGAIN so I think this has benefits. Josh can speak more
to that.

Christian
