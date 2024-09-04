Return-Path: <linux-kselftest+bounces-17091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD9696AE0B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 03:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0C91C246BC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 01:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D55256;
	Wed,  4 Sep 2024 01:45:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8F2F23;
	Wed,  4 Sep 2024 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414340; cv=none; b=VtY0/85KHnmeXSJYoRSoNLKaPtC/t1HHKSzlXTu6mbZwD9xQK6UZqJTJerGHwl+wJcO2d5mbBkHbwEmPLyi6b02g1RB66B7VVtdPEgMcf+TjMWVz5LlUfx36Xlge8s2Jfyd8BAIB+eBRnFWDVUZj/VYIvwQ/wX5dUAoz8G7EAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414340; c=relaxed/simple;
	bh=5HBu8C4PjvfJMb/BnrrnTrPxSK8UUloFuArx07Is6z0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k3zj6UzZNVrojqrwGmRStuNPgu9SsTfLhx4IryP0xBbX2HIw66/kATVT6YSLQCNfaZRn953RGh2+i15COmePtTGpYwkpeCQLEaPb+IdPi9rxOj6YaJsSWKzU8dYSWCD+Gjdsde3rM7dFK3NLwI23JJ2tv/So8C25LouMsD3ylZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowACHXI+uu9dmxYX1AA--.55981S2;
	Wed, 04 Sep 2024 09:45:18 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] selftests: net: convert comma to semicolon
Date: Wed,  4 Sep 2024 09:44:41 +0800
Message-Id: <20240904014441.1065753-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHXI+uu9dmxYX1AA--.55981S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Gr4rCw4kuw4kuw1xGrW3ZFb_yoW8Jryrpa
	92yw1qyF40qa4UKw12yFWxZayjqFnrJa12kr47K3yUZw1UJF1aqrW0ga98tFy3WrZYvay3
	ZFZ7Xr15uws8CaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUlYL9UUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Update commit message.
---
 tools/testing/selftests/net/psock_fanout.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
index 1a736f700be4..4f31e92ebd96 100644
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -165,9 +165,9 @@ static void sock_fanout_set_ebpf(int fd)
 	attr.insns = (unsigned long) prog;
 	attr.insn_cnt = ARRAY_SIZE(prog);
 	attr.license = (unsigned long) "GPL";
-	attr.log_buf = (unsigned long) log_buf,
-	attr.log_size = sizeof(log_buf),
-	attr.log_level = 1,
+	attr.log_buf = (unsigned long) log_buf;
+	attr.log_size = sizeof(log_buf);
+	attr.log_level = 1;
 
 	pfd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
 	if (pfd < 0) {
-- 
2.25.1


