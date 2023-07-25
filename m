Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84623761A25
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGYNjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 09:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGYNjn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 09:39:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6D2BE;
        Tue, 25 Jul 2023 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=AqhhXygkgYbNIUoMbam6nKKv+65xhkGjy3g6V0cI3YE=; b=hU0juKjhnKQNMPcWxGTglXF1kD
        xBeNXFwO6bnr7cRSGSRHFONAWDnx+6524lg/8FLjxvB00LuNdyZOyZfcpfPUYsI9/m4/wxx3XADTa
        IhO/K2oW4GRTfGIQ608wBXqm9GjRT1kOVe8WYSkXmy8R6Xy4Kmol7TQFesj4k3+2Ucyms3qwYaJY7
        jLJUnGnJNEcVrXPXgDy1IK44aIJfxkS+/FqW0+yWhU8qeyJh4cu9RXzeK/Gb1Zl8copgtkKLHoxDF
        JMGM13VNEgUa451vGA877Yf6lodJWN7+QQiNx8EG7C7Z5r9rUdrUihkgPelx/JvMdyFS4IfyITpst
        ZPZuwbig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOIGH-004AGP-0U;
        Tue, 25 Jul 2023 13:39:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C0A9B300095;
        Tue, 25 Jul 2023 15:39:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A54B92CCD6B85; Tue, 25 Jul 2023 15:39:36 +0200 (CEST)
Date:   Tue, 25 Jul 2023 15:39:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
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
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
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
Subject: Re: [RFC PATCH v2 18/20] context_tracking,x86: Defer kernel text
 patching IPIs
Message-ID: <20230725133936.GM3765278@hirez.programming.kicks-ass.net>
References: <20230720163056.2564824-19-vschneid@redhat.com>
 <6EBAEEED-6F38-472D-BA31-9C61179EFA2F@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6EBAEEED-6F38-472D-BA31-9C61179EFA2F@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 25, 2023 at 06:49:45AM -0400, Joel Fernandes wrote:
> Interesting series Valentin. Some high-level question/comments on this one:
> 
> > On Jul 20, 2023, at 12:34 PM, Valentin Schneider <vschneid@redhat.com> wrote:
> > 
> > ﻿text_poke_bp_batch() sends IPIs to all online CPUs to synchronize
> > them vs the newly patched instruction. CPUs that are executing in userspace
> > do not need this synchronization to happen immediately, and this is
> > actually harmful interference for NOHZ_FULL CPUs.
> 
> Does the amount of harm not correspond to practical frequency of text_poke? 
> How often does instruction patching really happen? If it is very infrequent
> then I am not sure if it is that harmful.

Well, it can happen quite a bit, also from things people would not
typically 'expect' it.

For instance, the moment you create the first per-task perf event we
frob some jump-labels (and again some second after the last one goes
away).

The same for a bunch of runtime network configurations.

> > As the synchronization IPIs are sent using a blocking call, returning from
> > text_poke_bp_batch() implies all CPUs will observe the patched
> > instruction(s), and this should be preserved even if the IPI is deferred.
> > In other words, to safely defer this synchronization, any kernel
> > instruction leading to the execution of the deferred instruction
> > sync (ct_work_flush()) must *not* be mutable (patchable) at runtime.
> 
> If it is not infrequent, then are you handling the case where userland
> spends multiple seconds before entering the kernel, and all this while
> the blocking call waits? Perhaps in such situation you want the real IPI
> to be sent out instead of the deferred one?

Please re-read what Valentin wrote -- nobody is waiting on anything.
