Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8264ACA8B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiBGUa5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiBGUaA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:30:00 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95339C0401E2
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 12:29:59 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id j14so22192831ejy.6
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7+lDRwMEEhHx0jHQ997hOwLnkm6ZLU/VDRQObDrGjg=;
        b=h/r8mcsDCrvh/7u0nd0V74YqNMU2eKFCfuq0kqEPf4RbJIg7PQuqA2CVcAv3RX5ut1
         lPAkhsE1/dzWsbngO8vzbZn+/upSoeKjAkzO8fw1OQ6OUz75KkR3G97ZvPHK3QOpMeq6
         k3IORJpl//nu9H08ydgcW+L8cJrxOStKxuVsXS5fV4XVGzX3dws2JnvsMeQM0uq1OPtY
         AK22jV+fPboRl4EdWwRQxckEMgZrmT2dm3nmxOQVA4S+icbv7eKEwsMNwt9zTF3Thisx
         8zeO20xn+Vj+g2Bk+6GdDM6t/M4k6FPD95tTzaaqXuKUwrqTK95oLEX44sd/8CJZiLu7
         CkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7+lDRwMEEhHx0jHQ997hOwLnkm6ZLU/VDRQObDrGjg=;
        b=Bq6KuFLGCvusUr4vLiVmWieWzWDFLb38XweLdLBb7Au8rGfbHR5B4CmWA7RGtRhvhy
         ldmlDmTEQxt5/upcFvFPGmY7D6ZGy/PWh7zL1F+k9DzAvodgryU0wxp7WyPFJ1lx0BdE
         vrBhOSke4rcxRE/vSZ/BaT7GAE+mkxe3+ztF70iTEb/pMUfRFCE9kjoy/OYbb4bBpmpJ
         uhXNiPDQbdCQyTCO/7BPJ4l695pg44bLyUWpt5R4UmOEF0eomggqI5v0aXoq5s0cU1Gm
         N41AI6fRFzZ2ZvPs0rvZWp4oUhB+ajSONEJFZQdyDQ583doF5NkQPbKgwkC1AWhx8Fgb
         mcWQ==
X-Gm-Message-State: AOAM532J1YWrcHfL47WZa0inYt8TJ73v6APZD8qIWV5tdcCGx9FRqkzb
        hIQrx3W2I79TDHvSa3LO6TfQ6F4+jGxevM2BdCnn6g==
X-Google-Smtp-Source: ABdhPJx+tIefAbwThfMeNLrz+Ql7EqVZ9lQ8ML14ttETNIJgX2xiITlZo8IoE+o4APCgksfUmbw1VxvQyTrivxiXCd0=
X-Received: by 2002:a17:907:3f0d:: with SMTP id hq13mr1129891ejc.358.1644265797925;
 Mon, 07 Feb 2022 12:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20220207183308.1829495-1-ribalda@chromium.org> <CAGS_qxoTLwvVjDGbfeOjMrGvh7sck7TDmiVeDXS2S5oyDWiKzA@mail.gmail.com>
In-Reply-To: <CAGS_qxoTLwvVjDGbfeOjMrGvh7sck7TDmiVeDXS2S5oyDWiKzA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Feb 2022 12:29:46 -0800
Message-ID: <CAGS_qxrkswforSv4XKGChwOZ0MbTGzCqYKsZq=0Sx6ThMOrheQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] kunit: Introduce _NULL and _NOT_NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
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

On Mon, Feb 7, 2022 at 11:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Feb 7, 2022 at 10:33 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > Today, when we want to check if a pointer is NULL and not ERR we have
> > two options:
> >
> > EXPECT_TRUE(test, ptr == NULL);
> >
> > or
> >
> > EXPECT_PTR_NE(test, ptr, (struct mystruct *)NULL);
> >
> > Create a new set of macros that take care of NULL checks.
>
> I think we've usually had people do
>   KUNIT_EXPECT_FALSE(test, nullptr);
>
> I'm not personally against having an explicit NULL check, however.
>
> But if we want to continue with this, we'll want to rebase on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit
> since a lot of this code has been deleted or refactored.
> E.g. see https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/include/kunit/test.h?h=kunit

I forgot to mention, it'd also be a good idea to update the new
example test case:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/lib/kunit/kunit-example-test.c?h=kunit#n76

e.g. just adding
  KUNIT_EXPECT_NULL(test, NULL);
with the rest of the pointer assertions
