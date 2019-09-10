Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE331AE9E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2019 14:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfIJMEF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 08:04:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbfIJMEF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 08:04:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BE7C89C38;
        Tue, 10 Sep 2019 12:04:05 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-63.ams2.redhat.com [10.36.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 768C15D9D6;
        Tue, 10 Sep 2019 12:04:00 +0000 (UTC)
Date:   Tue, 10 Sep 2019 13:03:34 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>
Subject: [PATCH 4/6] selftests/clone3: fix up format strings
Message-ID: <fc4ff67f28c6a6b83afecb6a6e22d632e23b82f2.1568116761.git.esyr@redhat.com>
References: <cover.1568116761.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568116761.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 10 Sep 2019 12:04:05 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* tools/testing/selftests/clone3/clone3.c (test_clone3): Change format
qualifier for printing size field from %d to %zu; place colon right
after the word "says".

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/clone3/clone3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 1746a9b..7b8d927 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -109,11 +109,11 @@ static int test_clone3(uint64_t flags, size_t size, int expected,
 {
 	int ret;
 
-	ksft_print_msg("[%d] Trying clone3() with flags %#" PRIx64 " (size %d)"
+	ksft_print_msg("[%d] Trying clone3() with flags %#" PRIx64 " (size %zu)"
 			"\n",
 			getpid(), flags, size);
 	ret = call_clone3(flags, size, test_mode);
-	ksft_print_msg("[%d] clone3() with flags says :%d expected %d\n",
+	ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
 			getpid(), ret, expected);
 	if (ret != expected)
 		ksft_exit_fail_msg(
-- 
2.1.4

