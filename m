Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B16DA40E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 22:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDFUu3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 16:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbjDFUt1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 16:49:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F419AF3B;
        Thu,  6 Apr 2023 13:49:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id cw23so4306703ejb.12;
        Thu, 06 Apr 2023 13:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680814145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCN3GrtUpZ+xlqLWoh1ipqXhNvsLB+QwAGX3mur1Ixw=;
        b=BheOjBuvTUebB1RMkj1YW3umEPmVi/BcbcP+0jtpeESNYpRR8Yl8k+uiONH0r63VV3
         eLI5F0XCCBnAYdVUzcwSMAWRlk8DK7PBsC4qnTmci86zrXDBhYQDZPEfDEPuAZc0dyXH
         11ICDipD3giRMUtmkVlg0WvJ5NYR2RD2k+EBuLGoaWtLIAjexGU2EwiHUuuPxf7yfDqf
         ojHj5ASivTPF7vEgnbewW+8JvcD+DAFzEFJWJxPuei/QR7ukrM6vFWSGZO9HNZon4IhV
         sHC9IR1oxXn6YHrcuj89H4netNP7I3DTUyeBoDhQKhzXcHjaYUbaWBIy8+KXB4povH0B
         sxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680814145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCN3GrtUpZ+xlqLWoh1ipqXhNvsLB+QwAGX3mur1Ixw=;
        b=MibWoPf+U4T1ChU1mbTPCyzqcnv397fsyaF6WdSni8T9qxyJZ4aVka61c+024LfjsW
         TIsG6nzfaWV8rAzOSe3vS6KV4MZrZ/Nh9Na7/hoRKwhsfD7jMPCNGWFiDjj9pvprcB6w
         RGMPl1fQM94cgQN0bdawMLK4RbYScHyGjfWK/8BfFj57hdvgUhMa6WxDPslcpzI/Hzpj
         +xBJ+awnPMUT+73yeuFmUA+WVIic0dUcqlEnNAo2LyU1MaeyX3kofwIAxIpAP6lukVzC
         +o3sQhTjS2yhSQMuEqGSeq9zpHlsGz4ufC2QTIFYqRTpUdAwvIixfaWR/wltdvGZ28js
         HRoQ==
X-Gm-Message-State: AAQBX9cEDUV1lhD74yNiXaZ5wZWXcua+UI111NfKeNlU8YqG632WIQ6y
        i2KfdO7k7m1kDzaBLoYqfGHWTO6PxTvZ9b+ei/c=
X-Google-Smtp-Source: AKy350bdBu7n5Th/kqT8+7RBE/AT/rIWP9xCgcx5DFhwuUvg6zhZOXPsuHZQB996csS4YTIEwvLnsWGP6ovbuYNO9mY=
X-Received: by 2002:a17:907:78d7:b0:8ab:b606:9728 with SMTP id
 kv23-20020a17090778d700b008abb6069728mr106389ejc.5.1680814144828; Thu, 06 Apr
 2023 13:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com>
In-Reply-To: <20230406004018.1439952-1-drosen@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 13:48:52 -0700
Message-ID: <CAEf4BzZ2zjJKhyUtZKUxbNXJMggcot4MyNEeg6n4Lho-EVbBbg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Dynptr Verifier Adjustments
To:     Daniel Rosenberg <drosen@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 5, 2023 at 5:40=E2=80=AFPM Daniel Rosenberg <drosen@google.com>=
 wrote:
>
> These patches relax a few verifier requirements around dynptrs.
>
> I was unable to test the patch in 0003 due to unrelated issues compiling =
the
> bpf selftests, but did run an equivalent local test program.
>
> This is the issue I was running into:
> progs/cgrp_ls_attach_cgroup.c:17:15: error: use of undeclared identifier =
'BPF_MAP_TYPE_CGRP_STORAGE'; did you mean 'BPF_MAP_TYPE_CGROUP_STORAGE'?
>         __uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>                      BPF_MAP_TYPE_CGROUP_STORAGE
> /ssd/kernel/fuse-bpf/tools/testing/selftests/bpf/tools/include/bpf/bpf_he=
lpers.h:13:39: note: expanded from macro '__uint'
> #define __uint(name, val) int (*name)[val]
>                                       ^
> /ssd/kernel/fuse-bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:=
27892:2: note: 'BPF_MAP_TYPE_CGROUP_STORAGE' declared here
>         BPF_MAP_TYPE_CGROUP_STORAGE =3D 19,
>         ^
> 1 error generated.

It is expected that you build the freshest vmlinux image before
building selftests, because we generate vmlinux.h from it. In your
case we generated vmlinux.h from your system-wide
/sys/kernel/btf/vmlinux BTF information, which doesn't yet have latest
UAPI enums.

>
> Daniel Rosenberg (3):
>   bpf: verifier: Accept dynptr mem as mem in helpers
>   bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
>   selftests/bpf: Test allowing NULL buffer in dynptr slice
>
>  Documentation/bpf/kfuncs.rst                  | 23 ++++++++++++-
>  kernel/bpf/helpers.c                          | 32 ++++++++++++-------
>  kernel/bpf/verifier.c                         | 21 ++++++++++++
>  .../testing/selftests/bpf/prog_tests/dynptr.c |  1 +
>  .../selftests/bpf/progs/dynptr_success.c      | 21 ++++++++++++
>  5 files changed, 85 insertions(+), 13 deletions(-)
>
>
> base-commit: 5af607a861d43ffff830fc1890033e579ec44799
> --
> 2.40.0.577.gac1e443424-goog
>
