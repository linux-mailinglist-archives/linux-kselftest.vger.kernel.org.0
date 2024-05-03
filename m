Return-Path: <linux-kselftest+bounces-9334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FE88BA639
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 06:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA08281043
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD92113B2AC;
	Fri,  3 May 2024 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tUmRuimO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AB113AD30
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711618; cv=none; b=TDNu0rFfkYN22KibiiinT4jNXmvIs5N4//n5SxhH81F2qwXZE+0PWNvrUZ5tEuedguFBimaraybp30zurFj+UIz/wkxj7CowH42P6HbK/xDJlln+LAloJGwAERoUgw+t5nY9UzfyaDkhykhjvssL/z0/6+IDbxALOrawCUvsG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711618; c=relaxed/simple;
	bh=pqN1lFvFRjrgQQgZqYCWrh0drQd/FoIFRL9Qt9AtemU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1NtUXLXOj0E4Yq/ZdbwfkdPytLNhqbDZZXpcAxeeJ2JvekzZ0amZ/Nn3pOtkLP6qR66tMWsuVej89IHwG4ddXJZ5XO80pylVY6MgQvHdqDbtYLThHSl2zew2USXVH6Ec/XsrE8DMW5j65sc0OhTxLyytaU7511T+4aLXyGqxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tUmRuimO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so63912945ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 21:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711617; x=1715316417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1x3fnfXZgKbRNZW52PQl31Hn8/VT/niX2j925w6Muw=;
        b=tUmRuimOjsN/lQbEklDW0kopDD8XeDISMvJEM1n4GrssIVVVJILQi3UKV5qVbz1vYU
         GTS5AExqQUjiR3SmMdX0hB5/RZwqvZ7/VY/dOoN4ERRuzK3XyJnjOyZEhbJDdgExwajq
         0EN+nH3vyrVu9V35uduP54jGTik8u+9/Vx/pqUYJRlG/hgyBJyGAknvn8jk7KE1yLy7/
         oozon+OGdwnFEsZ/GZJEC/U4fovqwbDRhy1t28U/9oPeWU4jPWo0IFGtP/TgGdpTafqi
         RH5loMNS+mTjfMp+QtOXYE48eJEl0WAtJKTRnmek1BT+rWlPoTo5R9fwD1tQl9dvJsav
         RgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711617; x=1715316417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1x3fnfXZgKbRNZW52PQl31Hn8/VT/niX2j925w6Muw=;
        b=HMGFq7aH/BIzvwS9L2VDEtsL3iEcFAbwJ1PkxCIFi6Jza7zSZY192e729Qijrc8YTo
         BFG0Efj/8Bt0aKCGqzbCgnDNX7Zz/QLJCGg9O+j0AGW6xHjHq2UYC8YeQWQATXS/TGWr
         NHcEWQWgOL82GjfEdOLANee54ngseiIQqq34KlBXNnFXC8fowFxDxtXQfgoEpQ2SRV8w
         2AG2M9DHx9weW3rAuXTP7Og1A/3i3pu31ICydpQsagQSqLXT3OLI/zP7Rmr1mHpIpwP7
         zijh5Y2wcxCwE9GqkVgWiPsem0Az3K63pjFbJBEcv+cfEvrpKplY/rg5l40mX1OGXz6x
         QBFA==
X-Forwarded-Encrypted: i=1; AJvYcCXYHDTrqNuiY2M3QkEyBCseasTfBKng1tmu3F04nLrB1ATren2vpUtprIBv1+c5gahWk3vNXRlbZ8f5+8c1bTu0Tm/pBzcKP937nX++Hi46
X-Gm-Message-State: AOJu0Ywwm0pRrWl1LX7s4TBMbVKV7knvqNs5WP+ptO7nGfIyeeTiRvFt
	euZYL40npXSPaALu0QQAYqun49CTsroc73Ch/eg2/jrczes9LCzpj9t5+QWL/NA=
