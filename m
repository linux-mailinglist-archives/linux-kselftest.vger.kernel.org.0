Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257B028EF5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgJOJ1t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 05:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbgJOJ1s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 05:27:48 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35014C0613D4
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 02:27:47 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j17so449915ilr.2
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/oWxjxOfWlAIEhqMrrUligmtkGSiaLafGJiqZMoZ+A=;
        b=RddR1mJzacpz//w0bbpREDVk2eN/vNgniNb6ER0bp7XU7rzMAGfibxLc8KB+4j3HgM
         VxyYVpeJhgZOKcY0ck8LDt6tJeKzoIA94Hd8AKYNqZT+edFGr1QkFWLwtRcZtYD7c1bR
         qAOadY/5erawCDQQ6KuuFjyTJkKCObwnTNJJXS/jEr+gDKIywgWypFwcnyK7dPNJcQ2r
         9bE8icpeivGjjlj0wsJ2OsgYsbBESIRVaSt9rfmGq8V+cvo23lVYsXIDVHwvMo3G4SOP
         5Tt++WXzi+2GdCwWS4bk+Ku5SyYY4gALETMT5xiWsEmDCJjIxrvSfZhkly8S+YSTG6gM
         3Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/oWxjxOfWlAIEhqMrrUligmtkGSiaLafGJiqZMoZ+A=;
        b=oN2u4hytWMUyGL8wniUOQ8ArgDIJvtW90u3ybUWZQgT7Z/WUAxymH4MSVdHbuoBpuS
         i/qpvpYpinClvi9elgL1hPnyBsg6ULZtO2ZN951LhcmB66zEjDZtxOOieG7ROOLX/oo1
         rYB1xnahJNSkezz6VlQbAhNWUHxEnZjfT/Vzuva2oWM74fAQxYf68pxWQM5zpgj27tkA
         ZlTsZ5tjtw606YvgQpT57GbPPsA7Mn45zLfusxV9GOOPcXLzLkxSEN8mtEqC+AxW+hQg
         g2TlrWBgZ5NjZwgoxHMD3Ls54iKZ3IXt4bVIuJwXY4ub3izkm68qQq7tCyajStix+bh7
         uW+w==
X-Gm-Message-State: AOAM530PCqKADF3tWv4t6G4mmxt+qEe8O7JaTZX0eYdCSxsU/7cBDyXk
        YFlsCATu6t2rerbimSlU7xkqP08qU53gSjqeBC4MXw==
X-Google-Smtp-Source: ABdhPJzuNZ0EsyUKZ4jMeEV+MX1ryS5DfGZLElWyD4suz6V11o4XlTjjxwTv/CKJxtg/UqmVK5HZyB7EdzngW1pF0s4=
X-Received: by 2002:a05:6e02:5ad:: with SMTP id k13mr2483422ils.71.1602754066287;
 Thu, 15 Oct 2020 02:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200928202650.2530280-1-keescook@chromium.org> <20200928202650.2530280-3-keescook@chromium.org>
In-Reply-To: <20200928202650.2530280-3-keescook@chromium.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 15 Oct 2020 14:57:34 +0530
Message-ID: <CA+G9fYtqqzWtb65pk8J=-Afv0KZ9iy3_bA-WmiJjbe5Y6qXbAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selftests/run_kselftest.sh: Make each test
 individually selectable
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 29 Sep 2020 at 01:56, Kees Cook <keescook@chromium.org> wrote:
>
> Currently with run_kselftest.sh there is no way to choose which test
> we could run. All the tests listed in kselftest-list.txt are all run
> every time. This patch enhanced the run_kselftest.sh to make the test
> collections (or tests) individually selectable. e.g.:
>
> $ ./run_kselftest.sh -c seccomp -t timers:posix_timers -t timers:nanosleep
>
> Additionally adds a way to list all known tests with "-l", usage
> with "-h", and perform a dry run without running tests with "-n".


While testing this patch set on LAVA the skip test functionality is not working.
We may have to revisit test definitions kselftest skip logic
or else
may add one more option to skip a given test on run_kselftest.sh script.

ref:
https://github.com/Linaro/test-definitions/blob/master/automated/linux/kselftest/kselftest.sh#L196

- Naresh
