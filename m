Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91B575FA39
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGXOwm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 10:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjGXOwl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 10:52:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DBF10D7;
        Mon, 24 Jul 2023 07:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DBB3611F6;
        Mon, 24 Jul 2023 14:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA815C433C8;
        Mon, 24 Jul 2023 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690210353;
        bh=Io85B1vzGj1NiepBNP1CXkgl9j43eYMLYiUZyMtHevU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJj9nVWeVnJDFBR0XVDtKFcRx4DdPvYzBxJs7NdyqhCdkyJSi7ns/QunyuF5T7ps6
         XU2A2MDFy7UQQzJsIx/xDqLe0FliBY/Oeg0aB/OquAS8cepo48SytLWwhoRHBnqAgE
         wTZhFOxngaubHLo/KhuNmg/icDkWf3KABmSQcw7hRGodIB5PblbvuCT6kpl36W6FZr
         hIH+s80Togjk4lAfltww4D/tmAcJlqIFj1q84XSHWsxVyk2brxNcyWdq/AUnuQb02p
         QLpBDuBflcJsU3fMXLT8vIMOo2OPS1Po+gVqEtzb2kBqqlYChJ+9nWv8THywbJoX77
         fSGCA/VpqlDFg==
Date:   Mon, 24 Jul 2023 16:52:19 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
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
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 15/20] context-tracking: Introduce work deferral
 infrastructure
Message-ID: <ZL6QI4mV-NKlh4Ox@localhost.localdomain>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-16-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720163056.2564824-16-vschneid@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Le Thu, Jul 20, 2023 at 05:30:51PM +0100, Valentin Schneider a écrit :
> +enum ctx_state {
> +	/* Following are values */
> +	CONTEXT_DISABLED	= -1,	/* returned by ct_state() if unknown */
> +	CONTEXT_KERNEL		= 0,
> +	CONTEXT_IDLE		= 1,
> +	CONTEXT_USER		= 2,
> +	CONTEXT_GUEST		= 3,
> +	CONTEXT_MAX             = 4,
> +};
> +
> +/*
> + * We cram three different things within the same atomic variable:
> + *
> + *                CONTEXT_STATE_END                        RCU_DYNTICKS_END
> + *                         |       CONTEXT_WORK_END                |
> + *                         |               |                       |
> + *                         v               v                       v
> + *         [ context_state ][ context work ][ RCU dynticks counter ]
> + *         ^                ^               ^
> + *         |                |               |
> + *         |        CONTEXT_WORK_START      |
> + * CONTEXT_STATE_START              RCU_DYNTICKS_START

Should the layout be displayed in reverse? Well at least I always picture
bitmaps in reverse, that's probably due to the direction of the shift arrows.
Not sure what is the usual way to picture it though...

> + */
> +
> +#define CT_STATE_SIZE (sizeof(((struct context_tracking *)0)->state) * BITS_PER_BYTE)
> +
> +#define CONTEXT_STATE_START 0
> +#define CONTEXT_STATE_END   (bits_per(CONTEXT_MAX - 1) - 1)

Since you have non overlapping *_START symbols, perhaps the *_END
are superfluous?

> +
> +#define RCU_DYNTICKS_BITS  (IS_ENABLED(CONFIG_CONTEXT_TRACKING_WORK) ? 16 : 31)
> +#define RCU_DYNTICKS_START (CT_STATE_SIZE - RCU_DYNTICKS_BITS)
> +#define RCU_DYNTICKS_END   (CT_STATE_SIZE - 1)
> +#define RCU_DYNTICKS_IDX   BIT(RCU_DYNTICKS_START)

Might be the right time to standardize and fix our naming:

CT_STATE_START,
CT_STATE_KERNEL,
CT_STATE_USER,
...
CT_WORK_START,
CT_WORK_*,
...
CT_RCU_DYNTICKS_START,
CT_RCU_DYNTICKS_IDX

> +bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
> +{
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> +	unsigned int old;
> +	bool ret = false;
> +
> +	preempt_disable();
> +
> +	old = atomic_read(&ct->state);
> +	/*
> +	 * Try setting the work until either
> +	 * - the target CPU no longer accepts any more deferred work
> +	 * - the work has been set
> +	 *
> +	 * NOTE: CONTEXT_GUEST intersects with CONTEXT_USER and CONTEXT_IDLE
> +	 * as they are regular integers rather than bits, but that doesn't
> +	 * matter here: if any of the context state bit is set, the CPU isn't
> +	 * in kernel context.
> +	 */
> +	while ((old & (CONTEXT_GUEST | CONTEXT_USER | CONTEXT_IDLE)) && !ret)

That may still miss a recent entry to userspace due to the first plain read, ending
with an undesired interrupt.

You need at least one cmpxchg. Well, of course that stays racy by nature because
between the cmpxchg() returning CONTEXT_KERNEL and the actual IPI raised and
received, the remote CPU may have gone to userspace already. But still it limits
a little the window.

Thanks.

> +		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CONTEXT_WORK_START));
> +
> +	preempt_enable();
> +	return ret;
> +}
> +#else
> +static __always_inline void ct_work_flush(unsigned long work) { }
> +static __always_inline void ct_work_clear(struct context_tracking *ct) { }
> +#endif
> +
>  /*
>   * Record entry into an extended quiescent state.  This is only to be
>   * called when not already in an extended quiescent state, that is,
> @@ -88,7 +133,8 @@ static noinstr void ct_kernel_exit_state(int offset)
>  	 * next idle sojourn.
>  	 */
>  	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
> -	seq = ct_state_inc(offset);
> +	seq = ct_state_inc_clear_work(offset);
> +
>  	// RCU is no longer watching.  Better be in extended quiescent state!
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & RCU_DYNTICKS_IDX));
>  }
> @@ -100,7 +146,7 @@ static noinstr void ct_kernel_exit_state(int offset)
>   */
>  static noinstr void ct_kernel_enter_state(int offset)
>  {
> -	int seq;
> +	unsigned long seq;
>  
>  	/*
>  	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
> @@ -108,6 +154,7 @@ static noinstr void ct_kernel_enter_state(int offset)
>  	 * critical section.
>  	 */
>  	seq = ct_state_inc(offset);
> +	ct_work_flush(seq);
>  	// RCU is now watching.  Better not be in an extended quiescent state!
>  	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & RCU_DYNTICKS_IDX));
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index bae8f11070bef..fdb266f2d774b 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -181,6 +181,11 @@ config CONTEXT_TRACKING_USER_FORCE
>  	  Say N otherwise, this option brings an overhead that you
>  	  don't want in production.
>  
> +config CONTEXT_TRACKING_WORK
> +	bool
> +	depends on HAVE_CONTEXT_TRACKING_WORK && CONTEXT_TRACKING_USER
> +	default y
> +
>  config NO_HZ
>  	bool "Old Idle dynticks config"
>  	help
> -- 
> 2.31.1
> 
