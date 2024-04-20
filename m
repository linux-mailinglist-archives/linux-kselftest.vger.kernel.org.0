Return-Path: <linux-kselftest+bounces-8504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC868AB7DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 01:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49B51F21ED0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 23:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092DE14F123;
	Fri, 19 Apr 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hynTKEUE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA914BFBC
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 23:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713570502; cv=none; b=Zm3sVfg9fDcGkZFMUNLwkeHzjF9rEKzcgRmiFPSUql3PJT1Y7Pg3xOk8DEsPCxeEqGPJOOYLAnSPsyYlulWhbqvauNsLpKekAu2JWPkC/xz84zxpdA0mZDJ78RZ0KcUk1KIeVp8b5PVv/bfd1qO4x/8lYAqfi2Qi/1Cm9mB7m/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713570502; c=relaxed/simple;
	bh=XaYtSkDqV2Gk6SkR/vZ7T7PA/8MDDP7ooY8/f+ym4MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YSBgfcfgYxbtuYFDAa9Mn4T//YhmrE7btbF8foyO2BmdK62H9k76TKmyhwosnJSUKnW6/AtoTJFDw3OEJmDU/Wa0E10rTcmm3vtLFkHRVrZqWhfYKqbkuiGkuDkkm9KPyu/iAt+kuqh0pqLJ5qV4NbEem2tMwpfOyav+Eqfp1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hynTKEUE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e5c7d087e1so23566605ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713570501; x=1714175301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9soA5cn4wIINjbEEbaSFa4z0U18KoF+cjavdbqPH+4=;
        b=hynTKEUEoIGX/tQReH2E0haucsJSmyTUPQRazvr5cpsIvqsvy2t68CUcSdXJ3WgIzt
         4hSrEe12CRAEq8fZoPmxnp9/gqyCWWMRY63kX8YfDSkuHxj+zz0z9OOGt1fDKWPhlUEb
         EoonxUsbDQ6MJ/hLq/gojzto0YJM2GPiBRgzgFbQmnCyAfV9IxFFSVMgSiHWg69Qb2v+
         UL2SZJKlRe7ZK1TGY190wWOQ8hbVWeZI3HmxBBBrjQ02wCNSQi6wUykcouBew7jY8Nyw
         Ggg46xuH3PPNykhJMG1oly3kvYoMlLY0if+b5yxXGtEQ0i5E6ZgkJhruXiBFbUOHqIKm
         0pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713570501; x=1714175301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9soA5cn4wIINjbEEbaSFa4z0U18KoF+cjavdbqPH+4=;
        b=XD2TlPGRj7q85YBZTubV2fh4u/t5HDJupsxbUhiR22l/dKyyO49uSrKcd4bpvC1AoW
         hbOZQT2TBhaws7nk6bQGYpSNqTc44PCKsMMcpQtXtidam5Q3d96aGwurIVQ6f7M4mMZC
         /t8T7CmugxMr72lRfOZRzv4mqfDjYty563WyOSggO7bs6ADizGtVjLPEVbioBN6lWcCo
         suwP7Pxgui3UOBMEvQDbu9cObGxezYXiMz/LgKVXFW5BDQASVTmWSo4AiC/PHQHc/Aw5
         HOJr152xUjWa7u3P7WF7ul/CEwwIdB+R+fr6H9LMm/peFaUxSc+GS+QZx98fixeriKb/
         HD1A==
X-Forwarded-Encrypted: i=1; AJvYcCW1640qnuyciA96VGDIoieMkH2IDtEFMI5OzPXRK2JkpwF+zAt0TEZgZ/X/KISNA5irFlEsZNN5/bbMFmcMLdqnkAy4fMZ8OPaP9U3i+xOH
X-Gm-Message-State: AOJu0YykvCXq91mHlFugyO+OTbfYQ5lfgT+2tVjJcsWqnS6mNsisRqP3
	EJtW/lBQ8Fke56wgOj9LyluO1iwq7TvI+hYYL3HsHpN+tOWD2xZ9oGVDbB0H4gw=
