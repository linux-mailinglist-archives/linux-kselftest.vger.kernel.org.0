Return-Path: <linux-kselftest+bounces-31509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DF5A9A3B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F334463D12
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D050E223DF8;
	Thu, 24 Apr 2025 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fiVHsPJQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D06C223DD8
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479290; cv=none; b=Rc6IHh2wlJ1cvFteIkLzRWXaLUAFvQMkyeuc3+Qs1Se4KotdnjbAK0SJN2fgs0MZ+5HHst2093HlNe16Y6lVmoHY2Jivbh5gs1ndUr4MsQ+6vfIm0or0Vz1pzAW+W9+YNwF/Rqk8QjGod9WRBalm1FbwpxNrfDlUXZx2UJt5lUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479290; c=relaxed/simple;
	bh=zlFZINb76FMBoVli7x5G/rJ3gW2orU8ElvZAB3SBxII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AqKWL6JmZRcdwzrYO6ov0vDFMLkUxdpFVwpOtE/PeCAMXpUFeMUwk8WNKsABJpsx6Ij9XmSZX6xTIqLZ/8VwthJc9u4eYPSjyI2OW+pK3EskPZ++76l/gaWEiOtSW3ZU6hUQB4ZcEef4EKP0tNGEL6eF1Wj2EpLCLMNF8Xp/er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fiVHsPJQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22423adf751so7082745ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479288; x=1746084088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eeH2xWhp7150dL05xNnwhOrsm/0dm8O4b6IoAKLk28=;
        b=fiVHsPJQxvR2aPUQlNOxkEqQ9Pzg1OKJ5WeMIl/l12booTnJD2qIgl6w6yNcDtN/hm
         L1YPthvuL8ROd0HxvgxEBsyoHuMeSL1z1H17gkiGEmfGeAmc/l/6sneZzpagBKGOMy0Y
         YKkgALzOjYReeHhElSSzZHUc7ZUG4QGIPPLjaPEcrpFKFYUvQPImplR/fK/J66HFkX7x
         aIdC7gdUclq3E4TYuZa52wPYnLBpSP9D92Z9vp5I89suOdinqhFFAZ+pcBg5Pf+RDtKx
         ZzcsTb6I0Bx1yoszoP5Z630SJZx1qLvvAHBBMNZaqZ75fhYuFrLqU28vcqQ7PsdM7jRO
         31IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479288; x=1746084088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eeH2xWhp7150dL05xNnwhOrsm/0dm8O4b6IoAKLk28=;
        b=eq2+r8xLwOYflEJU7IKjeyV7t4HwfJvw5EOJCUTQ1Oxq0jApc7rj0B3kFTKXr+ycLs
         3G6ak7oHwQAlzf3/WZZmdGgWb8gUqiqnF/J+xRopmhD1tYiMyi/5Vi0It3s05RhngRHo
         EWcuCcbX/P1cWW1zWQQuCPVkIVs+Pjformmjgo7vhdbm9pOhEZLj5Z1bIQ9+unsOUEBY
         vpx2L3Hew6c0TdPmiLD38uePTAndvSWczT2xIaME+WuA6bjJ1ELmqKaGjYZB0Ea/r9Cq
         vNN0CjLYsRND+eDnxXtg1HZgGQBEKAY7dfOm09lzGhT9VzVWTh25DZ9yCtK5kEOpN3rW
         jJWw==
X-Forwarded-Encrypted: i=1; AJvYcCUz5OAcGORPNU+9N6Qv1mYoKMw8RZ126k+nV2gIDt77rBlABm7Jde1nqaD0I8SodAqsu0v+N7lGK7vrAyJqhvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTX6FqPkaeTE7lD4DBHUP4+zB7KN/e1t16b19hDKzOM4RL2hf
	BURC806ONAxZ8hDTGQ9Xzeg8y+xZX1aNMzYaox9iMT8f9q0XXxeHYPWYCSz3fJI=
X-Gm-Gg: ASbGncs8DZIllLOziw1fymqBIh2gRcesclNQ1l+ofhQKRxwbrYv42ZAQZefM45T1miV
	yA52jLtmOQJvFh6QBZrISAW8WIHyJb7h79A2uVyaoX/j4c6ZSs1w+4UuiXwuLZXk7AA9+kpJQ6H
	efRzHpgyOlYJyyTw5dOn9ijhSzSMMr4266ra3qx5/1uPV50Hgu41nUezfOSrGTWEBIDduJx0AWK
	hqQZqW7QgJZIrP4XzyiohIH7VI75LsWzOniFLdJaJKEPW54rpPQo6MCFxfu1uVUsmz+GtMDITy5
	6GIz5a05xwDQANLLpWCMlAjPuBasODqgJxIPQONfHoAq2z4B7Hq0ZRuRlTZZqA==
X-Google-Smtp-Source: AGHT+IHQaPNWR8AWB4C6qrLbgpXQ/uCnelvpmMXGyE7SN/TZw8kP+Kpttxym0RazMvhkr34F2t3brw==
X-Received: by 2002:a17:902:f64c:b0:223:4537:65b1 with SMTP id d9443c01a7336-22db3d99508mr26205085ad.36.1745479288201;
        Thu, 24 Apr 2025 00:21:28 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:21:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:35 -0700
Subject: [PATCH v13 20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-20-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index c3c1cc951cb9..c1b537b50158 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -73,6 +73,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
 #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 50)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 51)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index bcd3b816306c..d802ff707913 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -108,6 +108,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
 		EXT_KEY(ZIHINTPAUSE);

-- 
2.43.0


