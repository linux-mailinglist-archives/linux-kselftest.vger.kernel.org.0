Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6A227F8E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 07:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgJAFJi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 01:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJAFJi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 01:09:38 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51105C0613D1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 22:09:38 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g96so4163862otb.12
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 22:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q6KOBJvHBicR0VoRRtmGhxc4kN/+VGebNPC7Evs4tF4=;
        b=cm3qXwMNswUF/liZPf5zMwhmh8GyH5J8ViJ70KxfUs7yhhVYXbCaon/m0ixBKyvtaA
         DHW1hKffN8HrskAwfnGEMN8iPg4MKLhY9VVD+L21T1W6x9VljZ7yudIj8AproT57ytv9
         gHSNS89B9H4W5REGOxuK7w9WGMo5OPkLpZBy6fqX6aa6b7TzZEEMaJK9UZc0c889QEbE
         0M1rpi9cmeeCTsaBNuizNXKVZBksVhtff5r7dAUNUaj5VFfi+fpzV1z6WFj659rdZIaC
         QzKCc9z09at1Sj8sWPvD524hGLrD79PDvpP02W4IOLLALVL3QcoJdeH27iHhx5vsGwGH
         EDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q6KOBJvHBicR0VoRRtmGhxc4kN/+VGebNPC7Evs4tF4=;
        b=M3JyJ5ivl5kR+R3I5n8MK5encnQ7UEQRbhXjXJqwuMNRH6evY4/DRVHRYlklBDSxxk
         2A43xVskKyTgwRt3UdV7sNWniJxhTqxvW5Bki3KIQHOaqJqH6YB4VPC4hYdi3dDvoIJp
         4AoWEOuCj+s/kQsWEjAMlmyq3j6HfPMDwsScxJP3jhyvQiqM55E3+H2xmw0lWVt7d5af
         Rk/qi++LyXO/oUgYFQIqA7pNif0IF1g1ONqvv43w0RZeY3Elq6OZT0tz8+Aj9q1qGmk/
         kcjiZCgYWz1j8LajvMVESQlC5SLiBPRMuMDwKh96HEfKbAHglDN07QIbTdf6Vzaaj268
         H3IA==
X-Gm-Message-State: AOAM531c0rkWLCQtu515sxtmwM26xwbXhEc9TjHeYQgM0rNoeDdSMZrz
        ZRyVTgsVEnLqSTa7AxmIHqWBguqxGyac/85hXXqc5w==
X-Google-Smtp-Source: ABdhPJyiR313uHTtIPf7OufasmFIaSMpBW4yu1rpoIB4XegXsDLsrEUYH3jEZhxSCK1w300SRNjGUNOE3soN7DimF7Q=
X-Received: by 2002:a05:6830:22ce:: with SMTP id q14mr3666913otc.72.1601528976723;
 Wed, 30 Sep 2020 22:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200928202650.2530280-1-keescook@chromium.org> <20200928202650.2530280-2-keescook@chromium.org>
In-Reply-To: <20200928202650.2530280-2-keescook@chromium.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 1 Oct 2020 10:39:25 +0530
Message-ID: <CA+G9fYvwJM20+0Td24H9reeiQPkak+uq7TL1cugufkUxFthWFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selftests: Extract run_kselftest.sh and generate
 stand-alone test list
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
> Instead of building a script on the fly (which just repeats the same
> thing for each test collection), move the script out of the Makefile and
> into run_kselftest.sh, which reads kselftest-list.txt.
>
> Adjust the emit_tests target to report each test on a separate line so
> that test running tools (e.g. LAVA) can easily remove individual
> tests (for example, as seen in [1]).
>
> [1] https://github.com/Linaro/test-definitions/pull/208/commits/2e7b62155e4998e54ac0587704932484d4ff84c8
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

- Naresh
