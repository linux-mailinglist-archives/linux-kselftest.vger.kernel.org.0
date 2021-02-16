Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A075A31C873
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Feb 2021 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhBPJ5U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Feb 2021 04:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhBPJ5S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Feb 2021 04:57:18 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2735AC061574;
        Tue, 16 Feb 2021 01:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=G1rJISCtbmEjkZgEkUza1CHcQJlALOsUgrEKGt62Ww0=; b=ITqmpNKLZ91FyiouFCGBCTWmOs
        7sMWLgI50fSxJr25JP3GJS2U8az6ucJFSiedQ4Qo2+o230RH8NNwnYpL6n5xVjOADJWU5zSn62jEJ
        ZduLmaFu/nJkd3yDWNiZjdoX3hDhrHWJTp9UpapAPbS4uttrIxjBdt1iyMSsPzJ/DRKqO1ya1tewI
        JGElFy/xxGQZFzImfhm41Wp+NVWGBImdFFDnT7mJxme55PgDu4rWIz6/nZy1ADzI3Zy1WLyTDi8/c
        uYnk5VR4fMgLcQ81zEb61F/uBgKYvytslkoZQpuqUFKBxUXO9c3Tfzyu6tEzAN0HXAuvkCouDrIgG
        cBP2ZXtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBx5d-0004uh-0t; Tue, 16 Feb 2021 09:56:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC20D3007CD;
        Tue, 16 Feb 2021 10:56:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABB6E2B82AB42; Tue, 16 Feb 2021 10:56:14 +0100 (CET)
Date:   Tue, 16 Feb 2021 10:56:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net
Subject: Re: [RFC PATCH 01/13] futex2: Implement wait and wake functions
Message-ID: <YCuWvlKRXAygNQZP@hirez.programming.kicks-ass.net>
References: <20210215152404.250281-1-andrealmeid@collabora.com>
 <20210215152404.250281-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210215152404.250281-2-andrealmeid@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 15, 2021 at 12:23:52PM -0300, André Almeida wrote:
> Create a new set of futex syscalls known as futex2. This new interface
> is aimed to implement a more maintainable code, while removing obsolete
> features and expanding it with new functionalities.
> 
> Implements wait and wake semantics for futexes, along with the base
> infrastructure for future operations.

> +	futex_table = alloc_large_system_hash("futex2", sizeof(struct futex_bucket),
> +					      futex2_hashsize, 0,
> +					      futex2_hashsize < 256 ? HASH_SMALL : 0,
> +					      &futex_shift, NULL,
> +					      futex2_hashsize, futex2_hashsize);

So why are we implementing a whole second infrastrure and doubling the
memory footprint of all this?

Sure, futex.c is a pain in the ass, but most of that is not because of
the interface, most of it is having to deal with sharing state with
userspace and that being fundamentally unreliable.

Once you want to add {,UN}LOCK{,_PI} and robust futex support, you're
back to it being a giant rats nest of corner cases. Thinking a new
interface can solve any of that is naive.

So while I'm in favour of adding a new interface, I'm not sure I see
benefit of reimplementing the basics, sure it seems simpler now, but
that's because you've not implemented all the 'fun' stuff.
