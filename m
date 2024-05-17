Return-Path: <linux-kselftest+bounces-10353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEF38C88A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 16:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC981C21A99
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E817605E;
	Fri, 17 May 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cpnQj7rd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80387443E
	for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957609; cv=none; b=CTq0A/B8ZCwk30hRgIQYNlbZchCfG3IRSvz+NE9WipCzQ4wQCA44IGfZAGZuajNKXbmMMpiLCSkwoXerB+UhChAe+C27ulpu5TJvDZ5mTj3stxfaH9Gj/yoNQ4U3VyE/I15N00VP3AUjmbSMo6JEofz5avtlXADAeds7KSsP+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957609; c=relaxed/simple;
	bh=lLqhe1SzAbvHTQxSP/UWudiA/apzCVKuUbLMMh8qjWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6A4VUa+mmcMQ1vi0d02deq3j4TKzHXVAETkMeCKYEEG0H0DHTdiismpd7IAvEHpZrkhFc+xQhMES6Lj0Hb6HANW+hoaeDT6Klt9jGxx74tWQB75fGccv1e1W0f3H+dF01NL1jMuKT4mosVL63ZJ6PV3JB/sPOqyS2KNQA+VVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cpnQj7rd; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e1e8c880ffso4086691fa.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715957606; x=1716562406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAqp201GVFEIbm+MBVsat6TXP4XkPRbsrzp6M2IRGJU=;
        b=cpnQj7rdcXk61rk+7dHNrWrHEp3cJNGZNdQbLOMIwO+fEOoeenn9RA+VcCWtzIHDVV
         j9pUeV9SnMhNgmIcW5MPagVJnkixd5ywRlcOi1oqUbB3/y0q+ZhrfxmCM5FW5o7xzaXC
         q+9Y/3yWI3ER24uNagCkzOlZjNc/45vkpiia0YoDhqzcYZQ9/NlP3HF8ntpoPJJWXi2v
         UXu1G5E7fGeUX77h50iqQ+4x0GfdnPDX60BAI55oS44/tv+29iK6uCVsvJn3qm/B8bSw
         OP/Zhg5gTdxq5pDEyZItInI9lurf3mu15aHFVvLH2l4zIpa1Hbt8A7rc/mdqkV7pGD+h
         wMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957606; x=1716562406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAqp201GVFEIbm+MBVsat6TXP4XkPRbsrzp6M2IRGJU=;
        b=CHf8IZ8SKU2K1UfIJ5NNXFWw1+bzPJD6s/f51dJPoa3EmoT2EN4pJCVlqAKxeAPQdX
         yzfEogh6mFXHLDMBzesxyETb5qNwqDgL57iLb/sOgnPOcbrKk0XsxlMbgpZLrBW4Zmy+
         EhQjicM4yfdEvm37JjH2IPhToScEN5Icirch2VUmEH6bMG+rhMjVZX7cPcTrKuf8Xou7
         wwvEnJiN0p/wOl2wGQNStEu8c2aMv1p2BLNPbenZ2+qRkkImZvwb1VpKxUASAVwssFU7
         58JRb9bwoKTZ70U32OeIs2Q/sD7GqknfsXSqOriqc/OadytKwZatPIAJryeSBPzuEeyX
         iIKA==
X-Forwarded-Encrypted: i=1; AJvYcCW0LNUTnrjvdj1NN7zc1LE6VxYK4bItF0/6hhDU81546PN1d7ItPeVdlZ08pprn+/msa8ayv3+YjCy6w6vqEJEf/GTT8QrcLxPQwacHeiQq
X-Gm-Message-State: AOJu0Yxf1Ry24bpUj/SfxU1IilSImBU61vnMTQm2Xw4oHcTdI7d5DmjG
	PcarmizWYUqX6nnvitueRc6Yt+wyBVZ1P55EjunT7Ps3s8vHIoHIwhGMSzPOUR8=
