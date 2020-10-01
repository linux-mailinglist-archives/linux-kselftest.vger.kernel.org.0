Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6376E27F8EA
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 07:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgJAFKC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 01:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbgJAFKC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 01:10:02 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC059C0613D2
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 22:10:01 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z26so4276426oih.12
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 22:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfiXEz/Yp7QnacqOD0Bzaygm1o0QXJVF3bzwVd/E22Q=;
        b=Uz+lMmvfUS1+tFLwnQ2LlW/OVHuHJghfAGtFQ6AJ2KGeGLhy1Qky5mnDJwmzbAbpKb
         v7jfYo3oD29S7aGY7clc2Gq9wRpmItDqHfH1GVygOnbaQvgz8ez1XJHACveGMW+v2Pkz
         8PsriqINqCg2XRIaDmvD0VZWhLMRGfypdMvwcLxgWBqJRkf5lvDwAdb+XnVtrmFiMotM
         V8fUdTkREETmdPW7/XkRmjMdWtbJuWLL6y4W4PayDpTK7bIB/RGRZEFGJmcrBULqNU9H
         DuZW+PYMLdDinRJntfZBzT73jAtCISezkDzN1iRG5JrsuSk9LCQhoHbKAcqneS2KZdXV
         Si9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfiXEz/Yp7QnacqOD0Bzaygm1o0QXJVF3bzwVd/E22Q=;
        b=AYK0WkOw6kLdsC+NPxZ3HleckrAtkwHPK6+ZAPD6prDwodDCIjfS0+F0jvwF4FosiT
         AMAW4Qsrb3PNAws/3mIZ7tYudtxGcChYW/ynSk1x0xE6b8cQW3Va6aQGg/Q7sJSZHWQo
         K08ihboZwtDZBLXXzgI7HLicdbS1myKo7OajjklfuGpW6tl8R060AoEMblDkA+6CA+FQ
         B7CgrT5W14YEoxHu04re1lQVsYpb4+Uw7uONBkL3b/rxJhV1pyAUEPH5sJ528BCaZtMC
         e6IccjXlJ329IP9vydGiBSU9pQEyTPp6cMCMklyDHjjbxTcS7YQ1xWFi0/shl7rv2hs1
         1L1Q==
X-Gm-Message-State: AOAM530HF2usIJoT3/sXVTSBbhI8YCWnvx9j++yUMm0z9oZdJsOM7tfc
        DK07vnRn6w8YLXBblge47HIK8qnrCgAlzVDTsKsFYQ==
X-Google-Smtp-Source: ABdhPJzQ6h/KHKuHn3/SzwzefC4Qb4baLReVpfD338TkNEHJRp7rh7ry3lxoUZOLw48LBreyERso58n2djRLzIXnL88=
X-Received: by 2002:aca:4142:: with SMTP id o63mr3062971oia.167.1601529001163;
 Wed, 30 Sep 2020 22:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200928202650.2530280-1-keescook@chromium.org> <20200928202650.2530280-3-keescook@chromium.org>
In-Reply-To: <20200928202650.2530280-3-keescook@chromium.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 1 Oct 2020 10:39:50 +0530
Message-ID: <CA+G9fYtLQN_dMXUE0zVbWmtYjpu16hbShMb+mxQh3tiedwrXuQ@mail.gmail.com>
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
>
> Co-developed-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

- Naresh