X-Google-Smtp-Source: AGHT+IExX7jSBzI9snc8ZpgJeYyDpP9nMeKJ6Hd3nM6HLbB59ikb+ctX7/mUd/kE+BrHwRoKJsb1xA==
X-Received: by 2002:a17:902:edc4:b0:1e5:1108:af1b with SMTP id q4-20020a170902edc400b001e51108af1bmr3327140plk.22.1713570501082;
        Fri, 19 Apr 2024 16:48:21 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm3924017plw.85.2024.04.19.16.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 16:48:20 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	samuel.holland@sifive.com,
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
Subject: [PATCH v8 20/24] KVM: riscv: selftests: Add SBI PMU extension definitions
Date: Sat, 20 Apr 2024 08:17:36 -0700
Message-Id: <20240420151741.962500-21-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420151741.962500-1-atishp@rivosinc.com>
References: <20240420151741.962500-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI PMU extension definition is required for upcoming SBI PMU
selftests.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 .../testing/selftests/kvm/include/riscv/sbi.h | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/sbi.h b/tools/testing/selftests/kvm/include/riscv/sbi.h
index ba04f2dec7b5..6675ca673c77 100644
--- a/tools/testing/selftests/kvm/include/riscv/sbi.h
+++ b/tools/testing/selftests/kvm/include/riscv/sbi.h
@@ -29,17 +29,83 @@
 enum sbi_ext_id {
 	SBI_EXT_BASE = 0x10,
 	SBI_EXT_STA = 0x535441,
+	SBI_EXT_PMU = 0x504D55,
 };
 
 enum sbi_ext_base_fid {
 	SBI_EXT_BASE_PROBE_EXT = 3,
 };
+enum sbi_ext_pmu_fid {
+	SBI_EXT_PMU_NUM_COUNTERS = 0,
+	SBI_EXT_PMU_COUNTER_GET_INFO,
+	SBI_EXT_PMU_COUNTER_CFG_MATCH,
+	SBI_EXT_PMU_COUNTER_START,
+	SBI_EXT_PMU_COUNTER_STOP,
+	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
+	SBI_EXT_PMU_SNAPSHOT_SET_SHMEM,
+};
+
+union sbi_pmu_ctr_info {
+	unsigned long value;
+	struct {
+		unsigned long csr:12;
+		unsigned long width:6;
+#if __riscv_xlen == 32
+		unsigned long reserved:13;
+#else
+		unsigned long reserved:45;
+#endif
+		unsigned long type:1;
+	};
+};
 
 struct sbiret {
 	long error;
 	long value;
 };
 
+/** General pmu event codes specified in SBI PMU extension */
+enum sbi_pmu_hw_generic_events_t {
+	SBI_PMU_HW_NO_EVENT			= 0,
+	SBI_PMU_HW_CPU_CYCLES			= 1,
+	SBI_PMU_HW_INSTRUCTIONS			= 2,
+	SBI_PMU_HW_CACHE_REFERENCES		= 3,
+	SBI_PMU_HW_CACHE_MISSES			= 4,
+	SBI_PMU_HW_BRANCH_INSTRUCTIONS		= 5,
+	SBI_PMU_HW_BRANCH_MISSES		= 6,
+	SBI_PMU_HW_BUS_CYCLES			= 7,
+	SBI_PMU_HW_STALLED_CYCLES_FRONTEND	= 8,
+	SBI_PMU_HW_STALLED_CYCLES_BACKEND	= 9,
+	SBI_PMU_HW_REF_CPU_CYCLES		= 10,
+
+	SBI_PMU_HW_GENERAL_MAX,
+};
+
+/* SBI PMU counter types */
+enum sbi_pmu_ctr_type {
+	SBI_PMU_CTR_TYPE_HW = 0x0,
+	SBI_PMU_CTR_TYPE_FW,
+};
+
+/* Flags defined for config matching function */
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
+#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
+#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
+
+/* Flags defined for counter start function */
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
+#define SBI_PMU_START_FLAG_INIT_SNAPSHOT BIT(1)
+
+/* Flags defined for counter stop function */
+#define SBI_PMU_STOP_FLAG_RESET BIT(0)
+#define SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT BIT(1)
+
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
-- 
2.34.1


