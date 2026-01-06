Return-Path: <linux-kselftest+bounces-48275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26866CF6B51
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 05:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2ADF301144B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 04:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F8E29E0F8;
	Tue,  6 Jan 2026 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="AdxepRR3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C329BD81
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 04:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767675403; cv=none; b=J6DLvd5jWHqUehN8UYZi+HU9OWXDfrwJQKqRWrBXLE8KSvOa/MzhuYWAiykNz1QzynIpXSKzIiFL6YwgiZy5Y+XVZiYmHA1JAu0j4g/38kif8C4tWxe7PPUkcQZf8gX7w2dpSq0GI0rMsHayJ5jFgb+VAZJChAxLC1l1SrRZY40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767675403; c=relaxed/simple;
	bh=fbOChfkZbXOq4bWAzF7RfS77y5AjBtfElT9+lVK8jhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JczFKz3btbLZWi7SWlBY7pAgKJ6tG7+jAfDMdRvZVPJvxy3ijxG6LWATrQ/lQdt3FaWMZJhyIXjimj3wh99TzoFcTySuaR07FCbwhaiAqNPpM/jCsBm6u3THycfAPYmrhCFwtS88GgZWiD2NPMFyYqvWfWc8hI/G0giRgAD6FMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=AdxepRR3; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-457c1148a5bso252701b6e.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 20:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1767675401; x=1768280201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WA+vnv3FR+Z4SF0lY1aYTXYOVt37m8c4DjPEA2hxbj8=;
        b=AdxepRR32ZRfNXuAeeUizo+CnwLitQ7zhXMGkWNX+ePYeR8Edb8n82yNZ0WtZmeyVn
         RjGoMQ5RFebtp9D2clL1nAiKpmFEKNTAN3ui5gMmE0rD1LPLpiE+RLtRQH3jMzLAtVoM
         fq8D4n7rM4Xj4pp4q6ZMji5Lw9yxCMk2R66PmNkxDKxUd5v6jV6U8uG9wtzY24vCk8ZF
         Wn/Ntf3/VIShSc2WA6rOrmkZMmyJb4M73uaCM/KJbdRp2ap1VP4tKRc94YjTLJVGbp4N
         j8R2wNdf42iuSkEuZAAGMlAQNr0F4ulHSiRscM8Qk9fVMd7VWslEpFA8Msf1eTODs3Ex
         uqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767675401; x=1768280201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WA+vnv3FR+Z4SF0lY1aYTXYOVt37m8c4DjPEA2hxbj8=;
        b=ujVKy8iT1dugQBKKL0lczSGJLKQy/VBWyC39nw2PULRcKyqKuE7cpPOMfEn1ea5Dnc
         fRmngC5xidzahxnuZ4kCg8x+Nw/nr7NbXJSsaroEfSVFOw+covA6FM7hSfbJ4wqjlIJm
         odAP2hDV+OZHl0XHh6cQ4oaEGidroyTOjvUZFhYtDcQpFFhXQGckf3AwA+35ahVfbA/H
         Fx4Ts3crmAP0inZnF5PfGFhk4Cty4CdvGjgwqLgMHmfUE0c1xweUjjR75wb1YhVzU23/
         mMBcrLyFLhyD9RRoIZdvdrWEvhlxExAYXdhLRndx0uqwL1lR2FfYHnKMpQTQZ30Uq7Sp
         u0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXiNyazzEvMrQIELp7bpeTnbLqYM7AfnQYBeiZ0UpSIIw9uwAC1vzNzQR5h2a2yD0bq4Kf37yV+5LOAbBajB0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY10KlBUfWFAJkbjQMi1RKkQJag+TER/LL3TDtFOmYOeMIt90g
	0MZckXjR14SLYjfAtQBK4YEf/QUfKqkMjzU3J6Px7/VHOO5FQpmWABUR3e1N8BI8B8FtwRyWQ97
	XCJqWn6pjdDXHvOObouqGAJm0Xft85UXT70+wQlB9bw==
