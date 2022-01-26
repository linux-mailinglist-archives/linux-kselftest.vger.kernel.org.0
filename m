Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5B149C4D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 09:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbiAZIDj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 03:03:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56190 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiAZIDj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 03:03:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3FC5B80E58;
        Wed, 26 Jan 2022 08:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DBBC340E3;
        Wed, 26 Jan 2022 08:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643184216;
        bh=+vHH6coBn+fxyHOUtpoTMk9tkgCZPRFerUEzgh3lC0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqneUEtDGDJuawtt4SeTc2xgeRMWSuDfz7221pvgZgzE/Hbz5WqBA4L7U2b4ksZBM
         W3uPKQ/98bUEYNleUcCSuSuM3RA5lQvgBPK7MERY8oZjHuzo7WUMAhyVQa4KmJ1kEh
         MXrpJLDDKqkGdk3uGT5XgSz9ZUyAmN4BxAXwKVrRrBCgjx70bWGj74oGZ1W66Ypcs6
         fxg8i0UFLCMIf3JXciiOKRnpAY9kZk41FKgDj2hV5OUxSmVNtUpDwDEwh8maVOVGmC
         5OE/PNGoEXw4PAt8hGfw5s0wGhmEurmz7IE0V0IpT34+JZrRFoO/nBQRmZzru9PGTp
         EXCOueL0g0Vqg==
Date:   Wed, 26 Jan 2022 09:03:27 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>, shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>,
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
Message-ID: <20220126080327.4g4pkv3haenxt2m6@wittgenstein>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
 <20220124171253.22072-3-mathieu.desnoyers@efficios.com>
 <20220125122156.v2f5anzcs35i3rii@wittgenstein>
 <1234069751.70438.1643121673355.JavaMail.zimbra@efficios.com>
 <1445357149.71067.1643137248305.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1445357149.71067.1643137248305.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 25, 2022 at 02:00:48PM -0500, Mathieu Desnoyers wrote:
> ----- On Jan 25, 2022, at 9:41 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
> > ----- On Jan 25, 2022, at 7:21 AM, Christian Brauner brauner@kernel.org wrote:
> [...]
> >>>  include/uapi/linux/rseq.h | 17 ++++-------------
> [...]
> >>>  	union {
> >> 
> >> A bit unfortunate we seem to have to keep the union around even though
> >> it's just one field now.
> > 
> > Well, as far as the user-space projects that I know of which use rseq
> > are concerned (glibc, librseq, tcmalloc), those end up with their own
> > copy of the uapi header anyway to deal with the big/little endian field
> > on 32-bit. So I'm very much open to remove the union if we accept that
> > this uapi header is really just meant to express the ABI and is not
> > expected to be used as an API by user-space.
> > 
> > That would mean we also bring a uapi header copy into the kernel
> > rseq selftests as well to minimize the gap between librseq and
> > the kernel sefltests (the kernel sefltests pretty much include a
> > copy of librseq for convenience. librseq is maintained out of tree).
> > 
> > Thoughts ?
> 
> Actually, if we go ahead and remove the union, and replace:
> 
> struct rseq {
>   union {
>     __u64 ptr64;
>   } rseq_cs;
> [...]
> } v;
> 
> by:
> 
> struct rseq {
>   __u64 rseq_cs;
> } v;
> 
> expressions such as these are unchanged:
> 
> - sizeof(v.rseq_cs),
> - &v.rseq_cs,
> - __alignof__(v.rseq_cs),
> - offsetof(struct rseq, rseq_cs).
> 
> So users of the uapi rseq.h (as an API) can still use rseq_abi->rseq_cs before
> and after the change.
> 
> Based on this, I am inclined to remove the union, and just make the rseq_cs field
> a __u64.
> 
> Any objections ?

I do like it fwiw. But since I haven't been heavily involved in the
userspace usage of this I can't speak confidently to the regression
potential of a change like this. But I would think that we should risk
it instead of dragging a pointless union around forever.
