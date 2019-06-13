Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1197F43EFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfFMPyM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:54:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33606 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731577AbfFMIze (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 04:55:34 -0400
Received: by mail-lf1-f68.google.com with SMTP id y17so14455498lfe.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2019 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oNyuLZ3F1bzaSW1koPHqyfFUd0fSRVPfMMwQfg+V81o=;
        b=LuZH0T6LZOMfFAn5Mqr/VDoSVFPwQAS4wijjxz/JKLLQjRDPvlC4TU7KR1OiQIUm+w
         7HmTOtPDE5CtlxIjIB0YApkq9PfEMq934UtIu98yN4+hSEVLnCdGPp7hCrX8VFk6LT70
         ZAfOA+pn47/JYmXECDZY4WM2feCEfylqNNgR26nq9R8n+blioc5FJaVLL4eJuQK6hQ5U
         j9PB/Hbpj7uWorSBjFKBT0Kz0Wj7QlBYGPUnSoBk9R9ayKbLFBJB31mWdzAM8/g7AAh/
         5Fa/dKtUxtVlXSubypXMBdCPwQMD1m+uaKCdjNp6/HslnZOieYyur3KCjVN2jeyZm/Uy
         GpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oNyuLZ3F1bzaSW1koPHqyfFUd0fSRVPfMMwQfg+V81o=;
        b=U8E8UEQrIvF5jcjNjVVqJFVijAbnpt804w9TPISvlSS1/4GDh57/IyXvA7m43KPlKi
         oHlr4znabhtXFaSnIhiULIco0PP8LzPDMZF6BV6QzBmwjzFKX6KbjM/zc4IlhUH+GuMK
         Dij/3FEafwjFHKELIFRLoJbmTtydMTVuPnuO8aGf9m6VjTC7pRoMzH/o2DD8Bc8YWmDj
         ig/ExynWRwW+SNO5BdC+dO8fnhcbKPLrvby0J9EkTHOe/8fGBKovJV2WsNEF2Wwme3Q0
         FJqK8t8bjlVrukpkNyMQvq4eCO7EFXLx4kHDcJySCSoH+cmRsD0NGgSjLrCZp9v0cjZl
         zlbw==
X-Gm-Message-State: APjAAAVXczc5YSSNelTmAxdzEl4RNUObNV3/6vVc3AdL+9E/eBul6WeD
        LEctvrK3Av1O+T+KT4P38di8igv/oyOMSLZCN1Ni+g==
X-Google-Smtp-Source: APXvYqxHxZeoI8y9NSIiggX0Bqcu/+nwOlyRycm9HNjCf6J7pZRMPHYqV6pY48zI52VlheP7hHVA1u2PDaJKRXJ3Yn8=
X-Received: by 2002:a19:671c:: with SMTP id b28mr44063506lfc.164.1560416131678;
 Thu, 13 Jun 2019 01:55:31 -0700 (PDT)
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
 <37e5e069-076d-9833-9eab-51c507fbbe2f@kernel.org> <CAEUSe791S6ODPZq4gcfbY=5kZ98ss2qNm0ks-oo0XLwFjsO=ag@mail.gmail.com>
In-Reply-To: <CAEUSe791S6ODPZq4gcfbY=5kZ98ss2qNm0ks-oo0XLwFjsO=ag@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 13 Jun 2019 14:25:20 +0530
Message-ID: <CA+G9fYs0AEMV2LC12kvBHLEgzoFh9Q9+7kRVUJV2BzFRnKJapQ@mail.gmail.com>
Subject: Re: kselftest build broken?
To:     Dmitry Vyukov <dvyukov@google.com>, shuah <shuah@kernel.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 13 Jun 2019 at 02:43, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wro=
te:
>
> Hello!
>
> On Wed, 12 Jun 2019 at 14:32, shuah <shuah@kernel.org> wrote:
> > On 6/12/19 12:29 PM, Dmitry Vyukov wrote:
> [...]
> > > 1. You suggested to install a bunch of packages. That helped to some
> > > degree. Is there a way to figure out what packages one needs to
> > > install to build the tests other than asking you?
> >
> > I have to go through discovery at times when new tests get added. I
> > consider this a part of being a open source developer figuring out
> > dependencies for compiling and running. I don't have a magic answer
> > for you and there is no way to make sure all dependencies will be
> > documented.
>
> This is something we, as users of Kselftests, would very much like to
> see improved. We also go by trial-and-error finding out what is
> missing, but keeping up with the new tests or subsystems is often
> difficult and tend to remain broken (in usage) for some time, until we
> have the resources to look into that and fix it. The config fragments
> is an excellent example of how the test developers and the framework
> complement each other to make things work. Even documenting
> dependencies would go a long way, as a starting point, but I do
> believe that the test writers should do that and not the users go
> figure out what all is needed to run their tests.
>
> Maybe a precheck() on the tests in order to ensure that the needed
> binaries are around?
>
> For what it's worth, this is the list of run-time dependencies package
> for OpenEmbedded: bash bc ethtool fuse-utils iproute2 iproute2-tc
> iputils-ping iputils-ping6 ncurses perl sudo python3-argparse
> python3-datetime python3-json python3-pprint python3-subprocess
> util-linux-uuidgen cpupower glibc-utils. We are probably missing a
> few.
>
> [...]
> > > 10. Do you know if anybody is running kselftests? Running as in
> > > running continuously, noticing new failures, reporting these failures=
,
> > > keeping them green, etc.
> > > I am asking because one of the tests triggers a use-after-free and I
> > > checked it was the same 3+ months ago. And I have some vague memories
> > > of trying to run kselftests 3 or so years ago, and there was a bunch
> > > of use-after-free's as well.
> >
> > Yes Linaro test rings run them and kernel developers do. I am cc'ing
> > Naresh and Anders to help with tips on how they run tests in their
> > environment. They have several test systems that they install tests
> > and run tests routine on all stable releases.
> >
> > Naresh and Anders! Can you share your process for running kselftest
> > in Linaro test farm. Thanks in advance.
>
> They're both in time zones where it's better to be sleeping at the
> moment, so I'll let them chime in with more info tomorrow (their
> time). I can share that we, as part of LKFT [1], run Kselftests with
> Linux 4.4, 4.9, 4.14, 4.19, 5.1, Linus' mainline, and linux-next, on
> arm, aarch64, x86, and x86-64, *very* often: Our test counter recently
> exceeded 5 million! You can see today's mainline results of Kselftests
> [2] and all tests therein.

Thanks Daniel.

In the recent past we have found kernel oops, bugs and warnings while
running kselftest suite on our environment. It is worth running them in CI.
Linaro 's test farm have been reporting these issues to kernel sub-system
maintainers and test authors and they have investigated and fixed.

The test cases which are known to fail due to missing dependency
it could be Kconfig or userland packages. There is one more case
we see failures when running latest test cases on older kernel
branches. We have marked them as known failures XFAIL [3].
qa reports will parse actual results and applies xfails as blue in color.

Best regards
Naresh Kamboju

>
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org
>
> [1] https://lkft.linaro.org/
> [2] https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.2-rc4-2=
0-gaa7235483a83/#!?details=3D175

[3] https://github.com/Linaro/qa-reports-known-issues/blob/master/kselftest=
s-production.yaml
