Return-Path: <linux-kselftest+bounces-7206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBCF898BE8
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 18:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51890B21865
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE212CD9C;
	Thu,  4 Apr 2024 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ge1bY6gJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97212C7FA;
	Thu,  4 Apr 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247256; cv=none; b=nXk4p42TD17j8KEbQCbycve4zGGFSpVxGv2sOH6dArmpGoZqdzDK5fp69mKLaruXB2Ui7fa3DuoVSId/m7ThU1ZHlU6/Zq+Rt7E+V5kRI46jkL06J3GunF6cL+Nm+oVeEENgUMvZoedzdkBTHFVdbwDVbvzrTzOADLmQ8uHOgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247256; c=relaxed/simple;
	bh=boDL5nHOi6Lw/iE+qqB7X+GYBlXdpClEfHq4s6TIuWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEo9Q+i8qYxO7XPKHYk1Quw9+68PxhovUFh53/19f3DY10qJ8tQDM8CFSmJbxxFBC2SWjc29Je8CIBVWDsXPdzjkOuSQJZLF8Bj29nkFknjxnT0wD3h4iBwfVEOFywPOs/LzjedogivsqGNnuqkb34xaSi4eVZJMUmnjIysDUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ge1bY6gJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712247253;
	bh=boDL5nHOi6Lw/iE+qqB7X+GYBlXdpClEfHq4s6TIuWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ge1bY6gJXP/VQg+cVNTG6HkpGguexAj/rR7+IrElRFFuC6JIWVk2BTA+MEQ/wtY8V
	 qtyRZ8S2iIl+4J/4u4qMxUWf2k3VRpdg6ktbBjv3mBfE0p0Ynzlf4Wsw4OhHI7bDIW
	 D4SvB2DcTayeOHd9wgGb13zqts5ZlfpBArMT6h72PANYY9Uigq2GeTA5eaJcAQ2URx
	 9u68VpEuWE4sbNOCOOo3ZzOZRIn7FyPZ1gWMeg0Ldd5XHiu2HzV0gq0XffLOirrdDk
	 NuBVPhqxowuMVTRZ+YfFiXoWFsyMQHmBKAsHWhwKic+f6mFBgYehR/Ht7THAxSPg+D
	 GEv+GZ8oU8NEA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 50B4F3782129;
	Thu,  4 Apr 2024 16:14:08 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 1/2] selftests: add ksft_exit_fail_perror()
Date: Thu,  4 Apr 2024 21:14:32 +0500
Message-Id: <20240404161433.114497-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404161433.114497-1-usama.anjum@collabora.com>
References: <20240404161433.114497-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a version of ksft_exit_fail_msg() which prints the errno and its
string form with ease. There is no benefit of exit message without
errno. Whenever some error occurs, instead of printing errno manually,
this function would be very helpful. In the next TAP ports or new tests,
this function will be used instead of ksft_exit_fail_msg() as it prints
errno.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kselftest.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 159bf8e314fa3..2cd93d220f434 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -41,6 +41,7 @@
  * the program is aborting before finishing all tests):
  *
  *    ksft_exit_fail_msg(fmt, ...);
+ *    ksft_exit_fail_perror(msg);
  *
  */
 #ifndef __KSELFTEST_H
@@ -370,6 +371,19 @@ static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 	exit(KSFT_FAIL);
 }
 
+static inline void ksft_exit_fail_perror(const char *msg)
+{
+#ifndef NOLIBC
+	ksft_exit_fail_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
+#else
+	/*
+	 * nolibc doesn't provide strerror() and it seems
+	 * inappropriate to add one, just print the errno.
+	 */
+	ksft_exit_fail_msg("%s: %d)\n", msg, errno);
+#endif
+}
+
 static inline int ksft_exit_xfail(void)
 {
 	ksft_print_cnts();
-- 
2.39.2