X-Google-Smtp-Source: AGHT+IGbsOhS3vioDq76MfxLVdQKIggUZ1R5Mnaj+gjL7Qa12+AkX4dFvnOwn4zP83iDuEwRqKrmKA==
X-Received: by 2002:a2e:a1ca:0:b0:2e5:67a7:dda7 with SMTP id 38308e7fff4ca-2e567a7df67mr139375581fa.3.1715957605840;
        Fri, 17 May 2024 07:53:25 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:46f0:3724:aa77:c1f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce9431sm301723695e9.28.2024.05.17.07.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:53:25 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 08/16] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
Date: Fri, 17 May 2024 16:52:48 +0200
Message-ID: <20240517145302.971019-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240517145302.971019-1-cleger@rivosinc.com>
References: <20240517145302.971019-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Zc* standard extension for code reduction introduces new extensions.
This patch adds support for Zca, Zcf, Zcd and Zcb. Zce, Zcmt and Zcmp
are left out of this patch since they are targeting microcontrollers/
embedded CPUs instead of application processors.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |  3 ++
 arch/riscv/include/asm/hwcap.h      |  4 +++
 arch/riscv/kernel/cpufeature.c      | 44 ++++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 1a148cd67e0e..8611e1c8ec2d 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -46,6 +46,9 @@ void riscv_user_isa_enable(void);
 
 #define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, NULL)
 
+#define __RISCV_ISA_EXT_DATA_VALIDATE(_name, _id, _validate) \
+			_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, _validate)
+
 /* Used to declare pure "lasso" extension (Zk for instance) */
 #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
 	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b1896dade74c..a5836fa6b998 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,10 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 #define RISCV_ISA_EXT_ZIMOP		74
+#define RISCV_ISA_EXT_ZCA		75
+#define RISCV_ISA_EXT_ZCB		76
+#define RISCV_ISA_EXT_ZCD		77
+#define RISCV_ISA_EXT_ZCF		78
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index fa4ad73b770a..3bb2ef52a38b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -103,6 +103,29 @@ static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
+static int riscv_ext_zca_depends(const struct riscv_isa_ext_data *data,
+				 const unsigned long *isa_bitmap)
+{
+	return __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) ? 0 : -EPROBE_DEFER;
+}
+static int riscv_ext_zcd_validate(const struct riscv_isa_ext_data *data,
+				  const unsigned long *isa_bitmap)
+{
+	return __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
+	       __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_d) ? 0 : -EPROBE_DEFER;
+}
+
+static int riscv_ext_zcf_validate(const struct riscv_isa_ext_data *data,
+				  const unsigned long *isa_bitmap)
+{
+#ifdef CONFIG_64BIT
+	return -EINVAL;
+#else
+	return __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_ZCA) &&
+	       __riscv_isa_extension_available(isa_bitmap, RISCV_ISA_EXT_f) ? 0 : -EPROBE_DEFER;
+#endif
+}
+
 static const unsigned int riscv_zk_bundled_exts[] = {
 	RISCV_ISA_EXT_ZBKB,
 	RISCV_ISA_EXT_ZBKC,
@@ -183,6 +206,21 @@ static const unsigned int riscv_xlinuxenvcfg_exts[] = {
 	RISCV_ISA_EXT_XLINUXENVCFG
 };
 
+/*
+ * Zc* spec states that:
+ * - C always implies Zca
+ * - C+F implies Zcf (RV32 only)
+ * - C+D implies Zcd
+ *
+ * These extensions will be enabled and then validated depending on the
+ * availability of F/D RV32.
+ */
+static const unsigned int riscv_c_exts[] = {
+	RISCV_ISA_EXT_ZCA,
+	RISCV_ISA_EXT_ZCF,
+	RISCV_ISA_EXT_ZCD,
+};
+
 /*
  * The canonical order of ISA extension names in the ISA string is defined in
  * chapter 27 of the unprivileged specification.
@@ -229,7 +267,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(f, RISCV_ISA_EXT_f),
 	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
 	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
-	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
+	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
 	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
 	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts,
@@ -248,6 +286,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
+	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zcb, RISCV_ISA_EXT_ZCB, riscv_ext_zca_depends),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zcd, RISCV_ISA_EXT_ZCD, riscv_ext_zcd_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zcf, RISCV_ISA_EXT_ZCF, riscv_ext_zcf_validate),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
-- 
2.43.0


