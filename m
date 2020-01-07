Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA04D132811
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 14:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgAGNto (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 08:49:44 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:17623 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgAGNtn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 08:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578404984; x=1609940984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=b7YvakxQUDhIYxvaIP9AWgD21Q+/Dpc5za+Ll0cvmyA=;
  b=dT99APbDX8WMAzafx3B8f95/9xO4fvleBjqyIk6v96dvO6PO52gjVvPk
   fRhhuA4cKDye1YfFrj70R5lTw62V0W6T3TvwxpNWrMoeCizEDVxphcWgS
   U8ExARa4Bcw1TrbvWmprHDJ0MxIO30zr65nVPg+SkIo+Ujg/CSGh+PQvo
   8=;
IronPort-SDR: +Orc/lmc0ipZQOdDDcYTpgvJiEqgvHzto1KG0KJliFle6CUe+TAtUYAMMz6jQWJnzCEk4rpOsE
 ncanrSeUR9wg==
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="17221127"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 07 Jan 2020 13:49:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id B2780141623;
        Tue,  7 Jan 2020 13:49:27 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 7 Jan 2020 13:49:27 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.244) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 Jan 2020 13:49:23 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Brendan Higgins <brendanhiggins@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj38.park@gmail.com>
Subject: Re: Re: Re: What is the best way to compare an unsigned and a constant?
Date:   Tue, 7 Jan 2020 14:49:10 +0100
Message-ID: <20200107134910.20347-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g47-wi0duBAVxvevDKT7eb7WGT9JMFoKgCJQQSa0P0h9Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.244]
X-ClientProxiedBy: EX13D06UWC004.ant.amazon.com (10.43.162.97) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On   Tue, 7 Jan 2020 05:35:21 -0800   Brendan Higgins <brendanhiggins@google.com> wrote:

> Sorry for the delay, I was on vacation. (I still am, but I was too ;-).)

Happy new year, Brendan :)

> 
> On Tue, Jan 7, 2020 at 3:52 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > On   Fri, 27 Dec 2019 13:52:27 +0100   Bernd Petrovitsch <bernd@petrovits=
> ch.priv.at> wrote:
> >
> > > This is a multi-part message in MIME format.
> > > --------------D98A0A31D62B0BC2939BAEE9
> > > Content-Type: text/plain; charset=3Dutf-8
> > > Content-Transfer-Encoding: quoted-printable
> > >
> > > Hi all!
> > >
> > > On 27/12/2019 13:39, SeongJae Park wrote:
> > > [...]
> > > > I have a function returning 'unsigned long', and would like to write =
> a =3D
> > > kunit
> > > > test for the function, as below.
> > > >=3D20
> > > >     unsigned long foo(void)
> > > >     {
> > > >             return 42;
> > > >     }
> > > >=3D20
> > > >     static void foo_test(struct kunit *test)
> > > >     {
> > > >         KUNIT_EXPECT_EQ(test, 42, foo());
> > > >     }
> > >
> > > For this case: shouldn't=3D20
> > > ----  snip  ----
> > > static void foo_test(struct kunit *test)
> > > {
> > >      KUNIT_EXPECT_EQ(test, 42ul, foo());
> > > }
> > > ----  snip  ----
> > > do the trick?
> >
> > Unfortunately, it doesn't works.
> >
> >     [13:04:58] Building KUnit Kernel ...
> >     In file included from /.../linux/include/linux/list.h:9:0,
> >                      from /.../linux/include/linux/wait.h:7,
> >                      from /.../linux/include/linux/wait_bit.h:8,
> >                      from /.../linux/include/linux/fs.h:6,
> >                      from /.../linux/include/linux/debugfs.h:15,
> >                      from /.../linux/mm/damon.c:12:
> >     /.../linux/mm/damon-test.h: In function =E2=80=98damon_test_foo=E2=80=
> =99:
> >     /.../linux/include/linux/kernel.h:842:29: warning: comparison of dist=
> inct pointer types lacks a cast
> >        (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
> >                                  ^
> >     /.../linux/include/kunit/test.h:493:9: note: in expansion of macro =
> =E2=80=98__typecheck=E2=80=99
> >       ((void)__typecheck(__left, __right));           \
> >              ^~~~~~~~~~~
> >     /.../linux/include/kunit/test.h:517:2: note: in expansion of macro =
> =E2=80=98KUNIT_BASE_BINARY_ASSERTION=E2=80=99
> >       KUNIT_BASE_BINARY_ASSERTION(test,           \
> >       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     /.../linux/include/kunit/test.h:606:2: note: in expansion of macro =
> =E2=80=98KUNIT_BASE_EQ_MSG_ASSERTION=E2=80=99
> >       KUNIT_BASE_EQ_MSG_ASSERTION(test,           \
> >       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     /.../linux/include/kunit/test.h:616:2: note: in expansion of macro =
> =E2=80=98KUNIT_BINARY_EQ_MSG_ASSERTION=E2=80=99
> >       KUNIT_BINARY_EQ_MSG_ASSERTION(test,           \
> >       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     /.../linux/include/kunit/test.h:979:2: note: in expansion of macro =
> =E2=80=98KUNIT_BINARY_EQ_ASSERTION=E2=80=99
> >       KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
> >       ^~~~~~~~~~~~~~~~~~~~~~~~~
> >     /.../linux/mm/damon-test.h:565:2: note: in expansion of macro =E2=80=
> =98KUNIT_EXPECT_EQ=E2=80=99
> >       KUNIT_EXPECT_EQ(test, 42ul, (int)foo());
> >       ^~~~~~~~~~~~~~~
> 
> Isn't the issue here that you fixed the 42, but are now casting the
> result of foo() to an int?

Oh, right...  Removing the non-sense casting fixed the problem.  Thanks,
Brendan!


Thanks,
SeongJae Park

> 
> Or have you fixed that now too?
> 
> Worst case (gross) scenario, you could just cast 42 to whatever type
> foo() returns.
> 
> > Some other thoughts?
> >
> >
> > Thanks,
> > SeongJae Park
> >
> >
> > >
> > > MfG,
> > >       Bernd
> > > --=3D20
> > > "I dislike type abstraction if it has no real reason. And saving
> > > on typing is not a good reason - if your typing speed is the main
> > > issue when you're coding, you're doing something seriously wrong."
> > >     - Linus Torvalds
> 
