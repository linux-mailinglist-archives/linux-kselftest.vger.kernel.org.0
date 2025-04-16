Return-Path: <linux-kselftest+bounces-30976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40624A90B76
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 20:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F2117A834
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B8A224253;
	Wed, 16 Apr 2025 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RCSFiGSb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E922423B;
	Wed, 16 Apr 2025 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828848; cv=none; b=Ddhd3mqxpHpXzJtD6JXiMn7gUup7TKJFyMCJb6g0qDrjEsBlaquruUC7bXGvu3hWD0+CJCyoL5MH/OuNI8jlm01TTomf1C9uhr7X+bNMCeTywrTw1N7mzGmHduGtkee6jRO6VUMPkUWA3VCXgK6IPkcdaWMYbHb9w1jZgPRSYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828848; c=relaxed/simple;
	bh=umVrEBGRj3bl+YVGjKRcJZOWpy3k480FdxVtwmyb2hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tZdQGxqe1l0Spx3xxWDS8mD2tVTFggD/Dymhye37Hp0wQ7jM3F7zx31hpYjBY6fcyAXAfxCNKcB6Tg0TK3TeNnAuIoV9MMLvd8MTfEwD3qk/yNPk9TTNi7QAtpFrdCk8Ig0KDfnXL8zrJJlpsMlXVwVWFxEr1hzAdilfYlnZqqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RCSFiGSb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1744828843;
	bh=umVrEBGRj3bl+YVGjKRcJZOWpy3k480FdxVtwmyb2hw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RCSFiGSbJNYSLG3TxRHz6zwC1nVYkgdEcPDMdyvypV5waQC/RdDCNIqYZbBDOw6+i
	 igglaxpIetgvkR2q2s/sLhXSwKegoNSLn4s2QOILM7DJUy+ky8SFXJ0dZRZBDWDrXM
	 ChpeAm/9F8ru+DQVYZd/x2G2h9yGaFiAs+XYOz5w=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 16 Apr 2025 20:40:18 +0200
Subject: [PATCH 3/6] tools/nolibc: properly align dirent buffer
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250416-nolibc-ubsan-v1-3-c4704bb23da7@weissschuh.net>
References: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
In-Reply-To: <20250416-nolibc-ubsan-v1-0-c4704bb23da7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744828842; l=934;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=umVrEBGRj3bl+YVGjKRcJZOWpy3k480FdxVtwmyb2hw=;
 b=ud/DqkVbfaY7SS7KVrfrdctaxRwKYJTWo+NBW9KWzJwf8p8VnzvEnICYp6FmU2c6+Tx80xco0
 oiUqr3VM+IjBauXHGu7hTqGat9mJ4WIiDuNP4ThCC9R2PZp8hw6DVCT
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As byte buffer is overlaid with a 'struct dirent64'.
it has to satisfy the structs alignment requirements.

Fixes: 665fa8dea90d ("tools/nolibc: add support for directory access")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/dirent.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/nolibc/dirent.h b/tools/include/nolibc/dirent.h
index c5c30d0dd6806b1bec2fa8120a3df29aaa201393..cd0ddff86c360b14913a809c8696d89d8a356e9e 100644
--- a/tools/include/nolibc/dirent.h
+++ b/tools/include/nolibc/dirent.h
@@ -58,6 +58,7 @@ int closedir(DIR *dirp)
 static __attribute__((unused))
 int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
 {
+	__attribute__((aligned(__alignof__(struct linux_dirent64))))
 	char buf[sizeof(struct linux_dirent64) + NAME_MAX + 1];
 	struct linux_dirent64 *ldir = (void *)buf;
 	intptr_t i = (intptr_t)dirp;

-- 
2.49.0


