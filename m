Return-Path: <linux-kselftest+bounces-4913-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4515A85950F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Feb 2024 07:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B3E282294
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Feb 2024 06:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1D86AA7;
	Sun, 18 Feb 2024 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIirGwTq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F763A9;
	Sun, 18 Feb 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708238476; cv=none; b=NN1Wn+s5C4Oq71q9Mkt2+R12Yb7AyPwmmro3WmisqKkYpMvljKgUPjbO0Ch0ZJThMvfCaez72myPLmtceJqOh7Ji9Tt1Nx01wz7W56KmfKPV2s/VIovoxXtnqzcSytLs24dVLT6CC+tfUIFjU+zjQGWSQRD19FBPDLduwIyO8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708238476; c=relaxed/simple;
	bh=iuQbiFx2hJLfWb+6L78zmyCOPRaRIT6gS+4sPUW3K4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efMKckdG/nwfhPr1zMhwdH1j9eujlW8ha+5sjWSj+ZungxMVyNYMk0WRGME6YtKYmc9oz8NEaYTIGY8CsE4RIBDPAubH2O3qXzIlsUzAU4AV8jgn2kClZaOFuY/L2HdX2hng4ThjwaNZ0R/HUvQMDb1VXBeolW8wmdj2JGi5V5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIirGwTq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d22fa5c822so7706281fa.2;
        Sat, 17 Feb 2024 22:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708238473; x=1708843273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0Y6u+5ShCMCnWeHjQjEcItSyrNAyQ4PzYVN7xsknZY=;
        b=QIirGwTqqGyHzI+XMVjKhstg12wSmSuwqE85Cm0b2iqvZBeh1RRlO5opcUJra4Gs0T
         rJAuOeFJarGA0FPjgLFlrX3oXe2Lz6bMlHvjvLL0fgyse7jZ/GOAe8YTBC2esWgsbnkG
         u5uvCs2NKmYAvZfG50NLFfhkwGtqcD617x+HFEN5egfehzuyIYWBHaeaoW19lf46asFo
         7SIulg2A94je5tqDLSwgKa0whJEV8P3FDCrxPItnanzH9ueQGciXSgpZWyvkV3B83dYk
         ZFrFVu2Ojlqz+8kAn0RC3Zv2dha9vsmjKV/Ng3uapH79U6lv4SxdUktpcHWF/KanSga+
         EBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708238473; x=1708843273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0Y6u+5ShCMCnWeHjQjEcItSyrNAyQ4PzYVN7xsknZY=;
        b=ppdPsXlAZMh8s3x9UkMeAwJ51c92DY0vOxs4iAMdu7KizaG2XSvKDt1r7fG/SL2WnA
         mfQgkV8Fzxu21/omeiBMCLzgcOQgG4rjc5jeSxx+Q3FCe2gL4vqtdPIl3292c2rJVtXj
         OYN6hAofKTm2AMH5unAetpw5h9WXMj92JRWL0Cqq6ILGpqYx51N8y5c1ObMmNP4ufjNg
         JPlSVPG1IvvoJDepeikLnHEWBrOah8gRQf/Az1SzKxLMXT8J0fiVukQp5cjJyT45JUcM
         THsgvWtSg09lLitRiiT9q8sZGmCopAJqectzjOliTZTzylbTC3Y5dmDL/gsdS/uswv89
         Sbsw==
X-Forwarded-Encrypted: i=1; AJvYcCWclt3JhtVlS8S1mIAmtT+HvkAWTTnBwjIlIc9Gamm6iTNQro4FAUdq/SS/jbU7HEiKkXkdcPOxDwxIbn9Jgy/872SsCXViFvLwcOi+IqZ5EJxNZbkEBDnRvDslq8GaPgGrsDo5M6iR7XPnCDNMEVUhsV707ed2ie22K1/Al9styPLu
X-Gm-Message-State: AOJu0YwQU/GwuaB/6SIEw8zxCmBBSD1CnbliYbMX3SMZvRSnihmZC+DJ
	VQ7uC4e91x8EyisL78NUFiolAYYF3bziR4iChb4sMuVU+E3s6KkrREnizwIC6R7kpDXjA+Guqml
	LLhYC9pPIuvIz9lYMjjYaajQteFw=
X-Google-Smtp-Source: AGHT+IEU/ZiwgqWrDWfItsbjFQF1nhRZH5qrkBorAITC5xFGNJCVzU/oI+JZS45+PPkqBNqvb8/D/bZalu0eAbcSmoY=
X-Received: by 2002:a2e:8684:0:b0:2d2:3913:5c4 with SMTP id
 l4-20020a2e8684000000b002d2391305c4mr54562lji.37.1708238472941; Sat, 17 Feb
 2024 22:41:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705916069.git.haibo1.xu@intel.com> <CAAhSdy2wFzk0h5MiM5y9Fij0HyWake=7vNuV1MExUxkEtMWShw@mail.gmail.com>
