Return-Path: <linux-kselftest+bounces-31990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A2EAA3F52
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2F1189B177
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445E26659C;
	Wed, 30 Apr 2025 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="W4/WeOPX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318B264FBC
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972244; cv=none; b=lg6dx/u5SdKOzBU2MQ12bqn8hP9oDpADeYrEVSc+yw+3uQPZtt9moYfEI6G3juCgwGM26LYUOCY/1lzDhyhhgupok3jMAg55LTb9rZ2+0GEnL44thxkphjTNKUMVukoMjRQKDkiEQH6ssQewPiihBKEdcjknlADoAuzaaECLRko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972244; c=relaxed/simple;
	bh=gg2vJdQgN9X+9gIUXwpUpI2GPYjg2wVSASLNhtMDlR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikRxI7WxWxw9PdVJXZiowpD/xsv27+vfwDFMEplEGD2vKCpsd3xQ4WwnBeZSSPcrjRT1GjgzTtNMS/8VkPiwoyBloo3SW3tvkMAYtGlTLbuFjv1uGAYStiC965O8FT0a2ZsuJgH3wt7ZCSbyxA6i5siOxkpXz6PSlY6rHJ2fEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=W4/WeOPX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33e4fdb8so71133965ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972240; x=1746577040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5J/5mZxT+k+LmAKU7G8MkVD/8s7ODhQZCUl5WVjl9l4=;
        b=W4/WeOPXbPEFpr/7o60qaeEyv3FBWP/wnfPTRphxjueOGVydnE9B1XLD9cwxtVuSbW
         ON6k2iS60pm82DD03UnlDN05gBtt/qfDNN/R8e2DxTjX5unHKHfDur0CBoIF/+v49Wlh
         o4zudPf3L37DADpjEovY/eZpeJvTBnUFElcSgXLoWs9fJJwmoXygkGBgbxMmMXbWsuF8
         wwHKCldv3Os/Q5wIrk1mKtPO/r3ACHitzCE4ImTDzawZKT7/iweHB749NRn/WG4ez61l
         +uFtiQjXWMBVlKv8Hv52pgAY/PvTweeecV9tly6A2lT/y9hM+wQ1/giMWRmDvK/O//YM
         +bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972240; x=1746577040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J/5mZxT+k+LmAKU7G8MkVD/8s7ODhQZCUl5WVjl9l4=;
        b=UTiR3qJ85iub8unmwn9SaIUSAXGgpvK0T7woJeBgKsQafmkSGZ6Adm6WjEIvo6d1Li
         pZNKd9or+n4xovnQ2Ve8w7AGxu+0/tfmj9I8wkYH8OBMgZo2qTTgrLoEmkl+JXGxlLi6
         2nch/AUUZjLPpIcYg4jorqxdLcINPUJfznp6dGP5yjsZqmNmC8M33eRu1ZxO73T78fyH
         b1pJ4Rx259zfI13dhj0ZxPVe8toqmyG09ky8S6JlyHp91QR0sDSQacOrfV8hhog75bDH
         h20jrAr/SEpEsy8mDuktws20Ev8bPHCSuyFdFo238TapoQiU9IxmcAgUXFQT8S0CCp8K
         b/cA==
X-Forwarded-Encrypted: i=1; AJvYcCWfSodP5JKG1jOoZQp7OUzuQSuxfFSuL6Aepu0jRvoj4n6IQAlg50hAPbB+XrxrVqkoVsTSlNHvIAbqMT83c+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCro7gD0byuRKfX68RS0K3yfYJPAlPu1AKaR6+bAtsUsNrw0aO
	HWLnZpfM6OMGSofQWlNdiyuN0qzcarmxUwOZesTJorzp3HqtGnG0UOi5i1pBgfs=
X-Gm-Gg: ASbGnct1L/n6ad6ibtpk5Cje7RHg1XPzxdpH4924F5gdUnll4Rv8kQkUZwLky8CYHHN
	FpWu6Uin77jD651NR9p0GoJWdLTUarM7Avk6bSv7QWICyo2/zgzb0Ef6vpbSAs8NjrI3VNdRaVn
	KKgAoQQM3nQJ7+0Ys0aYNbnifcysj+s5Umsvh4x2MS5MzsNOMgpBXI8H9WL/NAvuWV5KXk/jKOu
	37jhH/BrRCpiwvIsHGg0s9V0RdVbCHWMHSIiConn19Gf7hHYGKIu4ZERyNpCkpiNXGhWemA7bO/
	Mbbwd6TQfYAPBImTBiShse08vJTxlSqdM2T84IKhCFjmmTO369E=
