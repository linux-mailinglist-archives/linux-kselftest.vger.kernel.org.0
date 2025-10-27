Return-Path: <linux-kselftest+bounces-44077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E723C0BC37
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 04:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A71E1888C5D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 03:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EE02D46B3;
	Mon, 27 Oct 2025 03:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="1pdv+HQ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95A242D70
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761536314; cv=none; b=aszphaxVjrls3++4bEnSezKX/wwdWIUNWMa6CL639XpQPUIS3hKBlwtSsvJw+TaAcNXH2IO8IdITdPnLARbtO97P0e5HADvzaoKOrimilLkpyO/PxTp5TXQfN8mgMAH7YwkxHHbBS58mF0RSlydwahs30aZsUwwdjxZK2z+guE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761536314; c=relaxed/simple;
	bh=ykqsBz7ltNcPXKuQY9/QTGVQNnJRyRhhtKcA12vcA/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2xAlqmfERPaUqdsi8GpJKRCn0qC+dzX892mk3aLsK2N4Y7KjRzWeLlCytLrqbNgOJw5/79K2f76cckRcPj29RUPjYLhw9RPmizfuC0GCn+5rEiOPLb5OtRoGHzLGPl1bStyXUkG7v5ThvDsNFNuyHT3B7JIBUsM1bA7YDig4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=1pdv+HQ4; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93e7d3648a8so166334339f.2
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 20:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1761536311; x=1762141111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLv/abQqhTrjCuxnsZKW6XWrZqaImCMO0bBeDuN7Ur0=;
        b=1pdv+HQ4aRXCgsmvJPnow+5C4Cz+nYqKSF84oWDwNrqZkzWOgY1vJpCSBoUQHvFaKb
         qTeZTgwpuIlaowcY9aganZJuJFKxNGadAK3y0Jr1vdnPJIH67l+oipfUDPeWoa3YJHo+
         AJzJkeRMGpzaC3+MSNgzg8RR71I/mVIRpFRUTH/Ikk3yaoT3FhmIdpeg7U7g8kqk7UGb
         xWMoIprbGVhBpwuAWutla9g0ZXsoGRsGgpHMn4g4afs5QHwKw3VfanFz9wihmHestkJl
         Vhj5bbfVt/2rTDFHgambTncdd5iKkWp3Jkzk+ahYDuyv3/cuR9uBScjGYrn7TVB6SffO
         DRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761536311; x=1762141111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLv/abQqhTrjCuxnsZKW6XWrZqaImCMO0bBeDuN7Ur0=;
        b=jDR4cbB5Dy/DQOFloP6bP7Ukkot+vQfkBunkmWmXG3ttl7PURoUd1AWM7lQGTNCQvd
         hhHWN/0Upv/c/XNlz97XehxMN9biN11fz7o8tIUuX7s4BUpImqnN/M0hkYw03RHzTK/W
         VhUUDZGsP2xTBN+aVTBKp9BxfLYi5HHQWvqBxsq7HI4tQ615Pz/8TXC88vmvK0r/CFKn
         4UJmNdg8uwjkMVxWaMYTTbf0NKlZbrOUbAeqB60Qdx07h+3Xqa8KR7O/CE+HVQcP9RKr
         KOiZEOBhtgTAzz5KWpvfTxrFQpD8+bXrpS/2SpO+sm4I1OOWF7sIOSkGVv9s6RdxuESJ
         AfNw==
X-Forwarded-Encrypted: i=1; AJvYcCVkrc+wEvp88L8jwVVv44szEC+wiOjm3uoqMysHWrZwCplhj+AC97Ri6wx6yCf5PZRVDgbTBfpg8zkJ9vlMTWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZZ78lAj0AfMy6H5lqaSSsHp0e3MzmWfAyzSvoE3w7giXkekZ
	eDe5w3ssXNe2vueHHPP9fWw0DH1EByPy5ODI3jcJYU7VRgbsiO5qs1ZzpOorVWDZUekxzHbJ06+
	PWbn20oJMgD5knFoJ1AGUPhKwcM4BkV5woZQ98Yc2qw==
