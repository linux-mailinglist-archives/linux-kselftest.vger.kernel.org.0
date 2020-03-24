Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A41918D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 19:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgCXSUt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Mar 2020 14:20:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33734 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgCXSUs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Mar 2020 14:20:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id g18so7757084plq.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Mar 2020 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G7TBBxwNpvZEgu2P5vS45mLuMGm5bXW06PLHgtTqssI=;
        b=Qb4QiodoFRSeAhTNws1BGKTLfVwQURZEB+9ru/JmLHBeA0pAhKtqd+VUnu0E5SKyYM
         bye4qLMhUFG7j3MF06tObcrsefap0AIr5lC7zL6obQTERItM2rUrFXUDCNPZuWvJ5lTS
         NLTjApMbAd1h2cBovb8yg5bfaXrtOgZ9vj5Etnf2C0RRzntwrf+GgnFPX6NAD1RhEDev
         +/IhzhE7Rcs0KP4O6eM7rGdn/Vi7OY6BHgKtrg3sTtzY3hBPCJaFQvoUXJK4oJu8SXHh
         JaI2neNR+Qb+0HvUi0IkQP1ATE4E1g0IH9SberwTGLWZM3HS4lzNm6jPxRI7zegNPtdF
         oL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7TBBxwNpvZEgu2P5vS45mLuMGm5bXW06PLHgtTqssI=;
        b=YXicGndiNzvYNB3UM9uCEwfJDddA8qDa7ZYNklSOQlqIa5/lGVp22Ieo9lANZyOV/Y
         0itoxu4aoi95Qz7EM/Vp1iHiVBrJDQlBCSNp1nqFxLo97pQvZPexiRF8Fz70DHYv4zWy
         tGuCK0HsS4D6F0XHLNgVY8pbbwmSXJEpBigBy5bnj6saU/7b7KvADH8L666TMbI7y/+2
         N1iK29AhRl+QfM5/KD0x1fgxcY/zylCrXkwVGji9MP6XqyjIgUpt6DzE462OKjTa9x+u
         gBB4062cW/2jLkmAmBGMIi5zLVPAyW61ToIV3YSggOGv3V2FOTnvGco5qSLC17/fxnv7
         sTDQ==
X-Gm-Message-State: ANhLgQ2N+1h4EJn4csplcMeHjTE6T7jpOsggT5milNRyBXOQ5lC31BJC
        IiBiT9UD+PAq5bZkg3CJpI4c4cJl+4ptCOVc1jSbKw==
X-Google-Smtp-Source: ADFU+vvU/DEpKK++hcYvv//uiYg/cZGTM7oLYwReML+Okiq04rSe9KXRONxXVeIa2d4G4pW2RqbBJqIOHuZpjNMauVo=
X-Received: by 2002:a17:90a:30c3:: with SMTP id h61mr6876474pjb.18.1585074047136;
 Tue, 24 Mar 2020 11:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com> <20200319164227.87419-4-trishalfonso@google.com>
In-Reply-To: <20200319164227.87419-4-trishalfonso@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 24 Mar 2020 11:20:36 -0700
Message-ID: <CAFd5g47jJ0f+NFDBXK5gTqbx4-UiyJ9xfZaRW1qzZ_6AcGKC+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] KASAN: Port KASAN Tests to KUnit
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     David Gow <davidgow@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 19, 2020 at 9:42 AM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> Transfer all previous tests for KASAN to KUnit so they can be run
> more easily. Using kunit_tool, developers can run these tests with their
> other KUnit tests and see "pass" or "fail" with the appropriate KASAN
> report instead of needing to parse each KASAN report to test KASAN
> functionalities. All KASAN reports are still printed to dmesg.
>
> Stack tests do not work in UML so those tests are protected inside an
> "#if IS_ENABLED(CONFIG_KASAN_STACK)" so this only runs if stack
> instrumentation is enabled.
>
> copy_user_test cannot be run in KUnit so there is a separate test file
> for those tests, which can be run as before as a module.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
