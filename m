Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F224295441
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 23:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506213AbgJUVdE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506189AbgJUVdE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 17:33:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016E9C0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 14:33:04 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s22so2265122pga.9
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWdO/BEHPBVW0hCFPQ+JR5DZl5CQy5T+Kf+qXCSlmaY=;
        b=vapsFGNt7qONFuQsa3KqFg9vFwXGyaSa+VKM9Od4OikxgZqrXxOJ92ntvxT70Jkvh6
         zNnJqpV1YHNlRGVPjBP2Kdn9h6OM1tcTDkj+VdHJUd/kYop9wMlYOcxZyQnyIUkbzYCU
         aC4DQ2nLP9d4TYOIGzCSdVACDSRYTfo0CyA4enSKwCQ6+qkhSj4X8PrVvOaSdtHPO8FQ
         Luw3hPS1+myvLHe1K7iEMVl3SV21AD6sKF4X0W/qRFz18BlMEzVRh3wOHpFHz1y2DsZ7
         19NR3KuWTORF4UXpLoiH7d5+YSExEwbta0L5pr1Vai1EIEaevKMPGltPzH7PGxAvRXn8
         ihpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWdO/BEHPBVW0hCFPQ+JR5DZl5CQy5T+Kf+qXCSlmaY=;
        b=IFvtTosJttaXO/VSs97OHqqz2Kppmhs2JtNOD2X0vOCrGDvMK7uR+Lz4hjQSPrAXdO
         92Y3HeV23iKSAlau/Pb4xn8QdKdq3X7mbV524e4N0d/3g9SlJQMTrXpno2sJXqrB4uuA
         uOHN3U+J5v0i/qAZz0lfeO7/dil5g2tEwhbW4ZQ/pYB5Lh/pH1HdMc8jl6WODAuSNrzL
         ZhszOU/Q1fpkUdZYyq7ZGYfHgqiNq/5zScjNtU3/N9dWjTQLOHk4NPFj/okcuOewndeC
         3TsisWYpEiwcNdknayXYp7O80WMOiZQHCb6ERlxeWv/6E6d6AGkl92Y/o1tHTwjzKpDT
         QlXQ==
X-Gm-Message-State: AOAM530KVHvKYtTq0HJJMnwPq8UEKd1F5THfo9D5NbblqRV1RFv+CHs9
        2peaUKfvSGWbrvotlCL/9gqYCcFlheKLgvIoGJxHlPRLvMzd5w==
X-Google-Smtp-Source: ABdhPJxGlF369VBjuL9KPmdp7qYAXWO3zXA0g1TE1lxNpt0Mt5RIdjomUYCqWdJoC4dnsAgiBDqGBiamcgtX44xgtMk=
X-Received: by 2002:a63:dc05:: with SMTP id s5mr4890090pgg.201.1603315983174;
 Wed, 21 Oct 2020 14:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201012102621.32226-1-sjpark@amazon.com> <20201012102621.32226-2-sjpark@amazon.com>
In-Reply-To: <20201012102621.32226-2-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 21 Oct 2020 14:32:52 -0700
Message-ID: <CAFd5g44CxPuXbHund397PJSQPHGhWy1-7ij7JnJNzCO0NF6dCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: Mark 'kunittest_config' as constant again
To:     SeongJae Park <sjpark@amazon.com>
Cc:     SeongJae Park <sjpark@amazon.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 12, 2020 at 3:27 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> 'kunit_kernel.kunittest_config' was constant at first, and therefore it
> used UPPER_SNAKE_CASE naming convention that usually means it is
> constant in Python world.  But, commit e3212513a8f0 ("kunit: Create
> default config in '--build_dir'") made it modifiable to fix a use case
> of the tool and thus the naming also changed to lower_snake_case.
> However, this resulted in a confusion.  As a result, some successing
> changes made the tool unittest fail, and a fix[1] of it again incurred
> the '--build_dir' use case failure.
>
> As the previous commit fixed the '--build_dir' use case without
> modifying the variable again, this commit marks the variable as constant
> again with UPPER_SNAKE_CASE, to reduce future confusions.
>
> [1] Commit d43c7fb05765 ("kunit: tool: fix improper treatment of file location")
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for this! This is something I meant to fix a while ago and forgot about.

One minor issue, this patch does not apply on torvalds/master right
now. Could you please rebase this?
