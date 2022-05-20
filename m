Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81E52F246
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 May 2022 20:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiETSNk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 14:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352491AbiETSNi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 14:13:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9172E18FF11
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 11:13:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg11so11738526edb.11
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diEsMUAPJX4u0FJo9NkDwZ5Xz9iATJQSF3lAp/gYU1A=;
        b=I87RLcljCH0RuSbiTrRQexejctdo+oMuIRy59YA+r+nR+yZwS2t6yeUqhQNO3I0sho
         0kvV9fopy2diCllarPTabCkUVUGiHFwYWAYnpqsf7Pa7SmkSmgcM/rzj7catq+4TMWVq
         EOkLlq6rMWfkrLiGFfbgaoxEz78RbWy5Oc2a54iNQCB2Z21hIlbfiTzpkuWY21YUjOEi
         dmYO4mZ0+WM6qw5mmauUQf69pAkPy5b5D915wxqgN/EmALrVJq6ly76nBGi5VWw8gjcI
         4O3Ns1t1LgkRbhOcQmhON3hCYwT5gZGIJh2HAja7zlFXEjHIUtl5AWU9yAa2BjipS9x3
         BCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diEsMUAPJX4u0FJo9NkDwZ5Xz9iATJQSF3lAp/gYU1A=;
        b=7Iq7ZpAcBh9m9ez2odudxiZeZPbSn9tk9R87RnIM5ldrBwdVqTaAXFotP1K+EXCgMt
         XpHqfe44xc6tYLULmZd/BHFjbiH3/JpBRLhdkXF1t+ryn+2jPU6LYwE2EbxuCIderfde
         roduhpY4HxtqTvoMD8w5L9zrWnhnOy60ceF2dJ0j7XE/uu5VvVnab8vPn398C8d10N0Q
         TMrvwzzHeUF8jeU0UoN81WsbvGwGXGsHLTnAsnt453Fe4EsVr5F+CDE4PFrXH6FtDCeX
         Q1Xpc08Me7i1sEfluzWhoecsFmNbozwdsHBtbIBIi52wZRqTHdnElHfjki26qLmSxb4Z
         e7Iw==
X-Gm-Message-State: AOAM533gOjH+ZgxTMWFmV1vvMCPIuK6H1fu4cAisU9KWdOz+gWxGRycf
        L1fKCQfQXGmraQWujsr31Wgyw1SNP3nR62lkAO4Mra2om00ASg==
X-Google-Smtp-Source: ABdhPJyJ9aD1+buOd6X23qPr2SUjHKZOvsxBvuzgTQCHrWKd4i4H+xLKXa2OUWjgWol3otPNS4gl1fDpDbZoTdNYgOc=
X-Received: by 2002:a05:6402:84a:b0:426:262d:967e with SMTP id
 b10-20020a056402084a00b00426262d967emr12527519edz.286.1653070410982; Fri, 20
 May 2022 11:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220519164512.3180360-1-dlatypov@google.com> <CABVgOSnooocLsy2=a8rm7Y_m3DpffKtDam5_uYou+Y2tUkumRw@mail.gmail.com>
In-Reply-To: <CABVgOSnooocLsy2=a8rm7Y_m3DpffKtDam5_uYou+Y2tUkumRw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 20 May 2022 11:13:19 -0700
Message-ID: <CAGS_qxrDYKKoWy3UAuVqebT+3jp-ux_uyfbwX3OnJqVbnzaiJg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: refactor internal kconfig handling, allow overriding
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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

On Thu, May 19, 2022 at 11:13 PM David Gow <davidgow@google.com> wrote:
>
> I like this, but do think there are a few gaps this doesn't handle
> properly. (Though exactly how we'd deal with them, I'm not yet sure.)
>
> In particular, it's not possible to disable a pair of options where
> one depends on the other: disabling the parent option will result in
> the child one not being present in the generated config. This will
> conflict both with "=y" and "=n/not set": we'd need a way to _remove_
> a kconfig option for that to work.

Do you have an example?
Because what you describe sounds like how we want it to work, but I'm
not sure if I'm misunderstanding the scenario you describe.

I was considering the case mentioned in the commit description.
I.e. we do --kunitconfig_add=CONFIG_KUNIT=n to the default kunitconfig.
That gives us complaints about these
 CONFIG_KUNIT_EXAMPLE_TEST=y, CONFIG_KUNIT_TEST=y,
 CONFIG_KUNIT_ALL_TESTS=y
options no longer being in the generated .config.
And I think that's exactly how it _should_ work, as this flag is a
low-level tool for tweaking individual options.

IMO, anything complicated should be done by editing the
kunitconfig/qemu_config files, in which case it's a lot less
cumbersome to disable multiple options by just deleting them.

Daniel
