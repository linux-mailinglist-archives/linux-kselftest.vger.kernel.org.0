Return-Path: <linux-kselftest+bounces-12192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B6C90E17A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007F72820D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EDF3D57E;
	Wed, 19 Jun 2024 02:01:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ECE7470;
	Wed, 19 Jun 2024 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762504; cv=none; b=S1KNl5lpqmqfPPvc7+s47uv+bG5YuaV+iKcZCKtyl6jUah1jYlUW3lFovzoZkfBl5LWPxaLtJCpcOkedOCjvcFyK7OaNbnC03kwf8Nc47/Z8/AgpgVrRoC/+0t+te8cP4WGEUOJus2h7KoCVgO7M3pwKYNX5OD7SRXBYkJfYuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762504; c=relaxed/simple;
	bh=Fa7JE2b6dXrhrG9ZpxQ/R79R+ygTJTKKTIW7ZGyH2QY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leIowckh0Xli1NwWGw2yacOWUiSuM87IGzFUf6eW8clJcIAhVFLUZXPKsGrU6WJHXKQXux7EktUAaBpsH92peVQEG4P54a7Zsw0rfHtZwQSzkixdfsmVpj6Ehw/bCrm2mBWyDFXBYLjW5RQZiUl9G0/aUUqNg95NIROc5jOzJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ThinkPad-T480s.. (unknown [121.237.44.152])
	by APP-05 (Coremail) with SMTP id zQCowACHjeX3O3JmKoWbEQ--.13480S2;
	Wed, 19 Jun 2024 10:01:27 +0800 (CST)
From: zhouquan@iscas.ac.cn
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: oleg@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	shuah@kernel.org,
	charlie@rivosinc.com,
	zhouquan@iscas.ac.cn
Subject: [RFC PATCH 1/2] riscv: Expose orig_a0 in the user_regs_struct structure
Date: Wed, 19 Jun 2024 10:01:27 +0800
Message-Id: <d4c7da80b72375c75836303bc744e4db9eeec218.1718693532.git.zhouquan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718693532.git.zhouquan@iscas.ac.cn>
References: <cover.1718693532.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHjeX3O3JmKoWbEQ--.13480S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW7WF4rXr4fJF4kKrWfXwb_yoW8Xw1DpF
	Zakwn7KFWrurWvkry7ZF4DWr4UJwn8K343KrWIy34Yv3WUtF45ZrZ3Gw1qyr1fJayvqFyx
	uFySkr98A3WDZ3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU6MKtUUUUU=
X-CM-SenderInfo: 52kr31xxdqqxpvfd2hldfou0/1tbiBwwNBmZyBf6gSQAAsG

From: Quan Zhou <zhouquan@iscas.ac.cn>

Expose orig_a0 to userspace to ensure that users can modify
the actual value of `a0` in the traced process through the
ptrace(PTRACE_SETREGSET, ...) path. Since user_regs_struct is
a subset of pt_regs, we also need to adjust the position of
the orig_a0 field in pt_regs to achieve the correct copy.

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
---
 arch/riscv/include/asm/ptrace.h      | 4 ++--
 arch/riscv/include/uapi/asm/ptrace.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index b5b0adcc85c1..37f48d40ae46 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -45,12 +45,12 @@ struct pt_regs {
 	unsigned long t4;
 	unsigned long t5;
 	unsigned long t6;
+	/* a0 value before the syscall */
+	unsigned long orig_a0;
 	/* Supervisor/Machine CSRs */
 	unsigned long status;
 	unsigned long badaddr;
 	unsigned long cause;
-	/* a0 value before the syscall */
-	unsigned long orig_a0;
 };
 
 #define PTRACE_SYSEMU			0x1f
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index a38268b19c3d..3e37f80cb3e8 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -54,6 +54,8 @@ struct user_regs_struct {
 	unsigned long t4;
 	unsigned long t5;
 	unsigned long t6;
+	/* a0 value before the syscall */
+	unsigned long orig_a0;
 };
 
 struct __riscv_f_ext_state {
-- 
2.34.1


