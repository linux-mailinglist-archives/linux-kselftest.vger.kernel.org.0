Return-Path: <linux-kselftest+bounces-7064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E48F8967CB
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D838D28B544
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4154312A15B;
	Wed,  3 Apr 2024 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GjXjuL1Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2701292D7
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131547; cv=none; b=ThDF93FAeBPHe3wZR4RKau4X+qKQNUzNbvtsDPdDbjocSTs2PRg0PBmIfsM8q7+sASc+PqMI6432z5jRzQnUqbBTU3m2De1/PZHg8BhpEENjGmx9s9uBawsA0qG1ple2PxpyzMqOdMoYPLU6Trh2fnT/7wXiKbCIgVbC1NH3/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131547; c=relaxed/simple;
	bh=BAJjj9DUFC41oCUghV1zdmiJwIpGKHSqJMMsbfwWnaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Npl9txjz11n4qW5jxa62Pq4mdB2zzomQx3z16nsRemA1yIz9fglz02nfBh9YwjqLgzqrtuB03wgrrLfYWb62q9Rqk4a3/Ydx2/FMFmnJ9DAFiM1lvy0LP/s7lyOfOgH0IYHJ14qqllxj2LIAsACyFHO0paxJDCLsYhACKw7Uufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GjXjuL1Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e0ae065d24so51513725ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131545; x=1712736345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKKIkxhVPzlR31GWSQWSWFD216hXiUzA8utaOE+u8sQ=;
        b=GjXjuL1Zw90DuXBP2Bwb4uoBEPovPetVR1iMXta2j104mzYBQTmzanz18Wt7KN1lIS
         GeGuqOeDXqAd8PK4vdYDXbBDqYcxbe0XWickXEaGGn/o6UShGJ7W+/EoZvf9YYGw3+eA
         lYy0CC+e5bcZXE+hzDrE6rCIAW9/Jv0kDAHUbPMy3MvbV3vEtwou0fb4kUF0YtaH2Cv5
         dIA6+P+ZcUNLYdmDYp7qcLbAcsycu3IsVLmM2hKT2Q+0sBb13ONEMEsJ95mX3dQrdz5g
         OYXoYoqeN405t2KuWrflXkoeB1Akx7mOdV0RrdxZE/fs5LMe9QoWWDtmNWYmVqt0tYZh
         xFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131545; x=1712736345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKKIkxhVPzlR31GWSQWSWFD216hXiUzA8utaOE+u8sQ=;
        b=Mz2sht28IgI7vGDIpPDsvWNNYCoTeY5wVjOt8fkSNms3E1vcGQMAKp0s14aPjY8JHo
         Z6b2nRF0QeON0FpvQUBkcdDL8owt0mjzlNXGGdRwhC2SDLfyXTTKJKSwaZSIdsa6+0cq
         3LsMU6a/NkexgG2U1SUUUiCZhfhjTwwrmtW/bMS26CHhW0gWNYRrXwjXlMNYEJ6xTbs1
         wjmWo59QFGfL7zs4pmP40hClnQlNeb+jpqXarCH3OufIxDMWYqnJ636ibfwR7cPJxJAq
         Juui+eED1ErL5y/ErrRi9JgO8NCQb2FaF75K7tAC8cIdYg1kn4aBQDEkeQbW0/1udcWY
         D/Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVm846Da+iHZ9U5RqJVhALDyEFrUAQR1R14ha8mU0T+I/aXJG/T/8mnRg9PSEHjws0KrCl+ofCHjOqnqO5apQixX5Ulf3LQVfOBIuIdlwJL
X-Gm-Message-State: AOJu0YwtaRWbsvmF84DtMqya/Z+MOQ5jC2G7G7Lz9XC2gsIFeURZTuof
	I7065LCvnt2Rc4WKU6NcUiK8wrJsZQliOU4CMrHhbH23Ahd24mrY8mB/jFhSwVU=
X-Google-Smtp-Source: AGHT+IEHII7tSGtUqO5wpO59JDooIKUZaJc45tvRQjDzAvEN2jSXssf4AqTMGpJ/lHoLRFAsmkx1xA==
X-Received: by 2002:a17:902:bf04:b0:1e0:115c:e03c with SMTP id bi4-20020a170902bf0400b001e0115ce03cmr11696876plb.53.1712131545155;
        Wed, 03 Apr 2024 01:05:45 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:44 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v5 16/22] KVM: riscv: selftests: Move sbi definitions to its own header file
