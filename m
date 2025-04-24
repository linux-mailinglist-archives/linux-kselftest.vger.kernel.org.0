Return-Path: <linux-kselftest+bounces-31504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1762EA9A394
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFED4639D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DAB21FF23;
	Thu, 24 Apr 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Qm5kpKDT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1521D5A6
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479277; cv=none; b=o0eBaFewX0pPzAB+xbKxIIvhUyZfTwpwEnBwLSo/uoVq8LT62xTBwW4NqcwwghIDteSy2VMYkYh9OZ9sWhgEFLh6BzInXrzEdWcS4mCgmY7P4m6O5AfzztfKBEDYKprO31mYH5Lv7MmZaDOy6z84QYa8g47URvkXQsZz763HUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479277; c=relaxed/simple;
	bh=5YvrVTsSlhPnygHyY70JOYrzgqWZtw6Xz6pUq2DcWT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIgpGrtJ7AQSURoVVby/hK3rewJBC/k6XcaxJ7I7YQgoJK0ka4uEomUJa6vOOK9lvMn7nTGSd8WzYqAfQGjZfQqaYEgqs6rFOsLh6i8CTPpfDMcCqIkzjXC3IhzFti4G0SCoBGXNU8/UMErxPUR6LcOeJhl7+SA+y03vQF/k3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Qm5kpKDT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22435603572so7547085ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479275; x=1746084075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41v4E7ga+ZFzPbByHXLYifyQZM5AuT/Tz2JN75Nn7jw=;
        b=Qm5kpKDTv+7kmKJADYvhcm7deNOGmWMpyhCoe4hLNbACVdgm3iaoFLcQA45zl2i9mt
         bB4m+mkdHtW3oVoGYyCs/0UCHw9hEiI0hH2w5AlrY5TNBdchdoi3ht+AufyEKIF02YYp
         V5h2aaRHv2tgjYQ+K6lPCbiB5fR9zXYJEXIPa6aHR/GfQ+5SPoZLqa3kgfSbwn+FMaQ7
         De8S8SYIWZCYJdDJ2d2QdGq07DYXpAgg2wRpB+9t1A9mtuy+9371zwApjNXwcELO56fg
         os2zslUVNtbUiFgKIDkzsZqPTVYQVXwHUWukD+JyBDwbcJjqRSG4Pg4OPwkEl+j0IpLw
         zMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479275; x=1746084075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41v4E7ga+ZFzPbByHXLYifyQZM5AuT/Tz2JN75Nn7jw=;
        b=AHbEiZt+Eq74eUKfah0Bw4g0Xmp2cwYKT/UOpi24qwjHkX+UJYMiE6WNxA8d5dLAiV
         F+AadGVWt8/f6PMDODdENqtabvFPnI4nthGRNgklKO3fIu9dbF3BkLHKLmTuwdH/WLUl
         0nJAL2HDFaVwlk1qeJPjE//WrjkigGlbG5zvJihVOlDAHsx9o5n2pHcaVUCDX2TZ1u1r
         JTTjgFsjQ9D3emJuk8jyXVczNELkhtmfKYoaVL7iUD2rKxF3l0lpJ36HrI530kaZq5tw
         OlB+YedmnIuragbkZW3iEjPkhNILbtIglSkIYrUPgwuesyeTY6D8cFU7UyZtLu0st+7l
         G0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZOa6DBU/Ag7dSt4UWJx1lnOEpu7OaV6GnxGj9AAkau6FiJfkKUn/uq4ojSy6udSg/Cbxiv1RCdHb04vg1AqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysZMokeZNE786DM0kRmvKqMjuwFCJRnY8EwYFI/NPjIit6oEPd
	4Gb7BgtkSY1KH0FnOVxJYSjx1wqIzLukk17gkB/PT3RbCb1XZc8pCSR6NNV+rAY=
X-Gm-Gg: ASbGnctIyPTV7EvVNkWVz20zQ3AL/WvhU8EwH8YhPOO3+m1hlT8gFMqX4CYggnlz610
	+5Rn7bJ1w+wh8e1qTXxqqYXHnaSJhD3GF5NGBsqSfJsxqVOdzKkYsw7c2LnfUQ8YDM+aAQhdsIh
	nyNb++NUtyIN3IChr4PP59J1a3nLEuI79BcEL6ntUT+VTglDEwgOSFLZ3uqCTF9IATD81jGCK6r
	po265l7y1e/SxHurUtaV+a4WpWmJclTjyFJurSxtEolOPkDP+UOnfLcyfnqoY43z3zUJgZDkv8G
	q7nacZazMm8aGTZtdmGCY67Kem+RI5rwEiERewgCYRkicLuDC9BRIHQayPABwQ==
X-Google-Smtp-Source: AGHT+IG7mw5kM3A7JF7yXhsREItsbjvUMsakyfD3ulI1IpW0IVgA9l0SFzQdVfIWwOREJNL+l+daLg==
X-Received: by 2002:a17:902:f693:b0:224:216e:3342 with SMTP id d9443c01a7336-22db3db5763mr22507105ad.43.1745479274622;
        Thu, 24 Apr 2025 00:21:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:21:14 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:31 -0700
Subject: [PATCH v13 16/28] riscv: signal: abstract header saving for
 setup_sigcontext
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-16-971437de586a@rivosinc.com>
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
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org
X-Mailer: b4 0.13.0

From: Andy Chiu <andybnac@gmail.com>

