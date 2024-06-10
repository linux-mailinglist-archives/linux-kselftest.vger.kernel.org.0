Return-Path: <linux-kselftest+bounces-11540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA2901A4B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 07:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F93281B05
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 05:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2514910A22;
	Mon, 10 Jun 2024 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qCrunUUA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4C1755C;
	Mon, 10 Jun 2024 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998063; cv=none; b=kpJd/HcR0Rwb0tTm9vfBqw5xZomg2csyjiCxdthezozq6sg2Ror+umucEvQQ6CuueZmCNH8gbfB5uvL+ln2xOUf8f5Yyw9jODz5ZLYHRxAGtuz1ZJQFbMpO2Hoh33A8Ya3I6/PZ5S2Fv67hQeQnMxOhiGigQzD8RR+d8it/z+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998063; c=relaxed/simple;
	bh=DcQaDcNXN78UOD3DTHZRmfQSWi58vR/vSZYiDdiNKpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W32Pb/KWkvzQ+JVz9m1aed1CmKw8+fbrz2WRA1POFO8jULheITMV2chqAEkonJ3MwRLIcntSxhcUnmfGxZ8jTYu2Cy/f57IlyqjqV8Ii1RTgodtBcJdXAJEXPO5CE0XpQbQltE7QfIwvFLgwhIQHrFNffNv9A+x1CsTHqNcPoMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qCrunUUA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717998059;
	bh=DcQaDcNXN78UOD3DTHZRmfQSWi58vR/vSZYiDdiNKpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCrunUUA0kPOHFlokcKejxRdqoraW+HpDyjUM9gTLcBycZ9WXrLuF44Ufeugyed4n
	 rPXILKVL2HFAHaGZ5/6LKBKcUKzl0h6IUK0ier2z0MOHm8yevmhF5KMlf91msNN5N+
	 xHwmypRgYRJCLLxdi5jmzELIgonWuu72uvD0kDrnufDK7Yu2Tteg35EqJD/1ubvMzY
	 juM9eHF4vXxQ6PPivB+DIdhsjuIVHGXbIVQ7kn7f5+IYyyJJkwfmle7uHIrj4R9VEQ
	 2JMxpB4kY+u1bg5o0dWwspKRGq4SvqXcW2JGpRRayPVmzGBuu8vIsyFEbG1uDZM0Je
	 eim9s275yG8Gg==
Received: from deb.www.tendawifi.com (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2957E3782159;
	Mon, 10 Jun 2024 05:40:56 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH v2 1/4] kselftests: vdso: vdso_test_clock_getres: conform test to TAP output
Date: Mon, 10 Jun 2024 10:41:26 +0500
Message-Id: <20240610054129.1527389-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610054129.1527389-1-usama.anjum@collabora.com>
References: <20240610054129.1527389-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.
Use kselftest_harness.h to conform to TAP as the number of tests depend
on the available options at build time. The kselftest_harness makes the
test easy to convert and presents better maintainability.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Update commit message to include that kselftest_harness has been used
  to conform to TAP and why
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


