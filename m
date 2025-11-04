Return-Path: <linux-kselftest+bounces-44709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7328CC30C34
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 12:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049B5189A71C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347CA2E9722;
	Tue,  4 Nov 2025 11:37:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934342E8E01;
	Tue,  4 Nov 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256231; cv=none; b=Kf3QL9dwEsLJBiaOnJAW0CpxJJvsHYC/uOtxu9acME3QpOPkI+QXOtSpODwNrxggqkNnGulmYjbJ3uaSbfMa24SnVYU6jc9B8ykaWe3FpQ1USIJfeP+uC/d5lVDru86FX+Fij3glksZM9eboqkZBkw33O8spi5C6b2ms436tkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256231; c=relaxed/simple;
	bh=/eL7qO9Bg4rxngtC4qoLPKMphY8SvbMqkKlEZehmPKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LLW+o3PHKodvpb1nmUij0pxJXJ5T4DkVj2tjt47vvJUwcaFrVQuN2bmbb+gDNQOLcpz+PvQXvlPWirTZKAxv4bv74E1IrNlw3UI2NKOlUJuiozjbpbbRJ6h8Uy3oQ9x+13WYk87Dpz0IIrwPL0Ux0sdWIdEcaqQ1xyyZpPT41Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxM9Bg5QlpYbQeAA--.1385S3;
	Tue, 04 Nov 2025 19:37:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDx_8Nc5QlpQTImAQ--.54832S3;
	Tue, 04 Nov 2025 19:37:04 +0800 (CST)
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
Subject: [PATCH v2 1/7] KVM: LoongArch: selftests: Add system registers save and restore on exception
Date: Tue,  4 Nov 2025 19:36:53 +0800
Message-Id: <20251104113700.1561752-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251104113700.1561752-1-maobibo@loongson.cn>
References: <20251104113700.1561752-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx_8Nc5QlpQTImAQ--.54832S3
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


