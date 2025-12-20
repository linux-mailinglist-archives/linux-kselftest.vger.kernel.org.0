Return-Path: <linux-kselftest+bounces-47762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E9ECD3007
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC4D830019DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E1E2EFD86;
	Sat, 20 Dec 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Yfwpd+9F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5A2DE6F4;
	Sat, 20 Dec 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238967; cv=none; b=qiUnYRcUIBDkc+HaBmTFH1ynwcRi1XC0/62AVTe74ep6oGI8xwSOgAGmdsfJjWjTfaWo7LWBBuCcxq8yf/z4bIOYQtHjShckCmGWaPVkGZy8hNAeyptUNI7m/9mSAWmBmHuU7KOYtPBZYX7CxF6pJhe6TJQ73nKgsXPTrBv2EuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238967; c=relaxed/simple;
	bh=6N2OUgVowZtYioDgMO03QsrHw7wax3/lq8qAqnnDT9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNu4afw/yd8/LY7CAk6ePiaCiGyvc4MR2HtVeJjKJlN1kOWtD5szhc/u19z24IMulVtt27Cza/P6tSQa5EWfmnlCvzTIH/EOqlC5uAUs3p4R/wOXqLpQjyZTJLR+u+eZ09W1uCaUv4VdLIns6uyGtAjamZRrQrr+SlbWAop23MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Yfwpd+9F; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238957;
	bh=6N2OUgVowZtYioDgMO03QsrHw7wax3/lq8qAqnnDT9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yfwpd+9Fe+cb99tVQ6qqoj69HD4+CUlxP+3Ztu1NAZnOziqdrTWxf3wTvvy4msrN7
	 vhORqNEo6sa/Qx+ZXYdl+aHCb5/KcQIUF3oswVJNIY7Qh/NxGqe9kXhvrcsI4wwxD9
	 hC4a7HN8hOFNLYI9Zf0YZ0THN6y8SKopvh5Lny9I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:45 +0100
Subject: [PATCH v3 01/14] tools/nolibc/poll: use kernel types for system
 call invocations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-1-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=1655;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6N2OUgVowZtYioDgMO03QsrHw7wax3/lq8qAqnnDT9Y=;
 b=j0QMLr0U+QDQ0iiqP4ui6Hj7RIDJnMycPXjpWvliH3/ORam/BCS3rJWLgMiAbmLELfqb0HQFA
 DYER+s0tYlXBtFzCN4bJGAMZzsmAGnvvePCgNEE0/Kspu/WfIHfxieS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The system calls expect 'struct __kernel_old_timespec'.
While currently 'struct __kernel_old_timespec' and 'struct timespec' are
compatible, this is confusing. Especially as future patches will change
the definition of 'struct timespec'.

Use the correct kernel type instead.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/fbca1d3e-12e4-4c4e-8091-87464035fe39@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/poll.h       | 2 +-
 tools/include/nolibc/sys/select.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/poll.h b/tools/include/nolibc/poll.h
index 0d053f93ea99..df952bcf0905 100644
--- a/tools/include/nolibc/poll.h
+++ b/tools/include/nolibc/poll.h
@@ -24,7 +24,7 @@ static __attribute__((unused))
 int sys_poll(struct pollfd *fds, int nfds, int timeout)
 {
 #if defined(__NR_ppoll)
-	struct timespec t;
+	struct __kernel_old_timespec t;
 
 	if (timeout >= 0) {
 		t.tv_sec  = timeout / 1000;
diff --git a/tools/include/nolibc/sys/select.h b/tools/include/nolibc/sys/select.h
index 2a5619c01277..9a29e5b98a3c 100644
--- a/tools/include/nolibc/sys/select.h
+++ b/tools/include/nolibc/sys/select.h
@@ -75,7 +75,7 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 #elif defined(__NR_select)
 	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
 #elif defined(__NR_pselect6)
-	struct timespec t;
+	struct __kernel_old_timespec t;
 
 	if (timeout) {
 		t.tv_sec  = timeout->tv_sec;

-- 
2.52.0


