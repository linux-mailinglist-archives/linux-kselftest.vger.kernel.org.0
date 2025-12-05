Return-Path: <linux-kselftest+bounces-47148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39684CA8D72
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 19:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61B0C3195D42
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E3034B1A0;
	Fri,  5 Dec 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="OdGPP9gv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F8347BA5
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Dec 2025 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959823; cv=none; b=qErGSfX6MSFhxsgSlKJqiX5/6DagsoxnLuzs3fdZuFnvrr+qbOzRJUDOCujG5fq8VoyTcP6fpbv7KAaLVd0hS0CSchopp2R2aZmJ/Hq2rGHiI2C2W2sOroZ53eqvBzsdruL5ZfS60+oia9dlXYVJIAfR5lx9zKXSWkTUP0h7s6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959823; c=relaxed/simple;
	bh=n7bR1NnVFI/AqRJ5DRrpGqIuuKL5t/EAGbECncFah4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnX+nSoILQcNOCwNys4/loMY4K9TclKBEQ0t8RQKpsfcv+7uz4cwB2y6gQ1d6zSTjwnWSYmMvVRjDK8hXaiaEF88gvhOwiexkIXi8aN0UWVgrIeof0qgInmcy2l/FqVPAFIlHd1dAjJA2tyjTDbVYY1bBqj96vG/9T7lZUjxpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=OdGPP9gv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bddba676613so1617627a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Dec 2025 10:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959819; x=1765564619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cETj36wQ9Li8D++iY1PBxUMbJIR6wBVZ7mUW8zqZ2ak=;
        b=OdGPP9gvMqICkHUNxjestrW16p8dgTnCgBtRmRY5Q1AZCcE0lvQgCKlmbRzkXJzCjt
         XE08kZYI+ycosead7s8QVubf289JEBL3DvCmcs+8T4i3AAgS0zRxdFQqeHQWMYIl65Tq
         c38Ac8mYiCcmhsYqnMn5z0EVJdgtKHenDqxXGMoAU+AyECVzDWYD/5N3JILx1MdSaHHy
         R11+C2yiaFh7tMYQd8KwaumQcsTjulOVHmYa30bIFQDZZ2gL8aqUWTAh/JBMLLnEyfia
         Ufv4ua2jME1UsuSmRUeXfehkWnAWEfQvFx82ccbO9GuSro+Uwd3958JS2z+ZKSFflM7N
         Dk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959819; x=1765564619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cETj36wQ9Li8D++iY1PBxUMbJIR6wBVZ7mUW8zqZ2ak=;
        b=GSaFiMBe7YenCxkMXaGeLPDM/u7MICllbTXU6pWM7IMgwEVXTxkUjM3xvfOitOjQob
         f/NxwxP7J0iIxtX4D1xweXrIismwoQzopFMUNkVwCibZHgTi1+LYQw9xbzg70whiFYBh
         UWBZL4Ze5cwxmxCI1RtYOag4SSqbvlTXdQ+K/nh1RQthxRLNZxmgibApm8Rtx+Ud5kFO
         /G1zEF1HLRq/cIp4ECxf/RwBVDeErvqLrycISbz8BeOrqxItvHyqzf0+aWr6rfDAq7B6
         RiQrSBDdOupJ4zndCPmENWB0Ey06Wc3ZlgEHuEWkN+oxl3Sa2tT2PAz80KPChhKwMJ8I
         c1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZp9t2SFX6PSATupwZyNM5f54PQJJUjHzxYgRGdK25XQ7fcsnjw6Erv7nBz+M6FP7i6znb9iQTZ+uGT5a6TG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxAS0tqKNmRXwf5nrdOQ3Brdc4vwsENYT4EL3ppT6+hQDZBQta
	Q1uzAwE1PuaeytqzjXCDmwEcYBCTnw5ivgsVJubc2byqfzQ0KihXqwTrn7JMheumaJA=
