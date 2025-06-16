Return-Path: <linux-kselftest+bounces-35054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E176ADA97E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 09:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D23A58B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 07:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7B1FCF7C;
	Mon, 16 Jun 2025 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DC1i+2um"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ABE1F8BD6
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059106; cv=none; b=fQt/f129UAsuifipo6+HYXVVA7bH5WqXX9LDO3174Ty6lTpTj/9su0rnWc6REJMlKvJN4qPrylu8H0T8Lq+wmtep872qrkx36B8RqiCyfQG/ytjfhURqmQa+lmzSlalLVTD0QabTWH6qtxi321WED76lXWK1O5b5yylZmbgEENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059106; c=relaxed/simple;
	bh=ee5HiIoIsa3WDFCUyUGDDZltzjB7Oew/byuJhXXlAlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSfrxKtpBdsBKChkNVn40UrCAYC+m3lHZ5hMcqnwEU3rSC0UqkxVoCxLZsh96esZSlMH4mY4ip5GoR9d3h4dgicDyJphJwSHFB4L1h/xSUAqWDpVJXQ+gRb0LXqlqZTBJZz5ytryhMVNlI0sU/G6Qg9Js20wTqqPpTeV+wi+MgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DC1i+2um; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3dc8265b9b5so39526305ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1750059103; x=1750663903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQxXH/0dmAKUHVoHoL5MncVmJUg8FbHf/SfAogCBA2o=;
        b=DC1i+2umUVfKRl3dV5GPu22ngrs1sm0QAx+hY6GxzRuTxJz2aEVXBVY21zCsxxxAb3
         xQ7OnZYKqww37y7xbgOG9IasDUprZUWYFUg0EZ4MElZo6BmPrlMHfFMz5ewViqQiXtWr
         /+kx131zxEmT0q/ZfGhXZmZzXXUWLkGa88xBOnl1w1EhoTa9j0IhgDRIKQKB+e2cHZaE
         +dJ//AYrH56dqdU2azxMFshlEHAKGit9qUbhCcCEVP/Tbj5P5zE1/M4AtQ7TENXxPDBt
         Wsj+Oref7Aunzg2G6havYh6dekCCPT/Diu8Z8ZalOmwWyhPA2KJHD+yvV/aEF/B2yHpy
         yAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750059103; x=1750663903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQxXH/0dmAKUHVoHoL5MncVmJUg8FbHf/SfAogCBA2o=;
        b=pc0pTpQlsKQgWNogYRz9x3aJ2bIbifTlFmaGgxBNYKACa//4XByHvaifBACqmEwM63
         RlhJKiBTHbV0OL78rORk6pd0gqJMH9dVMoj4Qm7VfUdC5eAo9NEupDQw14MFN1uM9PKO
         o27fIQeu9M6f4dH1jFO+DHFZ5fSOLIPP8EiNjAEqEyc/ra8JPfooTFAbQYCR9Lwxummm
         dbEDR/XqMRHS0fVURnVuKpU9txnPKSEpPDAvOUUJUT9xsWCTGg27UIOlFDNT8iYY5SMG
         Oh1hretSUcPPbcBtj8wPdVoliMuTsC3xo90Y/+DGbBRsdNNW8Z0oqK2H9C5I2v1KYMbO
         d83w==
X-Forwarded-Encrypted: i=1; AJvYcCWaPyDAgqAGKVq3VVZEOi52Rsy36rjAVhTMDbU0xWj/Ukj2kB6pnD/33+gg0wKGgheJKd4ZITQoDcAZHbUbGGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1uSo7vWJPupA5Zj/NM5ewYUNZNdZBpqCFXXPdokYRSdQa9jAi
	sLGt4Ah4gjEO///pBmfZvKmL7mKoLgKlNtSLg6G4rkX+yERgQX7dmFMd57ae3bL49cJBZIK7Fhw
	a0AERoyEkS2TTgl8PpGRasFHs8kxPu0M0szTBcce51g==
X-Gm-Gg: ASbGncvXw/0HTYPrH4u9Dpf9bkSOvNJdMEdtnW79M2x6Z21rEN9rSSjRi+N4Ikn82Eq
	N2VrVOC60ugi6kV73mBYK6h8lSEG/tY4nX/XVpto+JmYcdeyLrsyBN+1iQ+UVECAwRL6lUx8CUe
	SKf3BbhuhojdJSRaEUM2iIVRcI37rNnTWDH67UTY+GEOfh/A==