X-Google-Smtp-Source: AGHT+IHUsd3WrSJ9gmGyyVk1RxhM9S+Uh5Mwx3YhJbCfwhMaqV/yOZGZCO9itWeSGD50TlYFP578aw==
X-Received: by 2002:a17:902:f611:b0:224:78e:4eb4 with SMTP id d9443c01a7336-22df356e711mr16382915ad.39.1745972240329;
        Tue, 29 Apr 2025 17:17:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:17:19 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:34 -0700
Subject: [PATCH v14 17/27] riscv/signal: save and restore of shadow stack
 for signal
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-17-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
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
 Deepak Gupta <debug@rivosinc.com>, Andy Chiu <andybnac@gmail.com>
X-Mailer: b4 0.13.0

Save shadow stack pointer in sigcontext structure while delivering signal.
Restore shadow stack pointer from sigcontext on sigreturn.

As part of save operation, kernel uses `ssamoswap` to save snapshot of
current shadow stack on shadow stack itself (can be called as a save
token). During restore on sigreturn, kernel retrieves token from top of
shadow stack and validates it. This allows that user mode can't arbitrary
pivot to any shadow stack address without having a token and thus provide
strong security assurance between signaly delivery and sigreturn window.

Use ABI compatible way of saving/restoring shadow stack pointer into
signal stack. This follows what Vector extension, where extra registers
are placed in a form of extension header + extension body in the stack.
The extension header indicates the size of the extra architectural
states plus the size of header itself, and a magic identifier of the
extension. Then, the extensions body contains the new architectural
states in the form defined by uapi.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/usercfi.h         | 10 ++++
 arch/riscv/include/uapi/asm/ptrace.h     |  4 ++
 arch/riscv/include/uapi/asm/sigcontext.h |  1 +
 arch/riscv/kernel/signal.c               | 86 ++++++++++++++++++++++++++++++++
 arch/riscv/kernel/usercfi.c              | 56 +++++++++++++++++++++
 5 files changed, 157 insertions(+)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index cea7908cdb3a..68da5b7b79fd 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -8,6 +8,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 #include <linux/prctl.h>
+#include <linux/errno.h>
 
 struct task_struct;
 struct kernel_clone_args;
@@ -34,6 +35,9 @@ bool is_shstk_locked(struct task_struct *task);
 bool is_shstk_allocated(struct task_struct *task);
 void set_shstk_lock(struct task_struct *task);
 void set_shstk_status(struct task_struct *task, bool enable);
+unsigned long get_active_shstk(struct task_struct *task);
+int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr);
+int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr);
 bool is_indir_lp_enabled(struct task_struct *task);
 bool is_indir_lp_locked(struct task_struct *task);
 void set_indir_lp_status(struct task_struct *task, bool enable);
@@ -71,6 +75,12 @@ void set_indir_lp_lock(struct task_struct *task);
 
 #define set_indir_lp_lock(task)
 
