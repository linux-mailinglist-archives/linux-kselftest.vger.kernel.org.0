Return-Path: <linux-kselftest+bounces-10663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2E68CE3B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 11:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E518E2822EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6024A8526B;
	Fri, 24 May 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Qvv+rTHr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C34C84E19
	for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543991; cv=none; b=Rd8DgHTDPEd4m9rBuLqqPOvpiSTUUbB2WhcAb0yqiDGvxGYQErituS9BXr33BlsfRIDiULQOr6NP5kG/palViOzcTMcLmQVP/dlY+BBFqA08gcARy2MG/DLXKg8BMtF20u05A6kZvuq+mJG3dk8TbmBcJlEqrgfbmvQBYItAK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543991; c=relaxed/simple;
	bh=HDU6Ikis2reepBp7XonSWdeQ98AVdDz0nuzQ+64KYp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLpcxeGfo5SXXG8UN1tpCh+8TGU8/lK8viu/Lw739JgQqzkGL7eoy/9nVG96esN+gK4qPyJ3KFKJ97qne6GuEqVUM+Gr+5KQFuhKMTACMWxeGwB41/TMz0hA1Sd35otVhb76LF45w67Irzxj/rzNJOQHymw+zzppeMcLHKsbxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Qvv+rTHr; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df481bf6680so2720594276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2024 02:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1716543987; x=1717148787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjgMHPkdKke/sFW+wP3x/OWfAW3icjljhDceGb+T51c=;
        b=Qvv+rTHrHM5G+L52LeF/Ukc57xiGL2/T+SEBVpyDFh0YPcFG22QFWnTay7BdzrZ3JP
         hUQESM8tnI7oSt7hVKSGhj9+wW9szYPoHmD2M9QAApWzUHwgOWfaWPVbZ1VTYQq+fDJZ
         Z5r0118dPBrruHGC83QnOfMaHkNBCEvPh2gJ8KpOXIllsXa2YTOxiIBl2J4Nv85Ccd4Y
         IWjs40RXK78QI4z3tAFTn8diN+7XuYR/pxMgmzJJT3/jzKk++3dgxEaU1S+PBmbYngGA
         RRBipfTPQbP7nPrqaMOPdkb3feB8K+rO7FA1QBUlY9nYY2FnYz9vcF5xArFebdzgv4cG
         lx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716543987; x=1717148787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjgMHPkdKke/sFW+wP3x/OWfAW3icjljhDceGb+T51c=;
        b=Mh9J8CaSArWNIZ86JyNVGqV9XMsBdZgEV7LJA8BI+l/iHVZHfbjeIuXkChsn5L+2pE
         5cJXZhWsgEoB7shpS0W2WAXUVhchP9P9dsp7aogSkRKh64ijNhOvygk6YvsxP7/6RXU+
         4hHQ5HREx+w5CNyL8TkXHoIKMjr1aIbDoopbggX84CXszBWJuodOIDjVibaP/DQR7MRh
         +DmygmLc/eRk7rePN0g90hc2kN9pabLdbf3ECUHHINyrSr0Q/daz/U1ByEeH61O75BVC
         vWxmwOzzZVLY4/pweH94pxoMOQhFyWyXTwGbcJpjIXJ1U7P45XaU5UYwFmTBEoAuWYkd
         X+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWFIP9LzjoNCRSPcxO2CSIZEm8Gz07yazK5gW+jH2oiODs4z9S/xuHu6gwVL4bNAfpyIGwXLKB4j8gW+zObA3ctHbG2qe5uv4saN62NS0O7
X-Gm-Message-State: AOJu0YzUiKLnZo09QHHzz91uh09QLUf0BGy6TfqBeXjtAEmw8Y+QmOpX
	rNB/4iOeFUIWQ6bTq1YWS+/ItzaNe/zJBRdxy6EKY9HvD8VVjKNet897RpzJsnyrW6342vSZ6Eh
	ruizS4bZD+FStY91uYQbjfpOraLGKO6HC4Prqnw==
