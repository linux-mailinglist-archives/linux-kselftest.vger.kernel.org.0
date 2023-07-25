Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CB57614CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 13:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbjGYLWz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 07:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbjGYLWy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 07:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021021BEC;
        Tue, 25 Jul 2023 04:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85AEC6168E;
        Tue, 25 Jul 2023 11:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605A4C433C9;
        Tue, 25 Jul 2023 11:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690284164;
        bh=3PZwNojel/fB0iAxHMvVvEfU8vg+2OWEs6gC1RrNPhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ug3Bp0moAtl2iOU0LqyL6tock6eXDiL1XykMzJHwS26YFDBZTp2nVVg5DegFC95W1
         wDJLMEHXkEgb5ZX1TQ495uXTpRNdYAXZ0H74hGRGrgpvceN4JFUqF6/WhthIgQOoXb
         XvH/x8Td6KU4anPDoEwiqQRHT7TSms9g3xsZZT/xKIcjy12Z7QZkhJPm6IYHGnAxUf
         /7VrDt7orGvGidvZWlI4CS9xmnPnE8482azX1QUUGJEU3qAo3Aq5g2wHoRF8lZwyFA
         aKaa6T74oelllGzL5yE1ufrOMNi/c0qdUFY7RpOaL4AoiPSzhULoGduWnosuWAb/0L
         PhJHNPXC3RiRg==
Date:   Tue, 25 Jul 2023 13:22:42 +0200
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
Message-ID: <ZL+wgn76H1em9hZU@lothringen>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-16-vschneid@redhat.com>
 <ZL6QI4mV-NKlh4Ox@localhost.localdomain>
 <xhsmh351dtfjj.mognet@vschneid.remote.csb>
 <ZL7OoUMLZwfUttjV@lothringen>
 <xhsmhzg3ks3mw.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhzg3ks3mw.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 25, 2023 at 11:10:31AM +0100, Valentin Schneider wrote:
> I have reasons! I just swept them under the rug and didn't mention them :D
> Also looking at the config dependencies again I got it wrong, but
> nevertheless that means I get to ramble about it.
> 
> With NO_HZ_IDLE, we get CONTEXT_TRACKING_IDLE, so we get these
> transitions:
> 
>   ct_idle_enter()
>     ct_kernel_exit()
>       ct_state_inc_clear_work()
> 
>   ct_idle_exit()
>     ct_kernel_enter()
>       ct_work_flush()
> 
> Now, if we just make CONTEXT_TRACKING_WORK depend on CONTEXT_TRACKING_IDLE
> rather than CONTEXT_TRACKING_USER, we get to leverage the IPI deferral for
> NO_HZ_IDLE kernels - in other words, we get to keep idle CPUs idle longer.
> 
> It's a completely different argument than reducing interference for
> NOHZ_FULL userspace applications and I should have at the very least
> mentioned it in the cover letter, but it's the exact same backing
> mechanism.
> 
> Looking at it again, I'll probably make the CONTEXT_IDLE thing a separate
> patch with a proper changelog.

Ok should that be a seperate Kconfig? This indeed can bring power improvement
but at the cost of more overhead from the sender. A balance to be measured...
