Return-Path: <linux-kselftest+bounces-34303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E98ACE2E0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 19:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4D416F646
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A01F5437;
	Wed,  4 Jun 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O/zuGXmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D031F150B
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057379; cv=none; b=iY5MW4TmBXUAmAAKLIWh2MZvm6vvgGkO09IkLSYgGZhDNze2djAeOIEXRPcawn2ohbr5IU2UflKemX++aiXWuXrQYNfWCT081eR0C94wb3ympc1sOTyGPbBrKrk2s2ZBUT6VQHPc0RSOj50UV+qwgHSzo5Ottgv2QMgjqIneA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057379; c=relaxed/simple;
	bh=uG4QPZVjl5gDK86VnIwXxVnXWRkca87HCRZHSL9+/F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gsRBHWdseqqu7u4GMZIBsvF1bLmggiwV5ltiW52p5L8JsTOue/nQaOA/MYbzIdFDv4g0+cHzJisJb+irqVbqxMQrjG7JKkDbvyhbhG+GcEp0WSW9OvtEw0cgciWhM7mXsAId4mn1Px/AqROOHxnrMaoboOizEJfFEpt27Oie/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O/zuGXmY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so92743a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057376; x=1749662176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7X54j1g90psIDWU5pz15Bdf5E+ehG4+aRIqU9eaNKxE=;
        b=O/zuGXmYL86lTvTOiAnuQF4/gKf0p+Y98HAYr+0xwH199VVC9yyaV2lE62tA+R6Cs8
         bqIwEQJOSE0tg5+W5dWjGqjCkrDgvnRQ/DKHs0zGLlLiSH8gKCTUHEBqY0NFWnWzMMWu
         k11Axp1YFpNsduAZ1/AuTKklZqwhWkOmuVmqaFfOUOnd9fN5NPrDk1EbXglzuecFxr5O
         ZRyuCj9/g5kjhApp9SjHa/B8sb3tZP5SSZt5ZCtf5n4BvOAebZeDzr1rOCStqoj2EsXL
         UjkcT3DAYadd2YUkwU6X2wBKYg2OfJfaR3OlwRQGugSo2BSQqYEuL1J54bzi49xkAFP2
         eerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057376; x=1749662176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X54j1g90psIDWU5pz15Bdf5E+ehG4+aRIqU9eaNKxE=;
        b=abseWa6xOyketEgmyyVd5e3GtFlEYAgfAgbNEoDefJ352uwhaIagIl1qkl062y1iR5
         V08Y/1n1Ud/nuXQbsl5tbBaXpumNIcQgpY6Cu87uv8b2nVlJzIJ8WnBj7X/hd6h22CJ2
         +AErmNfrgKssgIIJ1mEGU8ZLGDLH9swT0tgucNatY6YrOqaJvPBT2WNMgEDvDNrwiSH7
         iek1rsFWQERD8WpjGuY3nu3r3iXgW9WtzeChLTJJZosjWHlpAoK1X8JXfdFmOt9T4Ujh
         ATGnEqD55tyjj35ljHkkszAsiy3JcRcMaLoDN9w/ri+7550opdR7b6MBXx/BWN68e2Ln
         4O+A==
X-Forwarded-Encrypted: i=1; AJvYcCUh0IhN6ZMiAgbmSLzEkFNls91mhR2JuLNcXOJbtA1rM3OGtC/hoVGJFFd7NmmeptEFPmqOshbN6t39QTM9BjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/rn2Udn3EPXZhYYrnT3jXl4qS9Z6GF/NTSb7QHSyh/yxnDxd
	4nqzBi3W6NYJ7zcT6ojBBi+aodI93a01NHbEfQFTofLNImjMqTW1FGUm2nGE7UPGN+g=
X-Gm-Gg: ASbGncuWf91bdhwWAieI10t4EsodINX+1LMglOH8MK2AwgwxCSPUORtGBkzvuObVTMa
	W/kNTelb3Lf9HC1mNHlSVJxdgD4qnDgg2meHX9K1vvhZDHap853QB5+6lEwSUt3ynPv1+/nh8W6
	i14P6tchb819WUreEV/OkIfoE8uL2yedDQXzF2YjkVOfby/S10WhqKn+KKykRWM4n2Yjsm1dojk
	6alQskfrDPXCPrKilHvHVyunQQh6FrjSBV2QoyOF/p5uJpskEfIVhdb79NA+xOLWP9GXAP8dQK9
	tOqOUVaLFYlCAdm/rm+oN7QUI13EnA3sVFBhKwVKIuk+boi8FiHGHSfFFiKBckrMVF8a4w01
X-Google-Smtp-Source: AGHT+IHxPqIk1owtxlyp5LegtYf4MjOLT64nMI3kVgiGthtvO0lFym3JvM1rzmQWvRKFQF65n5vIwg==
X-Received: by 2002:a17:90b:28c7:b0:312:e731:5a6b with SMTP id 98e67ed59e1d1-3130cdfb38dmr4440357a91.32.1749057376016;
        Wed, 04 Jun 2025 10:16:16 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:16:15 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:25 -0700
Subject: [PATCH v17 01/27] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-1-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
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
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
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
index b7f13f087954..3487f28fa0bf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -352,6 +352,13 @@ extern unsigned int kobjsize(const void *objp);
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


