Return-Path: <linux-kselftest+bounces-12970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A821391D1B2
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 15:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD961F216E2
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 13:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E20613BC12;
	Sun, 30 Jun 2024 13:01:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982038DC0;
	Sun, 30 Jun 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719752473; cv=none; b=SOGaaRt+GiGNGCbYLTaYwGR9+CpE2xuKoKc198lyBZHmu/G/VOBSN1uwNANe/XHqw68EQh6MBCpdSs5WIxw/TyHk92ZQYYisk1j4xdxYUZg5QN8k9G2dNOM+8I53Vyk1BEtMCpJdO/FEClI9u3ZtJGa0HwhFQBWXps7fZvCOfGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719752473; c=relaxed/simple;
	bh=xMj/myBzm+/VpLtwbn4+LKZJHjX/L5rUSL9EdkSg3No=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oM8npdUe5ZycQLYXx/JGFC8YlWSQ7Mo247M+4mipP7N0Z5P1TzZLMXkxQsF5YRoOas/gWP2JiF6VjH8DVW3k7l8QHLMpjSnOIII3trCaVOAA+SF7qrQCuNmzK+uHIlzJVULjyMfnVmnyWM5jEXFqvz5gnNFN9pbQwG97M/QsbUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAAXHNT3VoFmpidNEw--.25664S2;
	Sun, 30 Jun 2024 21:00:49 +0800 (CST)
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
Subject: [PATCH v3] selftests/capabilities: Fix possible file leak in copy_fromat_to
Date: Sun, 30 Jun 2024 21:00:38 +0800
Message-Id: <20240630130038.3671507-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXHNT3VoFmpidNEw--.25664S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1rAF4UXr15Xr4kCF4xtFb_yoW8ZFyrpa
	yxJ3yY9as7KF47Jw18J3yvva409F4kJr47tr1DGr9Fv3WfGr1vqF4xKFW8ta4UurZYqa4S
	v39aqFWv9F4DZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
	nIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

The open() function returns -1 on error. openat() and open() initialize
'from' and 'to', and only 'from' validated with 'if' statement. If the
initialization of variable 'to' fails, we should better check the value
of 'to' and close 'from' to avoid possible file leak. Improve the checking
of 'from' additionally.

Fixes: 32ae976ed3b5 ("selftests/capabilities: Add tests for capability evolution")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- Thank you for your interest in our vulnerability detection method. We 
extract vulnerability characteristics from a known vulnerability and match 
the same characteristics in the project code. As our work is still in 
progress, we are not able to disclose it at this time. Appreciate your 
understanding, we could better focus on the potential vulnerability itself.
Reference link: https://lore.kernel.org/all/20240510003424.2016914-1-samasth.norway.ananda@oracle.com/
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


