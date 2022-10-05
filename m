Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF165F5D24
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Oct 2022 01:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJEXOg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 19:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJEXO1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 19:14:27 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E23E85A8F;
        Wed,  5 Oct 2022 16:14:25 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e62so358169yba.6;
        Wed, 05 Oct 2022 16:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=70/0VDagsCspULHomdUzncRjIyjSrHpZkWTpvU+Mdnc=;
        b=Ui9PfNfdZTtU6jOx6m29Brzt8qaGM1rmvPM64cfvS2965Q/AHw9kio3RsCdwhBE4lC
         SdnMGpgwu7DK3fS1TdSxR0n4AgYpaWu5oClNpUoIqAq++IUqYCRrrfFTnEDO7paRM2ot
         22yLQxTvSE7WVpkmgLiTda1RcywO8twpU/WeErxbh7A2WP2llw7oTFpNQHWXlqpevUP+
         FpDUipPw5dAMuqT9pwKB8aAgM7HD2+K86YHYvfTie+uf93e45G3EFMu9U8J6gUOaF+d/
         Aj2kaff5fDGPSZd28AjteAChmma/tGu1cSr36yuvfFpoHkki6JtXYJVLdy0GQlsELyVe
         f2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70/0VDagsCspULHomdUzncRjIyjSrHpZkWTpvU+Mdnc=;
        b=Q1qcvsIyLwO/Z7sMk11VyRwP6hh/1t4bGuRSp8wnmwOzDGGlF5Cpjl8EdKJwL1Z3WV
         pFWXWHsjBQ2zW4ORFq+WNDkV72IaZ7ZctE5SQXZvkN10yKMTCNEUCsyLsxVA0O03o3XI
         TYFHPrynZkuFSRC794d2084CCXJVI03GQdiCuEWJZlsg9YlfgiPuhV+ErhEBHDC4f0xB
         PzxQsERGClu0eoH8TZo4OsAySBHLDQEAGvrOSamWnatqQvTDdhS2X3cuI+Vm0Piwp4mR
         NRJOjRgUUplQ4P66fOB2OFBMr9uNHeVlRI6wfVJCDja/rHjs51oc1WoVyBc8OfS+sY8X
         0KUA==
X-Gm-Message-State: ACrzQf3jgKAW382BY9wQt/h6q1VmiaC7qAp7suRX4GgtrY4EjZgBUKKA
        geC2S6L1sqgd2XrHiaulQ1FGydkQHjbnYwAAUnI=
X-Google-Smtp-Source: AMsMyM6I4s6UccUK4U+1a85yiHlmz50OFgQOtvzM1LTxzYeZI2wkrMEJsvjEnlINVZWw4sqPNxThXaEVdei6cZniuRg=
X-Received: by 2002:a25:9e85:0:b0:6be:1725:91a8 with SMTP id
 p5-20020a259e85000000b006be172591a8mr2353790ybq.86.1665011664245; Wed, 05 Oct
 2022 16:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221004131750.2306251-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221004131750.2306251-1-roberto.sassu@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Oct 2022 16:14:11 -0700
Message-ID: <CAEf4BzYba-4gG8HRiAfrWTO9wo9tmB-5fB03zxOV=SCEqc800A@mail.gmail.com>
Subject: Re: [RESEND][PATCH 0/6] Add _opts variant for bpf_*_get_fd_by_id()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 4, 2022 at 6:18 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> NOTE: resending with libbpf_get_fd_opts test added to deny list for s390x.

it's not a resend if you change something in patches, it's a new
version, please mark it appropriately with v2 instead of [RESEND]

>
> Add the _opts variant for bpf_*_get_fd_by_id() functions, to be able to
> pass to the kernel more options, when requesting a fd of an eBPF object to
> the kernel.
>
> Pass the options through a newly introduced structure, bpf_get_fd_opts,
> which currently contains open_flags (the other two members are for
> compatibility and for padding).
>
> open_flags allows the caller to request specific permissions to access a
> map (e.g. read-only). This is useful for example in the situation where a
> map is write-protected.
>
> Besides patches 2-6, which introduce the new variants and the data
> structure, patch 1 fixes the LIBBPF_1.0.0 declaration in libbpf.map.
>
> Roberto Sassu (6):
>   libbpf: Fix LIBBPF_1.0.0 declaration in libbpf.map
>   libbpf: Define bpf_get_fd_opts and introduce
>     bpf_map_get_fd_by_id_opts()
>   libbpf: Introduce bpf_prog_get_fd_by_id_opts()
>   libbpf: Introduce bpf_btf_get_fd_by_id_opts()
>   libbpf: Introduce bpf_link_get_fd_by_id_opts()
>   selftests/bpf: Add tests for _opts variants of bpf_*_get_fd_by_id()
>
>  tools/lib/bpf/bpf.c                           | 47 +++++++++-
>  tools/lib/bpf/bpf.h                           | 16 ++++
>  tools/lib/bpf/libbpf.map                      |  6 +-
>  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>  .../bpf/prog_tests/libbpf_get_fd_opts.c       | 88 +++++++++++++++++++
>  .../bpf/progs/test_libbpf_get_fd_opts.c       | 36 ++++++++
>  6 files changed, 189 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_opts.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_opts.c
>
> --
> 2.25.1
>
