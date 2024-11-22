Return-Path: <linux-kselftest+bounces-22448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6FC9D5F49
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 13:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F9C1F23690
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E42C1DDC39;
	Fri, 22 Nov 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLsIV1EN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5779FE;
	Fri, 22 Nov 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280029; cv=none; b=OTiXQYkEFzwLA8p1NN5AJ7lAZAgSOXtqLEYb18MEfU1ACC/o63ITMzJArz9Q4cqax6qdWxRoAc1lPZzMPv98XOrrSTtQzgsqvsD5HQ/JbZof8aqt98fN1Mw1q5iAITM17gOGmV20ah7tWpcEMzx56hjxz7YNvOpD6pJF7tSusdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280029; c=relaxed/simple;
	bh=//jUWkPnDeKfRmE6z8C5sOx1U9xYZqa2EA/4iJb5IuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njyYMcD/kE7opgsJmCEXUXamBRk/zIgkc/9xBMog3sQxSZ9+ktAi7pdr9sxKlch82xigAhNKTZfLNaEKFFV5iiF4NXgJlzyFDbylzxC+8/3ro1gi4CzIt+1wEX+eZaYtaIOwTrysCc4IGDBiYSP4VUF02mVN7yhsvvMILpl4wZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLsIV1EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFF6C4CED0;
	Fri, 22 Nov 2024 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732280028;
	bh=//jUWkPnDeKfRmE6z8C5sOx1U9xYZqa2EA/4iJb5IuM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oLsIV1ENlDGQftG6yQCY/EpB8zrqkKUT69pzDQJAY3XLR/SLc9/EzLWeMHn/hEC/6
	 doErMA7pZLaVEVBhEGHzz2odGEodVKCFpUbAzdH2pAE8DDR+lN5c9GZ1a85l5/sJRr
	 Sn7IR4Zfx2w6+8N8tybnxkwBu6Bsiu5C4+jZagfffWrXBp3EL9m9dsszw5bOIUmaN7
	 BxdpzTfTeVqT0QwaITMc1JuHtXaBrB2T/JN8h0YMAROrH4EXxK/bd59UId0xQ7urbI
	 Qfn8CQlmUWeUnIX0X9E4EL79apdDUuTCctH1NpKd8NulSl8gmRRgaSTGqBQs8eMQTT
	 Q1AvSRmge2OIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 14E3BCE0BC4; Fri, 22 Nov 2024 04:53:48 -0800 (PST)
Date: Fri, 22 Nov 2024 04:53:48 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	x86@kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>, Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v3 04/15] rcu: Add a small-width RCU watching counter
 debug option
Message-ID: <f85c0f84-7ae3-4fb5-889a-d9b83f9603fe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241119153502.41361-1-vschneid@redhat.com>
 <20241119153502.41361-5-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119153502.41361-5-vschneid@redhat.com>

