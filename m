Return-Path: <linux-kselftest+bounces-46319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4CAC7D439
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96F93A9404
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7CB289E06;
	Sat, 22 Nov 2025 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IJKXpAXT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C2020DD51;
	Sat, 22 Nov 2025 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830794; cv=none; b=e5XYdFj77obC9NiHsl8KgBj1gbxw/J10IaiJk+v50XWiSOUilu3Uw38Y48UKHs3uyUhTe4ql/8azDcsVSkbaiFNoxVn/ZG+3Qt09CmLNPqVlyqdBxcbL1DysK1yOnY7rfd/z9EDwfvEa1b3VG+EnW5laMhVSyd1acohlmOtCM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830794; c=relaxed/simple;
	bh=OXjYAaSKgSUp1SYFjqpEYfE2DfwsOyHI6zFHrIiJQ48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htfisvF8qSQ9CMXqyeHffUbD+p4+aTuy2Bd3xvJlfebEgByWFn7i3pEq9YVg1cGQHCqa61/23NTXcxLBzDb6gL4lRn9rDCPlutLwjHBUGDMc7/Y7oDNoF4lgInSOj/Ut6FhVky8BPJn3cSae2eKkTGQHTTo+XT6ESHVZv0p1/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IJKXpAXT; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830790;
	bh=OXjYAaSKgSUp1SYFjqpEYfE2DfwsOyHI6zFHrIiJQ48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IJKXpAXTOrEvjiD1CGLZBbRmr+t6hNQZcUp961mSWvS0RRGctlmcO1v20so9O5MdN
	 dX2HxxA8n91NFrfRgdF+XhukWWboXD3hQcmXqcBkRmEwDzkQa6bh7mzNgYheKi1298
	 4FEg56qrm0iMI/qHdzWNy/dL8r2B+9nfu2D7fpUw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 17:59:07 +0100
Subject: [PATCH v2 01/13] tools/nolibc/poll: use kernel types for system
 call invocations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-uapi-types-v2-1-b814a43654f5@weissschuh.net>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=1619;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OXjYAaSKgSUp1SYFjqpEYfE2DfwsOyHI6zFHrIiJQ48=;
 b=91uPi2WXdzPL5fEM3KLwwgRubqN1R77wr6/Xrqp5dWOe+uihm5aPzDxcW4lkHBIKCttDjDCzL
 P+FMUeao2/4ANia8Y27lx/RdzsWtIwAf/oOrDEsSU6mFRmblfu2jVCh
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


