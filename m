Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3931CAAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Feb 2021 13:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBPMoY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Feb 2021 07:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhBPMoU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Feb 2021 07:44:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B760C061574;
        Tue, 16 Feb 2021 04:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uOWdJIPiqLxSLw1FB8DUC17VYXjO4ss7tBRpE+csj60=; b=X/BCEKx2XCpDmibeE6L/Vxn1JF
        I0HPwy3x7sk164lmCWc2/VVuIak2O0QCjpoPVlAwoQgnRGXs5ddZvlE/Etzu0upfMvY65uPksc8Vt
        Yr4QKi7YZ1x1QT1dSIR2s/XXTUaObnfVTSUtIBpr8vic9TNbotQ2PDlFNqk1tqXTuifsOMUOwOdvQ
        7dpVGzO4E/IFTzDPkeQR061UTp5AuTaZFuZKRCH5s5ZEIwu3ksIXfQ0ipVGdTWveMLEYxK37BS2e3
        kU8mcPPdegJuCy7/m7suSsW+8Kfu2xg7JAZw8XJJZB1QX4rqTpfX9zaQYUJXdBDe0fCNaK3jv3gte
        ZF8hRBhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lBzgS-00Greh-7l; Tue, 16 Feb 2021 12:42:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70B9A3059DD;
        Tue, 16 Feb 2021 13:42:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3595C203C0769; Tue, 16 Feb 2021 13:42:26 +0100 (CET)
Date:   Tue, 16 Feb 2021 13:42:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net
Subject: Re: [RFC PATCH 01/13] futex2: Implement wait and wake functions
Message-ID: <YCu9suNwsselodLD@hirez.programming.kicks-ass.net>
References: <20210215152404.250281-1-andrealmeid@collabora.com>
 <20210215152404.250281-2-andrealmeid@collabora.com>
 <YCuWvlKRXAygNQZP@hirez.programming.kicks-ass.net>
 <20210216102044.e2cvvqdglqs23yfe@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216102044.e2cvvqdglqs23yfe@linutronix.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 16, 2021 at 11:20:44AM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-02-16 10:56:14 [+0100], Peter Zijlstra wrote:
> > So while I'm in favour of adding a new interface, I'm not sure I see
> > benefit of reimplementing the basics, sure it seems simpler now, but
> > that's because you've not implemented all the 'fun' stuff.
> 
> The last attempt tried to hide the updated interface within libc which
> did not fly. The global hash state is one of the problems because it
> leads to hash collisions of two unrelated locks.
> It will get simpler if we go into the kernel for each lock/unlock
> operation but this might not very good in terms of performance for locks
> which are mostly uncontended. I'm not sure how much we can cheat in
> terms of VDSO.

I'm sorry, but I'm failing to understand any of that.

How is adding a second global hash going to solve anything? Also, the
LOCK/UNLOCK primitives as we have them today very much rely on a
userspace fast path, and I don't see that changing. Only on contention
do we call into the kernel.

The advantage of the new interface is having that NUMA word along with
the Futex word, in which we can store the node_id for the hash we
stuffed the futex in, which is awesome, but that too doesn't need a
re-implementation of all the basics.

And getting rid of the super multiplexer is also nice.

But re-implementing all the basic stuff again, not so nice.
