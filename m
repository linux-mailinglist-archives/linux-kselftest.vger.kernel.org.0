Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5056F75F530
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGXLem (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGXLe0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945FC26A3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690198364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXJhrkLdNOLUHGZbbc+F0hjfqb3hPCsrY6WTn8MVyN8=;
        b=IKMGMDoBf5Q4TRF+J45GToUGxW8KJvD5bGgLyJeeLFh25nplZJDxAd3SInz6BrXVMcuVby
        hYYnA1MfyF7PRcydtsYPxyA9Zv0hniuCao8nXh20+jsSTaAkzAhJk2Wn0xOxzvlNoVm9B7
        dKLPBtMs43iUq3LlMZkcsIFwzQ66bYY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-x-6zLQxpObuRqRbI-hxOlw-1; Mon, 24 Jul 2023 07:32:43 -0400
X-MC-Unique: x-6zLQxpObuRqRbI-hxOlw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-316f39e3e89so2536813f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jul 2023 04:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198362; x=1690803162;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXJhrkLdNOLUHGZbbc+F0hjfqb3hPCsrY6WTn8MVyN8=;
        b=QyFldNYR/zT2lHpKns5X4/wjFfU90sFk8PNRZ0byU78c3nj5UJfd6AycF+Kqel+rT8
         MYZyWIU2yjpXHlXSEM5Th8u5rl9/05NtmLJWZjdEilbyru/6wxHP2Lg/116KuUETWveh
         hzSazLZvv1x18gX9xLZkRu9D1lrpHBMR+ri38dv4xM6Si0Xf3VpkO6HrUWAwKOWoijMw
         nillVK1OzTWbgHThnutqIInBT7mq9xclf3ANbdbP5rWutvlLdxd+qNMhtUO4ezg0TS6H
         GC266hiLVcMX+xk0mVxG5IdZbBls5RfOV94Y8bHYbMPacHFQ3i36GIJSyKq0RYtmjCb7
         uhoA==
X-Gm-Message-State: ABy/qLYM5o0ZNXl1TjjnM85O+c5FhLg2PDVMw0CV8a0ssGwnRLWpSGq+
        DhIsIisME+h4Jpa1B6YJ7VVRAEDzf5s2PY6TKAyTeDNZIgBYO/jyCBYog7yTH995mx/boKGFqUz
        YMHMYwxO4t4wd5yPyG4097SZuVO7J
X-Received: by 2002:a5d:4ec5:0:b0:314:98f:2495 with SMTP id s5-20020a5d4ec5000000b00314098f2495mr7489822wrv.12.1690198362009;
        Mon, 24 Jul 2023 04:32:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEI60yM7OEQYltk8pZJRHHkHj4AM6BZ+3LNkwODYxQy3aj86Uaqvq9RfiI7soFJIBmCEAmJvQ==
X-Received: by 2002:a5d:4ec5:0:b0:314:98f:2495 with SMTP id s5-20020a5d4ec5000000b00314098f2495mr7489803wrv.12.1690198361680;
        Mon, 24 Jul 2023 04:32:41 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d4047000000b00313f61889ecsm12615302wrp.66.2023.07.24.04.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:32:41 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 20/20] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <188AEA79-10E6-4DFF-86F4-FE624FD1880F@vmware.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-21-vschneid@redhat.com>
 <188AEA79-10E6-4DFF-86F4-FE624FD1880F@vmware.com>
Date:   Mon, 24 Jul 2023 12:32:38 +0100
Message-ID: <xhsmh8rb5tui1.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On 21/07/23 18:15, Nadav Amit wrote:
>> On Jul 20, 2023, at 9:30 AM, Valentin Schneider <vschneid@redhat.com> wr=
ote:
>>
>> vunmap()'s issued from housekeeping CPUs are a relatively common source =
of
>> interference for isolated NOHZ_FULL CPUs, as they are hit by the
>> flush_tlb_kernel_range() IPIs.
>>
>> Given that CPUs executing in userspace do not access data in the vmalloc
>> range, these IPIs could be deferred until their next kernel entry.
>
> So I think there are a few assumptions here that it seems suitable to con=
firm
> and acknowledge the major one in the commit log (assuming they hold).
>
> There is an assumption that VMAP page-tables are not freed. I actually
> never paid attention to that, but skimming the code it does seem so. To
> clarify the issue: if page-tables were freed and their pages were reused,
> there would be a problem that page-walk caches for instance would be used
> and =E2=80=9Cjunk=E2=80=9D entries from the reused pages would be used. S=
ee [1].
>

Thanks for looking into this and sharing context. This is an area I don't
have much experience with, so help is much appreciated!

Indeed, accessing addresses that should be impacted by a TLB flush *before*
executing the deferred flush is an issue. Deferring sync_core() for
instruction patching is a similar problem - it's all in the shape of
"access @addr impacted by @operation during kernel entry, before actually
executing @operation".

AFAICT the only reasonable way to go about the deferral is to prove that no
such access happens before the deferred @operation is done. We got to prove
that for sync_core() deferral, cf. PATCH 18.

I'd like to reason about it for deferring vunmap TLB flushes:

What addresses in VMAP range, other than the stack, can early entry code
access? Yes, the ranges can be checked at runtime, but is there any chance
of figuring this out e.g. at build-time?

> I would also assume the memory-hot-unplug of some sorts is not an issue,
> (i.e., you cannot have a stale TLB entry pointing to memory that was
> unplugged).
>
> I also think that there might be speculative code execution using stale
> TLB entries that would point to memory that has been reused and perhaps
> controllable by the user. If somehow the CPU/OS is tricked to use the
> stale executable TLB entries early enough on kernel entry that might be
> an issue. I guess it is probably theoretical issue, but it would be helpf=
ul
> to confirm.
>
> In general, deferring TLB flushes can be done safely. This patch, I think,
> takes it one step forward and allows the reuse of the memory before the T=
LB
> flush is actually done. This is more dangerous.
>
> [1] https://lore.kernel.org/lkml/tip-b956575bed91ecfb136a8300742ecbbf4514=
71ab@git.kernel.org/

