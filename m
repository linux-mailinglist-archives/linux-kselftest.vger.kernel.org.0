Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41B4315F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 23:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfFLVNL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 17:13:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38881 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFLVNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 17:13:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id b11so13314647lfa.5
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m3eluTPYVzNblYkcubvASnbKZ3oggUy7wSqozoUB0t0=;
        b=uiU8FLwX3434tPqbqESOwPl9NuP+gqm+wnw6eDhDuk+k0a2P7CQHJRbeV76BH+SKLv
         6PB6WNcNSWsDgTh4UC+Syhn9I5g3e/HR2HJ28ktJY3R3+QjE8OCHFHnbW6vG8BElFgos
         o8GpujBqHaKPizaobeqzHr6EyfQ3KLJnZrXvvZl4Dq3fvG1O5gZMcy2zSd03oiQkT2si
         eX91RiZESr/P6IO9Ug2th0J36zhE5y7X8hRhYBRyFNvxB4g6F0hOmYOY1j0O/1A2E3Mu
         4HOmXxeFyc5u6hED/DlOdmXqZNehn+MJVgJ3vGGqnBHUXnAmit71Y43gWZd140cJ9zjz
         7LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m3eluTPYVzNblYkcubvASnbKZ3oggUy7wSqozoUB0t0=;
        b=POmLbh+2iuuopa/n0GlX4jiJ/DYnD+ZjIjCoE8b85hoxXaaNL+P+N00AOhGxdILE6X
         Ta2qLFKldajucLcPuhZXEEIASwiF9XSf9cv7CtyrO0quqiyN3aV/tt8zaEE0Z0kGnJlh
         u4GUeRHGpvKIQBCgukCQp9HPpP9qyGdtotVQX+cBuy83x2LgkgOsmBDVwDaTRqxAOg0+
         ksPUmQ+t7Lu8y5RDdpIJf5uhQhU36/seEoJSgOLDbu4IbLhO9+IgIMv9Oherfi3SnsXl
         jd+nLsvU/3WAQw/TBTihZYenFNgad46mcCYW/0nLj9doSZ2E26b4qtcjOc2CPnL6o5OV
         yVDg==
X-Gm-Message-State: APjAAAVDSGn2TtTVeWNWwvmSJ4djyyfsLs2MndlGm0G41sFwNs0c98wf
        XhPQ3TS/wiaC05Fn2gujsh6gCekT6a6nb97SpVPjMQ==
X-Google-Smtp-Source: APXvYqzTrjmhY6lEWtZGwixM0wlOHO4foS0lmd7703KBefIWSCGeUDHYpg9PsXJmLSTseaFbs8lbQI14uUlhAIfUeDQ=
X-Received: by 2002:a19:6519:: with SMTP id z25mr42025244lfb.73.1560373989492;
 Wed, 12 Jun 2019 14:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Z4naaxx4N2B2t1hn4A99dfk=6yTY2yAZM=aJ05VCPLFQ@mail.gmail.com>
 <54bc80f8-71aa-1c04-5908-01923247832e@kernel.org> <CACT4Y+YUBw=t3CkbLeKLFAeAbzVZXoG09HARR+nsOTW4gkdLOw@mail.gmail.com>
 <6d5e0484-4dbc-d122-1ae4-9cce44c2d668@kernel.org> <CACT4Y+aE841JzvEVFmAevgmBO0eOssz0MFydWiuoAp18nr=_DA@mail.gmail.com>
 <CACT4Y+abfa9xVg+3S_tgpOA3cZ2bexe51d0FEZyBCGn0M-6DiA@mail.gmail.com>
 <CACT4Y+aiDUV4_JrvKct98mKvPwEQXSZFXae3qweSmotpzCAGTw@mail.gmail.com>
 <CACT4Y+a8zK7st7LUTkD=AaUBZGsn5hqLt5NXHHvJ0dg1Jds6Nw@mail.gmail.com>
 <CACT4Y+YKf3BFi-9J7Ag0yPtEWYrsPZXY1qUw21yRkNYu51wBWg@mail.gmail.com>
 <CACT4Y+bfz2F-p4xODb_=rU0+F-FJCC66MJW7q9DXd0UHoUfgwg@mail.gmail.com>
 <1e2cc74d-a6c2-0a73-ede5-c72df28e96b2@kernel.org> <CACT4Y+a203xykAHckhtMQ7ov-wNJ-YeuMg=o7qk=H9TQ756jcg@mail.gmail.com>
 <37e5e069-076d-9833-9eab-51c507fbbe2f@kernel.org>
