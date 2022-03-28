Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D64E9CE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 18:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbiC1Q40 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 12:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243671AbiC1Q4Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 12:56:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B34CD4B
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 09:54:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b24so17633449edu.10
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+3U/vned9HkTyfTaMmIcrVKk2BnMz3lKHdfaoCgpb0=;
        b=pjapL1jB0Bzc43euAW7NnZgfYJn+m6AKQ+qvrWGyx/40n4QMmUcpxefze/vNflYMSG
         +1rjux4wGSGxDVdFjAUg23PfqLJdoGpdgW73WWc6w0+8Tmh/7pyRU4kW2ZYoM/cl2Im1
         aN44nucKSXF10fJT5bqb7s0jaYhe1LAF9fq5DhF+BLx984P/y+XRuqYJsIh3I/dIYl7V
         CON23UvNdW/HHgSxMvLFw2A5zJqUkVqgGhkeTgIeu2dEX/nXQsKxkXEMlMyzeXu3WULW
         CpavXM5Q8LdC5dr1oOBUhho+vOmgS9UTQ2aSMUyDdMV4pr1iuvqJi6gO1828pssJ0/bF
         7RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+3U/vned9HkTyfTaMmIcrVKk2BnMz3lKHdfaoCgpb0=;
        b=eayKzQ6efo+cpWqBjX7iggMdMKmq5isG5OL8h5KE78sJMMArL3jeaDgtd2Thfw+dv1
         RkqGw2OxhjqhT67kecf5Fl7Q6qIdwyXSD0o0EDjta6r18MgiOrVTTeN1dSlHpGcmg39A
         kKouR01qnmKOIDixTd34Kh5klrqn8fq2F7wbHDBnCm7NeN9XHmCHYFQDftjdQbd8z0wi
         Rrpxmho0m1qbuIMGj0Oj9m6qiowwuYBuRtdgxKHrbMOgquMrXe1sLBhCQQm9K09x/Yy4
         7wPWIrx1KSLdkp20DU/oPi1nRDMrTu6QD39t2gNXrTaRzg4Ke+IMp1kcQ7tU2RdsbOR6
         KM5g==
X-Gm-Message-State: AOAM533p1kLBtefNUlrnFOtZvUvhNDIC/FNUVZgayUrPtLfWY2Pe92zd
        E2asg16qSZ+edrxryIHxy0MtFd8P7rTz+6VH2607Cw==
X-Google-Smtp-Source: ABdhPJyaviXVKiOGRFommlh51L/M5pChybEslM2SsXlhUC7gov1a9lrFdqwwV6iQ75H8dKgB8//d8wSMsf7HN+96QkQ=
X-Received: by 2002:a50:d949:0:b0:418:ecfe:8c25 with SMTP id
 u9-20020a50d949000000b00418ecfe8c25mr17467328edj.156.1648486482209; Mon, 28
 Mar 2022 09:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220326003356.487828-1-dlatypov@google.com> <CABVgOSmbQxZmmNtUQLsvMSPkr2FpXB_kdJUUbC=nLrt6xN7e2A@mail.gmail.com>
 <CAGS_qxq_vFtGS4BGieZz8L3QH7rZ7ZN25pGYmjWWoXbTGOKC9A@mail.gmail.com>
In-Reply-To: <CAGS_qxq_vFtGS4BGieZz8L3QH7rZ7ZN25pGYmjWWoXbTGOKC9A@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Mar 2022 12:54:30 -0400
Message-ID: <CAFd5g45f3X3xF2vz2BkTHRqOC4uW6GZxtUUMaP5mwwbK8uNVtA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: update kconfig options needed for
 UML coverage
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, maxime@cerno.tech
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 28, 2022 at 12:35 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, Mar 25, 2022 at 9:56 PM David Gow <davidgow@google.com> wrote:
> >
>
> <snip>
>
> > >         # Append coverage options to the current config
> > > -       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> > > +       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> > >         $ ./tools/testing/kunit/kunit.py run
> >
> > Would we want to instead use a chain of --kconfig_add arguments? (I
> > think there are advantages either way...)
>
> I've been considering this ever since the --kconfig_add patch was accepted.
> It's more compatible w/ commands using --kunitconfig, but it also
> looks very verbose.
> E.g. it looks like
>
> $ tools/testing/kunit/kunit.py run --make_options=CC=/usr/bin/gcc-6
> --kconfig_add=CONFIG_DEBUG_INFO=y
> --kconfig_add=CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> --kconfig_add=CONFIG_GCOV=y

I don't think it's *that* much more verbose, but I see your point. I
personally prefer this, but not enough to argue about it.

> Neither looks very appealing to me, so I've just kept it as-is for now.
>
> Maybe there's something we can do to make this easier (e.g. allowing
> --kunitconfig to be repeated and mergable)?

I would like --kunitconfig to be repeadable and mergable.