+#define restore_user_shstk(tsk, shstk_ptr) -EINVAL
+
+#define save_user_shstk(tsk, saved_shstk_ptr) -EINVAL
+
+#define get_active_shstk(task) 0UL
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index a38268b19c3d..659ea3af5680 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -127,6 +127,10 @@ struct __riscv_v_regset_state {
  */
 #define RISCV_MAX_VLENB (8192)
 
+struct __sc_riscv_cfi_state {
+	unsigned long ss_ptr;   /* shadow stack pointer */
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
index cd4f175dc837..f37e4beffe03 100644
--- a/arch/riscv/include/uapi/asm/sigcontext.h
+++ b/arch/riscv/include/uapi/asm/sigcontext.h
@@ -10,6 +10,7 @@
 
 /* The Magic number for signal context frame header. */
 #define RISCV_V_MAGIC	0x53465457
+#define RISCV_ZICFISS_MAGIC		0x9487
 #define END_MAGIC	0x0
 
 /* The size of END signal context header. */
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index a5e3d54fe54b..1bcda11e0680 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -22,11 +22,13 @@
 #include <asm/vector.h>
 #include <asm/csr.h>
 #include <asm/cacheflush.h>
+#include <asm/usercfi.h>
 
 unsigned long signal_minsigstksz __ro_after_init;
 
 extern u32 __user_rt_sigreturn[2];
 static size_t riscv_v_sc_size __ro_after_init;
+static size_t riscv_zicfiss_sc_size __ro_after_init;
 
 #define DEBUG_SIG 0
 
@@ -140,6 +142,62 @@ static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
 	return copy_from_user(current->thread.vstate.datap, datap, riscv_v_vsize);
 }
 
+static long save_cfiss_state(struct pt_regs *regs, void __user *sc_cfi)
+{
+	struct __sc_riscv_cfi_state __user *state = sc_cfi;
+	unsigned long ss_ptr = 0;
+	long err = 0;
+
+	if (!is_shstk_enabled(current))
+		return 0;
+
+	/*
+	 * Save a pointer to shadow stack itself on shadow stack as a form of token.
+	 * A token on shadow gives following properties
+	 * - Safe save and restore for shadow stack switching. Any save of shadow stack
+	 *   must have had saved a token on shadow stack. Similarly any restore of shadow
+	 *   stack must check the token before restore. Since writing to shadow stack with
+	 *   address of shadow stack itself is not easily allowed. A restore without a save
+	 *   is quite difficult for an attacker to perform.
+	 * - A natural break. A token in shadow stack provides a natural break in shadow stack
+	 *   So a single linear range can be bucketed into different shadow stack segments. Any
+	 *   sspopchk will detect the condition and fault to kernel as sw check exception.
+	 */
+	err |= save_user_shstk(current, &ss_ptr);
+	err |= __put_user(ss_ptr, &state->ss_ptr);
+	if (unlikely(err))
+		return -EFAULT;
+
+	return riscv_zicfiss_sc_size;
+}
+
+static long __restore_cfiss_state(struct pt_regs *regs, void __user *sc_cfi)
+{
+	struct __sc_riscv_cfi_state __user *state = sc_cfi;
+	unsigned long ss_ptr = 0;
+	long err;
+
+	/*
+	 * Restore shadow stack as a form of token stored on shadow stack itself as a safe
+	 * way to restore.
+	 * A token on shadow gives following properties
+	 * - Safe save and restore for shadow stack switching. Any save of shadow stack
+	 *   must have had saved a token on shadow stack. Similarly any restore of shadow
+	 *   stack must check the token before restore. Since writing to shadow stack with
+	 *   address of shadow stack itself is not easily allowed. A restore without a save
+	 *   is quite difficult for an attacker to perform.
+	 * - A natural break. A token in shadow stack provides a natural break in shadow stack
+	 *   So a single linear range can be bucketed into different shadow stack segments.
+	 *   sspopchk will detect the condition and fault to kernel as sw check exception.
+	 */
+	err = __copy_from_user(&ss_ptr, &state->ss_ptr, sizeof(unsigned long));
+
+	if (unlikely(err))
+		return err;
+
+	return restore_user_shstk(current, ss_ptr);
+}
+
 struct arch_ext_priv {
 	__u32 magic;
 	long (*save)(struct pt_regs *regs, void __user *sc_vec);
@@ -150,6 +208,10 @@ struct arch_ext_priv arch_ext_list[] = {
 		.magic = RISCV_V_MAGIC,
 		.save = &save_v_state,
 	},
+	{
+		.magic = RISCV_ZICFISS_MAGIC,
+		.save = &save_cfiss_state,
+	},
 };
 
 const size_t nr_arch_exts = ARRAY_SIZE(arch_ext_list);
@@ -202,6 +264,12 @@ static long restore_sigcontext(struct pt_regs *regs,
 
 			err = __restore_v_state(regs, sc_ext_ptr);
 			break;
+		case RISCV_ZICFISS_MAGIC:
+			if (!is_shstk_enabled(current) || size != riscv_zicfiss_sc_size)
+				return -EINVAL;
+
+			err = __restore_cfiss_state(regs, sc_ext_ptr);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -223,6 +291,16 @@ static size_t get_rt_frame_size(bool cal_all)
 			total_context_size += riscv_v_sc_size;
 	}
 
+	if (is_shstk_enabled(current))
+		total_context_size += riscv_zicfiss_sc_size;
+
+	/*
+	 * Preserved a __riscv_ctx_hdr for END signal context header if an
+	 * extension uses __riscv_extra_ext_header
+	 */
+	if (total_context_size)
+		total_context_size += sizeof(struct __riscv_ctx_hdr);
+
 	frame_size += total_context_size;
 
 	frame_size = round_up(frame_size, 16);
@@ -359,6 +437,11 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 #ifdef CONFIG_MMU
 	regs->ra = (unsigned long)VDSO_SYMBOL(
 		current->mm->context.vdso, rt_sigreturn);
+
+	/* if bcfi is enabled x1 (ra) and x5 (t0) must match. not sure if we need this? */
+	if (is_shstk_enabled(current))
+		regs->t0 = regs->ra;
+
 #else
 	/*
 	 * For the nommu case we don't have a VDSO.  Instead we push two
@@ -487,6 +570,9 @@ void __init init_rt_signal_env(void)
 {
 	riscv_v_sc_size = sizeof(struct __riscv_ctx_hdr) +
 			  sizeof(struct __sc_riscv_v_state) + riscv_v_vsize;
+
+	riscv_zicfiss_sc_size = sizeof(struct __riscv_ctx_hdr) +
+			  sizeof(struct __sc_riscv_cfi_state);
 	/*
 	 * Determine the stack space required for guaranteed signal delivery.
 	 * The signal_minsigstksz will be populated into the AT_MINSIGSTKSZ entry
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 2ebe789caa6b..8bc3e1e3f712 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -52,6 +52,11 @@ void set_active_shstk(struct task_struct *task, unsigned long shstk_addr)
 	task->thread_info.user_cfi_state.user_shdw_stk = shstk_addr;
 }
 
+unsigned long get_active_shstk(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.user_shdw_stk;
+}
+
 void set_shstk_status(struct task_struct *task, bool enable)
 {
 	if (!cpu_supports_shadow_stack())
@@ -169,6 +174,57 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
 	return 0;
 }
 
+/*
+ * Save user shadow stack pointer on shadow stack itself and return pointer to saved location
+ * returns -EFAULT if operation was unsuccessful
+ */
+int save_user_shstk(struct task_struct *tsk, unsigned long *saved_shstk_ptr)
+{
+	unsigned long ss_ptr = 0;
+	unsigned long token_loc = 0;
+	int ret = 0;
+
+	if (saved_shstk_ptr == NULL)
+		return -EINVAL;
+
+	ss_ptr = get_active_shstk(tsk);
+	ret = create_rstor_token(ss_ptr, &token_loc);
+
+	if (!ret) {
+		*saved_shstk_ptr = token_loc;
+		set_active_shstk(tsk, token_loc);
+	}
+
+	return ret;
+}
+
+/*
+ * Restores user shadow stack pointer from token on shadow stack for task `tsk`
+ * returns -EFAULT if operation was unsuccessful
+ */
+int restore_user_shstk(struct task_struct *tsk, unsigned long shstk_ptr)
+{
+	unsigned long token = 0;
+
+	token = amo_user_shstk((unsigned long __user *)shstk_ptr, 0);
+
+	if (token == -1)
+		return -EFAULT;
+
+	/* invalid token, return EINVAL */
+	if ((token - shstk_ptr) != SHSTK_ENTRY_SIZE) {
+		pr_info_ratelimited(
+			"%s[%d]: bad restore token in %s: pc=%p sp=%p, token=%p, shstk_ptr=%p\n",
+			tsk->comm, task_pid_nr(tsk), __func__, (void *)(task_pt_regs(tsk)->epc),
+			(void *)(task_pt_regs(tsk)->sp), (void *)token, (void *)shstk_ptr);
+		return -EINVAL;
+	}
+
+	/* all checks passed, set active shstk and return success */
+	set_active_shstk(tsk, token);
+	return 0;
+}
+
 static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
 					   unsigned long token_offset, bool set_tok)
 {

-- 
2.43.0


