Return-Path: <linux-kselftest+bounces-39497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C501B2FBD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038381D01F2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2FA2475C2;
	Thu, 21 Aug 2025 14:02:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74720298C;
	Thu, 21 Aug 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784923; cv=none; b=UFcXiFJQ4N4a2NWLS9FEntrCduUdImiFKiwgR0u62oewLzVhE8oBwn6L4zuTVfOFDK8cdjIQA8EBb+5ZCPnERzfrmyT7K0MQSHiHZUpv+sBA1wXfkSLP5hxtjt4DI0/sWB7xReUWIel2emwpq8cvmK4PhitFW8EidrJGWJev7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784923; c=relaxed/simple;
	bh=HtF3kKHFg9XwWbNN4HMPRKpFaIvrfyNEuULG2kM8s3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lF0K7VBoG82cv/q8W8PdF5JsHPfK8A2QslBqsAZMp+w9GeuvkufJ4u7IMM9Hgl/c1on9gcvvvoRXI19SfqoGAb5QI61zFZUXKkqVNDbBFhoXFQ9PMGAUSsqk3VQiEA1P1PfdgyA3sD6iWgaWe6LroM5nudxfvcqPgwOf+QRK3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from ROG.lan (unknown [118.251.176.166])
	by APP-03 (Coremail) with SMTP id rQCowABn+Xq+JqdoP8MTDg--.22469S4;
	Thu, 21 Aug 2025 22:01:41 +0800 (CST)
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
Subject: [PATCH v1 RESEND 2/5] riscv: add ISA extension parsing for Zilsd and Zclsd
Date: Thu, 21 Aug 2025 22:01:28 +0800
Message-Id: <20250821140131.225756-3-pincheng.plct@isrc.iscas.ac.cn>
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
X-CM-TRANSID:rQCowABn+Xq+JqdoP8MTDg--.22469S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1rAF1kuFW3Jr15ArykAFb_yoW5GF4kpr
	s5CrWFyrWDJw1fuwsxtrZ5Ww15Xw1UGws8Gw1xWryrJFW7trWfXr1kAa42yanxJFy0qr1Y
	vF1rWrsxZa4UAa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
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
	CTnIWIevJa73UjIFyTuYvjTRu1vVUUUUU
X-CM-SenderInfo: pslquxhhqjh1xofwqxxvufhxpvfd2hldfou0/

Add parsing for Zilsd and Zclsd ISA extensions which were ratified in
commit f88abf1 ("Integrating load/store pair for RV32 with the
main manual") of the riscv-isa-manual.

Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
---
 arch/riscv/include/asm/hwcap.h |  2 ++
 arch/riscv/kernel/cpufeature.c | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index affd63e11b0a..7ad43d12c49f 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -106,6 +106,8 @@
 #define RISCV_ISA_EXT_ZAAMO		97
 #define RISCV_ISA_EXT_ZALRSC		98
 #define RISCV_ISA_EXT_ZICBOP		99
+#define RISCV_ISA_EXT_ZILSD		100
+#define RISCV_ISA_EXT_ZCLSD     101
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 743d53415572..8e7757db3895 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -242,6 +242,28 @@ static int riscv_ext_zcf_validate(const struct riscv_isa_ext_data *data,
 	return -EPROBE_DEFER;
 }
 
+static int riscv_ext_zilsd_validate(const struct riscv_isa_ext_data *data,
+		  const unsigned long *isa_bitmap)
+{
+	if (IS_ENABLED(CONFIG_64BIT))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int riscv_ext_zclsd_validate(const struct riscv_isa_ext_data *data,
+				    const unsigned long *isa_bitmap)
+{
+	if (IS_ENABLED(CONFIG_64BIT))
+		return -EINVAL;
+
+	if (__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZILSD) &&
+		__riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA))
+		return 0;
+
+	return -EPROBE_DEFER;
+}
+
 static int riscv_vector_f_validate(const struct riscv_isa_ext_data *data,
 				   const unsigned long *isa_bitmap)
 {
@@ -483,6 +505,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcd, RISCV_ISA_EXT_ZCD, riscv_ext_zcd_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcf, RISCV_ISA_EXT_ZCF, riscv_ext_zcf_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcmop, RISCV_ISA_EXT_ZCMOP, riscv_ext_zca_depends),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zclsd, RISCV_ISA_EXT_ZCLSD, riscv_ext_zclsd_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zilsd, RISCV_ISA_EXT_ZILSD, riscv_ext_zilsd_validate),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
-- 
2.39.5


