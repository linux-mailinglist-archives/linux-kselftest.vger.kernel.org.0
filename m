Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90A4616A6F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 18:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiKBRS0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 13:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiKBRSW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 13:18:22 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE37192
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 10:18:20 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id d3so25966423ljl.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 10:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RknuEqUoiunPXi2OLjUbhlEwq60lRe2RTsR6hdfQJ0Y=;
        b=RRnZ2dze/6CLhyKFhxGEw08Ckp4XwE8DWxZ0rZxAOcMdf5vdt9kUpYu0i/LLqPGehj
         pYwLBE+/5Qto0rQ3PGtpUP8z7cfs5Z97tOSErjIiA7F6Gr0KhuXI0VS03iRzDSRFYUNa
         ZtYLM10ihngzyi4eQW3AMFVgmfH2JF5B4VVzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RknuEqUoiunPXi2OLjUbhlEwq60lRe2RTsR6hdfQJ0Y=;
        b=DGYVmD/Ue7/ZrErrDGV58ZgMLW7S5b+BANe3S4Z53SQ1kOOX7IaKDrUSjrGGwPKtSC
         a1LlAdofdHXv7sGhh7U1z0CGw0aMYZbFkogHJEpfnWBK0gMBJjkl92R7N5IzFnkJIGyF
         9ufs/sq6PzFT3LerWWZBwXx7jBw6yAgSy1N5j8y9DANDVDnaIOk8p9kiuycXgfb7aol0
         pqiQKPqehYx7BstMxtcrQ/L7oQRRqPiKilv8pLfJ6W80446DkBq2g+50q5vfWrVwMZyh
         d6BYs56sKY+A99W7lYIVA/Er7SXOv0Gp2EGVDP+Ce/1SPrlZdpP+nMvyOc9pDuC1/UJS
         2xow==
X-Gm-Message-State: ACrzQf0dGQISEi7uw9wjk35aZyBaWTH7OoTCNfsCEnN82+kB+ZLYTRyv
        NC79GKoXyYzar6bSVbStDvi7Fqm7rT7syAJLqnJSAg==
X-Google-Smtp-Source: AMsMyM7GIYG7A4ghgZ0+aS8SyddPotFMK2d1/uL5kMGl7GKycv3x9BCqeqPj62YF1UHA3B/H7CEDTV/OSueDj54yRvU=
X-Received: by 2002:a05:651c:19a8:b0:277:3cb2:d9f9 with SMTP id
 bx40-20020a05651c19a800b002773cb2d9f9mr9918004ljb.278.1667409498411; Wed, 02
 Nov 2022 10:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220805222126.142525-1-jeffxu@google.com> <202208081018.9C782F184C@keescook>
 <CABi2SkVXMUVhSTJezfHt_BKxyKP+x++9oveuB3qJZL7N672UKw@mail.gmail.com> <202211011933.DD0979338@keescook>
In-Reply-To: <202211011933.DD0979338@keescook>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 2 Nov 2022 10:18:07 -0700
Message-ID: <CABi2SkWGo9Jrd=i1e2PoDWYGenGhR=pG=yGsQP5VLmizTmg-iA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm/memfd: MFD_NOEXEC for memfd_create
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@google.com, skhan@linuxfoundation.org,
        akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        linux-hardening@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        dev@opencontainers.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 1, 2022 at 7:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Nov 01, 2022 at 04:14:39PM -0700, Jeff Xu wrote:
> > Sorry for the long overdue reply.
>
> No worries! I am a fan of thread necromancy. :)
>
> > [...]
> > 1> memfd_create:
> > Add two flags:
> > #define MFD_EXEC                      0x0008
> > #define MFD_NOEXEC_SEAL    0x0010
> > This lets application to set executable bit explicitly.
> > (If application set both, it will be rejected)
>
> So no MFD_NOEXEC without seal? (I'm fine with that.)
>
no MFD_NOEXEC because memfd can be chmod to add x after creation,
it is not secure.

no MFD_EXEC_SEAL because it is better to apply both w and x seal
within the same function call, and w seal can't be applied at creation time.

> > 2> For old application that doesn't set executable bit:
> > Add a pid name-spaced sysctl.kernel.pid_mfd_noexec, with:
>
> bikeshed: vm.memfd_noexec
> (doesn't belong in "kernel", and seems better suited to "vm" than "fs")
>
SG, will use vm.memfd_noexec

> > value = 0: Default_EXEC
> >      Honor MFD_EXEC and MFD_NOEXEC_SEAL
> >      When none is set, will fall back to original behavior (EXEC)
>
> Yeah. Rephrasing for myself to understand more clearly:
>
> "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL act like MFD_EXEC
> was set."
>
> > value = 1: Default_NOEXEC_SEAL
> >       Honor MFD_EXEC and MFD_NOEXEC_SEAL
> >       When none is set, will default to MFD_NOEXEC_SEAL
>
> "memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL act like
> MFD_NOEXEC_SEAL was set."
>
Copy, this is clearer. Thanks.

> Also, I think there should be a pr_warn_ratelimited() when
> memfd_create() is used without either bit, so that there is some
> pressure to please adjust their API calls to explicitly set a bit.
>
Sure

> > 3> Add a pid name-spaced sysctl kernel.pid_mfd_noexec_enforced: with:
> > value = 0: default, not enforced.
> > value = 1: enforce NOEXEC_SEAL (overwrite everything)
>
> How about making this just mode "value 2" for the first sysctl?
> "memfd_create() without MFD_NOEXEC_SEAL will be rejected."
>
Good point. Kernel overwriting  might not be a good practice.
I will add to vm.mfd_noexec.
value = 2: "memfd_create() without MFD_NOEXEC_SEAL will be rejected."

Thanks!
Jeff

> -Kees
>
> --
> Kees Cook
