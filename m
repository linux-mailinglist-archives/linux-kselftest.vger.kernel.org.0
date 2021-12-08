Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A32E46D7ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 17:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhLHQV3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 11:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhLHQV3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 11:21:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A49C0617A1
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 08:17:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so4913437wru.13
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Dec 2021 08:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XudR5QwbKwmMIdTWdxeMrD6caTZkAvE0b72zbhBzI50=;
        b=MSBoGk02QOdIPAonhp7MBQGtOMs2d2pLeUFrw4sx2zVj78Bot2Pu++a9IQ9arYfGc+
         XBXI4f/Zh+MZNarXEN078pbHRx064kH5PbQMqirEVgBVhWjZE55etYdEMbK1EopO8bLT
         5TFLKAhgu5X9i7CgutroZC2MttxWAx5ClOnsj2rLHGqZpP51P4sEZeqE6+CGtFBq8Tgt
         rq2MvtXZuN0roGIkYcsl3xtV5/j2m4U2GRQdoN0cTq8v81064ncaR/qlyR0kI0z7JkMz
         qufogI/Gskc7FW1oLPAiv/ogkRcx7jn4cT64D7xQnmuSjBcQdj02gxQVo9UYL+bYgKNh
         8H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XudR5QwbKwmMIdTWdxeMrD6caTZkAvE0b72zbhBzI50=;
        b=YZi3ELNLlXuCxJhPhqDrDLWX5y2wC4a/tFKY8adA/Hp/fk+XcKoIAeuYYnOoZCgDTL
         qsqmvKH3y8h6vHmYYrB0H26o0bBimQvPIDTKPKZZAgDsz/ainEouZMwc+1xCAtkDt3Xz
         9JE5JbZ8cFpZ5JBK1WgpcGLbu/rD/tjjfSspjQpIL8oNkKtgniFBU72sAF3JoicMtnrz
         l+SHAvdfih3+RZCRrkcJc17PJrRjjE7RuizJbHtffPcb4V/LL8hmRyxxXWi4B1KBBwNF
         NcYpt9KL470e3qhSXEo1Y+GIVih651XBexCxq90fuxwexFTlYa1DZ0K24Pm1hqhwvhRB
         Es9w==
X-Gm-Message-State: AOAM532OszAukNrrLW7LKhSRYpdfEKmvp6cBLBEfjUGFBrXO+xoUsCb7
        dobAh8YNPoqZdokrnF18R84IxejTxre6nloaJVT/gA==
X-Google-Smtp-Source: ABdhPJzIfb/G70ZKYOvkfAgLKJkiT/YbzYOh5Qus7tyAWqMTM7hM4m+uKUW+pRNOkcUNRxjIcWaEEm6BCa+fhZnKSfg=
X-Received: by 2002:adf:f209:: with SMTP id p9mr58643982wro.191.1638980275764;
 Wed, 08 Dec 2021 08:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20211207190251.18426-1-davidgow@google.com> <202112071358.E8E6812D@keescook>
In-Reply-To: <202112071358.E8E6812D@keescook>
From:   David Gow <davidgow@google.com>
Date:   Thu, 9 Dec 2021 00:17:44 +0800
Message-ID: <CABVgOSm68xfwCrnobKJkt_Qhh95JCP6kTXrUXoDwe_pBxWWt-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Documentation: dev-tools: Add KTAP specification
To:     Kees Cook <keescook@chromium.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>, Tim.Bird@sony.com,
        shuah@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 8, 2021 at 6:02 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Dec 07, 2021 at 11:02:51AM -0800, David Gow wrote:
> > From: Rae Moar <rmoar@google.com>
> >
> > It does not make any significant additions or changes other than those
> > already in use in the kernel: additional features can be added as they
> > become necessary and used.
> >
> > [1]: https://testanything.org/tap-version-13-specification.html
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > Co-developed-by: David Gow <davidgow@google.com>
> > Signed-off-by: David Gow <davidgow@google.com>
>
> I like it! Thank you so much for suffering through my earlier reviews.
> :)
>
> The only concern I have is wonder what'll be needed to kselftest to
> deal with indentation changes. As long as this can be implemented
> without a subtest knowing it is a subtest, we're good.

I'd think a minor tweak to the prefix.pl script should handle it for most tests:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/tools/testing/selftests/kselftest/prefix.pl

Certainly the indent should be the only difference between a top-level
test result and a subtest now.

And, if the results do use test plans (i.e., state how many tests are
expected beforehand) it's possible to parse the results even without
indentation. It it looks like it would be a problem, we could
explicitly state that indentation is optional if a test plan is
present (or provide some other mechanism for detecting the end of the
subtests: just checking the test number has some corner cases which'd
fail, but doing something akin to the "Subtest:" header TAP14 used
makes this pretty robust). Things like that would overcomplicate it a
bit, though, and might end up verging back on "tests need to know
they're subtests" territory, depending on the exact implementation, so
I think things are probably better as-is.

Cheers,
-- David
