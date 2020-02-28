Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2043D174019
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2020 20:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgB1THe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 14:07:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1THe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 14:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=HBMzr5gVP04tC4f4R0gYNtZC362qpqZcYA/7B43qKm0=; b=mAOpR2DontHhiQgwYCuhfeYSlk
        f5xW2Pl5Dr+qa+UVACw5k/O2+derp8VPFWmK7V97i3J/GBFIre2/mEASYcWD904r/nCcQPNS6lr+f
        H77kAaim+yF+TIJ9wKU1fP1OCTUPRhiqLP1w9koAAScMRrN31Bu5CYxTr9GRa2z8mwQnmo/0kkmJx
        J7U8mrlkqGxViI+I3x6wl6IODHpaQN9wT0UDhs4bHbqvw9IhKpMKDxjFCzDRzB8eST7TisoMwEJ+6
        9xdYGw/YLCLz1qAiMs/83p6e0SNJ/Z92AnrrQ83g1KhXpfLmzGAjJioQHRcYt64GdtsH1PeOKc4dE
        iTkCxr3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7kym-0002M6-Ge; Fri, 28 Feb 2020 19:07:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E926300478;
        Fri, 28 Feb 2020 20:05:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9957B2B98DCA1; Fri, 28 Feb 2020 20:07:17 +0100 (CET)
Date:   Fri, 28 Feb 2020 20:07:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kernel@collabora.com, krisman@collabora.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        ryao@gentoo.org, dvhart@infradead.org, mingo@redhat.com,
        z.figura12@gmail.com, steven@valvesoftware.com,
        pgriffais@valvesoftware.com, steven@liquorix.net
Subject: Re: [PATCH v3 1/4] futex: Implement mechanism to wait on any of
 several futexes
Message-ID: <20200228190717.GM18400@hirez.programming.kicks-ass.net>
References: <20200213214525.183689-1-andrealmeid@collabora.com>
 <20200213214525.183689-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213214525.183689-2-andrealmeid@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 13, 2020 at 06:45:22PM -0300, André Almeida wrote:
> @@ -150,4 +153,21 @@ struct robust_list_head {
>    (((op & 0xf) << 28) | ((cmp & 0xf) << 24)		\
>     | ((oparg & 0xfff) << 12) | (cmparg & 0xfff))
>  
> +/*
> + * Maximum number of multiple futexes to wait for
> + */
> +#define FUTEX_MULTIPLE_MAX_COUNT	128
> +
> +/**
> + * struct futex_wait_block - Block of futexes to be waited for
> + * @uaddr:	User address of the futex
> + * @val:	Futex value expected by userspace
> + * @bitset:	Bitset for the optional bitmasked wakeup
> + */
> +struct futex_wait_block {
> +	__u32 __user *uaddr;
> +	__u32 val;
> +	__u32 bitset;
> +};

So I have a problem with this vector layout, it doesn't allow for
per-futex flags, and esp. with that multi-size futex support that
becomes important, but also with the already extand private/shared and
wait_bitset flags this means you cannot have a vector with mixed wait
types.

>  #endif /* _UAPI_LINUX_FUTEX_H */
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 0cf84c8664f2..58cf9eb2b851 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -215,6 +215,8 @@ struct futex_pi_state {
>   * @rt_waiter:		rt_waiter storage for use with requeue_pi
>   * @requeue_pi_key:	the requeue_pi target futex key
>   * @bitset:		bitset for the optional bitmasked wakeup
> + * @uaddr:             userspace address of futex
> + * @uval:              expected futex's value
>   *
>   * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
>   * we can wake only the relevant ones (hashed queues may be shared).
> @@ -237,6 +239,8 @@ struct futex_q {
>  	struct rt_mutex_waiter *rt_waiter;
>  	union futex_key *requeue_pi_key;
>  	u32 bitset;
> +	u32 __user *uaddr;
> +	u32 uval;
>  } __randomize_layout;

That creates a hole for no reason.