X-Google-Smtp-Source: AGHT+IEjHI16GxKyLasfzKkpzXfv5K8fdxEJHSmO2c+vsZ5EW3jLub+wreQ1LSFrfqb50SzP3xXNNY/tkYcEG9qkkXQ=
X-Received: by 2002:a05:6e02:1445:b0:3dc:87c7:a5b5 with SMTP id
 e9e14a558f8ab-3de07c2710fmr92538565ab.3.1750059102855; Mon, 16 Jun 2025
 00:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com> <20250604-v5_user_cfi_series-v17-15-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-15-4565c2cf869f@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 16 Jun 2025 15:31:31 +0800
X-Gm-Features: AX0GCFv07zIy78CxiGqhmmuXUJ1bc3WRbaeMC8WS8lGUU29aYh3F-BEq_8IQZZA
Message-ID: <CANXhq0pRXX_OMW2g2ui-k7Z_ZT+5a8Sra8oE28nBh5B9K2L5bQ@mail.gmail.com>
Subject: Re: [PATCH v17 15/27] riscv/traps: Introduce software check exception
 and uprobe handling
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 1:17=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> zicfiss / zicfilp introduces a new exception to priv isa `software check
> exception` with cause code =3D 18. This patch implements software check
> exception.
>
> Additionally it implements a cfi violation handler which checks for code
> in xtval. If xtval=3D2, it means that sw check exception happened because=
 of
