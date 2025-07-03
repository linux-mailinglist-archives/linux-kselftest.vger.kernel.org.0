Return-Path: <linux-kselftest+bounces-36465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F00A0AF7D8D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D17F1C87B4A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4ED2EFDB8;
	Thu,  3 Jul 2025 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZvLlvK4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418AE2EFDB5;
	Thu,  3 Jul 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558773; cv=none; b=UWmqGTGb7F5s7NscjKmH+ogNpOugWOzQ4aLNXOVj2n4YSa5kxxQV5JqW8zzrVI/+yjMKU1B4nMrzZMGZi4joaQi+ouTjms98oVK9cQiPZz38qGp4OQoNx16WBrG2uXiS5D9NWZ3V6tv9+WGEj0RJ0D4Pke31o4oQcpw3bwOLRak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558773; c=relaxed/simple;
	bh=GxdG/hxlVXdujOXju8isvSn0cSnu8pfZPpii65s9OeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+RNkkg0Wxy9vu7NriIrDWPEOBmnqUU+RWoYvASLRyMjdsGToCw6eqwnuXnAgFFKDQ5SnBZ6IsISYw2xC7y1NxO3Iq+9aYWeL/JcPdGS6Yi322vu9L8I+tawMO/ajihgtN7Ro+4mdl2u0NEthbzvqhz9juUF7uqBgg+ETHl2kFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZvLlvK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2497C4CEEE;
	Thu,  3 Jul 2025 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751558772;
	bh=GxdG/hxlVXdujOXju8isvSn0cSnu8pfZPpii65s9OeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jZvLlvK4KtyF36UH0E1bZawCzUi8Kid1J3IPwZe3EV78RaxMJzahhqUyj+oUYffuL
	 YZQ1j/8GwbbDkc9kvjggLLsgteMKKbsAm0TAF8fa5H7UIWoaFFaZx7Xv7Nq69dYpp4
	 dWlS1ernWtbW8HigeLXYBKNTf8EccSbH+VO27hD2zm3k5lBe1ojTmYikmd1IDRirbO
	 saKBlkqRZfeMHpewSLxTKu3CrRzZaawr+lRPXyUSQVP7sj2ydkkGJZz23lv2TAPzF3
	 vjlKAEq5ohnsUcfXgos2/PqZPJvpY/FexOGY0yCx0BWwm8a+kBbTkNiquQZgtVYJEk
	 LSjFpNEJiXZUQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 03 Jul 2025 17:00:16 +0100
Subject: [PATCH v3 2/4] tools/nolibc: Provide vfork()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-arm64-gcs-vfork-exit-v3-2-1e9a9d2ddbbe@kernel.org>
References: <20250703-arm64-gcs-vfork-exit-v3-0-1e9a9d2ddbbe@kernel.org>
In-Reply-To: <20250703-arm64-gcs-vfork-exit-v3-0-1e9a9d2ddbbe@kernel.org>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GxdG/hxlVXdujOXju8isvSn0cSnu8pfZPpii65s9OeY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoZqpolC4QV+kVaH7lmRS7MVzRQG/lpBJvGQc3J
 i7h+RBSX8+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaGaqaAAKCRAk1otyXVSH
 0FrpB/9I3DAFv0+6RCslFfJA0deSaq6YBHh3AdbS42ZTfrykVfsGWq8ZpCb4ADUlEo8SDuYh0QV
 VWBJm88L7lT+dM/UD+uzXJ7WOZ15vGoYwe45Nb4MkJehqBNiau+VsCzZC43GKA48hmIRSfzGAmP
 wp4sYbvL7FQJcOm3pxsU+lQOto3b76hL0g4erR3nuyKsGcLu1lpIFuRUxO//RhMakGGCwGPq4bi
 4zg0LaTrDM8U46xqkIZdqy+IxfIVBqTAFetz7mjfwRzU41h1KWxAHPlKbG55nenb/BhBwiRbbPe
 KR14YnK3PQxkuokqahgRZpfvj4+iQxh8OLCnFtNjYK0aKixZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

To allow testing of vfork() support in the arm64 basic-gcs test provide an
implementation for nolibc, using the vfork() syscall if one is available
and otherwise clone3(). We implement in terms of clone3() since the order
of the arguments for clone() varies between architectures.

As for fork() SPARC returns the parent PID rather than 0 in the child
for vfork() so needs custom handling.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/include/nolibc/arch-sparc.h | 16 ++++++++++++++++
 tools/include/nolibc/sys.h        | 29 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/include/nolibc/arch-sparc.h b/tools/include/nolibc/arch-sparc.h
index 1435172f3dfe..ca420d843e25 100644
--- a/tools/include/nolibc/arch-sparc.h
+++ b/tools/include/nolibc/arch-sparc.h
@@ -188,4 +188,20 @@ pid_t sys_fork(void)
 }
 #define sys_fork sys_fork
 
+static __attribute__((unused))
+pid_t sys_vfork(void)
+{
+	pid_t parent, ret;
+
+	parent = getpid();
+	ret = my_syscall0(__NR_vfork);
+
+	/* The syscall returns the parent pid in the child instead of 0 */
+	if (ret == parent)
+		return 0;
+	else
+		return ret;
+}
+#define sys_vfork sys_vfork
+
 #endif /* _NOLIBC_ARCH_SPARC_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index aabac97a7fb0..295e71d34aba 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -22,6 +22,7 @@
 #include <linux/time.h>
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> /* for O_* and AT_* */
+#include <linux/sched.h> /* for clone_args */
 #include <linux/stat.h>  /* for statx() */
 
 #include "errno.h"
@@ -340,6 +341,34 @@ pid_t fork(void)
 	return __sysret(sys_fork());
 }
 
+#ifndef sys_vfork
+static __attribute__((unused))
+pid_t sys_vfork(void)
+{
+#if defined(__NR_vfork)
+	return my_syscall0(__NR_vfork);
+#elif defined(__NR_clone3)
+	/*
+	 * clone() could be used but has different argument orders per
+	 * architecture.
+	 */
+	struct clone_args args = {
+		.flags		= CLONE_VM | CLONE_VFORK,
+		.exit_signal	= SIGCHLD,
+	};
+
+	return my_syscall2(__NR_clone3, &args, sizeof(args));
+#else
+	return __nolibc_enosys(__func__);
+#endif
+}
+#endif
+
+static __attribute__((unused))
+pid_t vfork(void)
+{
+	return __sysret(sys_vfork());
+}
 
 /*
  * int fsync(int fd);

-- 
2.39.5


