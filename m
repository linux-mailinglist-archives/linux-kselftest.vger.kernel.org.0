Return-Path: <linux-kselftest+bounces-43041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70CBD677D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 00:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD64E4F7E7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 21:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A230C601;
	Mon, 13 Oct 2025 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="cdWWKhYy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFD30C340
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392581; cv=none; b=Ljlw4vTwajpt5OAOH9bk9XAQ6sWQQD0I3gtPJadMw1tYGCVZcQri9l2HyDunA6mDmI6wOPhvJ0MWRoswKO9hT/3Sg6T2fXDn/46mgX9MMLyV/Mu2rvUZZkrPnT+TBsEMn8vs5HNDSJ2FyIES4AB5lNZBOmYoiWSYRlMGyFW4wd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392581; c=relaxed/simple;
	bh=zG1PvbsubgVB7UstpLjRtN915FxsRLFbcnYegAn0YwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNQ0LubVKsc5IARS1RHY7ovDAReT6mQ3xiEzz6BOz46fTdQlgUkHPJPlPNnGfH+K1QbnMkkqxjalji7ZaTVB79A+Qtgxyrt8o9oL117JJvBF0HJsxXOxYbE/iKaKOQCVWSql5Pe+09P8I3z+LM7C4YZomHVxN0BeEg9/zJwD+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=cdWWKhYy; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so4987660a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760392579; x=1760997379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=cdWWKhYyIVjqBfHQzqQoAkzmW+wim/2SkMOHRvQlvPHCJKw74fobHOBxgmDeOczV+l
         mRgIn65367OxcvAIhWlQvAVIib9OwY5xkGOmVCSS2PMs/OJbZpICwKF3bsUDsT7Ax61h
         ni0iqAOkgKViPsAq/KvfY6mG4/S8ksKB99j91vaL9a2iJ2T9QqoBGPP3ycfB1LlFxjPs
         1xCr0TQ0g01UmFhbOi2nDu8B3Xze5SDky0fzT/C5DXiLdgza45n6JZo3OdA0llGSfhW5
         Jaj8vFpO5JJofbvseVCISJcPnSIXmX6iZlldBmPR2rpx033KDGZlXgWGJV0fbp9ZiKru
         leIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392579; x=1760997379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9H2LPWU9+l2k2EeL07qQml9rdpRAXigNCc3vd68LC0=;
        b=WuLB65ThWfQJKZ3Pjxm9zvjAW1WxNOAEuRDXjc1x8rI96kvfJry7rLMkCUt8N70Fs+
         SZc90DWzvnzDVHY4iQ419s430v920zyLPi7T0vGxKvZAg3SOLqsmTgTR0AogZhRm977X
         UctCpTFFdbkf+5/byqkbOEOnPDxLv+APaCtNI+XLNovLUSNOdzOh01Y2UioJlfKFH4JJ
         4PCqh7XbpkW0G0TT6l63+FhjIGcTAelmJcgiVXAzMWy3JBfhtZSR6wce1Bn1i/mCmIN9
         eAbqlZDlMw0fofzsOeWq6tGq9Nc1tyxbuEDiiM7vzmuZCNc0tvuNYxONiAtbl2mTZuLX
         Q95A==
X-Forwarded-Encrypted: i=1; AJvYcCW2KitNpM8phf/nYdn1jclmHP4Y3dLaSX3hHgiq0Ln/q/SqXu4OkL/WvLqSUzSj3UDMGlwWYGqRpwUC4VGAHcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Ea62LYUIEO8mA/xvx+fWMYYPACgxwMUorT6icJQN63pd7OzG
	YKsnWpRLTHwjucCV4Dutwzr4tlgifSYMLotqj9ik1VTp5IQNkIKiZwxMlzTMm1hRoBk=
X-Gm-Gg: ASbGncsTmu1QM9jWISOklUp0QXHPdaekXSfFPv3ZHo0atbX/jVtJEB2AsDPfbY3uchr
	2m1yn4PjI+EyAac5OKFlJVvrudoirA82INkOD2X0U5Co/0f7IXAI6AOC2AmGtMURpYdeXF5djNK
	Azy5veHlvM1nLJcV4HYs30qOTfnC2KR7W9GTzMkCvz6KBIZidxU+efURWK6YPMDI6wnfl2mjs2x
	SbGFKSbTc7CgTydxKH7UOrlBqnjqIGbSNEZlIBNBYfv7bZDyZdeD6lRcP5OG/zET5l6fUnj79om
	pECV7OjhJYZnGcmuslYf+ZTGSHPHqH1N6Aq9PKvoMSyBamw9zKdO0LkgpN5VwhjDsG3urM/7TYF
	6v9u7MaoCjKihGhW6B2C68510kKFXFnJpzCI1/GLSDvgRbqr89WE=
X-Google-Smtp-Source: AGHT+IFzR9QDYamHYpCjkFw7ZosGRTg3GUVmZHKGAXWmLamhYw9LpV35U9SRuq2pbLs+pbK1awqRow==
X-Received: by 2002:a17:90b:3a92:b0:32e:4924:690f with SMTP id 98e67ed59e1d1-33b5114b5c6mr35939819a91.6.1760392578914;
        Mon, 13 Oct 2025 14:56:18 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626bb49esm13143212a91.12.2025.10.13.14.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:18 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 13 Oct 2025 14:56:01 -0700
Subject: [PATCH v20 09/28] riscv/mm: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-v5_user_cfi_series-v20-9-b9de4be9912e@rivosinc.com>
References: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
In-Reply-To: <20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

`fork` implements copy on write (COW) by making pages readonly in child
and parent both.

ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
Assumption is that page is readable and on fault copy on write happens.

To implement COW on shadow stack pages, clearing up W bit makes them XWR =
000. This will result in wrong PTE setting which says no perms but V=1 and
PFN field pointing to final page. Instead desired behavior is to turn it
into a readable page, take an access (load/store) fault on sspush/sspop
(shadow stack) and then perform COW on such pages. This way regular reads
would still be allowed and not lead to COW maintaining current behavior
of COW on non-shadow stack but writeable memory.

On the other hand it doesn't interfere with existing COW for read-write
memory. Assumption is always that _PAGE_READ must have been set and thus
setting _PAGE_READ is harmless.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index b03e8f85221f..df4a04b64944 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -415,7 +415,7 @@ static inline int pte_special(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -611,7 +611,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+	pte_t read_pte = READ_ONCE(*ptep);
+	/*
+	 * ptep_set_wrprotect can be called for shadow stack ranges too.
+	 * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
+	 * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
+	 * but we dont want this wrong configuration to be set in page tables.
+	 */
+	atomic_long_set((atomic_long_t *)ptep,
+			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH

-- 
2.43.0


