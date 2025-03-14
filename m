Return-Path: <linux-kselftest+bounces-29076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 603BAA61E73
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F444600BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E264F18A6C5;
	Fri, 14 Mar 2025 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m7KCyXD5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B221FE44A
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988372; cv=none; b=rNdDgjB1ZTNYpBojXomCLAP68E90U6XU5ithB1fZ31YAmUUPMAF0a7hh5fWiGloFFevYpMEanTLWgVjMvJ74d3UmGLwat5xM91y56y5coqLjayLItfkrwtMyiQBTqYhgo084d0Zu+rYhtYOXQubtwnqKiSWkCkn9DyNm1enV+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988372; c=relaxed/simple;
	bh=pbZsnVycfvlXR/jueZaepHgseReSQSx1x2o5rAzi9lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utBV6PLhb7GzsrTbuNPBGVE4kNItygCo8+5bij3kSjAtUfOF38k7HCtzwaAcQUTGrDvg5EGjSeMPFNx/+UKD1EsiAgctVq1OY0q3nyRrDw5VutLVqGDad3TBaSl/OZfT7ZEYRrpS1LxjVYVrCTuuqYen8Z4MbYB7zbBKOY50FJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m7KCyXD5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fd89d036so53920185ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 14:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988370; x=1742593170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDDw4jYk8ElhORayLnctVQ+77ceNByh8dqs8gmZ197w=;
        b=m7KCyXD5LnQkJc1z4hTDR+h/VGiM9ZJOvppzKGG89mi2z7hF997+HAp2iVNQvdG8gU
         Zv0IMTWNSNbV0PFimBwSB/VWO65+Py8SABFRH+hwGCAIkXUX189K/w+Jch8F4De4htFB
         L/ml8N0GPEI/0Tg63UW1AuemeMYmMbhk8RIbUkJ0lAIgphrfHA4y8agSB9cOZrdUQ0tm
         Cgst9vZr21qxvzsgRUiZYXVoL7i3iPwHOFk8ZX43QDBy/nsJVfoUvCFgBN72DuivKhp+
         d9q1u9Mu13Es5RX/iMYEoygtZTeQp8jF20lwvdgrnnsECasfo1mih6z4BLag2Ml7Kd8S
         jVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988370; x=1742593170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDDw4jYk8ElhORayLnctVQ+77ceNByh8dqs8gmZ197w=;
        b=Vnct/LvIS0LoApfmgPxFKlMqu+ap+K2wU1fUZn09Sdi9/gsEkoRYD0io+I6OQ1q96l
         48Ir+vm6Kxo9UrDzvCSAjs32XvFyQduvsBSef3G6g1GnjrnnnbU6CNtqhcG+QEIoZKPM
         cGoaMoGs6RvH3SQHS7303W5BM1IjVkFmlUH4EftGU5ZA7DwXczagHt2Q3LVqMyPVAmML
         i20+HSEei524jTTOyg0731GPkY3qizZqANMToC7A5aB8dYoyqIjBEF5LA4rfIiH+eNyo
         0klapP/lkzHx+m3ZzTgNMoqbEIUY+zpK1wZ+Np4X+igjbGXISxR7slQ5Kj8qfKdIfJbk
         w4Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUH/J59lwsFDDi8r8nTlb3xfqHtd3QLNHp+/f4HndvYEure5UFAnTa1F/08fAuZsfMqngKVBuCLZN0rvKxZ4Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyutlsc7TbPOn9WiJfzKHsjtMPhSPUA/iG1j8V/9ZshfASEIAMe
	UltmBtPgFsI5LeLyxn6W3HfTJ5PNN1zrR8pzYCuxSdKRwfuP/0JpP2gPE2hucC0=
X-Gm-Gg: ASbGncs2tU/KtlR+MS7m5ZsPug0Ou5WVPJiO6rZBatABhRVJGRj89u4M92vwk3rFeU/
	bnLGBiVlgySgvMIbkUDxtkHkKlli6eqXdjOhmHKpiFRLA+RSl7jxm7dqUfWG4m+Ekt1e6sDCbIt
	OskVc39xKD5KL6NwgIgmi4fV6gmuRZ9P1rz+1oPxgxz4ZwCh0eqCuw6kI3uiQ4dM+fTx2SDYnRN
	LmVKZNAn3Eq7/O0/WTzOSyV6D6cnvNZIAgQVIQi1bh9FGUxjq0W/raVOQN6ys4UTsR5mh4bpsRB
	ppxb5G9iZGlYK1dlpQroVF5XDU7t7/rNGlr0QxgzFjC4YyeiulZh+xh6ZWFOFv46zg==
X-Google-Smtp-Source: AGHT+IFpg7z+OE/2A1gqmKjw7jqoEU+X8gr8RuneE9Exr7j30nKzCtL2OnQx5eLIT+ktDst/E1FOnA==
X-Received: by 2002:a17:902:db04:b0:224:8bd:a482 with SMTP id d9443c01a7336-225e0aa7e06mr46126855ad.25.1741988369862;
        Fri, 14 Mar 2025 14:39:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:39:29 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:20 -0700
Subject: [PATCH v12 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-1-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..1ef231cbc8fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -378,6 +378,13 @@ extern unsigned int kobjsize(const void *objp);
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
2.34.1


