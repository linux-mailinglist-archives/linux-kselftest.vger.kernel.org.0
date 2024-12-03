Return-Path: <linux-kselftest+bounces-22733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22E99E1BF9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 13:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C63EB3CC94
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D901E3DE7;
	Tue,  3 Dec 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHI3kOxC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3561E3772;
	Tue,  3 Dec 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225711; cv=none; b=B2S2yAL2s/h+aUZUKIOY7mDlL4ea0JKc5qtASePqELwrkNy8BzJzJZcreMNY9jg0pCwlccleAahvjUtmAZevfDkWkNE4UKoGd75H/OY+IAg1Ky2f/nqz5HTyqkYB4gQ+PTfxPgOxvJjj/xl6XKgn0VKfJUjSTpYBDbJWazVabwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225711; c=relaxed/simple;
	bh=3MWjk85NmWlbYMWabiD2fBNYO8K3kUK/Onp9ETA+5Y4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IcHBbB0rq4Q3MNAW869ly13Bap1GzXoQ69zBOrQdv5vqGLKGIfveqVqMVTW00us4u0thtyg6xyDgZBoDNFXHQ2wa4AOFruDbLOUe8nrS7cQfbN3dEsLXEEDMZxgH9+4vfbk3S7nqPS0cmfHiwQlcriNGMVLWs0NTEIhLIsHK3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHI3kOxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC7EC4CECF;
	Tue,  3 Dec 2024 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733225710;
	bh=3MWjk85NmWlbYMWabiD2fBNYO8K3kUK/Onp9ETA+5Y4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hHI3kOxCigtxutre/XbKF8THCbBA15kF2UzeEXnrSamiyaEFqVM4H3c+96TIZ2v3I
	 HpVLl0bl7MdznOYha2Hc7OVvTbjLuiVZMzAqTxx+ERgiEdIkVs/pCTEQkvtMRCQyLe
	 H0mf7yKzj8unWbqRt7i0h7nFlGz4JXTX754TN7l4wpS8dqXRMW9jffGxoM5SjQRdh6
	 Zv01tQD3eXXzbR8kSvH8wD+zrSXGo5LIQHFCi4NwGDjs8BFDAK66oRovKf3ry8z2bo
	 zpV+LoHnrso1bIivSeWZJBBQIdTGVKZrArvCYv36KO5jZfoKUYZRjAIY42MCc40VXh
	 wUqFRvWrHkh1w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Celeste Liu <uwu@coelacanthus.name>, Oleg Nesterov <oleg@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Eric Biederman
 <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
 Andrea Bolognani <abologna@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, Charlie Jenkins
 <charlie@rivosinc.com>, Quan Zhou <zhouquan@iscas.ac.cn>, Felix Yan
 <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, Shiqi Zhang
 <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, Yao Zi
 <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Celeste Liu <uwu@coelacanthus.name>
Subject: Re: [PATCH v2 1/2] riscv/ptrace: add new regset to access original
 a0 register
In-Reply-To: <20241203-riscv-new-regset-v2-1-d37da8c0cba6@coelacanthus.name>
References: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
 <20241203-riscv-new-regset-v2-1-d37da8c0cba6@coelacanthus.name>
Date: Tue, 03 Dec 2024 12:35:07 +0100
Message-ID: <87ed2pdmok.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Celeste Liu <uwu@coelacanthus.name> writes:

> The orig_a0 is missing in struct user_regs_struct of riscv, and there is
> no way to add it without breaking UAPI. (See Link tag below)
>
> Like NT_ARM_SYSTEM_CALL do, we add a new regset name NT_RISCV_ORIG_A0 to
> access original a0 register from userspace via ptrace API.
>
> Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gm=
ail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> ---
>  arch/riscv/kernel/ptrace.c | 32 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/elf.h   |  1 +
>  2 files changed, 33 insertions(+)
>
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index ea67e9fb7a583683b922fe2c017ea61f3bc848db..18ce07ffb27bb1180667769ee=
d800f6fdf96c083 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -31,6 +31,7 @@ enum riscv_regset {
>  #ifdef CONFIG_RISCV_ISA_SUPM
>  	REGSET_TAGGED_ADDR_CTRL,
>  #endif
> +	REGSET_ORIG_A0,
>  };
>=20=20
>  static int riscv_gpr_get(struct task_struct *target,
> @@ -184,6 +185,29 @@ static int tagged_addr_ctrl_set(struct task_struct *=
target,
>  }
>  #endif
>=20=20
> +static int riscv_orig_a0_get(struct task_struct *target,
> +			     const struct user_regset *regset,
> +			     struct membuf to)
> +{
> +	return membuf_store(&to, task_pt_regs(target)->orig_a0);
> +}
> +
> +static int riscv_orig_a0_set(struct task_struct *target,
> +			     const struct user_regset *regset,
> +			     unsigned int pos, unsigned int count,
> +			     const void *kbuf, const void __user *ubuf)
> +{
> +	unsigned long orig_a0 =3D task_pt_regs(target)->orig_a0;
> +	int ret;
> +
> +	ret =3D user_regset_copyin(&pos, &count, &kbuf, &ubuf, &orig_a0, 0, -1);
> +	if (ret)
> +		return ret;
> +
> +	task_pt_regs(target)->orig_a0 =3D orig_a0;
> +	return ret;

Nit: Could be return 0, for readability.

Regardless,
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>