In-Reply-To: <CAAhSdy2wFzk0h5MiM5y9Fij0HyWake=7vNuV1MExUxkEtMWShw@mail.gmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Sun, 18 Feb 2024 14:41:00 +0800
Message-ID: <CAJve8okkfvdRtvh8onQYL7_bmv9ntrViP54u805fQMq3apWFcQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] RISCV: Add kvm Sstc timer selftests
To: Anup Patel <anup@brainfault.org>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atishp@atishpatra.org>, 
	Guo Ren <guoren@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, wchen <waylingii@gmail.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Minda Chen <minda.chen@starfivetech.com>, 
	Sean Christopherson <seanjc@google.com>, Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>, 
	Vipin Sharma <vipinsh@google.com>, Thomas Huth <thuth@redhat.com>, 
	Aaron Lewis <aaronlewis@google.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 8:24=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Mon, Jan 22, 2024 at 3:15=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wr=
ote:
> >
> > The RISC-V arch_timer selftests is used to validate Sstc timer
> > functionality in a guest, which sets up periodic timer interrupts
> > and check the basic interrupt status upon its receipt.
> >
> > This KVM selftests was ported from aarch64 arch_timer and tested
> > with Linux v6.7-rc8 on a Qemu riscv64 virt machine.
> >
> > ---
> > Changed since v4:
> >   * Rebased to Linux 6.7-rc8
> >   * Added new patch(2/12) to clean up the data type in struct test_args
> >   * Re-ordered patch(11/11) in v4 to patch(3/12)
> >   * Changed the timer_err_margin_us type from int to uint32_t
> >
> > Haibo Xu (11):
> >   KVM: arm64: selftests: Data type cleanup for arch_timer test
> >   KVM: arm64: selftests: Enable tuning of error margin in arch_timer
> >     test
> >   KVM: arm64: selftests: Split arch_timer test code
> >   KVM: selftests: Add CONFIG_64BIT definition for the build
> >   tools: riscv: Add header file csr.h
> >   tools: riscv: Add header file vdso/processor.h
> >   KVM: riscv: selftests: Switch to use macro from csr.h
> >   KVM: riscv: selftests: Add exception handling support
> >   KVM: riscv: selftests: Add guest helper to get vcpu id
> >   KVM: riscv: selftests: Change vcpu_has_ext to a common function
> >   KVM: riscv: selftests: Add sstc timer test
> >
> > Paolo Bonzini (1):
> >   selftests/kvm: Fix issues with $(SPLIT_TESTS)
>
> Rebased on Linux-6.8-rc4 and queued this series for Linux-6.9
>

Thanks!

> Thanks,
> Anup
>
> >
> >  tools/arch/riscv/include/asm/csr.h            | 541 ++++++++++++++++++
> >  tools/arch/riscv/include/asm/vdso/processor.h |  32 ++
> >  tools/testing/selftests/kvm/Makefile          |  27 +-
> >  .../selftests/kvm/aarch64/arch_timer.c        | 295 +---------
> >  tools/testing/selftests/kvm/arch_timer.c      | 259 +++++++++
> >  .../selftests/kvm/include/aarch64/processor.h |   4 -
> >  .../selftests/kvm/include/kvm_util_base.h     |   9 +
> >  .../selftests/kvm/include/riscv/arch_timer.h  |  71 +++
> >  .../selftests/kvm/include/riscv/processor.h   |  65 ++-
> >  .../testing/selftests/kvm/include/test_util.h |   2 +
> >  .../selftests/kvm/include/timer_test.h        |  45 ++
> >  .../selftests/kvm/lib/riscv/handlers.S        | 101 ++++
> >  .../selftests/kvm/lib/riscv/processor.c       |  87 +++
> >  .../testing/selftests/kvm/riscv/arch_timer.c  | 111 ++++
> >  .../selftests/kvm/riscv/get-reg-list.c        |  11 +-
> >  15 files changed, 1353 insertions(+), 307 deletions(-)
> >  create mode 100644 tools/arch/riscv/include/asm/csr.h
> >  create mode 100644 tools/arch/riscv/include/asm/vdso/processor.h
> >  create mode 100644 tools/testing/selftests/kvm/arch_timer.c
> >  create mode 100644 tools/testing/selftests/kvm/include/riscv/arch_time=
r.h
> >  create mode 100644 tools/testing/selftests/kvm/include/timer_test.h
> >  create mode 100644 tools/testing/selftests/kvm/lib/riscv/handlers.S
> >  create mode 100644 tools/testing/selftests/kvm/riscv/arch_timer.c
> >
> > --
> > 2.34.1
> >

