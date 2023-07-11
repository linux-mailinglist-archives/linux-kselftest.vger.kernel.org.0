Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301FB74E299
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 02:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGKAhR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 20:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGKAhQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 20:37:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFDF1AC;
        Mon, 10 Jul 2023 17:37:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so83371081fa.1;
        Mon, 10 Jul 2023 17:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689035833; x=1691627833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KzZR+3uBAAfoyD64XhpmvukCNRgSrEvKBzVHoKvA4I=;
        b=QePSPYmXWBGIDNUBrGBf5dNhcMIgQXxeSLRtxqxBcsVcRzTIUh7r+RU+SJgk/tmHGt
         8ZoLhHoWtRH2tgqNmUgQy9A9InN93Do8kb5ER210aYcrZTmWOPm1pr37GIYVQbHF3lYv
         1teYgsn0Cnt2EHvRiPl/ffYISmv8S38q1G11FpdRLRiAGt/z7PZvttauDbVQ89la54m2
         BeVbhy/8N+QbNSyslcBmQkJq8cVVmQErH/APZuyYtuoXn1RKtKaZeYSV1eMo4RMTNbwL
         LjsuLhXCSyfJkcf9PU9AO/cNxgPkvnsuRMwjmZm7oqPnj1d+OrAPeHX3fvKFc7FoMYUg
         P7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689035833; x=1691627833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KzZR+3uBAAfoyD64XhpmvukCNRgSrEvKBzVHoKvA4I=;
        b=JMAwWM0idH6i0ZzOIhcnZ4rbp0xXR03rqDiApdpo4q9/MV11w3pGX2QaZdhxdys/du
         B9Z0Rf9kNe+uVWXIAjT53dXi4GxtIEI7I5PjgWlIj++072BFbDdwljxMzQk15Th40I0F
         EIoB8CkQqUWzLbBCF8Mk4a3HPM6l+kD5kp22v4PaiDnI+p8x9aRYPZwlMFCGUMvPgzwJ
         tI8Q9Sp85UD1pkD0u9PHtYVWPac/AulrzcLmEHy6Ft/WS1xQq1N7L5isJZ2aPZVS/ljf
         h2aym/zG6bt7sxMajnXmqq+zfeHE1vq8fPxPNWS4SETj/VnktrvUlacLtfbhsuUau0kd
         LReQ==
X-Gm-Message-State: ABy/qLYEODthPWn62gmZxSXKOpa6DXzNT6mmxlsIl6GWBSFKF7MrvK6d
        GHjhAp01UkfGwZ1hqBxOr20mPry3+aPmh+s6iRY=
X-Google-Smtp-Source: APBJJlEnq2pY54DPq3uUhu9mvqZQeE6rwDrv5wtxw4z6ZOom5E9R2u1iJKyFPEgekhQxSbs17e6NVE2XcwInUAgpuG0=
X-Received: by 2002:a2e:964e:0:b0:2b6:fa3f:9233 with SMTP id
 z14-20020a2e964e000000b002b6fa3f9233mr7975582ljh.46.1689035833423; Mon, 10
 Jul 2023 17:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688748455.git.dxu@dxuuu.xyz> <13720a4b7a18b2409357a82eebe57ef388ab9cf1.1688748455.git.dxu@dxuuu.xyz>
In-Reply-To: <13720a4b7a18b2409357a82eebe57ef388ab9cf1.1688748455.git.dxu@dxuuu.xyz>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 10 Jul 2023 17:37:01 -0700
Message-ID: <CAADnVQLaepgpoH4qjbhAmq-+JLiAXyJ=4nXgbu6NSkZmpF9ghg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] bpf: selftests: Add defrag selftests
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 7, 2023 at 9:51=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> These selftests tests 2 major scenarios: the BPF based defragmentation
> can successfully be done and that packet pointers are invalidated after
> calls to the kfunc. The logic is similar for both ipv4 and ipv6.
>
> In the first scenario, we create a UDP client and UDP echo server. The
> the server side is fairly straightforward: we attach the prog and simply
> echo back the message.
>
> The on the client side, we send fragmented packets to and expect the
> reassembled message back from the server.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

The patches look good, but new tests are failing on arm64.

test_bpf_ip_check_defrag_ok:FAIL:server recvfrom unexpected server
recvfrom: actual -1 < expected 0

see BPF CI.
Feels like a timing issue, but pls take a look.
