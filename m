Return-Path: <linux-kselftest+bounces-39283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4CFB2B977
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 08:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE13163040
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 06:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442C26B973;
	Tue, 19 Aug 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NnC4547D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6BB26B777
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585060; cv=none; b=eXDZwxxAey1+XiAVI6HqIwKfoNLC0a2N+xMPVKuYzfCh/+CX3slO/RyTM08PqmlQ8U7++vBTud00USfAK+tEc5C7eJKBZQi5VpDDsxjRKCZkcqji5wMMu0Ajw3hQqukyRUtBZ7xZK5HGRbBvrs2B4NQEkvwnbUM1P6BLAdShp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585060; c=relaxed/simple;
	bh=x5X4ewm5a89y5y4039N/SNIncKcOQEgQsBChRS5leiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsiqS1/CHhmtOseKEgopYzRjf2uAhYJTJaV3cnXmYtY9Uziq2bUvFV3kOiO9nDJ/YoLN4UFgefwVeWeAealgGSPsCAHhdH8exwwI2vJ8PGV8Nwx49ngiXK42ZWU8d5Z8jxE6E5mvsGQz5jetTx69zmSONws1n7saXB73Y/7Zm4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NnC4547D; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55ce52658a7so4728629e87.2
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 23:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755585056; x=1756189856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5X4ewm5a89y5y4039N/SNIncKcOQEgQsBChRS5leiM=;
        b=NnC4547Dt2cNAa4tdZ3Hz4tq3lRpCfukYB0aLUKB7Q8/EXrP1kjd8VQZCTcJQGw67m
         5mqBKBKazW4jeT6oHXTOnRSoGy8pz/gydTtTeAea0YVrEkB2pOKle87GGLg5O0oNbg3X
         uL73kco4TTvuXGUvLGQt9J4vALPqg6tVeZWajXe5nWK9YLtklxCbhYd0R4gVCnxgtB8C
         O17wz9XvdXJpfNJ2BVYHIOVKzBiK4ra4ZnrFTf8aK/FMCRDC/eFinegOTBjK9iXapACs
         wOnNWvQKa25Edp+o7+Vb5iP20EuoiOkqGZjb3kogjItUgl+QVSTN/EgB9fxt9Yy3KxRP
         V9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755585056; x=1756189856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5X4ewm5a89y5y4039N/SNIncKcOQEgQsBChRS5leiM=;
        b=tEF6q7RnNTRXz+YZT/jcKd4VMPGeBXXkFqAJxAdmJsILvJvjBbPFaQTorX4SrPeTLK
         qQp9ftvR0znmRzRXu64BPbcxD9XYjmTkhByafQmlaneAxtx8eWR6wq0rg1lMpdTqN28C
         XmAWCwZ7t2YmQ/Ue3PniD0ZJ202sgrVfr7h2OAkPppnnGUHjsTfdQXwJV1DAADlqyTyF
         iGn35QAxEA+twJUvLCfs5VkgrE9uYebCvKu0SDiJ5JF1tI9fZCuq4PGk03fjv+cChn2F
         TYo1S0rTK24vu8S6kb0ZZUvoAVM47KghLYcJ+9cjmSZVTYCwf//h0W7+gacjDqX2uglX
         BWEw==
X-Forwarded-Encrypted: i=1; AJvYcCVMupFyBfWnlI2t+S5ssPO5/MYu0sv7W2rV3s71SZYYdpoFqnga5HwU5/lAITCsTSEcNzBjd8CT5kYgj2522HE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRVCE+oPphFeb+w57JL4nN+fCgeQorUWR9tDP6DKS/o2YNW8MS
	Uz6M3PqZLjXJs+1ON4Zf9a3M4jmAAc44iuOIEKfiOQl29S0I0CsmhZ9phobQREUgOWJyJ8Yy1xq
	5zhxt9d5jkby9/LZjsmnwyRG3h79Qzf5wzhnimrIuXQ==
