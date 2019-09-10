Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6ABAF0D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2019 20:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfIJSCc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 14:02:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfIJSCc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 14:02:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9462A7FDF6;
        Tue, 10 Sep 2019 18:02:32 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-20.ams2.redhat.com [10.36.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E7746017E;
        Tue, 10 Sep 2019 18:02:28 +0000 (UTC)
Date:   Tue, 10 Sep 2019 19:02:02 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Adrian Reber <areber@redhat.com>
Subject: [PATCH v2 4/6] selftests/clone3: fix up format strings
Message-ID: <33af2258349329295860896fd7caf4d10ffaa827.1568138394.git.esyr@redhat.com>
References: <cover.1568138393.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568138393.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 10 Sep 2019 18:02:32 +0000 (UTC)
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
index 613544b..eb705f6 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -124,11 +124,11 @@ static int test_clone3(uint64_t flags, size_t size, int expected,
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

