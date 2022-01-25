Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88CD49B3E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 13:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383162AbiAYM0E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 07:26:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58562 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444963AbiAYMWN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 07:22:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D668CB817E6;
        Tue, 25 Jan 2022 12:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FAEC340E0;
        Tue, 25 Jan 2022 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643113324;
        bh=smHriwhZRzmYd06A5ADB/HEiixrqxr9u1mD1v+Ab6Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LlF0UtQmRh0zWYeJwpjdNbcl+auvhufZbOuRQRLHGYYtnDjxug/riXLFSSl2/cva9
         UPOtl3tKKDG+IwxiqznI6SEzWmoqfrbPngwY1qQ7DGH7sOPphdsjmz1jQo+wpj/esN
         7XyHDDOyMXsYMAsvY6AL193unLLV1ALpaqEUnjMeR7mj6z/M7OpaE+XWIDJMOxtJTa
         Mv1qF4fI2pGgMcx2aEIDdzFksSv0g2OUCHdrqcTYxQNkN2gTpYM/xJHfwLHyBVlvPp
         rqv4dxpLUpJHJds/ckQUtLTL/VcVkh1PCwIdZs5FS0EFdtESiG6Z6/bXvIU3Q7zX0C
         /JbVI4irv9Hxg==
Date:   Tue, 25 Jan 2022 13:21:56 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andi Kleen <andi@firstfloor.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 02/15] rseq: Remove broken uapi field layout on
 32-bit little endian
Message-ID: <20220125122156.v2f5anzcs35i3rii@wittgenstein>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
 <20220124171253.22072-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124171253.22072-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 24, 2022 at 12:12:40PM -0500, Mathieu Desnoyers wrote:
> The rseq rseq_cs.ptr.{ptr32,padding} uapi endianness handling is
> entirely wrong on 32-bit little endian: a preprocessor logic mistake
> wrongly uses the big endian field layout on 32-bit little endian
> architectures.
> 
> Fortunately, those ptr32 accessors were never used within the kernel,
> and only meant as a convenience for user-space.
> 
> Remove those and only leave the "ptr64" union field, as this is the only
> thing really needed to express the ABI. Document how 32-bit
> architectures are meant to interact with this "ptr64" union field.
> 
> Fixes: ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union, update includes")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Florian Weimer <fw@deneb.enyo.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-api@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Watson <davejwatson@fb.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: "H . Peter Anvin" <hpa@zytor.com>
> Cc: Andi Kleen <andi@firstfloor.org>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Ben Maurer <bmaurer@fb.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/uapi/linux/rseq.h | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index 9a402fdb60e9..31290f2424a7 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -105,22 +105,13 @@ struct rseq {
>  	 * Read and set by the kernel. Set by user-space with single-copy
>  	 * atomicity semantics. This field should only be updated by the
>  	 * thread which registered this data structure. Aligned on 64-bit.
> +	 *
> +	 * 32-bit architectures should update the low order bits of the
> +	 * rseq_cs.ptr64 field, leaving the high order bits initialized
> +	 * to 0.
>  	 */
>  	union {

A bit unfortunate we seem to have to keep the union around even though
it's just one field now.
