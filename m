Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAF72EF18
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 00:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjFMWUY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 18:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjFMWUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 18:20:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E8E1FCE;
        Tue, 13 Jun 2023 15:20:06 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b1ac373c9eso344491fa.0;
        Tue, 13 Jun 2023 15:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686694805; x=1689286805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYeMigch2qnrSoGYhm73AILcfdoJpBTi7JKRyKYYyCk=;
        b=PZCesWE4DaYOP18PmGDorKj9OLJ3ApomZcQzCge4oFExlX8JTrnjBV/KTYwd05NoAP
         KKeVhguMor5LJsM2yCCJ8PUW2w1Dq/yqjioNmhkUQmOpcCZTnk1K48r8I5LomoRpIThu
         Xwl/7j4WMhEbZfouIdiGnJyrEcwY6bdiYCWD9fymCGPiIoMCSEEKaldqqdeCNp99UvEi
         CaeFH1WLWuiAe9q+MF5bWzUj4+3CXjwAg6x1poUjQ3aWf6qcW2Pnu0aUGeWN+lf8OVYU
         ANUfZokY/ed1pKKYBkkS0bELeIcZOSFnH2ly0YthjYXw+Qn/XHkA9c+pOrM4zT1UVB3y
         kfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686694805; x=1689286805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYeMigch2qnrSoGYhm73AILcfdoJpBTi7JKRyKYYyCk=;
        b=eUR/LM7BfjkjEn/WgUgYNoLa6YPrSB4mpLyN4YghA/bkEyxpw7L/lohEr2A2ZZ7M8n
         1bTDRKEa3mr3wzUjxPfRu+qfu2ho9pk/vBobSWoGaU9lElV1hgCqvI9Z+VdPHr7BO+wN
         o7Onkrs/EQ4Y+kLrKNUKF2r3dcoQiTXKJrNwaDTWtjTjmJcQzkCy3mysEPy1f/mjFkI/
         hnIoQLcv1rBJrzQPoT8zLMIJ7YRcBjQ8/KXFxPMzGTHbiPw1zbg2oFHsA+1TAqkC36AK
         S68BoCvm8tW9Yzt/tDEGjkAyK2nz/KOUkEWi6Jr15KNcBHzWyimswMqqdGvD8S+NDNnF
         Cr4A==
X-Gm-Message-State: AC+VfDwIAjuddBIIqlLEZHbFvfmtbNn4p524GTL+J2GEbA2G3xJXUIAt
        oUrzgWa0VEqCPhMhysMmjntW04WkGh3r4exM/iv+Nxrt
X-Google-Smtp-Source: ACHHUZ4F2wBvbvprp7cHLESqQNB/qMvpDKYm5iumWiUbmHKZoPtfFVUNgGzg4Muy+I8sfB5rKe5k4wY2KmiQaJZu8h0=
X-Received: by 2002:a2e:a0ce:0:b0:2af:1dd5:b068 with SMTP id
 f14-20020a2ea0ce000000b002af1dd5b068mr5939374ljm.48.1686694804634; Tue, 13
 Jun 2023 15:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686616663.git.kjlx@templeofstupid.com> <6de9b2f4b4724ef56efbb0339daaa66c8b68b1e7.1686616663.git.kjlx@templeofstupid.com>
In-Reply-To: <6de9b2f4b4724ef56efbb0339daaa66c8b68b1e7.1686616663.git.kjlx@templeofstupid.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 13 Jun 2023 15:19:52 -0700
Message-ID: <CAADnVQ+ewk9QHobAMisC5=gT=sfTSzbx029Ahgc5ZUzGuyH6cQ@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: ensure main program has an extable
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
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

On Mon, Jun 12, 2023 at 5:44=E2=80=AFPM Krister Johansen
<kjlx@templeofstupid.com> wrote:
>
> When subprograms are in use, the main program is not jit'd after the
> subprograms because jit_subprogs sets a value for prog->bpf_func upon
> success.  Subsequent calls to the JIT are bypassed when this value is
> non-NULL.  This leads to a situation where the main program and its
> func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
> has an extable.  Extables are only created during JIT.  Now there are
> two nearly identical program ksym entries in the tree, but only one has
> an extable.  Depending upon how the entries are placed, there's a chance
> that a fault will call search_extable on the aux with the NULL entry.
>
> Since jit_subprogs already copies state from func[0] to the main
> program, include the extable pointer in this state duplication.
> Additionally, ensure that the copy of the main program in func[0] is not
> added to the bpf_prog_kallsyms table. Instead, let the main program get
> added later in bpf_prog_load().  This ensures there is only a single
> copy of the main program in the kallsyms table, and that its tag matches
> the tag observed by tooling like bpftool.
>
> Cc: stable@vger.kernel.org
> Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function progra=
ms")
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied. Thanks
