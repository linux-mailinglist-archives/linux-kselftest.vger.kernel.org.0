Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0B7758907
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 01:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjGRXW5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 19:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGRXWw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 19:22:52 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20C0EC;
        Tue, 18 Jul 2023 16:22:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso62163061fa.1;
        Tue, 18 Jul 2023 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689722570; x=1692314570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2owPjOsknzvkS4L5ZSPonWRfNu9HLT/sQNV5ahQc2RA=;
        b=Q82+ha22FbALhLDWrrhpK9q5yMPG07MW8A2B5DYAvE9QNdMmkNHG8ZCQ2QNjwGPOYq
         4iwCYgaYSz0Sjpr/BrsOlMBV7Xo99Yh5FDSS4s/xj/cCCKV3U1D2vdzm6g6DfwwgSRCu
         6LnpYWW9mHhSN1CIErqmBNlS0g90YJIy7Z/UEUxNgSVzJXxyPvCnhtLWV2LjHTpf/rHi
         4oXiNRRLNecG9RNKDzM9wl+6iqQb+U1DkAt99x7ANLE8t64/LH06O5309AXv8OV8DuNa
         4en/Vq/3weqoGCge6bhdXi/LdWOA1zcDnKmpwHp7M9Zu3XM0M0uE3v0QAJm6OmoqV2sT
         XyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689722570; x=1692314570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2owPjOsknzvkS4L5ZSPonWRfNu9HLT/sQNV5ahQc2RA=;
        b=V3eHn3LiaXiZRZoD6ZQXGnD8KNhjXKAO2A4QWNDA6O0khP4jl/hxkMrEO1vDkHuopX
         N1CyqbteQ4yeB7wrVq1L4o1vjS6pxtH3E7Ku2tsUzanFOSGNmtZ0g9JabwWaH66R5X5J
         pZ/TzoRJO/pKSMMCOYjNQSgFGxCMz8ArDNzqrfJC04urAYjFietGOF6qRDV7c8C6xc3h
         irimVrjubBfCmoxN9nsgUJlQpJVl/5/Jdm6karK4nLqN6ds5GA+JMbZH6dBnKUOpbLGU
         omQ+/4Xxv2eJeLQ8+H7xlIO/gc16d34W89GKBTxO9a1Ek/9JUfsYPuKnAx/nbW4OmKi/
         HNAw==
X-Gm-Message-State: ABy/qLYD59CKGAa/Ys8++oWLthPW5YIl7GAdfUGY+JBo6G6JkA+2Sab1
        jTo4HCPePuDAe+RPAWaH0s/9IPajZOP+/z6wsyk=
X-Google-Smtp-Source: APBJJlGpzSgPClsd2m+CYvKqmu/ee+SbsjKc1wf/vDbxh3cDC5D1so2fh0hZrPZfcx1svTrzHWUgIayRTAbGxwzhdoc=
X-Received: by 2002:a2e:80ca:0:b0:2b4:6eb0:2a27 with SMTP id
 r10-20020a2e80ca000000b002b46eb02a27mr15608676ljg.17.1689722569556; Tue, 18
 Jul 2023 16:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230502005218.3627530-1-drosen@google.com> <20230718082615.08448806@kernel.org>
 <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
 <20230718090632.4590bae3@kernel.org> <CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
 <20230718101841.146efae0@kernel.org> <CAADnVQ+jAo4V-Pa9_LhJEwG0QquL-Ld5S99v3LNUtgkiiYwfzw@mail.gmail.com>
 <20230718111101.57b1d411@kernel.org> <CAADnVQLJBiB7pWDTDNgQW_an+YoB61xkNEsa5g8p6zTy-mAG7Q@mail.gmail.com>
 <20230718160612.71f09752@kernel.org> <CAADnVQ+3Bmm0DgGBgh_zkA1JeK7uApo_nnJ+=Sgf4ojGX2KrHQ@mail.gmail.com>
 <20230718162138.24329391@kernel.org>
In-Reply-To: <20230718162138.24329391@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Jul 2023 16:22:38 -0700
Message-ID: <CAADnVQKD6T2AL1xgJgmXfyXqeTWQwNV0KBNd4Apiyfqg0aQ1vQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 4:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 18 Jul 2023 16:17:24 -0700 Alexei Starovoitov wrote:
> > Which would encourage bnxt-like hacks.
> > I don't like it tbh.
> > At least skb_pointer_if_linear() has a clear meaning.
> > It's more run-time overhead, since buffer__opt is checked early,
> > but that's ok.
>
> Alright, your version fine by me, too. Thanks!

ok. will send it officially soon.
