Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69E64EB553
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 23:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiC2VeQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 17:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiC2VeQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 17:34:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B608239334
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 14:32:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r13so37718256ejd.5
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNJQ60t9ow46nPLDTL0lGrHwboox4GQw0/vTKn1ZL5A=;
        b=lnCZC0DpxNBLUffB2oLIpMxBrnBLwD0WpNwv5f4uqc5YgSJI4TrtRUIQf/bb9rxUed
         AtfCIuaRpS5iFubDPmmKV3V/46+wzs/EDPYr8LSgwndpCVpOsBh6enFI6o6nFZVS5olq
         qTFPzcWj0F+8AgEs2wEDFQ29eb+bYS+jHElB1GmX5Y/wIvCgxthpJ9u41nbuJBrhXYQx
         sfkOfFov7NlGx0boBMgMYs5msdyhwv4Z+xIyZFg/hY25oyySfW/0Bb7QLLEaZEVPxMAK
         //gQhJubH1DN1qykwZxJe9fbnx+4xLuVBh7veoFkeq6OxHhylLUivsrLDF2kk1FD6CoX
         35FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNJQ60t9ow46nPLDTL0lGrHwboox4GQw0/vTKn1ZL5A=;
        b=ol6taeXElXaAGKPKDAvJogwcahUyT0hFfE1YKhlUF/ofOHFrjV4JTVW5lzeLG7rMXg
         14HUxNvZ2Y/lpLfek48YgEmC9reH5OkE8dFX30GebiAsNiCMTEamrC9prgUuC+J9bZ3/
         8dRvaU+TeVz3he4syUf7rnZ/g6cRt+/D5XtiMmrIcW4IOKOtP9TgDOcIwSRMYDNviqsF
         b1b2ZllurLrJg61kvgVr0OwT3+JhkpB7STy1vBuoyy53y7aLDnEnUdjz9aY8JY8xz7KP
         cgvTgBZIHkXzYZvVryuwFdLH6b3zkA882AnDp4SOJi209lYua3QOg8y5lnj1Lyi+ETa0
         Da/w==
X-Gm-Message-State: AOAM53096elLuKjThuxS9V03UXezS7ZO999kNpuvZWtABrYVzaw0rl25
        M8ZcPPsncs3SfwoyTKw1vCF68zVCa8La6pTBLTgTwQ==
X-Google-Smtp-Source: ABdhPJy4BTMYt2cEtBSbmfC31i1s9R0oGmoVOfOD2HZA+Zfy6cogEZxNy+3Fb9rktahrlflKpbi84cW4L/9tBA7+n80=
X-Received: by 2002:a17:907:eab:b0:6da:8ec5:d386 with SMTP id
 ho43-20020a1709070eab00b006da8ec5d386mr36400202ejc.668.1648589548764; Tue, 29
 Mar 2022 14:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220329103919.2376818-1-lv.ruyi@zte.com.cn> <CAGS_qxpCHgp7ToQV9UALPy-4nyHDcdpWOCCd3duz-L6EgYPpOg@mail.gmail.com>
In-Reply-To: <CAGS_qxpCHgp7ToQV9UALPy-4nyHDcdpWOCCd3duz-L6EgYPpOg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 29 Mar 2022 17:32:17 -0400
Message-ID: <CAFd5g46xma=yCYYNhupXkQmM=u1-ts3L0JhkX-Ueo21QxsMtmA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: add null pointer check
To:     Daniel Latypov <dlatypov@google.com>
Cc:     cgel.zte@gmail.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 29, 2022 at 3:29 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Tue, Mar 29, 2022 at 5:39 AM <cgel.zte@gmail.com> wrote:
> >
> > From: Lv Ruyi <lv.ruyi@zte.com.cn>
> >
> > kmalloc and kcalloc is a memory allocation function which can return NULL
> > when some internal memory errors happen. Add null pointer check to avoid
> > dereferencing null pointer.
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> > ---
> >  lib/kunit/executor.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 22640c9ee819..be21d0451367 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -71,9 +71,13 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
> >
> >         /* Use memcpy to workaround copy->name being const. */
> >         copy = kmalloc(sizeof(*copy), GFP_KERNEL);
> > +       if (!copy)
> > +               return NULL;
>
> While this is technically correct to check, in this context it's less clear.
> If we can't allocate this memory, we likely can't run any subsequent
> tests, either because the test cases will want to allocate some memory
> and/or KUnit will need to allocate some for internal bookkeeping.
>
> The existing code (and by extension this patch) "handles" OOM
> situations by silently dropping test suites/cases.
> So I sort of intentionally figured we should let it crash early in
> this case since that's probably more debuggable.
>
> This code does check for NULL returns earlier on in the call chain, i.e.
>
> first in kunit_filter_suites()
>    158          copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
>    159          filtered.start = copy;
>    160          if (!copy) { /* won't be able to run anything, return
> an empty set */
>    161                  filtered.end = copy;
>    162                  return filtered;
>    163          }
>
> and second in kunit_filter_subsuite()
>    107          filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
>    108          if (!filtered)
>    109                  return NULL;
>
> The first kmalloc_array() is our first allocation in this file.
> If we can't handle that, then things are really going wrong, and I
> assumed there'd be plenty of debug messages in dmesg, so silently
> returning is probably fine.
> The second one also felt similar.
>
> So I think that
> * it's highly unlikely that we pass those checks and fail on these new
> ones (we're not allocating much)
> * if we do fail, this is now harder to debug since it's partially
> running tests, partially not
>
> Should we instead rework the code to more clearly signal allocation
> errors instead of overloading NULL to mean "no matches or error?"
> Or maybe just adding some pr_err() calls is sufficient.

I think we should either return an err ptr, or log something (maybe both).

But yeah, I agree with you Daniel, I don't like overloading NULL.

> >         memcpy(copy, suite, sizeof(*copy));
> >
> >         filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
> > +       if (!filtered)
> > +               return NULL;
> >
> >         n = 0;
> >         kunit_suite_for_each_test_case(suite, test_case) {
> > --
> > 2.25.1
> >
