Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B816739F56E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhFHLrY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 07:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhFHLrX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 07:47:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB32AC061789;
        Tue,  8 Jun 2021 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wnXuDaSzTGYZ5h0WV9tmuYOo7bwrW3p7q5WO8BPzujQ=; b=Ys2vp0Pk9YGzIFdmF6/EtYp9ed
        Mpc9y6acdYj3N7S3SWQqOvs0pSlHbfao7WQAtu5/3aN6UFQy3Rbkw3zXHIE8yIuAnArBGtj0d0djU
        9EnIuw/wdRfosmUxwdgo6P9M5ufMH5zo9ELO91ja08AZNYdLAYhAXaM1ZRwjLrsxXcG8rdm/SUcpo
        fULa/yWmHHYq7mfntXLdLjg9cmMab8YOlWs751AIXE6X9nOCgMnWiX6ufj0gM67RZFd8lNCIg6sk9
        rjaBRdd0qrwF1L9GlQ7jf83j+A3uFTAfBIf7IObg1HDb9WKqDlO9JIu6LIoBsXuyXNIBDvKcUMGes
        oO0tdx3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqa9w-004jsb-CJ; Tue, 08 Jun 2021 11:44:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03BF830018A;
        Tue,  8 Jun 2021 13:44:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2BF52011672D; Tue,  8 Jun 2021 13:44:44 +0200 (CEST)
Date:   Tue, 8 Jun 2021 13:44:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrey Semashev <andrey.semashev@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        acme@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>, pgriffais@valvesoftware.com,
        Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
Message-ID: <YL9YLCY9/MkhOW7F@hirez.programming.kicks-ass.net>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
 <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
 <1623114630.pc8fq7r5y9.astroid@bobo.none>
 <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com>
 <YL9Q2tKLZP6GKbHW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL9Q2tKLZP6GKbHW@kroah.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 08, 2021 at 01:13:30PM +0200, Greg KH wrote:
> On Tue, Jun 08, 2021 at 02:03:50PM +0300, Andrey Semashev wrote:
> So what's keeping the futex2 code from doing all that futex1 does so
> that the futex1 code can be deleted internally?

I'd much rather see it the other way around. Much of what futex2 does
can already be done with the futex1 code-base. And then we can add
features on top.

I've been moaning about this for the past many versions, even older
versions actually implemented some of the new features in futex1,
showing it can be done.

We just wanted a saner futex interface because the existing futex
syscall is a monster and making it even worse seemed like a bad idea.

So *again*: please add the new syscalls on top of futex1 and then
extend.  Do not re-implement.
