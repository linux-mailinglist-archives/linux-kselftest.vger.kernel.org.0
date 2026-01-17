Return-Path: <linux-kselftest+bounces-49235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D026D38E34
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 12:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D876A3008DFD
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6CE33507B;
	Sat, 17 Jan 2026 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YZT6kyVd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F7329E7D;
	Sat, 17 Jan 2026 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768649277; cv=none; b=LHwuLrzKKm6LIsKj1uHPgeSuwvKHTieyftEVzyBrOGFeekdrUNxfQWGHxc7DwgMtyQhAA27Fj+6j8+oevzd7R/lw6xWzk9Z/gFouTNJsPnMQ68pjIsGAlrx9YidaId8XGCfRzxVauVc2c8Ly0Ovm2gL+e15iTjaXIonP1c6qo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768649277; c=relaxed/simple;
	bh=OW43itkqUHtxS37BsbFYe97PdBAljL0UDj9thfEiWHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=isRY3/tPXwddcOI9qoW798nSO9ANMHs1d3KwnTmvLZWTSlCHiB6dEQNlzbNjVnjcku0iOjVWn4oQ03QHvxd0ZsVJpLKziH79s2VTCEvU/Nt1mP/LUeY+t30IaEGN3kPRK4OsXpwdxinGCZEAeiFY5wGfTcuxlKTM9sUkbdFiIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YZT6kyVd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768649272;
	bh=OW43itkqUHtxS37BsbFYe97PdBAljL0UDj9thfEiWHM=;
	h=From:Date:Subject:To:Cc:From;
	b=YZT6kyVdoI/BMZKRnG0EmFZAvjFF0LgVppy9M3CLTpebkLgZ+9iao/j/3Lg2Jo44H
	 q6/X8AWvcTt0rCjGEjsWQCHq3P/+oLB4aKZ/X1H17ZDJquMLh9NAz4GLgADb+INdKE
	 Wqpd8n1jPh56augDIWvovPQ4zSmgKBdN4OQ3UJMI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 17 Jan 2026 12:27:46 +0100
Subject: [PATCH] selftests: riscv: vstate_exec_nolibc: Use the regular
 prctl() function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260117-nolibc-mysyscall-riscv-v1-1-0ae1ae3513e9@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1gZaxU+9iriwNWqgVmlAFPHuF
 pdvMfOAUGQS6LIHIp0svIcEnWfg1jEshDwlQ6GKWmndYNg9W4fbLbe40XuMLO7E1pRtZSqjZms
 hxUekma9/3A/v+wFg3eA6aAAAAA==
X-Change-ID: 20260117-nolibc-mysyscall-riscv-893859590fbb
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768649272; l=1578;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OW43itkqUHtxS37BsbFYe97PdBAljL0UDj9thfEiWHM=;
 b=Pnv+sld0dz0N/prWd330V2GUCsIiaydFowwLdGpGZtVYpzv6+6WzjYcHXrHcLGIPzXyjSqrcz
 rIJ9Tt+ZEzOCJZnhnL0sGrIEYbEAK0UwIUcCb0B36btjMzVtGnEwAjW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The my_syscall*() macros are internal implementation details of nolibc.

Now that nolibc has a normal prctl() function, use that.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Compile-tested only.
For the riscv tree.

I want to rename those macros at some point.
---
 tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
index 7b7d6f21acb4..12f1b1b1c7aa 100644
--- a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
@@ -16,10 +16,10 @@ int main(int argc, char **argv)
 	if (argc > 2 && strcmp(argv[2], "x"))
 		xtheadvector = 1;
 
-	ctrl = my_syscall1(__NR_prctl, PR_RISCV_V_GET_CONTROL);
-	if (ctrl < 0) {
+	ctrl = prctl(PR_RISCV_V_GET_CONTROL, 0, 0, 0, 0);
+	if (ctrl == -1) {
 		puts("PR_RISCV_V_GET_CONTROL is not supported\n");
-		return ctrl;
+		exit(-1);
 	}
 
 	if (test_inherit) {
@@ -51,7 +51,7 @@ int main(int argc, char **argv)
 		}
 
 		if (!pid) {
-			rc = my_syscall1(__NR_prctl, PR_RISCV_V_GET_CONTROL);
+			rc = prctl(PR_RISCV_V_GET_CONTROL, 0, 0, 0, 0);
 			if (rc != ctrl) {
 				puts("child's vstate_ctrl not equal to parent's\n");
 				exit(-1);

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260117-nolibc-mysyscall-riscv-893859590fbb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


