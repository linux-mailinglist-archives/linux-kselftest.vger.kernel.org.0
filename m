Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1644116EB65
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2020 17:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgBYQ0z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Feb 2020 11:26:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40271 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbgBYQ0z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Feb 2020 11:26:55 -0500
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1j6d2r-0005TI-4c
        for linux-kselftest@vger.kernel.org; Tue, 25 Feb 2020 16:26:53 +0000
Received: by mail-lf1-f69.google.com with SMTP id a1so2617113lfr.16
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2020 08:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KgosfBk+kukcYhOBsRdACyiQcocWmwDB5HCCyo2ovs=;
        b=szS+RZMp7AsdUsi05zKXZwBzOjc/O14ujtWw0MLRGycJr1P2mL5vMW1Feym+B5F9Sl
         J86V1vPWgpwTjTBVDwJA9T218LicaNdwrp78DygTnJ9WKuI5TATMTGFdqgecbyiJXnnT
         vZWbDkpblz6tqG65cxeTF7gb8t429HUbD9FXguHlX0ZiYlxcp5rwbYI+vnIRBHRIlGej
         m+lLU5jMzQ3uVITCenJPIaF3OY/h6GQUeof5Rv0SRf9kNQ8scuFD/NpI6pXgTU7Hh0Gy
         u2pquRLQK3VTnVetEszYnGGZGST34/0z76d1rvdDzEqrQfbpEvK+wQvmXGN7HyYImZpO
         ze3Q==
X-Gm-Message-State: APjAAAUgaJ7A3ij78t0QyNvhl4MJbnb2EGdZ1wBSShaibekfWAz3fhKy
        AMV9SSEGjAiCjGsqaJx9fBpXNiHDqz2TuHjQfpHdJ0Dz/6HyvE9w17lL9UxdkUCKOwv34mXMCFb
        yBuqF0E3UFfbkNnMjeBB3CV0wVuW39yIEMqaOk9rGYxa1C/e2UW+J9txWG3jw
X-Received: by 2002:a05:651c:86:: with SMTP id 6mr35455452ljq.193.1582648012577;
        Tue, 25 Feb 2020 08:26:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhAChCYW8Rnza3LJ6Bqlvbte3yT4V3IJgbdnBoydcCXoxBv65l338zoLUI7XDIPP1MBkmx7GDdU7hQOX/tW8Q=
X-Received: by 2002:a05:651c:86:: with SMTP id 6mr35455420ljq.193.1582648012111;
 Tue, 25 Feb 2020 08:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20200225101809.9986-1-po-hsu.lin@canonical.com> <bbc88e24-835b-2b1e-2997-255896b14cc4@kernel.org>
In-Reply-To: <bbc88e24-835b-2b1e-2997-255896b14cc4@kernel.org>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Wed, 26 Feb 2020 00:26:40 +0800
Message-ID: <CAMy_GT_aUvyUGb8RhdWu5VQ7Y-a82-Jm4hY7fPGL+rEAityyhw@mail.gmail.com>
Subject: Re: [PATCH] selftests/timers: Turn off timeout setting
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, tglx@linutronix.de,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sure,
I will send V2 that include the change for makefile and more detail
about the change.
Thanks for the feedback,

On Tue, Feb 25, 2020 at 11:30 PM shuah <shuah@kernel.org> wrote:
>
> On 2/25/20 3:18 AM, Po-Hsu Lin wrote:
> > Tests in timers especially nsleep-lat, set-timer-lat,
> > inconsistency-check and raw_skew these 4 tests can take longer than
> > the default 45 seconds that introduced in commit 852c8cbf
> > (selftests/kselftest/runner.sh: Add 45 second timeout per test) to run.
> >
> > Disable the timeout setting for timers instead of looking for an proper
> > value to make it more general.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > ---
> >   tools/testing/selftests/timers/settings | 1 +
> >   1 file changed, 1 insertion(+)
> >   create mode 100644 tools/testing/selftests/timers/settings
> >
> > diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
> > new file mode 100644
> > index 0000000..e7b9417
> > --- /dev/null
> > +++ b/tools/testing/selftests/timers/settings
> > @@ -0,0 +1 @@
> > +timeout=0
> >
>
> What happens when you disable this and set it to 0? How long does the
> rest run in this case? Can you add the details to the change log please.
>
> thanks,
> -- Shuah
