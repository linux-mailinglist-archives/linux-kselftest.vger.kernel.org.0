Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E066531C8A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Feb 2021 11:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBPKVi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Feb 2021 05:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBPKV1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Feb 2021 05:21:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0EC061786;
        Tue, 16 Feb 2021 02:20:47 -0800 (PST)
Date:   Tue, 16 Feb 2021 11:20:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613470846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7a6EbWhcc1He9imxspIn+eCQuB9DLKRDzdmRL5DBYhk=;
        b=k4Es/RI9TJqS8Whdcbr/nWxt7F9+yGDKNfzTIhTmEvi10ogJrC9YAwuAlPNqs31bwIrH+j
        n2yNtqOubFv7pCKUbcm4qCbP4z11nHgugLmKgkn+pomk6IquLT+LBnA3Z4di8kVovQmeM3
        aybTjJ7bkYPnONMzRsB6ST9v57wwgrGAZJDlpqJ5d1Yt0RuL6pvquLtgeVlMxpA/EUVCLY
        kkdCbZh6gOqN2Ek6I+Ci5MXR2yPdnLBrhZ8/mWYxwvIZ0aaGgBLZ911xuQhFufuvKQfZ5W
        YGyB4aE3SxW/IOS/jOxH2daeEIrPYPOZexBJwOg1Vk9DrAPseT8RCxVUdMReDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613470846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7a6EbWhcc1He9imxspIn+eCQuB9DLKRDzdmRL5DBYhk=;
        b=sLsdW/5TPSKc5o1seFXs0fqEdHWJsS2WlIEPOV9yYyn1ourZEClZobFApUK1pqDqTBSnOK
        ZCjAsNHI4pGke8Bw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
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
Message-ID: <20210216102044.e2cvvqdglqs23yfe@linutronix.de>
References: <20210215152404.250281-1-andrealmeid@collabora.com>
 <20210215152404.250281-2-andrealmeid@collabora.com>
 <YCuWvlKRXAygNQZP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCuWvlKRXAygNQZP@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-02-16 10:56:14 [+0100], Peter Zijlstra wrote:
> So while I'm in favour of adding a new interface, I'm not sure I see
> benefit of reimplementing the basics, sure it seems simpler now, but
> that's because you've not implemented all the 'fun' stuff.

The last attempt tried to hide the updated interface within libc which
did not fly. The global hash state is one of the problems because it
leads to hash collisions of two unrelated locks.
It will get simpler if we go into the kernel for each lock/unlock
operation but this might not very good in terms of performance for locks
which are mostly uncontended. I'm not sure how much we can cheat in
terms of VDSO.

Sebastian
