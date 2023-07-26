Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E84763FE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 21:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjGZTmF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 15:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjGZTmE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 15:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F1B1BE3;
        Wed, 26 Jul 2023 12:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6014861CBB;
        Wed, 26 Jul 2023 19:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0408AC433C7;
        Wed, 26 Jul 2023 19:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690400522;
        bh=6e6cReriYF7em75Hf0iAxdRhfTIt48diinTa2LCaE+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLyIAGyV6TUHuowqKx/5JfDcmeo0WhbUg1yCQ8GAUu2bA1CHQXElka+Q1GRT7V1yv
         R0EddtJuV1su72lOKWDmqPZkTqr3rjqushe4n3Y0JyPwiujSaR6lzMnBE/bXB37uce
         8O1V4aPEPJ7CtaWT6N1qd3sf2g3qg1GZ/ysRkHn0W2duBIi4pMtC3lDu6nsoC6Pt3/
         swHIlZLsRsV+7qlwiW9MPLzwOhahR6eIG7+fvoyQ2iGsIvPP2A61lMuC8l5VN12v0v
         2zw+8Jdxg6lE+m401O76ze1xAH8enmcSNQ3pjVXumpOLBXI9Yvybgks7Mc9qIvNX4N
         FrlfiSoNf+zHg==
Date:   Wed, 26 Jul 2023 12:41:48 -0700
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
Subject: Re: [RFC PATCH v2 02/20] tracing/filters: Enable filtering a cpumask
 field by another cpumask
Message-ID: <20230726194148.4jhyqqbtn3qqqqsq@treble>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-3-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720163056.2564824-3-vschneid@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 20, 2023 at 05:30:38PM +0100, Valentin Schneider wrote:
>  int filter_assign_type(const char *type)
>  {
> -	if (strstr(type, "__data_loc") && strstr(type, "char"))
> -		return FILTER_DYN_STRING;
> +	if (strstr(type, "__data_loc")) {
> +		if (strstr(type, "char"))
> +			return FILTER_DYN_STRING;
> +		if (strstr(type, "cpumask_t"))
> +			return FILTER_CPUMASK;
> +		}

The closing bracket has the wrong indentation.

> +		/* Copy the cpulist between { and } */
> +		tmp = kmalloc((i - maskstart) + 1, GFP_KERNEL);
> +		strscpy(tmp, str + maskstart, (i - maskstart) + 1);

Need to check kmalloc() failure?  And also free tmp?

> +
> +		pred->mask = kzalloc(cpumask_size(), GFP_KERNEL);
> +		if (!pred->mask)
> +			goto err_mem;
> +
> +		/* Now parse it */
> +		if (cpulist_parse(tmp, pred->mask)) {
> +			parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
> +			goto err_free;
> +		}
> +
> +		/* Move along */
> +		i++;
> +		if (field->filter_type == FILTER_CPUMASK)
> +			pred->fn_num = FILTER_PRED_FN_CPUMASK;
> +

-- 
Josh
