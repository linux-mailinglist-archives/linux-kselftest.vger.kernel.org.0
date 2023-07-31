Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D500769490
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 13:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjGaLTn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 07:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjGaLTm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 07:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63311E76
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690802316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Feb3SbI628V0M+Xl6cXNHTwh1emqN1pCsroF1cMMhXw=;
        b=Lz5B9a8tI/ubSSVOY7g9gMzwaa1MeAaBzaJ4gjvx3QdAJ7HMTB13ZG7DGdd3GCjO2DMBpo
        kq6YW7eNQHLJ2kywXHxFrCIfxLHmyoHHEO+ciwjZYwd9pm39YaMEdyZLTehiB/ShDBmqLO
        4THpOJ/D7HR/wViODRlDt1t+pZZXIrY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-RSPy47SBMrynC8O5H1Sp9g-1; Mon, 31 Jul 2023 07:18:35 -0400
X-MC-Unique: RSPy47SBMrynC8O5H1Sp9g-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-406afc93066so39029821cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 04:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802315; x=1691407115;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Feb3SbI628V0M+Xl6cXNHTwh1emqN1pCsroF1cMMhXw=;
        b=Unk3tWstQguulQO+bAAEWxNgMcbYIOGu6H6C/7NTZnjuZDfsoDqAJtSLOYES+XfU8/
         BSyBB9GZDWaMGgZb/CvDjWecxpyHztTKeGtMCNS5CTEpx7ONWZ8A69XxaHOx8mlCR771
         UaSHXe8mhLSUC8e8w48wEj5ViqcWBD9BYLm28JSk1jOM3iyvP1eJzT60vPV4gBirqUFO
         18Nqa3XPulNcrN0oWeV63QPFSgoCBswZ1O8mddtXMI9ckgRANuNWeRB/89RKuOuv32r2
         opbFJIs6prUxeXHgHnURdMrCbgSb8Lpbz1weFTuhIyxh73Xu4nezLoLrDe3BkcohAuFI
         wFRQ==
X-Gm-Message-State: ABy/qLaRhsqEIiu/kO39Gnpi4w1hY4RKxgrx06YSCNPFArZxUImXk/PE
        gEu2my60Fio2LdX7MMT7IsqGpEeUB+6MMPeLuinLONughywNHtt09Gy8fdcHHFTScHh3IZUsk3D
        4RCWJaXP60ZoYfbcWEUEXBkDTn6Ay
X-Received: by 2002:a05:622a:1806:b0:403:b23f:9e16 with SMTP id t6-20020a05622a180600b00403b23f9e16mr13377221qtc.2.1690802314890;
        Mon, 31 Jul 2023 04:18:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEehrZuAEoVbTnlaVgIfddlc4rg89Sd70WHq1FBXragdFZy0TviERBFx02bWZYfpI2p+8TwzA==
X-Received: by 2002:a05:622a:1806:b0:403:b23f:9e16 with SMTP id t6-20020a05622a180600b00403b23f9e16mr13377176qtc.2.1690802314653;
        Mon, 31 Jul 2023 04:18:34 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id e21-20020ac85995000000b003fde3d63d22sm3385798qte.69.2023.07.31.04.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:18:33 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
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
In-Reply-To: <20230728160247.multb2csnpa22fgx@treble>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-13-vschneid@redhat.com>
 <20230728160247.multb2csnpa22fgx@treble>
Date:   Mon, 31 Jul 2023 12:18:10 +0100
Message-ID: <xhsmh7cqgs51p.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 28/07/23 11:02, Josh Poimboeuf wrote:
> On Thu, Jul 20, 2023 at 05:30:48PM +0100, Valentin Schneider wrote:
>> Later commits will depend on having no runtime-mutable text in early entry
>> code. (ab)use the .noinstr section as a marker of early entry code and warn
>> about static keys used in it that can be flipped at runtime.
>
> Similar to my comment on patch 13, this could also use a short
> justification for adding the feature, i.e. why runtime-mutable text
> isn't going to be allowed in .noinstr.
>
> Also, please add a short description of the warning (and why it exists)
> to tools/objtool/Documentation/objtool.txt.
>

I had missed this, thanks for the pointer.

> --
> Josh

