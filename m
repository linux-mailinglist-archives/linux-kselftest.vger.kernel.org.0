Return-Path: <linux-kselftest+bounces-14348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6337993ECAD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 06:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C702813D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 04:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7603839E3;
	Mon, 29 Jul 2024 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="KE8V/R7l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47968288C
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722228400; cv=none; b=D+yL6VsYsXajgjSXj+ah0aj/AzLhS2Qb0uy0c14gXXpX+j9bIvYG80EMqGO6gS15I5mCl2y5LVgw6cuRo6PQLI0o9D5mKVfmw3gLXDwWvpFLehlipZmbFp8EqISY4mu3KFSgur86lHnyn3OrKSmkaiyb/B9jwtEW2UPZ9+bKPN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722228400; c=relaxed/simple;
	bh=2w4uyh/GOZovEWb83IxHnqPcuR/YIdWIEouPZ22d3wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edRtcCw8lXRuNV5A1nnFhAFoz2YSNwcXy7QimJpUjK255QwhTtB0js/EH0iZLpShEqgohtnyOlZuh5WfpfRY1/VvbnIx8xnhG6ZLlN9tJK8O5JQl48Prwn6ESppLahFr/GEq5D5exetiCC30cY5D0rYawPeg2vfffCbelEmqDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=KE8V/R7l; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3737dc4a669so15576995ab.0
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Jul 2024 21:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1722228398; x=1722833198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW7iKI5VA6V8XgNVOHyNoqHMEwUK7QtSHaQ1viyOIsc=;
        b=KE8V/R7lY77p1fG4iLiKe7vSnU+7ewBUfDt7wON5EPxtLe2Ssa5V3+TDbRMJV+LWd7
         SVnv0yFr3bMjtpPSm8LF/L3TLmIbpLV6k41h2uq6xDWDQvQkfOIDI60XnqqPcDZmVbOf
         wWpqGtUjgvLSvhaERR2c1U7skGeFzJxkaG1NccyRu6buBRpjUR6C0Ol3bIsvBE65qJPT
         0BLXhYzyEt7vg6GE1NXhR5gO8fuEG+t9GjKQaKaLKil401x24VvNNa5VqCwXcQWYQAke
         bY54sTaGDsHTlc7qzvqmHiOV10KYgshzzEcy/mP6wiME7aelkEJ6QWc9TMomEQ3GQSyA
         YWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722228398; x=1722833198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OW7iKI5VA6V8XgNVOHyNoqHMEwUK7QtSHaQ1viyOIsc=;
        b=SbD5VIyLyRksWQ5G5J+Jw9kGuzVyoVyNAOiIBsdUBR57fiq16YyirL3nm2au39JiU7
         XCqSqXuMpsqV5bVZQIT1yuZC5AZiOYJycThIcxjaEHLp2FE8E/RBPfU5Z6fOqaPHemB4
         +BDVMTK65Pgb92rFA1be71u3fZk2vr0e7Kb5McXFFSxfPhHVea4uSb23Wk3AKs3sBMjU
         SNSc2ve8x90U1KtL4+4NN9kgx4ggG6+3kRcfwdaGRyKS89Wy3GZJCjggTqy2zCs8lkem
         t6H8/962Rm5VuIIrPdbj7WOG7l5H4h/rlz21A/d4IQ35cwHGr0g+kTxTwvNeKh/kcbyB
         6HsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT8lqpugU+WJjO8ulsrN6fttSHQIw4siNpBfp66GpPSFIJpd7v8/gCpBVExwIKPKOVoptWgTNWGBX+UJ/jNkfPj7vyAJHgk0wpllPDEYjt
X-Gm-Message-State: AOJu0Yy4ZTa3PQBgYpPZfujtII73y9QVh/Aim8h3TC2X8Fa8YQ+8pqag
	DC7MODZL/nxdfbHOsrOv37so+TBA/nabieuRA5cnKPzECEWv5qrqtqNlOL1fWvnVD573xF4Sgn8
	h9msZc3aUNJWN1OBKTrBvE1PxsPBrexwKaQxSgg==
X-Google-Smtp-Source: AGHT+IHBbVydjPrAC5zGlF7xgbsY+f63BZCI3Qdtaq/cb1kuBVX2K7LOkNc3W9JJ2Y0boEOPjiAkAJkUZnp9b/68Qjg=
X-Received: by 2002:a05:6e02:2163:b0:37a:601c:9147 with SMTP id
 e9e14a558f8ab-39aec2d8533mr72590785ab.10.1722228397863; Sun, 28 Jul 2024
 21:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726084931.28924-1-yongxuan.wang@sifive.com> <20240726084931.28924-5-yongxuan.wang@sifive.com>
In-Reply-To: <20240726084931.28924-5-yongxuan.wang@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 29 Jul 2024 10:16:26 +0530
Message-ID: <CAAhSdy2Tvt3+w4=zwKOJJF4absZBGxacWmV2y517RqVqLWGEiQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] KVM: riscv: selftests: Fix compile error
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, Atish Patra <atishp@atishpatra.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 2:19=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> Fix compile error introduced by commit d27c34a73514 ("KVM: riscv:
> selftests: Add some Zc* extensions to get-reg-list test"). These
> 4 lines should be end with ";".
>
> Fixes: d27c34a73514 ("KVM: riscv: selftests: Add some Zc* extensions to g=
et-reg-list test")
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

Queued this patch for Linux-6.11-rc1 fixes.

Thanks,
Anup

> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index f92c2fb23fcd..8e34f7fa44e9 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -961,10 +961,10 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zbkb, ZBKB);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbkc, ZBKC);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbkx, ZBKX);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
> -KVM_ISA_EXT_SIMPLE_CONFIG(zca, ZCA),
> -KVM_ISA_EXT_SIMPLE_CONFIG(zcb, ZCB),
> -KVM_ISA_EXT_SIMPLE_CONFIG(zcd, ZCD),
> -KVM_ISA_EXT_SIMPLE_CONFIG(zcf, ZCF),
> +KVM_ISA_EXT_SIMPLE_CONFIG(zca, ZCA);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zcb, ZCB);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zcd, ZCD);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zcf, ZCF);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zcmop, ZCMOP);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zfa, ZFA);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);
> --
> 2.17.1
>

