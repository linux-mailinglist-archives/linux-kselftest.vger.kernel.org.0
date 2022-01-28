Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7081349F5A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 09:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347446AbiA1Iwr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 03:52:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34248 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbiA1Iwg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 03:52:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8637B824F3;
        Fri, 28 Jan 2022 08:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58E4C340E8;
        Fri, 28 Jan 2022 08:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643359953;
        bh=A4ZIq4YD54mut6tILAfqK6qkKR21qOF5XKfRj9haV7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRAb5TSqgtbYl/IuvBdAeio42OQkKV8HONQvLbracpULCcVf4ckEOQIbGpEy89J0y
         Zyn508vIY/LKWJ/gTeXV1neO5E4LYN+y8aSu52Yzlr5bksmAye+T3h8/+vHfR8WSO0
         CL2shUlnt0Xwoj4sB3n0oJ9TmcvYZPhgYb9oEKGtzKQknZnVtC4sXOVUivG+h8RC6E
         t3rDMlLGsG5VPY7IdKsbx9lKnQGH231ls8WgalFLUDLpBZuQt2QpmwW34FGv+Jkp4/
         8VGzOzi+aBYIleGYPrdjQRnhPpdkGn2bx1Cgg9o+asYslsEXSCFaO8VwkzvwAl02fl
         3MaBw8qE9fawg==
Date:   Fri, 28 Jan 2022 09:52:24 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [RFC PATCH v2] rseq: Remove broken uapi field layout on 32-bit
 little endian
Message-ID: <20220128085224.twfwxz4ttxnaeweo@wittgenstein>
References: <1116876795.2062.1643223596536.JavaMail.zimbra@efficios.com>
 <20220127152720.25898-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127152720.25898-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 27, 2022 at 10:27:20AM -0500, Mathieu Desnoyers wrote:
> The rseq rseq_cs.ptr.{ptr32,padding} uapi endianness handling is
> entirely wrong on 32-bit little endian: a preprocessor logic mistake
> wrongly uses the big endian field layout on 32-bit little endian
> architectures.
> 
> Fortunately, those ptr32 accessors were never used within the kernel,
> and only meant as a convenience for user-space.
> 
> Remove those and replace the whole rseq_cs union by a __u64 type, as
> this is the only thing really needed to express the ABI. Document how
> 32-bit architectures are meant to interact with this field.
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

Looks way cleaner now! Fwiw,
Acked-by: Christian Brauner <brauner@kernel.org>

>  include/uapi/linux/rseq.h | 20 ++++----------------
>  kernel/rseq.c             |  8 ++++----
>  2 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index 9a402fdb60e9..77ee207623a9 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -105,23 +105,11 @@ struct rseq {
>  	 * Read and set by the kernel. Set by user-space with single-copy
>  	 * atomicity semantics. This field should only be updated by the
>  	 * thread which registered this data structure. Aligned on 64-bit.
> +	 *
> +	 * 32-bit architectures should update the low order bits of the
> +	 * rseq_cs field, leaving the high order bits initialized to 0.
>  	 */
> -	union {
> -		__u64 ptr64;
> -#ifdef __LP64__
> -		__u64 ptr;
> -#else
> -		struct {
> -#if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined(__BIG_ENDIAN)
> -			__u32 padding;		/* Initialized to zero. */
> -			__u32 ptr32;
> -#else /* LITTLE */
> -			__u32 ptr32;
> -			__u32 padding;		/* Initialized to zero. */
> -#endif /* ENDIAN */
> -		} ptr;
> -#endif
> -	} rseq_cs;
> +	__u64 rseq_cs;
>  
>  	/*
>  	 * Restartable sequences flags field.
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 6d45ac3dae7f..97ac20b4f738 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -128,10 +128,10 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
>  	int ret;
>  
>  #ifdef CONFIG_64BIT
> -	if (get_user(ptr, &t->rseq->rseq_cs.ptr64))
> +	if (get_user(ptr, &t->rseq->rseq_cs))
>  		return -EFAULT;
>  #else
> -	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
> +	if (copy_from_user(&ptr, &t->rseq->rseq_cs, sizeof(ptr)))
>  		return -EFAULT;
>  #endif
>  	if (!ptr) {
> @@ -217,9 +217,9 @@ static int clear_rseq_cs(struct task_struct *t)
>  	 * Set rseq_cs to NULL.
>  	 */
>  #ifdef CONFIG_64BIT
> -	return put_user(0UL, &t->rseq->rseq_cs.ptr64);
> +	return put_user(0UL, &t->rseq->rseq_cs);
>  #else
> -	if (clear_user(&t->rseq->rseq_cs.ptr64, sizeof(t->rseq->rseq_cs.ptr64)))
> +	if (clear_user(&t->rseq->rseq_cs, sizeof(t->rseq->rseq_cs)))
>  		return -EFAULT;
>  	return 0;
>  #endif
> -- 
> 2.17.1
> 
