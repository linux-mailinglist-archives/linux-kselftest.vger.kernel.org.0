Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2031D19F04B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Apr 2020 08:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgDFGZB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Apr 2020 02:25:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48600 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDFGZB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Apr 2020 02:25:01 -0400
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jLLBr-0008FY-2C
        for linux-kselftest@vger.kernel.org; Mon, 06 Apr 2020 06:24:59 +0000
Received: by mail-lf1-f70.google.com with SMTP id y23so3061661lfg.23
        for <linux-kselftest@vger.kernel.org>; Sun, 05 Apr 2020 23:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ise8WB4LRl+1spcOs3F4DjReORuX4aKlSFdb77NCTb4=;
        b=ig5SGOBDKnC8ED9FDGu+8P0JDRK900a3GU3NTSUF0kprz/ObNm1NVSKNx5VHQ477wr
         o/MMNp9RO1wRsAKcH4S+IXIP2e1f/va1LwlatcYgx8nJZS20nQlNyapo4DeqJYCfK08O
         JWEwCnZP6+2uE4SO84HCLNh2iUOd6d94XJ11IbbEmNcmiTXGK0/Re8HYhpNTolgBIHnx
         z4aH0i19F+ViCvY6fY1L/Ew6wbV0eJq1rVQEN9OaCchUZRLt3ud6zZTvaesI5fg+3cRW
         YUb8FBFeuFNtIy95GHtsGwfKZUmxlRtmvEbiK0hTztQgV0xwBHSsHErTBVs73xbAm2oW
         NYFA==
X-Gm-Message-State: AGi0PuaBKlrLr4XkHDskOu6x1D+cgWwRYn81BsDBPD4i+VitEokwbYp8
        QTlYLhog0fdnHy2O0dCG69pOkXlXUfSqAOeEQRrq/tWh0GPHkP/tZcGbJOV2SaexF0ersi+zQ/0
        Kq5KTJ9x9D7nd2SWs0SLkgiNBkHt+q9NZS4bITMPgE1YFpZgDLI+WRnRUS/d+
X-Received: by 2002:a2e:b5b2:: with SMTP id f18mr10630832ljn.136.1586154298501;
        Sun, 05 Apr 2020 23:24:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypLknrn4eH27Rcgb0jVh8EDXWocACeNuBZt1r2IrlCa/6rD5lG/hFhrhEnjD0tVOq1ce+J+HhjD+4A8KeoX660c=
X-Received: by 2002:a2e:b5b2:: with SMTP id f18mr10630818ljn.136.1586154298241;
 Sun, 05 Apr 2020 23:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200225165749.6399-1-po-hsu.lin@canonical.com> <6e13759d-370f-6cd3-34a7-08f2a9b6c0f0@kernel.org>
In-Reply-To: <6e13759d-370f-6cd3-34a7-08f2a9b6c0f0@kernel.org>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Mon, 6 Apr 2020 14:24:46 +0800
Message-ID: <CAMy_GT_kAeMX51N_Ujh8nRB44KNG99xMx0mpRXt1Lj0gkLQR-A@mail.gmail.com>
Subject: Re: [PATCHv2] selftests/timers: Turn off timeout setting
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, sboyd@kernel.org,
        tglx@linutronix.de, John Stultz <john.stultz@linaro.org>,
        joe.lawrence@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Patch V3 re-submitted, thanks!
https://lore.kernel.org/linux-kselftest/20200318024215.5270-1-po-hsu.lin@canonical.com/T/#u

On Sat, Mar 14, 2020 at 1:41 AM shuah <shuah@kernel.org> wrote:
>
> On 2/25/20 9:57 AM, Po-Hsu Lin wrote:
> > The following 4 tests in timers can take longer than the default 45
> > seconds that added in commit 852c8cbf (selftests/kselftest/runner.sh:
> > Add 45 second timeout per test) to run:
>
> Please use the commit format:
>
> commit 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second
> timeout per test")
>
> >    * nsleep-lat - 2m7.350s
> >    * set-timer-lat - 2m0.66s
> >    * inconsistency-check - 1m45.074s
> >    * raw_skew - 2m0.013s
> >
> > Thus they will be marked as failed with the current 45s setting:
> >    not ok 3 selftests: timers: nsleep-lat # TIMEOUT
> >    not ok 4 selftests: timers: set-timer-lat # TIMEOUT
> >    not ok 6 selftests: timers: inconsistency-check # TIMEOUT
> >    not ok 7 selftests: timers: raw_skew # TIMEOUT
> >
> > Disable the timeout setting for timers can make these tests finish
> > properly:
> >    ok 3 selftests: timers: nsleep-lat
> >    ok 4 selftests: timers: set-timer-lat
> >    ok 6 selftests: timers: inconsistency-check
> >    ok 7 selftests: timers: raw_skew
> >
> > https://bugs.launchpad.net/bugs/1864626
> Please add Fixes tag with commit 852c8cbf34d3
> ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > ---
> >   tools/testing/selftests/timers/Makefile | 1 +
> >   tools/testing/selftests/timers/settings | 1 +
> >   2 files changed, 2 insertions(+)
> >   create mode 100644 tools/testing/selftests/timers/settings
> >
> > diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
> > index 7656c7c..0e73a16 100644
> > --- a/tools/testing/selftests/timers/Makefile
> > +++ b/tools/testing/selftests/timers/Makefile
> > @@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
> >
> >   TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
> >
> > +TEST_FILES := settings
> >
> >   include ../lib.mk
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
> thanks,
> -- Shuah
