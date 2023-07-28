Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35D576709C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbjG1Pdt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjG1Pds (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 11:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD43B5;
        Fri, 28 Jul 2023 08:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78DAD6215F;
        Fri, 28 Jul 2023 15:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81C5C433C8;
        Fri, 28 Jul 2023 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690558424;
        bh=oINpRshoP8wUOrW0KrHyosEeCy6vm0dPU8gi9b4Apus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AD2p4MRxVbTJMornW4rtnlVVyLtsVamKFOjKM/YtSATmK7lMhlOFDtRA8/G9pwgAF
         1sWs1sWg4F/hukZR/JU7U6+l+wo+TWOewD4I0cwarQlOh0aRJ5NoYtpqB65I1MoNkZ
         9eZ9o3jYY3UHmKnV1fAXG/Wsu+xLSUGP3fwhMzmUZYsiirR4cz2f0g0qO5oPqupzrV
         KVK6uhTCxPtxrv7b6kTCNn/0LI+haKYLBtnoLaTW2+Afw76EKbl/pDrq9Nr7zzTHx3
         98waSBKvQ5Se6QKIDWgXNStJwQxe0LwKr5KRFMdIy2JGzu/oByxmUdnBja60W0N9t0
         bBsDZIkwNMEcg==
Date:   Fri, 28 Jul 2023 10:33:34 -0500
From:   Josh Poimboeuf <jpoimboe@kernel.org>
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
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 11/20] objtool: Flesh out warning related to
 pv_ops[] calls
Message-ID: <20230728153334.myvh5sxppvjzd3oz@treble>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-12-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720163056.2564824-12-vschneid@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 20, 2023 at 05:30:47PM +0100, Valentin Schneider wrote:
> I had to look into objtool itself to understand what this warning was
> about; make it more explicit.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  tools/objtool/check.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 8936a05f0e5ac..d308330f2910e 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -3360,7 +3360,7 @@ static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
>  
>  	list_for_each_entry(target, &file->pv_ops[idx].targets, pv_target) {
>  		if (!target->sec->noinstr) {
> -			WARN("pv_ops[%d]: %s", idx, target->name);
> +			WARN("pv_ops[%d]: indirect call to %s() leaves .noinstr.text section", idx, target->name);
>  			file->pv_ops[idx].clean = false;

This is an improvement, though I think it still results in two warnings,
with the second not-so-useful warning happening in validate_call().

Ideally it would only show a single warning, I guess that would need a
little bit of restructuring the code.

-- 
Josh
