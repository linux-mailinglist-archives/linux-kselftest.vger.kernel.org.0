Return-Path: <linux-kselftest+bounces-31639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C94CA9C894
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 14:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA5C4A77B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E54248176;
	Fri, 25 Apr 2025 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="zUi4Sgjl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA002475CD
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582984; cv=none; b=N10D3bq/7ZLEWkT6jjjOGbsVj+qDi6t7BRiaOnplqS0BxRBPbzCIBg7l+DI4b18PZxG4B3HrC7E425k8fFvmwgk1JxfpFOr62lGxn/dFNlUd6ifBolm2UaY4ICU/EaXX33s8QJvePlAiSmlvSQqHeYROmrZmPfUroCCOmO4u6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582984; c=relaxed/simple;
	bh=Zxm4WulE6nllv3dcY5iH7gFi33gUsbG3+YxtX1wnINQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5As9ltgmVX0FICvCOWIF8V+eFU4aYyFDEFufbUOYHGdH5hZklCJdiEZzQ0KFjOeSFwrLennFypt0VoDTpDv4m3jvcsRZLPv+R6LXIzJrHouWY0Fo0nPb+5nFuofdiN0hDCBPiO1ExTe370XNUVDjiDi5DHAI+u5i++MhVR4QR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=zUi4Sgjl; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d4436ba324so20392885ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Apr 2025 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1745582982; x=1746187782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viCw2qA4ejmDM4IL1wv9giS7D3cMPoAepDm5Vm/i2EM=;
        b=zUi4SgjlJBzSh0xtjOn+Pcl21QkhhCwXgqVxRQr6287ChU/x8U1gPxDjcJ5JJd/a4W
         8N+L9iyjGMqlDH13lwiilFCJQhTa+N9PiDHmp4XTg2SjgwwKcu3Rd7y2lr1aUuM+7Qou
         QPndFx4ppyK5aK/Rh6OoxozSdZ07hXE8EKA3yOEAHPlzr6+IjVA+FgQdlHXC0AMjEyLt
         s1YBbYN8ExY1Y/S02GgrlaUQz5Sr4GKaLMlGlq2hSVKds0uy6WiJWx2EDEtZ0QuCoXjI
         RRA+MNKUFtYBC6JsnDcO1odi1doIoKbE3Nsvdk6MwKiEkUdBYVMBg68u4ay1NAMXRvoE
         tBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745582982; x=1746187782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viCw2qA4ejmDM4IL1wv9giS7D3cMPoAepDm5Vm/i2EM=;
        b=BoIhBN/Lj6mFI5InnYr6J8zGjXU0lX0Itj+nUldO52x2AkOxrqXOWTWCL0CcTOxhiH
         h48+HNdAGYoh5U9Nt3TyKSmie9UU3EYOJbCLipNKe6VyG1s3sxhrch9rBww0mT6pj5dd
         iK3Amep17bicNR06UyIW1X5XwmXYQA6RdRq4dZO5QfZkmv9fFglY/edUGF4txDu4n5rT
         aZS5PBN4fPuNxS4nliVwOsJEJV9FK/2oyv1ctlJY5Fdev3v/vi6Zh7zKvG/Nooj/UqzJ
         YYCOjYt7niUgh/Ts2W/bzY87WEkjSfgSTMeKbrnP8NcjFiVXkz1LzWRqPGHDbFL9dQ1L
         wCAA==
X-Forwarded-Encrypted: i=1; AJvYcCWhGmzU2JEWILQHsNNQQcveFA6poblxzQoDRoYFVY8ZNu1JcEIi4uBXBWvaopj2aH8gthTjPEWjtuzaCn54qJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhavfwuQ81YScyDeiBCIWHSSH5j9tFSPRpzKzkAiZ5wUiNu4F
	fAjmnwDa5J1wyXQG4nGAD6O5QOW79RcQsi4FFAyhlP8RXDpYZyWbAAWihM77n1Xu46CqsVMiseF
	eHzWYZMq7T8Hb145Y0EsK/7t7fDnjhwJkf64KRg==
X-Gm-Gg: ASbGncvhFYw1r47h4PPLaVZQ/itIkBloFfwICRWyDuPxaUeJOTm1O5oxMNAKfuy66G+
	RfjAwBgpMQym44Hz3PA/ho2QwIFIz1Tv3diXWFwFuDz63Qj+2J9Q6KK6LEPaNjpqi5SA7d7r5ai
	c/KmVHp7NLAhNgLS//aoDTN17IscFmG3QzYw==
X-Google-Smtp-Source: AGHT+IGoEJG5zH/Wr0uFePVEm/5CuSYxVySEAKvHuO5qDV3z6MJIg+y3hhgx9qY6URyzTt8T0jY2qH9X8K2GpPqyw1A=
X-Received: by 2002:a05:6e02:174a:b0:3d4:2409:ce6 with SMTP id
 e9e14a558f8ab-3d93b3aad74mr19265945ab.5.1745582981830; Fri, 25 Apr 2025
 05:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-kvm_selftest_improve-v1-0-583620219d4f@rivosinc.com> <20250324-kvm_selftest_improve-v1-1-583620219d4f@rivosinc.com>
In-Reply-To: <20250324-kvm_selftest_improve-v1-1-583620219d4f@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 25 Apr 2025 17:39:30 +0530
X-Gm-Features: ATxdqUFstmpMiz2VW1TbmZRJAZ7pd1khz3F8RMk9AGfAqqDs4TxHZFyQgyus6fM
Message-ID: <CAAhSdy11BqtEV+RoFmnpizxCTiKaWexMQGKvP15BF-AkDZUDJQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: riscv: selftests: Add stval to exception handling
To: Atish Patra <atishp@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 6:10=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Save stval during exception handling so that it can be decoded to
> figure out the details of exception type.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 1 +
>  tools/testing/selftests/kvm/lib/riscv/handlers.S      | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tool=
s/testing/selftests/kvm/include/riscv/processor.h
> index 5f389166338c..f4a7d64fbe9a 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -95,6 +95,7 @@ struct ex_regs {
>         unsigned long epc;
>         unsigned long status;
>         unsigned long cause;
> +       unsigned long stval;
>  };
>
>  #define NR_VECTORS  2
> diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/tes=
ting/selftests/kvm/lib/riscv/handlers.S
> index aa0abd3f35bb..2884c1e8939b 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/handlers.S
> +++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
> @@ -45,9 +45,11 @@
>         csrr  s0, CSR_SEPC
>         csrr  s1, CSR_SSTATUS
>         csrr  s2, CSR_SCAUSE
> +       csrr  s3, CSR_STVAL
>         sd    s0, 248(sp)
>         sd    s1, 256(sp)
>         sd    s2, 264(sp)
> +       sd    s3, 272(sp)
>  .endm
>
>  .macro restore_context
>
> --
> 2.43.0
>

