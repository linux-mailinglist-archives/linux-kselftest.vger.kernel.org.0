Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25EA512B4C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2019 14:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfL0NIn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Dec 2019 08:08:43 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:45941 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0NIn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Dec 2019 08:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577452123; x=1608988123;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Q5c4P1klft40yJ0p29MuVtu83VklnTxjifywTVem2zo=;
  b=IM9vqOEuoP5sO3iDcz+CFkjlFWFto7VY9A+EyWf5Yuaa5MoDRLBRNJZ2
   +PnOtDZlydnd4k/nM7n0HizAqikq0vZKaBP51V1aKgOCW+Y27YiJm6Kox
   Hg1mRyvRkfwxiNQPhQzrZAOdKNGNBtXH1lT+82+xos8dk3vysWF/ESnpw
   I=;
IronPort-SDR: Pk8K7OzuhYrfSsahFWe24b9NEPtZcqwRMxX/tWmi/oPpMJAW1Fd/EBBJBdwvp809wg3MDZgg5D
 dgpU9+MjN18w==
X-IronPort-AV: E=Sophos;i="5.69,363,1571702400"; 
   d="scan'208";a="10736271"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 27 Dec 2019 13:08:41 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id C80EAA0701;
        Fri, 27 Dec 2019 13:08:39 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Dec 2019 13:08:39 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.44) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Dec 2019 13:08:32 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
CC:     SeongJae Park <sjpark@amazon.com>, <joe@perches.com>,
        <brendanhiggins@google.com>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj38.park@gmail.com>
Subject: Re: Re: What is the best way to compare an unsigned and a constant?
Date:   Fri, 27 Dec 2019 14:08:11 +0100
Message-ID: <20191227130811.12839-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <688d8f4b-266f-2c47-d4e9-d0336316a0a9@petrovitsch.priv.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.44]
X-ClientProxiedBy: EX13D03UWC001.ant.amazon.com (10.43.162.136) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 27 Dec 2019 13:52:27 +0100 Bernd Petrovitsch <bernd@petrovitsch.priv.at> wrote:

> --------------D98A0A31D62B0BC2939BAEE9
> Content-Type: text/plain; charset="utf-8"
> Content-Transfer-Encoding: quoted-printable
> 
> Hi all!
> 
> On 27/12/2019 13:39, SeongJae Park wrote:
> [...]
> > I have a function returning 'unsigned long', and would like to write a ku=
> nit
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

Thank you for quick answer :)
That makes 'checkpatch.pl' be silent, but unfortunately, not kunit.

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
> 
