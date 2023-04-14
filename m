Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5ABB6E1B4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 06:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjDNE4o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 00:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDNE4a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 00:56:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB826A70;
        Thu, 13 Apr 2023 21:56:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id xi5so42685036ejb.13;
        Thu, 13 Apr 2023 21:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681448172; x=1684040172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOahN4QlawcFehI7bLkgrg/iclvzg8ErEBM3r/6qSpk=;
        b=CrORqfpgEv8CcZlXgF/ZZDgOnffuc+L7LYhC7/5nNBokxAsYwWGd2SiMnIDh06t/yn
         G0ISeD9fIQso5ekz4J1JfFRORTNa6aEcTAl2cgvewdhKtfiONANh7mAFaNXOFwi8mZCM
         Mjz4Rz/lbBn3jW1jecVUvMmuvet8mZChBaqe8tfA8p9geD0b2y61pVpH5dXgoVggy3q7
         ecqW2ZO20JUowb8SaK5Et45JXOFKvaHBy760qPV7syOJzTiYT4T6SWFy6XRiThAV0vmD
         XyUy2cc1Z/uaKnivvTjK6cl5plFMrhqrGsoJXhZjOjIewP5xIjppd50z0w2IlgCIqiv0
         8N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681448172; x=1684040172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOahN4QlawcFehI7bLkgrg/iclvzg8ErEBM3r/6qSpk=;
        b=k6S6OCjOJVCWHM0RBVGjvvH5syelOZmPQ9DlyY3ONgOyKeoZ1eRrfJzCb7TSabTNyM
         ALNTTu/4ryTgOxEXxDzz4xhg16CH9iTxZpPqhGYPNYyKogoscTS50Kd3EcAx9Rynke31
         ANYIfsNG9mtwkwsSMHZpyt7tiP3NDJ5t6V+Ke86tBUM2ykCEEZ6J83XUEqhfHFWQ+UVv
         fq9E4fM0LK6+BJj5AwY1Quuyc11+dHv0Nr6XpA93nHOlMz7Xy/mv/5lQ7dg+BOrAB7s0
         ZrQriojRjSLImZcOhPH4lULTViTqgNtgwB07wmwhj8pLII8DGUrDAn0H9dSmO/ejp6Wy
         E1zQ==
X-Gm-Message-State: AAQBX9dSpH8TQ0oN5GDC0jOQ/azL2EjFZUE8xtr9rEgESVcjKEFC/KnZ
        gkUrJuBQsv+1MBbmHsvocpQHxJdoUMpSdZs12m8=
X-Google-Smtp-Source: AKy350YveSCh9e1itePQiC1fiBDMPTPosSx9uzFJv5U8GqasjFL8eDOOPHlNN4hQfkj2UU2eQ6eYskxDGzTh/tVAEsU=
X-Received: by 2002:a17:907:968c:b0:94a:87d6:d39a with SMTP id
 hd12-20020a170907968c00b0094a87d6d39amr2519987ejc.3.1681448171913; Thu, 13
 Apr 2023 21:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230412095912.188453-1-andrea.righi@canonical.com>
In-Reply-To: <20230412095912.188453-1-andrea.righi@canonical.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 13 Apr 2023 21:56:00 -0700
Message-ID: <CAADnVQJ00Npkp=+XYaTybzaPnrcfK0nKrePAktVNBt2-YqWdEg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: ignore pointer types check with clang
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 12, 2023 at 2:59=E2=80=AFAM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> Building bpf selftests with clang can trigger errors like the following:
>
>   CLNG-BPF [test_maps] bpf_iter_netlink.bpf.o
> progs/bpf_iter_netlink.c:32:4: error: incompatible pointer types assignin=
g to 'struct sock *' from 'struct sock___17 *' [-Werror,-Wincompatible-poin=
ter-types]
>         s =3D &nlk->sk;
>           ^ ~~~~~~~~
> 1 error generated.

I cannot reproduce this and BPF CI doesn't complain about it either.
What kind of clang do you use?
Some special version and build flags?
