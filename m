Return-Path: <linux-kselftest+bounces-38319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C34B1BB07
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA7218887F4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 19:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E669525A631;
	Tue,  5 Aug 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Lz6no2bh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379EF23C8A0
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422805; cv=none; b=Kv1rk4cwfby18G/Dk4dS2TYHxVItluaCKDD4EHj5ZrPZC1Vh3ckFN9iZnE3WPtHIb9HkbVFmxBBnAbHPR5Ghjlb2qw4a8ImhPfbAbC9cwXXUWgV6GvALqnEaxnabl/zXM1iWJNghrscbkJNyYaUzDaVaIUzfYK+Teu1wa6pkGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422805; c=relaxed/simple;
	bh=3yynwp5xkX2tlPXadX9UGBNDDBTvMVZycNKpFPtm3RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RasGMk1klMZnll9jH5n9MvU2wGljDoo9o7V9NJ02Qlw1kHPq5KmpDlA0pgZMFnipp99DNWn+/HGQlOUtm90AKQ25g1OVnsOR39dpScxi9biO7O27y9tQ6xyZM1v14utx4I9GlUXsYW4o5PDtNazrDI3KAlxIuaLr0NuXX5mccLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Lz6no2bh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e699c5b110so27596385a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754422803; x=1755027603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBx+S5U+eiCq8pUooPV2kB8TZrzcZaWUvNy/30cjCv8=;
        b=Lz6no2bhsa1jJH8jZxqPZzw3Dy+jEShkPkGbr2xpO7yZmfg/EmJmBTdU4AKMwF4SZ2
         Jp1aH6/3uCD+GK5l2mnVRV+X2Mf2Ttn+dFLEIz3zQwfrZZhN8D0P+YmQQNFIIHaq04TF
         NjPS4cYh7xexa/uVR3g/EruKQLPo4FYuFg+UYyQrJHmbZ8OU7+ecTynfKoXfNjZgFTFX
         ifV+JOYl830td9WF3lnPdhjZBYJ7o/4IgAOZmetAhaNmcaOIrnssYivNasrwoj6ZE6ve
         fd7+2DDwDjdtWsQSgAYwsvtWk5CzUO3tIkGbyE3f4lLsPKU1ts7PkJF3VcRypCtllwM4
         DYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422803; x=1755027603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBx+S5U+eiCq8pUooPV2kB8TZrzcZaWUvNy/30cjCv8=;
        b=gyQM13W/sZHYOotnMjmMZmViGweYmXR+75t0/tybdGc83YSBAL21SMW98VH9zAyHu+
         mZz89LEGg1FsJbp+6IAGJXgje3Frt2dg5l8vfzSfFdVFy9qx4K4ytJdUn1LS/+U2S7C8
         Q6tBAV7f03TAX1Qdt4pDps74Z3pGBYoPKa1wIxrI/YbRm5Or8kFnWxL8SNWARlXE+92I
         4W2wdNvwgekT8OEeR8wbdSqJ9LhoA7vRZhUsStMdRmD75o5gVJ0736m48jRVdxa5nmEO
         3CPVmpgfHtoFx7esoJ6yla6AyNlpf05EwjI3kXMNl605ouYf0wWmirflyT6AGLBdXVOP
         u/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCV1uSbGS+PipQi3O70QhuzKZTD4UugNZV7NYNQaG2grtHAIcOu0RvetzoysemXySW+Hd2i686yMIZ/uq8Gtm3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YysGO59biBE4MPy3WepdzIi/NhxAzkdOVNaIqAxnMLJeLp34q6x
	rAVOFSzxMKOdjpA+Xb783TluJx/JdL9XIPyud49UbP0xQW2XLbx1WuWFlh2HF5XX2Kc=
X-Gm-Gg: ASbGncsLTBnUlJpGYtIbRaWWqlBExtcqaNVbp6BuuWbO27qCntLFdE2NszHN9epOt4N
	QJTDmeWt05mXjGKPOUHpQWBflOUrW+mK0J6PAYGokN5JrnA82vo5xKfsmGiIok9vabdqE5lTSMQ
	7tq0smFObI5eMCV8CE+xJbXHAKs3OmsgOfmpxZ7Z43QKQd7VTr25bVFs5fRyo9yQFM4v2RiVaQq
	4v63KSpMZRfbyt8u0M4JMfkQtk60cEFf4IBBAt7EdyGEVy76GF8YM7o9zcIcT3AkjzA594ckyMN
	k3jW1sZ14Myr3grygysyNP5UWVaUmRNHbpoP5GgOb8rY4BcsCYDxcQ3tDDEDExdH1/SUT/uKAIF
	zhYPuSSkBd0AwAuqHB9oyHANFUanKXMf6nVzbDy6naXDSadUgVqAmG8Wal4w1SRZrkIWOhbd4I3
	e2ndrO1Q==
X-Google-Smtp-Source: AGHT+IGX7OQglHEEPOq98awptA6J/9DSpmeeKDOZlvbBLWPX9HQBX2UPCjNuTmMSORoLz+090C2k2w==
X-Received: by 2002:a05:620a:424c:b0:7e6:99d7:3340 with SMTP id af79cd13be357-7e8156bcaacmr32337785a.12.1754422802272;
        Tue, 05 Aug 2025 12:40:02 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7064b0sm717855685a.54.2025.08.05.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:40:02 -0700 (PDT)
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
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley  <conor.dooley@microchip.com>,
	Deepak Gupta  <debug@rivosinc.com>,
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
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/8] riscv: Add SBI debug trigger extension and function ids
Date: Tue,  5 Aug 2025 12:39:49 -0700
Message-ID: <20250805193955.798277-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805193955.798277-1-jesse@rivosinc.com>
References: <20250805193955.798277-1-jesse@rivosinc.com>
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


