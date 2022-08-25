Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B8E5A0862
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Aug 2022 07:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiHYFQm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Aug 2022 01:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiHYFQl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Aug 2022 01:16:41 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870CC9E697;
        Wed, 24 Aug 2022 22:16:40 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id w28so14438341qtc.7;
        Wed, 24 Aug 2022 22:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/IezxT3YpP/ZjkPS+Sq1V7sUV/YNLeMEPS9rX6LVw9Q=;
        b=UkOOJVih0dAjblIhangVtEHpzEmp4UPcqY6Jw4xE2aaNGGq2l77AtJAVTUqUrFwKht
         G139yS8e6ugVaSeXJNnI3oAejgh7RwSHiurVUfkTf2AO0JhM5CmWg3AePjLa/pBnAw2w
         Sr5W8zL5xdCDO2QbW29tt9xLbwyh/u6EmNcXJbTlN4ebBSlGpkwRRj8l8HOIGAyUPOxS
         eMM52r0/u5aniYyAMEX9rdzEUKuM006h+f20jZ10Kj0L59aHy3WoF63Sh0r/lMxy6AUN
         /4Szbh9fmnx2XiQIRZgkeHzZrF7SAV8DDtcEc/Y0wxC+z2e2i1fmJuxTfGv1euLwITmO
         bcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/IezxT3YpP/ZjkPS+Sq1V7sUV/YNLeMEPS9rX6LVw9Q=;
        b=Frsg4vkoif/WLlfucV5Wc5C9IO39qGl4okbO53Y0tIxCvbPHN5V0B+sw/JONjofYmn
         Mk6As4AZmJYa8NtYzTI3b8xfGLiBJtxOBe/CWLbP1RvfBtj92huw0WALH8FEgqFY50+w
         T6prDfui6JgFH5c7XjHeaxWlX/lWtpFqJublA1doV8vMQgHxoJoQu4C0MRMBAyxgPxZF
         CZQjb2CR4k6T0i2mbkaAQgO9z/GrBfCZlFpomay569wceSw5f3cf/hclq3PlT6PsJ6wW
         qqSRi9KdEoOlt7u8Yo5rkQI5j/6xeVX0aafSH5yXfpRxXA/5ArblQjDkJoXZblTPRx5q
         urUg==
X-Gm-Message-State: ACgBeo3MyfzbKAhi34XJwCP3i/7qV71am1Q5/0hH0ihn8TeknXbxfNno
        jET881dUldtiyH7mXZFpiPFncR2thxJr2+9Ld9s=
X-Google-Smtp-Source: AA6agR7dbvdf53Ku9mgcjUs4w/KuJACzIcGua7jYnSSH0TxPDmQdTjWK2m3y3o+6vlS9a275sNagDjSQn0pOZNAGvxE=
X-Received: by 2002:ac8:7fc5:0:b0:343:681d:c3fb with SMTP id
 b5-20020ac87fc5000000b00343681dc3fbmr2273958qtk.157.1661404599568; Wed, 24
 Aug 2022 22:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220824110632.1592592-1-eyal.birger@gmail.com>
 <166136161501.22569.15129561246366098327.git-patchwork-notify@kernel.org> <CAADnVQKeaFwU_f9WYMh91HwLuU4NJnmM5OW9dLfq9sXuB6_kbw@mail.gmail.com>
In-Reply-To: <CAADnVQKeaFwU_f9WYMh91HwLuU4NJnmM5OW9dLfq9sXuB6_kbw@mail.gmail.com>
From:   Eyal Birger <eyal.birger@gmail.com>
Date:   Thu, 25 Aug 2022 08:16:29 +0300
Message-ID: <CAHsH6GvRyRiQ3KWN49b6aKRZuubHqqdD=B1BBjiczg3XsaH-kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next,v3] selftests/bpf: add lwt ip encap tests to test_progs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     patchwork-bot+netdevbpf@kernel.org,
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

On Thu, Aug 25, 2022 at 5:06 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 24, 2022 at 10:20 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
> >
> > Hello:
> >
> > This patch was applied to bpf/bpf-next.git (master)
> > by Daniel Borkmann <daniel@iogearbox.net>:
> >
> > On Wed, 24 Aug 2022 14:06:32 +0300 you wrote:
> > > Port test_lwt_ip_encap.sh tests onto test_progs.
> > >
> > > In addition, this commit adds "egress_md" tests which test a similar
> > > flow as egress tests only they use gre devices in collect_md mode
> > > for encapsulation and set the tunnel key using bpf_set_tunnel_key().
> > >
> > > This introduces minor changes to the test setup and test_lwt_ip_encap.c:
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [bpf-next,v3] selftests/bpf: add lwt ip encap tests to test_progs
> >     https://git.kernel.org/bpf/bpf-next/c/a8df1b0636af
> >
> > You are awesome, thank you!
>
> Sorry. I had to revert this patch.
> It added 1 min 40 seconds to test_progs that I manually run
> every time I apply patches.
> Essentially it doubled the test_progs run-time.
> Please find a way to test the same functionality in a few seconds.

Sorry about that! I ported some of the delays from the original script
in an effort to improve robustness which is probably the bulk of the run time.
I'll find a different approach.

Eyal.
