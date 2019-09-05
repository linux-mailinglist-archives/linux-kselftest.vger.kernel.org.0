Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6718AA97D5
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2019 03:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfIEBLA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Sep 2019 21:11:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34688 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIEBK7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Sep 2019 21:10:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id x18so621285ljh.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2019 18:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WyHVwV+7lAWgH1R2i9ysnM5HCldoC4oI4CCPuZ3doyI=;
        b=sn/ogdrFBxD994h23gtI7Z2GZH+2UCVo7W8VbjV+/zlgMc9hB0qAzYynFhfr3JE3iK
         ECCZfC85stQz9yW6kJhViR4GZhBF60S3952VgfnKCZ7euM+qHCkxZ4QJ3ExlepEX1auD
         cfjDdlfTCWjDInRB5b6yjgzIyB/55ynKlXYXK6hu0oAKed9WGiTU9Iq5c13X14qGZCGG
         LoznsEDspzcYAEwmxMI2i+9OzFS9XLoeSMFGs4WANzueLs+IC5bLLjyVK7BxdcWkjNUf
         t+21jvq5j1t5anylXhMZFyqSylwntok2OAq5jSPyMa94jBcjHVCuxV4MvB0Z7LxFgyM4
         CG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WyHVwV+7lAWgH1R2i9ysnM5HCldoC4oI4CCPuZ3doyI=;
        b=Iscjs1EADp3FBM2y4KmoY0gDegzGIytbBlYChwtfZeJ+OuX8u1l1r51vgLEbMri6PJ
         1SQPlsLHg3x2R+CNceXkwuPK+8OWhEagETSIK8DvXM4xai6j1vhytjDZjSTekdmAP4hq
         9BFJOAB9uW3V81OgHfEaojF8FdenGgNXmuPUGxk9S9R49BGioQcB4X/BIJ4XQl1mZZg6
         vXPvLItd6m27tGHo3rakunZ9lGZgXrsCP6qVVqbn7DAQMTPehZPF0F1WG1XdhPdGabEK
         0ASIIvT2pH/ImfuVQ+AT05aIadocAxFmioSCidCndkI4B58Z3XiKcz1ZP+mEUMXStHXb
         OO0Q==
X-Gm-Message-State: APjAAAVuQh7JczRHdw/QdfUJVDmfUacsVas4dXZas/ND/4BNvV50g/tz
        jSuHq8mVzMu6FMccsigntw7QXafH98ZvtpFCVcpxTw==
X-Google-Smtp-Source: APXvYqyM7YdRaj3gRnVlg7+oOqf7l+oX9vD7se2y3EMoWvepDFR7ywjd44SpkfvRUQrjHtpJtVW6ehpKsplXmar3iIg=
X-Received: by 2002:a2e:2b89:: with SMTP id r9mr285056ljr.34.1567645857675;
 Wed, 04 Sep 2019 18:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <943338456.3594.1567519226589.JavaMail.javamailuser@localhost> <34634351-ecff-4520-cbc0-8ab6a4412150@kernel.org>
In-Reply-To: <34634351-ecff-4520-cbc0-8ab6a4412150@kernel.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 4 Sep 2019 20:10:46 -0500
Message-ID: <CAEUSe78FOo26W+96v4o5mv3Dr5HvWdgssEXDaq4b_kJZhCY+TQ@mail.gmail.com>
Subject: Re: next-20190903 kselftest results
To:     shuah <shuah@kernel.org>
Cc:     ci_notify@linaro.org, lkft-triage@lists.linaro.org,
        Dan Rue <dan.rue@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello!

On Wed, 4 Sep 2019 at 17:44, shuah <shuah@kernel.org> wrote:
> On 9/3/19 8:00 AM, ci_notify@linaro.org wrote:
> > Summary
> > -----------------------------------------------------------------------=
-
> > kernel: 5.3.0-rc7
> > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git
> > git branch: master
> > git commit: 7dc4585e03786f84d6e9dc16caa3ba5b8b44d986
> > git describe: next-20190903
> > Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/ne=
xt-20190903
> >
> > Regressions (compared to build next-20190902)
>
> Looks like you are running kselftest from 5.2 on this linux-next.
> You won't be able to find any kselftest test regressions this way.
> You aren't testing the kselftest patches that are in linux-next
> for Linux 5.4-rc1.

The way OE refers to versions can be confusing (it was for me, at
least). The version is said to be "5.2+gitAUTOINC+7dc4585e03", which
means that it's 5.2 (last known version) + some Git commits. In this
case, 7dc4585e03 points to next-20190903.


> It would be helpful if you match the kernel and kselftest for linux-next
> and Linux mainline.

Indeed, we do that exactly:
* linux-next is tested with the in-kernel version of kselftests
* linux-mainline is tested with the in-kernel version of kselftests
* linux-stable 5.2 is tested with the latest released kselftests
(*should* be 5.2.11)
* linux-stable 4.19 is tested with the latest released kselftests
(*should* be 5.2.11)
* and so on for 4.14, 4.9 and 4.4

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
