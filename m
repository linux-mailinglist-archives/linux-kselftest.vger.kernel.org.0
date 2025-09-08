Return-Path: <linux-kselftest+bounces-40913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB4B48307
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 05:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BB7189A6BD
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 03:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FC321D5AF;
	Mon,  8 Sep 2025 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="ruVnsDTU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2481721C9E4
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757303475; cv=none; b=Qefzf1oRH8nVycu/PO2KRX+gMQ+ecWFnD/CTV1SGp0nxtS1JVhB34Uvxey+31bI0evCZl6PVyjcgfx2YUTM2knqcIdID2HDXCiSLzkLZTjO15F5EerdxGNNjGLPEE7fY1E8rnrrDaCMfh5Y/WyfDrH04g5HBQK1h78+/y2mmKrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757303475; c=relaxed/simple;
	bh=VklWpKh2I9KYvBx6Az/wIjIwP5yxfg17gFuk9AVjD3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byhoY8M+YUaOq60ewdr39rH0Pz8+J+6taRkGD3HFL7Bk0a5PWGGWllwwlfOThZBOmRcjAi2SPk1gy31IqPLRks6C7HHL3C3SHBlCyXevsEyz+npAioNSh1AuXvhIWRko/edeZWrYCapmY7L3E29quFGLzWAyei6djZJI3fH140U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=ruVnsDTU; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-406ec5934caso3333615ab.3
        for <linux-kselftest@vger.kernel.org>; Sun, 07 Sep 2025 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1757303473; x=1757908273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hq2toZ1MStoLsAaQpze6/oEBhlqrv8NRJsOlpJj3oRE=;
        b=ruVnsDTUrIQaiy6i3NMDxQoBTecEAwC2aRjExdIeXR8ew2Vxjs+R60+/jxYhnzkGUy
         RRMFrRc9JFWnhiurb6MG5sbe+yc7hQf0kzCRivy/pJpiDCEZrzk/TJw9FrBRdWZ/zfxH
         +AI6AvNZ5IFb8DWwX6enEamhGHPmimmyct0omVGOkqa10FW555IA2niOek4969zG+MxS
         jzuYK2fFovbxXzlOFsvdosEHpE3jR7KXaCRKNKY+bfuk6CwbgZ3Sd0MrAYk9UH8BbGbX
         P0oZeX6z/3aso+j3/QUIf8eGPkmD5RAcUziS9teZQuvFH2iD0cyCZtrhvXp9M+fcHvGV
         I+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757303473; x=1757908273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hq2toZ1MStoLsAaQpze6/oEBhlqrv8NRJsOlpJj3oRE=;
        b=Kf17DWBQFxfB1WUrMXexTqV6CL2GD+O4j4qqZUMQI0DNh9hZvE9C9PnhQKWR9Mwirr
         xMnHc0kAllC2gHhc7Gjkmr6PCp2kHYMQw3pAVhvXmxOeBxvjL+bPTuyWouJ3RBteYqII
         DLFoko2GMM5KEheOL1PafZCK/1ZU6bCVi5WTrBe5IMgb7JCdrr0AuXrYfVe3QY7DWmzf
         MSAm5XS7u25emjTg+3y0/qRstrTLchxapGtrm9mVYKJlcoCJPpKP2K2Oykl2B+7R19+/
         IgHHYpn3blBzdBgLnQF2uXWcMcyxbiDLx4GF33tlgqCPKLxzABPE7/f2Z+3LB55SExKf
         I6Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVRDS2I9S624HCy8nUs9g1EaqEj4IYM4bBaauB1MUvp2slZeiiUjDI+t/GJnteJ01PuBAdnsA4o62lvF1s6Ye0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjDxjRHpT5072kaWTlX57vneNNlo3+HVe52hgR64O1NvrKl3P
	Pz5tWvxYiYvUdheHjjAVfunx8o+clRLkpdHIQPqEJ20nhXc+7rxhkksviDW2ZbF5gz+jjHN6BLy
	v9ro03f/+lpX2G4dal6WHntTTPeEQB0RRKai2yGro3w==
