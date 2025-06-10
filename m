Return-Path: <linux-kselftest+bounces-34559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1278FAD3743
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BB0163090
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A3C29C347;
	Tue, 10 Jun 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRkuzvM1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320DE29C340;
	Tue, 10 Jun 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559354; cv=none; b=oqOVuk9NklePhcY9IiRiGIv4I7S34712OOZvHotJaZLtbIHwgBmOR037d4HLiJTkFDzQ9ZiwDYHqGYnXMF7EmwZ3M9pgzgxXLUgpsuEppCuarwFoPIJvXtMt3lKsjj4wVn4OkJNKVKRkUWjj5l5g7hSyakDfNbR9O8DizCOv2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559354; c=relaxed/simple;
	bh=J6AFLpxqvQUWE4ch4VBYYdyyIA1JHulBUl77i0XMQXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sm7J83djf9VcOmm6GqE/zpOnYCsaVHJ09JRQpgi3C2yPm48omoEBP9JwY24QqHOi5UkPGG2cfrzHKCSjFRWBusXY9xbw/rY452jEKQd+Wjr3sRxzr1045wBYtPyhzWCvBw7WfNJEjS4OdLVnEnjnmn1CPto4LgQUh+8QLpi+888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRkuzvM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCB9C4CEED;
	Tue, 10 Jun 2025 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559354;
	bh=J6AFLpxqvQUWE4ch4VBYYdyyIA1JHulBUl77i0XMQXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NRkuzvM1VuWrjni1jIHamlCP5Bf1frhkd/OQ6upItw68wDuIDQ1w3JYAKfbPY1Sel
	 H5fw+qaJ6BDT3n2lXXAAxygtCxT6mJBewqs0LfJhbg0liyACN1ArVO1sqhIUoP4srk
	 Sr9bAd64TUSiT441BkLsLPAQbKzvz8GVl8ATS2d9ZiV0PVC6bX4ddtl8GQ7/OIwuNL
	 VJdq0ggAuB9KpbiTPog1ER1NI4nHonjdr2vkoViqzSWM2f0qzyRE2fOJRwGWGtlCip
	 nNuxSAZZ1A5LNrfl9qVcDSlHNWjc4ax4O2s2vdzysJDPhGZanrVgCL2x49ZOre1E6z
	 K5uRdO1yCKOfA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Jun 2025 13:29:45 +0100
Subject: [PATCH v2 2/4] tools/nolibc: Provide vfork()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-arm64-gcs-vfork-exit-v2-2-929443dfcf82@kernel.org>
References: <20250610-arm64-gcs-vfork-exit-v2-0-929443dfcf82@kernel.org>
In-Reply-To: <20250610-arm64-gcs-vfork-exit-v2-0-929443dfcf82@kernel.org>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=broonie@kernel.org;
 h=from:subject:message-id; bh=J6AFLpxqvQUWE4ch4VBYYdyyIA1JHulBUl77i0XMQXw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoSCgvukmbaMjh17UgVr99O7M6G30oiXXdn4BKoDV/
 rkfEdzyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEgoLwAKCRAk1otyXVSH0KMuB/
 4wSoNjdhT70WakS3tv5X9iBatU6hPJ1jqe4SqsQejll0GFhY4EP6j92MKruox3yVgGp1es9BfWiK7k
 pHdfUp4iCpcVTo1xaJBB1kS47mnEoMvOYLFccmH9Ka8i+j2G+FpSqtaD/xhQL34NNbtCk84Js59oAY
 cF6v4jl1b6CYWsDFpwxBYvZ3Mv4rVE9ZOfGch/2tA/dnmeIopWbEBZeBciROMX312SXGh0+3A1CCsU
 2unwKDDBDqYbC62Cj+arSFXSG9p4cN3HD596UwoRvcOk8ocu/PHCgN3/5trKu3VQfR5t8IigKQc6up
 RP53ygLYtS+Kxmxi1rrN9y5tMeVTap
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

To allow testing of vfork() support in the arm64 basic-gcs test provide an
implementation for nolibc, using the vfork() syscall if one is available
and otherwise clone3(). We implement in terms of clone3() since the order
of the arguments for clone() varies between architectures.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/include/nolibc/sys.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index aabac97a7fb0..5932ae8828a1 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -22,6 +22,7 @@
 #include <linux/time.h>
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> /* for O_* and AT_* */
+#include <linux/sched.h> /* for clone_args */
 #include <linux/stat.h>  /* for statx() */
 
 #include "errno.h"
@@ -340,6 +341,32 @@ pid_t fork(void)
 	return __sysret(sys_fork());
 }
 
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


