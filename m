Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEFE6D438D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 13:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjDCLfv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 07:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjDCLfu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 07:35:50 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FEAD520
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 04:35:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn12so116077966edb.4
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1680521746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DtE7tV0BJ1X9kRhDE14KjV/Fb1R+O4UUB9r9GwZWHwo=;
        b=o3vCAWCphfEADsf6/95NRHzkL1jz+Vky1MmSf5xdgXS9fzGpMmWYi8ZQONoeeS5gJj
         NGvHL5Zh/1nkvJfx4L8oEb1CsTICL++1jR5kbKxy3AzeDHtnbj1b5k9FyvxHL03anMYX
         qoOrxjNj5jkQ2B43jxieaG9sl32GhSlueiUK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680521746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtE7tV0BJ1X9kRhDE14KjV/Fb1R+O4UUB9r9GwZWHwo=;
        b=HfFtDVczvjdnqWwmvsNSBm+ru29KrZSJ6q9vMcxftb8Zzpj5MEFdtzfG4Ck5C8JzAz
         w1bovmy8KMGHvI6TJHFk8eUCbFvoQ7JhI5TlPQBXHedwthUhnDmkvs71AXneHiYKmURV
         3uNcHg+ElFVFEL/vaECLOwup1Mu5+QtxW917gxZj4j+ZJl/3qFdlrQdHkkVsshWkeFXM
         IR9u5uKnGXmyRKDGTCNH4CVEfomJkMn3Mq8/3yVY9dQHqOR/Ir2N7lBoXugR7DluSn7S
         fzlT4L7SPR6ySeVgC5mNf7yJ4S0gN+WnwTfl0Dib1bQ9LuEw6Fi9/qNdg69CtiTUK5zJ
         IP6w==
X-Gm-Message-State: AAQBX9etNCdysjo14fgNPJ0EsF4uwCUijvbtbG6aCZ9+V5ipneOX6O4d
        046pQWvEea2AHrkudBzt/haFCtuVlLiLx27ba0aTcQ==
X-Google-Smtp-Source: AKy350YHk+VumZlyk8Dikia4bU8HuhDFbXRE1v2w6I3NT+rYijEYQ2uNrwg/BoeLVEvlcTh/IngcPwMBYTWYI9etBKg=
X-Received: by 2002:a50:f692:0:b0:4fc:fc86:5f76 with SMTP id
 d18-20020a50f692000000b004fcfc865f76mr17964995edn.6.1680521746373; Mon, 03
 Apr 2023 04:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230329180502.1884307-1-kal.conley@dectris.com>
 <20230329180502.1884307-5-kal.conley@dectris.com> <CAJ8uoz1cGV1_3HQQddbkExVnm=wngP3ECJZNS5gOtQtfi=mPnA@mail.gmail.com>
 <CAHApi-kV_c-z1zf9M_XyR_Wa=4xi-Cpk1FZT7BFTYQHgU1Bdqg@mail.gmail.com>
In-Reply-To: <CAHApi-kV_c-z1zf9M_XyR_Wa=4xi-Cpk1FZT7BFTYQHgU1Bdqg@mail.gmail.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Mon, 3 Apr 2023 13:40:26 +0200
Message-ID: <CAHApi-mp7ymJ2MP_MFK=Rcv--YCz4aqtKArMwF1roRZHh0to1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/10] selftests: xsk: Deflakify
 STATS_RX_DROPPED test
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
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
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>
> Can I send patches 01-05 all together as one patchset?
>
On second thought, I will just send out 01, 04, and 05 already
separately since those are all completely independent.
