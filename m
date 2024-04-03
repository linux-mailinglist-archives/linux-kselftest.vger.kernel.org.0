Return-Path: <linux-kselftest+bounces-7149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D8897C9E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 01:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA0A28C9E8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91EA15DBD5;
	Wed,  3 Apr 2024 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YwMx341w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70415D5DA
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187769; cv=none; b=WTXaDvxhTSR9Hs4hIJI4Ce+HDTufdYu0dhJros9AWX6aQXuKvGM7gw5IBoXAnQAdRwOQ1OOBVMoxaOCk5ng3nKzOhHUadNVCPayTQ9x7DPmRGFAGDNDwnAyf7yGfWoSOZIqUKJLtxaplZyOwocGqy/9YKrH4aDOBRzKWyvn3q0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187769; c=relaxed/simple;
	bh=gRUEuRotPJjUi2hlrSXSLGRWOK9UqoUEje/IwX9OQE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdImd1FUk/uLRR4AYFVeEnxdf6wD6F0zNtLSjNYZxB5ZIJfnB9mmnr87ByN2DV5F9KyjpPS0uFq4VY43sCksXiyoQbiOz78RyLU4G5H9e6qyX6qpuYZqTgMApqU4s+epJHKmVym7Dt6RNnHlaFTiwxQ7k8VeqJfLCt7j1AbEaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YwMx341w; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eac64f2205so302177b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712187767; x=1712792567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DtlDgd/GAT0EKcB2AjZTXvg/KwB3A8UKH6yER0NyfA=;
        b=YwMx341wx/Wa3bsWUkv9/0EdOfHv8Zq9ZoouLn4DtRxapcnfryBzyRZhRVoBURgbWS
         XdAshDMADFJ7tkrqy1N8EtdmuEX29biH/cLgfTucRcQhBz9waC5NrkvyVyrzaPh7H2D8
         ByrFBZQNk5w6tb1vI/Qw+BGzOrsF78WB0TzEfxO5IGKCzZrab7nPj9pRwBpMAqjeeeRT
         c4TYMLHVGPQKu0ZC+lO3XzbSVWAJPSshnE0J1yXcFtO5FdtVkGvlpuYGOIIAKJsQOzRP
         fRrGblFel1Cb2FBLr7xCOCUPXlMUGd0NaN1ribZ2jbmjzfiQJuWzX3g3qVcmaBZISzk1
         8f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712187767; x=1712792567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DtlDgd/GAT0EKcB2AjZTXvg/KwB3A8UKH6yER0NyfA=;
        b=vx0lzHusKCsWlH7WXY87JcTrPKri7aAeGPibBnb5ilHf8MORD74KKZzNFtUsUukjxp
         +io3RlJ7Ygr/xuNwCq3ZXcmoM1AaM1GXeR3imjsSMERBtLZD2GL5jmPQM6AWX6XAN8hq
         qudV4yj/wQCoFdXAB0HVKdh0LiJN1nN9FUw6Wo8bHgN4QXFs5BzgGYva5/mr7dfdl2zW
         k4abgHx1+2felNXu159roMRlO7uswv4BovYLMr7Uc1oFfLpuCCHZ6Sca7SHb17IrgIp2
         4NMN15t1Oekdd8ZHS/DUKbB3EkbajradwCBkLH+y9Twfs0hZG+G0n0+n6Os4BLnehg+q
         +ioQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9hRw6fIP/N+JgZA0RlAvnfVQqo1vhu30jNvoYPRy3360ly8DXaYX5igJZx0OjfeAeEC8JSExvSZ0iOYZE+aiDoWbPOMw3Kr0J4O8vFFUU
X-Gm-Message-State: AOJu0Yzb0cejXGxMOQMt8c+epiQe98E0yFD5QgvgFDLKLOq7g9+ZvxOp
	/pOF9vR4LU4Khf/oTyN+2OXRPjnzZGscmu3DHBJmt4KLmljXmfIuN/zTlerJrbg=
X-Google-Smtp-Source: AGHT+IGTlfFxuJFVldaZ8jYPJUINkZRKqV1i5a/wExLO9N1TqU40XTAEu7HYkbstJURl0N5AQEsIcg==
X-Received: by 2002:a05:6a20:7285:b0:1a7:2437:3d58 with SMTP id o5-20020a056a20728500b001a724373d58mr1369671pzk.13.1712187767375;
        Wed, 03 Apr 2024 16:42:47 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001deeac592absm13899117plg.180.2024.04.03.16.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:42:47 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	samuel.holland@sifive.com,
	conor@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	hankuan.chen@sifive.com,
	greentime.hu@sifive.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	charlie@rivosinc.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	sameo@rivosinc.com,
	shikemeng@huaweicloud.com,
	willy@infradead.org,
	vincent.chen@sifive.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	gerg@kernel.org,
	heiko@sntech.de,
	bhe@redhat.com,
	jeeheng.sia@starfivetech.com,
	cyy@cyyself.name,
	maskray@google.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bgray@linux.ibm.com,
	mpe@ellerman.id.au,
	baruch@tkos.co.il,
	alx@kernel.org,
	david@redhat.com,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	shr@devkernel.io,
	deller@gmx.de,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: [PATCH v3 26/29] riscv: create a config for shadow stack and landing pad instr support
Date: Wed,  3 Apr 2024 16:35:14 -0700
Message-ID: <20240403234054.2020347-27-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403234054.2020347-1-debug@rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7e0b2bcc388f..d6f1303ef660 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -203,6 +203,24 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select ARCH_USES_HIGH_VMA_FLAGS
+	help
+	  Provides CPU assisted control flow integrity to userspace tasks.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge in program.
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption. This helps mitigate ROP attacks.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This mitigates against
+	  JOP / COP attacks. Applications must be enabled to use it, and old user-
+	  space does not get protection "for free".
+	  default y
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8
-- 
2.43.2


