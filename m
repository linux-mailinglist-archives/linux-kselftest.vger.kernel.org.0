Return-Path: <linux-kselftest+bounces-8592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C6C8AC3B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 07:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E411C216E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 05:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFECA1802B;
	Mon, 22 Apr 2024 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="N0BypsN8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9C17BCE
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 05:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763778; cv=none; b=WfWoejlXfO2RpJwlfYU15kiWmgDaDDXJrObCfix9hV47Kso/CWFQRXXGadqaEQzfxoLbq6CK4zJXj4kqIsPQvlpawUOjK4fWTrpSG52ZJWX7s0HjTms/bBgGqM9Krsot5J0r+Oy2xAVCan2GO96tzZMo7GggXdfxq6OLIOe5IEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763778; c=relaxed/simple;
	bh=hfR8wFHUTqy0PtbXA2fJ051uKSvhoqdLre89/yRBZd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxUB7Q3gQlRNZRDd3z7DfxAdI8tK6XL843EoEMchmXUp6q5VHjrb4zXEYcmWGLWldo0zeWC5md57oHZSQJHbV2cG+bP6lNrY0kDcnFe0zMmZNHBoK5Oaukez+lWRq06Ixs5AXgzqxPlRuaS4hfrhF5QcDKpzdG1phdxmOI+KFJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=N0BypsN8; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36a1b0777b7so16527155ab.0
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Apr 2024 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713763776; x=1714368576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u4byTUlDNwKD7I4IoEN6osZEpNF6BpvONGOZchupOs=;
        b=N0BypsN8wDRJd9d/z8/qwGh8UEBJ3xSnZIGHcg2UXL6s11+4hTS8VABs5zUU76jQKV
         wgK4AxpmmM2NxPPRtDPKe/yI6jR3YzPbPysCwaIqGvGVTTg859GYSa/N3ag9t0BGPLKL
         /6l3xIgPyrhCgJxSJ2CcI1W6bfxDYj04L1S1ra0/CQYhVPK6JfDkXosvWXmH9xORJmiI
         +PpBmsUavEJHqilB52b9cCEB9EUGOadV7950tSJF/OEp5FzIXhVVOhHY6gJK5nx3VzdY
         ySse7b7XiJ+8gMwGHboqZttPHuBCjVgDOihu5S5Bpgui7GrpajoHvdGUmhTgITbiWRF8
         4sYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763776; x=1714368576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/u4byTUlDNwKD7I4IoEN6osZEpNF6BpvONGOZchupOs=;
        b=v422EC01Tnva3fx5uEanQtqUChZ/ZJkoYIc4rXJAiIcgN52lVdHvQBAJGK9JzGPt45
         xj8KMaNF6DKNgN8zf4G9CY6v0AqBaH5DT5oE8NwVwx4rz8qQSSaw+ZZkG3lVbFJhKEXN
         TjcTFB6n59K/mO19AWPFC6tIMZ+mOWjjzYCYdtfiA5/haGG6WmGbHA0OdKBLZqRRpwQv
         vISHEOgXHRueaofzIK3qxoDKepKiCa0Erza5iI2gz4LC6FMuoRyNUDPc34R1/HosSxGH
         8in5qmAgTdsZOUI1+elnPFETyKMcJo7UQIoH4YOsOhN44T0+ynIeC7CLQdyYHsv4iKgV
         Hu1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAsHRxpasPaQuBYBKL+8auHJw43DQqGebSWjheMTALf6iIqGVqTvJ9raFiwJaGdC+R6GsNose947aEVq9BEDjn4EIZCPvDT9wrloi6WgWb
X-Gm-Message-State: AOJu0YwPsr8ML7BDIHU8zxbNGybhw11SLJdsGGxAwW2ET6vqPPycY8+x
	mIzT7xm2RjCE0AwpHRyAvpjLljj8KjH4kwoXJurDGenEfsrlJJxAcoxX3gxNW+uFMYBXyMK04ft
	1UIATawZ6nubAYqeUal2Pn8pP9GnhHuy/YtqwkQ==
X-Google-Smtp-Source: AGHT+IFC/ggrORFQDRIsgf3m5CDc64LQxhFUDaRtJHNN1AtIkubwk7+EwLTGLb3mIW99QlL7g0zTkCXH/qKaaakQzOk=
X-Received: by 2002:a92:cd89:0:b0:36a:fa7a:629f with SMTP id
 r9-20020a92cd89000000b0036afa7a629fmr13121951ilb.21.1713763776638; Sun, 21
 Apr 2024 22:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-19-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-19-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 10:59:25 +0530
Message-ID: <CAAhSdy0OmAjs1oHUjPzwUydsnGtqUd_HKTZKZzJpQQFEXvPX8w@mail.gmail.com>
Subject: Re: [PATCH v8 18/24] KVM: riscv: selftests: Add helper functions for
 extension checks
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, samuel.holland@sifive.com, 
	Conor Dooley <conor.dooley@microchip.com>, Juergen Gross <jgross@suse.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	Will Deacon <will@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 5:18=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> __vcpu_has_ext can check both SBI and ISA extensions when the first
> argument is properly converted to SBI/ISA extension IDs. Introduce
> two helper functions to make life easier for developers so they
> don't have to worry about the conversions.
>
> Replace the current usages as well with new helpers.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 10 ++++++++++
>  tools/testing/selftests/kvm/riscv/arch_timer.c        |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index 3b9cb39327ff..5f389166338c 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -50,6 +50,16 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uin=
t64_t subtype,
>
>  bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
>
> +static inline bool __vcpu_has_isa_ext(struct kvm_vcpu *vcpu, uint64_t is=
a_ext)
> +{
> +       return __vcpu_has_ext(vcpu, RISCV_ISA_EXT_REG(isa_ext));
> +}
> +
> +static inline bool __vcpu_has_sbi_ext(struct kvm_vcpu *vcpu, uint64_t sb=
i_ext)
> +{
> +       return __vcpu_has_ext(vcpu, RISCV_SBI_EXT_REG(sbi_ext));
> +}
> +
>  struct ex_regs {
>         unsigned long ra;
>         unsigned long sp;
> diff --git a/tools/testing/selftests/kvm/riscv/arch_timer.c b/tools/testi=
ng/selftests/kvm/riscv/arch_timer.c
> index 0f9cabd99fd4..735b78569021 100644
> --- a/tools/testing/selftests/kvm/riscv/arch_timer.c
> +++ b/tools/testing/selftests/kvm/riscv/arch_timer.c
> @@ -85,7 +85,7 @@ struct kvm_vm *test_vm_create(void)
>         int nr_vcpus =3D test_args.nr_vcpus;
>
>         vm =3D vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
> -       __TEST_REQUIRE(__vcpu_has_ext(vcpus[0], RISCV_ISA_EXT_REG(KVM_RIS=
CV_ISA_EXT_SSTC)),
> +       __TEST_REQUIRE(__vcpu_has_isa_ext(vcpus[0], KVM_RISCV_ISA_EXT_SST=
C),
>                                    "SSTC not available, skipping test\n")=
;
>
>         vm_init_vector_tables(vm);
> --
> 2.34.1
>

