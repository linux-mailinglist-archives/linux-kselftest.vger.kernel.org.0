Return-Path: <linux-kselftest+bounces-41207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A55B52708
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 05:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8AC1C2565A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 03:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50685188715;
	Thu, 11 Sep 2025 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FCwdmNI/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961A329F21;
	Thu, 11 Sep 2025 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757561537; cv=none; b=j3Xwe6PFXC8f4QwoHR3YaIvp3/WEDnRgpDtVRjNmiyP5857I4guj1hnNLlRCnUzVG1oDerksVei3ZetUYd0M21ngiUP6Oebf4mpeUEENxCLFVoeF3h9ZP1TapcOUy1O4X6t+nC00O3EIJoscKZhlEPDsOHOVhSfuQGR+Bfzbosc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757561537; c=relaxed/simple;
	bh=SCCBc1/jK7ZO3kT4wmYWBLQT6RVh6iwStDJFkvVZzO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tMOl1VxBn7qpOrMZoIPgAr9tsqlpicb0zAALP/NBZcTBFEp/xW4Ux1VTCztq8WcZhcjLKy3vahlX93rAaXVPkOb1QffvbJNl14ZoDdZhEk6ANSDcVrRhgxe7y23ugztuHhEjap8rNVAtT2bG4GUpla+IX/XScmlqlxrC663VHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FCwdmNI/; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tC
	iGzGE0DHTWu7jZAydvyLJA/sCbIJ/W4pGSY03GL3I=; b=FCwdmNI/XbzwSomaVo
	fOpq/BquHOSANzA3cBrPsMfAxZX7bwCDowEL4OzoDymfPZpWTc6wcjPrccXstNUG
	50o4KQcqo/5E9h/WaqYuko2NuOp99xQv5RLsBMzWbs4H/D2vIIIBz+PINLrwEsXx
	MUmAt8neCdCyIr1I0+Ay3K7B4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3H_StQsJoR5GRAQ--.13246S2;
	Thu, 11 Sep 2025 11:31:58 +0800 (CST)
From: zhouyuhang <zhouyuhang1010@163.com>
To: shuah@kernel.org,
	jlayton@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhou Yuhang <zhouyuhang@kylinos.cn>
Subject: [PATCH v2] selftests: filelock: Initialize the flock to zero
Date: Thu, 11 Sep 2025 11:31:54 +0800
Message-Id: <20250911033154.2397610-1-zhouyuhang1010@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H_StQsJoR5GRAQ--.13246S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFW5ur1kGrykZw1UZw43Wrg_yoW8ArW3pa
	93J343Cr1UKr17WF4UGan5Xr4FgwnrXa18CwnFg34IvF1rZr1kJF1Iyr18K34UGrZYgrs8
	C3WrJrsFvw1jvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnZ23UUUUU=
X-CM-SenderInfo: 52kr35xxkd0warqriqqrwthudrp/1tbiYB3CJmi+LQ51NgABsu

From: Zhou Yuhang <zhouyuhang@kylinos.cn>

On x86_64, the size of struct flock is 32 bytes,
and the layout of this structure may be as follows:

 +------------+  offset 0
 | l_type     |  2 bytes
 +------------+  offset 2
 | l_whence   |  2 bytes
 +------------+  offset 4
 | padding    |  4 bytes
 +------------+  offset 8
 | l_start    |  8 bytes
 +------------+  offset 16
 | l_len      |  8 bytes
 +------------+  offset 24
 | l_pid      |  4 bytes
 +------------+  offset 28
 | padding    |  4 bytes
 +------------+  offset 32

Flock fl and fl2 are not initialized after definition.
The padding bytes in the structure may contain random values,
which could cause memcmp() to return a non-zero value,
potentially leading to test failure. The output is as follows:

 # [INFO] opened fds 3 4
 # [SUCCESS] set OFD read lock on first fd
 # [SUCCESS] read and write locks conflicted
 # [SUCCESS] F_UNLCK test returns: locked, type 0 pid -1 len 3
 # [FAIL] F_UNLCK test returns: locked, type 0 pid -1 len 3

Initialize them to zero to solve this problem.

Signed-off-by: Zhou Yuhang <zhouyuhang@kylinos.cn>
---
changes in v2:
	- Add a description of the struct flock layout to the commit message.
---
 tools/testing/selftests/filelock/ofdlocks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..84e25505bebb 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -36,6 +36,8 @@ int main(void)
 {
 	int rc;
 	struct flock fl, fl2;
+	memset(&fl, 0, sizeof(fl));
+	memset(&fl2, 0, sizeof(fl2));
 	int fd = open("/tmp/aa", O_RDWR | O_CREAT | O_EXCL, 0600);
 	int fd2 = open("/tmp/aa", O_RDONLY);
 
-- 
2.33.0


