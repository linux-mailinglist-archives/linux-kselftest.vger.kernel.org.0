Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2219F17A386
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 11:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgCEK6P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 05:58:15 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:46172 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgCEK6P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 05:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1583405894; x=1614941894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ojTAuSJDm69Io0P8U0Y2BJzm0Z0TFV7WQiEQVKAfL24=;
  b=uh8VCLjqJFmwBXmm5Jy/GAxQ7ko1/AJe4Sg8n4GKJLqhW56AiUn2ftAd
   Ae7SfozF74OSsOiiRrFWuaGKz+adN4OAyGdgSY8Y6Z+BeGkyF1qs6upgw
   g4Aw0uO34LeBhI0lLO0+yZ9LInusaH2/PYH16SVymBpS9hTlFBkNLwcZe
   Q=;
IronPort-SDR: c0YteK+JK7Ka+pOzEod0lDxfv2rQLs+bdcrx8gatT7u4lL5WoPsGJUu1I1ceAdT1WyF4Gd8ZxV
 /nOvyiCMOThA==
X-IronPort-AV: E=Sophos;i="5.70,517,1574121600"; 
   d="scan'208";a="29413309"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Mar 2020 10:58:12 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 05478A1907;
        Thu,  5 Mar 2020 10:58:10 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Mar 2020 10:58:08 +0000
Received: from 38f9d3582de7.ant.amazon.com.com (10.43.162.115) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 5 Mar 2020 10:58:04 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     <keescook@chromium.org>
CC:     <kuni1840@gmail.com>, <kuniyu@amazon.co.jp>,
        <linux-kselftest@vger.kernel.org>, <luto@amacapital.net>,
        <osa-contribution-log@amazon.com>, <shuah@kernel.org>,
        <wad@chromium.org>
Subject: Re: [PATCH] selftests: Add support for argc and argv.
Date:   Thu, 5 Mar 2020 19:57:59 +0900
Message-ID: <20200305105759.53508-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <202003041016.38A4956310@keescook>
References: <202003041016.38A4956310@keescook>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.115]
X-ClientProxiedBy: EX13D04UWA002.ant.amazon.com (10.43.160.31) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 4 Mar 2020 10:17:41 -0800
> On Wed, Mar 04, 2020 at 05:52:04PM +0900, Kuniyuki Iwashima wrote:
> > Currently tests are often written in C and shell script. In many cases, the
> > script passes some arguments to the C program. However, the helper
> > functions do not support arguments, so many tests are written without
> > helper functions.
> > 
> > This patch allows us to handle argc and argv in each tests and makes it
> > easier to write tests flexibly with helper functions.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> 
> Interesting! Do you have an example that uses this? I wonder if it might
> make sense instead to allow extending the struct __test_metadata with
> test-specific options so that individual tests don't have to re-parse
> argv every time (the main test running could instead do it once and set
> variables in struct __test_metadata (or somewhere else).

I added a sample test program at the end of this mail.

There are some functions that are not TEST() but are passed __test_metadata to
in order to use ASSERT_EQ in the function. I did not extend __test_metadata
because I thought argc and argv would not be used in such functions.

  e.g. kill_thread_or_group() in tools/testing/selftests/seccomp/seccomp_bpf.c

But, I have not thought about re-parsing, thank you!
Also I thought up that it is better to pass argc and argv to
FIXTURE_SETUP/TEARDOWN.

Now I have two idea.

  1. pass argc and argv to FIXTURE_SETUP/TEARDOWN.
  2. define COMMON_FIXTURE and COMMON_FIXTURE_SETUP/TEARDOWN,
       and pass COMMON_FIXTURE to all tests.
       (I think it is not good to extend __test_metadata because argc and
        argv is not metadata, so it is good to setup another vars with args)

I think each has pros and cons.

1.
Pros
  - shell script only has to call a C program once with some arguments and
      each FIXTURE_SETUP differs from one another
  - shell script can call the same C program with different arguments and
      each FIXTURE_SETUP differs from one another
Cons:
  - if TEST()s use the same FIXTURE, the same FIXTURE_SETUP is called in each TEST()s.

2.
Pros:
  - we do not have to re-parse argc and argv in each TEST()s.
Cons:
  - 1. may give more flexibility than 2.

Which would you think is better?
I would be happy if you tell me another idea!

Thanks.


===sample===
#include "./kselftest_harness.h"


TEST(argc_test)
{
	int i;
	for (i = 0; i < argc; i++)
		TH_LOG("argv[%d]: %s", i, argv[i]);
}

FIXTURE(argc_f) {
	int data;
};

FIXTURE_SETUP(argc_f) {
	self->data = 92;
	ASSERT_EQ(92, self->data);
}

FIXTURE_TEARDOWN(argc_f) {
}

TEST_F(argc_f, argc_test_f) {
	int i;
	for (i = 0; i < argc; i++)
		TH_LOG("fixture: %d\targv[%d]: %s", self->data, i, argv[i]);
}

TEST_HARNESS_MAIN
============
