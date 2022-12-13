Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460E464B7F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 16:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiLMPAv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Dec 2022 10:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbiLMPAt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Dec 2022 10:00:49 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD30209BD
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Dec 2022 07:00:48 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h33so10581474pgm.9
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Dec 2022 07:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GLIInnSNLsVE/J6a2Xd9bNIZvERsAp0qLY2kO8N1shU=;
        b=Zidh/R1GFynJEb18RlHBvz6IoC0Hl5ASTdipjh5/H6wQb2SnFdchuMCkvNHNhd2SFF
         3VxWkcGqLNphXP2XW2DQm0ymYpSDf1+zfFB8v/KDUQeoN2XvmqISWb3rNjY4G5HZ/D/H
         S5jQGXH2zlgbWchZ7Ao97d1ynffMYzhbG8U6RQ/93oVbsK7BpPK4EyiDuBHbcX5t8YUC
         5TN46lt8BRG1gMXFkx59ZQNCZ28+JGClpBU04vaio2+nLarBQn7EGbk4XF2WIU4ZvSxr
         c/32Pat7RujPVPPv0Z98Mx8sfGZ77eQhFGw3kJTNZ190j/MEb/2IWez4DX+gVPh9dhmL
         MeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLIInnSNLsVE/J6a2Xd9bNIZvERsAp0qLY2kO8N1shU=;
        b=Mug1bGnaRhmqNBpfJFj1ButedrMIYV4iwbuPF6hs1zM49QJN+R/bDKmM28u5vD3csa
         heqWiXygUqaM4HzBux9xegmlCz3G5f3kfyfwy5+c/MiJhYt5vMCGoUMipsLRaIlvGBv8
         RMcwEzCaIjEqln4EzEO4XXz32wrcCmMpyPyLSfpq9bKvJXY1F3hmRoXFuHUkHY2gEoeJ
         /H1ipIpLE2Kgi9vlZss7ek5vYkKLlT++GgVrqvCCX2XiiBV/9Ah9K98i+F1ioKSdFN9X
         68WlkQGYUeRoZunYqWBBUZcgtWVR2N6Kgd75BfaxInJY1gDP7+X48GTsH/ly3LSTf5e+
         45MQ==
X-Gm-Message-State: ANoB5pnlbPaaTQHkdvtpBW4H7bOGRtJOwxJZbGxRQsOohCJcgyAIqp91
        XBCd60x51c23qW7Rux5GfBeI5kOJ0mNXYnTeYVeELQ==
X-Google-Smtp-Source: AA0mqf42WDxA4vPej1NXWlvuUSqlHsOa4aNAQrdFVrQalk7JTlYjtWMWzpWZB5ca/rP+cF+1fWJkb7w4lvvPF7AFv6Q=
X-Received: by 2002:a63:5823:0:b0:479:3a88:5e0 with SMTP id
 m35-20020a635823000000b004793a8805e0mr469934pgb.466.1670943647500; Tue, 13
 Dec 2022 07:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <20221209160453.3246150-7-jeffxu@google.com>
 <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
In-Reply-To: <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 13 Dec 2022 07:00:00 -0800
Message-ID: <CALmYWFvrasXnshO01YGWRyC7qKk4o0G88yAgkgjO1YBumF5zeA@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
To:     Paul Moore <paul@paul-moore.com>
Cc:     jeffxu@chromium.org, skhan@linuxfoundation.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 9, 2022 at 10:29 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@google.com>
> >
> > The new security_memfd_create allows lsm to check flags of
> > memfd_create.
> >
> > The security by default system (such as chromeos) can use this
> > to implement system wide lsm to allow only non-executable memfd
> > being created.
> >
> > Signed-off-by: Jeff Xu <jeffxu@google.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  include/linux/lsm_hook_defs.h | 1 +
> >  include/linux/lsm_hooks.h     | 4 ++++
> >  include/linux/security.h      | 6 ++++++
> >  mm/memfd.c                    | 5 +++++
> >  security/security.c           | 5 +++++
> >  5 files changed, 21 insertions(+)
>
> We typically require at least one in-tree LSM implementation to
> accompany a new LSM hook.  Beyond simply providing proof that the hook
> has value, it helps provide a functional example both for reviewers as
> well as future LSM implementations.  Also, while the BPF LSM is
> definitely "in-tree", its nature is such that the actual
> implementation lives out-of-tree; something like SELinux, AppArmor,
> Smack, etc. are much more desirable from an in-tree example
> perspective.
>
Thanks for the comments.
Would that be OK if I add a new LSM in the kernel  to block executable
memfd creation ?
Alternatively,  it might be possible to add this into SELinux or
landlock, it will be a larger change.

Thanks

Jeff


> --
> paul-moore.com