X-Gm-Gg: AY/fxX5PpSUXQ9kGCZY0QV46LInxlZGyL2ejASTMgbInesHIXXIZg67azgpY0DltCcE
	kS8eFR+KTv2waoeurG9yA75pGUEXoVkap/lso86IrK/gUnX/LH5ityKsgwhzGgP9jD75bZ2xxhB
	RzGOc5dqu7w88/trxD6N8NdRRk0ehMnyLJnlxKdtl7BYA+0bMxKIx9V5xE+DV4iSWk+5uNVPoyC
	3C08/Y+PY2FDkFgl+l+xUM0p0KLWNnV5GdtXZaTX0JQ9lkUMTGXlMyRsWVWnP5T48TcaMMA6BDx
	y3YszgTzMEjH/jS/rVtKp8Q3rEZjjUDL8w9Yaxn2upXqN+pV1tEncOW5/w==
X-Google-Smtp-Source: AGHT+IFYFZIDuKpjkDS72Ef6JCpoBzzGRuIzZj1eYSMd9ZLPsEbeYPPSGa4zpnzJp7w6utOo445xI/OFNWfh52Uwiq4=
X-Received: by 2002:a05:6820:f006:b0:65d:a21:d1f9 with SMTP id
 006d021491bc7-65f4799cc06mr1525576eaf.5.1767675400701; Mon, 05 Jan 2026
 20:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020042457.30915-1-luxu.kernel@bytedance.com> <20251020042457.30915-5-luxu.kernel@bytedance.com>
In-Reply-To: <20251020042457.30915-5-luxu.kernel@bytedance.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 6 Jan 2026 10:26:29 +0530
X-Gm-Features: AQt7F2pAUL7KOytVD0mr7jwpoQ61NGCRNrXweF7HHu0OAcu7_RUK7gg5_B9FCMI
Message-ID: <CAAhSdy3btmd-G_335XjJ6O_+WFNyrq5wWYSEtEQHUeP1yKmLog@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] RISC-V: KVM: Allow Zalasr extensions for Guest/VM
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, will@kernel.org, peterz@infradead.org, 
	boqun.feng@gmail.com, mark.rutland@arm.com, atish.patra@linux.dev, 
	pbonzini@redhat.com, shuah@kernel.org, parri.andrea@gmail.com, 
	ajones@ventanamicro.com, brs@rivosinc.com, guoren@kernel.org, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	apw@canonical.com, joe@perches.com, lukas.bulwahn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 9:55=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> Extend the KVM ISA extension ONE_REG interface to allow KVM user space
> to detect and enable Zalasr extensions for Guest/VM.
>
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-6.20

Thanks,
Anup

> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index ef27d4289da11..4fbc32ef888fa 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -185,6 +185,7 @@ enum KVM_RISCV_ISA_EXT_ID {
>         KVM_RISCV_ISA_EXT_ZICCRSE,
>         KVM_RISCV_ISA_EXT_ZAAMO,
>         KVM_RISCV_ISA_EXT_ZALRSC,
> +       KVM_RISCV_ISA_EXT_ZALASR,
>         KVM_RISCV_ISA_EXT_MAX,
>  };
>
> diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
> index cce6a38ea54f2..6ae5f9859f25b 100644
> --- a/arch/riscv/kvm/vcpu_onereg.c
> +++ b/arch/riscv/kvm/vcpu_onereg.c
> @@ -50,6 +50,7 @@ static const unsigned long kvm_isa_ext_arr[] =3D {
>         KVM_ISA_EXT_ARR(ZAAMO),
>         KVM_ISA_EXT_ARR(ZABHA),
>         KVM_ISA_EXT_ARR(ZACAS),
> +       KVM_ISA_EXT_ARR(ZALASR),
>         KVM_ISA_EXT_ARR(ZALRSC),
>         KVM_ISA_EXT_ARR(ZAWRS),
>         KVM_ISA_EXT_ARR(ZBA),
> @@ -184,6 +185,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsign=
ed long ext)
>         case KVM_RISCV_ISA_EXT_ZAAMO:
>         case KVM_RISCV_ISA_EXT_ZABHA:
>         case KVM_RISCV_ISA_EXT_ZACAS:
> +       case KVM_RISCV_ISA_EXT_ZALASR:
>         case KVM_RISCV_ISA_EXT_ZALRSC:
>         case KVM_RISCV_ISA_EXT_ZAWRS:
>         case KVM_RISCV_ISA_EXT_ZBA:
> --
> 2.20.1
>

