Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F07761942
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjGYNGh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGYNGg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 09:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F018AE5C
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690290354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sjst0ANUHPkhmyS9EMxljg+0hKTtA2LkvoCccenEaWc=;
        b=F7+xFVN/UTPtioUDXmny4WuOauzeqiMr3GZY7z4ZN3NSNic3rnB+YM9YlvrM4oJIRcpCBR
        EUZkTCN/IFwszgRPwQqPwmuiuHakAykTSIQ66vIQqAu2TWbA+DLVAG6WUkHPt+sDmTvotf
        yFAjlzdpsTNHhc69ehl4uvxwy8/lHq0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-cCBAFxslPdq5SkkcZWK4lg-1; Tue, 25 Jul 2023 09:05:53 -0400
X-MC-Unique: cCBAFxslPdq5SkkcZWK4lg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3176c4de5bbso291547f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 06:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690290352; x=1690895152;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjst0ANUHPkhmyS9EMxljg+0hKTtA2LkvoCccenEaWc=;
        b=CQgWTYXbPFq4/TyUiay8/U0PGZK0bCyy8NvzGbq26AgifgwxZKi0EOxm8qii1OLpeF
         nv4l/xpRHQrcJMCxqYzZ1N42XK4gQ4r+NSHvqo2clAraQhP0b8lEDXYuhrOsT73yC30/
         cymYS3SIfL3khezUhMAR/SlCEgeykcaG/YAOQZP0QlXy8LHbiWpZGtE3iMVhborbivfl
         7Pp9OemW9FItp+fodaP+2r33Nb0T73bQSbvojPrwCE6Osgce7iEyeQN7fbd183ydtN5d
         YnOY+wOohLYBeNAQUODx6JTr+EuPZNwEAHaFQfMd0SWZierIt6Rb/prdxip4yai2b2Cb
         mZNg==
X-Gm-Message-State: ABy/qLapypOwknAjGBG6glq6fNu2aiQoFfdz0Ku/pGl1d5wZHySKswl6
        4c7jH2KtA7O4nlxOiiuaEBUOVIYlB4RCXc955mJSYZ8u68lNQ1yp6Hdjds9yTB4+olbQogqq/2Z
        ryrdItIKJ55NwfvJCI8MmBliRd/yl
X-Received: by 2002:a05:6000:4c3:b0:314:3f98:a788 with SMTP id h3-20020a05600004c300b003143f98a788mr9662091wri.7.1690290351823;
        Tue, 25 Jul 2023 06:05:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3IfiPQXJmTRIbnVDIkRhO1QGeOmJQGB2V7Ax+LFUYp7XQ/uOSm8c19TiPQx/PfreNkIV1Uw==
X-Received: by 2002:a05:6000:4c3:b0:314:3f98:a788 with SMTP id h3-20020a05600004c300b003143f98a788mr9662062wri.7.1690290351507;
        Tue, 25 Jul 2023 06:05:51 -0700 (PDT)
Received: from vschneid.remote.csb ([149.12.7.81])
        by smtp.gmail.com with ESMTPSA id a15-20020adfeecf000000b00311d8c2561bsm16238717wrp.60.2023.07.25.06.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:05:51 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
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
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 15/20] context-tracking: Introduce work deferral
 infrastructure
In-Reply-To: <ZL+wgn76H1em9hZU@lothringen>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-16-vschneid@redhat.com>
 <ZL6QI4mV-NKlh4Ox@localhost.localdomain>
 <xhsmh351dtfjj.mognet@vschneid.remote.csb> <ZL7OoUMLZwfUttjV@lothringen>
 <xhsmhzg3ks3mw.mognet@vschneid.remote.csb> <ZL+wgn76H1em9hZU@lothringen>
Date:   Tue, 25 Jul 2023 14:05:47 +0100
Message-ID: <xhsmhwmyorvis.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

On 25/07/23 13:22, Frederic Weisbecker wrote:
> On Tue, Jul 25, 2023 at 11:10:31AM +0100, Valentin Schneider wrote:
>> I have reasons! I just swept them under the rug and didn't mention them :D
>> Also looking at the config dependencies again I got it wrong, but
>> nevertheless that means I get to ramble about it.
>>
>> With NO_HZ_IDLE, we get CONTEXT_TRACKING_IDLE, so we get these
>> transitions:
>>
>>   ct_idle_enter()
>>     ct_kernel_exit()
>>       ct_state_inc_clear_work()
>>
>>   ct_idle_exit()
>>     ct_kernel_enter()
>>       ct_work_flush()
>>
>> Now, if we just make CONTEXT_TRACKING_WORK depend on CONTEXT_TRACKING_IDLE
>> rather than CONTEXT_TRACKING_USER, we get to leverage the IPI deferral for
>> NO_HZ_IDLE kernels - in other words, we get to keep idle CPUs idle longer.
>>
>> It's a completely different argument than reducing interference for
>> NOHZ_FULL userspace applications and I should have at the very least
>> mentioned it in the cover letter, but it's the exact same backing
>> mechanism.
>>
>> Looking at it again, I'll probably make the CONTEXT_IDLE thing a separate
>> patch with a proper changelog.
>
> Ok should that be a seperate Kconfig? This indeed can bring power improvement
> but at the cost of more overhead from the sender. A balance to be measured...

Yep agreed, I'll make that an optional config.

