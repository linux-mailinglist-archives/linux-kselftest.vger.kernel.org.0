Return-Path: <linux-kselftest+bounces-23577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 531669F75F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 08:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3FC168738
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 07:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280D216E37;
	Thu, 19 Dec 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="Zyim+WEM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566112165EE
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734594192; cv=none; b=Ch0cSyWw5FyfcNgFVKb3JzWhY2tc2b4BVLcVNfdS8DyODk2RTbzsnuOOn5p27eCbEWSx7kSQvBPT1xIdhIlHg03S5HdaR9flHWjxPgtT9fxqbeQfLxGMDoBF4vlvQjB0tnKt2NVWdJvd0zC30VWHn8Q7b2EoixuT37H3xtziuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734594192; c=relaxed/simple;
	bh=VacssBPVArSm6k/3qDdJeMgOVxZskDxHg9GeKEaHoMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D70tZao07/8PaPba2sHCCZ5Zf3eMApt+h4sLrJ/v51rJIOC5AXYLQz2+cM5tZGKtFkbiIjVO8bSVaZNstL9d75QD5ebUO8ipLTyYLD8nDFN6Kbz6qRyO9eQ4uZ9XBEavzYzYEB7vC+YfShsR+Xv+ZavRBzNjsub58BwEPKa37Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=Zyim+WEM; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ab29214f45so1539545ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 23:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1734594190; x=1735198990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OBSLf6ezAUOBKlVMuu5hWXIY5CF9SG01M/FkrWs7IM=;
        b=Zyim+WEMchFZGGrpuToBRvAytqNVClL3yfQTYorWO4lzImaVWSi+8UPvCCiGmbAPyf
         G16lhJJwX69bv2Tusc72pZy6CesbIHzKU8R018QIvK3fGQhKscDkUHSTBApR6qzAoW1v
         FyWqyAAyufgIbouyh5li6QqWXULL8HB4xegx8rsFlgq3MkBHBPpAH+nrQzCYHble5U+C
         e/6TEqwu5Iz2iTeOaKSI/rdsBTSD9rFjL0ZBz5zTlCGHxakOwShPfwikE+RTwa5GAebT
         xidQqdGQ/r6PFBeAOW0z/s02HZt8KmXEuv4rVcmGcjjBlFgEvR985uAaab27I335ZxQd
         Y8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734594190; x=1735198990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OBSLf6ezAUOBKlVMuu5hWXIY5CF9SG01M/FkrWs7IM=;
        b=QYXo05Gk1h92h+cfD11B2WS9E+mABByBjZnUpDjLauIpM1tACp5CgyR+wjoDLlGNLI
         uXNarXk4Ps5VE7VA80PJP6+CzcoQjI8vw3OPkdg/UPmNPH+WQuXKdFPZ80VzyW99ZJYJ
         eXcNNC6ObyK7VGuwWXs7NMjZAtwWaW81/7OiptYjpG+UpMKdNITJN8cRfZlqbkEVt8p5
         W82vhIhsBtx1zYF9skLr/QSFzNGxPyFpMwW1pVYRcHooWaBkp97Z6kabDKGqlGzI3HQK
         kxcOYUTzMvUh1+zqZ0/WujRKfVkgZLY8w4arS1ICepaKoUiO4GLUaVvJ2uP66cmH9ZGX
         oKHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn/s7kY3Egs6ETHUz8CEEoqzu5GFsb2NkEqiltpzEHJiEBRMcf0DbyorbAk3+VfuRR1EZhs7iytwwwBY36gRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSwiOAKabDxfpnXd0knNRAB7xwb3nKVIAw4KR7Ul7Q0nRcjdw+
	MXFcO5dJ2cl0MlGQrfyX5fdHrE7+zaLxJbbEZc1gWMetyUcqR62UW1hAP8AiM4pk37r22YOV7TL
	YTYfvdB9Bpl6XFqRbn9Ti/PO2GObKl7GCI+0QGg==
X-Gm-Gg: ASbGncufEJxDboVr1KLz63U10NHlrkoSvBtnqPUrsuxWDIiG0tfNCriGrmUaQZyvZH9
	KqCXbdHxfDjFaqKImsu2IzrF2F616pQJrXmZ3Sz2N
X-Google-Smtp-Source: AGHT+IEYkbHFgP7rWEbUL4gJw6AmdAq+2B/xjkc5BL4zM4osboITpF6FofLzy/cYgFT9HyU3ZxpxXw1GxTtEEJ9scZ0=
X-Received: by 2002:a05:6e02:160a:b0:3a7:e86a:e80f with SMTP id
 e9e14a558f8ab-3bdc003ea26mr62053815ab.3.1734594190381; Wed, 18 Dec 2024
 23:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619153913.867263-1-cleger@rivosinc.com> <20240619153913.867263-6-cleger@rivosinc.com>
In-Reply-To: <20240619153913.867263-6-cleger@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 19 Dec 2024 13:12:58 +0530
X-Gm-Features: AbW1kvZ_WXwEDbsqmAKgoCiT1ZSWNjyowoJciFKcgfWXJoYFYtMyuYjF6-4g-mE
Message-ID: <CAAhSdy3gYPa82zj+fAXtkDvJuKXoWBNj5Mx+XjHXkn=a2c__ig@mail.gmail.com>
Subject: Re: [PATCH 5/5] KVM: riscv: selftests: Add Zaamo/Zalrsc extensions to
 get-reg-list test
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 9:11=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> The KVM RISC-V allows Zaamo/Zalrsc extensions for Guest/VM so add these
> extensions to get-reg-list test.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 1a5637a6ea1e..70216a1760c3 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -48,7 +48,9 @@ bool filter_reg(__u64 reg)
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SVINVAL:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SVNAPOT:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_SVPBMT:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZAAMO:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZACAS:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZALRSC:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZBA:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZBB:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZBC:
> @@ -420,7 +422,9 @@ static const char *isa_ext_single_id_to_str(__u64 reg=
_off)
>                 KVM_ISA_EXT_ARR(SVINVAL),
>                 KVM_ISA_EXT_ARR(SVNAPOT),
>                 KVM_ISA_EXT_ARR(SVPBMT),
> +               KVM_ISA_EXT_ARR(ZAAMO),
>                 KVM_ISA_EXT_ARR(ZACAS),
> +               KVM_ISA_EXT_ARR(ZALRSC),
>                 KVM_ISA_EXT_ARR(ZBA),
>                 KVM_ISA_EXT_ARR(ZBB),
>                 KVM_ISA_EXT_ARR(ZBC),
> @@ -950,7 +954,9 @@ KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
>  KVM_ISA_EXT_SIMPLE_CONFIG(svpbmt, SVPBMT);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zaamo, ZAAMO);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zacas, ZACAS);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zalrsc, ZALRSC);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zba, ZBA);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbb, ZBB);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbc, ZBC);
> @@ -1012,7 +1018,9 @@ struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_svinval,
>         &config_svnapot,
>         &config_svpbmt,
> +       &config_zaamo,
>         &config_zacas,
> +       &config_zalrsc,
>         &config_zba,
>         &config_zbb,
>         &config_zbc,
> --
> 2.45.2
>

