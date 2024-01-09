Return-Path: <linux-kselftest+bounces-2776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE1829102
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 00:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3021C250F3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 23:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE9A3E480;
	Tue,  9 Jan 2024 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd1NsK0K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F91364B5;
	Tue,  9 Jan 2024 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55719cdc0e1so4002584a12.1;
        Tue, 09 Jan 2024 15:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704844299; x=1705449099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt9b2XHBtKSzu7V5D9PWo+9Hr9WnYT/2ETEwyufFis0=;
        b=Xd1NsK0KmZB9aqpFdcVpidyS2b2Ux1zIwOeaB2Wh4QUbRSiz+01z84XcFnHbDIz1sb
         2DLiAHhFryW9aqdwutF41BklSbscKL/LYFQBEWieFyj66H6bnFA/Rc2QWfkGW29ejUlb
         lmBefKZBxNcoFwGlJVM1rVi8B3yvCig4EDEXNabP24laHTVl401xhZi0aBgzz3z5XT5c
         GZUwctM88WtAhCnsSSdmfj288oC7DJtDh/Af5L2v6ir+hxVtEkQrH3SPbVxo/e6kSbNF
         TxaKZ1Ok3tDHUP++OCMJmo+Ku/cY0s2dT2MCE61sr7SK1Jqsd7nwZoIogmoPc7IkZbQv
         m4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704844299; x=1705449099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt9b2XHBtKSzu7V5D9PWo+9Hr9WnYT/2ETEwyufFis0=;
        b=Fe0CMw61NcJHAG6mWWgn0O28JtYx5tMvhKsR8CEiZiZ1//y0evx4WLAbwoPT9WPnLf
         k0nPRxBw2UFUC9olNXrKHsSyTrqjpkcK/dRMArKk32bcgDUFz6sE+r5QKbUOaS44ZJMd
         i3F78l3pRKq5lKSlRp4gOb7Y520eO/1lHD/5fQvZDnwCioIi+gSrk3GOo+PhDcdPeW20
         SCBue2ax0HPC1woMqNHZO2hXZx83rGNoVLUk1KSO3Hi7dJuDbtV895QFq98KBFkst9Dk
         ml4pzvPhqv6bK0AniLYZhe1coycD0EwMvO+kC5ONG18xSugYX08Sj5Iwa1k16Tu5HI1C
         w1mg==
X-Gm-Message-State: AOJu0Yy7BWJs8f98qDqK2Q8czqUnhQAI3lPoRi4GpCCkCAUMuS3bML5R
	1rGCRE8c3lKcIW8jLnK5pOEKA+k9blX7hChBhfE=
X-Google-Smtp-Source: AGHT+IEDBqwqtOIgFzpACFpa+mEDRSeUYcka1/XE8tMhf3xhp5/VPJ9gTdrqi3C6sBGwFrcOwysitmsovdaLXXmKNxs=
X-Received: by 2002:a17:907:ca5:b0:a28:5815:cbb3 with SMTP id
 gi37-20020a1709070ca500b00a285815cbb3mr92003ejc.56.1704844298811; Tue, 09 Jan
 2024 15:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108205209.838365-1-maxtram95@gmail.com> <20240108205209.838365-13-maxtram95@gmail.com>
In-Reply-To: <20240108205209.838365-13-maxtram95@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 15:51:26 -0800
Message-ID: <CAEf4BzaNUfO-EBiJPtOKpBFay2gqr=nzT0Aipe274MG+m2Jvrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 12/15] bpf: Preserve boundaries and track
 scalars on narrowing fill
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 12:53=E2=80=AFPM Maxim Mikityanskiy <maxtram95@gmail=
.com> wrote:
>
> From: Maxim Mikityanskiy <maxim@isovalent.com>
>
> When the width of a fill is smaller than the width of the preceding
> spill, the information about scalar boundaries can still be preserved,
> as long as it's coerced to the right width (done by coerce_reg_to_size).
> Even further, if the actual value fits into the fill width, the ID can
> be preserved as well for further tracking of equal scalars.
>
> Implement the above improvements, which makes narrowing fills behave the
> same as narrowing spills and MOVs between registers.
>
> Two tests are adjusted to accommodate for endianness differences and to
> take into account that it's now allowed to do a narrowing fill from the
> least significant bits.
>
> reg_bounds_sync is added to coerce_reg_to_size to correctly adjust
> umin/umax boundaries after the var_off truncation, for example, a 64-bit
> value 0xXXXXXXXX00000000, when read as a 32-bit, gets umin =3D 0, umax =
=3D
> 0xFFFFFFFF, var_off =3D (0x0; 0xffffffff00000000), which needs to be
> synced down to umax =3D 0, otherwise reg_bounds_sanity_check doesn't pass=
.
>
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> ---
>  include/linux/bpf_verifier.h                  |  2 --
>  include/linux/filter.h                        | 12 ++++++++
>  kernel/bpf/verifier.c                         | 15 +++++++---
>  .../selftests/bpf/progs/verifier_spill_fill.c | 28 +++++++++++++------
>  4 files changed, 42 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index e11baecbde68..95ea7657f07e 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -239,8 +239,6 @@ enum bpf_stack_slot_type {
>         STACK_ITER,
>  };
>
> -#define BPF_REG_SIZE 8 /* size of eBPF register in bytes */
> -
>  #define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
>                           (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
>                           (1 << BPF_REG_5))
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 68fb6c8142fe..be784be7ed4e 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -39,6 +39,8 @@ struct sock_reuseport;
>  struct ctl_table;
>  struct ctl_table_header;
>
> +#define BPF_REG_SIZE 8 /* size of eBPF register in bytes */
> +
>  /* ArgX, context and stack frame pointer register positions. Note,
>   * Arg1, Arg2, Arg3, etc are used as argument mappings of function
>   * calls in BPF_CALL instruction.
> @@ -881,6 +883,16 @@ bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 =
size_default)
>
>  #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]=
))
>
> +static inline bool
> +bpf_stack_narrow_access_ok(int off, int size, int spill_size)

this is used by verifier.c, right? So why not add this to bpf_verifier.h?


nit: given we have spill_size, should we s/size/fill_size/ for symmetry?

> +{
> +#ifdef __BIG_ENDIAN
> +       off -=3D spill_size - size;
> +#endif
> +
> +       return !(off % BPF_REG_SIZE);
> +}
> +
>  static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
>  {
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON

[...]

