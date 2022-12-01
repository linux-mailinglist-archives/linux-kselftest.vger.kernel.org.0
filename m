Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B263E6C1
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 01:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLAAzw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 19:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiLAAzr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 19:55:47 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B1889ADA;
        Wed, 30 Nov 2022 16:55:43 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bj12so554507ejb.13;
        Wed, 30 Nov 2022 16:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1qYXzLGJu2XqjP11e47hiFXp8VFuiRkRBZDY257xsSg=;
        b=Zaud8nuqZMCi4yRpCk9SR/EytQ07lJDENUlZX9ogHuu8P93DML7KWhEKAkBuf7Z0/B
         tQRRPyFXPRka7LGcqVjlzDAfb34MUV/D1pxVZeCgW4cPbTOvXWo8+GZ3w6mUbfsHxqY4
         PXOZJW0bIs6A+XBIK8MjbBq4/bMXnR4ihMKRaaIXT6Yy0vD4hdBs5+2+3ZF4vh993hcp
         V2R2sWHNOcRxAi/B71VVRaDj2FT4TmetsggCumRaq3OPIx10eDJiE3so7SoMP+LFf0QT
         lhXLcj/uHNE2zn+kFCqcVbx5LioEDa+LzvXSe7thKZsmM98JIvJ88MQWUCpLBR054f66
         taJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qYXzLGJu2XqjP11e47hiFXp8VFuiRkRBZDY257xsSg=;
        b=6594InQAZkcjUgYoCM7l9bFQP1narT3O4T+HaEV67orpi1Dh04wBWCKYi1OOZp3cI5
         g9oUknnyw/EN1s3QsRMCVVjhUCYCGgNiB2VuV95eh2WiiLXo9QNJSKRPWZE44mX1sanN
         kroq/7uI2QvCYQ5KM9Oh8SRPjuLk/Ak5Ok+tr43VDmaDGUG7Snt/Au2tKal9sivLm1JC
         JDiDa4ocWixa3oSadyORuE4389dQLvCXdc7SKwWbxfqYS9TVx5Ceu31u7GHWXUFK7Vje
         THjEWcNwXnkeFAwgBHBb1AKw2Q+UqL0/vdv10lJ9kp/jiODi5gqI1Ief+ShCDEI+8Gtd
         ikPg==
X-Gm-Message-State: ANoB5plRPOBE70UXbzwyVQUJQWGdtD+5sgCyDDnmXQJCHSkMNWw5AmxX
        RvWZkdEQiGRTUWF0Y62L1EUnHwd/cO63QuRx2r8=
X-Google-Smtp-Source: AA0mqf6bzEwgYGnidcSo+09yD5kU8PvKK726XKN4nGP/wJrfCD7hhCYBxgRq0g7VxBFAwwduYwJwQc8Z7Xap1jq2HB8=
X-Received: by 2002:a17:906:94e:b0:7ba:4617:3f17 with SMTP id
 j14-20020a170906094e00b007ba46173f17mr31849780ejd.226.1669856141413; Wed, 30
 Nov 2022 16:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20221129134217.52767-1-changbin.du@gmail.com>
In-Reply-To: <20221129134217.52767-1-changbin.du@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 16:55:28 -0800
Message-ID: <CAEf4BzbRwom3dp1Vqkjk6ueshaemVUWtr46T1rRw50t9U8OD6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] bpftool: improve error handing for missing .BTF section
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
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

On Tue, Nov 29, 2022 at 5:42 AM Changbin Du <changbin.du@gmail.com> wrote:
>

please fill out cover letter


> v2:
>  - remove vmlinux specific error info.
>  - use builtin target .DELETE_ON_ERROR: to delete empty vmlinux.h
>
> Changbin Du (2):
>   libbpf: show error info about missing ".BTF" section
>   bpf: makefiles: do not generate empty vmlinux.h
>
>  tools/bpf/bpftool/Makefile           | 3 +++
>  tools/lib/bpf/btf.c                  | 1 +
>  tools/perf/Makefile.perf             | 2 ++
>  tools/testing/selftests/bpf/Makefile | 3 +++
>  4 files changed, 9 insertions(+)
>
> --
> 2.37.2
>