> an indirect branch not landing on 4 byte aligned PC or not landing on
> `lpad` instruction or label value embedded in `lpad` not matching label
> value setup in `x7`. If xtval=3D3, it means that sw check exception happe=
ned
> because of mismatch between link register (x1 or x5) and top of shadow
> stack (on execution of `sspopchk`).
>
> In case of cfi violation, SIGSEGV is raised with code=3DSEGV_CPERR.
> SEGV_CPERR was introduced by x86 shadow stack patches.
>
> To keep uprobes working, handle the uprobe event first before reporting
> the CFI violation in software-check exception handler. Because when the
> landing pad is activated, if the uprobe point is set at the lpad
> instruction at the beginning of a function, the system triggers a softwar=
e
> -check exception instead of an ebreak exception due to the exception
> priority, then uprobe can't work successfully.
>
> Co-developed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/asm-prototypes.h |  1 +
>  arch/riscv/include/asm/entry-common.h   |  2 ++
>  arch/riscv/kernel/entry.S               |  3 ++
>  arch/riscv/kernel/traps.c               | 51 +++++++++++++++++++++++++++=
++++++
>  4 files changed, 57 insertions(+)
>
> diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include=
/asm/asm-prototypes.h
> index cd627ec289f1..5a27cefd7805 100644
> --- a/arch/riscv/include/asm/asm-prototypes.h
> +++ b/arch/riscv/include/asm/asm-prototypes.h
> @@ -51,6 +51,7 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_u);
>  DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
>  DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
>  DECLARE_DO_ERROR_INFO(do_trap_break);
> +DECLARE_DO_ERROR_INFO(do_trap_software_check);
>
>  asmlinkage void handle_bad_stack(struct pt_regs *regs);
>  asmlinkage void do_page_fault(struct pt_regs *regs);
> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/a=
sm/entry-common.h
> index b28ccc6cdeea..34ed149af5d1 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -40,4 +40,6 @@ static inline int handle_misaligned_store(struct pt_reg=
s *regs)
>  }
>  #endif
>
> +bool handle_user_cfi_violation(struct pt_regs *regs);
> +
>  #endif /* _ASM_RISCV_ENTRY_COMMON_H */
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 978115567bca..8d25837a9384 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -474,6 +474,9 @@ SYM_DATA_START_LOCAL(excp_vect_table)
>         RISCV_PTR do_page_fault   /* load page fault */
>         RISCV_PTR do_trap_unknown
>         RISCV_PTR do_page_fault   /* store page fault */
> +       RISCV_PTR do_trap_unknown /* cause=3D16 */
> +       RISCV_PTR do_trap_unknown /* cause=3D17 */
> +       RISCV_PTR do_trap_software_check /* cause=3D18 is sw check except=
ion */
>  SYM_DATA_END_LABEL(excp_vect_table, SYM_L_LOCAL, excp_vect_table_end)
>
>  #ifndef CONFIG_MMU
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 8ff8e8b36524..64388370e1ad 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -354,6 +354,57 @@ void do_trap_ecall_u(struct pt_regs *regs)
>
>  }
>
> +#define CFI_TVAL_FCFI_CODE     2
> +#define CFI_TVAL_BCFI_CODE     3
> +/* handle cfi violations */
> +bool handle_user_cfi_violation(struct pt_regs *regs)
> +{
> +       unsigned long tval =3D csr_read(CSR_TVAL);
> +       bool is_fcfi =3D (tval =3D=3D CFI_TVAL_FCFI_CODE && cpu_supports_=
indirect_br_lp_instr());
> +       bool is_bcfi =3D (tval =3D=3D CFI_TVAL_BCFI_CODE && cpu_supports_=
shadow_stack());
> +
> +       /*
> +        * Handle uprobe event first. The probe point can be a valid targ=
et
> +        * of indirect jumps or calls, in this case, forward cfi violatio=
n
> +        * will be triggered instead of breakpoint exception.
> +        */
> +       if (is_fcfi && probe_breakpoint_handler(regs))
> +               return true;

Hi  Deepak,
Sorry for missing something earlier. I think we would like to clear
sstatus.SPELP in the uprobe handling case. For example:

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index c2ea999c1167..e8492bb57e09 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -349,8 +349,10 @@ bool handle_user_cfi_violation(struct pt_regs *regs)
        bool is_fcfi =3D (tval =3D=3D CFI_TVAL_FCFI_CODE &&
cpu_supports_indirect_br_lp_instr());
        bool is_bcfi =3D (tval =3D=3D CFI_TVAL_BCFI_CODE &&
cpu_supports_shadow_stack());

-       if (is_fcfi && probe_breakpoint_handler(regs))
+       if (is_fcfi && probe_breakpoint_handler(regs)) {
+               regs->status =3D regs->status & ~SR_ELP;
                return true;
+       }

        if (is_fcfi || is_bcfi) {
                do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,


When a user mode CFI violation occurs, the ELP state should be 1, and
the system traps into supervisor mode. During this trap, sstatus.SPELP
is set to 1, and the ELP state is reset to 0. If we don=E2=80=99t clear
sstatus.SPELP, the ELP state will become 1 again after executing the
sret instruction. As a result, the system might trigger another
forward CFI violation upon executing the next instruction in the user
program, unless it happens to be a lpad instruction.

The previous patch was tested on QEMU, but QEMU does not set the
sstatus.SPELP bit to 1 when a forward CFI violation occurs. Therefore,
I suspect that QEMU might also require some fixes.

Thanks

> +
> +       if (is_fcfi || is_bcfi) {
> +               do_trap_error(regs, SIGSEGV, SEGV_CPERR, regs->epc,
> +                             "Oops - control flow violation");
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +/*
> + * software check exception is defined with risc-v cfi spec. Software ch=
eck
> + * exception is raised when:-
> + * a) An indirect branch doesn't land on 4 byte aligned PC or `lpad`
> + *    instruction or `label` value programmed in `lpad` instr doesn't
> + *    match with value setup in `x7`. reported code in `xtval` is 2.
> + * b) `sspopchk` instruction finds a mismatch between top of shadow stac=
k (ssp)
> + *    and x1/x5. reported code in `xtval` is 3.
> + */
> +asmlinkage __visible __trap_section void do_trap_software_check(struct p=
t_regs *regs)
> +{
> +       if (user_mode(regs)) {
> +               irqentry_enter_from_user_mode(regs);
> +
> +               /* not a cfi violation, then merge into flow of unknown t=
rap handler */
> +               if (!handle_user_cfi_violation(regs))
> +                       do_trap_unknown(regs);
> +
> +               irqentry_exit_to_user_mode(regs);
> +       } else {
> +               /* sw check exception coming from kernel is a bug in kern=
el */
> +               die(regs, "Kernel BUG");
> +       }
> +}
> +
>  #ifdef CONFIG_MMU
>  asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>  {
>
> --
> 2.43.0
>

