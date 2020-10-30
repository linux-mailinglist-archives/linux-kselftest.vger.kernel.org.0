Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B292A0A98
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 17:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgJ3QBB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 12:01:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:50300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgJ3QBB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 12:01:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604073659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQDohgUNVV/smdMN61E32dwYNdiCQiMPZhVZGxPEY3k=;
        b=uPyOddKRCOXN7qNmJnCPkgsnsGtS8zHkzaD/Ov/bF6SFvR/e6gjUYWsQKykMiJk+q00tfX
        qXQhxtiYLlL7TjN/BB4ysVgRRuW7XiXZMQDRHP/cwsTCt07dMgd0udk/hRY+nnsAEhHtS5
        9SVdMCh8QG7r9NsVQR4G617kldP7jog=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80361B471;
        Fri, 30 Oct 2020 16:00:59 +0000 (UTC)
Date:   Fri, 30 Oct 2020 17:00:58 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 1/4] prandom.h: add *_state variant of prandom_u32_max
Message-ID: <20201030160058.GB20201@alley>
References: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
 <20201025214842.5924-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025214842.5924-2-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun 2020-10-25 22:48:39, Rasmus Villemoes wrote:
> It is useful for test modules that make use of random numbers to allow
> the exact same series of test cases to be repeated (e.g., after fixing
> a bug in the code being tested). For that, the test module needs to
> obtain its random numbers from a private state that can be seeded by a
> known seed, e.g. given as a module parameter (and using a random seed
> when that parameter is not given).
> 
> There's a few test modules I'm going to modify to follow that
> scheme. As preparation, add a _state variant of the existing
> prandom_u32_max(), and for convenience, also add a variant that
> produces a value in a given range.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/linux/prandom.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/include/linux/prandom.h b/include/linux/prandom.h
> index aa16e6468f91e79e1f31..58ffcd56c705be34fb98 100644
> --- a/include/linux/prandom.h
> +++ b/include/linux/prandom.h
> @@ -46,6 +46,35 @@ static inline u32 prandom_u32_max(u32 ep_ro)
>  	return (u32)(((u64) prandom_u32() * ep_ro) >> 32);
>  }
>  
> +/**
> + * prandom_u32_max_state - get pseudo-random number in internal [0, hi)

s/internal/interval/

> + *
> + * Like prandom_u32_max, but use the given state structure.
> + * @state: pointer to state structure
> + * @hi: (exclusive) upper bound
> + *
> + * Exception: If @hi == 0, this returns 0.
> + */
> +static inline u32 prandom_u32_max_state(struct rnd_state *state, u32 hi)
> +{
> +	return ((u64)prandom_u32_state(state) * hi) >> 32;
> +}
> +
> +/**
> + * prandom_u32_range_state - get pseudo-random number in internal [lo, hi)

same here

> + *
> + * @state: pointer to state structure
> + * @lo: (inclusive) lower bound
> + * @hi: (exclusive) upper bound
> + *
> + * Exception: If @lo == @hi, this returns @lo. Results are unspecified
> + * for @lo > @hi.
> + */
> +static inline u32 prandom_u32_range_state(struct rnd_state *state, u32 lo, u32 hi)
> +{
> +	return lo + prandom_u32_max_state(state, hi - lo);
> +}

With the above typo fixes:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Well, I guess that we need ack from Willy.

Best Regards,
Petr
