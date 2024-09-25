Return-Path: <linux-kselftest+bounces-18340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6896B985564
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BC4282490
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3808158DDC;
	Wed, 25 Sep 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYb9KAz8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21624130499;
	Wed, 25 Sep 2024 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252656; cv=none; b=MjfdJU2M2ydEH4R+blTMdVve1j6TdNkCHzDIzfp87uiDtQFXxLp4uRy+0Ep1Xs2WWL7ueXlwwtR5cyCuiSVmlGciXkZpSbjPXfmB/Rua69g1vVfSw3HftFwQBxT1SPvixLmipVvEtgSXP7DYQYC9S2YGaCYQLv/wAeEFG1SKa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252656; c=relaxed/simple;
	bh=z0YhgJE8tGOsHV49d9k1PcL2yhU7lZxB7k3+WA5Bpo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCNEFEPtETaWcMDh1DQvjrT986zaejrensUrm+rQvE43FEEa3u4uYx+qNoHvLnVZe0ikBnq1COXFFnHUCAEggwjW/QIShcDRSqTjZxjAj1UaQL7btHwclxM0U+1yG+zywUB1QFfKyJmnZ7uk0DCabgs84HfKz2r2UpG70DSs/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYb9KAz8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374cacf18b1so3791278f8f.2;
        Wed, 25 Sep 2024 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727252653; x=1727857453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2edHstWlsclzGFyhsz5xiTaZ1ZX4wZXAdxPbt18MN0=;
        b=QYb9KAz86aPOk0KFsYMPchvHwqVgVbHqR2blrPF0Po6bng82J7+Qw4KHXGjQLHI2qp
         4S8pVPrjxeVhNEuAH4DcNJz0SSdL1qcO+BSUCAdZo5kxmzYti5iJqo42v4zotU+ySjTK
         05CaJIOO+ISz5jjx7sFi7nZxtd0ZhuX/OpCKyBFvrhYBhbVgEqqJvu3uNQmQehH4xqTC
         Olc9Cmv+Uad1K+ToYpjVPz2/sAwoAlBAv+hvBHu1qyKGuFC0xd9UgJq47zMMEF1DEmTP
         fm0a4cHCAiGfPD6U/lxunfDr6ss4jo/UTNqvfqn0wt5TulaSDMlw9yBVVzVLkAv8HyZr
         Gklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727252653; x=1727857453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2edHstWlsclzGFyhsz5xiTaZ1ZX4wZXAdxPbt18MN0=;
        b=AO29vmNL7A/rc5FFI/hIKbXE0fqklLQV4r58gVV4FFUSdffwC6fP12h8bdcGC27Ca8
         EkejjXGbtXBtQM9xI/oEuX6Usa1YlcD+m8tiONE2BMByR8T1EQkRPgTcMzVM7/KWOC9y
         otzZGZLJVhR9wtTQwIfJDSwXwus7b0KktY0JZCSoWleQVEdL1ZwhEvjHsE8YcmCHVZIm
         DEuKYbig8bUkc+MQCBOsRV1WKIKn4/EV1R8+QOUCeN3DstNnUXCrNAuZ4WrFd/UZck+I
         EJCjc9Sc1njgZ1Of4eaKytncAjYHnyRYAm19ipAErpC/UavN/yXwNiFMjLMKf8pOyPTo
         DwWA==
X-Forwarded-Encrypted: i=1; AJvYcCVKsbbV/Gxn+ECgIMisxQtDgjR25Q9/VUAbytGEy4y0H7zep94Il+5feG5gPXXiM43cm+IGLYLbwUvg+CTb@vger.kernel.org, AJvYcCW+tHvGhBQUTI1PslT5RgxhrMC6HLiwYlSWJAI87qnlxKW1ez/8vfI3ppc6noX+b3XVgkE=@vger.kernel.org, AJvYcCXDeecuXAgvN2oTXNyFca/lJYtx/10InTsHgvaz1bcI1uuwog2Q1/z/gvyBvwB2dXkR1qIljTKKqTj3XlGhNjyA@vger.kernel.org
X-Gm-Message-State: AOJu0YyxP1P7GLZTywTkcmVGld5oh2o+kf9tpL3RqR3RTiBdYZSPm80P
	jgUcUdwm7YhCL+cpQBswwIJ4NN2ZEBbfQ6+wMlWddNf1fRp4OqXW98bqG5MxlDsdIqyqnBkab4n
	hc2Nn1dq8J5qduHQzFPlMN5zsj4E=
X-Google-Smtp-Source: AGHT+IEDxTRbBnGIMHlwmtmEVOiP+3su787rzVqn6SiEoedksyYRYCb1L7LZhgoxFmj4CZxWus/vi/pOmX1wsDm8s+Y=
X-Received: by 2002:adf:dd90:0:b0:374:b6b5:4688 with SMTP id
 ffacd0b85a97d-37cc24c9e96mr1103156f8f.49.1727252653066; Wed, 25 Sep 2024
 01:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727174358.git.dxu@dxuuu.xyz> <815cefa75561c30bec8ca62b9261d4706fa25bb6.1727174358.git.dxu@dxuuu.xyz>
In-Reply-To: <815cefa75561c30bec8ca62b9261d4706fa25bb6.1727174358.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Sep 2024 10:24:01 +0200
Message-ID: <CAADnVQKZ1MkBttCKsOMh7nNXNP4OVxGdYLnJuXjNFLPUv3Bm6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: verifier: Support eliding map lookup nullness
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Shuah Khan <shuah@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Eddy Z <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 12:40=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> +
> +/* Returns constant key value if possible, else -1 */
> +static long get_constant_map_key(struct bpf_verifier_env *env,
> +                                struct bpf_reg_state *key)
> +{
> +       struct bpf_func_state *state =3D func(env, key);
> +       struct bpf_reg_state *reg;
> +       int stack_off;
> +       int slot;
> +       int spi;
> +
> +       if (key->type !=3D PTR_TO_STACK)
> +               return -1;
> +       if (!tnum_is_const(key->var_off))
> +               return -1;
> +
> +       stack_off =3D key->off + key->var_off.value;
> +       slot =3D -stack_off - 1;
> +       if (slot < 0)
> +               /* Stack grew upwards */

The comment is misleading.
The verifier is supposed to catch this.
It's just this helper was called before the stack bounds
were checked?
Maybe the call can be done later?

> +               return -1;
> +       else if (slot >=3D state->allocated_stack)
> +               /* Stack uninitialized */
> +               return -1;
> +
> +       spi =3D slot / BPF_REG_SIZE;
> +       reg =3D &state->stack[spi].spilled_ptr;
> +       if (!tnum_is_const(reg->var_off))
> +               /* Stack value not statically known */
> +               return -1;
> +
> +       return reg->var_off.value;
> +}

Looks like the code is more subtle than it looks.

I think it's better to guard it all with CAP_BPF.

pw-bot: cr