X-Google-Smtp-Source: AGHT+IHbNMkuv/su3XYOiyps0iZwtZ876nCqWFEdktTVe4e6t6GWJkz5DfWvpaj9ZsUbI8EqMDprbw==
X-Received: by 2002:a17:902:ecc7:b0:1eb:dae:bdab with SMTP id a7-20020a170902ecc700b001eb0daebdabmr2129152plh.46.1714711616732;
        Thu, 02 May 2024 21:46:56 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e2bb03893dsm2240411plh.198.2024.05.02.21.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:46:55 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:46:41 -0700
Subject: [PATCH v5 06/17] riscv: Add vendor extensions to /proc/cpuinfo
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-dev-charlie-support_thead_vector_6_9-v5-6-d1b5c013a966@rivosinc.com>
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711602; l=2459;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=pqN1lFvFRjrgQQgZqYCWrh0drQd/FoIFRL9Qt9AtemU=;
 b=H+DX3cVVjv1vLieQvFF/GzHeHnV6V/D0UYWMIUMz9yJnTEHNzwd2Lhb1bwFvj20Y7hip0X35P
 f1ya+z76CwvDzykr4rBxhsKf62CDwPGbJNyH02uPIH6mLHUmhes2dAq
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

All of the supported vendor extensions that have been listed in
riscv_isa_vendor_ext_list can be exported through /proc/cpuinfo.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/kernel/cpu.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index d11d6320fb0d..2a7924dd809b 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -16,6 +16,7 @@
 #include <asm/sbi.h>
 #include <asm/smp.h>
 #include <asm/pgtable.h>
+#include <asm/vendor_extensions.h>
 
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
@@ -203,7 +204,33 @@ arch_initcall(riscv_cpuinfo_init);
 
 #ifdef CONFIG_PROC_FS
 
-static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
+#define ALL_CPUS -1
+
+static void print_vendor_isa(struct seq_file *f, int cpu)
+{
+	struct riscv_isavendorinfo *vendor_bitmap;
+	struct riscv_isa_vendor_ext_data_list *ext_list;
+	const struct riscv_isa_ext_data *ext_data;
+
+	for (int i = 0; i < riscv_isa_vendor_ext_list_size; i++) {
+		ext_list = riscv_isa_vendor_ext_list[i];
+		ext_data = riscv_isa_vendor_ext_list[i]->ext_data;
+
+		if (cpu == ALL_CPUS)
+			vendor_bitmap = &ext_list->all_harts_isa_bitmap;
+		else
+			vendor_bitmap = &ext_list->per_hart_isa_bitmap[cpu];
+
+		for (int j = 0; j < ext_list->ext_data_count; j++) {
+			if (!__riscv_isa_extension_available(vendor_bitmap->isa, ext_data[j].id))
+				continue;
+
+			seq_printf(f, "_%s", ext_data[j].name);
+		}
+	}
+}
+
+static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap, int cpu)
 {
 
 	if (IS_ENABLED(CONFIG_32BIT))
@@ -222,6 +249,8 @@ static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
 		seq_printf(f, "%s", riscv_isa_ext[i].name);
 	}
 
+	print_vendor_isa(f, cpu);
+
 	seq_puts(f, "\n");
 }
 
@@ -284,7 +313,7 @@ static int c_show(struct seq_file *m, void *v)
 	 * line.
 	 */
 	seq_puts(m, "isa\t\t: ");
-	print_isa(m, NULL);
+	print_isa(m, NULL, ALL_CPUS);
 	print_mmu(m);
 
 	if (acpi_disabled) {
@@ -306,7 +335,7 @@ static int c_show(struct seq_file *m, void *v)
 	 * additional extensions not present across all harts.
 	 */
 	seq_puts(m, "hart isa\t: ");
-	print_isa(m, hart_isa[cpu_id].isa);
+	print_isa(m, hart_isa[cpu_id].isa, cpu_id);
 	seq_puts(m, "\n");
 
 	return 0;

-- 
2.44.0


