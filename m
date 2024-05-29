Return-Path: <linux-kselftest+bounces-10822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0828D2E13
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 09:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4274F1C23DED
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 07:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124FC167264;
	Wed, 29 May 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BEgUJJQO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE116729A;
	Wed, 29 May 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967559; cv=none; b=r2mGddqD109xXA+uvsBdVNSLZ5dc5rIeCDM8vqWtDnxiNakEG59mVzSiRt3UWT+P+f9PgFZcmkPhkCpkYbDIVV/Y+VWnt34br92s98Zxo0qCoifH3Xn4+6UhL0uGznj4epfbTZLY0//PeHe3txWhGU3TgNM7KEHO1AO6I73larY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967559; c=relaxed/simple;
	bh=Vw18zT8fK+zC+4bVifRZS0YUxoq9gpaiVYxnOu+WInc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ugglxAEgFZE33JgZVxF6rthiHTSf8YY6C8PWahbiXLG6c/tjKRPzooXCerQk74JnHZxuG/jAkW9LypCylY2pTABvkTdgQuS0M+jDHtbYabKwSTp4KNOITAtZGz/iOQ3oBc8pLVTPk3nxUmn5pvBC5bv+jhdq3rvZLCo95ta+2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BEgUJJQO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716967555;
	bh=Vw18zT8fK+zC+4bVifRZS0YUxoq9gpaiVYxnOu+WInc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEgUJJQOXNXVI8Is5f9/TdSu3v6yWkmXyHKBcPe+iSN1iw/UIESCMCtW6vKMxjDnt
	 0t/KcxYACJ+JyWf2r/T4krrsfU50HnmmlDRWzXD+NkzdW6+c3PLyZqLxN9Up2Ve5Ed
	 PY/pMypexQ000D3xhPpKYtJQXpQMFktWrn6sMbX/KzMh6N1stJmDETUwA3Q56dw6M9
	 yzwfuxIwtnGyNw93B4h8yDUjWYTtg6D7mWX9KnPa3hFT6CCOrevS+mnHiJrz7I/6AB
	 lRzb3cPEXIji1+7wYthMyHZk76u2E8SDFpRNv0iLvF09r21t1XgS5r9Lovxo6dJZ7Z
	 SCGkuxGmtLdVA==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 862923782162;
	Wed, 29 May 2024 07:25:50 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 1/4] kselftests: vdso: vdso_test_clock_getres: conform test to TAP output
Date: Wed, 29 May 2024 12:24:51 +0500
Message-Id: <20240529072454.2522495-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529072454.2522495-1-usama.anjum@collabora.com>
References: <20240529072454.2522495-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../selftests/vDSO/vdso_test_clock_getres.c   | 68 +++++++++----------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
index 38d46a8bf7cba..c1ede40521f05 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -25,7 +25,7 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 
-#include "../kselftest.h"
+#include "../kselftest_harness.h"
 
 static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
 {
@@ -54,18 +54,8 @@ const char *vdso_clock_name[12] = {
 /*
  * This function calls clock_getres in vdso and by system call
  * with different values for clock_id.
- *
- * Example of output:
- *
- * clock_id: CLOCK_REALTIME [PASS]
- * clock_id: CLOCK_BOOTTIME [PASS]
- * clock_id: CLOCK_TAI [PASS]
- * clock_id: CLOCK_REALTIME_COARSE [PASS]
- * clock_id: CLOCK_MONOTONIC [PASS]
- * clock_id: CLOCK_MONOTONIC_RAW [PASS]
- * clock_id: CLOCK_MONOTONIC_COARSE [PASS]
  */
-static inline int vdso_test_clock(unsigned int clock_id)
+static inline void vdso_test_clock(struct __test_metadata *_metadata, unsigned int clock_id)
 {
 	struct timespec x, y;
 
@@ -73,52 +63,60 @@ static inline int vdso_test_clock(unsigned int clock_id)
 	clock_getres(clock_id, &x);
 	syscall_clock_getres(clock_id, &y);
 
-	if ((x.tv_sec != y.tv_sec) || (x.tv_nsec != y.tv_nsec)) {
-		printf(" [FAIL]\n");
-		return KSFT_FAIL;
-	}
-
-	printf(" [PASS]\n");
-	return KSFT_PASS;
+	ASSERT_EQ(0, ((x.tv_sec != y.tv_sec) || (x.tv_nsec != y.tv_nsec)));
 }
 
-int main(int argc, char **argv)
-{
-	int ret = 0;
-
 #if _POSIX_TIMERS > 0
 
 #ifdef CLOCK_REALTIME
-	ret += vdso_test_clock(CLOCK_REALTIME);
+TEST(clock_realtime)
+{
+	vdso_test_clock(_metadata, CLOCK_REALTIME);
+}
 #endif
 
 #ifdef CLOCK_BOOTTIME
-	ret += vdso_test_clock(CLOCK_BOOTTIME);
+TEST(clock_boottime)
+{
+	vdso_test_clock(_metadata, CLOCK_BOOTTIME);
+}
 #endif
 
 #ifdef CLOCK_TAI
-	ret += vdso_test_clock(CLOCK_TAI);
+TEST(clock_tai)
+{
+	vdso_test_clock(_metadata, CLOCK_TAI);
+}
 #endif
 
 #ifdef CLOCK_REALTIME_COARSE
-	ret += vdso_test_clock(CLOCK_REALTIME_COARSE);
+TEST(clock_realtime_coarse)
+{
+	vdso_test_clock(_metadata, CLOCK_REALTIME_COARSE);
+}
 #endif
 
 #ifdef CLOCK_MONOTONIC
-	ret += vdso_test_clock(CLOCK_MONOTONIC);
+TEST(clock_monotonic)
+{
+	vdso_test_clock(_metadata, CLOCK_MONOTONIC);
+}
 #endif
 
 #ifdef CLOCK_MONOTONIC_RAW
-	ret += vdso_test_clock(CLOCK_MONOTONIC_RAW);
+TEST(clock_monotonic_raw)
+{
+	vdso_test_clock(_metadata, CLOCK_MONOTONIC_RAW);
+}
 #endif
 
 #ifdef CLOCK_MONOTONIC_COARSE
-	ret += vdso_test_clock(CLOCK_MONOTONIC_COARSE);
+TEST(clock_monotonic_coarse)
+{
+	vdso_test_clock(_metadata, CLOCK_MONOTONIC_COARSE);
+}
 #endif
 
-#endif
-	if (ret > 0)
-		return KSFT_FAIL;
+#endif /* _POSIX_TIMERS > 0 */
 
-	return KSFT_PASS;
-}
+TEST_HARNESS_MAIN
-- 
2.39.2


