Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE173769599
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 14:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjGaMIC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 08:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjGaMIB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 08:08:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842DE10E2
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 05:07:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3175f17a7baso4009211f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690805276; x=1691410076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtmERFMlZOzYX/xBspxMX5ThTF00TCl7wQ49mzpQ0/E=;
        b=ckvKa3Zx6KLTC/M6VWdrDZz/SSn75QqFRlMc0INiSsSBx74N0XLvwMHXr/+1kT27eP
         2VJgFZt4x2XA8zK/QCSOllF4qlJL0zdlWeiSenxoo5XA6bg0BWmo4iAsdwWj5iJRGauk
         wDEn65j7MAM1S5M1tIugT7l19Cfb4tdy6ef+XqorZf5v2By4dSwzVTenowDcofckzNyO
         K3OktzO+ncq6RAs2ijzNHWsQJJW4olboxJSVETmXZPSjGFq7VH+zra5n0r2r2pTXta7N
         Q1Jy7aFI41e+av0nqqcbhUAS0OF7+1gTr+jZqBOc0NfGDi0XeErtkvl+rKkCg5HXkczs
         4qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805276; x=1691410076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtmERFMlZOzYX/xBspxMX5ThTF00TCl7wQ49mzpQ0/E=;
        b=dOcdreOAJMCzUoKU4b0sEABhr9xzodHUG5NW5lS8bRfEwzRjwE8f1WKj6IFZJYEpLJ
         yfJpwi4tDPnhNg+oZlc+iSS1Tv/46RDo06p5c08TWrgorj3DZ/iguH7h3U7RXrGwCuAf
         h+rey2N9zM/FRz77RaB/LyMm3kQtSkgaQUWSFHFx8MIEk6+5Q71Ueg/InlUQPwQyA4iO
         TOC/pOgjqeB9ik0bBKTgqZeGmqfPralLzBouK4fVCAw3rzaKQ3SxWQcmW12i9BEtSHFa
         Ya6jpFvxCOmgywfEZy5K2OeCRresr5J/+aA59WsZ942Q2drwqvatzDX3tldfURh+bL6K
         Ci1Q==
X-Gm-Message-State: ABy/qLZU+YFTQcRUxJlNNPXVwNdHmry6uVxfksHLzAFJaRlObB2PcIkM
        Kq7Jf7Y6jjHe6oqrKOkzs2q96g==
X-Google-Smtp-Source: APBJJlFr6e04BsmGj0Si0aJ/H+RJXUxKxJY/Gls37u74uRa2g6gDjuh0SZ+KHpB0+aEfGznvQoXMRw==
X-Received: by 2002:a5d:6889:0:b0:313:f548:25b9 with SMTP id h9-20020a5d6889000000b00313f54825b9mr6424281wru.40.1690805275895;
        Mon, 31 Jul 2023 05:07:55 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b003fe20533a1esm3193045wmj.44.2023.07.31.05.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:07:55 -0700 (PDT)
Date:   Mon, 31 Jul 2023 15:07:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
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
Subject: Re: [RFC PATCH v2 06/20] tracing/filters: Optimise scalar vs cpumask
 filtering when the user mask is a single CPU
Message-ID: <04f20e58-6b24-4f44-94e2-0d12324a30e4@kadam.mountain>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-7-vschneid@redhat.com>
 <20230729155547.35719a1f@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729155547.35719a1f@rorschach.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 29, 2023 at 03:55:47PM -0400, Steven Rostedt wrote:
> > @@ -1761,6 +1761,11 @@ static int parse_pred(const char *str, void *data,
> >  				FILTER_PRED_FN_CPUMASK;
> >  		} else if (field->filter_type == FILTER_CPU) {
> >  			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
> > +		} else if (single) {
> > +			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
> 
> Nit, the above can be written as:
> 
> 			pred->op = pret->op != OP_BAND ? : OP_EQ;
> 

Heh.  Those are not equivalent.  The right way to write this is:

	if (pred->op == OP_BAND)
		pred->op = OP_EQ;

regards,
dan carpenter

