Return-Path: <linux-kselftest+bounces-38146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA1AB17986
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 01:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F26A177441
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 23:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA27285053;
	Thu, 31 Jul 2025 23:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rzeHB25B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299C28469D
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003982; cv=none; b=k7LlUfajgQ38mrbFQvITI+FacAXO+NKSWKZu6mnP1KAwzO0l9GlBTaY/4VkwtC5QxZjoFcQ/KbC+gE/01b8DWBmPyM0gGMc9MSzmMXlg4cJgK2IfxXnhTGEIFGHTJnn/j5wW/DR+aRtOpRg2w5ipO7LFYxKzy7RKFcKNAAFhKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003982; c=relaxed/simple;
	bh=1FCtprg+5iy5TwUAdOVeniUOl54kIVW1HbeIvQ2AWDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSSldJMZDM5XZJlyfBkYouLev0EV8a5V5KTEiuFkdDfjJV4N8EIeC0CN+zKeDV9i7itokMFCZ0p6RxVrUOqYxSesDKkaMCRjxV2zYL8dfW1erQHZgDhegTg7eRYm0J/Gp37fqWvrtNKnWg6BcEAp1XyXkq/fwnrzM8w4dt8S6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rzeHB25B; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bc5e68e26so1748857b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 16:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754003979; x=1754608779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ez7fajQ4lWgiIPATC51FeBxCIECW6n3uAlkHVBFvak8=;
        b=rzeHB25BkP8OtL88dznDNbD9BTMSKv8OS7sBjQ0Wjci8efkXrBnnhupRC++7/qFYDf
         ZdO0Y6RajlzZVjGqYHx+J0D9233OeTp0mZLdrrtl4+NyR6QG6vHY6d56gs34RdZoN3Qb
         yGsf78ALnN/kN3rhzzzXDK3fUGvWZlnZAM0vhAfzpFA5a4kAEH3zLnQfd6PvpbDpGd7f
         uEFk7fvbISptW8fxN0SgPdkz+iJp6RlZztGvPf8DNgHU9UmpmQvBmw1rSvH+XmJRfHQx
         HUOI0fG3KPsF5hcAfQ96pTa+EM0+L58/kjk+WZE4oggGwtXpG+8Rj3Wl7YG5WhvJMlcQ
         4MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754003979; x=1754608779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez7fajQ4lWgiIPATC51FeBxCIECW6n3uAlkHVBFvak8=;
        b=KmpHFmhN8jhMoMgHY/wcVojiAmEuUEkPdKa2EYchTw8K+pY7TYuYenKqxUsi5qMSbF
         eB24HrWA030qx7KsJtrl27FqWN64t7oBJCEFsDs7U87+nsYx9bRSX7DTWSghzXpB0NWh
         EuVcQYjr1WTrJ+0JNBAFtV4mVzPDWILfJKN0bg0/BnT9UtvnkRjM/gpg5UvSeKf6hboa
         JpKSBqRLoB5yvsoqDAPmgO6yHnl4HtjAh6zpz6BAUP/oPE8BP7NDm5C4OZGgcOKnKvNC
         lr0NW7QfgZAb9Hlxmdx5TB/hoifcJAxDvtmGM9IUluLtm5KMTWB8jWe/I0tt6joUcK9Y
         yfSg==
X-Forwarded-Encrypted: i=1; AJvYcCWvofbde4c10jlMmnNFOAaJPE9isQzo6qPBOsrwgsagq4yEk/modFBgY7m+pfT51/Di7Y0+M18wR8/khIbRxjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb90aBzXzO1A2ASvAt+V0q+H1ar0IHYH80D250AvhJE0DCwEjH
	CLa0guQw48QtuZzSDa6MN7jcECgb9anVlSpiHwE/mhDvjGKkUCi/br86m3/zAtqgZ/M=
X-Gm-Gg: ASbGncud6Zcvdl/HAYtYVQNsShI2FzYCHHV7BNnOxaUZoGJQyU9jqzOmg/4o7k9F1b6
	flfdqdaK1N6y/ZxanvxD+i2SmkiB7puymKubrC1LPGqHJoJ2n0GquCjz9aybOo3j5JsgOpG0haD
	e1lWvebWD4cmjnqxfYmTJZRsGgOOYbTByQmCzSV60C99o4Ps7BU4FZYJcMlxuO6sUKFZ6P7XIai
	CAmr2mnYgRz2Ec4cr8AxhSi5utoSVGK1g74f1TPPptMsdkvhRJrsMufE/+cWMyKKoorK5O4cwZj
	syVIjDza9z54ppwVlgs6XdPMGwmOfsba+XfLgt2aVytfIDYYmDF0t07NL7QglcZmzX04S87ZXUB
	jDfDx2tocPCYFqjeGGZYrmevBP0h88Kel
X-Google-Smtp-Source: AGHT+IF2xo1ZfVMwTGmqa0w+CJyQOLIX1YGoKzAdOOg0c/bt0OowoMzz4A7p4t8/qA7S3n5MiZF/3Q==
X-Received: by 2002:a17:90b:2b46:b0:31e:d643:6cb9 with SMTP id 98e67ed59e1d1-31f5dd7f18dmr11303515a91.1.1754003979507;
        Thu, 31 Jul 2025 16:19:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:19:39 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:17 -0700
Subject: [PATCH v19 07/27] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-7-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index c0d7e67c67ff..792cb9792e8f 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -431,6 +431,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -776,6 +781,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
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
2.43.0


