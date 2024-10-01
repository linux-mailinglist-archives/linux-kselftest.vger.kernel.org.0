Return-Path: <linux-kselftest+bounces-18789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E1F98C2E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE001F211B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB321D07A2;
	Tue,  1 Oct 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e0+OcCjz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AB1D078D
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798891; cv=none; b=duKh8hr09Y1GjwZH5TlmT9rhhivaYlZftdzqS07g+duvW/CyiNevX0gpChLDm1qvvR9F4bWu4OT/9dFTe8rERuEnXUD2rW4sEVGSSpfMF++Vf0i5AeHUSHG2wjThPnzIBWRKqCAyBEmsTBpGrPtTfUgmAgVt1mmv+LFc3hE+IFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798891; c=relaxed/simple;
	bh=z3F5GZUNNZRZ61rUGXBlYYR6QqrnCnK9ZskBaiISZhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FEKmxYudfx1Fyeyvqx4B0VM55ccRFI+QSwFKJvHRoseIDpvZOZrBPOHSw7JhCI1fL27mwFVFPZheIxprfTX4ydtVWyNf+dxCWOU/YrsPF2VDBqz5yVv2qt8gYzyi3W9iKR/RwCrB+jQkRKbD3cr6cZrbrNc1ExvyixW9KMWwtn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e0+OcCjz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e091682cfbso4248092a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798889; x=1728403689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjvUiWFDgNIgR9D1bPvnv0vD2BBeNN4jEZqEwYO5LXU=;
        b=e0+OcCjz1Htu6hDpNUM8FYjvOgEzp5FnsO0EA40mushUZurj/5f6mTRhgpiBTPY0Vy
         ozQPY9CKVfDF1f0C6l/QT+q5KICMIVNuJcEqB9BqIo9/P7SMsi9uwn2+437V0SS31KBh
         FT6DHXhxP9jnvE+U/VDgmpyuDtsbdyKwJWkIZWLX4BquK6d0lR2UCR+3HLZIJt6vjW35
         aDbgQyk7T7wPvMAwyykXs5Mv3vpcS7zzetw24DFcGqBce6EwDfC1Ka5Q4BcJaVGV/K5N
         C9X8LebMAOm7rCosGZ9RU/Edjc1WTdYKvIvuTjLznOkHVAsxtuxWah0A33bzIFDoEx3F
         cZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798889; x=1728403689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjvUiWFDgNIgR9D1bPvnv0vD2BBeNN4jEZqEwYO5LXU=;
        b=tG13jxXVVM8CaiKNdQFzGiOZfyQZ63qRB+JCWtg0PO/FUh9TAKjAepM9bIo+dyxKi4
         HysOHhAS8BJ3ib0hycHTGkhRjwXURKS6Au5dlSjq0bkiNWcopdY5Cbygo5dsyIFKpcNz
         T2vnUljHMcznscSbr/fXCCP3wOFJz/XSNQlsB1nHDb0CxLxSzEsRYouN7S4PHBLEStHh
         RyDqr0bgJppFWrbQnnekxvwtoQO9gGO1iw0ZtHhIp3cgkaNuD7YgXfpIqyakISjHHyr/
         fGUdmiBz7pspMBXVugJIaXVWE7I442Eknd/GBX5kMt4XtEmjT3TvNVXuM24BZF4RHZIh
         VFJg==
X-Forwarded-Encrypted: i=1; AJvYcCX29UXA8QNJJQENbhFBIWwH2VC9Zs0rMZQdNxyRUIMoj6R4Z1N/Bm7oSq5Cz4z3R50uIPjANXhjVLzT5Zf1mA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXE8SOOTzI7nLehMuqNh6AdKrlcnUgvpmfcKIP3JuzYdu4KRED
	KplY4bxmJq1udwAegxtPlygKdX7tAhKArvORQSofbOV5GRT388cHiSRZHW+enLE=
X-Google-Smtp-Source: AGHT+IEFtkvkf8CeAUwgsAXuKYnO4LfTHDhI++8QoSmmlyNMIGKy49PqXf+MVN7GYY3kXwIYrf7vbw==
X-Received: by 2002:a17:90a:7402:b0:2d8:77cc:85e with SMTP id 98e67ed59e1d1-2e18496b9e2mr188291a91.37.1727798889491;
        Tue, 01 Oct 2024 09:08:09 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:08:09 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:31 -0700
Subject: [PATCH 26/33] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-v5_user_cfi_series-v1-26-3ba65b6e550f@rivosinc.com>
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

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 1e153cda57db..d5c5dec9ae6c 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -72,6 +72,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 50)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cea0ca2bf2a2..98f72ad7124f 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -107,6 +107,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
 		EXT_KEY(ZIHINTPAUSE);

-- 
2.45.0


