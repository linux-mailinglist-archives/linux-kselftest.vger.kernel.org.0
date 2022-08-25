Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7F05A0721
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Aug 2022 04:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiHYCGv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 22:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiHYCGr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 22:06:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B4370E75;
        Wed, 24 Aug 2022 19:06:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb36so36804768ejc.10;
        Wed, 24 Aug 2022 19:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8TqByloDSlg58SemH92k8gPZuSCHkGBcxDf5SmwhPCg=;
        b=oNo1F4J3UTDT7c5gLaH/OTw09gC57RIJqxzNRsrUZZII6M7TNutIoXPX8rESxE725N
         s/GJ2mqQ+kwIMa6NTbY2AGNRXV9tB9aXiifrLcQ6xN18hjX5D6yehUtR0e5ZgY/5u8sc
         2FnfZ2zyMp6UDJpmzths3h3wJzyEqAmipT7+Bx82sXNL3rhgUrqkJN+g415YEdVCBv1X
         aeHU6yer3QWcgQ2TiGXnHzCTuAcc3jp3+pZvdx/IfYgXScqSsPIOdopEDc2qNQ3UuVXT
         GMkHEtBx9Hi6s0qFE91dzCxibKNdT4mtz4vPI4iLK51fKANjyQIIVaUaRHjWVmTNPkWh
         BJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8TqByloDSlg58SemH92k8gPZuSCHkGBcxDf5SmwhPCg=;
        b=BUCN95KOVhJIrdDKHoZSm/EhJ/1+mGFPQOJYYXYrqjPK5DGCX1+5CjOCNzSgom8gBY
         XPk6AIfXleWmJEFrR/JBYm6k0T+vxuLwXvAGiMD4Q67oZzPhPr3n62cDcFxDn6uTr+KF
         uRg5J3MXcNTgScOTC4sxTv+FCdT4I9/NO2NOPV6Z6Y+3kPC8XBZoWBON6r6xsBDjqpFa
         d5rxn1oYbk7JAX0MFmCQ5v5vhNrp1/ktDGCvLi+H5aBWuP5GMdbkGaT5KtZEt2Qjm1FV
         hcR6WRic7W1IKh1ulWQ2P34j9DGnqe1E6Sx7h9XZdByW6wlfCppybu/ug/6KEgv7T65V
         pggA==
X-Gm-Message-State: ACgBeo2M4wrwnzpwBAR0k6az42dVPvxNoU5HsUVIYe77qihWisdW20zQ
        f2o9cMMyActUvjqQHwvp9Or4IPJF0si7OzQhQEhAkTOS
X-Google-Smtp-Source: AA6agR4w1XFfUtQqz2s80F9c4wcXWZEgspoKiLx5nqgvgPh1tJLYQVWFC+OqrXbYjSnIUMwe7aXCnJ7IkXrUgYwPeJI=
X-Received: by 2002:a17:907:2896:b0:730:983c:4621 with SMTP id
 em22-20020a170907289600b00730983c4621mr1026272ejc.502.1661393203311; Wed, 24
 Aug 2022 19:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220824110632.1592592-1-eyal.birger@gmail.com> <166136161501.22569.15129561246366098327.git-patchwork-notify@kernel.org>
In-Reply-To: <166136161501.22569.15129561246366098327.git-patchwork-notify@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 24 Aug 2022 19:06:32 -0700
Message-ID: <CAADnVQKeaFwU_f9WYMh91HwLuU4NJnmM5OW9dLfq9sXuB6_kbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next,v3] selftests/bpf: add lwt ip encap tests to test_progs
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     Eyal Birger <eyal.birger@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 24, 2022 at 10:20 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Daniel Borkmann <daniel@iogearbox.net>:
>
> On Wed, 24 Aug 2022 14:06:32 +0300 you wrote:
> > Port test_lwt_ip_encap.sh tests onto test_progs.
> >
> > In addition, this commit adds "egress_md" tests which test a similar
> > flow as egress tests only they use gre devices in collect_md mode
> > for encapsulation and set the tunnel key using bpf_set_tunnel_key().
> >
> > This introduces minor changes to the test setup and test_lwt_ip_encap.c:
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf-next,v3] selftests/bpf: add lwt ip encap tests to test_progs
>     https://git.kernel.org/bpf/bpf-next/c/a8df1b0636af
>
> You are awesome, thank you!

Sorry. I had to revert this patch.
It added 1 min 40 seconds to test_progs that I manually run
every time I apply patches.
Essentially it doubled the test_progs run-time.
Please find a way to test the same functionality in a few seconds.
