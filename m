Return-Path: <linux-kselftest+bounces-44476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A93C2320E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AC2C347D88
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC93064B9;
	Fri, 31 Oct 2025 03:12:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3891D1373;
	Fri, 31 Oct 2025 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880361; cv=none; b=F0Rhl2zFo/SZLMtUWrLLPHyGiaR9IXP7V3Z6P3R+1sOBdZZKJjFEsdOksevVaF2/R3nTcSrS4Of/cX5RpyqVWVzPHKwa7Gjgd6b9YVj6ZhbRzW8V/iuAeccncekgvxbh7ueE6H/3nPjwTTyteI/J7s9UqEbfXNCvJfDjYx0gW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880361; c=relaxed/simple;
	bh=pAhQEBocaEEOblK1oHdDixREaBMzTRKDELgX7YTiN3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+5uQBHizsw3pBGlfASNEmOjzkNgzEB+mgiaSPvC4wqbpvzho4NbIMwhH4oIzHkvT7o6YCK3bix7C2womVUb5AIS9kTiZ0k0bLJ+3j22G4+jaX35b9Av2jUq2NrQF3VT3tDMf2pJRABIPJzYuZyHmoNEyB+N++UL8lr+GCfbRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxO9IhKQRpl+wcAA--.62905S3;
	Fri, 31 Oct 2025 11:12:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxysAbKQRpGMkeAQ--.13727S3;
	Fri, 31 Oct 2025 11:12:31 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/6] KVM: LoongArch: selftests: Add system registers save and restore on exception
Date: Fri, 31 Oct 2025 11:12:22 +0800
Message-Id: <20251031031227.4020738-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251031031227.4020738-1-maobibo@loongson.cn>
References: <20251031031227.4020738-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxysAbKQRpGMkeAQ--.13727S3
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
index 88bfa505c6f5..616d1905097d 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/exception.S
+++ b/tools/testing/selftests/kvm/lib/loongarch/exception.S
@@ -51,8 +51,14 @@ handle_exception:
 	st.d   t0, sp, ESTAT_OFFSET_EXREGS
 	csrrd  t0, LOONGARCH_CSR_BADV
 	st.d   t0, sp, BADV_OFFSET_EXREGS
+	csrrd  t0, LOONGARCH_CSR_PRMD
+	st.d   t0, sp, PRMD_OFFSET_EXREGS
 
 	or     a0, sp, zero
+	ld.d   t0, sp, PC_OFFSET_EXREGS
+	csrwr  t0, LOONGARCH_CSR_ERA
+	ld.d   t0, sp, PRMD_OFFSET_EXREGS
+	csrwr  t0, LOONGARCH_CSR_PRMD
 	bl route_exception
 	restore_gprs sp
 	csrrd  sp, LOONGARCH_CSR_KS0
-- 
2.39.3