On Tue, Nov 19, 2024 at 04:34:51PM +0100, Valentin Schneider wrote:
> A later commit will reduce the size of the RCU watching counter to free up
> some bits for another purpose. Paul suggested adding a config option to
> test the extreme case where the counter is reduced to its minimum usable
> width for rcutorture to poke at, so do that.
> 
> Make it only configurable under RCU_EXPERT. While at it, add a comment to
> explain the layout of context_tracking->state.
> 
> Link: http://lore.kernel.org/r/4c2cb573-168f-4806-b1d9-164e8276e66a@paulmck-laptop
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Looks good, one help-text nit below.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/context_tracking_state.h | 44 ++++++++++++++++++++++----
>  kernel/rcu/Kconfig.debug               | 14 ++++++++
>  2 files changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index 7b8433d5a8efe..0b81248aa03e2 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -18,12 +18,6 @@ enum ctx_state {
>  	CT_STATE_MAX		= 4,
>  };
>  
> -/* Odd value for watching, else even. */
> -#define CT_RCU_WATCHING CT_STATE_MAX
> -
> -#define CT_STATE_MASK (CT_STATE_MAX - 1)
> -#define CT_RCU_WATCHING_MASK (~CT_STATE_MASK)
> -
>  struct context_tracking {
>  #ifdef CONFIG_CONTEXT_TRACKING_USER
>  	/*
> @@ -44,9 +38,45 @@ struct context_tracking {
>  #endif
>  };
>  
> +/*
> + * We cram two different things within the same atomic variable:
> + *
> + *                     CT_RCU_WATCHING_START  CT_STATE_START
> + *                                |                |
> + *                                v                v
> + *     MSB [ RCU watching counter ][ context_state ] LSB
> + *         ^                       ^
> + *         |                       |
> + * CT_RCU_WATCHING_END        CT_STATE_END
> + *
> + * Bits are used from the LSB upwards, so unused bits (if any) will always be in
> + * upper bits of the variable.
> + */
>  #ifdef CONFIG_CONTEXT_TRACKING
> +#define CT_SIZE (sizeof(((struct context_tracking *)0)->state) * BITS_PER_BYTE)
> +
> +#define CT_STATE_WIDTH bits_per(CT_STATE_MAX - 1)
> +#define CT_STATE_START 0
> +#define CT_STATE_END   (CT_STATE_START + CT_STATE_WIDTH - 1)
> +
> +#define CT_RCU_WATCHING_MAX_WIDTH (CT_SIZE - CT_STATE_WIDTH)
> +#define CT_RCU_WATCHING_WIDTH     (IS_ENABLED(CONFIG_RCU_DYNTICKS_TORTURE) ? 2 : CT_RCU_WATCHING_MAX_WIDTH)
> +#define CT_RCU_WATCHING_START     (CT_STATE_END + 1)
> +#define CT_RCU_WATCHING_END       (CT_RCU_WATCHING_START + CT_RCU_WATCHING_WIDTH - 1)
> +#define CT_RCU_WATCHING           BIT(CT_RCU_WATCHING_START)
> +
> +#define CT_STATE_MASK        GENMASK(CT_STATE_END,        CT_STATE_START)
> +#define CT_RCU_WATCHING_MASK GENMASK(CT_RCU_WATCHING_END, CT_RCU_WATCHING_START)
> +
> +#define CT_UNUSED_WIDTH (CT_RCU_WATCHING_MAX_WIDTH - CT_RCU_WATCHING_WIDTH)
> +
> +static_assert(CT_STATE_WIDTH        +
> +	      CT_RCU_WATCHING_WIDTH +
> +	      CT_UNUSED_WIDTH       ==
> +	      CT_SIZE);
> +
>  DECLARE_PER_CPU(struct context_tracking, context_tracking);
> -#endif
> +#endif	/* CONFIG_CONTEXT_TRACKING */
>  
>  #ifdef CONFIG_CONTEXT_TRACKING_USER
>  static __always_inline int __ct_state(void)
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 9b0b52e1836fa..8dc505d841f8d 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -168,4 +168,18 @@ config RCU_STRICT_GRACE_PERIOD
>  	  when looking for certain types of RCU usage bugs, for example,
>  	  too-short RCU read-side critical sections.
>  
> +
> +config RCU_DYNTICKS_TORTURE
> +	bool "Minimize RCU dynticks counter size"
> +	depends on RCU_EXPERT
> +	default n
> +	help
> +	  This option controls the width of the dynticks counter.
> +
> +	  Lower values will make overflows more frequent, which will increase
> +	  the likelihood of extending grace-periods. This option sets the width
> +	  to its minimum usable value.

The second sentence ("Lower values ...") sounds at first reading like
this Kconfig option directly controls the width.  The third sentence sets
things straight, but the reader might well be irretrievably confused by
that point.  How about something like this instead?

	help
	  This option sets the width of the dynticks counter to its
	  minimum usable value.  This minimum width greatly increases
	  the probability of flushing out bugs involving counter wrap,
	  but it also increases the probability of extending grace period
	  durations.  This Kconfig option should therefore be avoided in
	  production due to the consequent increased probability of OOMs.

	  This has no value for production and is only for testing.

>  endmenu # "RCU Debugging"
> -- 
> 2.43.0
> 

