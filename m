Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1F6F5E0C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 May 2023 20:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjECSjr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 May 2023 14:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECSjq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 May 2023 14:39:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F1D4EDD;
        Wed,  3 May 2023 11:39:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f7a0818aeso908176166b.2;
        Wed, 03 May 2023 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683139184; x=1685731184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXawo9kiP+Vmzoz/c2lQQeKzlye9OM2UYu1dHvknnKI=;
        b=P5g/bc4CJxpECNiGqxkyLXl2+x+qXT/PsfKky592bnfOuaqHgctz1pzcGnk7c7DLnZ
         Gzc0Hpanaeq/vQIbd13QXdC59a3FWr6QSzLyePt81dZE6WZ+5vh4Sv80Mx16dm6IOjrR
         d+ZMEk7AvVPLGPFJ1k+0BD7CwwGzlQECTbpvZyIOhzTzmmoKObZlQlax8OvfOCYJDiNW
         +U5pwJ7ao1sl+qOm1RX3j+4U2sQmXbjfP2himr8IuoMYgYp8OzdKeHnHoFPrhX1rsf5m
         Bdj6V2AWvEAxoTb2IeiIo1Cbx69kfo7zi/80chUqTmKT8tdSP02tNURGpoaZ5cTyzva9
         393g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139184; x=1685731184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXawo9kiP+Vmzoz/c2lQQeKzlye9OM2UYu1dHvknnKI=;
        b=L7HxfH+wr0+eHqIXwRz4gsJuxCKBQQ4cCwKgbaoX8TK1eSoe8tHb/DjW+uGOfXH2Ho
         Hl5GK6q5NuoWkeoUHH9tFuQp97f0yAY72fvFc9Wp+ygYzhJRVaATWZ53hFXCMdseHQwg
         ONXIlLPnkeUBe9whipeUFjk0Ma1cv1rGtWNqs3agl9uy/ARJ8wuUSwCdgenWfJggMbVP
         WbBpMf0mEcfMuQx8uBK+Z1MuvNZD2AipuF7wSM5Bz0+vfQLTsfmFSA9iC2WSBDYn4m2z
         1A+Ki3YQb+MriQqN6RcqFfDuGnyZ1JCXxoFLURKQeKf7OO2KHcwRdQd3I6xSWyJooDEb
         Lyow==
X-Gm-Message-State: AC+VfDy44OizYVxzVF6suH/S91CnqdpXzuzypMhN+nBSW4ELz3h2fDDT
        FgZA2aikp5KRbdhF2C5KVE8uEk+f6hC658bnhIU=
X-Google-Smtp-Source: ACHHUZ4FqJhmXnUo/9MSvsx/rBHxAFjruUTH3c2eTKi/Fu9MUkFzjkK2ZGcho5F9Qo3igWXoBGNqZGNw/UV+gQwQJ7M=
X-Received: by 2002:a17:907:1b08:b0:957:1df0:9cbf with SMTP id
 mp8-20020a1709071b0800b009571df09cbfmr4694843ejc.19.1683139184132; Wed, 03
 May 2023 11:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <20230406004018.1439952-2-drosen@google.com>
 <CAEf4BzbyX3i6k5eL6D-5enU+u58nVn_fK28zNBJ4w_Vm-+RiMQ@mail.gmail.com>
 <CAADnVQ+jQG95kVqkajr=zz2-vs24XedEXcBgSx29oAjqUsFn2g@mail.gmail.com> <CA+PiJmST4WUH061KaxJ4kRL=fqy3X6+Wgb2E2rrLT5OYjUzxfQ@mail.gmail.com>
In-Reply-To: <CA+PiJmST4WUH061KaxJ4kRL=fqy3X6+Wgb2E2rrLT5OYjUzxfQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 May 2023 11:39:32 -0700
Message-ID: <CAEf4Bza3ONHzV0OPu2q17g7Z6w4PD8hMAmjP6ov-hKstt7r55A@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: verifier: Accept dynptr mem as mem in helpers
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

On Mon, May 1, 2023 at 6:12=E2=80=AFPM Daniel Rosenberg <drosen@google.com>=
 wrote:
>
> On Thu, Apr 6, 2023 at 3:13=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > +1
> > All of the DYNPTR_TYPE_FLAG_MASK flags cannot appear in type =3D=3D reg=
->type
> > here.
> > They are either dynamic flags inside bpf_dynptr_kern->size
> > or in arg_type.
> > Like in bpf_dynptr_from_mem_proto.
>
> Looking at this a bit more, I believe this is to enforce packet
> restrictions for DYNPTR_TYPE_SKB and DYNPTR_TYPE_XDP. When a helper
> function alters a packet, dynptr slices of it are invalidated. If I
> remove that annotation entirely, then the invalid_data_slice family of
> tests fail. bpf_dynptr_from_mem_proto is fine since that's just local
> dynptrs, which don't have any extra limitations.


Ah, ok, thanks for investigating!