X-Gm-Gg: ASbGnctA8eSgnd5ESVIeGxT+9L7BB/iZn2uFwlnQO8m4TgQFuNdyRo717P/J5elVaGu
	x5Fu651I/IayUnCakdftWvqod/mp8uEdnSbRiWux5RUxrLlnzM5IBBdirfZc8m5Izp6jgMp7WRh
	YDqqdZW5wn2MM0pZeQm/VgoLmRCWkQRImO+zKeGVpOm/xZ7WeCNDKxWIegwN6EwfFL7Tb/sr2dS
	+yG7ffxF0m9pWcRMFGNk8cilZ7arrYJYBeXdFgP5lx4PohdJ8a0zRDWb5soG2N7m68Fq/f/qnKM
	O1aGTsYesLEqDTOWxhjBxWBQByCwnou3cA7Z/yWYaB0521rIcNG6apDi5CqPjYkvWSDBw0LhJZB
	kr0Uvw4HoU/nGjb3pukFI0gDplnEDuKJO3Wm4YHqfv4k265wUNeLZPyrBrbTPduTpT90Y4EPwXF
	FgeXYXTUYtxBs4PsrC9Y2L
X-Google-Smtp-Source: AGHT+IEkzbnT/WgOlempvP3hpilfiz+Q71aHJSWUM26fnmV95b/U/OPvqEShn/bm1V+eS1bH7ZJBNQ==
X-Received: by 2002:a05:7301:7389:b0:2a4:6488:7a91 with SMTP id 5a478bee46e88-2abc721e3aemr63588eec.37.1764959818484;
        Fri, 05 Dec 2025 10:36:58 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:36:57 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:36:50 -0800
Subject: [PATCH v25 04/28] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-4-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=2422;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=n7bR1NnVFI/AqRJ5DRrpGqIuuKL5t/EAGbECncFah4k=;
 b=31A6j7PC6Y5du6FtyG1Tip5TQTReoqkkZmO7mrZz/KN+VapztQ/ClG5jXhF8oJEHAJfpgvSh7
 Wdgdq2HWZ/wBlxT7xVvM72WWT8CT9lmclkSWtwU4fMwFZ3NA1iNoLlQ
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

zicfiss and zicfilp extension gets enabled via b3 and b2 in *envcfg CSR.
menvcfg controls enabling for S/HS mode. henvcfg control enabling for VS
while senvcfg controls enabling for U/VU mode.

zicfilp extension extends *status CSR to hold `expected landing pad` bit.
A trap or interrupt can occur between an indirect jmp/call and target
instr. `expected landing pad` bit from CPU is recorded into xstatus CSR so
that when supervisor performs xret, `expected landing pad` state of CPU can
be restored.

zicfiss adds one new CSR
- CSR_SSP: CSR_SSP contains current shadow stack pointer.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 4a37a98398ad..78f573ab4c53 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -18,6 +18,15 @@
 #define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
 #define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
 
+/* zicfilp landing pad status bit */
+#define SR_SPELP	_AC(0x00800000, UL)
+#define SR_MPELP	_AC(0x020000000000, UL)
+#ifdef CONFIG_RISCV_M_MODE
+#define SR_ELP		SR_MPELP
+#else
+#define SR_ELP		SR_SPELP
+#endif
+
 #define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
 #define SR_FS_OFF	_AC(0x00000000, UL)
 #define SR_FS_INITIAL	_AC(0x00002000, UL)
@@ -212,6 +221,8 @@
 #define ENVCFG_PMM_PMLEN_16		(_AC(0x3, ULL) << 32)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
+#define ENVCFG_LPE			(_AC(1, UL) << 2)
+#define ENVCFG_SSE			(_AC(1, UL) << 3)
 #define ENVCFG_CBIE_SHIFT		4
 #define ENVCFG_CBIE			(_AC(0x3, UL) << ENVCFG_CBIE_SHIFT)
 #define ENVCFG_CBIE_ILL			_AC(0x0, UL)
@@ -230,6 +241,11 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/*
+ * zicfiss user mode csr
+ * CSR_SSP holds current shadow stack pointer.
+ */
+#define CSR_SSP                 0x011
 
 /* mseccfg bits */
 #define MSECCFG_PMM			ENVCFG_PMM

-- 
2.45.0


