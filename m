Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6794C3E1B08
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Aug 2021 20:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhHESPN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Aug 2021 14:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhHESPN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Aug 2021 14:15:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF875C061765
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Aug 2021 11:14:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so13648116pji.5
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Aug 2021 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYldJwdsql0xBaO1sKZOJMQPzD9lyreF8UumtGeLwiM=;
        b=QWKcGa6Bq0wgTfZN+2z+g7oAboQKIql9gyrBd+aax2vyJSxivlISSyMyuHoMd3c1Sc
         o05wBdkEpym7arFZ2BcKYnd3ykim0MQJwXpSxGuoj63IGtw59qMi9R6+w9yV1O1lcQ4+
         I8KsWJ95A+hJXyHdONBcAEe+WPGjIZ9dIXamG2sMqoSuU15hubVLoH7ymfHv2QXy4EZm
         jMy51GoGt2Zcr6QffAPpyI2SwA2YHtMn7ff1uOfofZJZFwVtkwe0EurjBp9+E4WSf4WR
         mFiNS4vEa6MaeBaJb6l6d9dlvYERr+7CI0ytK+uxFsMSqprJeBXb/0CIH73rIHiqEbDV
         fHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYldJwdsql0xBaO1sKZOJMQPzD9lyreF8UumtGeLwiM=;
        b=faJVhpXN7qDLKrH2sZSwe9lBbdQkIShEvoQB2p+v6GiQ/0SLg2lSZ9RspL1UqACTtK
         is2zlKk64pCwnw7dBk0Q29Ff252kM9/EAZ3HTQe+ERbubzgw43g8LmMCY6K8mCj0IrCY
         ktax8UfgwCX68VsQjBUbnjrDK70Ipx3ibOeRxi7+wvw3nCZa+mSVjO+wjcasuLLV4tBU
         xmMImdAq5+f1EULj8jaR+83KLP3byrj1PtW4fRNw1FThjWf0iTgscxE9kb0yCC9JOyh0
         BWxLwmBRBDOomhGEeyd/KczVGKWhUUI6G5P/fx6Udd0Kr5/AGgXKHVIVENY9j+qkawE7
         8POA==
X-Gm-Message-State: AOAM5319hzrqyBKwfH1/1ga53X6B43/zz3Xwvocn4RtJOZwNZSHAoR+7
        55FWqwEKKuL+G/1mopNHcZM1+M8iVfHSZ/hot24X+45mS0q/bQ==
X-Google-Smtp-Source: ABdhPJxi/GLd77d+bxDF94SYcXRVvNToYZiSJ9wBaBVpMqXd+INkyV8All4ZBD6lrWvOjHWkbM8U5nvy9WCVQHq/sUg=
X-Received: by 2002:a17:902:8ec6:b029:12b:ab33:15d4 with SMTP id
 x6-20020a1709028ec6b029012bab3315d4mr5044138plo.80.1628187298193; Thu, 05 Aug
 2021 11:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210804050809.628266-1-davidgow@google.com>
In-Reply-To: <20210804050809.628266-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 5 Aug 2021 11:14:47 -0700
Message-ID: <CAFd5g44suSKUDXhAh6CNewGeg00BDJurYNMyY4vaAsaEZ1puWQ@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Print test statistics on failure
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 3, 2021 at 10:08 PM David Gow <davidgow@google.com> wrote:
>
> When a number of tests fail, it can be useful to get higher-level
> statistics of how many tests are failing (or how many parameters are
> failing in parameterised tests), and in what cases or suites. This is
> already done by some non-KUnit tests, so add support for automatically
> generating these for KUnit tests.
>
> This change adds a 'kunit.stats_enabled' switch which has three values:
> - 0: No stats are printed (current behaviour)
> - 1: Stats are printed only for tests/suites with more than one
>      subtest (new default)
> - 2: Always print test statistics
>
> For parameterised tests, the summary line looks as follows:
> "    # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16"
> For test suites, there are two lines looking like this:
> "# ext4_inode_test: pass:1 fail:0 skip:0 total:1"
> "# Totals: pass:16 fail:0 skip:0 total:16"
>
> The first line gives the number of direct subtests, the second "Totals"
> line is the accumulated sum of all tests and test parameters.
>
> This format is based on the one used by kselftest[1].
>
> [1]: https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/kselftest.h#L109
>
> Signed-off-by: David Gow <davidgow@google.com>

This looks great, David!

My only suggestion, can you maybe provide a sample of the TAP output
with your change running on the thread? I think it looks great, but I
imagine that it has the potential of being more interesting to people
other than you, Daniel, and myself rather than the actual code change.
(To be clear, I think the summary and the code both look good, IMO.)

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Cheers!