Date: Wed,  3 Apr 2024 01:04:45 -0700
Message-Id: <20240403080452.1007601-17-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI definitions will continue to grow. Move the sbi related
definitions to its own header file from processor.h

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../selftests/kvm/include/riscv/processor.h   | 39 ---------------
 .../testing/selftests/kvm/include/riscv/sbi.h | 50 +++++++++++++++++++
 .../selftests/kvm/include/riscv/ucall.h       |  1 +
 tools/testing/selftests/kvm/steal_time.c      |  4 +-
 4 files changed, 54 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/riscv/sbi.h

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index ce473fe251dd..3b9cb39327ff 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -154,45 +154,6 @@ void vm_install_interrupt_handler(struct kvm_vm *vm, exception_handler_fn handle
 #define PGTBL_PAGE_SIZE				PGTBL_L0_BLOCK_SIZE
 #define PGTBL_PAGE_SIZE_SHIFT			PGTBL_L0_BLOCK_SHIFT
 
-/* SBI return error codes */
-#define SBI_SUCCESS				0
-#define SBI_ERR_FAILURE				-1
-#define SBI_ERR_NOT_SUPPORTED			-2
-#define SBI_ERR_INVALID_PARAM			-3
-#define SBI_ERR_DENIED				-4
-#define SBI_ERR_INVALID_ADDRESS			-5
-#define SBI_ERR_ALREADY_AVAILABLE		-6
-#define SBI_ERR_ALREADY_STARTED			-7
-#define SBI_ERR_ALREADY_STOPPED			-8
-
-#define SBI_EXT_EXPERIMENTAL_START		0x08000000
-#define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
-
-#define KVM_RISCV_SELFTESTS_SBI_EXT		SBI_EXT_EXPERIMENTAL_END
-#define KVM_RISCV_SELFTESTS_SBI_UCALL		0
-#define KVM_RISCV_SELFTESTS_SBI_UNEXP		1
-
-enum sbi_ext_id {
-	SBI_EXT_BASE = 0x10,
-	SBI_EXT_STA = 0x535441,
-};
-
-enum sbi_ext_base_fid {
-	SBI_EXT_BASE_PROBE_EXT = 3,
-};
-
-struct sbiret {
-	long error;
-	long value;
-};
-
-struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
-			unsigned long arg1, unsigned long arg2,
-			unsigned long arg3, unsigned long arg4,
-			unsigned long arg5);
-
-bool guest_sbi_probe_extension(int extid, long *out_val);
-
 static inline void local_irq_enable(void)
 {
 	csr_set(CSR_SSTATUS, SR_SIE);
diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
new file mode 100644
index 000000000000..ba04f2dec7b5
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RISC-V SBI specific definitions
+ *
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#ifndef SELFTEST_KVM_SBI_H
+#define SELFTEST_KVM_SBI_H
+
+/* SBI return error codes */
+#define SBI_SUCCESS				 0
+#define SBI_ERR_FAILURE				-1
+#define SBI_ERR_NOT_SUPPORTED			-2
+#define SBI_ERR_INVALID_PARAM			-3
+#define SBI_ERR_DENIED				-4
+#define SBI_ERR_INVALID_ADDRESS			-5
+#define SBI_ERR_ALREADY_AVAILABLE		-6
+#define SBI_ERR_ALREADY_STARTED			-7
+#define SBI_ERR_ALREADY_STOPPED			-8
+
+#define SBI_EXT_EXPERIMENTAL_START		0x08000000
+#define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
+
+#define KVM_RISCV_SELFTESTS_SBI_EXT		SBI_EXT_EXPERIMENTAL_END
+#define KVM_RISCV_SELFTESTS_SBI_UCALL		0
+#define KVM_RISCV_SELFTESTS_SBI_UNEXP		1
+
+enum sbi_ext_id {
+	SBI_EXT_BASE = 0x10,
+	SBI_EXT_STA = 0x535441,
+};
+
+enum sbi_ext_base_fid {
+	SBI_EXT_BASE_PROBE_EXT = 3,
+};
+
+struct sbiret {
+	long error;
+	long value;
+};
+
+struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
+			unsigned long arg1, unsigned long arg2,
+			unsigned long arg3, unsigned long arg4,
+			unsigned long arg5);
+
+bool guest_sbi_probe_extension(int extid, long *out_val);
+
+#endif /* SELFTEST_KVM_SBI_H */
diff --git a/tools/testing/selftests/kvm/include/riscv/ucall.h b/tools/testing/selftests/kvm/include/riscv/ucall.h
index be46eb32ec27..a695ae36f3e0 100644
--- a/tools/testing/selftests/kvm/include/riscv/ucall.h
+++ b/tools/testing/selftests/kvm/include/riscv/ucall.h
@@ -3,6 +3,7 @@
 #define SELFTEST_KVM_UCALL_H
 
 #include "processor.h"
+#include "sbi.h"
 
 #define UCALL_EXIT_REASON       KVM_EXIT_RISCV_SBI
 
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index bae0c5026f82..2ff82c7fd926 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -11,7 +11,9 @@
 #include <pthread.h>
 #include <linux/kernel.h>
 #include <asm/kvm.h>
-#ifndef __riscv
+#ifdef __riscv
+#include "sbi.h"
+#else
 #include <asm/kvm_para.h>
 #endif
 
-- 
2.34.1


