Return-Path: <linux-kselftest+bounces-21806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9D29C4754
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 21:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1581F21562
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 20:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9989F1C9B97;
	Mon, 11 Nov 2024 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JaxSSnwl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7941C8FC2
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358458; cv=none; b=c7ynWD+TAPt/OCycOQP5rjC/9sfxaryEYP1XErnGGdbBCszCGKlBcs6PtiXf2p73w0C5wnlCfU4VrxFY90GtnCwl2MAGefQPMKAccRQ8KRZyNGAtWi52eqZAjzzL9RTWuU64O69FF4GHyT9o8tSz9V+NCKZWbyZGFYWNLl1NRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358458; c=relaxed/simple;
	bh=0P0H7tyzucv3KISYxlKm6qbY67oBbop+zQ8AHryx3GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bb+GDGGTJV8zgPqo7LysF1j1tykL9BYYMWssHUTVweVVYlFx1sILCXaapYKmfM4jn3cGSt7gXts7qlbzV1jGCz0oQmo+JNrjj/VXjwdPUgt4JBHXQAf31IJYNBMTYgLrFj3POPmViwstDWCB3Ua6mLj927S6JbCvaoH23R6ETzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JaxSSnwl; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so3466505a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358456; x=1731963256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvFaRabdOYgj/FaUxHA5lpjBxuSoaWHPSkkVGjDU8NY=;
        b=JaxSSnwlJo/lD+GLDEPBjlQiYpwI6rvV3podhdIoUtzPPG+luaffpVraQ2Ijcvy279
         kczovEp64cV2xODa15yZDhftj33/1S4dChlftzT/C14qpyyIo7vsWeF/KY+FVvhv+VCV
         O2dTOG6liLHdLc9V56UTx6x4Bt7ZVFxef59gH479RWZjDiOqgbY56dt+yN5sLp7/VCks
         m7mMiF7ZKCkqjpUfinyn2Kgox5Lz+Us4dWfsTb5STBKYgFF48M2gtSZS/xE91wOl00QD
         Diym4DNOILfAL6sEqYK5vn+iD528Kkq8KQep9cYxzsjuAkb/3/GI0Gdc8jpo3shTtaN+
         c5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358456; x=1731963256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvFaRabdOYgj/FaUxHA5lpjBxuSoaWHPSkkVGjDU8NY=;
        b=mA14wFCthCTT1bqyikFp8LDmPg2f0Hp0hHGrQ9MKWsbV2IaettR/Ii3Dn3p5hSG82T
         xMUKeaRecOPkuJYchCQr81tj3/Zeo/HfPavNL73+wxF+HLL2wWWdqm5wGReXy3b0/v1k
         NZWc50vhV3YozcfpHk831sCYmxdUI9LbYZYZ4Vlndwlle9boqLGOWe5JPPy5/cI4PjkM
         g6szTiDj2YusX6xevnmqzh6wZfEoonq6Dc+VAiijnG8J7D5zw3OiTO32PvVAMpAkXy+q
         2waiJS2rs9lu20Syxm2RsveMdk6sNuj3Tt4HQamLdLD6tv0EetYr178ejF/zGLj8HYDX
         kFvw==
X-Forwarded-Encrypted: i=1; AJvYcCVOSJAUmGntZ7iMMM0MFWXzTYplrH11tUbGHuarH/2ItaiunMVn61iLOj2l8cMDtEySX2ZgSGxezA/AAwxhRUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyF9J27mO3AsD9nmFkFaQVEtZzMvTWH9zYfignEPjfsx78A2ea
	ZxmVcIBP5CfrqoQYM8t6IPzxsQMX2CiQiEGZfkZ9nVqegLoFEhvvq/brMuB05cc=
X-Google-Smtp-Source: AGHT+IHkeWur3sgROxcRoGTFfP+xBQFc9m8RxiHforXzu5iQMPat3nHq0j8ICMSCMJgsQveJpQW4TA==
X-Received: by 2002:a17:90b:4acb:b0:2e2:af53:9326 with SMTP id 98e67ed59e1d1-2e9b177fc76mr19427178a91.30.1731358455997;
        Mon, 11 Nov 2024 12:54:15 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:15 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:53:53 -0800
Subject: [PATCH v8 08/29] riscv mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-8-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4948a1f18ae8..2c6edc8d04a3 100644
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
@@ -738,6 +743,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
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
2.45.0