The function save_v_state() served two purposes. First, it saved
extension context into the signal stack. Then, it constructed the
extension header if there was no fault. The second part is independent
of the extension itself. As a result, we can pull that part out, so
future extensions may reuse it. This patch adds arch_ext_list and makes
setup_sigcontext() go through all possible extensions' save() callback.
The callback returns a positive value indicating the size of the
successfully saved extension. Then the kernel proceeds to construct the
header for that extension. The kernel skips an extension if it does
not exist, or if the saving fails for some reasons. The error code is
propagated out on the later case.

This patch does not introduce any functional changes.

Signed-off-by: Andy Chiu <andybnac@gmail.com>
---
 arch/riscv/include/asm/vector.h |  3 ++
 arch/riscv/kernel/signal.c      | 62 +++++++++++++++++++++++++++--------------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index e8a83f55be2b..05390538ea8a 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -407,6 +407,9 @@ static inline bool riscv_v_vstate_ctrl_user_allowed(void) { return false; }
 #define riscv_v_thread_free(tsk)		do {} while (0)
 #define  riscv_v_setup_ctx_cache()		do {} while (0)
 #define riscv_v_thread_alloc(tsk)		do {} while (0)
+#define get_cpu_vector_context()		do {} while (0)
+#define put_cpu_vector_context()		do {} while (0)
+#define riscv_v_vstate_set_restore(task, regs)	do {} while (0)
 
 #endif /* CONFIG_RISCV_ISA_V */
 
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 94e905eea1de..80c70dccf09f 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -68,18 +68,19 @@ static long save_fp_state(struct pt_regs *regs,
 #define restore_fp_state(task, regs) (0)
 #endif
 
-#ifdef CONFIG_RISCV_ISA_V
-
-static long save_v_state(struct pt_regs *regs, void __user **sc_vec)
+static long save_v_state(struct pt_regs *regs, void __user *sc_vec)
 {
-	struct __riscv_ctx_hdr __user *hdr;
 	struct __sc_riscv_v_state __user *state;
 	void __user *datap;
 	long err;
 
-	hdr = *sc_vec;
-	/* Place state to the user's signal context space after the hdr */
-	state = (struct __sc_riscv_v_state __user *)(hdr + 1);
+	if (!IS_ENABLED(CONFIG_RISCV_ISA_V) ||
+	    !((has_vector() || has_xtheadvector()) &&
+	    riscv_v_vstate_query(regs)))
+		return 0;
+
+	/* Place state to the user's signal context spac */
+	state = (struct __sc_riscv_v_state __user *)sc_vec;
 	/* Point datap right after the end of __sc_riscv_v_state */
 	datap = state + 1;
 
@@ -97,15 +98,11 @@ static long save_v_state(struct pt_regs *regs, void __user **sc_vec)
 	err |= __put_user((__force void *)datap, &state->v_state.datap);
 	/* Copy the whole vector content to user space datap. */
 	err |= __copy_to_user(datap, current->thread.vstate.datap, riscv_v_vsize);
-	/* Copy magic to the user space after saving  all vector conetext */
-	err |= __put_user(RISCV_V_MAGIC, &hdr->magic);
-	err |= __put_user(riscv_v_sc_size, &hdr->size);
 	if (unlikely(err))
-		return err;
+		return -EFAULT;
 
-	/* Only progress the sv_vec if everything has done successfully  */
-	*sc_vec += riscv_v_sc_size;
-	return 0;
+	/* Only return the size if everything has done successfully  */
+	return riscv_v_sc_size;
 }
 
 /*
@@ -142,10 +139,20 @@ static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
 	 */
 	return copy_from_user(current->thread.vstate.datap, datap, riscv_v_vsize);
 }
-#else
-#define save_v_state(task, regs) (0)
-#define __restore_v_state(task, regs) (0)
-#endif
+
+struct arch_ext_priv {
+	__u32 magic;
+	long (*save)(struct pt_regs *regs, void __user *sc_vec);
+};
+
+struct arch_ext_priv arch_ext_list[] = {
+	{
+		.magic = RISCV_V_MAGIC,
+		.save = &save_v_state,
+	},
+};
+
+const size_t nr_arch_exts = ARRAY_SIZE(arch_ext_list);
 
 static long restore_sigcontext(struct pt_regs *regs,
 	struct sigcontext __user *sc)
@@ -276,7 +283,8 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 {
 	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
 	struct __riscv_ctx_hdr __user *sc_ext_ptr = &sc->sc_extdesc.hdr;
-	long err;
+	struct arch_ext_priv *arch_ext;
+	long err, i, ext_size;
 
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
@@ -284,8 +292,20 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 	if (has_fpu())
 		err |= save_fp_state(regs, &sc->sc_fpregs);
 	/* Save the vector state. */
-	if ((has_vector() || has_xtheadvector()) && riscv_v_vstate_query(regs))
-		err |= save_v_state(regs, (void __user **)&sc_ext_ptr);
+	for (i = 0; i < nr_arch_exts; i++) {
+		arch_ext = &arch_ext_list[i];
+		if (!arch_ext->save)
+			continue;
+
+		ext_size = arch_ext->save(regs, sc_ext_ptr + 1);
+		if (ext_size <= 0) {
+			err |= ext_size;
+		} else {
+			err |= __put_user(arch_ext->magic, &sc_ext_ptr->magic);
+			err |= __put_user(ext_size, &sc_ext_ptr->size);
+			sc_ext_ptr = (void *)sc_ext_ptr + ext_size;
+		}
+	}
 	/* Write zero to fp-reserved space and check it on restore_sigcontext */
 	err |= __put_user(0, &sc->sc_extdesc.reserved);
 	/* And put END __riscv_ctx_hdr at the end. */

-- 
2.43.0


