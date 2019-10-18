Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3229DC809
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 17:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410313AbfJRPFe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 11:05:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49063 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388698AbfJRPFe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 11:05:34 -0400
Received: from [185.81.138.19] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iLToo-0001Jy-62; Fri, 18 Oct 2019 15:05:30 +0000
Date:   Fri, 18 Oct 2019 17:05:27 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     oleg@redhat.com, linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@kellner.me, cyphar@cyphar.com, elena.reshetova@intel.com,
        guro@fb.com, jannh@google.com, ldv@altlinux.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, peterz@infradead.org,
        shuah@kernel.org, tglx@linutronix.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 1/5] pidfd: check pid has attached task in fdinfo
Message-ID: <20191018150526.mgmucts33p7gspqo@wittgenstein>
References: <20191016153606.2326-1-christian.brauner@ubuntu.com>
 <20191017101832.5985-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191017101832.5985-1-christian.brauner@ubuntu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 12:18:28PM +0200, Christian Brauner wrote:
> Currently, when a task is dead we still print the pid it used to use in
> the fdinfo files of its pidfds. This doesn't make much sense since the
> pid may have already been reused. So verify that the task is still alive
> by introducing the pid_has_task() helper which will be used by other
> callers in follow-up patches.
> If the task is not alive anymore, we will print -1. This allows us to
> differentiate between a task not being present in a given pid namespace
> - in which case we already print 0 - and a task having been reaped.
> 
> Note that this uses PIDTYPE_PID for the check. Technically, we could've
> checked PIDTYPE_TGID since pidfds currently only refer to thread-group
> leaders but if they won't anymore in the future then this check becomes
> problematic without it being immediately obvious to non-experts imho. If
> a thread is created via clone(CLONE_THREAD) than struct pid has a single
> non-empty list pid->tasks[PIDTYPE_PID] and this pid can't be used as a
> PIDTYPE_TGID meaning pid->tasks[PIDTYPE_TGID] will return NULL even
> though the thread-group leader might still be very much alive. So
> checking PIDTYPE_PID is fine and is easier to maintain should we ever
> allow pidfds to refer to threads.
> 
> Cc: Jann Horn <jannh@google.com>
> Cc: Christian Kellner <christian@kellner.me>
> Cc: linux-api@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Applied this series to:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=pidfd

Thanks!
Christian
