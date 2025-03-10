Return-Path: <linux-kselftest+bounces-28602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2663DA5983C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8CF7A2C39
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F2022D4D5;
	Mon, 10 Mar 2025 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qT8njxvc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF46522371A
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618357; cv=none; b=gHm3i1WrR6UBvaLvQg1zoFoyOqhIvy+7DJojHuMrl9i3Ff+FmTudpUgkVh1K7VUoSPGPETe3eWx7zltfNjivw/tarZ6F4QJW3MCEG2OO/HRhj+F0+HL3Pw5IAeeXrdmjUEzV9CQNnkATjj+rn4bfoulFT9wQVvBZRZCEKqL+DWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618357; c=relaxed/simple;
	bh=fvZEXse498MAei+juRUqd4/R9FeoMw38NPBzNnBXz58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XeTAtr9oOZVFOAVZBiDLNRsiJRUHp4O4rCBCMMou3pPzCHXyTY0DU54jdczZ8heZx48yyGX2n6Hhs4hGy2enwmzA50xLjAI9niabZ9tzwXEqP2Bge4Dd0e4jdfz0l3coQ427MN/6uMXzzG4FocoIH6EbGFfX12MnOfA7uoRaHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qT8njxvc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2234e4b079cso76854955ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618355; x=1742223155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ADFXc53D/cc0VutYfr8tgUjvI5cmEZUhOUtSZhfaHM=;
        b=qT8njxvcFWywG74UVYmqzi+wSnsvfdw3Uv7Oqs6yTatlDi7wXNGpKuHM2kvPsw3ijb
         +l33qtxvqgiLvjXowL9sNa7A42FMbI/UPW3tQkupYq7mbR+MS0JpCMGW/EBBdm7O2NtF
         4uUq2Pnn6gb+sykYVaGeSTx/Gjx4NYx8u/47/ZfVKQGhZuPGFVwSPBcIXkS+oanJceUh
         +2XFVVjZDm5szukXs626lde7nfrfjIkzt3NLhvXhtDNmmxIEzVnz20MUJMYy0S72UyVD
         XqwxHOE6mJp9sGmrVBLUuLONPoEQser0ZpgrgLfVLYMZjpo+M0aEMrRSLQ1grYcop58a
         WpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618355; x=1742223155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ADFXc53D/cc0VutYfr8tgUjvI5cmEZUhOUtSZhfaHM=;
        b=sESMJsA7Hjc8u4b0el+7hu8L6QfHzMqtmpMtKd4t5e/As8JaKXowtuKfPJ3MTq6vHz
         10Pf24uWY34j/JOOTrQPIW8KPmB93hKIUWDd4d3b0Hzf7uq2A490p7l9ETFifypePlGD
         aQuEy7kNf+SzR3g1GrkIUfJ52oB9ogGBNfTnSItL2CsSkUwiED3xg5IwH+HZksnhtIKk
         k9zbr14JNmjfWoYgTE05EsOoRvQxHuSH4EMey5cqqWSu7NrWVmINcqtycNx9rJmvYmuy
         YFV6xULXylN+2A0xjR7ud2kdn30f5z3F5B5HYUfBUawgFXZaN+1OxN92dU6nQMaxYDwr
         Xv6g==
X-Forwarded-Encrypted: i=1; AJvYcCUxfDQqYryYfcFfICRg0M4VyJlayzD/gat/EV/zaAHrBknM4j/yMseO8KfhI5FrT3QBZ2hFE534RWWSs8Hy9tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOpghs47mJ2zw7922KlzQslNt/xHp7XuCKNRoqTDAP8nCWYxR
	8I8koNq4ch/OCOJIx3AVSa1snghYX9O5rBm2QwJv0TNMhgQQIhzl6pcjPPEEKK8=
X-Gm-Gg: ASbGncsfMVK1ByKXeBRqkhmE85F9bjDOa+UZI5fTeU4H3M4zHMylouCUWdzBRyxtM59
	W89zNl6jo7aiW8d8jGIRYMheD8NvCL1Y1WlpCaWj1NlLFAz/C6eRbZs/QKD4dUAZ1pCtCKvbiLr
	4536C9AvS89O2QoOpWE5KygtnHXqnteCpjTW1J/W5vVLwL3BO6+9yCivvkVjS+961zheXjaRfx9
	ZhakV+GfnJdABXYgxSQzgdihurZxl9xdMLQ3DLQNH5eR3aSqjWZKMSwhpAOunBjwQbdtvNTnlnQ
	xTdraEtcagQtueSO0VpN4iCe8GlfWcuPMD55XWxlghlgcrirgYRfGl8=
X-Google-Smtp-Source: AGHT+IGmALl7tE1vDAuhwzUIZXgg+Q9w22Wqj1GO54eJLmN8OylP52nRYF70/T1mCfLbdEp2H00RTw==
X-Received: by 2002:a05:6a21:4606:b0:1f5:7df9:f147 with SMTP id adf61e73a8af0-1f57df9f49dmr7380018637.40.1741618355060;
        Mon, 10 Mar 2025 07:52:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:52:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:23 -0700
Subject: [PATCH v11 01/27] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-1-86b36cbfb910@rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
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

VM_HIGH_ARCH_5 is used for riscv

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


