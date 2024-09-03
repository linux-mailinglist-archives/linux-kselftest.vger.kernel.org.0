Return-Path: <linux-kselftest+bounces-17030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC19695EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F681F24AEE
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711911D6DD1;
	Tue,  3 Sep 2024 07:46:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00861CDFCD;
	Tue,  3 Sep 2024 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349604; cv=none; b=N40BoYTvwUOpf2fcQnsMyfcmbPZWfwRSoLEmjev49WDyS5aeUUwGnsslvikPGxTRE/S8N1JRcznWBtRSJTmQMmNAj5o20NfBPTZI42DcS/4/WT/WZXf2njXyQZC0UhJz1v/q/Vv0jg7k42ZMBMQ6OJ7UQetXKSTQNI2b3va6nFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349604; c=relaxed/simple;
	bh=gT5AzO0UNM6QTElViqcBqC42ZSFImmjwiORhutd450Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rO+QfJue6a3e5ELktPdn/bLzRuSav3f5RPRDPgcEj/EWQEmgB3nPH3P1vJ3Aba7SzIwcZNljQW9Wi965c+mbPfpVi3nOfUnRNznGmu980hPMSqBfQi7qjekrjbihsGFYJkViMyeprcfW9jkEe3vtA22JcU2DY1p9GzddUlsn/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowADX947WvtZmGIfAAA--.44837S2;
	Tue, 03 Sep 2024 15:46:32 +0800 (CST)
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
Subject: [PATCH] selftests: net: convert comma to semicolon
Date: Tue,  3 Sep 2024 15:45:19 +0800
Message-Id: <20240903074519.781224-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX947WvtZmGIfAAA--.44837S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4UZF15Zr47JF43ZrWfAFb_yoWDJFcEya
	nrtw1kAFs8Zr1vyF17Wa1Y9rn5A3ZrCrnrGF1kKF13tr1UAFy5ZFnY9w1DJFy8W390kFy3
	Za17JryfK3409jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUSZXrUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace a comma between expression statements by a semicolon.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
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


