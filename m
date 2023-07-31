Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F620769BBA
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjGaQDW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjGaQDS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 12:03:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B5F1BC
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 09:03:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso52378675e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 09:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690819394; x=1691424194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjX9vqrNZsVo8pAJHyJfBfDqvLmz9Q9LwcwZTP61/cs=;
        b=kYzWRu4k1QcGoE6XKlByF3TqlwnnuXUy4dR/Gmke34HiIojnc6bDt5mnmDrOMIanBC
         QUevvvfek0A0kIhfRLCo8R/86BFpovIiHnnInbzwZivWg2DRSm+X5e15n19MoM8ITjcG
         /+J6EfoaBtyNvPh2Yg2/K4Zf7rrxdQB0bQhvIF9F1h5QqrkpNHuKfSzod4rrLRa1ifOB
         nEUhBA9+KaGfeeecCMie9MebsjXRqYzaUgOSq09dmjhabu7gzNjGo+iXkB9N7h9h4gTU
         J2wpszV9xtd4d81pKysjcOiYL/WmjuQhdAci9fviFugAru1L92cwlrTrGrXfizKWktqj
         yppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690819394; x=1691424194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjX9vqrNZsVo8pAJHyJfBfDqvLmz9Q9LwcwZTP61/cs=;
        b=eFDR8O5V3r81HjOMa1JApo7hyIXkVsFBixUesTTn8T09jI6fVvJWhMy1u/ToJoaBfY
         KdqL/krlhlpN7f+EU+Ege9YqvhwuT7WcB7NWf2R5JPVHobfyoHu/DgOY2YK+ZlUg0XuE
         vRRuvzTFLSCmTWI6alXKyypE+wIJGBHYYhC1LLu4QHt3pQh61jHvIJDNwcyFMBzFuP+W
         skaI0jVOBG/FGNBa+4PDxHdZ2RW04FApuxhaSB9He7r7mFGisoMkheVNQSfeTYtitk63
         xmEeFFFwYqwVifGkxsJ85AjuqIQw+ezkFHyH3Ij/z9l7CEWouI5DqzmiJYi5DYEphq/b
         c50g==
X-Gm-Message-State: ABy/qLYISJRDFP+b9PvjuwZaH8bUUi8Fd9MMpXVr9a4+htItd38gJBMn
        BFhe3X7lY545OQqTpu0o78wEXQ==
X-Google-Smtp-Source: APBJJlH9s43EMKigyuVBab9J9RMVZV2UplPMJan+41yuvFpRsQzS559KIDbR9x9cZ2CPnZZf/f6ReA==
X-Received: by 2002:a1c:7505:0:b0:3fc:2e8:ea8b with SMTP id o5-20020a1c7505000000b003fc02e8ea8bmr295454wmc.28.1690819394291;
        Mon, 31 Jul 2023 09:03:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c215200b003fe0bb31a6asm8872643wml.43.2023.07.31.09.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:03:13 -0700 (PDT)
Date:   Mon, 31 Jul 2023 19:03:04 +0300
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
Message-ID: <b7cf996a-f443-402c-8e13-c5f25a964184@kadam.mountain>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-7-vschneid@redhat.com>
 <20230729155547.35719a1f@rorschach.local.home>
 <04f20e58-6b24-4f44-94e2-0d12324a30e4@kadam.mountain>
 <20230731115453.395d20c6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731115453.395d20c6@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 11:54:53AM -0400, Steven Rostedt wrote:
> On Mon, 31 Jul 2023 15:07:52 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > On Sat, Jul 29, 2023 at 03:55:47PM -0400, Steven Rostedt wrote:
> > > > @@ -1761,6 +1761,11 @@ static int parse_pred(const char *str, void *data,
> > > >  				FILTER_PRED_FN_CPUMASK;
> > > >  		} else if (field->filter_type == FILTER_CPU) {
> > > >  			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
> > > > +		} else if (single) {
> > > > +			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;  
> > > 
> > > Nit, the above can be written as:
> > > 
> > > 			pred->op = pret->op != OP_BAND ? : OP_EQ;
> > >   
> > 
> > Heh.  Those are not equivalent.  The right way to write this is:
> 
> You mean because of my typo?

No, I hadn't seen the s/pred/pret/ typo.  Your code does:

	if (pred->op != OP_BAND)
		pred->op = true;
	else
		pred->op OP_EQ;

Realy we should probably trigger a static checker warning any time
someone does a compare operations as part of a "x = comparison ?: bar;
Years ago, someone asked me to do that with regards to error codes like:

	return ret < 0 ?: -EINVAL;

but I don't remember the results.

regards,
dan carpenter