In-Reply-To: <37e5e069-076d-9833-9eab-51c507fbbe2f@kernel.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 12 Jun 2019 16:12:58 -0500
Message-ID: <CAEUSe791S6ODPZq4gcfbY=5kZ98ss2qNm0ks-oo0XLwFjsO=ag@mail.gmail.com>
Subject: Re: kselftest build broken?
To:     shuah <shuah@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello!

On Wed, 12 Jun 2019 at 14:32, shuah <shuah@kernel.org> wrote:
> On 6/12/19 12:29 PM, Dmitry Vyukov wrote:
[...]
> > 1. You suggested to install a bunch of packages. That helped to some
> > degree. Is there a way to figure out what packages one needs to
> > install to build the tests other than asking you?
>
> I have to go through discovery at times when new tests get added. I
> consider this a part of being a open source developer figuring out
> dependencies for compiling and running. I don't have a magic answer
> for you and there is no way to make sure all dependencies will be
> documented.

This is something we, as users of Kselftests, would very much like to
see improved. We also go by trial-and-error finding out what is
missing, but keeping up with the new tests or subsystems is often
difficult and tend to remain broken (in usage) for some time, until we
have the resources to look into that and fix it. The config fragments
is an excellent example of how the test developers and the framework
complement each other to make things work. Even documenting
dependencies would go a long way, as a starting point, but I do
believe that the test writers should do that and not the users go
figure out what all is needed to run their tests.

Maybe a precheck() on the tests in order to ensure that the needed
binaries are around?

For what it's worth, this is the list of run-time dependencies package
for OpenEmbedded: bash bc ethtool fuse-utils iproute2 iproute2-tc
iputils-ping iputils-ping6 ncurses perl sudo python3-argparse
python3-datetime python3-json python3-pprint python3-subprocess
util-linux-uuidgen cpupower glibc-utils. We are probably missing a
few.

[...]
> > 10. Do you know if anybody is running kselftests? Running as in
> > running continuously, noticing new failures, reporting these failures,
> > keeping them green, etc.
> > I am asking because one of the tests triggers a use-after-free and I
> > checked it was the same 3+ months ago. And I have some vague memories
> > of trying to run kselftests 3 or so years ago, and there was a bunch
> > of use-after-free's as well.
>
> Yes Linaro test rings run them and kernel developers do. I am cc'ing
> Naresh and Anders to help with tips on how they run tests in their
> environment. They have several test systems that they install tests
> and run tests routine on all stable releases.
>
> Naresh and Anders! Can you share your process for running kselftest
> in Linaro test farm. Thanks in advance.

They're both in time zones where it's better to be sleeping at the
moment, so I'll let them chime in with more info tomorrow (their
time). I can share that we, as part of LKFT [1], run Kselftests with
Linux 4.4, 4.9, 4.14, 4.19, 5.1, Linus' mainline, and linux-next, on
arm, aarch64, x86, and x86-64, *very* often: Our test counter recently
exceeded 5 million! You can see today's mainline results of Kselftests
[2] and all tests therein.

We do not build our kernels with KASAN, though, so our test runs don't
exhibit that bug.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

[1] https://lkft.linaro.org/
[2] https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.2-rc4-20-=
gaa7235483a83/#!?details=3D175
