Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5CD5266F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 18:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379849AbiEMQZ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358848AbiEMQZ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 12:25:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612D48E199
        for <linux-kselftest@vger.kernel.org>; Fri, 13 May 2022 09:25:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d6so10590649ede.8
        for <linux-kselftest@vger.kernel.org>; Fri, 13 May 2022 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYIE3zQpUPgi6v7iFVdQ2/TvPUcauYhfaGvlN50Rhro=;
        b=iY1k9LtTjSRyhsBlrL/e+liP2aDYDcihjvvw+2UVcBUKOAKoTwNzi39/GXjBIzyfbm
         6S8rz21bB1xCh/5l10W4z6UeRBLwWakJKIrJ03lk0GtkOzUB4z3uPPp2MOcb83RDD/qE
         Ilh0kPea9v0B4O5FFuR2RJfdum3iphLZWot1+oBUVpbD4y8ZLpPFYv+ukyRz2dSMnFHn
         KTfKVA7MLp5K8i2CEYGAmI80pggKs19ZvlcgHZu2+C4I1QtKcPNO/XAyqjFzft3hj0/G
         AFIXfqilaYIUzXH2z1+p/dm8czDIW5QbTUjjCVwGg0DGp3fyQGtV5HC47X3lpsKW4eZ/
         pUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYIE3zQpUPgi6v7iFVdQ2/TvPUcauYhfaGvlN50Rhro=;
        b=ivBnD50jBpKfDXTuHn3n6BfSguNuqNfCIIdfiHIilrwAyxuo6Qdtr3YykdBOHTMPPI
         WvjDn9EWYhsVYPe/cKJ4quQRBnMOrXOFXN3xpaO6RrfuGTlVstoWDmkbeF4ar+/qdiKL
         wE8UglkQbSGcrdAy+G7zMKHu9hLRJDfEgVwIYh1PbTX9LcIdsBW6J8OzhnYtr3ydgYUB
         M1kfa9Zgc6YKldkWai8GClPG1rmESFfyqPvHAWdOi2ClIRmeAolXX7QxeYheXsqhon8X
         6MoP89JcYAUgO6k1XXc0Wg6534A9wS1F1SvR/+f7uoQdG5kjonVcAGd8X5/G2IghBZhg
         0NlQ==
X-Gm-Message-State: AOAM530gfsdwmhxlyRncna1k0GmtpsyMFrlB6jbnUo9Du4+OEIGXE7Ee
        CRJaA8LghZTmTyHbDXbqgYz7bTkIyuNIbt1uzcTtiw==
X-Google-Smtp-Source: ABdhPJxcalzPWuWqmf11ZGrcsZTJjFfxrs2j0NUMCf2o8rzmJ3qPfEI4lFkfRh12epJW9zvfRqKiQGKH6kkzvjJydzQ=
X-Received: by 2002:a05:6402:28b6:b0:425:e137:e31a with SMTP id
 eg54-20020a05640228b600b00425e137e31amr41336129edb.215.1652459124752; Fri, 13
 May 2022 09:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220502192327.81153-1-dlatypov@google.com> <87ilqa6sjo.fsf@mpe.ellerman.id.au>
In-Reply-To: <87ilqa6sjo.fsf@mpe.ellerman.id.au>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 13 May 2022 09:25:13 -0700
Message-ID: <CAGS_qxq=O_npmyKHMSS_erzbh8O9TojCVYxyf7muEJaHOfDBjg@mail.gmail.com>
Subject: Re: [PATCH] lib/atomic64_test.c: convert to use KUnit
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
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

On Thu, May 12, 2022 at 8:06 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Daniel Latypov <dlatypov@google.com> writes:
> > The test currently is a bunch of checks (implemented using BUG_ON())
> > that can be built into the kernel or as a module.
> >
> > Convert it to a KUnit test, which can also run in both modes.
> > From a user's perspective, this change adds a CONFIG_KUNIT=y dep and
> > changes the output format of the test [1]. The test itself is the same.
> ...
>
> I don't know why I got Cc'ed on this :), but I gave it a quick test anyway.
>
> Seems to work fine on a Power9.
> I also flipped some of the conditionals to make sure failure is detected
> correctly.
>
> Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks!

You were just the last person to have made a real change to this file [1].
The people signing off no commits seemed inconsistent and
get_maintainers didn't give anything back.

commit ffba19ccae8d98beb0a17345a0b1ee9e415b23b8
Author: Michael Ellerman <mpe@ellerman.id.au>
Date:   Fri Jul 14 14:49:41 2017 -0700

>
>
> > Meta:
> > 1. this patch applies on top of the kunit branch,
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit
> >
> > 2. checkpatch complains about aligning with parens, but it wants me to
> > indent the `#ifdef CONFIG_X86_64` which seems inappropriate in context.
> >
> > 3. this file doesn't seem to have a clear maintainer, so I assume this
> > conversion is fine to go through the kunit branch.
>
> I think you want to at least Cc the atomic folks:
>
> ATOMIC INFRASTRUCTURE
> M:      Will Deacon <will@kernel.org>
> M:      Peter Zijlstra <peterz@infradead.org>
> R:      Boqun Feng <boqun.feng@gmail.com>
> R:      Mark Rutland <mark.rutland@arm.com>
> L:      linux-kernel@vger.kernel.org
> S:      Maintained

Ah, thanks for the pointer.

I'll see if I can add
  F:      lib/atomic64_test.c
to that entry so this files owners get tracked properly.

Daniel
