Return-Path: <linux-kselftest+bounces-8589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841C58AC39E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 07:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E991F215B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 05:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0A71759F;
	Mon, 22 Apr 2024 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="QTcc38Hv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC518E10
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763505; cv=none; b=MqvD5P38oBbrtF7xDBRLCt76klix+xLl2QW7RuW/qFnwkc9v270qbmeBCamtbTG+/F1wrZ9nrfdPCkW/luK7UmtDyJnp2H1zghFOzv5Ah8cnsogJzk7osdqWcFwp2ppeDSJEB00Xcr4MZ3k2Ny1/SF979J4X40GhFK/zAW99tKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763505; c=relaxed/simple;
	bh=Ik9DM1QNpRlU+dZ0CiUmfKQUt5GK17SQR7pdunVTi1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HM8OXm1XDeu40C6g8h7fNfrx2abK+cx0lMX5vza7bGutpKKKZbbYQIBkPWpTcCfRzrm07Xcb9A5lShgrRfHUnsfZhohqmDjSq6Vm7EHxEbaTBeQJfYwAEt1A/EWYpw9hpN3Qm/keusG1HiECdiqiVCeYqzv6u5zursdfChUlXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=QTcc38Hv; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36b309dd33bso15818875ab.1
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Apr 2024 22:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713763503; x=1714368303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF7iMXOY4VDDCKv5qNAPNo7XCDSpEYvkOWLnZnfiQso=;
        b=QTcc38HvYi+gmcROXNRPsN2+ACsXYSft+1UQ15tpXXXGoGqZlrz19XifTGmH4TgnQY
         Zof3ACGEUZ/cK87E0+XDCuiBkB+WplA5CAaxOwnxx2V6JthzB5/C3AmcataAjo6BWJSV
         k1pmen2KHTwR3Y5Ygo9ScVSJySmr3kzaXiyX7NEEB/h1/u9sx00ZJxSuXeJO2lzqdAdw
         c0eIU6EUtvTPi4STzxTw558iLQ7E7vV6VNAu/O3RWFC6vK1UjAK8KccfdVgeDNooDh6X
         AgxwUxgEW9A1CiY4wFERXwV2cZoCBxCqzCRldZFr0WxJVeuOVubx6zV1g3e77iPEYgTL
         NmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763503; x=1714368303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dF7iMXOY4VDDCKv5qNAPNo7XCDSpEYvkOWLnZnfiQso=;
        b=RhyT9oNjaY/YRdz3YVwRL4c3jYVFwWecMoj5XuxDDf7pTrloXjrdoq6mZwoC37hIDA
         JzuGBteSB7Es+ijArCXIBs3MrzYS1xdm+zUpL9ygrqfYWUCJ5BPbQH8H05u8m1La7UF5
         BNOBckEs370XL7XTqRvA8t3s51ekfSOghKpM2j9o3oPQMbjQZePOTraUmDj70HJsRCqo
         wkJzR7VJsl1EGkfzWSr1OC3OVvTSYQXoW7+N7cxYv0Z5CiFAeq7wQ0+SIk9sU75Y3pPU
         4ddEvssFtDnukfqHpRqOHDADCEn2/Knekm1JVN4KRPnmc67+t6qMdYAyXDxmutHrU32X
         kMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUewbk9+uDmsqsZcwTJhqJUTh5eFT+7sAMwDa3WY1AoKMvC2e/x8Yg6Wnuq+2WOlng39bKsULRIDbGmNzkKm7PhDllg+PsJYs2k8hqXSyy1
X-Gm-Message-State: AOJu0Yz0Pxwv5P/KD7OfMdkAEE5FwpEkzb07ymMII0Mtkgc1A7pvHPxG
	QnVqff3BxktDcVaM3zTg2G38xNXyAGiWWspEkHtt9ZEbxTmuo7gPpHyUYJYMC/V4Zf5GrVLp6SL
	DYI8XSQSHq42kizRQ8tZzXdAUkbaTiLlnew2djQ==
X-Google-Smtp-Source: AGHT+IHdn2npWqT6eXE8OXOJ8aeE+1uvyLE2k3jLpLR2kMrW4luyMtoF2cYuLh1aaMn2GPPBLemb20goD4jLZbNz7Kk=
X-Received: by 2002:a05:6e02:152e:b0:36c:a46:e018 with SMTP id
 i14-20020a056e02152e00b0036c0a46e018mr5159166ilu.24.1713763503545; Sun, 21
 Apr 2024 22:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420151741.962500-1-atishp@rivosinc.com> <20240420151741.962500-11-atishp@rivosinc.com>
In-Reply-To: <20240420151741.962500-11-atishp@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 10:54:52 +0530
Message-ID: <CAAhSdy34VhGY3v9h3cw167MafKHOF1dL6zqB7Wi6A9Z4fo7ZNg@mail.gmail.com>
Subject: Re: [PATCH v8 10/24] RISC-V: KVM: Fix the initial sample period value
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
> The initial sample period value when counter value is not assigned
> should be set to maximum value supported by the counter width.
> Otherwise, it may result in spurious interrupts.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kvm/vcpu_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 86391a5061dd..cee1b9ca4ec4 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pm=
c)
>         u64 sample_period;
>
>         if (!pmc->counter_val)
> -               sample_period =3D counter_val_mask + 1;
> +               sample_period =3D counter_val_mask;
>         else
>                 sample_period =3D (-pmc->counter_val) & counter_val_mask;
>
> --
> 2.34.1
>

