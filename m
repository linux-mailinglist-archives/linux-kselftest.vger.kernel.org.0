Return-Path: <linux-kselftest+bounces-37144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1FCB024CB
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 21:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806183A2488
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8D2EACF7;
	Fri, 11 Jul 2025 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hpFOQvHS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EAA1EB5D6
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263179; cv=none; b=izzO3ZBzsQzuuk/D6tOh8aGxjYTXOEMdNW05JCgvaq6gBemh71qcviWFIu80MfAcUohUfbjiseNXsYkgXmM0/I4LxlWJx8S1+TroYObJa4WhELKvj578JnnpfTR5EQuoD+5ZRnQQbhlSt+ztqtLhtOQOhQysWCx9uFFlqTx069U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263179; c=relaxed/simple;
	bh=3XZTvPjvB4R6wnDsFDBTbHp2HDNWsnF4EUoOhsYeC0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggRwe6jiGW5x4a6HF8n1zY8PTcUPUJZcdDwYZhf4hb/h8KfY+DVRexC78QT7OHdb0xnmEE7M1ifwtXjG83Kcp2Q9hPiZ32xno1/Kq1qh5ZQqUQxxsIRnKUROlEZwkm8E0IWte9XzDbO3mtR8VdukwE4xJNXdvRfccqGihmGxgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hpFOQvHS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748e81d37a7so1620593b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752263177; x=1752867977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5+3IuIbTGtFY2nGYSuEXP86kkX+tfkAPCryfH6oHp8=;
        b=hpFOQvHS7nEZ/9CPQUcAh7S1z8bs5bgGroDENNp6WkEP6SXgtk87fMAxMjkA+sdaJD
         39jAobdtfBsJ+LbkqTLl4tZQX6YWGVKlH2Aa054QQl83rcZJdmseds3frwDf9CHmSLyA
         PjToh4UcP++tptSsOPO+IwLglngfXpCMo/zlVrY7JtkJN+i09GLkn+ggTw32bLJvuiye
         BcJl8E76kewr7oKq8n4jgVT/FczEqotLs2pymU2j/StzKzfFtyMP1iZFXsIhkV71oZTQ
         0F1XwFRqnO3UOhD9NRcFABplww+2IEk0S7Vkgbs3cXJsl94RHPOH7ValJCncAiObzDnO
         5A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263177; x=1752867977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5+3IuIbTGtFY2nGYSuEXP86kkX+tfkAPCryfH6oHp8=;
        b=obHFDqepX0VNX3dcQg0Ise6sduA75tcZenzoQZh8gMkM48UTzfyDKgu+JXKHYsrRO2
         OjILn0DbZb0TpNW57eHNc4ABTNNrdgs8lNnGD7ImVyCBloIp2zGGpAQg2MNaC4bl+XMq
         do8C1XCJTEFUNY/QEPNOhSW8+biMc/YXC5GWJaaTlGiJeYIjsHnG9tClK7cPmNWHxIiz
         /BUcMI6WLYsN4rUNO/hCgcpZhk/NtfhOJ0HlVLWR3wAovoA2Y6bkQqrGQJCn9A2S4kCt
         dDA3VbQlNgLbD5VexMnCt8KaiwSmtNBrNmmQMIdEvn2PjTXq9LZDM2ZCjcduh3yMx0t6
         8wNA==
X-Forwarded-Encrypted: i=1; AJvYcCXIHDxuRk258U5AzYPiorZQatSEz3ksN609stykNRhpl+3nIFQlDeX5PZXT5l1cxOZ8RIYR2hSxFeH5TwV4vl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Z3jHvyaTPof6w3UzdaWbKJsh8JqSZSWW+ydwqKKPSrn/lIWj
	uIols6uf0Bk1pbSnsutmylsJE/Apf031Kh5e3D2KbpLhFfWk6ugoqoq2n64nRSlpLvo=
X-Gm-Gg: ASbGnctixXceoqVX0ZF18lQEVVvlgTrRz+d+/TFQCrrxiVa238UPCDQG9u4Q5ceLPnV
	I4SGUbVS9tBR0HBdFP5IbcUJUA45F+GR9HHxF0/R80z960Y7/1ZQMr2cQeNwWxj+9KT39G+BIXh
	8v1Ny0aKmiGcAi9SIJp9VS4OFvqlqAUtvCdLRKRnUlbSa36zFnij58jaV8tsrwZJ8xCoDYG3eTF
	xa/8mh9cSj5F5KxuFFOkpLFiE+euTiqSw5FYVumMVi0Rva4okDoLWlSRbbJcWbfZn/efTX7I7ui
	Vy7V0DAc6kvcCN9rR2zjgdC+yHBJPh4tyhRGRg7gCi5MHwK6DingnaZK+Zu68jo4Dx1RcOATMTb
	78AkJfi8mH4xv96ywa3a3NcVspgcWWgnTR+Zk4fQnrgc=
X-Google-Smtp-Source: AGHT+IHiT9dG2vPXDdmDzQOmWqgagw8g0E9RV6u9tAfh1pEL4PA1GTNnT+r9tqhN9VGCtBB45cyRbQ==
X-Received: by 2002:a05:6a00:b90:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-74ee2c51089mr6267738b3a.11.1752263176893;
        Fri, 11 Jul 2025 12:46:16 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06995sm5840977b3a.38.2025.07.11.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:46:16 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 11 Jul 2025 12:46:06 -0700
Subject: [PATCH v18 01/27] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-v5_user_cfi_series-v18-1-a8ee62f9f38e@rivosinc.com>
References: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
In-Reply-To: <20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ef2ba0c667a..eb48924105c4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -353,6 +353,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_6
 #endif
 
+#if defined(CONFIG_RISCV_USER_CFI)
+/*
+ * Following x86 and picking up the same bitpos.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif

-- 
2.43.0


