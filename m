Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E447449C877
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 12:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbiAZLSs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 06:18:48 -0500
Received: from albireo.enyo.de ([37.24.231.21]:41450 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233442AbiAZLSq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 06:18:46 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 06:18:46 EST
Received: from [172.17.203.2] (port=37899 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1nCgCt-0012zO-1Z; Wed, 26 Jan 2022 11:11:19 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1nCg2p-00078D-Rn; Wed, 26 Jan 2022 12:00:55 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>, shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andi Kleen <andi@firstfloor.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 02/15] rseq: Remove broken uapi field layout on
 32-bit little endian
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
        <20220124171253.22072-3-mathieu.desnoyers@efficios.com>
        <20220125122156.v2f5anzcs35i3rii@wittgenstein>
        <1234069751.70438.1643121673355.JavaMail.zimbra@efficios.com>
        <1445357149.71067.1643137248305.JavaMail.zimbra@efficios.com>
        <20220126080327.4g4pkv3haenxt2m6@wittgenstein>
Date:   Wed, 26 Jan 2022 12:00:55 +0100
In-Reply-To: <20220126080327.4g4pkv3haenxt2m6@wittgenstein> (Christian
        Brauner's message of "Wed, 26 Jan 2022 09:03:27 +0100")
Message-ID: <87fspa92xk.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Christian Brauner:

> On Tue, Jan 25, 2022 at 02:00:48PM -0500, Mathieu Desnoyers wrote:
>> So users of the uapi rseq.h (as an API) can still use
>> rseq_abi->rseq_cs before and after the change.
>> 
>> Based on this, I am inclined to remove the union, and just make the
>> rseq_cs field a __u64.
>> 
>> Any objections ?
>
> I do like it fwiw. But since I haven't been heavily involved in the
> userspace usage of this I can't speak confidently to the regression
> potential of a change like this. But I would think that we should risk
> it instead of dragging a pointless union around forever.

I don't think glibc needs changes for this, it will keep building just
fine.  We'll need to adjust the included kernel header fragment that
could be used by applications in some corner cases, but that's it.