X-Google-Smtp-Source: AGHT+IElLw9ldbzBvHZ3/TQt52rrJpYv9UPwEZAezgFRSlhX7EDpAmWQFaSOD80MnXamfMqxd179zHrTOZ6XZB7bNkc=
X-Received: by 2002:a25:ae1e:0:b0:df4:df14:61bc with SMTP id
 3f1490d57ef6-df7721b7236mr1844605276.29.1716543987537; Fri, 24 May 2024
 02:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403234054.2020347-1-debug@rivosinc.com> <20240403234054.2020347-23-debug@rivosinc.com>
In-Reply-To: <20240403234054.2020347-23-debug@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 24 May 2024 17:46:16 +0800
Message-ID: <CABgGipW4ZTFLh1dkiRuWD0WP4RRkfhyFCc+RsUjCD2EkA5GhSQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/29] riscv sigcontext: adding cfi state field in sigcontext
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com, broonie@kernel.org, 
	Szabolcs.Nagy@arm.com, kito.cheng@sifive.com, keescook@chromium.org, 
	ajones@ventanamicro.com, conor.dooley@microchip.com, cleger@rivosinc.com, 
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, corbet@lwn.net, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com, akpm@linux-foundation.org, 
	arnd@arndb.de, ebiederm@xmission.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lstoakes@gmail.com, shuah@kernel.org, brauner@kernel.org, 
	jerry.shih@sifive.com, hankuan.chen@sifive.com, greentime.hu@sifive.com, 
	evan@rivosinc.com, xiao.w.wang@intel.com, charlie@rivosinc.com, 
	apatel@ventanamicro.com, mchitale@ventanamicro.com, dbarboza@ventanamicro.com, 
	sameo@rivosinc.com, shikemeng@huaweicloud.com, willy@infradead.org, 
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com, 
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de, bhe@redhat.com, 
	jeeheng.sia@starfivetech.com, cyy@cyyself.name, maskray@google.com, 
	ancientmodern4@gmail.com, mathis.salmen@matsal.de, cuiyunhui@bytedance.com, 
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, 
	david@redhat.com, catalin.marinas@arm.com, revest@chromium.org, 
	josh@joshtriplett.org, shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, 
	ojeda@kernel.org, jhubbard@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Deepak,

On Thu, Apr 4, 2024 at 7:42=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> Shadow stack needs to be saved and restored on signal delivery and signal
> return.
>
> sigcontext embedded in ucontext is extendible. Adding cfi state in there
> which can be used to save cfi state before signal delivery and restore
> cfi state on sigreturn
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/uapi/asm/sigcontext.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/includ=
e/uapi/asm/sigcontext.h
> index cd4f175dc837..5ccdd94a0855 100644
> --- a/arch/riscv/include/uapi/asm/sigcontext.h
> +++ b/arch/riscv/include/uapi/asm/sigcontext.h
> @@ -21,6 +21,10 @@ struct __sc_riscv_v_state {
>         struct __riscv_v_ext_state v_state;
>  } __attribute__((aligned(16)));
>
> +struct __sc_riscv_cfi_state {
> +       unsigned long ss_ptr;   /* shadow stack pointer */
> +       unsigned long rsvd;             /* keeping another word reserved =
in case we need it */
> +};
>  /*
>   * Signal context structure
>   *
> @@ -29,6 +33,7 @@ struct __sc_riscv_v_state {
>   */
>  struct sigcontext {
>         struct user_regs_struct sc_regs;
> +       struct __sc_riscv_cfi_state sc_cfi_state;

I am concerned about this change as this could potentially break uabi.
Let's say there is a pre-CFI program running on this kernel. It
receives a signal so the kernel lays out the sig-stack as presented in
this structure. If the program accesses sc_fpregs, it would now get
sc_cfi_state. As the offset has changed, and the pre-CFI program has
not been re-compiled.

>         union {
>                 union __riscv_fp_state sc_fpregs;
>                 struct __riscv_extra_ext_header sc_extdesc;
> --
> 2.43.2
>

There may be two ways to deal with this. One is to use a different
signal ABI for CFI-enabled programs. This may complicate the user
space because new programs will have to determine whether it should
use the CFI-ABI at run time. Another way is to follow what Vector does
for signal stack. It adds a way to introduce new extensions on signal
stack without impacting ABI.

Please let me know if I misunderstand anything, thanks.

Cheers,
Andy

