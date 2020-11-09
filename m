Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E322AB008
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Nov 2020 04:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgKIDms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Nov 2020 22:42:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33700 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgKIDmr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Nov 2020 22:42:47 -0500
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kby4r-0007RO-7U
        for linux-kselftest@vger.kernel.org; Mon, 09 Nov 2020 03:42:45 +0000
Received: by mail-lj1-f198.google.com with SMTP id 15so876786ljr.19
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Nov 2020 19:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUcCrCG2WCSSYmMzIiMD5eJ3e1Q9gtiF+ZTLVEFlpk4=;
        b=ppjf4BsytIA5q61lLaty5hnWKYOYC1gBtXCc/peumPeM+f/ntqlyKw9uPV4AfBeFN/
         K4AVTqQ8R0Q2cDmA7H4o6I1M39xkF51WlDgLl0wKXNek2dfqrVfVpHX16NpUV2pGPelk
         tkmR5iqFLUjc6ctw96tdxBDsV3SmMUeOQTOuL3gHKHKhdLJdl1/PszyphxMRIsDH3gd7
         EMTfTY2AHYrm2aeu2fxSwr6xeIEjZhkLIzzjK8JFFX+E+v7okUAvbr2/csqUBqQXJifd
         gcMqDqn/+uDzY8z1lIjFnBorG15TbV8kqZLuftAn8rnquI/qN/YjTChvySnTA8yQwkRW
         tYdg==
X-Gm-Message-State: AOAM533kqcmSV/2KtXed60+cbovk6f4lkqpPVM/gUWTjrkx9uPu7GIgF
        SAoaD9L2mo3tg8y91qoa00Mp/q03N+cDfke46amxZRUyQrLo6uY4L29hzGngOpHmEmZiOZ6zuh7
        Q0wKD1Z9iDC00/pBQKHfjQqB3dh2XKJFwqfprDp1JDNrj98vJNs2j+t07Fem1
X-Received: by 2002:ac2:5e23:: with SMTP id o3mr2576561lfg.52.1604893364387;
        Sun, 08 Nov 2020 19:42:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxK1CNIH+0fkqb378JO7cEXuRLrjY/Qi39CLPDYJjYKo+ATQvkmLQH6wGhxbN75XHrpsqaarUY5Sv/dDt9QLFM=
X-Received: by 2002:ac2:5e23:: with SMTP id o3mr2576555lfg.52.1604893364127;
 Sun, 08 Nov 2020 19:42:44 -0800 (PST)
MIME-Version: 1.0
References: <20201105105051.64258-1-po-hsu.lin@canonical.com>
 <20201105105051.64258-3-po-hsu.lin@canonical.com> <20201107150200.509523e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201107150200.509523e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Mon, 9 Nov 2020 11:42:33 +0800
Message-ID: <CAMy_GT-Hsj7GmHKBb9Ztvsisrujud1C=E+sKE1TfHDsszwpMXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: pmtu.sh: improve the test result processing
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 8, 2020 at 7:02 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu,  5 Nov 2020 18:50:51 +0800 Po-Hsu Lin wrote:
> > This test will treat all non-zero return codes as failures, it will
> > make the pmtu.sh test script being marked as FAILED when some
> > sub-test got skipped.
> >
> > Improve the result processing by
> >   * Only mark the whole test script as SKIP when all of the
> >     sub-tests were skipped
> >   * If the sub-tests were either passed or skipped, the overall
> >     result will be PASS
> >   * If any of them has failed, the overall result will be FAIL
> >   * Treat other return codes (e.g. 127 for command not found) as FAIL
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> Patch 1 looks like a cleanup while patch 2 is more of a fix, can we
> separate the two and apply the former to -next and latter to 5.10?
> They shouldn't conflict, right?
>

Hello Jakub,

Yes the first patch is just changing return code to $ksft_skip, the
real fix is the second one. However the second patch was based on the
first one, if we want to apply them separately we might need to change
this $ksft_skip handling part in the second patch.

What should I do to deal with this?
Resend the former for -next and rebase + resend the latter (plus the
fix to remove case 1) for 5.10 without the former patch?
Thanks!

> > diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
> > index fb53987..5c86fb1 100755
> > --- a/tools/testing/selftests/net/pmtu.sh
> > +++ b/tools/testing/selftests/net/pmtu.sh
> > @@ -1652,7 +1652,23 @@ run_test() {
> >       return $ret
> >       )
> >       ret=$?
> > -     [ $ret -ne 0 ] && exitcode=1
> > +     case $ret in
> > +             0)
> > +                     all_skipped=false
> > +                     [ $exitcode=$ksft_skip ] && exitcode=0
> > +             ;;
> > +             1)
> > +                     all_skipped=false
> > +                     exitcode=1
> > +             ;;
>
> Does it make sense to remove this case? The handling is identical to
> the default case *).
>

Yes you're right, we can remove this part.

> > +             $ksft_skip)
> > +                     [ $all_skipped = true ] && exitcode=$ksft_skip
> > +             ;;
> > +             *)
> > +                     all_skipped=false
> > +                     exitcode=1
> > +             ;;
> > +     esac
> >
> >       return $ret
> >  }
> > @@ -1786,6 +1802,7 @@ usage() {
> >  #
> >  exitcode=0
> >  desc=0
> > +all_skipped=true
> >
> >  while getopts :ptv o
> >  do
>
