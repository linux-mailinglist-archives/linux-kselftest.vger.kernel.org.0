Return-Path: <linux-kselftest+bounces-46068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7148C72815
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59E304F3866
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 07:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E794A3016F0;
	Thu, 20 Nov 2025 06:58:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A384301014;
	Thu, 20 Nov 2025 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621905; cv=none; b=E2a/ozUJwtRodQozH8SECzMJpCe3xtJfBUYCZxwxTu0n26eg9wfp3QrwCjG8iCC0pxnoniJT1FnN1RlucXms/IbTfVWRTJM7L4sAb3x+CBoivCJsfxIxpVPTp3LAFSMPKBuTVWdqG0NO50Gd70JDnM6AIK1mBsQw+2ONkFeb288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621905; c=relaxed/simple;
	bh=/eL7qO9Bg4rxngtC4qoLPKMphY8SvbMqkKlEZehmPKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bH+Kt7sfX913ZX9n7UbB3rJ4o4QchwNGvcAyPPKI7/X6MByO8EkKcXUjecmPOhRae3Xm6CvWq0oew+b0eCE6ooRyo5GGMVAMVDv8CMNegxHv5MdCH4jPbdnNgyEeRQZ2FWM9MgGjPHQAf0T8SiUtIzracFqXYjJDaaYtH2Idpks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxbb8EvB5p9_4lAA--.15298S3;
	Thu, 20 Nov 2025 14:58:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxicD3ux5pSkU5AQ--.5850S3;
	Thu, 20 Nov 2025 14:58:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/6] KVM: LoongArch: selftests: Add system registers save and restore on exception
Date: Thu, 20 Nov 2025 14:57:53 +0800
Message-Id: <20251120065758.3064368-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251120065758.3064368-1-maobibo@loongson.cn>
References: <20251120065758.3064368-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxicD3ux5pSkU5AQ--.5850S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

When system returns from exception with ertn instruction, PC comes
from LOONGARCH_CSR_ERA, and CSR_CRMD comes LOONGARCH_CSR_PRMD.

Here save CSR register CSR_ERA and CSR_PRMD in stack, and restore them
from stack. So it can be modified by exception handler in future.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tools/testing/selftests/kvm/include/loongarch/processor.h | 5 ++++-
 tools/testing/selftests/kvm/lib/loongarch/exception.S     | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
index 6427a3275e6a..374caddfb0db 100644
--- a/tools/testing/selftests/kvm/include/loongarch/processor.h
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -124,18 +124,21 @@ struct ex_regs {
 	unsigned long pc;
 	unsigned long estat;
 	unsigned long badv;
+	unsigned long prmd;
 };
 
 #define PC_OFFSET_EXREGS		offsetof(struct ex_regs, pc)
 #define ESTAT_OFFSET_EXREGS		offsetof(struct ex_regs, estat)
 #define BADV_OFFSET_EXREGS		offsetof(struct ex_regs, badv)
+#define PRMD_OFFSET_EXREGS		offsetof(struct ex_regs, prmd)
 #define EXREGS_SIZE			sizeof(struct ex_regs)
 
 #else
 #define PC_OFFSET_EXREGS		((EXREGS_GPRS + 0) * 8)
 #define ESTAT_OFFSET_EXREGS		((EXREGS_GPRS + 1) * 8)
 #define BADV_OFFSET_EXREGS		((EXREGS_GPRS + 2) * 8)
-#define EXREGS_SIZE			((EXREGS_GPRS + 3) * 8)
+#define PRMD_OFFSET_EXREGS		((EXREGS_GPRS + 3) * 8)
+#define EXREGS_SIZE			((EXREGS_GPRS + 4) * 8)
 #endif
 
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/lib/loongarch/exception.S b/tools/testing/selftests/kvm/lib/loongarch/exception.S
index 88bfa505c6f5..3f1e4b67c5ae 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/exception.S
+++ b/tools/testing/selftests/kvm/lib/loongarch/exception.S
@@ -51,9 +51,15 @@ handle_exception:
 	st.d   t0, sp, ESTAT_OFFSET_EXREGS
 	csrrd  t0, LOONGARCH_CSR_BADV
 	st.d   t0, sp, BADV_OFFSET_EXREGS
+	csrrd  t0, LOONGARCH_CSR_PRMD
+	st.d   t0, sp, PRMD_OFFSET_EXREGS
 
 	or     a0, sp, zero
 	bl route_exception
+	ld.d   t0, sp, PC_OFFSET_EXREGS
+	csrwr  t0, LOONGARCH_CSR_ERA
+	ld.d   t0, sp, PRMD_OFFSET_EXREGS
+	csrwr  t0, LOONGARCH_CSR_PRMD
 	restore_gprs sp
 	csrrd  sp, LOONGARCH_CSR_KS0
 	ertn
-- 
2.39.3


