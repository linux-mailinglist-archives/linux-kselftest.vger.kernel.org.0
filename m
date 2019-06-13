Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA6B94449F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 18:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfFMQiH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 12:38:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42084 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392677AbfFMQhw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 12:37:52 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so18334930ior.9
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2019 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ia+UkKgK3wIMJUQg36mIwLiCXpVYOtzZdI1K2jTMm+U=;
        b=CxtDkJLFtbujeuZkbhiK8NEOpPiO+LjAcw45ZjY6JHPbVzp1q6g9FEeJCvMQY5npsG
         9+T6I/T+YAjF8A7lfJ39/IazuRfTc/0j5/FkWUkHqAWAmwzIHZn/E+XlSgrozOmra0a3
         tQZqICcjpkNJthdQgmPujPT7misD/UaBNAB3db272JFepD5SkDo+GxajMZx7E8alHh6w
         Qq7RywpHJtSjGLdKZgZFhR3Tmt+YscoyLBROO7M5Bbng/8V4Frpv0M64JR37TxvwGqjk
         RvA+D9CWOIvru1+7VB/8q0rJoUV4oTMpToKpYM+ASk6ivQ6xnujZFny/hXLQ9c/XzE3O
         tDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ia+UkKgK3wIMJUQg36mIwLiCXpVYOtzZdI1K2jTMm+U=;
        b=B4+MrMsH9PnVIuGpmg785lI5gqC1kXawPOI3NzClUx5JlIKt3GVD+3+jyWcjGffCCN
         mTwzUIWy1kZng+Qq7cfcmuQsZW6Govma1r2GKR1eXHw+4NqxjhL6LYQxqDcgA5XPxthI
         0bOK5oiNTXZBVoMmcp0cJyhf1U70tcZzLLtiJtG8uvOihrxmdhruJJsGM3oBtQFVGsHV
         ncARj5CTEFxAuBYzn0eelsD6CqtsZtu2vAnfhCxByrGhVyAAqVcpzD0kmncNIn9NEBXC
         KKFzUenljTe+14H3a5QPIj5OnhqqSN9VIglYLfNH2roipjDNHvoJJX5R517R147hd8Y5
         MONg==
X-Gm-Message-State: APjAAAXtM1tI8xHa7WXnLR2q/d4PESK2BFQUAxOYVHAWGCqHcWpmO/Qg
        pNsKdxTNSRK7+A4jtKNza6XWYlkwQbEMjpt/E1wHt5XU9zI=
X-Google-Smtp-Source: APXvYqz+Ukohsrl6mAoFjTo3YW6iM0rQ6d/ZkMzj33WO7IO7YwegRkY4TxBCZ7hrywBGSf8f7bKXe5FONWzZfriuyp8=
X-Received: by 2002:a02:a90a:: with SMTP id n10mr46425709jam.61.1560443870686;
 Thu, 13 Jun 2019 09:37:50 -0700 (PDT)
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
 <CACT4Y+Z9073CozbR800E7p9EdVsfGJ471i0_pF4GftQkY7S90Q@mail.gmail.com> <CAEUSe7_VSPceBnaK39Mc0jkkqM356MTOO8pnS1T9aP_1J1wnkQ@mail.gmail.com>
In-Reply-To: <CAEUSe7_VSPceBnaK39Mc0jkkqM356MTOO8pnS1T9aP_1J1wnkQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Jun 2019 18:37:39 +0200
Message-ID: <CACT4Y+ZwbiiHSj+HKKoiagR5XF1j1LzvzGZCfzj5JYvuqHT0CQ@mail.gmail.com>
Subject: Re: kselftest build broken?
To:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc:     shuah <shuah@kernel.org>,
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

On Thu, Jun 13, 2019 at 4:58 PM Daniel D=C3=ADaz <daniel.diaz@linaro.org> w=
rote:
>
> Hello!
>
> On Thu, 13 Jun 2019 at 09:22, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Wed, Jun 12, 2019 at 11:13 PM Daniel D=C3=ADaz <daniel.diaz@linaro.o=
rg> wrote:
> > > Maybe a precheck() on the tests in order to ensure that the needed
> > > binaries are around?
> >
> > Hi Daniel,
> > The Automated Testing effort:
> > https://elinux.org/Automated_Testing
> > is working on a standard for test metadata description which will
> > capture required configs, hardware, runtime-dependencies, etc. I am
> > not sure what's the current progress, though.
>
> We just had the monthly call one hour ago. You should join our next
> call! Details are in the Wiki link you shared.
>
>
> > Documenting or doing a precheck is a useful first step. But ultimately
> > this needs to be in machine-readable meta-data. So that it's possible
> > to, say, enable as much tests as possible on a CI, rather then simply
> > skip tests. A skipped test is better then a falsely failed test, but
> > it still does not give any test coverage.
>
> I agree. We discussed some of this in an impromptu microsummit at
> Linaro Connect BKK19 a few months back, i.e. a way to encapsulate
> tests and tests' definitions. Tim Bird is leading that effort; the
> minutes of today's call will be sent to the mailing list, so keep an
> eye on his update!
>
>
> > > [...] we, as part of LKFT [1], run Kselftests with
> > > Linux 4.4, 4.9, 4.14, 4.19, 5.1, Linus' mainline, and linux-next, on
> > > arm, aarch64, x86, and x86-64, *very* often: Our test counter recentl=
y
> > > exceeded 5 million!
>
> I was wrong by an order of magnitude: It's currently at 51.7 million test=
s.

w00t!

> > > We do not build our kernels with KASAN, though, so our test runs don'=
t
> > > exhibit that bug.
> >
> > But you are aware of KASAN, right? Do you have any plans to use it?
>
> Not at the moment. We are redesigning our entire build and test
> infrastructure, and this is something that we are considering for our
> next iteration.
>
> > If you are interested I can go into more details as we do lots of this
> > on syzbot. Besides catching more bugs there is also an interesting
> > possibility of systematically testing all error paths.
>
> Definitely join us on the Automated Testing monthly call; next one is
> July 11th. There are efforts on several fronts on testing the kernel,
> and we all are eager to contribute to improving the kernel test
> infrastructure.


Thanks, I will try to join the August one. Jul 11 I will be on a conference=
.
