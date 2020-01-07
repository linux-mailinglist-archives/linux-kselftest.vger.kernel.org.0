Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26CD13253F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 12:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAGLwp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 06:52:45 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:8834 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgAGLwo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 06:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578397965; x=1609933965;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=M87RnN37XgwXCD+GEsg/u8hPt4iEW8Ew/QPEy5zhFjc=;
  b=WUm+TZCIN8JyIo+4P1Wg/Q8pD46hMvNdHThqLY0Na62VWJVy2aR+hBTR
   tCnA4/lRCWSNH+B1gtO0yNUm7V9CkF8ZwozQeaqTpjqzCHCBitQ1s8QWP
   6AjaRbZu4SDYGYlXRzyevVKOkbMTsHpc0IcMROeEuB+FI/5oZlfgJTbRS
   c=;
IronPort-SDR: 9QW/w+s9Ty8UIMq8ZXzz9RtmmatTtG46bWiI0BW3qfPCmLMb8lsJBYJTfSKsyz+Ts+Ge3lJETh
 vKyf0SJ9FXSw==
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="10389039"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 07 Jan 2020 11:52:43 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 0609FA1F9C;
        Tue,  7 Jan 2020 11:52:41 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 Jan 2020 11:52:41 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.119) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 Jan 2020 11:52:37 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
CC:     SeongJae Park <sjpark@amazon.com>, <brendanhiggins@google.com>,
        <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sj38.park@gmail.com>
Subject: Re: Re: What is the best way to compare an unsigned and a constant?
Date:   Tue, 7 Jan 2020 12:52:20 +0100
Message-ID: <20200107115220.25574-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <688d8f4b-266f-2c47-d4e9-d0336316a0a9@petrovitsch.priv.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.119]
X-ClientProxiedBy: EX13D33UWB004.ant.amazon.com (10.43.161.225) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On   Fri, 27 Dec 2019 13:52:27 +0100   Bernd Petrovitsch <bernd@petrovitsch.priv.at> wrote:

> This is a multi-part message in MIME format.
> --------------D98A0A31D62B0BC2939BAEE9
> Content-Type: text/plain; charset=utf-8
> Content-Transfer-Encoding: quoted-printable
> 
> Hi all!
> 
> On 27/12/2019 13:39, SeongJae Park wrote:
> [...]
> > I have a function returning 'unsigned long', and would like to write a =
> kunit
> > test for the function, as below.
> >=20
> >     unsigned long foo(void)
> >     {
> >     	return 42;
> >     }
> >=20
> >     static void foo_test(struct kunit *test)
> >     {
> >         KUNIT_EXPECT_EQ(test, 42, foo());
> >     }
> 
> For this case: shouldn't=20
> ----  snip  ----
> static void foo_test(struct kunit *test)
> {
>      KUNIT_EXPECT_EQ(test, 42ul, foo());
> }
> ----  snip  ----
> do the trick?

Unfortunately, it doesn't works.

    [13:04:58] Building KUnit Kernel ...
    In file included from /.../linux/include/linux/list.h:9:0,
                     from /.../linux/include/linux/wait.h:7,
                     from /.../linux/include/linux/wait_bit.h:8,
                     from /.../linux/include/linux/fs.h:6,
                     from /.../linux/include/linux/debugfs.h:15,
                     from /.../linux/mm/damon.c:12:
    /.../linux/mm/damon-test.h: In function ‘damon_test_foo’:
    /.../linux/include/linux/kernel.h:842:29: warning: comparison of distinct pointer types lacks a cast
       (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                                 ^
    /.../linux/include/kunit/test.h:493:9: note: in expansion of macro ‘__typecheck’
      ((void)__typecheck(__left, __right));           \
             ^~~~~~~~~~~
    /.../linux/include/kunit/test.h:517:2: note: in expansion of macro ‘KUNIT_BASE_BINARY_ASSERTION’
      KUNIT_BASE_BINARY_ASSERTION(test,           \
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    /.../linux/include/kunit/test.h:606:2: note: in expansion of macro ‘KUNIT_BASE_EQ_MSG_ASSERTION’
      KUNIT_BASE_EQ_MSG_ASSERTION(test,           \
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    /.../linux/include/kunit/test.h:616:2: note: in expansion of macro ‘KUNIT_BINARY_EQ_MSG_ASSERTION’
      KUNIT_BINARY_EQ_MSG_ASSERTION(test,           \
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /.../linux/include/kunit/test.h:979:2: note: in expansion of macro ‘KUNIT_BINARY_EQ_ASSERTION’
      KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
      ^~~~~~~~~~~~~~~~~~~~~~~~~
    /.../linux/mm/damon-test.h:565:2: note: in expansion of macro ‘KUNIT_EXPECT_EQ’
      KUNIT_EXPECT_EQ(test, 42ul, (int)foo());
      ^~~~~~~~~~~~~~~

Some other thoughts?


Thanks,
SeongJae Park


> 
> MfG,
> 	Bernd
> --=20
> "I dislike type abstraction if it has no real reason. And saving
> on typing is not a good reason - if your typing speed is the main
> issue when you're coding, you're doing something seriously wrong."
>     - Linus Torvalds
