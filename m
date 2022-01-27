Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA5E49E67F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 16:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbiA0PqP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 10:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243097AbiA0PqO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 10:46:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1FAC061714;
        Thu, 27 Jan 2022 07:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=te34am54aUpFtK+DUx9YCfw5VurpEVmeZCzYybJUFVs=; b=DalpuByIZ+ookpm/OOIdVEWrm8
        WrsrgpLkhUtDWtK3cuAveqIl8AfwAkAqCwSDisxbMD167/Jz32GCvSZSU9py6pLraPF++nCvRA1IX
        1a0pk5i3hpseMlpLiU5qwQK0iai13QM+6jni9uvJO1hY2dRon10HG9pATqfhri7zdNirDNLkJ3254
        jONq5ebPfDhaeBJ/5+Hasnevwiw3NEOY+xfHClosK9XnJc23O19Q9xVeDGMYcYsjUgdnCxVpuU3Oi
        4zigj/i+jaB5hMagavS1VBqHuugcSrpA0t7yKRZTBj8wW5QNbsWl9i1e3V0mwDqLEDhLQqG7VQEj7
        lMspEUOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD6yM-004CiD-C2; Thu, 27 Jan 2022 15:46:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0202F986245; Thu, 27 Jan 2022 16:46:04 +0100 (CET)
Date:   Thu, 27 Jan 2022 16:46:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] rseq uapi and selftest updates
Message-ID: <20220127154604.GQ20638@worktop.programming.kicks-ass.net>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 24, 2022 at 12:12:38PM -0500, Mathieu Desnoyers wrote:
> Mathieu Desnoyers (15):
>   selftests/rseq: introduce own copy of rseq uapi header
>   rseq: Remove broken uapi field layout on 32-bit little endian
>   selftests/rseq: Remove useless assignment to cpu variable
>   selftests/rseq: Remove volatile from __rseq_abi
>   selftests/rseq: Introduce rseq_get_abi() helper
>   selftests/rseq: Introduce thread pointer getters
>   selftests/rseq: Uplift rseq selftests for compatibility with
>     glibc-2.35
>   selftests/rseq: Fix ppc32: wrong rseq_cs 32-bit field pointer on big
>     endian
>   selftests/rseq: Fix ppc32 missing instruction selection "u" and "x"
>     for load/store
>   selftests/rseq: Fix ppc32 offsets by using long rather than off_t
>   selftests/rseq: Fix warnings about #if checks of undefined tokens
>   selftests/rseq: Remove arm/mips asm goto compiler work-around
>   selftests/rseq: Fix: work-around asm goto compiler bugs
>   selftests/rseq: x86-64: use %fs segment selector for accessing rseq
>     thread area
>   selftests/rseq: x86-32: use %gs segment selector for accessing rseq
>     thread area

Thanks, I'll go stick then in sched/core.
