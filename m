Return-Path: <linux-kselftest+bounces-31201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13326A942EC
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 12:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB683A87BD
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF31E1C1ADB;
	Sat, 19 Apr 2025 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aGLfPhYR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0176C43AB7;
	Sat, 19 Apr 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059591; cv=none; b=hQan3nmk5C9OCCT63YUu7nV/WIOcjPXV77dE3XFL88bRZOfxgfnb7zKcmdcLJQ0+TNuS/h463mJmy1YTev8IXlLeBdxmvLb/iZ4yazdr1sHVBOLo25XML7vEKphlQUgYMjKWNYQ55CWOCY3rD3jsve7Q7p/UbTJbzXbA5Y7m9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059591; c=relaxed/simple;
	bh=2U/dcRwTExJtAZorNzJrHaFvZx2GCTS0zbAPO75QNGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/XVKNdLyV8JoUq+TNhthfukEQ38QrPlo4Yp26JuHGkZYPay+X+PAj0omvy6kczT0OkQU3v4XZhmiBLwGNYaXupXpaA9Ox5jSs5HtboA3dMcWhXf9yqrOjD1kT5XQ5UjSbJt8xbAzoDcWGb+EWWTHyw/0aq6VR5g7Iun0/utQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=aGLfPhYR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745059587;
	bh=2U/dcRwTExJtAZorNzJrHaFvZx2GCTS0zbAPO75QNGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aGLfPhYRPFnc3C4nO72wONVUzSo3D5O/Qp20l2WjHs9okOO1VrPZ5NZkUHjlZgxaE
	 +be7vAHwXNgegfqabI/ND5KnHk83wh7h6nLsHU4e+YHf7KIQdLhRevYhDcXy7Yub/k
	 WhLgUBmLy0jlxCh2p79FBd+zUL8gAJCIkyAy33iI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 19 Apr 2025 12:46:21 +0200
Subject: [PATCH v2 4/7] tools/nolibc: properly align dirent buffer
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250419-nolibc-ubsan-v2-4-060b8a016917@weissschuh.net>
References: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
In-Reply-To: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745059587; l=1186;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2U/dcRwTExJtAZorNzJrHaFvZx2GCTS0zbAPO75QNGQ=;
 b=LLSwzT4aqCw37xqmYBxyy4xERUH85Gl5SniRsgsU0Mlm2FsCKfHCT/jBMJLPPhj6oJ1toBgGK
 FSxV8IStHgHBO+UQTItXv0/rB/8zXuHrhD6NBDKE/If2zPasikIBfnb
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As byte buffer is overlaid with a 'struct dirent64'.
it has to satisfy the structs alignment requirements.

Fixes: 665fa8dea90d ("tools/nolibc: add support for directory access")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/dirent.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/dirent.h b/tools/include/nolibc/dirent.h
index c5c30d0dd6806b1bec2fa8120a3df29aaa201393..946a697e98e4c7bb0970b163ffdfe0e069b1d160 100644
--- a/tools/include/nolibc/dirent.h
+++ b/tools/include/nolibc/dirent.h
@@ -7,6 +7,7 @@
 #ifndef _NOLIBC_DIRENT_H
 #define _NOLIBC_DIRENT_H
 
+#include "compiler.h"
 #include "stdint.h"
 #include "types.h"
 
@@ -58,7 +59,7 @@ int closedir(DIR *dirp)
 static __attribute__((unused))
 int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
 {
-	char buf[sizeof(struct linux_dirent64) + NAME_MAX + 1];
+	char buf[sizeof(struct linux_dirent64) + NAME_MAX + 1] __nolibc_aligned_as(struct linux_dirent64);
 	struct linux_dirent64 *ldir = (void *)buf;
 	intptr_t i = (intptr_t)dirp;
 	int fd, ret;

-- 
2.49.0


