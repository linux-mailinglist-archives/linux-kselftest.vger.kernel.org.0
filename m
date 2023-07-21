Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8F975BD0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 06:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGUEBD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 00:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGUEBB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 00:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246161BC1;
        Thu, 20 Jul 2023 21:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A340F60F75;
        Fri, 21 Jul 2023 04:00:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05771C433C7;
        Fri, 21 Jul 2023 04:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689912059;
        bh=PEby7A9sVGRdb+oOMy8/Qs/8RcDGVrpFztRuZoH+h3A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B7y4CM4CPm5gM42FGswqGfa2Uf3gGEvcmWfb/lcUgej8juYNphZ5h/4slJxmUO6Gt
         gPLWhO3/2a/Z5ljESsclOKvZTJIJOSduYTMFu/bi8VluSExtItl5Bx6f5J8d7nVlMO
         386lWVphJER+giXAPgEbqoDg8/z2BzDHRuZaKsWGvMjJzXP4oGz0sHvbrcNKNac2aB
         6b10sJbP5U+dNDZkFt2BRK/emYxq/A3mQYI4bhXdtCIylrNcmrAGgl/1Vr3Ns03hCe
         Jz8PEOLvwIAHLjilOZtAYhiIeTclmiXt69+/n70rKS+IRv+tb0Ru+fwiPtWla8PHZk
         BmazTVkFzm+ZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 92D25CE09F7; Thu, 20 Jul 2023 21:00:58 -0700 (PDT)
Date:   Thu, 20 Jul 2023 21:00:58 -0700
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
Subject: Re: [RFC PATCH v2 17/20] rcutorture: Add a test config to torture
 test low RCU_DYNTICKS width
Message-ID: <5143d0a9-bc02-4b9a-8613-2383bfdee35c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-18-vschneid@redhat.com>
 <24b55289-1c35-41cc-9ad3-baa957f1c9cb@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b55289-1c35-41cc-9ad3-baa957f1c9cb@paulmck-laptop>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 20, 2023 at 12:53:05PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 20, 2023 at 05:30:53PM +0100, Valentin Schneider wrote:
> > We now have an RCU_EXPORT knob for configuring the size of the dynticks
> > counter: CONFIG_RCU_DYNTICKS_BITS.
> > 
> > Add a torture config for a ridiculously small counter (2 bits). This is ac
> > opy of TREE4 with the added counter size restriction.
> > 
> > Link: http://lore.kernel.org/r/4c2cb573-168f-4806-b1d9-164e8276e66a@paulmck-laptop
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > ---
> >  .../selftests/rcutorture/configs/rcu/TREE11   | 19 +++++++++++++++++++
> >  .../rcutorture/configs/rcu/TREE11.boot        |  1 +
> >  2 files changed, 20 insertions(+)
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
> > 
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11 b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
> > new file mode 100644
> > index 0000000000000..aa7274efd9819
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
> > @@ -0,0 +1,19 @@
> > +CONFIG_SMP=y
> > +CONFIG_NR_CPUS=8
> > +CONFIG_PREEMPT_NONE=n
> > +CONFIG_PREEMPT_VOLUNTARY=y
> > +CONFIG_PREEMPT=n
> > +CONFIG_PREEMPT_DYNAMIC=n
> > +#CHECK#CONFIG_TREE_RCU=y
> > +CONFIG_HZ_PERIODIC=n
> > +CONFIG_NO_HZ_IDLE=n
> > +CONFIG_NO_HZ_FULL=y
> > +CONFIG_RCU_TRACE=y
> > +CONFIG_RCU_FANOUT=4
> > +CONFIG_RCU_FANOUT_LEAF=3
> > +CONFIG_DEBUG_LOCK_ALLOC=n
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> > +CONFIG_RCU_EXPERT=y
> > +CONFIG_RCU_EQS_DEBUG=y
> > +CONFIG_RCU_LAZY=y
> > +CONFIG_RCU_DYNTICKS_BITS=2
> 
> Why not just add this last line to the existing TREE04 scenario?
> That would ensure that it gets tested regularly without extending the
> time required to run a full set of rcutorture tests.

Please see below for the version of this patch that I am running overnight
tests with.  Does this one work for you?

							Thanx, Paul

------------------------------------------------------------------------

commit 1aa13731e665193cd833edac5ebc86a9c3fea2b7
Author: Valentin Schneider <vschneid@redhat.com>
Date:   Thu Jul 20 20:58:41 2023 -0700

    rcutorture: Add a test config to torture test low RCU_DYNTICKS width
    
    We now have an RCU_EXPORT knob for configuring the size of the dynticks
    counter: CONFIG_RCU_DYNTICKS_BITS.
    
    Modify scenario TREE04 to exercise a a ridiculously small counter
    (2 bits).
    
    Link: http://lore.kernel.org/r/4c2cb573-168f-4806-b1d9-164e8276e66a@paulmck-laptop
    Suggested-by: Paul E. McKenney <paulmck@kernel.org>
    Signed-off-by: Valentin Schneider <vschneid@redhat.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
index dc4985064b3a..aa7274efd981 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -16,3 +16,4 @@ CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_RCU_EXPERT=y
 CONFIG_RCU_EQS_DEBUG=y
 CONFIG_RCU_LAZY=y
+CONFIG_RCU_DYNTICKS_BITS=2
