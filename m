Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED612B491
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2019 13:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfL0MkX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Dec 2019 07:40:23 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:6410 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0MkX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Dec 2019 07:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577450423; x=1608986423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TqWie5+1D5ATHV9gdzwRKMb1Ha1+Oq3U+OrZZ0ZX4K8=;
  b=c0BJF76Q+2FRXtLoDxL3w2oyG+4VfxeJVHEBJ5iYBlhLkBybKp94vfW8
   50f5iLB9sxwQQLZnEHVSv3r3InKZfzqupw8/b0tFsOsJTBZirx94YhJNx
   wytEo6KssBJe83jFcCF2UvL8nhFrAiSTFYMXmpJtCVvVzotP17DlC6P2/
   8=;
IronPort-SDR: iD8cDYmZVFb+x36/cyvjanwL1Nwiff6ulXzBAstzWvGZzryhX/RYKugnTo5bTFdu8cDXN7fdyw
 IR+7ZZjP49Ew==
X-IronPort-AV: E=Sophos;i="5.69,363,1571702400"; 
   d="scan'208";a="15731526"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Dec 2019 12:40:12 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 8EB62A1C8F;
        Fri, 27 Dec 2019 12:40:09 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Dec 2019 12:40:08 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.242) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Dec 2019 12:40:05 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <brendanhiggins@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, SeongJae Park <sj38.park@gmail.com>
Subject: What is the best way to compare an unsigned and a constant?
Date:   Fri, 27 Dec 2019 13:39:38 +0100
Message-ID: <20191227123938.5271-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.242]
X-ClientProxiedBy: EX13D05UWB004.ant.amazon.com (10.43.161.208) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,


I have a function returning 'unsigned long', and would like to write a kunit
test for the function, as below.

    unsigned long foo(void)
    {
    	return 42;
    }

    static void foo_test(struct kunit *test)
    {
        KUNIT_EXPECT_EQ(test, 42, foo());
    }

However, this kunit gives me below warning for the above code:

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
    /.../linux/mm/foo-test.h:565:2: note: in expansion of macro ‘KUNIT_EXPECT_EQ’
      KUNIT_EXPECT_EQ(test, 42, foo());
      ^~~~~~~~~~~~~~~

I could remove the warning by explicitly type casting the constant as below:

        KUNIT_EXPECT_EQ(test, (unsigned long)42, foo());

However, now 'checkpatch.pl' complains about the type casting as below.

    WARNING: Unnecessary typecast of c90 int constant
    #565: FILE: mm/foo-test.h:565:
    +       KUNIT_EXPECT_EQ(test, (unsigned long)42, foo());

Of course, there could be several work-arounds for these warnings, such as
using 'EXPECT_TRUE(test, 42 == foo())' or casting the function's return value.
Nonetheless, I'm not sure what is the right way.  Could you please let me know
what is the recommended way for this case?


Thanks,
SeongJae Park