X-Gm-Gg: ASbGncuj+glsOrlBTlZxwQoBxjlgCzTpXtzGeNeatU+fH+2GCLVfkzutJUbZPvK85+z
	Cl5yBUIVat5TX7Ema0hR7XjH3NF9eaXV0gNGaeelZm6w74g+xphVYEqy4565H4Ex7Q5dCrLUgV/
	OlfCHiCn4Gy5MhTpEZ6hrdvrCr0y65sl5xmphfcv1xHeIU0RVr05fl+NtZwkTkVZZ8l2frXRmDS
	rTp+0mjsPr8EvapOKtqEYw3WRbynmiWlt2Ign1bvrlIbi8Bx8OgpovvV194efFqphG/LFynDZSg
	3ZuNqTczdBXkkj+6WEGsMlVy8MTUpcy5wgY7HIHtRyYFivi/dObo2C/7czBc
X-Google-Smtp-Source: AGHT+IFXk1YUaLAdhvo8rgPkIKe5gLo/c+djIhEIA40LWqKcizzRXoBKOFj4cyggO2AuZkgxTRXbB8jToGSbWYc3oMw=
X-Received: by 2002:a05:6e02:190c:b0:42f:9eb7:759b with SMTP id
 e9e14a558f8ab-430c5306894mr466704455ab.28.1761536310727; Sun, 26 Oct 2025
 20:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017155925.361560-1-apatel@ventanamicro.com>
In-Reply-To: <20251017155925.361560-1-apatel@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 27 Oct 2025 09:08:19 +0530
X-Gm-Features: AWmQ_bleYZ_iePePDvRC5d6Pe5JA_nbAbhQUpFmow4pTKUmpRz54E4-TMp1PLS4
Message-ID: <CAAhSdy1+AFQepjrfKrcQvC8cxDpjOHfF500O6FXTYzf-iksCfw@mail.gmail.com>
Subject: Re: [PATCH 0/4] SBI MPXY support for KVM Guest
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 9:29=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This series adds SBI MPXY support for KVM Guest/VM which will
> enable QEMU-KVM or KVMTOOL to emulate RPMI MPXY channels for the
> Guest/VM.
>
> These patches can also be found in riscv_kvm_sbi_mpxy_v1 branch
> at: https://github.com/avpatel/linux.git
>
> Anup Patel (4):
>   RISC-V: KVM: Convert kvm_riscv_vcpu_sbi_forward() into extension
>     handler
>   RISC-V: KVM: Add separate source for forwarded SBI extensions
>   RISC-V: KVM: Add SBI MPXY extension support for Guest
>   KVM: riscv: selftests: Add SBI MPXY extension to get-reg-list
>
>  arch/riscv/include/asm/kvm_vcpu_sbi.h         |  5 ++-
>  arch/riscv/include/uapi/asm/kvm.h             |  1 +
>  arch/riscv/kvm/Makefile                       |  1 +
>  arch/riscv/kvm/vcpu_sbi.c                     | 10 +++++-
>  arch/riscv/kvm/vcpu_sbi_base.c                | 28 +--------------
>  arch/riscv/kvm/vcpu_sbi_forward.c             | 34 +++++++++++++++++++
>  arch/riscv/kvm/vcpu_sbi_replace.c             | 32 -----------------
>  arch/riscv/kvm/vcpu_sbi_system.c              |  4 +--
>  arch/riscv/kvm/vcpu_sbi_v01.c                 |  3 +-
>  .../selftests/kvm/riscv/get-reg-list.c        |  4 +++
>  10 files changed, 56 insertions(+), 66 deletions(-)
>  create mode 100644 arch/riscv/kvm/vcpu_sbi_forward.c
>

Queued this series for Linux-6.19

Thanks,
Anup

