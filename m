Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB93FCED7
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 22:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbhHaU4E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Aug 2021 16:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhHaU4E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Aug 2021 16:56:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72BCC061575
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Aug 2021 13:55:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so470502pjq.1
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Aug 2021 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7DJaTANbvrCQkH2QIc5sjZqAcUZDSgVgOpoHk7N9uc=;
        b=j9fpVhx7mUoQiaZsCC+QcRUNBUJL/aEbMEVfR4g7sTx/rJ3N/C5Pd2N8YzTIIF/eai
         J9jlGZYDW+p0aQEw1o6qgfsKdV/zHu9s64bmWwoAko4T87pdblhtQFXJYMRnG+JpKLtZ
         gnj7E0673Ib/e+wdCdEF6NHLQUauiMQEO97zt32Qc3+nUavkE4XBEnkJ2v999pRZdSEC
         7Nbzi0BHrSc6AKms5WkB7QfFagRkvW1/6MGzOESJ6vk/y1P8uIAm//sjecYggV1OyVwy
         xxfpwS+1g6wcbAT0S42P7eNxRYT8rYfkwwmm6utKkBPkzXQU3FIA6qPRzMI892CWIrrg
         omdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7DJaTANbvrCQkH2QIc5sjZqAcUZDSgVgOpoHk7N9uc=;
        b=J9qH1QYuK8FY0blWYbywD01p6EiUq99gcUkB0/1bnyMMeHS4QM8wccIUwQcBK6SB19
         zNYdEi0vGnB6iSMmEEWRKlo5m+5KQ8glP+erD0vmvzRBfsGDVw7NSw0z2Gie7gFYPJKw
         y/Gz9kPcPR3X0IT7hcca96sLQ8AA+rkkS4+yBTdB7iIOZWmi7ezjHoIU8ftWx1p3WO4l
         IhGcWyCfOb/5f8SM8dZw45wRL7cbU0l2d3NkCMTZV+J6hFAkWHwZeFfv0W8yhX7A06hs
         Jef8EBCPP/Gy0+MukeiUzbUcusLiQ4+l61f3Q8NETwiMKQ+rPpguN8+cbbPcE5UD72YU
         9ong==
X-Gm-Message-State: AOAM533l3DM/Tzll0B8vlgXqjH5Q47093TGzw/dfjM8V1CrxNhYp5ZvP
        fCNfGhgNqUW7pfLQ7LfM3EFuUfadYzMsZ4R+2QX9ZcuGtJBlUA==
X-Google-Smtp-Source: ABdhPJwFIeFPBZiPJhvAQUEntqlO8pMW4RMLT3FE0EwtGnEoSQ13B7k4ep9zi9c5K2I68z1ZU0o8k9yBRfv4ofHVfRo=
X-Received: by 2002:a17:902:6b47:b0:12d:7aa6:1e45 with SMTP id
 g7-20020a1709026b4700b0012d7aa61e45mr6306276plt.80.1630443308010; Tue, 31 Aug
 2021 13:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210831171926.3832806-1-dlatypov@google.com> <20210831171926.3832806-2-dlatypov@google.com>
In-Reply-To: <20210831171926.3832806-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 31 Aug 2021 13:54:57 -0700
Message-ID: <CAFd5g44gzSuq7cVK3A+0Di06fHYOLT7aWmF-xjp8V0onoPOwcg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kunit: tool: allow filtering test cases via glob
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 31, 2021 at 10:19 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit 1d71307a6f94 ("kunit: add unit test for filtering suites by
> names") introduced the ability to filter which suites we run via glob.
>
> This change extends it so we can also filter individual test cases
> inside of suites as well.
>
> This is quite useful when, e.g.
> * trying to run just the tests cases you've just added or are working on
> * trying to debug issues with test hermeticity
>
> Examples:
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit '*exec*.parse*'
> ...
> ============================================================
> ======== [PASSED] kunit_executor_test ========
> [PASSED] parse_filter_test
> ============================================================
> Testing complete. 1 tests run. 0 failed. 0 crashed.
>
> $ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit '*.no_matching_tests'
> ...
> [ERROR] no tests run!
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
