Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291546B8B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2019 10:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGQI5D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jul 2019 04:57:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44222 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfGQI5D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jul 2019 04:57:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so22807131ljc.11
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2019 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jVJYwVPqhI92ePrVwuK/g+oP5mpkNXJhduBRrTnzOo=;
        b=hc6r1e69nhIl69WPP0wsHJjCJ0EIaTLGofpXpOOCuwEBWVM2DslumLrlHBCVRPlXOb
         vtpofLq3bWMezI1jFYPQSlVS0XUVXadYW1mcxJJ5hzyT0MTd+x3PpzFNVy3N1IxT0mBM
         zCVb5nyOsBRFPJnDRXtMVc95qbpz21UCgaHQBRVnZjF87bPjqx3yZHbISO4sBn7ubXjb
         qa7ZJwAAPRVKsL+9pm4ezR+ltfBh3ZdLMYqJFyBAUnv1FDYODKsz9I1vzYgHx5jMZToN
         VCYnF5+0nRvQ69Xkihe/2ovzECrI4sGWEORpaknO3Y4aTs7qO9TZ198lz6V70XEcqWDr
         bOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jVJYwVPqhI92ePrVwuK/g+oP5mpkNXJhduBRrTnzOo=;
        b=NO8kIgJ2PKMxlMQN9TSgDXSvVCzy3LIj2NyX4zos5H4bFUoGu4rxBS8vmwsSXyISjY
         R4e6g4oZkJZlSyIkLZ1UMp5o8X7pLcGV0kXqrPq8bw91TvJXwKy8DTr/GTpu1DGnSpou
         YlwPGFYyVlfvb83kqUzoWfor/EoYt+ZbVzrXyLigOlM39vgoInKquQ20jD2UaGqq39+4
         xBlOsCh1DSIL3Bb0s5TNUwDZMJk3vEfCldySaqSZD7wgpWtOSXmlQh7YG8hTfErfiW3y
         OIwutEai4HtlLpAgWnwqzofUo3lxWcb0B7Y6DekNtydoRfD3L+pNQA0DZNOCTun2ZzBk
         Xsvg==
X-Gm-Message-State: APjAAAXu5k7tVAt58BTv5hwtk3c1nVsSVITQx7GwDiN7BnIhEr8nnF9c
        XlzrlrqVb8ugJllL96WnUciW92AgCjVT6MXKo7ppfg==
X-Google-Smtp-Source: APXvYqyhRKr01SffiXafxqbMn+xTzX5Ioffnm7MxINn2mQfMWmEYQmOejSLNGmv1u5rD0MnWkP9irHPVVa+jHScvu+s=
X-Received: by 2002:a2e:8559:: with SMTP id u25mr20141598ljj.224.1563353821144;
 Wed, 17 Jul 2019 01:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190405174708.1010-1-guro@fb.com> <20190405174708.1010-7-guro@fb.com>
 <CA+G9fYvz6MA0N8GgwY5QNdWBAw+XT9QcmwnABsSpjLnwz_jLzA@mail.gmail.com> <20190717004904.GA32357@castle.dhcp.thefacebook.com>
In-Reply-To: <20190717004904.GA32357@castle.dhcp.thefacebook.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Jul 2019 14:26:49 +0530
Message-ID: <CA+G9fYt+UmakwaZAM4gR-B+V8kZUJVNh8gFBcXa4zU2j0Cz0ZQ@mail.gmail.com>
Subject: Re: [PATCH v10 6/9] kselftests: cgroup: add freezer controller self-tests
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Roman,

> The interaction between ptrace and freezer is complicated
> (as ptrace in general),so there are known cases when spurious
> cgroup transitions (frozen <-> non frozen <-> frozen ) can happen.

When test ran for 8 times it got failed 5 times.
I have noticed intermittent failure on x86_64, arm64 hikey device and
qemu_arm64.

>
> Does it create any difficulties? If so, I'll send a diff to ignore
> the result of this test for now.

No difficulties. I will mark this test case as known failure.

> > > This patch implements 9 tests for the freezer controller for
> > > cgroup v2:
> > ...
> > > 6) ptrace test: the test checks that it's possible to attach to
> > > a process in a frozen cgroup, get some information and detach, and
> > > the cgroup will remain frozen.
> >
> > selftests cgroup test_freezer failed because of the sys entry path not found.
>
> Can you, please, elaborate on this?

I see this failure output on screen and sharing log here.

Please find full test log here,
https://lkft.validation.linaro.org/scheduler/job/825346#L673

- Naresh
