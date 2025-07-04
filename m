Return-Path: <linux-kselftest+bounces-36578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35715AF9548
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 16:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBE454303D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ACB18DB37;
	Fri,  4 Jul 2025 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j9+hoyxu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZtn3R83"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8D43AA9;
	Fri,  4 Jul 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638797; cv=none; b=g+69fk6lo7YUWmQhFlotYuoLaZqNIRHeiw1wPl9bO8MryBh8eOaqI9M3RNPh4hlcjaduWfsls9+5BcagMY6bKFW9698LJzW2QQR8PlPW06GM/ztQzBe8B8QHsJ9+rvBlQgd31QVT6aco7ClKgqzsuoowGjjKu5z1jdcjO89NmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638797; c=relaxed/simple;
	bh=l7W6ZxQ4jKQo69pkYn+br4lSJr8H67loghEexq0jha8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VFjtV4r4W74N5z6tJNVk8OIueDXtZ5U/9+eYHmbUkSphSWCQ3yJLduh/XDDszM3udq1E19mDBV7XppcG9RRzEVh6CsQlfLr6IvOwy/WHK+/EwRmX6/T8O/aPGdDXN6VlERjNmXgrCFqkPlKymMDSGx4nHSp/j/KZrt5hkhDdyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j9+hoyxu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NZtn3R83; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751638793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hcqlyRHzFS9/EhHIhTt/9QEidEGBoMUNXPAiM3doLfU=;
	b=j9+hoyxuFGCBLZ2XQX7Ykt2gaTDPQYGzVdX4IkH73SHRXlH3Izkj9+tSkMD5/FamzlxRBv
	TtNb1+kSoIW1lVpVIjCENYPiJoKWWBBMx+/EFbJ/G6ztBaziBeqzYSX3mpNIOsZrl0sIhQ
	tqZq+iQb3o3FgaB82cP2PQs9B2NKbSS4qslpCXErWw+CTjHok8cANgexVXwVSHuqpF31cV
	ESK+XFsy17T7tNvl95qIrH6aUPAXiPELlrCd2FJ3qdMeckje7LJWmvGAC5/3ekw7cASyt7
	1bDDK0H9tzzWMGr+xzDPc2sSnwFdaUIpzR5h1TEp5ZzkGZqK39MWCvKUjKiP+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751638793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hcqlyRHzFS9/EhHIhTt/9QEidEGBoMUNXPAiM3doLfU=;
	b=NZtn3R83fPMWqdWFNGAez3Q2DFxe8dk3aSJgMAtKss5XnbQ+uvJ3IYU2peSe78vs1O9hUu
	kMnB1TdyA4nnjzCg==
Date: Fri, 04 Jul 2025 16:19:48 +0200
Subject: [PATCH] tools/nolibc: add support for clock_nanosleep() and
 nanosleep()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-nolibc-nanosleep-v1-1-d79c19701952@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAPjZ2gC/x3MQQqAIBBA0avErBMm0YyuEi2yphqQMRQikO6et
 HyL/wtkSkwZxqZAopszR6no2gbWc5GDFG/VoFFbdGiUxMB+VbJIzIHoUtq43g/Ye9ws1OxKtPP
 zL6f5fT+emRmqYgAAAA==
X-Change-ID: 20250704-nolibc-nanosleep-2476b806b0d5
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751638791; l=3678;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=l7W6ZxQ4jKQo69pkYn+br4lSJr8H67loghEexq0jha8=;
 b=Ce9K79g7ypAu00HrEoK1fBjlzB6qcJlI1U/88HqUiSERlhDbAsrrdwUiuXfhYZ7gjPa7VPtFe
 Hv0pXRFsJQZCOtQ80PDTdrJfMnPaJ86kYckm6Yv21BKoZj6RMdmjS9b
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Also add some tests.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/time.h                  | 34 ++++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  1 +
 2 files changed, 35 insertions(+)

diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index fc387940d51f389d4233bd5712588dced31ae6e5..d02bc44d2643a5e39afa808841f7175bfab5ff7e 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -36,6 +36,8 @@ void __nolibc_timespec_kernel_to_user(const struct __kernel_timespec *kts, struc
  * int clock_getres(clockid_t clockid, struct timespec *res);
  * int clock_gettime(clockid_t clockid, struct timespec *tp);
  * int clock_settime(clockid_t clockid, const struct timespec *tp);
+ * int clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqtp,
+ *                     struct timespec *rmtp)
  */
 
 static __attribute__((unused))
@@ -107,6 +109,32 @@ int clock_settime(clockid_t clockid, struct timespec *tp)
 	return __sysret(sys_clock_settime(clockid, tp));
 }
 
+static __attribute__((unused))
+int sys_clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqtp,
+			struct timespec *rmtp)
+{
+#if defined(__NR_clock_nanosleep)
+	return my_syscall4(__NR_clock_nanosleep, clockid, flags, rqtp, rmtp);
+#elif defined(__NR_clock_nanosleep_time64)
+	struct __kernel_timespec krqtp, krmtp;
+	int ret;
+
+	__nolibc_timespec_user_to_kernel(rqtp, &krqtp);
+	ret = my_syscall4(__NR_clock_nanosleep_time64, clockid, flags, &krqtp, &krmtp);
+	if (rmtp)
+		__nolibc_timespec_kernel_to_user(&krmtp, rmtp);
+	return ret;
+#else
+	return __nolibc_enosys(__func__, clockid, flags, rqtp, rmtp);
+#endif
+}
+
+static __attribute__((unused))
+int clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqtp,
+		    struct timespec *rmtp)
+{
+	return __sysret(sys_clock_nanosleep(clockid, flags, rqtp, rmtp));
+}
 
 static __inline__
 double difftime(time_t time1, time_t time2)
@@ -114,6 +142,12 @@ double difftime(time_t time1, time_t time2)
 	return time1 - time2;
 }
 
+static __inline__
+int nanosleep(const struct timespec *rqtp, struct timespec *rmtp)
+{
+	return clock_nanosleep(CLOCK_REALTIME, 0, rqtp, rmtp);
+}
+
 
 static __attribute__((unused))
 time_t time(time_t *tptr)
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b5bca1dcf36e95a576ca9ffba4f7c213978a3f35..315229233930265501296dfeb9bc2838bb6fef84 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1363,6 +1363,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(mmap_bad);          EXPECT_PTRER(1, mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL); break;
 		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap(NULL, 0), -1, EINVAL); break;
 		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
+		CASE_TEST(nanosleep);         ts.tv_nsec = -1; EXPECT_SYSER(1, nanosleep(&ts, NULL), -1, EINVAL); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", O_RDONLY), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", O_RDONLY), -1, ENOENT); if (tmp != -1) close(tmp); break;
 		CASE_TEST(openat_dir);        EXPECT_SYSZR(1, test_openat()); break;

---
base-commit: 1536aa0fb1e09cb50f401ec4852c60f38173d751
change-id: 20250704-nolibc-nanosleep-2476b806b0d5

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


