Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2D761EB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 18:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGYQis (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 12:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGYQir (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 12:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535691BE1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690303087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jLj18oLOp3KH/CAHpxuqfsfjyo2yWkCl10MaSaKRkoU=;
        b=EQP3p1cHkEIRiB+y27l5gynle4EIDi6jzweIHfU2USDyWokUAhR1r7OKXTKG+icGw8yPHB
        vx96iXXCf2+7kV1j70maWpDCUGZv1FoDtoni+GO5kL8UftH/+GPGIvO7CHqGNJqyPqJzdU
        ayBHDHfEZcn1XYu7rYdhn0myLOV/7/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-1Gk68m60OaugU8loWBg99g-1; Tue, 25 Jul 2023 12:38:00 -0400
X-MC-Unique: 1Gk68m60OaugU8loWBg99g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27C681044597;
        Tue, 25 Jul 2023 16:38:00 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D021492B01;
        Tue, 25 Jul 2023 16:37:59 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id B479B4018E672; Tue, 25 Jul 2023 13:37:32 -0300 (-03)
Date:   Tue, 25 Jul 2023 13:37:32 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
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
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 20/20] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
Message-ID: <ZL/6THDvmC5mVyBI@tpad>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-21-vschneid@redhat.com>
 <188AEA79-10E6-4DFF-86F4-FE624FD1880F@vmware.com>
 <xhsmh8rb5tui1.mognet@vschneid.remote.csb>
 <2284d0db-f94a-e059-7bd0-bab4f112ed35@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2284d0db-f94a-e059-7bd0-bab4f112ed35@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 10:40:04AM -0700, Dave Hansen wrote:
> On 7/24/23 04:32, Valentin Schneider wrote:
> > AFAICT the only reasonable way to go about the deferral is to prove that no
> > such access happens before the deferred @operation is done. We got to prove
> > that for sync_core() deferral, cf. PATCH 18.
> > 
> > I'd like to reason about it for deferring vunmap TLB flushes:
> > 
> > What addresses in VMAP range, other than the stack, can early entry code
> > access? Yes, the ranges can be checked at runtime, but is there any chance
> > of figuring this out e.g. at build-time?
> 
> Nadav was touching on a very important point: TLB flushes for addresses
> are relatively easy to defer.  You just need to ensure that the CPU
> deferring the flush does an actual flush before it might architecturally
> consume the contents of the flushed entry.
> 
> TLB flushes for freed page tables are another game entirely.  The CPU is
> free to cache any part of the paging hierarchy it wants at any time.

Depend on CONFIG_PAGE_TABLE_ISOLATION=y, which flushes TLB (and page
table caches) on user->kernel and kernel->user context switches ?

So freeing a kernel pagetable page does not require interrupting a CPU 
which is in userspace (therefore does not have visibility into kernel
pagetables).

> It's also free to set accessed and dirty bits at any time, even for
> instructions that may never execute architecturally.
> 
> That basically means that if you have *ANY* freed page table page
> *ANYWHERE* in the page table hierarchy of any CPU at any time ... you're
> screwed.
> 
> There's no reasoning about accesses or ordering.  As soon as the CPU
> does *anything*, it's out to get you.
> 
> You're going to need to do something a lot more radical to deal with
> free page table pages.



