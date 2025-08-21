Return-Path: <linux-kselftest+bounces-39499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D014B2FBE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF50DAC1532
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C498D2EDD76;
	Thu, 21 Aug 2025 14:02:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CBF2DF6E9;
	Thu, 21 Aug 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784925; cv=none; b=J3/9pQJsJNLKz0YqmUd6u/LSKYUFqZpAVGf7w3bcQw+RtYd5pBkBZHpikEtho8flmKziW+TsZeJECcgGEW627dlgyFEYVprcByx9LTRkMt1tRxR1zvbQ2631ayyKK4rNcJd7jWnZsMjayxla0ATQefDJWvJ/+oxq6qCbUcpWZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784925; c=relaxed/simple;
	bh=QfKglcNTiER5SkUTfpeoOIwgphzbq95FQJpRkGDKQOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LgBhnFTW/HJ+BGvnAOHkN/zMkTTAdjIxeePFyWdWeOQOru9/Fmbdeqod0Mi6oBPqAkpqNe6+jv0m1OcmkdHCBq52EL/GbGnkLJyR7FnzH+AUdJaMJ+qTy6xh6Glec5gQl71NH6BZ2iUDRZiKtkrb04tW6QZGvhvnBHzhdJkfW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from ROG.lan (unknown [118.251.176.166])
	by APP-03 (Coremail) with SMTP id rQCowABn+Xq+JqdoP8MTDg--.22469S5;
	Thu, 21 Aug 2025 22:01:43 +0800 (CST)
From: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	anup@brainfault.org,
	pbonzini@redhat.com,
	shuah@kernel.org,
	cyan.yang@sifive.com,
	cleger@rivosinc.com,
	charlie@rivosinc.com,
	cuiyunhui@bytedance.com,
	samuel.holland@sifive.com,
	namcao@linutronix.de,
	jesse@rivosinc.com,
	inochiama@gmail.com,
	yongxuan.wang@sifive.com,
	ajones@ventanamicro.com,
	parri.andrea@gmail.com,
	mikisabate@gmail.com,
	yikming2222@gmail.com,
	thomas.weissschuh@linutronix.de
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	pincheng.plct@isrc.iscas.ac.cn
Subject: [PATCH v1 RESEND 3/5] riscv: hwprobe: export Zilsd and Zclsd ISA extensions
Date: Thu, 21 Aug 2025 22:01:29 +0800
Message-Id: <20250821140131.225756-4-pincheng.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821140131.225756-1-pincheng.plct@isrc.iscas.ac.cn>
References: <20250821140131.225756-1-pincheng.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABn+Xq+JqdoP8MTDg--.22469S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4kJw1rKr13Jw1rXw18Krg_yoW5XFyxpF
	4DWrs3WFZ8Ca1xCFZ7KF48urykA3Z7Kw4agF12k3yUXFW7ZrWrJ3sxtanIyr1jqFyFva9Y
	gF1FkrZ5t39rArUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRuksqUUUUU
X-CM-SenderInfo: pslquxhhqjh1xofwqxxvufhxpvfd2hldfou0/

Export Zilsd and Zclsd ISA extensions through hwprobe.

Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
---
 Documentation/arch/riscv/hwprobe.rst  | 8 ++++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 2aa9be272d5d..538ab6c08f7b 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -275,6 +275,14 @@ The following keys are defined:
        ratified in commit 49f49c842ff9 ("Update to Rafified state") of
        riscv-zabha.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZILSD`: The Zilsd extension is supported as
+       defined in the RISC-V ISA manual starting from commit f88abf1("Integrating
+       load/store pair for RV32 with the main manual") of the riscv-isa-manual.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZCLSD`: The Zclsd extension is supported as
+       defined in the RISC-V ISA manual starting from commit f88abf1("Integrating
+       load/store pair for RV32 with the main manual") of the riscv-isa-manual.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
      :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
      mistakenly classified as a bitmask rather than a value.
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index aaf6ad970499..e086179bb4fa 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -82,6 +82,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 56)
 #define		RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 57)
 #define		RISCV_HWPROBE_EXT_ZABHA		(1ULL << 58)
+#define 	RISCV_HWPROBE_EXT_ZILSD 	(1ULL << 59)
+#define 	RISCV_HWPROBE_EXT_ZCLSD 	(1ULL << 60)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 0b170e18a2be..12f4b68ad2ac 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -111,6 +111,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCA);
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
+		EXT_KEY(ZCLSD);
 		EXT_KEY(ZICBOM);
 		EXT_KEY(ZICBOZ);
 		EXT_KEY(ZICNTR);
@@ -119,6 +120,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZIHINTPAUSE);
 		EXT_KEY(ZIHPM);
 		EXT_KEY(ZIMOP);
+		EXT_KEY(ZILSD);
 		EXT_KEY(ZKND);
 		EXT_KEY(ZKNE);
 		EXT_KEY(ZKNH);
-- 
2.39.5


