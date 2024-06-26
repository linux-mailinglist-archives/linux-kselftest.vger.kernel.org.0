Return-Path: <linux-kselftest+bounces-12777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C520917984
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 09:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A421F23C20
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 07:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791CF158D74;
	Wed, 26 Jun 2024 07:20:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFD1847;
	Wed, 26 Jun 2024 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386446; cv=none; b=Sv6FjUiW4BX7dWDB18XzRstTSe4BIGcO26afwwXPOLT/ul20FlpvEMe+M0dRnEsROlvs8AtYl+kg1QPv4A9J/aS2XiNJ4oCUiMjXFOIIbCdidQ1E4OXxFkpsjaH1N1StubIbnNm4J//o0QdvAt/zlJJJDkAmDkcayk7xv8uC0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386446; c=relaxed/simple;
	bh=OqEnKKiJjQVSfNPWrE0Mk8R/WYJ1z/AHeH7hQPc6gGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJpHxoQ7gKwn6fS3RGE2dtyxVj516dK2Mu0wMGOCOZ/NayxVRkkf6hecjH6ngB8X5+XhnnXGMAOf2rJO1BtFeZ4p1ZZWNRVbZp1cB6Lrsz+VHRKTaGRWj3LPDQ+7WAtOWG9CHfGcpnZ+TLVnMOCjGXzahYpWi1corcpF7DWL5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowABXXQE5wXtmX+DcEg--.19512S2;
	Wed, 26 Jun 2024 15:20:35 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: shuah@kernel.org,
	usama.anjum@collabora.com,
	amer.shanawany@gmail.com,
	make24@iscas.ac.cn,
	swarupkotikalapudi@gmail.com,
	kees@kernel.org,
	luto@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/capabilities: Fix possible file leak in copy_fromat_to
Date: Wed, 26 Jun 2024 15:20:24 +0800
Message-Id: <20240626072024.2816986-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXXQE5wXtmX+DcEg--.19512S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr1kAr15ZrW5Xw1ftFW5Jrb_yoW8JF15pa
	4xJ34aka4IgF47tr1UJ3yvvFy09Fs7JrW7Jr1DG342qr1fGrn7Xr4xKFWUta9ruFZaqayS
	v392qFZ5Wa1DJ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

The open() function returns -1 on error. openat() and open() initialize
'from' and 'to', and only 'from' validated with 'if' statement. If the
initialization of variable 'to' fails, we should better check the value
of 'to' and close 'from' to avoid possible file leak.

Fixes: 32ae976ed3b5 ("selftests/capabilities: Add tests for capability evolution")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Found this error through static analysis.
---
 tools/testing/selftests/capabilities/test_execve.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 47bad7ddc5bc..de187eff177d 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -149,6 +149,10 @@ static void copy_fromat_to(int fromfd, const char *fromname, const char *toname)
 		ksft_exit_fail_msg("open copy source - %s\n", strerror(errno));
 
 	int to = open(toname, O_CREAT | O_WRONLY | O_EXCL, 0700);
+	if (to == -1) {
+		close(from);
+		ksft_exit_fail_msg("open copy destination - %s\n", strerror(errno));
+	}
 
 	while (true) {
 		char buf[4096];
-- 
2.25.1


