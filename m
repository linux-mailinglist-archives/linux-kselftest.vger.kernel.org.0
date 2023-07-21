Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E9575C92B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 16:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGUOKH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 10:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGUOKF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 10:10:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7170CE;
        Fri, 21 Jul 2023 07:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6558E6195D;
        Fri, 21 Jul 2023 14:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39B4C433C7;
        Fri, 21 Jul 2023 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689948603;
        bh=mqpc+bgxfipMEEmdMi0c2/ZJlESRyidyP20iwu1ubiU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mwXJ4tWAGVS1YQv279yKam6lNor4fbv+EyYgPE9RKEXpJy6cXNZvFlP/KKxzKOTcB
         +lqGPmG2ffZZ0Efx0S0TqnBE8IaMzk2MnCLGRhRMBEWpOJudId0i07k3cmP/nZVUaq
         SHQPI6oYI5J2Ttnh4Enh9amoPJh7ypEjFICnaRQdDw7U29St7RlFkhJ+D7ihhqnWOv
         xJjOEA3EUwNJAeTjNQJuuLgeXIWPSt3vBhtsEYX+1h3uDFaCPOyDIo8LBS3B298nuq
         TrABcFKxVgUZNpuCKIaTgVNCGRGx0+QB9sHGcYJxF9jYzQi65FyVdVCSm+wLi6c1Xq
         S45vKWYuRh3Iw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E67BCE097F; Fri, 21 Jul 2023 07:10:03 -0700 (PDT)
Date:   Fri, 21 Jul 2023 07:10:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
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
Subject: Re: [RFC PATCH v2 16/20] rcu: Make RCU dynticks counter size
 configurable
Message-ID: <28d4abb7-8496-45ec-b270-ea2b6164537b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-17-vschneid@redhat.com>
 <xhsmhjzutu18u.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhjzutu18u.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 21, 2023 at 09:17:53AM +0100, Valentin Schneider wrote:
> On 20/07/23 17:30, Valentin Schneider wrote:
> > index bdd7eadb33d8f..1ff2aab24e964 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -332,4 +332,37 @@ config RCU_DOUBLE_CHECK_CB_TIME
> >         Say Y here if you need tighter callback-limit enforcement.
> >         Say N here if you are unsure.
> >
> > +config RCU_DYNTICKS_RANGE_BEGIN
> > +	int
> > +	depends on !RCU_EXPERT
> > +	default 31 if !CONTEXT_TRACKING_WORK
> 
> You'll note that this should be 30 really, because the lower *2* bits are
> taken by the context state (CONTEXT_GUEST has a value of 3).
> 
> This highlights the fragile part of this: the Kconfig values are hardcoded,
> but they depend on CT_STATE_SIZE, CONTEXT_MASK and CONTEXT_WORK_MAX. The
> static_assert() will at least capture any misconfiguration, but having that
> enforced by the actual Kconfig ranges would be less awkward.
> 
> Do we currently have a way of e.g. making a Kconfig file depend on and use
> values generated by a C header?

Why not just have something like a boolean RCU_DYNTICKS_TORTURE Kconfig
option and let the C code work out what the number of bits should be?

I suppose that there might be a failure whose frequency depended on
the number of bits, which might be an argument for keeping something
like RCU_DYNTICKS_RANGE_BEGIN for fault isolation.  But still using
RCU_DYNTICKS_TORTURE for normal testing.

Thoughts?

							Thanx, Paul
