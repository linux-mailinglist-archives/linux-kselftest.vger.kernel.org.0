Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD0F55CFDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jun 2022 15:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbiF0XeJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jun 2022 19:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbiF0XeH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jun 2022 19:34:07 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699EE00A
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 16:34:06 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id p136so13166963ybg.4
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jun 2022 16:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36OIarfx5PzM4kjZSSg0l/qf9yDisYQa76AlgarhvfQ=;
        b=VkW70IK+3vPfOcOnRfWuB6LlV+6vmO/mzt/JCIbzEK4bLDfPMmrzfix3SzjJvMofg5
         NjMF1m9bTZAD8EtP+QATDYGTVZptEXbY1wLv5kvTGX8Vcn+YL4rFBBLgIPkCe5FVRnKX
         RjkNcsqd9AQibP3cTF85ik1u2xfUI53T2U5HwUU9m3bjG+RFbm7U5NYQSWaWN2jBXT56
         pRjpx+pbNDOdeJkw4SxT7B5C3A6kqxk6OgMNMc0hd6RQ+F0WNojoMUFFGMfHETX0UMUR
         EEBDJKNfqSwVDy65n69nDAgOeoLQxrLxd+OXmqDj1JOV8CgLWJZe4U1q/W8tVjfVJ/HE
         wYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36OIarfx5PzM4kjZSSg0l/qf9yDisYQa76AlgarhvfQ=;
        b=FATAjOnPrw28zBzkDYcfGOu0gucXmSk3Co3xy8gIsQZBeV60Xnk2HkPMyedNEqC2FR
         HSlOAMCNdUYSlX9rAV1PV6IoriSuxG1DHh0pCOp3VNk76om93TzoMEsyHmXNHow+/fu+
         4gOsDhhv6O/5Fh3/dQDXApUXgtL4C6v6R0oXhw7JoUDrSZoUSAvu9vfed2Qx3+vfdkL2
         gbWNjBNTAAqGKhdVxzuqOpj2gx+DY0fWFvNx0nV1RBznBnVK83UajZyGrl9/WAHa0OXJ
         EUgVCglJ7CUGe18LBPepejW77MOqr49jj+flgAPTjL787ASxoga0IITu4HqOiIaMlJqr
         ISnw==
X-Gm-Message-State: AJIora+WFwP8BNpZwv1JSPxHeN/Ytsvy3GTPPgZASKp6YUK6L/YWcns+
        C1R/l/rf0U3foHfWo/tpvkCjg2gZkGf/iJCsI5THPzDBbvvowRHh
X-Google-Smtp-Source: AGRyM1vC5NaCuMcoNthT4i9leFW9x27xMZpQY1Eu6fWof/sJuw4UGnnR6x/z3pEdr/3/k4fegrTT9sWv8QUD6Wjdyok=
X-Received: by 2002:a25:d4d6:0:b0:669:b717:187b with SMTP id
 m205-20020a25d4d6000000b00669b717187bmr15523053ybf.405.1656372845601; Mon, 27
 Jun 2022 16:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220624084400.1454579-1-davidgow@google.com> <CAGS_qxqrcyEH+C=63R8uT+K2opkXm6Da1wa4pyNupLUsy1iAKw@mail.gmail.com>
In-Reply-To: <CAGS_qxqrcyEH+C=63R8uT+K2opkXm6Da1wa4pyNupLUsy1iAKw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 27 Jun 2022 16:33:54 -0700
Message-ID: <CAGS_qxra2cCoJvduj4Burtm+_wP2dg_hBFqwVZuhAkb38S4iyg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Enable virtio/PCI by default on UML
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jun 27, 2022 at 3:57 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, Jun 24, 2022 at 1:44 AM David Gow <davidgow@google.com> wrote:
> >
> > There are several tests which depend on PCI, and hence need a bunch of
> > extra options to run under UML. This makes it awkward to give
> > configuration instructions (whether in documentation, or as part of a
> > .kunitconfig file), as two separate, incompatible sets of config options
> > are required for UML and "most other architectures".
> >
> > For non-UML architectures, it's possible to add default kconfig options
> > via the qemu_config python files, but there's no equivalent for UML. Add
> > a new tools/testing/kunit/configs/arch_uml.config file containing extra
> > kconfig options to use on UML.
> >
> > Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

LGTM, modulo the pytype error mentioned before.

> >                         tree = kunit_kernel.LinuxSourceTree(build_dir)
> > +                       # Stub out the source tree operations, so we don't have
> > +                       # the defaults for any given architecture get in the
> > +                       # way.
> > +                       tree._ops = kunit_kernel.LinuxSourceTreeOperations(None, None)
>
> This runs and typechecks under mypy, but not under pytype.
> The problem is that the first argument is type str, not Optional[str].
>
> I think a fix would be to just use LinuxSourceTreeOperationsUml() instead here.
>
> Since you recently switched machines, you might want to run:
> $ pip install pytype
>
> And then
> $ ./tools/testing/kunit/run_checks.py
> would run pytype and show you the complaints here.

Oh, I see what you're doing here, we want to avoid the new step where
UML now adds to the .kunitconfig file.

Something like this could work
- tree._ops = kunit_kernel.LinuxSourceTreeOperations(None, None)
+ tree._ops = kunit_kernel.LinuxSourceTreeOperations('none', None)
or we could put 'fake', etc.

If we're not happy with using this class directly (since it's meant to
subclassed), an alternative, more targeted approach could be:
 mock.patch.object(tree._ops, 'make_arch_config', lambda x: x).start()
But I don't like this and would prefer the above.

Daniel
