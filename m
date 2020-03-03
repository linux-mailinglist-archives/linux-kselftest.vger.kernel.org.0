Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C976F177591
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 13:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgCCMBb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 07:01:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57746 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgCCMBa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 07:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dWv1/bBladFHP1191u4sCJNLli40QRaahI/ayU7p77I=; b=KiNfiBVt6HQO9gSIvJQ7lyfg0v
        gFgfulIeck8mNbXrqyOWoazcwb+/WM2ieo8XFFNFrhjbHzZFV4Xv4W/tzoNl6LUKpdI9rggJqJW9Q
        W4eeVniRdXkkGD8QKZdJ6pz5j75q+5yvJJsEzssJLID6qOS2js/pJslU6Up3JhDF7LBL8Jd1QpYzW
        LIMCkCIQCANCTVDjf3fuSGc+bht1bOQ1m+bNUd6O7ishBLLwLZ/kjWCmdTu56Jq6DJFK5PQ/MlCT5
        tgtgGrLcE2v0DuVOk/v2/fiRdsfeFTfRmOV5NBjXp32p+WhHIEL0w647W/barpo9ST1Qvlau6eNC0
        zSaLq2ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j96EI-0003q5-0r; Tue, 03 Mar 2020 12:00:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B651A30110E;
        Tue,  3 Mar 2020 12:58:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B61C2203E9E26; Tue,  3 Mar 2020 13:00:50 +0100 (CET)
Date:   Tue, 3 Mar 2020 13:00:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, dvhart@infradead.org, mingo@redhat.com,
        z.figura12@gmail.com, steven@valvesoftware.com,
        steven@liquorix.net, malteskarupke@web.de, carlos@redhat.com,
        adhemerval.zanella@linaro.org, fweimer@redhat.com,
        libc-alpha@sourceware.org
Subject: 'simple' futex interface [Was: [PATCH v3 1/4] futex: Implement
 mechanism to wait on any of several futexes]
Message-ID: <20200303120050.GC2596@hirez.programming.kicks-ass.net>
References: <20200213214525.183689-1-andrealmeid@collabora.com>
 <20200213214525.183689-2-andrealmeid@collabora.com>
 <20200228190717.GM18400@hirez.programming.kicks-ass.net>
 <20200228194958.GO14946@hirez.programming.kicks-ass.net>
 <87tv3aflqm.fsf@nanos.tec.linutronix.de>
 <967d5047-2cb6-d6d8-6107-edb99a4c9696@valvesoftware.com>
 <87o8thg031.fsf@nanos.tec.linutronix.de>
 <beb82055-96fa-cb64-a06e-9d7a0946587b@valvesoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb82055-96fa-cb64-a06e-9d7a0946587b@valvesoftware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi All,

Added some people harvested from glibc.git and added libc-alpha.

We currently have 2 big new futex features proposed, and still have the
whole NUMA thing on the table.

The proposed features are:

 - a vectored FUTEX_WAIT (as per the parent thread); allows userspace to
   wait on up-to 128 futex values.

 - multi-size (8,16,32) futexes (WAIT,WAKE,CMP_REQUEUE).

Both these features are specific to the 'simple' futex interfaces, that
is, they exclude all the PI / robust stuff.

As is; the vectored WAIT doesn't nicely interact with the multi-size
proposal (or for that matter with the already existing PRIVATE flag),
for not allowing to specify flags per WAIT instance, but this should be
fixable with some little changes to the proposed ABI.

The much bigger sticking point; as already noticed by the multi-size
patches; is that the current ABI is a limiting factor. The giant
horrible syscall.

Now, we have a whole bunch of futex ops that are already gone (FD) or
are fundamentally broken (REQUEUE) or partially weird (WAIT_BITSET has
CLOCK selection where WAIT does not) or unused (per glibc, WAKE_OP,
WAKE_BITSET, WAIT_BITSET (except for that CLOCK crud)).

So how about we introduce new syscalls:

  sys_futex_wait(void *uaddr, unsigned long val, unsigned long flags, ktime_t *timo);

  struct futex_wait {
	void *uaddr;
	unsigned long val;
	unsigned long flags;
  };
  sys_futex_waitv(struct futex_wait *waiters, unsigned int nr_waiters,
		  unsigned long flags, ktime_t *timo);

  sys_futex_wake(void *uaddr, unsigned int nr, unsigned long flags);

  sys_futex_cmp_requeue(void *uaddr1, void *uaddr2, unsigned int nr_wake,
			unsigned int nr_requeue, unsigned long cmpval, unsigned long flags);

Where flags:

  - has 2 bits for size: 8,16,32,64
  - has 2 more bits for size (requeue) ??
  - has ... bits for clocks
  - has private/shared
  - has numa


This does not provide BITSET functionality, as I found no use in glibc.
Both wait and wake have arguments left, do we needs this?

For NUMA I propose that when NUMA_FLAG is set, uaddr-4 will be 'int
node_id', with the following semantics:

 - on WAIT, node_id is read and when 0 <= node_id <= nr_nodes, is
   directly used to index into per-node hash-tables. When -1, it is
   replaced by the current node_id and an smp_mb() is issued before we
   load and compare the @uaddr.

 - on WAKE/REQUEUE, it is an immediate index.

Any invalid value with result in EINVAL.


Then later, we can look at doing sys_futex_{,un}lock_{,pi}(), which have
all the mind-meld associated with robust and PI and possibly optimistic
spinning etc.

Opinions?
