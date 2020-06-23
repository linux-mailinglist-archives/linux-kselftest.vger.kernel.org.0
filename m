Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573CA204516
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 02:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgFWAP4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 20:15:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731512AbgFWAPz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 20:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592871353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qgBvDcdooZK3cvfCeVH38SXW8qfkg0wa/Chs7ICVeU=;
        b=M9eOQ+brEw/DgXsL5rdwJ8IZcRD6JufPjpikGnmk/oe3XHFqgjGvorCcycPna2HgysbU7z
        iBPKVN1loaHaRhg3RD0MwrP5Q/pY73SOUlN7k7pvgaHBBkFb9IzP2V35G2a4XB5OOOdm4q
        YaldXP2Wj41brCKqDucCef96FQruis8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-aUMp7raEN9S2xszyh1TTrA-1; Mon, 22 Jun 2020 20:15:50 -0400
X-MC-Unique: aUMp7raEN9S2xszyh1TTrA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26B7CEC1A0;
        Tue, 23 Jun 2020 00:15:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC34560BEC;
        Tue, 23 Jun 2020 00:15:48 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/6] kselftest: fix TAP output for skipped tests
Date:   Mon, 22 Jun 2020 20:15:42 -0400
Message-Id: <20200623001547.22255-2-pbonzini@redhat.com>
In-Reply-To: <20200623001547.22255-1-pbonzini@redhat.com>
References: <20200623001547.22255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

According to the TAP specification, a skipped test must be marked as "ok"
and annotated with the SKIP directive, for example

   ok 23 # skip Insufficient flogiston pressure.
   (https://testanything.org/tap-specification.html)

Fix the kselftest infrastructure to match this.

For ksft_exit_skip, it is preferrable to emit a dummy plan line that
indicates the whole test was skipped, but this is not always possible
because of ksft_exit_skip being used as a "shortcut" by the tests.
In that case, print the test counts and a normal "ok" line.  The format
is now the same independent of whether msg is NULL or not (but it is
never NULL in any caller right now).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kselftest.h         | 28 +++++++++++++++------
 tools/testing/selftests/kselftest/runner.sh |  2 +-
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 862eee734553..1b0075359734 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -128,7 +128,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 	ksft_cnt.ksft_xskip++;
 
 	va_start(args, msg);
-	printf("not ok %d # SKIP ", ksft_test_num());
+	printf("ok %d # SKIP ", ksft_test_num());
 	errno = saved_errno;
 	vprintf(msg, args);
 	va_end(args);
@@ -190,18 +190,30 @@ static inline int ksft_exit_xpass(void)
 
 static inline int ksft_exit_skip(const char *msg, ...)
 {
-	if (msg) {
-		int saved_errno = errno;
-		va_list args;
+	int saved_errno = errno;
+	va_list args;
 
-		va_start(args, msg);
-		printf("not ok %d # SKIP ", 1 + ksft_test_num());
+	va_start(args, msg);
+
+	/*
+	 * FIXME: several tests misuse ksft_exit_skip so produce
+	 * something sensible if some tests have already been run
+	 * or a plan has been printed.  Those tests should use
+	 * ksft_test_result_skip or ksft_exit_fail_msg instead.
+	 */
+	if (ksft_plan || ksft_test_num()) {
+		ksft_cnt.ksft_xskip++;
+		printf("ok %d # SKIP ", 1 + ksft_test_num());
+	} else {
+		printf("1..0 # SKIP ");
+	}
+	if (msg) {
 		errno = saved_errno;
 		vprintf(msg, args);
 		va_end(args);
-	} else {
-		ksft_print_cnts();
 	}
+	if (ksft_test_num())
+		ksft_print_cnts();
 	exit(KSFT_SKIP);
 }
 
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 676b3a8b114d..f4815cbcd60f 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -77,7 +77,7 @@ run_one()
 		echo "ok $test_num $TEST_HDR_MSG") ||
 		(rc=$?;	\
 		if [ $rc -eq $skip_rc ]; then	\
-			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
+			echo "ok $test_num $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
 			echo "#"
 			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
-- 
2.26.2