X-Gm-Gg: ASbGncuFW43Oag5KAVAueox6GRvZsRLd7aG2Rlt80WTGxRqHNX89UabLvedygvCxB/G
	30dJARE72YwHF3WsOQjWfgkTf9WocxrxpOB6MMNzoidaTNp3HoOF4JxhObA1DCDXFsuikhCBUHx
	XbJtvpu/ETQODivy2jz+i4N9u+31wMbrqIW6FGtuNTtVldg69y6LpOJUQOc89XlZZON6Nv/fpri
	A95yozbSK8EshCbhfQ=
X-Google-Smtp-Source: AGHT+IHHkURi8B2o/4zRpbceYSK5peOTCukcS7TN3aV1RdQ+I1LvQUMDMhIAD9wu5TYxwZrH3wzL9O70PnE8RRwWRSk=
X-Received: by 2002:a05:6512:2351:b0:553:2e42:fffb with SMTP id
 2adb3069b0e04-55e007af767mr477220e87.33.1755585056179; Mon, 18 Aug 2025
 23:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814155548.457172-1-apatel@ventanamicro.com> <DC5HEJRMZ84K.34OPU922A7XBE@ventanamicro.com>
In-Reply-To: <DC5HEJRMZ84K.34OPU922A7XBE@ventanamicro.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 19 Aug 2025 12:00:43 +0530
X-Gm-Features: Ac12FXyJ8d4Eeyc3Nquuqj0vADLxjc_tq1DtUjG2ODWh3IKeJDYP9l_pzAP_rIM
Message-ID: <CAK9=C2X8-DBi7qQ87kMA0AiVdiFH0_4L4mzzZzbeCg2eiNm8Qg@mail.gmail.com>
Subject: Re: [PATCH 0/6] ONE_REG interface for SBI FWFT extension
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 3:59=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcma=
r@ventanamicro.com> wrote:
>
> 2025-08-14T21:25:42+05:30, Anup Patel <apatel@ventanamicro.com>:
> > This series adds ONE_REG interface for SBI FWFT extension implemented
> > by KVM RISC-V.
>
> I think it would be better to ONE_REG the CSRs (medeleg/menvcfg), or at
> least expose their CSR fields (each sensible medeleg bit, PMM, ...)
> through kvm_riscv_config, than to couple this with SBI/FWFT.
>
> The controlled behavior is defined by the ISA, and userspace might want
> to configure the S-mode execution environment even when SBI/FWFT is not
> present, which is not possible with the current design.
>
> Is there a benefit in expressing the ISA model through SBI/FWFT?
>

Exposing medeleg/menvcfg is not the right approach because a
Guest/VM does not have M-mode hence it is not appropriate to
expose m<xyz> CSRs via ONE_REG interface. This also aligns
with H-extension architecture which does not virtualize M-mode.
We already had discussions about this in the past.

As such, we have two options. One option is to expose
hedeleg/henvcfg via kvm_riscv_config and another option
is to have a separate ONE_REG for each FWFT feature.

Separate ONE_REG registers for each FWFT feature is better
than directly exposing hedeleg/henvcfg via ONE_REG because:

1) Once nested virtualization lands, we will be having separate
hedeleg/henvcfg as part of nested virtualization state of Guest
which is trap-n-emulated by KVM. The existence of hedeleg/henvcfg
in kvm_riscv_config and nested virtualization state will only create
more confusion.

2) Not all bits in hedeleg/henvcfg are used for FWFT since quite
a few bits are programmed with fixed value based on KVM
implementation choices (which may change in future). Also,
things like set_debug_ioctl() change hedeleg at runtime
which allow KVM user space to decide who takes breakpoint
traps from Guest/VM. This means value saved/restored
through hedeleg/henvcfg in kvm_riscv_config becomes
specific to the kernel version and specific to host ISA features.

3) We anyway need to provide ONE_REG interface to
save/restore FWFT feature flags so it's better to keep the
FWFT feature value as part of the same ONE_REG interface.

4) The availability of quite a few FWFT features is dependent
on corresponding ISA extensions so having separate ONE_REG
registers of each FWFT feature allows get_reg_list_ioctl() to
provide KVM user-space only available FWFT feature registers.

Regards,
Anup

