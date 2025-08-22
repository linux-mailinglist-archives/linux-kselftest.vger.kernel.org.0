Return-Path: <linux-kselftest+bounces-39706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A0B321B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD65B5C272C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FED292B3D;
	Fri, 22 Aug 2025 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="OTQZUj1v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1325285C90
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884845; cv=none; b=p9Yj8zq6pfGOWU6QldmyY0CJt+iXNIgUYxk0xvXN/UpSLX6rLfmV/K+qnApiYohsaDIVkY9FLkaMKSXptYv8CDj49+sLEv1clLzZBoyXOq+33G9JEPxnP8/yMxkGe4sm3VfgkcGGffZ0o4EapALgv0YqrpkI+LK6tq0CgLJNsCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884845; c=relaxed/simple;
	bh=3eKPG4TUTR4+0R+9VHkqyjDfcIO6WcWdW7JtEbAMzYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU3dpQhCmF+jpf5+Y4+am7Dd2iOyGI0jgBolZ54J/BMLQP+gb79KbGMT2FJOPlSXzij2WeM1TPTcmAT/J+qABFLWIWg/PAUa15jMRD9t203EtzusS5JEwfiq5IsBW3CPcswb6bIfJhGFoj/QFBxz6awWpDxSETQ/tjGhN5MAknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=OTQZUj1v; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b1099192b0so39196071cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755884842; x=1756489642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfYucjg1h8+O9tUzDFG8M32q+vBz17OTGpTy9qZYkXU=;
        b=OTQZUj1v9NpyD3w5ILfE7N9VGv6YW9/WHMn77bii310dpGoTVyRbNSK7xtcP83IsR8
         +CQPog4T8onKtM6zuZ3alDo+nr5ZiGUXa4Pemo4/Lf7GR8gvnk637iQvvULIBqw0opmX
         I3yWXea7mGx5DqiyhlSXv8T9MRyVuyzNrHb73qSHaCRkpX5A3qIxtRwLnNm6dByhWlUb
         +dE7+KYuDCwMRIoMH948AZ2xU7725O6fF8rZ7r3BzcHhsNl1YiyGnVmJkBIwaWwX1dho
         Gw3d+24AvmRfukzB/05Uu2tzBOFJP383COFWcUFS5nuDcvSkfYsuCWQprWgiRf/C6WtK
         R/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755884842; x=1756489642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfYucjg1h8+O9tUzDFG8M32q+vBz17OTGpTy9qZYkXU=;
        b=Kcv0z1pwFZ1j+dyELDmyMthy6YEGzBJ97AljepQJdu0qqxtsjsgzcWTjzFO37JGE+4
         rNO6JQWquUspjb9gfM2T6TqK+Sv3DxRVfdrXLk+bCgR9cuE9Nor10zmP94g5BYGcytj8
         tSYybLELHbYZh11rcMIflsOObXu4qsoTR9ODVNX5QMjuHgHY/eYv1Fd9OGflq2nLKNrw
         1O5MMghXi/JKWIOgcN+YBHtLSgipGs8MxmKu+qSYgzLoBgNuMiaDOTCov7tag2pHkori
         CV9wbCdHnDCd1VEXfQbHFGfMbxHsde4QGJnKMJmlqrwWMpMFlz9kQCpPnvO1mdoHOQE9
         70Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUHdDGyWwSawQ/ntJRjhpKQSyruluOEVlLzer+W2OslwaxzEODH/Ar8lIDZtmA/cx5yXGFo9P22bG3tZUnKnbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJrUsZc5voiVHj2FhMX3Tiz6ymtDk+BjS+8kUaUkJ7eCjjpkC5
	+SJBUPKzlZi0weNTcuHDLrIl0+pDk9FU7exPghBhm25UklvfYbBns7VbegXuCfUrDpA=
X-Gm-Gg: ASbGncufBvnzv886NkBnFRoKP7wUDBYTSpx8nPf+Q5PgXGhyEOa9I9I51ghDrmQySwx
	hUwFSL/n9gm3M0xZ+OEHBHEzoERAMqGzWNEcFvPOlQEeRS3DwaBBMDZRvWYfh0grdVFHbz9hBxb
	KJYXzDvlUgMZnJy66Px069S5NmdAO9HK+1E2M3TuZnHKx12leoKrzGhcT7IEcNslhy5h/uQAMdT
	jVugV88Ei/Yu/ffH4dW+22E1/I5BKvERcnHAAGISSPtceSixAAvx/0K1zjjyaL45vTEgZieREzY
	R8iom786Ai8gQ1kZhi0lzbAwEaxYv28hki7oYUsUgftFFGAnTAU7VrY297o6BN9EVWmaEDL6BE8
	TeXzPiUjUHFgx//U25G2exugY0BskaNTzOn/Gxx/Ki7qxc6j2JWsgyhl5VgzrH5JNYyiNSkmrvq
	zPKTMbUA==
X-Google-Smtp-Source: AGHT+IGIVSOen45mpOt0xYdR05GnbUoonndymEzs2Y2tUjKO6oUDKgrfkoqnPSp/0zNTXeE4BQVymQ==
X-Received: by 2002:a05:622a:2615:b0:4b0:75ed:bbf9 with SMTP id d75a77b69052e-4b2aaacb9dfmr44784981cf.33.1755884842505;
        Fri, 22 Aug 2025 10:47:22 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e6023asm3121361cf.53.2025.08.22.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:47:22 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH 2/8] riscv: Add SBI debug trigger extension and function ids
Date: Fri, 22 Aug 2025 10:47:09 -0700
Message-ID: <20250822174715.1269138-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822174715.1269138-1-jesse@rivosinc.com>
References: <20250822174715.1269138-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Himanshu Chauhan <hchauhan@ventanamicro.com>

Debug trigger extension is a proposed SBI extension to support
native debugging in S-mode and VS-mode.

The proposal for the extension can be found at:
https://lists.riscv.org/g/sig-hypervisors/message/361

This patch adds the extension and the function IDs defined
by the extension.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
RFC -> V1:
 - No change
V1 -> V2:
 - No change
---
 arch/riscv/include/asm/sbi.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 3d250824178b..be2ca8e8a49e 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -35,6 +35,7 @@ enum sbi_ext_id {
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
+	SBI_EXT_DBTR = 0x44425452,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -402,6 +403,34 @@ enum sbi_ext_nacl_feature {
 #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
 #define SBI_NACL_SHMEM_SRET_X_LAST		31
 
+/* SBI debug triggers function IDs */
+enum sbi_ext_dbtr_fid {
+	SBI_EXT_DBTR_NUM_TRIGGERS = 0,
+	SBI_EXT_DBTR_SETUP_SHMEM,
+	SBI_EXT_DBTR_TRIG_READ,
+	SBI_EXT_DBTR_TRIG_INSTALL,
+	SBI_EXT_DBTR_TRIG_UPDATE,
+	SBI_EXT_DBTR_TRIG_UNINSTALL,
+	SBI_EXT_DBTR_TRIG_ENABLE,
+	SBI_EXT_DBTR_TRIG_DISABLE,
+};
+
+struct sbi_dbtr_data_msg {
+	unsigned long tstate;
+	unsigned long tdata1;
+	unsigned long tdata2;
+	unsigned long tdata3;
+};
+
+struct sbi_dbtr_id_msg {
+	unsigned long idx;
+};
+
+union sbi_dbtr_shmem_entry {
+	struct sbi_dbtr_data_msg data;
+	struct sbi_dbtr_id_msg id;
+};
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
-- 
2.43.0


