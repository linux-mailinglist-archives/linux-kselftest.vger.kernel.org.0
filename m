Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EBA75C8FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGUOHQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 10:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGUOHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 10:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5B3FD;
        Fri, 21 Jul 2023 07:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5506061B68;
        Fri, 21 Jul 2023 14:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E85C433C9;
        Fri, 21 Jul 2023 14:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689948432;
        bh=bTZdyxvTtZgnsZIW0qXy4zcErrTkNn0mTmm4UjRN+Vs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qESCCl0+iQuLHfyRueHqahM4vVWNdMg3ivuHV7vx8jYnR+7wPhZY8zxBCOR+/Q7B+
         2IPqxdHva9fDbtK4KqaE5essvLqJZfMMdcrOaEJ3xhA3+GEUDjErJQc6WDsvXH9Xlm
         O6YzicfTK43iABbFokQ3yq+4TDo36v7PF4hQja1WkvfmXc0aNeDxLQ9vOWQRnGz6oj
         iqngu9qEVKyMUnuFoOVpmT/28R7PGzE/wwLhLFdaUMMrBB2UKzWO32+2kb4cjenWuF
         m1LGc9DZmuhDAnlSnF/QuDXgHZ1aW7hzcn+NKl/cPSU3dCp6K2wLYJ+cXIlglx9lqg
         Rr41b98rrUu8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 503BDCE097F; Fri, 21 Jul 2023 07:07:12 -0700 (PDT)
Date:   Fri, 21 Jul 2023 07:07:12 -0700
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
Message-ID: <7d2fdbb7-e574-40e8-8561-40a3873abc88@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-18-vschneid@redhat.com>
 <24b55289-1c35-41cc-9ad3-baa957f1c9cb@paulmck-laptop>
 <5143d0a9-bc02-4b9a-8613-2383bfdee35c@paulmck-laptop>
 <xhsmhmszpu24i.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhmszpu24i.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 21, 2023 at 08:58:53AM +0100, Valentin Schneider wrote:
> On 20/07/23 21:00, Paul E. McKenney wrote:
> > On Thu, Jul 20, 2023 at 12:53:05PM -0700, Paul E. McKenney wrote:
> >> On Thu, Jul 20, 2023 at 05:30:53PM +0100, Valentin Schneider wrote:
> >> > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11 b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
> >> > new file mode 100644
> >> > index 0000000000000..aa7274efd9819
> >> > --- /dev/null
> >> > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
> >> > @@ -0,0 +1,19 @@
> >> > +CONFIG_SMP=y
> >> > +CONFIG_NR_CPUS=8
> >> > +CONFIG_PREEMPT_NONE=n
> >> > +CONFIG_PREEMPT_VOLUNTARY=y
> >> > +CONFIG_PREEMPT=n
> >> > +CONFIG_PREEMPT_DYNAMIC=n
> >> > +#CHECK#CONFIG_TREE_RCU=y
> >> > +CONFIG_HZ_PERIODIC=n
> >> > +CONFIG_NO_HZ_IDLE=n
> >> > +CONFIG_NO_HZ_FULL=y
> >> > +CONFIG_RCU_TRACE=y
> >> > +CONFIG_RCU_FANOUT=4
> >> > +CONFIG_RCU_FANOUT_LEAF=3
> >> > +CONFIG_DEBUG_LOCK_ALLOC=n
> >> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> >> > +CONFIG_RCU_EXPERT=y
> >> > +CONFIG_RCU_EQS_DEBUG=y
> >> > +CONFIG_RCU_LAZY=y
> >> > +CONFIG_RCU_DYNTICKS_BITS=2
> >>
> >> Why not just add this last line to the existing TREE04 scenario?
> >> That would ensure that it gets tested regularly without extending the
> >> time required to run a full set of rcutorture tests.
> >
> > Please see below for the version of this patch that I am running overnight
> > tests with.  Does this one work for you?
> 
> Yep that's fine with me. I only went with a separate test file as wasn't
> sure how new test options should be handled (merged into existing tests vs
> new tests created), and didn't want to negatively impact TREE04 or
> TREE06. If merging into TREE04 is preferred, then I'll do just that and
> carry this path moving forwards.

Things worked fine for this one-hour-per-scenario test run on my laptop,
except for the CONFIG_SMP=n runs, which all got build errors like the
following.

							Thanx, Paul

------------------------------------------------------------------------

In file included from ./include/linux/container_of.h:5,
                 from ./include/linux/list.h:5,
                 from ./include/linux/swait.h:5,
                 from ./include/linux/completion.h:12,
                 from ./include/linux/crypto.h:15,
                 from arch/x86/kernel/asm-offsets.c:9:
./include/linux/context_tracking_state.h:56:61: error: ‘struct context_tracking’ has no member named ‘state’
   56 | #define CT_STATE_SIZE (sizeof(((struct context_tracking *)0)->state) * BITS_PER_BYTE)
      |                                                             ^~
