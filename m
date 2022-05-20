Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B9552F586
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 00:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351410AbiETWOF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 18:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiETWOE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 18:14:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27C2197F56
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 15:14:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i27so17941067ejd.9
        for <linux-kselftest@vger.kernel.org>; Fri, 20 May 2022 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8tpGS9iPyKDrTF/Et0aFlq3MSSltBoAHnWZACQjZfY=;
        b=RwcGky0voHc/fdP+XpSWj5VgRxzbty/vsT0v3kQ/FFGLnkT6+48yZN8FMS4Kj09vxQ
         ZS+FYr3FSM0z8sZW9NB+Ru1hFavloOc2r9NLNRwmxZGDtI+Ghe/b8ew5uO046ARAg22T
         Rea9zXk4YW2WSF24FPMLUDQuIDyZ+1cqPTXauI9lgOnnHZ315+fXHuG1JzKcK92hN31D
         3xDEB16UO7IUwuowxv2mZr1e6/buZLk/ENm7Rh4ll5cAYzkTwImCAMzx/0lSaDS5+Ek3
         gtSKXXtRx0EHL6FmHeE6pKtJwdlOb16+rDSJQ92hi9O9Vhn7LTOtE2xMKwMvl5/Ew9VA
         muCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8tpGS9iPyKDrTF/Et0aFlq3MSSltBoAHnWZACQjZfY=;
        b=ARf2x7BAd33Iq47RI7NZ2YvTdgimHsgScN4dohNFj7k1CjTZIYpLstiD6afmBQMkdi
         Df5t6QGRTat5mwgEMrQLCS69ugsoWI3Jwaq6JJvogAsBdTRN7QLOsLsSVDke40uiFKY0
         GdOsCGz77arrhN53x5Kan8ekVUE7KhoSSrg0UJc2FyDrRIoJrhoV3pqgKzt/JerKQBtc
         /Q37V7L9HyVzIHnNhK4y66BcaINclyVc5zUmO3KJ7lmjQRgrayOD7BKWFChkMPJDHuEf
         HGO+HIWRCIMJTPlDwuP96Djv/UzVWYprGjqKF3ptRW7uRmP4ukKYzeZiGlwfLeuo4orK
         6ytA==
X-Gm-Message-State: AOAM531dldhXvDyneuk2hwvoGFAQMnx4NWRXduIexg+Dh6Nl9eayycz+
        w/scm7xMuTg8mLRQXi3ouv4NoMaJpJzXDupA36qm0A==
X-Google-Smtp-Source: ABdhPJwrzYFXTBosi+kTvEClQu5KzH42K5CwiLg8OXhcoiR2js/3XnjiS7QMhxK7oi2Gjqyla1h/SD1k45HtUiruwjw=
X-Received: by 2002:a17:907:3ea9:b0:6fe:b416:fe20 with SMTP id
 hs41-20020a1709073ea900b006feb416fe20mr3518012ejc.358.1653084842100; Fri, 20
 May 2022 15:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220519164512.3180360-1-dlatypov@google.com> <CABVgOSnooocLsy2=a8rm7Y_m3DpffKtDam5_uYou+Y2tUkumRw@mail.gmail.com>
 <CAGS_qxrDYKKoWy3UAuVqebT+3jp-ux_uyfbwX3OnJqVbnzaiJg@mail.gmail.com>
In-Reply-To: <CAGS_qxrDYKKoWy3UAuVqebT+3jp-ux_uyfbwX3OnJqVbnzaiJg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 20 May 2022 15:13:50 -0700
Message-ID: <CAGS_qxrvR+xxfmzz92rYYW=VzG1kyycn1EuaJxdNSMd_L5afFQ@mail.gmail.com>
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

On Fri, May 20, 2022 at 11:13 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Thu, May 19, 2022 at 11:13 PM David Gow <davidgow@google.com> wrote:
> >
> > I like this, but do think there are a few gaps this doesn't handle
> > properly. (Though exactly how we'd deal with them, I'm not yet sure.)
> >
> > In particular, it's not possible to disable a pair of options where
> > one depends on the other: disabling the parent option will result in
> > the child one not being present in the generated config. This will
> > conflict both with "=y" and "=n/not set": we'd need a way to _remove_
> > a kconfig option for that to work.
>
> Do you have an example?
> Because what you describe sounds like how we want it to work, but I'm
> not sure if I'm misunderstanding the scenario you describe.

Talking offline with David, we've come up with a small example.

If we add this kconfig somewhere
+config X
+       bool "X"
+       default y
+
+config Y
+       bool "Y"
+       default y
+       depends on X
+

Then running this will fail
$ ./tools/testing/kunit/kunit.py config --kunitconfig xy_kunitconfig
--kconfig_add=CONFIG_X=n --kconfig_add=CONFIG_Y=n

It will fail with this
This is probably due to unsatisfied dependencies.
Missing: # CONFIG_Y is not set

The problem is that kunit.py is looking for an explicit line saying
CONFIG_Y is not set.
But CONFIG_Y's dependencies are not met, so Kconfig doesn't write it out.

I assume we can treat the absence of it in the file as proof that it's not set.
I.e. the bug lies in the is_subset() logic we have in kunit.py?

I think there's also a general problem with kunit.py/kunitconfig not
really handling disabling options properly.