X-Gm-Gg: ASbGncsoKXoXt6QnqTlZ701sigSHMUCrXzSH7RQK8MN+tuFOIFoJkkXgtSeJHST11OH
	v/Q26yB0+YTjjwEISr2n0Yq6cw1EcOaxcl9mb9pqm+D5ejU3H50wX5M/WeLlMUM69KyHw2QwPeW
	lKd7ciD7yNJ+N+mcq5t69Z7pO5u5D2VzBMNxSqvQo22a8TirRrj8rLeJ8NhYm+61rVjNoAe18Te
	QqwMjuewtNjn5NNB9tfkl1sn8pYwEUdbzzCTpry7oaTx9oHno8=
X-Google-Smtp-Source: AGHT+IH4WAwWrAnnu4Rq1LOrwKuZ6PLy8v3SBH2WLczbYxVUoFRkmc/aL1MGlRWWeIeFxAJfFISceCNUeP2fr23Ivao=
X-Received: by 2002:a05:6e02:1d9d:b0:3f6:80ec:bae with SMTP id
 e9e14a558f8ab-3fd853158bamr95133955ab.21.1757303473045; Sun, 07 Sep 2025
 20:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823155947.1354229-1-apatel@ventanamicro.com>
In-Reply-To: <20250823155947.1354229-1-apatel@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 8 Sep 2025 09:21:00 +0530
X-Gm-Features: Ac12FXxdad2U7i621spIzbFw-GpwyPTNC5JI8CApKugYuwHXgesJ9uOvv3sJqD4
Message-ID: <CAAhSdy1jAmCeqWoPi7QpuzW4stH6U-Z0pSHmyC93jBYbSr6_xw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] ONE_REG interface for SBI FWFT extension
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 9:30=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This series adds ONE_REG interface for SBI FWFT extension implemented
> by KVM RISC-V. This was missed out in accepted SBI FWFT patches for
> KVM RISC-V.
>
> These patches can also be found in the riscv_kvm_fwft_one_reg_v3 branch
> at: https://github.com/avpatel/linux.git
>
> Changes since v2:
>  - Re-based on latest KVM RISC-V queue
>  - Improved FWFT ONE_REG interface to allow enabling/disabling each
>    FWFT feature from KVM userspace
>
> Changes since v1:
>  - Dropped have_state in PATCH4 as suggested by Drew
>  - Added Drew's Reviewed-by in appropriate patches
>
> Anup Patel (6):
>   RISC-V: KVM: Set initial value of hedeleg in kvm_arch_vcpu_create()
>   RISC-V: KVM: Introduce feature specific reset for SBI FWFT
>   RISC-V: KVM: Introduce optional ONE_REG callbacks for SBI extensions
>   RISC-V: KVM: Move copy_sbi_ext_reg_indices() to SBI implementation
>   RISC-V: KVM: Implement ONE_REG interface for SBI FWFT state
>   KVM: riscv: selftests: Add SBI FWFT to get-reg-list test

Queued this series for Linux-6.18

Regards,
Anup

>
>  arch/riscv/include/asm/kvm_vcpu_sbi.h         |  22 +-
>  arch/riscv/include/asm/kvm_vcpu_sbi_fwft.h    |   1 +
>  arch/riscv/include/uapi/asm/kvm.h             |  15 ++
>  arch/riscv/kvm/vcpu.c                         |   3 +-
>  arch/riscv/kvm/vcpu_onereg.c                  |  60 +----
>  arch/riscv/kvm/vcpu_sbi.c                     | 172 +++++++++++--
>  arch/riscv/kvm/vcpu_sbi_fwft.c                | 227 ++++++++++++++++--
>  arch/riscv/kvm/vcpu_sbi_sta.c                 |  63 +++--
>  .../selftests/kvm/riscv/get-reg-list.c        |  32 +++
>  9 files changed, 467 insertions(+), 128 deletions(-)
>
> --
> 2.43.0
>

