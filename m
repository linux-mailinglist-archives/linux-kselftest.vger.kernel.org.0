Return-Path: <linux-kselftest+bounces-8325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E121F8A9A39
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 14:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8991C220CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 12:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E343716C451;
	Thu, 18 Apr 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wrdZg5k7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA9168AFF
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444249; cv=none; b=OgldGW6I13waDLE4uDc3mKeHaH4KVX7GjZ+TvfCIPk+Iu/WFcl286qd/zoyI2gqjMdUQlaOwyrB1+MusksgBiOyPJ08wDJ3+/nnB5cX5qkkmv+N1PBOONy0X/hA2mxCzflKYCB7NytLOEDEhTTiKN3uiBOhuAS+U7v0LPDMl0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444249; c=relaxed/simple;
	bh=VBYIkTZIleyOsUo3Vs7GTW09WzwtONhQK0/AstEMTYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGstXjvPJttF5aav4MWv/6LmWhMOGrmJBSuu7ErJeHvh48U+vJxsJxNwu7tD4yTHoyAtvUUGxSRC05rSRWMc+ENdQo21GpyruFABm5Qm902PuzXPMLmbhwwEqn0iZmtB3v3vYdosfKVIAtiGrwrmoogGd96v0/55S45WoaV6qUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wrdZg5k7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-349a33a967eso25686f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 05:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713444246; x=1714049046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdCfPjm06PN8DLWdVlWU7iGB8QhHqS8f5T3HQCXkkpY=;
        b=wrdZg5k7YDT5lFIY1gLMfU0QxbdSnmnXom/WAvGceN+EsWONrwyT1cXaYixHB/VKW/
         kz7Bc2dr9lYtyTu93/yKIc5eGINGRACZ9x1SaqvtK5C9AGVpOHeZc+Jsv71V1lFqk0Yw
         dhyrBLfTtdHfZbXTjrkLBScl48FClZ35r0xCig976i7WPtQdWiNfwc9OroY78j+nGib2
         k0vKQddbSnnpdzRSBBJY/pzH9p7v4iTB602iXCakdt+Ooo71otlduoG7C7Acv6UKyrnF
         qxoXc7rWKtSmHGcaRv5XlTVQSxJlt3vzPVALlMPMXKPpAPwBcE+krRUKuqhkZwiYVkZa
         2Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444246; x=1714049046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdCfPjm06PN8DLWdVlWU7iGB8QhHqS8f5T3HQCXkkpY=;
        b=bhFIDL5zyeEhvifmUbwd+sn6qKrxxv2icBxRJHPOHW9epkzYuCzA1WG7rYkI6DlECt
         ReXvofZLeU98fKO/nSFJTYrv0m5fcJ9hF2MODXwdC3EbwzLqybtVzPnJCoNgi44/CZQK
         s2i81giwztJu7UymJpDUgIZ5q+KgMuyHimYuoWHMfM6hlw2AFNLe1qoaYWTe272vdFmF
         s15Fcw8t/+ziZ7/AVa7J07viv6ifMwOOeaKI/erbxLwreUJHLKwqD7hMOMtXcHFmXqxt
         be2s3dV8r11TS9lda+i0Ewr8THR3RkVWfmo3O82iH+HUE0cdkrTB29/13doOh0dbfisn
         pWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUhereeF/VliJOFvITc1r6+RX39NmfxjfDjsAuCO0rl8abOYdepXLZTiLu5R6W5/zz7/04lORlkQnjzbiRzcc9fOz/t5vqYiezkczuTn7I
X-Gm-Message-State: AOJu0YzhMFVRMMZVSckB/Y6o6UssDpeUmhILXj+ArlRXbjqPQwqJXeoV
	USKzf9M88wZzTI1E9ipkFUWShPhQv66+kCMFXVd+CTOo95Vei7QvxTtwkRqLEos=
X-Google-Smtp-Source: AGHT+IGMuL1VEcAVu36oqMeDfSFjQ3yk2Wj7i500rFn3wK2To4nptMyU7omA9B2isyVdkpsEUDxcgg==
X-Received: by 2002:a05:600c:1ca2:b0:418:2a57:3806 with SMTP id k34-20020a05600c1ca200b004182a573806mr1932349wms.0.1713444246501;
        Thu, 18 Apr 2024 05:44:06 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7b64:4d1d:16d8:e38b])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b00418d5b16fa2sm3373412wmb.30.2024.04.18.05.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:44:05 -0700 (PDT)
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
Subject: [PATCH v2 10/12] riscv: hwprobe: export Zcmop ISA extension
Date: Thu, 18 Apr 2024 14:42:33 +0200
Message-ID: <20240418124300.1387978-11-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418124300.1387978-1-cleger@rivosinc.com>
References: <20240418124300.1387978-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export Zcmop ISA extension through hwprobe.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 4 ++++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index bf96b4e8ba3b..e3187659a077 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -212,6 +212,10 @@ The following keys are defined:
        ("Zcf doesn't exist on RV64 as it contains no instructions") of
        riscv-code-size-reduction.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZCMOP`: The Zcmop May-Be-Operations extension is
+       supported as defined in the RISC-V ISA manual starting from commit
+       c732a4f39a4 ("Zcmop is ratified/1.0").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index dd4ad77faf49..d97ac5436447 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -64,6 +64,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCB		(1ULL << 38)
 #define		RISCV_HWPROBE_EXT_ZCD		(1ULL << 39)
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 40)
+#define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 41)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 2ffa0fe5101e..9457231bd1c0 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -114,6 +114,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZIMOP);
 		EXT_KEY(ZCA);
 		EXT_KEY(ZCB);
+		EXT_KEY(ZCMOP);
 
 		if (has_vector()) {
 			EXT_KEY(ZVBB);
-- 
2.43.0


