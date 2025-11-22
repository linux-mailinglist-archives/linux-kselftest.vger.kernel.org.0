Return-Path: <linux-kselftest+bounces-46325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5042BC7D461
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53CDD4E54FC
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9A32FB966;
	Sat, 22 Nov 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZhAfOUMc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282492D8DD0;
	Sat, 22 Nov 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830798; cv=none; b=VALwA0XvbGUQWAKt0wLO7B1J+rSt3MtNQUh/l5TgsEIVov5kzXQrDaxGVEKdRGMOSe7L9CFEUvFp5PJBWRrt2ajIr5uznTCMNXtRiHiOMgqL5r9KK8/QjOdORfS5lEqdjvFpSR9tLadsJS3rSBX5tvV/02byBFgxs6zikSByb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830798; c=relaxed/simple;
	bh=l9dUdwc7wiqkjKdJBg+bWqZ2xAX/mhq03Y3wW58x0Jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jX3t4kCdsSNRzxQSI6F52+8t9ONK6a9RowJF9j+saYQFVPZz2iQFKVeFKbaGOHHQSeQC8eWSYg8s12nfavkYpMEG2QJUhHmiOSxbcBv7QL724W9tiR0g1sEBaXdnh+v+mvAWE/D1EnatZol7fcK6zYe9h/nrioTVWsIegQJ6zUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZhAfOUMc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830790;
	bh=l9dUdwc7wiqkjKdJBg+bWqZ2xAX/mhq03Y3wW58x0Jk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZhAfOUMcLxG1BCDxaaajUn3d5n5JUYsUiGDEAK4ScZPZbbG+vHxe27ZqmfAEFY4RX
	 j40eDP/0ZGNfZQjKGlFjNrgHriMdIZbLzbPfhCllIgNrL00AIEa1jWWFUxLBgm0gyf
	 Ft5DkmlW57jeVJiialMTYkhBIalO2WcNVItcrFT4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 17:59:09 +0100
Subject: [PATCH v2 03/13] tools/nolibc/select: drop non-pselect based
 implementations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-uapi-types-v2-3-b814a43654f5@weissschuh.net>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=1503;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=l9dUdwc7wiqkjKdJBg+bWqZ2xAX/mhq03Y3wW58x0Jk=;
 b=PdFfyZgacglLLCCcbulKErE3oG1pu+XigHNY5HccJxyO4RR+Wr/B+RY0nVP18ZU8Y7asLxscY
 +85FAc7nly9BwPbcnY3bjgK1JtOg5YJiH81pEVSbFemtc53Pj6JfIj0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These implementations use the libc 'struct timeval' with system calls
which can lead to type mismatches. Currently this is fine, but will
break with upcoming changes to 'struct timeval'.

If the structure needs to be converted anyways, the implementations
based on pselect can be used for all architectures. This simplifies the
logic.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys/select.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/include/nolibc/sys/select.h b/tools/include/nolibc/sys/select.h
index 9a29e5b98a3c..50b77dace7ef 100644
--- a/tools/include/nolibc/sys/select.h
+++ b/tools/include/nolibc/sys/select.h
@@ -63,18 +63,7 @@ typedef struct {
 static __attribute__((unused))
 int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
 {
-#if defined(__ARCH_WANT_SYS_OLD_SELECT) && !defined(__NR__newselect)
-	struct sel_arg_struct {
-		unsigned long n;
-		fd_set *r, *w, *e;
-		struct timeval *t;
-	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
-	return my_syscall1(__NR_select, &arg);
-#elif defined(__NR__newselect)
-	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
-#elif defined(__NR_select)
-	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
-#elif defined(__NR_pselect6)
+#if defined(__NR_pselect6)
 	struct __kernel_old_timespec t;
 
 	if (timeout) {

-- 
2.52.0


