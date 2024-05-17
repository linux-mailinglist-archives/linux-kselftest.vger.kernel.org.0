Return-Path: <linux-kselftest+bounces-10363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 476F48C8931
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 17:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09C81F278E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6F612DD83;
	Fri, 17 May 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="KfJGnobH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7B12D743
	for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959115; cv=none; b=nvP4jSh+KW6hVmk1DgHmzFdIkHdFr37ekmsqnez1X2XJlGZAQoE+o+IzZvh7FAB3RtSX86Vp6w2YKWWby09nUse1dgSUUCHPCB+1FzFfuq1nhsYYc4uihmXfApvGIExyml7GRUoIaeYFTfFyRSVadVYJrkvsVD1ZhUeGvle8Ua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959115; c=relaxed/simple;
	bh=mpYs6UtAF6g4uCYv3WzchVCd0TLckL19zbzZwRq8vNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvJNb6J81ixMrZ/iEZgOtsaWCzdPs5vaPPFoJxMEzTX+rCkJLILDj7K/WjOCOaF37QWi4rc3sNOXUclYHXaBvTwbJ3cD+DmYRD6ZjasdpdIeO0ze91EEV7pmZOLMInFfuQcRJbCOAhzCBgffavrWMCItaFdKrLHktnrIsUdnQLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=KfJGnobH; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36c703d13e6so3207075ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1715959113; x=1716563913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1m4CFwHLpmZnHQVhxg9Ce7GcAxeNjySCi2dNUZGyOug=;
        b=KfJGnobHwephIp5j76CaJ6cQEdiFRclnJJFhgSdFrZDnoVbnjVQmTe7GgN4IFd0Vxo
         lRqMhihiV02kjtcq8ckGlqzQzP/tZb/yWZ8/UUFq7C1DeQ/nEaGpTl4AVGj0adpm6Em5
         ane58fcXjmjMA2+ZwErmpxVWb4YXra4kX+WsFzouLI7BL+MzTsHIuf41YEbGlHzureB7
         KAhqJ9EP5bAqa9z2MK0WAmjweThigKfD5Gqw3n/t0lEvKyXOPwGQUboUasRG9oVFzFuG
         8UL+vnwa08Isf7iVVSSkygwU//mAq8b81pc3dc/c/sr9Jd7pBvC+/53Uz5tN3mmcwk/R
         wnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715959113; x=1716563913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1m4CFwHLpmZnHQVhxg9Ce7GcAxeNjySCi2dNUZGyOug=;
        b=JTikmO0LlQogwBxvGs/DhmZRg0WoEZ/DJYEB3WfOiwaGMxU2oatQUzhO6mmBbT8KLN
         TcOoW7ErOFl8EQvi1Ur216ZceTN6KgrjQCA9WSAv9NglSMQN7l1ZV3kYK0aqbXZ4lnI2
         V+/1rwkFse/bI3Ml5htqiXPZDbjC5MC/FAh7JyUaqJg3RfBAFzesv0N6bNbOlK6TDz1L
         0TZNbM2hNv4tbRTY2FcWJ1D7/A6ouc/vhqGfOa6pQG6hiaT6erGoJDPf/koGZNGm04OH
         XQbgSoAEa/k1f7qDYWIW1EF3KGTMJR9X0dVEQytidZiT5rXwXRpOC1QraQoTReoj3l6q
         7rIg==
X-Forwarded-Encrypted: i=1; AJvYcCVKT1GJ+RPPy1RGCGod1awga/SW6BBL0buOVpo1zUST0y5by3vc83oeCmbCTlKW32xhxh1r1Y1Y0wl5UsMCnleiaCSvmHiopJQ1FwdQcAYS
X-Gm-Message-State: AOJu0YzWmmbt0VEkQn3DaNC2WWoArt6RoJbIVZjWCg/njTHl4Kyzm4l4
	JRJ3zKeSe1Ck3/abcKg+5Anw59fqYuxMKekPRKwTqGraEfvPijttMAHTrRaFDoWKImu7B/KJTQj
	GZ5gQH8vDl3YPXl5AOa3WiDTXGtFhDbzlk7GSxA==
X-Google-Smtp-Source: AGHT+IGJK8XCJzTVXEsiGdlO5wjVs7wX6BOSuvwLSEKG+jooZHMnH9FoE3Bzx4WPWeKRmsJRiTZQBEo5qN0POnnENhQ=
X-Received: by 2002:a05:6e02:16cf:b0:36d:b398:aa92 with SMTP id
 e9e14a558f8ab-36db398ac57mr108119485ab.8.1715959113504; Fri, 17 May 2024
 08:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517145302.971019-1-cleger@rivosinc.com> <20240517145302.971019-6-cleger@rivosinc.com>
In-Reply-To: <20240517145302.971019-6-cleger@rivosinc.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 17 May 2024 20:48:21 +0530
Message-ID: <CAAhSdy0XADKcLS_iFdTzpYDY+KAL2+v91xFcjWUu8LofknQWMA@mail.gmail.com>
Subject: Re: [PATCH v5 05/16] KVM: riscv: selftests: Add Zimop extension to
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

On Fri, May 17, 2024 at 8:23=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> The KVM RISC-V allows Zimop extension for Guest/VM so add this
> extension to get-reg-list test.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index b882b7b9b785..40107bb61975 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -67,6 +67,7 @@ bool filter_reg(__u64 reg)
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZIHINTNTL:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZIHINTPAUSE:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZIHPM:
> +       case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZIMOP:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZKND:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZKNE:
>         case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV=
_ISA_EXT_ZKNH:
> @@ -432,6 +433,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg=
_off)
>                 KVM_ISA_EXT_ARR(ZIHINTNTL),
>                 KVM_ISA_EXT_ARR(ZIHINTPAUSE),
>                 KVM_ISA_EXT_ARR(ZIHPM),
> +               KVM_ISA_EXT_ARR(ZIMOP),
>                 KVM_ISA_EXT_ARR(ZKND),
>                 KVM_ISA_EXT_ARR(ZKNE),
>                 KVM_ISA_EXT_ARR(ZKNH),
> @@ -955,6 +957,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zifencei, ZIFENCEI);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zihintntl, ZIHINTNTL);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zihintpause, ZIHINTPAUSE);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zihpm, ZIHPM);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zimop, ZIMOP);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zknd, ZKND);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zkne, ZKNE);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zknh, ZKNH);
> @@ -1010,6 +1013,7 @@ struct vcpu_reg_list *vcpu_configs[] =3D {
>         &config_zihintntl,
>         &config_zihintpause,
>         &config_zihpm,
> +       &config_zimop,
>         &config_zknd,
>         &config_zkne,
>         &config_zknh,
> --
> 2.43.0
>

