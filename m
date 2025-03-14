Return-Path: <linux-kselftest+bounces-29009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDDFA60B8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 09:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD1D166504
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D241719CD0E;
	Fri, 14 Mar 2025 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kBpm+0Qw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C81A3174
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940994; cv=none; b=q1AWLU3yKV2MtfAaDIHP+8/uG1HY7tDEsmiLJU1WGwTrHqIHNKrvnY4wYMv9UDVyuIGnMp4qnClfKcFkHlkkGCe/tm3sk6CK5xJPr9QqZpJLcGJbrwZ3kTWdjotLJV5v0bUBcNUkJ9ehSwmtIT+7s1jMucl1CnC14niq544lo0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940994; c=relaxed/simple;
	bh=+VOeEyaaz4ETl+dZkiEVp7F2yseM43nsL5eCpvrqo2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liuKDSOQSxz8pTxrRrbe/p6K8ByWmQJPSjWiV5OYVeHp9PWP4MY/fltc6OjsiOikI+8+Pn/+1GMagWh3rXxt9iN5FTpf+90Ttflwio5nZMMSoK4HxlJRFSHgUHbVPxn3NgombLoEYBi3YXTqr0vLqiTOG+RTMr8uSlzOwXYkTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kBpm+0Qw; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-856295d1f6cso129877539f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741940992; x=1742545792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG/NhetTUX73vAvkNoljifPvpPm7zk3dE/2sfnfhqPg=;
        b=kBpm+0QwTCd69Wj62PiurQ2Yy6o0svNz8PKoaAeyk2k1w0rvS9Tfg30CwdMu/HakHS
         iVMjx0mZEefGz7SyTwCghJFZ5bN7fGRKNjCDvKObR5HfUUCo86JVxW7un3MmfNAtLwut
         wnBC8h6VWP/pglAbWTaxYBOF2+zpHq7SAJ2GkvoIGoUYLR9mmF0U5XhJFBvGmUZeNDHL
         ulBNBq4jPuAeobA5nyPVaZwePeWdirNebt7qc7bXYwfPcYc5LSvy7zLoNFGGieUMgh3P
         eS/nep4o1EchXEUGb6DGVBQ/7Uun/DnrxGO6qn30vxSTTjeKYJ3/HzkYpGCErebJliO2
         DZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741940992; x=1742545792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG/NhetTUX73vAvkNoljifPvpPm7zk3dE/2sfnfhqPg=;
        b=FEZZw+GdOOXhauLtspQGMOqcFojClL++FfyaBjND0ouOlpvMixn3zXpabzwdO4cKzS
         /0WNKMTHjpD/Vqzc39kPHwjL4VajV3uHBRjRDlRM9tcObQX1S+WPp67Qjx09rnA6OTPG
         dwtF12Y8h10WbCya2CA1tGA7JQnALOh6KDuMGGcf6cTDN+3meCzXWGRZxt7WoIBdvDdG
         BGa/+BuH5ZvSm9/4OCSPoK4mJj2YJ2thCnQc7VLGbdCT6RtwQGIFR8XThF9t6VjRtCrd
         vWN2LAWoDh3lAxlmxASqhyMq+KSBJrITlMBuHb80iqFqEvIZ1ZDT3LeHcF+g16lDL3TK
         zbVw==
X-Forwarded-Encrypted: i=1; AJvYcCW8uh8KPbRE8NcQn4u5sb7jz9HAE+sW0jmdt9asDgKr5ttX4u7jmb/MBywYPRL1Fo8i/dZOKmWZ2QDGWsw16QA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx38yOuqiZrgae/vTBW9wQt5feNSdiQJ68EhxlZ/Jyx+BAS7e6W
	CbcGgaXRTkgvIY51zOsJuYzgbz3Wzw4TYRldqpL2PMGhNBpCPLAreNevLjXA57AsKOis4REW2gf
	N/4jBqRir7WfMcpJKWVPx2YNeh4wBMORj7dmv7Q==
X-Gm-Gg: ASbGncvdafDc40jbDEtc+fbz1BP/E/uinhV7zGuxbBKx5i9mHc5JIoftTsP8Npma4mx
	SLXeIVyZGkD0oqKeSsXS+5pMzChiS5dln31eJz37Bls1QRUNbB7kUeo13QawEvytlwkeL6Tzk1O
	9QNXyN624OwyJaVpCAp7zgJMZVKDI=
X-Google-Smtp-Source: AGHT+IGRGLu273ia/uJ1kVEfWXIabWgbH3cTFkXdos2+rXsX2htUfTI0qOd7W1pVul4CWeCQ4K4xAqme80WLVyOqC1E=
X-Received: by 2002:a05:6602:3809:b0:85b:3c49:8825 with SMTP id
 ca18e2360f4ac-85dc47a4b7emr202235439f.4.1741940992038; Fri, 14 Mar 2025
 01:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-9-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-9-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:29:41 +0800
X-Gm-Features: AQ5f1JqloEVd2PMJQWiW4SYNMnwxagAj6nW3aH_4ypy943_pLM-QCjhzDDCcitw
Message-ID: <CANXhq0rKE-PFP=OnD4o3+fDxgmzLxuz3LDyGmvBqnTgVO8oCsw@mail.gmail.com>
Subject: Re: [PATCH v11 09/27] riscv mmu: write protect and shadow stack
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
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:42=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> `fork` implements copy on write (COW) by making pages readonly in child
> and parent both.
>
> ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
> Assumption is that page is readable and on fault copy on write happens.
>
> To implement COW on shadow stack pages, clearing up W bit makes them XWR =
=3D
> 000. This will result in wrong PTE setting which says no perms but V=3D1 =
and
> PFN field pointing to final page. Instead desired behavior is to turn it
> into a readable page, take an access (load/store) fault on sspush/sspop
> (shadow stack) and then perform COW on such pages. This way regular reads
> would still be allowed and not lead to COW maintaining current behavior
> of COW on non-shadow stack but writeable memory.
>
> On the other hand it doesn't interfere with existing COW for read-write
> memory. Assumption is always that _PAGE_READ must have been set and thus
> setting _PAGE_READ is harmless.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index ccd2fa34afb8..54707686f042 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -411,7 +411,7 @@ static inline int pte_devmap(pte_t pte)
>
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {
> -       return __pte(pte_val(pte) & ~(_PAGE_WRITE));
> +       return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
>  }
>
>  /* static inline pte_t pte_mkread(pte_t pte) */
> @@ -612,7 +612,15 @@ static inline pte_t ptep_get_and_clear(struct mm_str=
uct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>                                       unsigned long address, pte_t *ptep)
>  {
> -       atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)pte=
p);
> +       pte_t read_pte =3D READ_ONCE(*ptep);
> +       /*
> +        * ptep_set_wrprotect can be called for shadow stack ranges too.
> +        * shadow stack memory is XWR =3D 010 and thus clearing _PAGE_WRI=
TE will lead to
> +        * encoding 000b which is wrong encoding with V =3D 1. This shoul=
d lead to page fault
> +        * but we dont want this wrong configuration to be set in page ta=
bles.
> +        */
> +       atomic_long_set((atomic_long_t *)ptep,
> +                       ((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE=
) | _PAGE_READ));
>  }
>
>  #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
>

LGTM.

Reviewed-by: Zong Li <zong.li@sifive.com>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

