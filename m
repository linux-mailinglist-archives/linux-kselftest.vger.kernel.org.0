Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CCB789B0D
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 04:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjH0Cta (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Aug 2023 22:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjH0CtX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Aug 2023 22:49:23 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BC1FA;
        Sat, 26 Aug 2023 19:49:21 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-64a70194fbeso14318966d6.0;
        Sat, 26 Aug 2023 19:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693104560; x=1693709360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCtnF9exppXJ6XEDIDPLdkpvn2zVvtmJBQygM/RMB4o=;
        b=rAb2DkGtLtzvfBusGnyMbSTNQITIVKXuVi/834VnyW/8qP/QrdR+zwzLXjW4G9cS16
         L80aJ8eBncSsGnLp7m/BIHTC5J29pNaiHgxMoR63mUkPSC22edCqtzExg7KRNeWcAehg
         OWJXkDDMnjjzC/hb1xk9BRhuweSCXFoKMDSCQd/J+uMbKJCIo1sQPlwhhVKV0w2ixnL0
         hW1HNfiSNNB1q/D2ClEburhGBGvUq2BcPhH0Zptmb08IPwI1fEO5jqOYLXRNZRY4zMD0
         DeDqHTcMiKiXQl5hWxDOVcXsRbkOeeOOn4QWHYmYOeYaY0Z6zaHzDvurKz+p7KR06RUk
         BLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693104560; x=1693709360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCtnF9exppXJ6XEDIDPLdkpvn2zVvtmJBQygM/RMB4o=;
        b=Jmfg7tZMqB/Is/qGG59kF2Gh19KiCGpXKxgKD5bWRMb39xGDQK/p58ti8JDhmJ3Rlp
         cVO0Fe2Vag5ZGyKQoGK3LStCDVzwFG7Z5aYz1jDh4T5bWVwFVO0arzjeb1HV5BWZTrW+
         xVZdZdEuVOSENdSRY8KMJyadcA45xKcZEJeNTq7aw9tnmj30RDdWD744VXD5CgXhbgIK
         zRCWrn+QoB/PUJ8pMePaQSmRLVZcpJDNIzvJTIt01yXsEiniKBP6PaqrJSPV218XChE+
         /S+ZYgxBQYt2Bj9GiQzkisCsmsVG/5NVpCR4QByQmdz1/BGhpLDN5S2BIB4XA0fp6un5
         RauA==
X-Gm-Message-State: AOJu0YyGjYHED97iArgCkJ3SdxmBdRbrCeYfRl6xrjRn7WukrPELj1Tu
        /BZz1AzHA8M7km0V6xJa0RkrbvNsipP1P2i5aCY=
X-Google-Smtp-Source: AGHT+IF4vkWOe6NkflE5M3y8AVEnYVu/enyv10HrjdIye1KfASXGZWMrI8GglN7QOaOkABkqbpataQrmDhg3E7fucmo=
X-Received: by 2002:a05:6214:4111:b0:649:bf3:6dbe with SMTP id
 kc17-20020a056214411100b006490bf36dbemr27581212qvb.62.1693104560582; Sat, 26
 Aug 2023 19:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_6D23FE187408D965E95DFAA858BC7E8C760A@qq.com>
In-Reply-To: <tencent_6D23FE187408D965E95DFAA858BC7E8C760A@qq.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 27 Aug 2023 10:48:44 +0800
Message-ID: <CALOAHbCXVNXk4WUCRGCDsezzTfieDcLT=Jt00m4UX4zdw=RtsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
To:     Rong Tao <rtoax@foxmail.com>
Cc:     olsajiri@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
        sdf@google.com, Rong Tao <rongtao@cestc.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        Manu Bretelle <chantr4@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Ross Zwisler <zwisler@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 26, 2023 at 10:46=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wrote=
:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Static ksyms often have problems because the number of symbols exceeds th=
e
> MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
> commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
> the problem somewhat, but it's not the perfect way.
>
> This commit uses dynamic memory allocation, which completely solves the
> problem caused by the limitation of the number of kallsyms.
>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
> v8: Resolves inter-thread contention for ksyms global variables.
> v7: https://lore.kernel.org/lkml/tencent_BD6E19C00BF565CD5C36A9A0BD828CFA=
210A@qq.com/
>     Fix __must_check macro.
> v6: https://lore.kernel.org/lkml/tencent_4A09A36F883A06EA428A593497642AF8=
AF08@qq.com/
>     Apply libbpf_ensure_mem()
> v5: https://lore.kernel.org/lkml/tencent_0E9E1A1C0981678D5E7EA9E4BDBA8EE2=
200A@qq.com/
>     Release the allocated memory once the load_kallsyms_refresh() upon er=
ror
>     given it's dynamically allocated.
> v4: https://lore.kernel.org/lkml/tencent_59C74613113F0C728524B2A82FE5540A=
5E09@qq.com/
>     Make sure most cases we don't need the realloc() path to begin with,
>     and check strdup() return value.
> v3: https://lore.kernel.org/lkml/tencent_50B4B2622FE7546A5FF9464310650C00=
8509@qq.com/
>     Do not use structs and judge ksyms__add_symbol function return value.
> v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262E=
ED09@qq.com/
>     Do the usual len/capacity scheme here to amortize the cost of realloc=
, and
>     don't free symbols.
> v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F=
2909@qq.com/
> ---
>  samples/bpf/Makefile                          |   4 +
>  samples/bpf/offwaketime_user.c                |   7 +-
>  samples/bpf/sampleip_user.c                   |   9 +-
>  samples/bpf/spintest_user.c                   |   7 +-
>  samples/bpf/task_fd_query_user.c              |  13 +-
>  samples/bpf/trace_event_user.c                |   7 +-
>  .../selftests/bpf/prog_tests/bpf_cookie.c     |   7 +-
>  .../selftests/bpf/prog_tests/fill_link_info.c |   9 +-
>  .../bpf/prog_tests/get_stack_raw_tp.c         |  10 +-
>  .../bpf/prog_tests/kprobe_multi_test.c        |  13 +-
>  .../prog_tests/kprobe_multi_testmod_test.c    |  13 +-
>  tools/testing/selftests/bpf/trace_helpers.c   | 116 ++++++++++++------
>  tools/testing/selftests/bpf/trace_helpers.h   |  10 +-
>  13 files changed, 154 insertions(+), 71 deletions(-)

I think we'd better split it into two patches: one for samples/bpf/
and another for tools/testing/selftests/bpf.

BTW, why can't we just load it once for all ?  IOW, load the kallsyms
before we start each individual test, and free it after all tests
finish.

--=20
Regards
Yafang
