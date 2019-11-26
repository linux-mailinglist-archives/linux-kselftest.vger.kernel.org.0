Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD33109A53
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 09:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfKZIku (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Nov 2019 03:40:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45433 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKZIkt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Nov 2019 03:40:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so19142464ljg.12
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2019 00:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJSgPehhaACQjhbDPXZqUXuTjHRDXeCK78JL36AA9zE=;
        b=pDI6vitKvFpChBChvFcJVAA7cIG+mqps0OW2UpNMUQah3fdMBHlC4WOMBjdWLmI8EM
         +u9wGLdRRphnuvg5f8FzP0xoMvCHq9omZ0cLlAaV3QGIvi+Y/MQNVWXs8+TN+hUu6RAW
         8P49lCHqc+tZCOhGOJKKWZNhxTye3TUueErA81Bcw1Jo1ky7IioMjjo/cG968xnOXyKv
         NJhWT8nxIiZSZe5cjc0b6mGIM02D4B6zqlMvgvNE0op1ioKgrq8B4hiUd9IonQz+LRtn
         sAVAx/hNZECMm+aqrOcgsDYE89bXYTfGICbeG0eX5Zgoahav96Ou6ziguP5/0hi4VnhZ
         ZrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJSgPehhaACQjhbDPXZqUXuTjHRDXeCK78JL36AA9zE=;
        b=ioEG0BX8GgJa+bVZhsmkKe/7VAdKs2PydZ3d2oxceMBpCSvP9ZV75fm2wSgHeTMKzv
         c2GF09t8/D1xLizDwcMiNalYCVedMAUFCEDkwGzAtUv9vZbKVFtPYnDErTawtZr1E/Rt
         Nmp6oyOnp+Sj/Nm610EGI4jHjPuzSCsSVfR1GIK4eHo6xyf4vN8clTGNxQgMeKEsu0PP
         msc+VPXVdzEEWRKBpEG6cfalK5I1dJmsmKacXSvBssjjubimGoA+ugw+hDe2H7Kmn8Jk
         TGItb548X/ixYc9mP0I9sh6iWqPeiTORSnrtYripWbnbxIfHkSYrfQqYcMZrGj824ECz
         flsw==
X-Gm-Message-State: APjAAAW8JUqjHVdrox0Kw68Lpo0pjkmrLJ8HiQ/c5qwELXUd4eVPUK3B
        8VumA7+b3F6+uhqEnzf2xGM5DpYLQ7i/wB1wUsDubQ==
X-Google-Smtp-Source: APXvYqxYd2ghv3pGu8gS4dX38qXoPXBS8TuRFtBvUBWEYGmJyvuuX/Rn1SoXWIJm0fGZkDvHeMO1Ht1ZC9cYM0eI6BE=
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr26326562ljq.20.1574757646678;
 Tue, 26 Nov 2019 00:40:46 -0800 (PST)
MIME-Version: 1.0
References: <908428601.2367.1574715624016.JavaMail.javamailuser@localhost>
In-Reply-To: <908428601.2367.1574715624016.JavaMail.javamailuser@localhost>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Nov 2019 14:10:35 +0530
Message-ID: <CA+G9fYt6-mcn4BNxB4sZFrLQUTprqVafxz_YHajrGRQm6mJD4w@mail.gmail.com>
Subject: Re: next-20191125 kselftest results
To:     CI Notify <ci_notify@linaro.org>
Cc:     lkft-triage@lists.linaro.org, Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

selftest reported few regressions on arm64 hikey device.

On Tue, 26 Nov 2019 at 02:30, <ci_notify@linaro.org> wrote:
>
> Summary
> ------------------------------------------------------------------------
> kernel: 5.4.0-rc8
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> git branch: master
> git commit: c165016bac2719e05794c216f9b6da730d68d1e3
> git describe: next-20191125
> Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191125
>
> Regressions (compared to build next-20191122)
> ------------------------------------------------------------------------
> hi6220-hikey:
>  kselftest:
>     * futex_run.sh
>
>     * net_so_txtime.sh
>
>     * net_traceroute.sh
>
>     * proc_read
>
>     * sync_sync_test
>
>     * user_test_user_copy.sh

The above listed test cases got timed out on hikey device.

Full test run log link,
https://lkft.validation.linaro.org/scheduler/job/1021542#L10216

--
Linaro LKFT
https://lkft.linaro.org
