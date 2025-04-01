Return-Path: <linux-kselftest+bounces-29972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F368A77464
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 08:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382B4168E47
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 06:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293F1DB55C;
	Tue,  1 Apr 2025 06:17:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC804131E2D;
	Tue,  1 Apr 2025 06:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743488261; cv=none; b=riSZMFJVzBwaVufzRBJkVZSx2IsWWluJSw0YVDiL2JedyvAXiQ2TIAh81GGxWlepfwgsDSfsYALCpxJAg6C86k/GLDXkh644l8+xCP/Xme2OdjQQUKh/l1mtoCxzNEENhLyi8I+wCUBPYb7GXDFpQUaTc/tax5zNPdLkR5qR/7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743488261; c=relaxed/simple;
	bh=L6I6mgr2VPoIYZD2sGpQ4Y2PmWqo7xJmAmKe2BECYRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LNNTitC1MH4viFwEm51dVUGycwst6OGd/E968lLSyiV1aI4tpC2eiyJJTSdfTqY+fkPCDV41iVrY5dTnxZ+scRbb13HUxUgO2aF4lw3++p9bj8MT3faxA/acKCQKIuQrZsta9ZKFKvJet9vXsebKKzYDXyNU29H1Nq/z/OQxDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACn3wfchOtn05WcBA--.19358S2;
	Tue, 01 Apr 2025 14:17:02 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	peterz@infradead.org,
	ameryhung@gmail.com,
	juntong.deng@outlook.com,
	oleg@redhat.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] selftests/bpf: Convert comma to semicolon
Date: Tue,  1 Apr 2025 14:15:46 +0800
Message-Id: <20250401061546.1990156-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACn3wfchOtn05WcBA--.19358S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ur4DKrWUZF4kWFyrtFb_yoW8Cr47pa
	4fXw1DAr1xJa1UJa1xKa9Fqr1S9rsIq3y7Jas3Kr93Xa13t3W3XryUtr18twnxXF4rXa15
	uw1YvFyv9an7ZrDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRzMKAUUUUU=
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
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 3220f1d28697..f38eaf0d35ef 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1340,7 +1340,7 @@ static int st_ops_gen_prologue_with_kfunc(struct bpf_insn *insn_buf, bool direct
 	*insn++ = BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_7, offsetof(struct st_ops_args, a));
 	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 2);
 	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id),
+	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id);
 	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_8);
 	*insn++ = prog->insnsi[0];
 
@@ -1379,7 +1379,7 @@ static int st_ops_gen_epilogue_with_kfunc(struct bpf_insn *insn_buf, const struc
 	*insn++ = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, offsetof(struct st_ops_args, a));
 	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 2);
 	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
-	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id),
+	*insn++ = BPF_CALL_KFUNC(0, bpf_cgroup_release_id);
 	*insn++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_6);
 	*insn++ = BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, 2);
 	*insn++ = BPF_EXIT_INSN();
-- 
2.25.1


