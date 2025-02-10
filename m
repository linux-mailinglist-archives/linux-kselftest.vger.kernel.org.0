Return-Path: <linux-kselftest+bounces-26222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B75A2FA2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C9E1884FB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5F254B11;
	Mon, 10 Feb 2025 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Jjso/jkr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C332512EF
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219221; cv=none; b=nD8PCgPJZA9QH7EepM4FGHu7wPcpwxQ44dQ0kVMrJuPfNg46ZbcoiDXxOchBkaLGns7C+ELbe7fMi/4F87KTgG+B83zV/Fz9aciFdZYNhW79ANEzEASC212S/r5ph/AX2daxtvKDMXXeCVnbRLSX70cOcrk0d2ALEyPEkALe+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219221; c=relaxed/simple;
	bh=VGYxjWQw4QYGSfT3AnAkedt5HRuw2tlx5dJCnKUawWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bsnEsQT7nmTcciOKvkSwSS2Pftm6Lt9D3zRc2ttUq5UnSQqIZQt4scdhXkwtzwwFnckg5kn8o9BtMTHALCqaeaGpg3FdAcVPgTrfYFrkfhII8XdVM8GRm2lSldEZxZazArajk9VDNyTk7OEJF5RkTGHtw3hPhsZX6Nu2+4cgmBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Jjso/jkr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f7f1e1194so49343915ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 12:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219219; x=1739824019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bi056oDr44X6mEA5ptOBWamFE29btTVHHp5F60vYQ4s=;
        b=Jjso/jkrqo17czBv99NVyVdLAR/jj7kRxKYwNCZYJ4riMxKQt6iRLNkZIe5CmzByln
         NLBWDAwOGpyj8HeHDcJCRSud6/ls6ohnjTdPKqWpprcp5iQO+0z8O3MppljcpnQP80hH
         +r7pX/PWhRPFTob8enkbzWtUt9G9tD9+GtDScXE8PBDDU/8Sihc8SJGcqWHcGWzGJTzG
         hOgcy2xS/OSRmpSgcp5YLE5NcMlaeSocxm/nlS8Rfcrfuc4/ghfRjZNImhTf4XJotQwX
         sUicyo3QQGFZkI8JXhTyPrqM6ajqZBc4Zq4Ysm0RLUGelscF4EbYj68AB9pQ7hgunkFm
         rm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219219; x=1739824019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi056oDr44X6mEA5ptOBWamFE29btTVHHp5F60vYQ4s=;
        b=iRCNsL/8IG/9REfFrd7krn7+8a2mluW25Gf3WwvxHEPrvkfbkqQSKrcqXxIiq1dnaE
         JHjLbzpqE+QnQVZuaoCn5peH76fTa4TWO+SGzwE68RaJiFNEqBk5p588x58yIouxdjpD
         BROlor2xQmqcQb9ZPY4MMdEPdFjzj5boffnvF1rHhDsnvjLS/W0wRtK0ZUWfGJiNzAKa
         fTCwsW4DZjWrCIG9sSt3XaQnyGjvDRsNrTQ99ZtggP04n9wzw8KBjnG2F+nDcbXPX6Bs
         I1fh4xdkME/VUfUyFbs1ZlZyh/S4rqrjhYw9/QMpv8bMa1mVt/KoQhJXzDOM+0MFcfcr
         AWYw==
X-Forwarded-Encrypted: i=1; AJvYcCW2LTIzo6YQ3Un9fwH2o5Y2kXqbNJ0m+7eRk5XC8i3xb0OWfaWtFdMbeMRzAdaLTeE7IledaJsZba4gmkwdnHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ja1Hgl1urcXwnbQq2iApzYH1zSrRWhjoYzxdA1DFa+p1ngjD
	XTjHqXujWV6WPPrnwh1OUMRcgWb41QTuZ4jZqk8cnZQqJSoJjtV30X+ERZPMssk=
X-Gm-Gg: ASbGnctJEmdD/4RBOgXxAl55p3N7ZSZlHMsdRTTP0CawLZCYEqfA3FvxF5S/pX+jZNI
	a1MOe97jsHlj5+Uo40ZSLZNpn1ZbyLdIoG75ciJwgYAh/w6S3hUMnNpQ3GYxEHS9H/y6bQSlnXV
	wtrE31kkqA6zGoGR6fxRi8TKyQZmjm97Te4AYyq2bWWTViEESHmC/Jp4hNOSkuctmTRR4H3jyku
	kfciBLsHgBsIwy3FQ4B41jteBq3aK5vmgGS322lqhiagD7B3c9kRO55FVViyFDbRPkyZOzLOsgw
	NGezgW4JnDto3wLmkKaPFq0F+Q==
X-Google-Smtp-Source: AGHT+IED7zcqCk6xnlgZyjRhcEK3K99n9HG3VnjktIjXL97/vl92I1hppw2VD80KTsXjIvmfBlGjpA==
X-Received: by 2002:a17:903:284:b0:216:7ee9:21ff with SMTP id d9443c01a7336-21f4e763a67mr241716765ad.49.1739219219434;
        Mon, 10 Feb 2025 12:26:59 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:26:59 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:40 -0800
Subject: [PATCH v10 07/27] riscv mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-7-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 8c528cd7347a..ede43185ffdf 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -421,6 +421,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -749,6 +754,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));

-- 
2.34.1


