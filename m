Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2F2769B1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjGaPsQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjGaPsO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 11:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B3710D;
        Mon, 31 Jul 2023 08:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 210FF611BD;
        Mon, 31 Jul 2023 15:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAFBC433C8;
        Mon, 31 Jul 2023 15:48:05 +0000 (UTC)
Date:   Mon, 31 Jul 2023 11:48:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
        x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
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
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 02/20] tracing/filters: Enable filtering a
 cpumask field by another cpumask
Message-ID: <20230731114803.019158b9@gandalf.local.home>
In-Reply-To: <xhsmh4jlks4yw.mognet@vschneid.remote.csb>
References: <20230720163056.2564824-1-vschneid@redhat.com>
        <20230720163056.2564824-3-vschneid@redhat.com>
        <20230726194148.4jhyqqbtn3qqqqsq@treble>
        <20230729150901.25b9ae0c@rorschach.local.home>
        <xhsmh4jlks4yw.mognet@vschneid.remote.csb>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 31 Jul 2023 12:19:51 +0100
Valentin Schneider <vschneid@redhat.com> wrote:
> >
> > Also, when you do an empty for loop:
> >
> >       for (; str[i] && str[i] != '}'; i++);
> >
> > Always put the semicolon on the next line, otherwise it is really easy
> > to think that the next line is part of the for loop. That is, instead
> > of the above, do:
> >
> >       for (; str[i] && str[i] != '}'; i++)
> >               ;
> >  
> 
> Interestingly I don't think I've ever encountered that variant, usually
> having an empty line (which this lacks) and the indentation level is enough
> to identify these - regardless, I'll change it.


Do a "git grep -B1 -e '^\s*;\s*$'"

You'll find that it is quite common.

Thanks,

-- Steve