./include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
./include/linux/context_tracking_state.h:73:1: note: in expansion of macro ‘static_assert’
   73 | static_assert((CONTEXT_STATE_END + 1 - CONTEXT_STATE_START) +
      | ^~~~~~~~~~~~~
./include/linux/context_tracking_state.h:61:29: note: in expansion of macro ‘CT_STATE_SIZE’
   61 | #define RCU_DYNTICKS_START (CT_STATE_SIZE - CONFIG_RCU_DYNTICKS_BITS)
      |                             ^~~~~~~~~~~~~
./include/linux/context_tracking_state.h:70:29: note: in expansion of macro ‘RCU_DYNTICKS_START’
   70 | #define CONTEXT_WORK_END   (RCU_DYNTICKS_START - 1)
      |                             ^~~~~~~~~~~~~~~~~~
./include/linux/context_tracking_state.h:74:16: note: in expansion of macro ‘CONTEXT_WORK_END’
   74 |               (CONTEXT_WORK_END  + 1 - CONTEXT_WORK_START) +
      |                ^~~~~~~~~~~~~~~~
./include/linux/context_tracking_state.h:56:61: error: ‘struct context_tracking’ has no member named ‘state’
   56 | #define CT_STATE_SIZE (sizeof(((struct context_tracking *)0)->state) * BITS_PER_BYTE)
      |                                                             ^~
./include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
./include/linux/context_tracking_state.h:73:1: note: in expansion of macro ‘static_assert’
   73 | static_assert((CONTEXT_STATE_END + 1 - CONTEXT_STATE_START) +
      | ^~~~~~~~~~~~~
./include/linux/context_tracking_state.h:62:29: note: in expansion of macro ‘CT_STATE_SIZE’
   62 | #define RCU_DYNTICKS_END   (CT_STATE_SIZE - 1)
      |                             ^~~~~~~~~~~~~
./include/linux/context_tracking_state.h:75:16: note: in expansion of macro ‘RCU_DYNTICKS_END’
   75 |               (RCU_DYNTICKS_END  + 1 - RCU_DYNTICKS_START) ==
      |                ^~~~~~~~~~~~~~~~
./include/linux/context_tracking_state.h:56:61: error: ‘struct context_tracking’ has no member named ‘state’
   56 | #define CT_STATE_SIZE (sizeof(((struct context_tracking *)0)->state) * BITS_PER_BYTE)
      |                                                             ^~
./include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
./include/linux/context_tracking_state.h:73:1: note: in expansion of macro ‘static_assert’
   73 | static_assert((CONTEXT_STATE_END + 1 - CONTEXT_STATE_START) +
      | ^~~~~~~~~~~~~
./include/linux/context_tracking_state.h:61:29: note: in expansion of macro ‘CT_STATE_SIZE’
   61 | #define RCU_DYNTICKS_START (CT_STATE_SIZE - CONFIG_RCU_DYNTICKS_BITS)
      |                             ^~~~~~~~~~~~~
./include/linux/context_tracking_state.h:75:40: note: in expansion of macro ‘RCU_DYNTICKS_START’
   75 |               (RCU_DYNTICKS_END  + 1 - RCU_DYNTICKS_START) ==
      |                                        ^~~~~~~~~~~~~~~~~~
./include/linux/context_tracking_state.h:56:61: error: ‘struct context_tracking’ has no member named ‘state’
   56 | #define CT_STATE_SIZE (sizeof(((struct context_tracking *)0)->state) * BITS_PER_BYTE)
      |                                                             ^~
./include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
./include/linux/context_tracking_state.h:73:1: note: in expansion of macro ‘static_assert’
   73 | static_assert((CONTEXT_STATE_END + 1 - CONTEXT_STATE_START) +
      | ^~~~~~~~~~~~~
./include/linux/context_tracking_state.h:76:15: note: in expansion of macro ‘CT_STATE_SIZE’
   76 |               CT_STATE_SIZE);
      |               ^~~~~~~~~~~~~
./include/linux/context_tracking_state.h:73:15: error: expression in static assertion is not an integer
   73 | static_assert((CONTEXT_STATE_END + 1 - CONTEXT_STATE_START) +
      |               ^
./include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
./include/linux/context_tracking_state.h:73:1: note: in expansion of macro ‘static_assert’
   73 | static_assert((CONTEXT_STATE_END + 1 - CONTEXT_STATE_START) +
      | ^~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:116: arch/x86/kernel/asm-offsets.s] Error 1
make[1]: *** [/home/git/linux-rcu-1/Makefile:1275: prepare0] Error 2
make[1]: *** Waiting for unfinished jobs....
  LD      /home/git/linux-rcu-1/tools/objtool/objtool-in.o
  LINK    /home/git/linux-rcu-1/tools/objtool/objtool
make: *** [Makefile:234: __sub-make] Error 2
