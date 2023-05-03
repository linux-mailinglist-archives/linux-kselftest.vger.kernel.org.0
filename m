Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7055F6F5BD3
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 May 2023 18:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjECQUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 May 2023 12:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECQUW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 May 2023 12:20:22 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F20F1;
        Wed,  3 May 2023 09:20:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac733b813fso11072891fa.1;
        Wed, 03 May 2023 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683130819; x=1685722819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oJaJ5PrPQ//M23xyU/2Ww+DvRXASYOAbGX+aLa2MYU=;
        b=bdOJPXjBlqb0/dMsX2NYbIAlgrxtqJu8zmOrfNCF1LdlCtEyW9RAD29prQ/tuboOwW
         lKD4sGtroNz8cEWGZwPiEA9J/gz0vPyApifltLMcuu1I77XI9PGnkwhd4JAzx0eOQXrq
         ysW2X0E8pjnrziM8T8o9NjKhQ8QFVgnwhzC4R1rjnirPTjnlJWoU2hf2Iodhi0hWZG8z
         wf7ImB4qOfNVc5lRggFlhs1iBWPmcYF8NhfTOIQK6M61G8Gj80pB/VlpkwiHQzC+N5Sf
         GR7DGoF8OnDotqOHFaxzm4UOl7TIi+abBSTuGL8uuIRVeP+J4b5p0h8uIAVYAC8YFqMI
         821A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683130819; x=1685722819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oJaJ5PrPQ//M23xyU/2Ww+DvRXASYOAbGX+aLa2MYU=;
        b=NU+qyDEtxQD+roQncjeYxzEFE0rfw3i367+RuHqCmdYH2MWX1bhKkyLMhuDCxPn7g5
         6KsXuGk9i8TqrhEQmJgCVezSnqcMMNyyoikm1eIZZ3zXzCJqFIYAQmzLg2uQ9aLYzfO5
         qzt26A0Nt1nqUhxjq03JpQrnuNxYsrZkzKLaQWoGlPqr23/DfL4BeSM0/ap4SGiCdYju
         66DVNNp4MtmrL03N0tEAHzNQ17HM/5fYeUXoTecNAgbbrJdxnKfY+uuC4lfYjdUDKIKf
         +RdTiKx0PN1vt+lxSZ7WCV6iZ5Akl0K8PAZJ5t5F8KB41Wh9Dn5oBgiBgLxiaAEy4rMH
         17VQ==
X-Gm-Message-State: AC+VfDxJNJOJMoqn+zrTpU4KxHFv4KCjYeoGXF/gNLNIJqHPNVAJatV/
        Kzt+qE2lPfHDyyYgT/ZfVW7qU904qGCAreKEzhM=
X-Google-Smtp-Source: ACHHUZ6eGbSsOsju0SsuWwgDT+dCIW84R4PDyIme2zBsu+/jH2ZQU27gtEqS9w3emhQAXI67NhEEKnewD3vKp6TMMI0=
X-Received: by 2002:a2e:7d12:0:b0:2a7:768c:f5ac with SMTP id
 y18-20020a2e7d12000000b002a7768cf5acmr171925ljc.32.1683130818885; Wed, 03 May
 2023 09:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230502005218.3627530-1-drosen@google.com> <20230502005218.3627530-2-drosen@google.com>
In-Reply-To: <20230502005218.3627530-2-drosen@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 3 May 2023 09:20:07 -0700
Message-ID: <CAADnVQ+KJgnB-aPKsZuMGyJ5Sp+FCzANBjoZqNuoZ8A5bzLqvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selftests/bpf: Test allowing NULL buffer in dynptr slice
To:     Daniel Rosenberg <drosen@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
        Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 1, 2023 at 5:52=E2=80=AFPM Daniel Rosenberg <drosen@google.com>=
 wrote:
>
> bpf_dynptr_slice(_rw) no longer requires a buffer for verification. If th=
e
> buffer is needed, but not present, the function will return NULL.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/dynptr.c |  1 +
>  .../selftests/bpf/progs/dynptr_success.c        | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
> index d176c34a7d2e..ac1fcaddcddf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -20,6 +20,7 @@ static struct {
>         {"test_ringbuf", SETUP_SYSCALL_SLEEP},
>         {"test_skb_readonly", SETUP_SKB_PROG},
>         {"test_dynptr_skb_data", SETUP_SKB_PROG},
> +       {"test_dynptr_skb_no_buff", SETUP_SKB_PROG},
>  };

Please rebase and resubmit targeting bpf-next and with [PATCH bpf-next] sub=
ject.

It doesn't apply:
Using index info to reconstruct a base tree...
M    tools/testing/selftests/bpf/prog_tests/dynptr.c
M    tools/testing/selftests/bpf/progs/dynptr_success.c
Falling back to patching base and 3-way merge...
Auto-merging tools/testing/selftests/bpf/progs/dynptr_success.c
CONFLICT (content): Merge conflict in
tools/testing/selftests/bpf/progs/dynptr_success.c
Auto-merging tools/testing/selftests/bpf/prog_tests/dynptr.c
CONFLICT (content): Merge conflict in
tools/testing/selftests/bpf/prog_tests/dynptr.c
error: Failed to merge in the changes.
Patch failed at 0002 selftests/bpf: Test allowing NULL buffer in dynptr sli=
ce
