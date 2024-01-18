Return-Path: <linux-kselftest+bounces-3198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8259B83195F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 13:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395071F26C74
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605F250E4;
	Thu, 18 Jan 2024 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="sJB4mONY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655525112
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581897; cv=none; b=YyjmT5Vb1LPsFeSW9RxVMB5bJZybwQmhHfGb+HT4N15QWIoPDYFp6XpVfg+tgSx/dMLhDIYQuZ+fyA8qNVNslII7VlfwytaZlUqvt7O/qPA7XFKQzmjutvW/RRdUy9IHBjlFwdcnfWKeOJm46aarqXY32Tk/tCfQ/B6GlQOfbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581897; c=relaxed/simple;
	bh=37Nm1D6XQrs+VsUMHb4aux5DEe0RfLXArjfaU4qNE7E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=hT0zXdMrl/5eFzfmvam8/wkhBjkpz9e98d1DTSk45V7ky1P8PBdE+bCZmwyRBx9OGuYcI8iQDAMv4K4p/tOFlxDoRPKGr0tN8TY0H9oJJwoLBS8EsWqyOX527SBlNa82OtjHMKoy+6bK5N9ptggSMZhDkITe0gNl23EMvjoh5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=sJB4mONY; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3619299e551so7669585ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 04:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1705581894; x=1706186694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CWJqfzPlIKbIm9XXUGeYPV3xbAqaiB/K2JIOon3tWs=;
        b=sJB4mONYac4ucb+zlyOttrKg+C2KJdOhwVGrwOOOqeAhzOkQgatCRZ/XS6iyDeRQ1J
         LxKZhW6YnLCyUDVymX2un0bqI6gqc+ClQr8OJKRfF089QLglA8DMMRNoP1Fiae/4cOaT
         tVKJBSMyPJUMOFEKv2+3d/St9EDiz4IkRbeG3JNmYLGeC0ZE0GDjA+GXyS+uL2NPWFW+
         eChxVp1f7KztacUVaud4fLTsX+wqk9t47ltJNTwCL/KCf/021hCZVD7rOku9fDkSjeWy
         9z8IToguiLrlmkU4jrVIXgf0HO0icZjunON4RNbgkUovKIXq9kg2Mn6sMp9bkYkbv9T0
         plyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705581894; x=1706186694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CWJqfzPlIKbIm9XXUGeYPV3xbAqaiB/K2JIOon3tWs=;
        b=rIZiV+6bSwS1Nojh1UU5dH59h8TuYp/sPZmMb4gnz8Oo4sKdwswJqPXS3bI1AcxwZL
         xuUB7woKNtiOvBp7kcAPT84zG1209S0tAoIv52wdJfMuP+5zRc/Yh4DlBpPwMaaWPqk9
         XGmzoTeJn2DATncMM25xth6k7zNExgL/SSCi6sBhXjPHB+gWzKPPKmnk64aJgnkosjMP
         5IjgCo8DGywDovhrhF9XgdyEyjRSVVjpTaEvwPowQTJhMQlJZ4ii+a69DgSd0jF52WfC
         vTIdq11gZeEB3cnJ3GOryOq4lG7d9CNELsxpHwMz/ZH6aYD7NUqOXTypokC08U6noA4B
         Bchg==
X-Gm-Message-State: AOJu0YwPIa+C18qCHwnYdYoFj6CbmH1cFcMqb1VF5N8T+KvThHcs3t2x
	U5tYgRTOUrWP6PI3WVsxzcr0x6ALm3xPHqNpNaAtil8Z9BgPCdo4sR7F0Tf+8n+VkRwAyTZOSkW
	NhSoOpu2BSVvQU0wsUxDiZOQ2lBShQdIuuP5ZzA==
X-Google-Smtp-Source: AGHT+IFJ1bu7mCR98lyWrW+kDP0nULQ1bDHopDCzu01vUiZEYsTfjPTku/pcO21lNxa+IQGYXi5gy2BL1dSF+jC1bNQ=
X-Received: by 2002:a05:6e02:96d:b0:361:a21d:d492 with SMTP id
 q13-20020a056e02096d00b00361a21dd492mr227444ilt.24.1705581893859; Thu, 18 Jan
 2024 04:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128145357.413321-1-apatel@ventanamicro.com>
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 18 Jan 2024 18:14:42 +0530
Message-ID: <CAAhSdy0Q8raGzH_mUsvAo++KmWu3yqBkjNTrn8CO-ZCiYEY9Cw@mail.gmail.com>
Subject: Re: [PATCH 00/15] KVM RISC-V report more ISA extensions through ONE_REG
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 8:24=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> This extends the KVM RISC-V ONE_REG interface to report more ISA extensio=
ns
> namely: Zbz, scalar crypto, vector crypto, Zfh[min], Zihintntl, Zvfh[min]=
,
> and Zfa.
>
> This series depends upon the "riscv: report more ISA extensions through
> hwprobe" series.from Clement.
> (Link: https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivosi=
nc.com/)
>
> To test these patches, use KVMTOOL from the riscv_more_exts_v1 branch at:
> https://github.com/avpatel/kvmtool.git
>
> These patches can also be found in the riscv_kvm_more_exts_v1 branch at:
> https://github.com/avpatel/linux.git
>
> Anup Patel (15):
>   KVM: riscv: selftests: Generate ISA extension reg_list using macros
>   RISC-V: KVM: Allow Zbc extension for Guest/VM
>   KVM: riscv: selftests: Add Zbc extension to get-reg-list test
>   RISC-V: KVM: Allow scalar crypto extensions for Guest/VM
>   KVM: riscv: selftests: Add scaler crypto extensions to get-reg-list
>     test
>   RISC-V: KVM: Allow vector crypto extensions for Guest/VM
>   KVM: riscv: selftests: Add vector crypto extensions to get-reg-list
>     test
>   RISC-V: KVM: Allow Zfh[min] extensions for Guest/VM
>   KVM: riscv: selftests: Add Zfh[min] extensions to get-reg-list test
>   RISC-V: KVM: Allow Zihintntl extension for Guest/VM
>   KVM: riscv: selftests: Add Zihintntl extension to get-reg-list test
>   RISC-V: KVM: Allow Zvfh[min] extensions for Guest/VM
>   KVM: riscv: selftests: Add Zvfh[min] extensions to get-reg-list test
>   RISC-V: KVM: Allow Zfa extension for Guest/VM
>   KVM: riscv: selftests: Add Zfa extension to get-reg-list test

The first PATCH is already merged in upstream Linux.

I have rebased and queued the remaining patches for Linux-6.8.

Regards,
Anup

>
>  arch/riscv/include/uapi/asm/kvm.h             |  27 ++
>  arch/riscv/kvm/vcpu_onereg.c                  |  54 +++
>  .../selftests/kvm/riscv/get-reg-list.c        | 439 ++++++++----------
>  3 files changed, 265 insertions(+), 255 deletions(-)
>
> --
> 2.34.1
>

