Return-Path: <linux-kselftest+bounces-39498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5E0B2FBF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A93DAE6ABE
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00932EDD51;
	Thu, 21 Aug 2025 14:02:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589F25487A;
	Thu, 21 Aug 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784924; cv=none; b=B3mij76fRRIF4PiktvDMT92VCjw/ul4Gq7/A+qvc6rLru+FT8LbwwXFA810YATOO3B+H4O2UwB8TFJXBuqNLq4nQrIC4IClWgnxIw1a7yILZM8TKtqkIwgZHp+H/Y3Jahi8NmYAjA2KzglX7qmGoKsjWDyiEyFLSUBl09hMdj3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784924; c=relaxed/simple;
	bh=phIJMcgQ6E84sL2C/Ac8Pje97s1BQGqkugomBSZrM8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B995JFbWyT9xZcZzGhTo+JQZtaFJx7gYGQGgEF9AmfaGh7nfUiaCs/BetfYivMlvy174QpmHDIJGFFjKJhp//booRLWBrTn24w7bX/g2CvONK1HidGn/40sCkWrXCiP5SXHFRzzikdcA6i1cdZQVs46T7s9kj6S4pQVnF6FcBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from ROG.lan (unknown [118.251.176.166])
	by APP-03 (Coremail) with SMTP id rQCowABn+Xq+JqdoP8MTDg--.22469S3;
	Thu, 21 Aug 2025 22:01:38 +0800 (CST)
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
Subject: [PATCH v1 RESEND 1/5] dt-bidings: riscv: add Zilsd and Zclsd extension descriptions
Date: Thu, 21 Aug 2025 22:01:27 +0800
Message-Id: <20250821140131.225756-2-pincheng.plct@isrc.iscas.ac.cn>
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
X-CM-TRANSID:rQCowABn+Xq+JqdoP8MTDg--.22469S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4ftF48uw17Ww1fCr15Jwb_yoW8tF1rpF
	s3GF1kKas0q3W3ur97tw4xuw15ZF1vqw45AFZFy34xKFZ0yry0qrWay3W5Z3WrCF4xAFyU
	ua1jgr17ZrsrAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
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
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRuq2MUUUUU
X-CM-SenderInfo: pslquxhhqjh1xofwqxxvufhxpvfd2hldfou0/

Add descriptions for the Zilsd (Load/Store pair instructions) and
Zclsd (Compressed Load/Store pair instructions) ISA extensions
which were ratified in commit f88abf1 ("Integrating load/store
pair for RV32 with the main manual") of the riscv-isa-manual.

Signed-off-by: Pincheng Wang <pincheng.plct@isrc.iscas.ac.cn>
---
 .../devicetree/bindings/riscv/extensions.yaml | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ede6a58ccf53..d72ffe8f6fa7 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -366,6 +366,20 @@ properties:
             guarantee on LR/SC sequences, as ratified in commit b1d806605f87
             ("Updated to ratified state.") of the riscv profiles specification.
 
+        - const: zilsd
+          description:
+            The standard Zilsd extension which provides support for aligned
+            register-pair load and store operations in 32-bit instruction
+            encodings, as ratified in commit f88abf1 ("Integrating
+            load/store pair for RV32 with the main manual") of riscv-isa-manual.
+
+        - const: zclsd
+          description:
+            The Zclsd extension implements the compressed (16-bit) version of the
+            Load/Store Pair for RV32. As with Zilsd, this extension was ratified
+            in commit f88abf1 ("Integrating load/store pair for RV32 with the
+            main manual") of riscv-isa-manual.
+
         - const: zk
           description:
             The standard Zk Standard Scalar cryptography extension as ratified
@@ -847,6 +861,16 @@ properties:
             anyOf:
               - const: v
               - const: zve32x
+      # Zclsd depends on Zilsd and Zca
+      - if:
+          contains:
+            anyOf:
+              - const: zclsd
+        then:
+          contains:
+            anyOf:
+              - const: zilsd
+              - const: zca
 
 allOf:
   # Zcf extension does not exist on rv64
@@ -864,6 +888,21 @@ allOf:
           not:
             contains:
               const: zcf
+  # Zilsd extension does not exist on rv64
+  - if:
+      properties:
+        riscv,isa-extensions:
+          contains:
+            const: zilsd
+        riscv,isa-base:
+          contains:
+            const: rv64i
+    then:
+      properties:
+        riscv,isa-extensions:
+          not:
+            contains:
+              const: zilsd
 
 additionalProperties: true
 ...
-- 
2.39.5


