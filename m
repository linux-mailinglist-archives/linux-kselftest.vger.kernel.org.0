Return-Path: <linux-kselftest+bounces-34479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D07AD2210
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B691885632
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96061DF97D;
	Mon,  9 Jun 2025 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEEGMSxc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D86194094;
	Mon,  9 Jun 2025 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481758; cv=none; b=Hidfat9l0OjJl+8lkTwRjtK6NbLGuWGmlWJ2par9EmcAHfIBSuGUlsS7iCs90IsPO1/NwscvU8bTrYWSfac6V7hRf4Dpdh/8/qoUJChb/DPfbtzj+bnIPSegoOkiSvCZwNufkf2qmTNb3YgcRQMtX7D4bmpujiP8fF7fN6WHwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481758; c=relaxed/simple;
	bh=TY+j0nASxQk+1sb6wh0CAFNql3zjYmvVHlihYQ3nANk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=owXAyjYtjUy1ZDU86HYQXvoXrmxthWXJf7mdn/G1o5Tqkx5NwLli8JYNzzq35RRZqnN2r1J13TaPGImbuwQdgShR+v+y2NPIUYA9/KoPDmU2LXD1JwzIFjm/MPJwQlnsjVwZghNFwzVPlT0fZup6nxiRmkzN5FPhzBjgj/0y6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEEGMSxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210EBC4CEF2;
	Mon,  9 Jun 2025 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749481757;
	bh=TY+j0nASxQk+1sb6wh0CAFNql3zjYmvVHlihYQ3nANk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WEEGMSxcriWMZdMRX5sY7W2SeZDEV4HOLUSLaaX3nbYMuzRkO/6+33lJQ7wrlXsUg
	 4DkqFFDJqvJAUZ9IUzHOCvdz5M7ye/ESMEgDweR7rRjgTomIxhYW4yZ0tw3yGtvUUi
	 o45ESOPAGmG/bvvsX4B32oSD35I0NEjbqFzdVf2KpKg1B+40xys+lEAasqIqPksdIG
	 +uw9vPqa4KEQSL6KQhi8NpqF+WFd3vdNeKHsQAZiaQ6WqSw99COnrWO1ZzlW0kwJY3
	 Gli2kpn5BZJqN27ht4bC+Vko/AvkOjLbOv+G6YHZpvcelYOaI5Ebl20OVEb3QeapdH
	 qtaG8S/qik7dA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Jun 2025 16:08:56 +0100
Subject: [PATCH 1/2] tools/nolibc: Provide vfork()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-arm64-gcs-vfork-exit-v1-1-baad0f085747@kernel.org>
References: <20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org>
In-Reply-To: <20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TY+j0nASxQk+1sb6wh0CAFNql3zjYmvVHlihYQ3nANk=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhgy3n+KPmcPYt7v1C98WrBN3+bhY6wKbyJ2e4BxeIVHBOT79
 bbc7GY1ZGBi5GGTFFFnWPstYlR4usXX+o/mvYAaxMoFMYeDiFICJNLtyMDRXe065871XPmcPl9cpdc
 fE54Z9P9MfNNqZbm0/sUDmlYie6s94/ayF8brtBqzH+52WRnvsruyTKbnb7T+t58g9C9PeZI7+CbN+
 lB3YFtl47tElRc6XJh/v/1wVtXDd+k+Vds5XFn1IymLtdNyiuq3T8McpjX2XlJlubll0q3rR6xX6m6
 9NnenAsTvvlX2z9FmjiG+btW32iLzpni1T2yg3J9Fv8mrXr26tC15PNb3bP8VtT91b79y7LVGhvyeu
 qC1J16njVHz9mn+ioifrDe0nmr9bQ/niXm6+7BsazX7/irqudnW+vmu8S2KIIc8iPQsH6XPJ5YZRnp
 nWZzKXqC+Z9c5L80vAqxmuzW7ZAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

To allow testing of vfork() support in the arm64 basic-gcs test provide an
implementation for nolibc, using the vfork() syscall if one is available
and otherwise clone3(). We implement in terms of clone3() since the order
of the arguments for clone() varies between architectures.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/include/nolibc/sys.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 9556c69a6ae1..e056da010f64 100644
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
+#ifdef __NR_vfork
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


