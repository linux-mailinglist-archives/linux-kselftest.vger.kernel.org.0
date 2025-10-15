Return-Path: <linux-kselftest+bounces-43238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59687BE01F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2DE583E3B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76718350D45;
	Wed, 15 Oct 2025 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="GjYN+CL3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B734DCF5
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552073; cv=none; b=qIjvutlazQlXTvAEn5G4pQiSCz69JRDYsw8Fuir91xO8zMQtr6JMGwLW5m6fLQGKroRufQKzYkpycC20ORYTYkeNPR9fOIL86y54pEJBj0ISp/6S69RoABxXj/51WbDqC+K8jWjkaZ5dGbOnb3umMu8FaprU6XB1oWxX/Sa10bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552073; c=relaxed/simple;
	bh=I1jqcPRPd1hxfvYCXrKsXB3tX7WWaFK9J8/4Z0z3BE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmnEj67Toern7WswbFCQUKACPa9zIdGatLyBv9IsJTfeKKQYbbcHLSjv2bt3fPFXc7BadFSqaRs+estzY/FUz4yyr2sYI72zpOkNQPZxMzSx5jSJH7SwMbWSF6VtbfHmxYtIVE5kStt+zmEy3DD/JmxDsC2LClSVHOEECXxME0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=GjYN+CL3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26983b5411aso47567875ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552069; x=1761156869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlTCabZFxINt6Lm9QbVDHZ4MzlWsICTGzKM8x7gyE4c=;
        b=GjYN+CL3jeLDRhF3Z66apJUIhzmco+PPsSywbdqybXmwSgTEvMmUhuzAPgDMYELbzo
         NZm2DOu+c9smkjaJFkFzaJHwOusXqzJlxTe+xc1X9Hlgd4fTRNMvqRnh5qZ3ZbSjUJQ2
         MzQPKqAz0iVpC1dkcnQYWNEj42S8WZRV29tA0hUKpGtx7asQAbwVfwsYtm9ccdHPSeFj
         9PM5983xku0jqQq5ULbsr3eh8QmwMej9l5e8lrOZQoxdeZPVkYeVEutCfE7fvKFTcHJu
         44y36eaR7tl7HyVUw2eUWol4SA2kHvfxfa3Prg0c19MQ033rPaIJ4Uott+jGORpDYDBu
         ud3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552069; x=1761156869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlTCabZFxINt6Lm9QbVDHZ4MzlWsICTGzKM8x7gyE4c=;
        b=HUr1C7LIViBfcOPz5+KflGyjnZdZuXqHFmZ0p6TuaqFfmQ+jLZxr7K5GJssLvlSuSj
         vejvyjLJvsv9fSubx6QF4Ax/Xr39OJzDl8iO/LWm0L+/KXN4No+V63jjjaguMJ9O8O6n
         rb63a1Sodo7U3P7t3E8FkjPHyVdz/4Jo966H48EY6eTQK1wcRGBbO6nfs1ClNH+qoaTt
         1FOK2QUkua9h1iwC8VTl7lGXt5k+dfZs8cGXmgvjVjZ5AuQaIHgo3JkvsqwsqKhn3sk4
         8hS0nJ1C2fHSenHA5Ymj+yPcDPMWniMl74r3+LMb8+bDZmOJlFnnwXhd5CALh7qTluHt
         B9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXcfaIbcI4ndqezNGgTBpdYo0gGmKyexieYEbTqEkEucefuA7SqjTpSvKyZvzRa2EG66yCtVFPB1ZS3aEdoKI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/tC/15T9Z4hME1OJUErL6Mt1TzVS5/yhp0W5P7KjPCNCb5bv
	wzaR7WUskJdOI8l+TvQfyQmuvSvQm1M7979MLjxf5D1n2Kd718VxtPTkQkBlu1tJxw8=
X-Gm-Gg: ASbGncv499D/3KsFu7oAovcjjmLn43zrGaSaHsXydvn6rW0qF+EliV/zBSOWH1BPI32
	Bxe11nx0wyaJB+B3wbVygQRNeedlkW+7tabTNsHwkjT0XArg8XJ984ge3UiDdNjTwaIP6lsWryU
	A1YeVfGHQFQpkJPwmwZk5Rfd5oaCzAKdsz1oPEgh77a50eJZS1rKqKf39UsvURa9kOC/QwQ89ua
	ND9ZI4H39VO8SGM/NRgo9lOxkc+pnb2/FJpgGMNIF3s47KeTuRoHCuSHN4Mu1kZAVopX/EEciwy
	XxvtVIDU0Et0kRktYQRzScBA0/igtNiGj6NHoUSBZLcvSqPJgnN866vhGpjQ/NXoeNSt6eLSAaF
	QAYwsgLosi7/xduIdGSPq3bV4ZwjuFvs+4GXlqmLurYNNAI+0Jug=
X-Google-Smtp-Source: AGHT+IHEXT5xfzaQ9E7GA47DV8y7VdpAtjfIT1LAxVPzv4De3A/Ut9fEGvcfd0ReXWhAXtZ/RL7Blw==
X-Received: by 2002:a17:903:2acb:b0:268:1034:ac8b with SMTP id d9443c01a7336-2902739ad00mr410312175ad.26.1760552069224;
        Wed, 15 Oct 2025 11:14:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:14:28 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:52 -0700
Subject: [PATCH v21 20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-20-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
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

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 5d30a4fae37a..0efc9c7d1199 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -82,6 +82,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 56)
 #define		RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 57)
 #define		RISCV_HWPROBE_EXT_ZABHA		(1ULL << 58)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 59)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 60)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 000f4451a9d8..d13d9d0d1669 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -114,6 +114,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOM);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICNTR);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);

-- 
2.43.0


