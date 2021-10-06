Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F0424372
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 18:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhJFQ5J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJFQ5J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 12:57:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D557C061753
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 09:55:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c4so2086161pls.6
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EU/1nSdcmq9wxGvA5GjD0Uso7E7y+C1WRcEA7I5q/r4=;
        b=eNyLPDeZ5JIwxplTq2YpnqmBRnPkTyDm/CiCAZZIjMvjlRaHHiZkdM9zWKJn6R90UG
         Xz2B4VSptag9Dvk36DwNWbBj6aBUYg3Ypt+J64VBkJN0dKJt97XOH/iu1GIpcbIy1095
         t12dvcXyi37tnTUK6y+5WzOkMsTw2Nnckufgh7OXTmaVH+UqCZBdjbSon1yTNTEyGOuh
         e8zcY8O7wx7o3D+WINfqULkiKDyllpMm0qJlC0cMKaqCCRoxw2ZIGn7MSPATibpv3T73
         xgYLxcdnBhajldYoJPRqEHbLD24wTiN2T1ZBlZh+QcNzeKPuxH2cKm5n8Y2iFekOV+/D
         UwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EU/1nSdcmq9wxGvA5GjD0Uso7E7y+C1WRcEA7I5q/r4=;
        b=mILLOnao8YNFLommB81QbxkEaSXpEAjAtZ8Y3QUFzfsVHl6Yf/fZ+mh+Jjr4NHYEBX
         H8bUra0KggHnLDxJS124mYMqaJDL0P/kM9B1OjKcCFv8qUyjvloQvaVT3U3A9zXjxC7z
         cP53podt5h7tKWcnkS/YTAoYM88bygA6loPnixo3IT6xY4R+iIfQXtfOxg5y2maduziY
         BP5m7lUFYqTQ1bTYP6HuMmg7sL91PsQfWuzEYxaazN5+3UkDQ39dgq/kMq0YM7n2PwFT
         Svf+rIRB6p3AhE+uqPfvyyVCSMPxPJh/AfbOcwASt5nDQutt3vGupphCTJxdblKf7mzP
         WnAg==
X-Gm-Message-State: AOAM5311G3wm4WEs8ueTAmR+Be2/0Mvfb+mrVn1fnH4khwLwu3mTSzvU
        u95UQYGt0zMOprZNlAt6yoLKRRPwlYR8H74k2C9LDg==
X-Google-Smtp-Source: ABdhPJwmXV8J2FW3/DTnnJvaCZrFumM5at5TF4jvaHiQVpy8zO4E21sXch+DB+P2SPwIlu8bOPoxaBj26blSG5gM6N4=
X-Received: by 2002:a17:90b:3552:: with SMTP id lt18mr11923608pjb.63.1633539316349;
 Wed, 06 Oct 2021 09:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com> <20210930222048.1692635-2-dlatypov@google.com>
In-Reply-To: <20210930222048.1692635-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Oct 2021 09:55:05 -0700
Message-ID: <CAFd5g45jD+M=xmx7eoVX2sQMNfrOCFGB_H8PU+VZo=eO8q6Bzg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] kunit: add 'kunit.action' param to allow listing
 out tests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 30, 2021 at 3:20 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Context:
> It's difficult to map a given .kunitconfig => set of enabled tests.
> Letting kunit.py figure that out would be useful.
>
> This patch:
> * is intended to be an implementation detail used only by kunit.py
> * adds a kunit.action module param with one valid non-null value, "list"
> * for the "list" action, it simply prints out "<suite>.<test>"
> * leaves the kunit.py changes to make use of this for another patch.
>
> Note: kunit.filter_glob is respected for this and all future actions.
>
> Hack: we print a TAP header (but no test plan) to allow kunit.py to
> use the same code to pick up KUnit output that it does for normal tests.
> Since this is intended to be an implementation detail, it seems fine for
> now. Maybe in the future we output each test as SKIPPED or the like.
>
> Go with a more generic "action" param, since it seems like we might
> eventually have more modes besides just running or listing tests, e.g.
> * perhaps a benchmark mode that reruns test cases and reports timing
> * perhaps a deflake mode that reruns test cases that failed
> * perhaps a mode where we randomize test order to try and catch
>   hermeticity bugs like "test a only passes if run after test b"
>
> Tested:
> $ ./tools/testing/kunit/kunit.py run --kernel_arg=kunit.action=list --raw_output=kunit
> ...
> TAP version 14
> 1..1
> example.example_simple_test
> example.example_skip_test
> example.example_mark_skipped_test
> reboot: System halted
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
