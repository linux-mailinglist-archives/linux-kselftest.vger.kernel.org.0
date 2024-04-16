Return-Path: <linux-kselftest+bounces-8193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F37428A7374
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 20:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98F828458D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1292B13957C;
	Tue, 16 Apr 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yjRaKnHf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9813848F
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293089; cv=none; b=chLrF8afom9XiebQAlf/XCfjjopdLwdMV26lXshLwRFl3PY4lpU7N6T8OawR5mkEVDznYHvBAOf5fpRVwpBjimaHLwKyRIeka5EvA9VN6zlDLR/pHuisHY0f2qfzqsIQYnmN9l51xFJs5MAOg5sjL8ffxh0F4bnrybaO7zYy8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293089; c=relaxed/simple;
	bh=J8TrFuN//G6PmUvmCaqpAzaTIpoKbVOHs/yKTawHfLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pR8kAxQWyOih+I5AGzvIz7MFhMmwX2LE6IKOrCADGdZFJF/YRlOHWI4mIcBT+fHqJxoPZiOLp/fPlfv3hyg+F0cME0wtdBcIU2khR7RokEJF97ecckQekiKJimrssQMIaXd8ZPVQ4usuq9/UIn20Cf7IT3H0JMXGrW4HnZIBNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yjRaKnHf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5f769fd2bd0so1200701a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293087; x=1713897887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITt+KwUVR5JlR3QMHjofp/8j27l4zwoSN907Yn7Ybbg=;
        b=yjRaKnHf+GpGr5M6pgOHlhLt0GqXvQhiIAxcCO2kjXoYjQR5NHbM9NXFo+lCUfsamz
         l8GDHnO4crgCMchdBzNawcTCn+uZWJ0O5F8abDay9RmvJnb71jmUfYdcIoqMMXWGzoOI
         UBEGgJZsZcf6D/iHOHOXcoaGpHaqeVB9IQwQz885BJbFGYsK/EWMdP7TodMCo3ayrxBu
         iqURbx328xpSleA79JHtqwCZ+QvU4tswYXBiBAsOVZyT/4WSPyKTddGjBkzkqzbQ4V7T
         7+yukKFVA+8zWIZmACbrGpytsk6DcHQcvGt3RXRHr0rbBheC/hf0MqPENQQhx5S+5f2o
         VJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293087; x=1713897887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITt+KwUVR5JlR3QMHjofp/8j27l4zwoSN907Yn7Ybbg=;
        b=EU3PPzMYoNSwxs20jFNuhKCE97qhTMLvxUOFynJVQlYEdlcZvvBpJagMfOeVwgz9s3
         mhWj4jt2yXTiDiFPama9QMjY/ovPFkto60tPe1W6JO2aOGc6XAuyJfB9ddo1ilAnvKRf
         2rwWf2z74D7bZq1iS+hmmlHp4ikb9Cz1bBeYCEPqf65v/tipRNRr7aHoAVlbHHJTInUl
         GRZd4l0vJwt4TiS/8NhKvpySS3kkGeS23wbgIbz4KMNKXsIrjpz/0HbAb1AsayP6EY2F
         7RD3xduDz7lMG4IrPTUDMiY69HbuTBrF02VsLUj/Z5IgOePEU3mFhZvLiPFOtDjlMvis
         qxnw==
X-Forwarded-Encrypted: i=1; AJvYcCUI+LlXmpVqzXFQ/nxMovl+AU7LzEFlbX+/VG5PLslBM6mpegfCB2jefRKcgKw5FhBHLFihvi+D2zt5zF4yzJfQUIGo6dt4FgWTVJiMB9Wh
X-Gm-Message-State: AOJu0YwQJkpbDzJ6etPoCsmxpUwe77uT5J74EvZzA8mNSvkTloPC//PU
	hyTXK9Ld7nFYrx8ss99BxVtwZYDDo8/eY7bRbRVH2Ez3+VL87HMIGC7REPr3xXc=
X-Google-Smtp-Source: AGHT+IEnYtzsA7elyzf5DNngEcjjYE+bmd13QVJzyjcon3lkT0mRIoKa/EFd9tely84aFZU2X/E/ig==
X-Received: by 2002:a17:90a:17af:b0:2a5:4537:ee67 with SMTP id q44-20020a17090a17af00b002a54537ee67mr10405072pja.49.1713293087083;
        Tue, 16 Apr 2024 11:44:47 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:46 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v7 04/24] drivers/perf: riscv: Use BIT macro for shifting operations
Date: Tue, 16 Apr 2024 11:44:01 -0700
Message-Id: <20240416184421.3693802-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is a good practice to use BIT() instead of (1 << x).
Replace the current usages with BIT().

Take this opportunity to replace few (1UL << x) with BIT() as well
for consistency.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 20 ++++++++++----------
 drivers/perf/riscv_pmu_sbi.c |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index ef8311dafb91..4afa2cd01bae 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -233,20 +233,20 @@ enum sbi_pmu_ctr_type {
 #define SBI_PMU_EVENT_IDX_INVALID 0xFFFFFFFF
 
 /* Flags defined for config matching function */
-#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
-#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
-#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
-#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
-#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
-#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
-#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
-#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
+#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
+#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
 
 /* Flags defined for counter start function */
-#define SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
 
 /* Flags defined for counter stop function */
-#define SBI_PMU_STOP_FLAG_RESET (1 << 0)
+#define SBI_PMU_STOP_FLAG_RESET BIT(0)
 
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 1823ffb25d35..f23501898657 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -386,7 +386,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 			cmask = 1;
 		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS) {
 			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
-			cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
+			cmask = BIT(CSR_INSTRET - CSR_CYCLE);
 		}
 	}
 
-- 
2.34.1


