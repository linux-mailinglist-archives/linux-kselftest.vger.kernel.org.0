Return-Path: <linux-kselftest+bounces-18793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FF998C2FE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1004B22E83
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14271D0DCB;
	Tue,  1 Oct 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qEme/YOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429571D0BB4
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798901; cv=none; b=kxkveiaqnWo+cl6PC78XOHgEmdUxpAgrYV1VbKjYKBIWaYbpVh8OJF4KDUqfyZssycGzJ6CbMemmOoRPf3ArD4xqTa19VdYAkpBT2Tq9F9wf5XyajGti78GwOkLD2a6jClCMwBVPJzjtsTDiGycebgGixOuVlUJnb8ZvLJhefJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798901; c=relaxed/simple;
	bh=cM56kiCyLgvj4YIuFFWkC72N0JeR2VN2U63+F/njxF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTMnF9XUfCTVB8X38M/xKPqircLA7lAaaL2pw+T+JeOjLM/hm/7zR0BuwFsBP7XVt7riGq0QYIgUSHDuYAA0DOnipU8/0AiuWV5B5atwMwwGy7tD2XMWwLyECIZTOpHp+ce/q7nwm9UrQdRLsZ821EHtdteseb0VGGM6AcZMLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qEme/YOZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b90ab6c19so22646605ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798900; x=1728403700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4qrRFCNXnOZYa1fD74V0zlcrdQ+HWyEoqE9F8mKpFo=;
        b=qEme/YOZxT397CdnAD8EF28nufZWNFzwlrCQsHP12gL63EoI/FPMi6dteI4v8UTKl3
         beMelIP8xGIQTkcPPdFUtMh/9oE2lBuCRisAeBJDUvone9l9DRpUyIIFQAym7X7tOBnD
         BfAMSsT7agmcCjtHqaFrRYAWorWPK/QKAv8dTd/vzRxEgjYiNU0TX5UKlDBr0p/QXL2n
         0CZZL8RxnUMxQCJseES8Gv1a6g7mVDxq6b9geOLRbFh8VxXaT36NYRxrpmG0CmDH2fk3
         vPG62ZBgmXXsFdvlTRt9M6RXVxUkpydbf0zGMQdUCNOIFahLNamTMy1wUB2HwCWk5YVI
         K+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798900; x=1728403700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4qrRFCNXnOZYa1fD74V0zlcrdQ+HWyEoqE9F8mKpFo=;
        b=s1Xguca2lrnxhukz2pxkZyUkrMSk9+FG/JV9t4x+qFB+PWRnnzLFwfcMBKgJ0GbPrt
         /trsI6kKPnr07eIA3NhRBnd3cK519V4UZl3wvSUN83ssF2ksfjOasp4WcVniDug0TBLb
         7vm3lLYyqKOKvAnnt3tFBySYVdljfxOMXKUt4G5/wXQHNpwc/ODsvo6FrMKWwwiIIBQ6
         Dbff5BJVkFjdcxl9HVwngoKwcl2IFRQCHuxMX+CJvN0pQaIdEOSu4sQM7d1vwsP2VIaG
         9Rv2uLJnsn2wYOSgRGBJyj8LCDtl9OckWlxS2m8FnUd9VMdr76YtSrbUzRNYnXF2MEM0
         pzBg==
X-Forwarded-Encrypted: i=1; AJvYcCU/zPHxSuWygS9PY+sbXZSUHazITunEcjOuJX2kZPf5xzfPYUgTPg3zyqrUFaruqFlsawcpve0JAvw3YGAHV78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBs/gcBO2jzGNPNXeAKJFWMToXIzrHztiG0g7+WmWpRqDlzkQ6
	sNWtiK03/Ud8mRwm/bbed7C2Qbz5oFBk6DUAqULg7hpuROf8ZTb47tjJiVIc4s0=
X-Google-Smtp-Source: AGHT+IGiAxXYx6yXeYkA/G/la8C9nBfo7vSN2Z7fy96K3UGQ0W+8BbkIQQBBecsOmRmnWw0/cNAzkw==
X-Received: by 2002:a17:90b:3543:b0:2d8:8175:38c9 with SMTP id 98e67ed59e1d1-2e184804fc6mr237651a91.20.1727798899815;
        Tue, 01 Oct 2024 09:08:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:08:19 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:35 -0700
Subject: [PATCH 30/33] riscv: create a config for shadow stack and landing
 pad instr support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-v5_user_cfi_series-v1-30-3ba65b6e550f@rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`
and `ARCH_HAS_USER_SHADOW_STACK` for riscv.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 808ea66b9537..d0cc2879fcd4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -245,6 +245,25 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select ARCH_HAS_USER_SHADOW_STACK
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
2.45.0


