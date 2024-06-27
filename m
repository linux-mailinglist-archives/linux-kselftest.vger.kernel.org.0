Return-Path: <linux-kselftest+bounces-12834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5492B919D16
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 03:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2CF2B228BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 01:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DF66AD7;
	Thu, 27 Jun 2024 01:58:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459AF6AC0;
	Thu, 27 Jun 2024 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453484; cv=none; b=nMjNTd7B/rsqiP4TAnh61R4lLgKgD2mBZ3vX9Tuykx1uG4z651R6uWqL5xklvuNBACNToIlg3hP69LDn+W9pliTr7tAeSjQeHUscUPKouqAZDhSvy9LX1nCdqXD3JMq9Lxsz/yKQo4NEdPGkqiZdY/trkKI5DT9s9aptrFanm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453484; c=relaxed/simple;
	bh=QtWF5D6wtWtzMUjsvVghrZTI6m0RYR/eXMJY/MsGWvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JEUKKSw8oxJgMWuYGnkcdKQjaxANac61pOo5onHWz1DAhFwEdUx5aRkj4EszVqjQ/vgdNBQCTgt1hpqgTd3q3pQvuJ4GhE0Da5Z0yFHOfhbXM4RmWz19RcZpASzvIWkMWO/RMJhW/jqOWhcvPFHZ4o/56HYTCX2aAabUqM4b7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAC3v7cSx3xmZCAgAA--.4237S2;
	Thu, 27 Jun 2024 09:57:41 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: shuah@kernel.org,
	usama.anjum@collabora.com,
	swarupkotikalapudi@gmail.com,
	make24@iscas.ac.cn,
	amer.shanawany@gmail.com,
	kees@kernel.org,
	akpm@linux-foundation.org,
	luto@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/capabilities: Fix possible file leak in copy_fromat_to
Date: Thu, 27 Jun 2024 09:57:32 +0800
Message-Id: <20240627015732.2974078-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3v7cSx3xmZCAgAA--.4237S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1rAF4UXr15Xr4kCF4xtFb_yoW8XF17pa
	48G3yYka4IgF47t3WUJ3yvqa409Fs7JrW7tr1DG3sFvr1fGr1vqF4xKFWUta47urZaqa4S
	v392qFs5Z3WDJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	W8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxV
	WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS
	5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

The open() function returns -1 on error. openat() and open() initialize
'from' and 'to', and only 'from' validated with 'if' statement. If the
initialization of variable 'to' fails, we should better check the value
of 'to' and close 'from' to avoid possible file leak. Improve the checking
of 'from' additionally.

Fixes: 32ae976ed3b5 ("selftests/capabilities: Add tests for capability evolution")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch according to suggestions;
- found by customized static analysis tool.
---
 tools/testing/selftests/capabilities/test_execve.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 47bad7ddc5bc..6406ab6aa1f5 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -145,10 +145,14 @@ static void chdir_to_tmpfs(void)
 static void copy_fromat_to(int fromfd, const char *fromname, const char *toname)
 {
 	int from = openat(fromfd, fromname, O_RDONLY);
-	if (from == -1)
+	if (from < 0)
 		ksft_exit_fail_msg("open copy source - %s\n", strerror(errno));
 
 	int to = open(toname, O_CREAT | O_WRONLY | O_EXCL, 0700);
+	if (to < 0) {
+		close(from);
+		ksft_exit_fail_msg("open copy destination - %s\n", strerror(errno));
+	}
 
 	while (true) {
 		char buf[4096];
-- 
2.25.1


