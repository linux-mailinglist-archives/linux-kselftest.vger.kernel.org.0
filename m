Return-Path: <linux-kselftest+bounces-44310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD907C1C700
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 18:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8922C6E47A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6597034FF78;
	Wed, 29 Oct 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tqJA1+zd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06334BA50;
	Wed, 29 Oct 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753894; cv=none; b=jFxjBwjRMUiekzqsx0xhwZkW9gRBiVf4NUzDFbpXyyfJNR+JkHPd116Bw72tFLvcAJBAbGwCHYlhwESLx6bCVtA5XcnBz9v3qGfZ45WD/1Lf6rzhObFldKdvsj4Ppdd3YB3SOeJCRnAPrPH3vtd420pzyIk3xD01wNV8dSECJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753894; c=relaxed/simple;
	bh=uQ4VuDACIC74mOTa+M7TyhSvihH8rx+FoRO7JkSOWzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IcbEz6EWXXRzxSgwaPSkPT3pAxZrXyWC0UcQl532eb98tUgqfIYM4OGspmxLgtRUxVCWMcC4vEhdz322skTO5S04Jqi0YCWrX6Cr1H9G/8828GOCNfsFGa+zdUkDoMuHGspoo7m9h/z2MkxgG2L7TUS8gI0i1X59w6qXNmU/IEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tqJA1+zd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761753883;
	bh=uQ4VuDACIC74mOTa+M7TyhSvihH8rx+FoRO7JkSOWzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tqJA1+zdmnET/tyP0kbhPl6XqZCljrQMaBmqZYKaBE66GLSRuqWkHFEE6QKH6XI3i
	 gNxeuAcpP9pnp262UE+QDcugfjJpN91yfvBLW2l1UWuqAIn0TPrvSu2+QW9h1I+ufn
	 6D2t9e8ut4kri7Av8cFhFGYKARgxj0RAo/X8UfJM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 17:02:56 +0100
Subject: [PATCH 06/12] tools/nolibc: remove more __nolibc_enosys()
 fallbacks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-nolibc-uapi-types-v1-6-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
In-Reply-To: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761753881; l=2817;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uQ4VuDACIC74mOTa+M7TyhSvihH8rx+FoRO7JkSOWzY=;
 b=43abOEqlGvCcTyJLcCO0X0uULXfHvE1PisOLu5UJspT82sJgJj+JrxJjXwGU8Mtc1IBx6FCjs
 yF2o7FgPPhfCFAkCVB9B2BBSkeAiNOmDdSGF0qF1y+EGb4exxql0NPB
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Commit e6366101ce1f ("tools/nolibc: remove __nolibc_enosys() fallback
from time64-related functions") removed many of these fallbacks but
forgot a few.

Finish the job.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/time.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index 6c276b8d646a..48e78f8becf9 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -89,13 +89,11 @@ int sys_clock_settime(clockid_t clockid, struct timespec *tp)
 {
 #if defined(__NR_clock_settime)
 	return my_syscall2(__NR_clock_settime, clockid, tp);
-#elif defined(__NR_clock_settime64)
+#else
 	struct __kernel_timespec ktp;
 
 	__nolibc_timespec_user_to_kernel(tp, &ktp);
 	return my_syscall2(__NR_clock_settime64, clockid, &ktp);
-#else
-	return __nolibc_enosys(__func__, clockid, tp);
 #endif
 }
 
@@ -111,7 +109,7 @@ int sys_clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqt
 {
 #if defined(__NR_clock_nanosleep)
 	return my_syscall4(__NR_clock_nanosleep, clockid, flags, rqtp, rmtp);
-#elif defined(__NR_clock_nanosleep_time64)
+#else
 	struct __kernel_timespec krqtp, krmtp;
 	int ret;
 
@@ -120,8 +118,6 @@ int sys_clock_nanosleep(clockid_t clockid, int flags, const struct timespec *rqt
 	if (rmtp)
 		__nolibc_timespec_kernel_to_user(&krmtp, rmtp);
 	return ret;
-#else
-	return __nolibc_enosys(__func__, clockid, flags, rqtp, rmtp);
 #endif
 }
 
@@ -195,7 +191,7 @@ int sys_timer_gettime(timer_t timerid, struct itimerspec *curr_value)
 {
 #if defined(__NR_timer_gettime)
 	return my_syscall2(__NR_timer_gettime, timerid, curr_value);
-#elif defined(__NR_timer_gettime64)
+#else
 	struct __kernel_itimerspec kcurr_value;
 	int ret;
 
@@ -203,8 +199,6 @@ int sys_timer_gettime(timer_t timerid, struct itimerspec *curr_value)
 	__nolibc_timespec_kernel_to_user(&kcurr_value.it_interval, &curr_value->it_interval);
 	__nolibc_timespec_kernel_to_user(&kcurr_value.it_value, &curr_value->it_value);
 	return ret;
-#else
-	return __nolibc_enosys(__func__, timerid, curr_value);
 #endif
 }
 
@@ -220,7 +214,7 @@ int sys_timer_settime(timer_t timerid, int flags,
 {
 #if defined(__NR_timer_settime)
 	return my_syscall4(__NR_timer_settime, timerid, flags, new_value, old_value);
-#elif defined(__NR_timer_settime64)
+#else
 	struct __kernel_itimerspec knew_value, kold_value;
 	int ret;
 
@@ -232,8 +226,6 @@ int sys_timer_settime(timer_t timerid, int flags,
 		__nolibc_timespec_kernel_to_user(&kold_value.it_value, &old_value->it_value);
 	}
 	return ret;
-#else
-	return __nolibc_enosys(__func__, timerid, flags, new_value, old_value);
 #endif
 }
 

-- 
2.51.1.dirty


