Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EBD366522
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Apr 2021 08:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhDUGEI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Apr 2021 02:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbhDUGEG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Apr 2021 02:04:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D9C06138B
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 23:03:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d27so8232892lfv.9
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Apr 2021 23:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZS2JpeIkIMBK4UXRFMJIanBPQAOTd8QwR3u/vBehNeo=;
        b=bQzTOEBpMGZH5H3dbm7xA1VkK7OKLJT2pLKpW2Q8n+CV7TN8ICVMGm4NUsXMvdLOPu
         s4QkC4uAB6x5neZJ7tj4W8QTdmArEQOFMjpbNgEyyWXbCurd4ryqFG5t4EoBxDwVrS1g
         PPpqxQ5lTcvfQPKB8d/lJjn9AXvtAMQXqvtZj0uUwa0rrBrFR8i850e4cTI0RB70h3zA
         VZUMUxbZl5thFT+jX/WMRwaueZopavHWg/cR2p8RQNxB23C1xlAS8agUsxoRgomB3ZU7
         C/WEgHYKzlk3WlqlaLpq7jWwU+duhfJEGJ8PLIOPz49b40K7Y0PvJhCdBbvrTju32rLK
         7m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZS2JpeIkIMBK4UXRFMJIanBPQAOTd8QwR3u/vBehNeo=;
        b=W7msqTsrx0Bs8zJYlLH1KKioKQVkuIb+r1PGNNiGBfhfDNSEDtI1DkMjmPld7EWKZX
         SD8Zdd3adxr1Eu5vgm1POHWV0GzcBYD3ulx+lwOAn6l0nl30WqqnterbqozKUwLcFvf0
         618mwsjsZhKn7bczr2FklKed/GQOKJzozEqeTAylitUohfiMcf0dIuSJfiVLZITotbXC
         HZe4JW0WMQpud9igtuOQ9X7X80MUwg3/F2TUpHrLCw7bKC5XxpK2Ey25NIMAvsAL4cGG
         C07K5cLLGmaaC4I4r4RCyXe7b+dF3uWiqETObBcZo06prwMhhSEsfIftGYkMTO6bLk3j
         amyQ==
X-Gm-Message-State: AOAM530v4Kf9KulIG3ybBnHjIMmsj5q/oGhGMd15QDGKybDHtsXi18aD
        s0xQ8BvqGizT/MFeW4XvubU+bBGhjdSgjM+p+LIEIA==
X-Google-Smtp-Source: ABdhPJzIkJofST36Xj70YcRHBhuVfM0v6d7YRdW8jMeo7bmioWl4fVNzGM/e3S5WkV7dfbPy6lk5iU118kK6mM2Ge34=
X-Received: by 2002:a05:6512:b0f:: with SMTP id w15mr18818927lfu.333.1618985009814;
 Tue, 20 Apr 2021 23:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210421020427.2384721-1-dlatypov@google.com>
In-Reply-To: <20210421020427.2384721-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 21 Apr 2021 14:03:18 +0800
Message-ID: <CABVgOSkgGr+_RVkzsThP_OJjytAqygB7VubcuTaZxznBhpu6Mw@mail.gmail.com>
Subject: Re: [PATCH v3] kunit: add unit test for filtering suites by names
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 21, 2021 at 10:04 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This adds unit tests for kunit_filter_subsuite() and
> kunit_filter_suites().
>
> Note: what the executor means by "subsuite" is the array of suites
> corresponding to each test file.
>
> This patch lightly refactors executor.c to avoid the use of global
> variables to make it testable.
> It also includes a clever `kfree_at_end()` helper that makes this test
> easier to write than it otherwise would have been.
>
> Tested by running just the new tests using itself
> $ ./tools/testing/kunit/kunit.py run '*exec*'
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

I tested this version as well, and it still works fine.

Thanks.
-- David

> ---
> v2 -> v3:
> * Rename variable for filter_glob module param to avoid compiler
> warnings. Couldn't think of a better name for the argument.

Neither can I:  filter_glob_param is fine by me.

> v1 -> v2:
> * Fix missing free in kfree_subsuites_at_end()
> ---
