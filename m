Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD1E42485E
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 22:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbhJFU7X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 16:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbhJFU7W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 16:59:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4895CC061746
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 13:57:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w14so2517930pll.2
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cro8T8lb7lgZU9x32Bgh7IJds0gE/AUhAt67PgW2U0=;
        b=OOHTmEackZPTn1u41cjp30lBmsToU4UvfFE27FwJx1mIsPIFtXSaNs/NkCJOIN04GI
         8sl4d4Tq/n7hlYcZdrB7WFquBncfavHAq1pSbLLsXg3UU0k3Kjtj/Oi9T5Qf9i4vVriN
         yK/Jv2X0RQVD04UEquS0VFM1rD1mSkqUXhZnBxjOr24L+bO/6RnCTeJ4zIt5n0KRivcz
         RPbnagp4JBo3ILllGdp3JUCwnq2z1u2OaWKr9AFZFTOJQc1KpWdlQCKuhw+BHqOmDWeX
         EBdz2kkp9uYW92IR0EmvGvvwQqFMlEquUZEJzpRRMZXEvxJgNtrLoA/iDlUpEXhxqzrD
         VWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cro8T8lb7lgZU9x32Bgh7IJds0gE/AUhAt67PgW2U0=;
        b=TMm+aLIuVhdhj+6TflU4BlkHX6mOKkBqqw2RYPPcv45rpRY5+Zn1dnLjSA9VgYanal
         3lvdDpzoVGcJTnr/jvo/HTYDH97q/1bvj9Wpg6phEa3Vtmj8dsAdC6D8q67nInahnq7L
         CnsmjhQldI5TgochxijX868Q2rR4snNLKRVbCgtxK0saACE2phwbafTTfbKrHfxIqV5W
         wuqzKW/EL1xD6c9bDdqnV7thD9iP6sxI2RNjC7ffDKISyGp6IjJ6XJel49ozv2K+jdkH
         Njw1XIF4/9L0Jxs7wZIiAvFLCR/rCfPVee32j2OGDzCmNgZNpVSewkmmCOKyry6bHcMa
         WqbA==
X-Gm-Message-State: AOAM533ybo/417Ywy/HayOXMgHmI3ghKZ3QysYj89aKsJjHck6R9KZBM
        J1UlFgApzIn1Pkc+S3g9wv/bYcge61DPn68OoGlHjg==
X-Google-Smtp-Source: ABdhPJwsS9psEbLuG48IwDIvCu/mtGIOS+73Q2CuJ6vYwseJ9mbPy3DemzdOJBYVA27mNqNvTk6fWYhygPEg0X3+jYQ=
X-Received: by 2002:a17:90b:3552:: with SMTP id lt18mr974214pjb.63.1633553849440;
 Wed, 06 Oct 2021 13:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211006071112.2206942-1-davidgow@google.com> <CAGS_qxodEp+HwWJCEaz39T-QEOxhev5a0KjLx+nUfbuM-ZLOcg@mail.gmail.com>
In-Reply-To: <CAGS_qxodEp+HwWJCEaz39T-QEOxhev5a0KjLx+nUfbuM-ZLOcg@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Oct 2021 13:57:18 -0700
Message-ID: <CAFd5g44k2UB3T7Ow=isSAMVjgT6vWo_iwtGQ_-RZG_UB9QCg-Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: Report test parameter results as (K)TAP subtests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, Rae Moar <rmr167@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 6, 2021 at 1:32 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Wed, Oct 6, 2021 at 12:11 AM David Gow <davidgow@google.com> wrote:
> >
> > Currently, the results for individial parameters in a parameterised test
> > are simply output as (K)TAP diagnostic lines. However, the plan was
> > always[1] to make these (K)TAP subtests when kunit_tool supported them.
> >
> > With [2], these are now supported. (v5 will print out an error about the
> > missing plan line, but this can safely be ignored, and will hopefully be
> > changed). As a result, individual test parameter results are parsed,
>
> Hmm, I'd rather not condition users to ignore warnings.
> It's possible we can get this all fixed up in time for 5.16, but we
> have quite a bit we're trying to get in already, so I'm not sure.

I agree with Daniel. I think we should just get that fixed first. I
will poke Shuah to start applying patches for 5.16 to give us a place
to work.

> > displayed in the formatted results, and counted for test statistics.
> >
> > [1]: https://lore.kernel.org/linux-kselftest/CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com/
> > [2]: https://lore.kernel.org/linux-kselftest/20211006001447.20919-1-dlatypov@google.com/
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  lib/kunit/test.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index f246b847024e..02a9fdadcae2 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -508,6 +508,8 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                         /* Get initial param. */
> >                         param_desc[0] = '\0';
> >                         test.param_value = test_case->generate_params(NULL, param_desc);
> > +                       kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> > +                                 "# Subtest: %s", test_case->name);
> >                 }
> >
> >                 do {
> > @@ -520,9 +522,8 @@ int kunit_run_tests(struct kunit_suite *suite)
> >                                 }
> >
> >                                 kunit_log(KERN_INFO, &test,
> > -                                         KUNIT_SUBTEST_INDENT
> > -                                         "# %s: %s %d - %s",
> > -                                         test_case->name,
> > +                                         KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> > +                                         "%s %d - %s",
> >                                           kunit_status_to_ok_not_ok(test.status),
> >                                           test.param_index + 1, param_desc);
> >
> > --
> > 2.33.0.800.g4c38ced690-goog
> >
