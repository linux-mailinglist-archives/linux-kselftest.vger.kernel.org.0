Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81977670A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjG1PgI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjG1PgH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 11:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F03110FA;
        Fri, 28 Jul 2023 08:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E276218D;
        Fri, 28 Jul 2023 15:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F875C433D9;
        Fri, 28 Jul 2023 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690558565;
        bh=RiameAJyaqASlv6hb4c10KMAlN4/6+6/hqnDkYkEzPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5Tu2hgT+a6gPKQMW1urJHIGxB0ZTZOTtxLFvSij1f/yjSQQyTa3zf0mqdYayXPmV
         iccIrLhwD4QgY1Nagc4saDTCQBBcQAV3RcD1m6I2F1ForGzrpqfl32G6a840/Taa7m
         jAW0KefOuBEpEOxh9v1oNKyA0vJvkBsDdk4UOR1d8fmxbhTXNBN479coNCzX9EKVkf
         g7e48OjBzRhIJ1ioN6rN2lAkY9uA3PrFeg93sId02DNN6tLC0glfzPl7gZYl7gg3Gu
         4sC+6Du26Ly24TZAb5B0eOcNMIwGZbynuoLApCVvleEIQpqXqssPsuv7UECOCOrQMQ
         03M7Kq16bokjw==
Date:   Fri, 28 Jul 2023 10:35:57 -0500
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Subject: Re: [RFC PATCH v2 12/20] objtool: Warn about non __ro_after_init
 static key usage in .noinstr
Message-ID: <20230728153557.frzmaayyy3auibx3@treble>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-13-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720163056.2564824-13-vschneid@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 20, 2023 at 05:30:48PM +0100, Valentin Schneider wrote:
> +static int validate_static_key(struct instruction *insn, struct insn_state *state)
> +{
> +	if (state->noinstr && state->instr <= 0) {
> +		if ((strcmp(insn->key_sym->sec->name, ".data..ro_after_init"))) {
> +			WARN_INSN(insn,
> +				  "Non __ro_after_init static key \"%s\" in .noinstr section",

For consistency with other warnings, this should start with a lowercase
"n" and the string literal should be on the same line as the WARN_INSN,
like

			WARN_INSN(insn, "non __ro_after_init static key \"%s\" in .noinstr section",
				  ...

> diff --git a/tools/objtool/special.c b/tools/objtool/special.c
> index 91b1950f5bd8a..1f76cfd815bf3 100644
> --- a/tools/objtool/special.c
> +++ b/tools/objtool/special.c
> @@ -127,6 +127,9 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
>  			return -1;
>  		}
>  		alt->key_addend = reloc_addend(key_reloc);
> +
> +		reloc_to_sec_off(key_reloc, &sec, &offset);
> +		alt->key_sym = find_symbol_by_offset(sec, offset & ~2);

Bits 0 and 1 can both store data, should be ~3?

-- 
Josh
