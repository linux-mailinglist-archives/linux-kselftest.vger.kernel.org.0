Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F48A3FC0CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 04:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbhHaC1a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Aug 2021 22:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbhHaC13 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Aug 2021 22:27:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200E3C061575
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 19:26:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g22so24516862edy.12
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Aug 2021 19:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxZfZimTqO85QuBFQ+HEqcgFp3fXZItUNlIo+IuYwrU=;
        b=Yjj09dOBQtMSVYAkFMbQ+LEbkdRWJiPHH/pTKVTbFFWXKZg+ydiCcn/0NtXCNHGsLm
         7IEVh3sIk6fsE7vUFfnvodCPJSS36jnnMRRYsI/M9inH1syVHqhsc5VKzEgWMYMaJEWt
         OZwL6KTl22iVxso86UWcOk4XIMb6r9DiWAdMML43PpQdG+Agx/8ks5j6RVatSx0Ez9rd
         S412H41h2rzfYa1GajAQhFsUuXka6qNFY/k5iVWsUojZC2vw+pdeoEm12500YZz46gqr
         R5qutDGgNTrCWa6ZO3Pj5zbAk5XA1kOlV4cCocZ7vQHUg9nJOv/avDlp2BEazuu05r4c
         8ILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxZfZimTqO85QuBFQ+HEqcgFp3fXZItUNlIo+IuYwrU=;
        b=Qnb6AkOgO4praWI6CRqB+dpxx9ppq2Ilkhzd0uTmxIi5GN/8OjG2NPVQqsBTuzbAlL
         Gj3/fFUim1oKIsZN6QoqGBAVlyd/EQES78NAYgwIqKvu3y8Nqy0L+EQ24u6uqHigF6FR
         HcTMcs6MKrEQsH2v5sWO9Q1VKJbgGO6VTfsR2EvO7tq6ZQd6yX/1z4cV0ikakKER2xgC
         zX7xt87g1FYE0JEK7cVktw0o/46u97xQO2/oNWramfoEFnKRSgJJBDBsaAG3BaTPK61s
         ya6hLNGEDidy2u+iXc5oVpWYAximuFHYl0ZyA+SAk4qka0PhkUChZ28erbrshN6LztLf
         VljQ==
X-Gm-Message-State: AOAM531IijglB81t4Ne/MkKYru5PV6oxA8VmDXTMvOFxlhN/hYGIzGyF
        /y1Tp34Z5I8+lstEsuC5PNO/p8LEfMV2g189a6BBaA==
X-Google-Smtp-Source: ABdhPJz5NorlrPFMTP4Zl7TwtoEGKtTI6acdKX4+UF3dByxLMX6WwXHnU2Qt+dWKRwpHmUT4/oMmvbzW66e6sAPXE+M=
X-Received: by 2002:aa7:ce8c:: with SMTP id y12mr23171759edv.198.1630376793395;
 Mon, 30 Aug 2021 19:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210827225812.3247919-1-rmoar@google.com> <202108272303.F659107A@keescook>
In-Reply-To: <202108272303.F659107A@keescook>
From:   Rae Moar <rmoar@google.com>
Date:   Mon, 30 Aug 2021 22:26:21 -0400
Message-ID: <CA+GJov4vqN6O9_rfVRH3Z+eozUnkn9uWbrTMJTu15iFXuUzqAQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] selftests: tool: update format of kselftest TAP
 results to improve compatibility with KTAP
To:     Kees Cook <keescook@chromium.org>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, shuah@kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These changes to the format of TAP results for kselftests are
based on this proposed specification of KTAP:
https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/

However, there has been considerable discussion on this proposal recently.
It is great to see this discourse on the specification KTAP. However,
the changes to the format of TAP results for kselftests in this series of
patches should be paused until further agreement on the exact specification
of KTAP.

- Rae

On Sat, Aug 28, 2021 at 2:10 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Aug 27, 2021 at 10:58:10PM +0000, Rae Moar wrote:
> > This series of patches updates the format of kselftest TAP results to improve
> > compatibility with the proposed KTAP specification
> > (https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/).
> >
> > Three changes:
> > - Change from "# " to "  " for indentation of nested tests
>
> This seems like subtests would need to have a known global nesting
> tracking again. That was removed to simplified various aspects of
> kselftest.
>
> > - Add subtest header line at start of tests with subtests. Line format
> > is "# Subtest: [name of test]".
>
> That would mean subtests are no longer individually parseable by
> existing TAP parsers (i.e. when LAVA splits up kselftest output,
> suddenly there is no TAP header).
>
> > - Remove TAP header in nested tests
>
> What benefit does this provide? This just makes things harder to machine
> parse now.
>
> > Standardizing TAP results would not only allow for clearer documentation and ease of reading but by standardizing the format across different testing frameworks, we could also share the use of tools.
> >
> > As an example:
> >
> > This is a truncated version of TAP results from the kselftest ptrace with the new format changes:
> >
> > TAP version 13
> > 1..1
> > # selftests: ptrace: get_syscall_info
> >   # Subtest: selftests: ptrace: get_syscall_info
> >   1..1
> >   # Starting 1 tests from 1 test cases.
> >   #  RUN           global.get_syscall_info ...
> >   #            OK  global.get_syscall_info
> >   ok 1 global.get_syscall_info
> >   # PASSED: 1 / 1 tests passed.
> >   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> > ok 1 selftests: ptrace: get_syscall_info
>
> But this would mean changing every TAP parser to notice "# Subtest:"
> instead of "TAP version ..." Why bother doing that? A parser aware of
> subtests just needs to examine indentation level currently.
>
> >
> > With the new patch to update the KUnit parser to improve compatibility with the proposed KTAP specification, (https://lore.kernel.org/linux-kselftest/20210826195505.3066755-1-rmoar@google.com/) the above TAP results would be parsed as the following:
> >
> > [20:46:09] ============================================================
> > [20:46:09] ===== selftests: ptrace: get_syscall_info (1 subtest) ======
> > [20:46:09] [PASSED] global.get_syscall_info
> > [20:46:09] ======= [PASSED] selftests: ptrace: get_syscall_info =======
> > [20:46:09] ============================================================
> > [20:46:09] Testing complete. Passed: 1, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
> >
> > Thus, the kunit parser could become a useful tool for kselftest users.
> >
> > Rae Moar (2):
> >   selftests: tool: Add subtest header line and change indentation format
> >     in TAP results
> >   Revert "selftests: Remove KSFT_TAP_LEVEL"
> >
> >  tools/testing/selftests/Makefile            | 6 ++++++
> >  tools/testing/selftests/kselftest/prefix.pl | 2 +-
> >  tools/testing/selftests/kselftest/runner.sh | 7 ++++---
> >  3 files changed, 11 insertions(+), 4 deletions(-)
> >
> > --
> > 2.33.0.259.gc128427fd7-goog
> >
>
> --
> Kees Cook
