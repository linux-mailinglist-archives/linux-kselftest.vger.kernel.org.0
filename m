Return-Path: <linux-kselftest+bounces-12249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7249990F282
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 17:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296291F25AD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 15:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37353158D7B;
	Wed, 19 Jun 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="z81WNGhk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E050158853
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811676; cv=none; b=bEYb094HL4pAMgvv64Vv1MGysbwjBS/4U+TNwX8Zc9ccAUJAN99WABP3XreXPYmwggyFV5Hf2K88DUJyJPiDLDqOR+1tU8uj9iVruF46BhN1Fg+H83sa+6p3gAbI8rvO6ef35U5UdxRXGs52JZfo8ei26ARm72a5bOAQK6UZ4Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811676; c=relaxed/simple;
	bh=sfkJQkB4VssH60z6VSpLP4aPbWO0sGtaDBnsCx5T9lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1ACpLliKZLF4vqEfMEvFRTjVxdqZAqyJNtpeaJTBxuukkz/XCdZcmvzP4GHIboAmp8xzGUDWcl5NY1bw190QZ5mRxdk8OskpKD7iCqYuodYnqmBWje1lRYR2Ll98qo+lMlgqL+sKuDImMoYrVMCOMCq+0/TlXkuuFzX9Q6B244=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=z81WNGhk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3590b63f659so515365f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718811673; x=1719416473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxBaoVReHjYi8LCIKzJk71raI5rhLtFKE/0A3hAurqc=;
        b=z81WNGhkI84iY0WnzpmrgF4HdBr+LvCzTYAwjD4CfyOKybB4CwljGthxzznsku0rH7
         OIZx39Agdz2TfWKJM6esk4s8kxB0xZNtt8hteCs6OubznDVGefwgPd9h5omLoc1UZzUD
         XjIvLc+0lI7ReBi+JKCq74TGN7k+/6GletIQdrX/WWZAARdLL4NqW9ZnCGkXu0CxmL2/
         G9FUbxAGe6t3/i1/7HZxet/vH5Ierj4sI1OurYAL7Hcfx9Y8S37ws2jneSVUxMtWlodi
         gsTllTnWI8pi7VPxLhy4yExRROthsVJNaQPX9dWn4un4Tl7MCndcqj2KA3Bncp03ktwW
         6yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811673; x=1719416473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxBaoVReHjYi8LCIKzJk71raI5rhLtFKE/0A3hAurqc=;
        b=T5twvlyso9bJgZER1VrlU+Z36wzBtUipGjOhjvTnKFzVc/v2BHYp7r6Tj9lFKMeM3d
         WtPbPFIGWre93XJu6rYvLn5fXTykgSwgU/8N3TxOWrPcSkd6mb2XpeQxd1a3xIR5Gx8E
         Hwm+OKfn6PwAoqkjbaUxwFWoYDnKXEIEgz7X4MdDqvTPyunHrAL6sL1NMEgJF3tdS0vP
         aBunL4u+ktwjSk7xq+ZvXs/mj6292+OBqW1ZHwOcbzbCdptad2S3xFPIlt0HCygUB1dr
         Y2vl8982XcqHKNkipO0ORU+Qm9MmHUhsXCiJtcanB8v3bMeJSGc8TjbcZhEIyL7/KytJ
         zAVA==
X-Forwarded-Encrypted: i=1; AJvYcCXHEbWrpTFU8P3w40zOLGPu09g2VREU6OjTtHiVCf42D9NQeLTIvREPjGFXaG8TFchU3OAguvLMyXgf0hqZ+70E43eC5nLflkCsHew8gKf7
X-Gm-Message-State: AOJu0YyDyDCTm0i7C9EAtd70DyFJiYPTwjV+6Jmxsrc2iJrOuS3JGup5
	2+NG9D6dAFz8ug2Nwy+9HmV3FecLSNIzgQYZIMAHU1vLYU6lxn3oMo98IlSe2cw=
X-Google-Smtp-Source: AGHT+IFz7mNhNVrkeHHVYr8mBns/F7ItFsjrGXd+9ip+r+Vpj1iuLdfUz+P+4a8dyx9jXLcARTyeFg==
X-Received: by 2002:adf:cf02:0:b0:364:7a63:93c7 with SMTP id ffacd0b85a97d-3647a639555mr16771f8f.1.1718811672887;
        Wed, 19 Jun 2024 08:41:12 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:819d:b9d2:9c2:3b7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c785sm17392292f8f.34.2024.06.19.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:41:11 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>,
	Atish Patra <atishp@atishpatra.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/5] riscv: add parsing for Zaamo and Zalrsc extensions
Date: Wed, 19 Jun 2024 17:39:09 +0200
Message-ID: <20240619153913.867263-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619153913.867263-1-cleger@rivosinc.com>
References: <20240619153913.867263-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These 2 new extensions are actually a subset of the A extension which
provides atomic memory operations and load-reserved/store-conditional
instructions.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpufeature.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 4880324a1b29..69be244bce4b 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -92,6 +92,8 @@
 #define RISCV_ISA_EXT_ZCD		83
 #define RISCV_ISA_EXT_ZCF		84
 #define RISCV_ISA_EXT_ZCMOP		85
+#define RISCV_ISA_EXT_ZAAMO		86
+#define RISCV_ISA_EXT_ZALRSC		87
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index ec4bff7a827c..d71e5bd58acc 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -156,6 +156,11 @@ static int riscv_ext_zcf_validate(const struct riscv_isa_ext_data *data,
 	return -EPROBE_DEFER;
 }
 
+static const unsigned int riscv_a_exts[] = {
+	RISCV_ISA_EXT_ZAAMO,
+	RISCV_ISA_EXT_ZALRSC,
+};
+
 static const unsigned int riscv_zk_bundled_exts[] = {
 	RISCV_ISA_EXT_ZBKB,
 	RISCV_ISA_EXT_ZBKC,
@@ -327,7 +332,7 @@ static const unsigned int riscv_c_exts[] = {
 const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(i, RISCV_ISA_EXT_i),
 	__RISCV_ISA_EXT_DATA(m, RISCV_ISA_EXT_m),
-	__RISCV_ISA_EXT_DATA(a, RISCV_ISA_EXT_a),
+	__RISCV_ISA_EXT_SUPERSET(a, RISCV_ISA_EXT_a, riscv_a_exts),
 	__RISCV_ISA_EXT_DATA(f, RISCV_ISA_EXT_f),
 	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
 	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
@@ -346,7 +351,9 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
+	__RISCV_ISA_EXT_DATA(zaamo, RISCV_ISA_EXT_ZAAMO),
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
+	__RISCV_ISA_EXT_DATA(zalrsc, RISCV_ISA_EXT_ZALRSC),
 	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
 	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
-- 
2.45.2


