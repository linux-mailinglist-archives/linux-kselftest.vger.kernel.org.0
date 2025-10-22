Return-Path: <linux-kselftest+bounces-43798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 001E8BFE149
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 21:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B11184E69E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D532F5473;
	Wed, 22 Oct 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbM8fVV1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA822FE0A
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162411; cv=none; b=mGjefH0Ox0ixUzrIteDHUYMtRs0ZX+HKmlC6M/FnUlnONtxrEu+tZONKMOSk1My8aQf+It3cxzsNMlFgYIJdFvkG044k/NP7J5P1bHw701IbSp0zvpfZbozNYeMTwOiAp4QjJ52oogfd+Ntq2Nv6KCRg4YP7YgvVZ0ZrQ55LPaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162411; c=relaxed/simple;
	bh=S/hh9/DeowLYEhJeBCNJoewLIAtZFWUGUe4gp+FIQNQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/qbHeXYeLdrrrwfExjStj7z/3XgsWMAHl8DAqm6jJeTQGQ8Ad7uvp4sFBEfqu9APAunqkxqGJS9yUxlaY6zEZAq6V0p9paIoOrPtKMd/2Q238N1mWAVbUIewTWfRUkiWgpYHq2aqr7pL3ilAT7wki6jnrmoPjxHB71fAEwu11E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbM8fVV1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso24644b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761162408; x=1761767208; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EWn78QyuKi/0YAncXLY/1r1sZ48dyDwTSq2IyjTdbM4=;
        b=IbM8fVV1zuPqLXj4M1QiSk1ZDYtworO0iJ5/1xagQXq6xDPvb0Wus8fxudHszkJDY6
         gM9LBYBaav+FTqvowQsX14r7mrSFMXoAhCZDC+ZdK6f7qcKYN5TEMlJKLsXwE6JC3ySx
         1ZUnmuytvEDZw7X3p4RbszLAXTcOgYXM7WXnSOTA0PuKs8jLyAuWAHcnEapEUf/aCCPp
         1W//b/8fE+FoFBMpcGOri3RBvIXHEk3x60453n8IoMh3tU+Y+lnJBrVBrD0CFGoODy35
         zaZZGPZWNQABhKMAkGcN93yY08l30MFr1sxWhs8Q7XHP4b7bRvTJMKQTGR73eI8LtnhI
         wf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761162408; x=1761767208;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWn78QyuKi/0YAncXLY/1r1sZ48dyDwTSq2IyjTdbM4=;
        b=BAh4nyWA5dNwucq4iuZbQIaufkgVQkKXeEE4RJcbzGHK6VGnvh+SYmaDncqqS1znPI
         ADQbSZ6YKLkdsNzrtda6Ou18ZTz3RvxF38T9NQruIzqG0HJB9YfoQWtG3Y26uXMway3n
         2sLsorO9Cz6Xjxj67DTDVcdVjmPyrAYxOlxvI19Cgk18RAUCIY8/s+H0M/+sEgZzGSfB
         uj6sZFCejFCFJqQNWiVNVR0dy3bU385PINDWbbS58PUYAt9M40KwWIrsWRNu+coNhJWV
         +EoWadKtKx5sPx+JO3hUlDGqQy+fYPvnu0dhqNyAEloEoZ+RczTAWCDgI/cyth3SxuDK
         FHWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNxYVor3MVZrVWXuH9Vq6KMZQRFWR3uuRX7u3IDRC658+XGNqe6lnJvJgGtXkutxUQs/C//qktzudCvlvcPIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9de/OlGKI8KzHmQ6clD+j5TcCJv9u8yS69Me1r64X2VeT6+nu
	+A0HYj1Na5I71vuWLgHD7Y1u4Oyrli2eoFjSPLe0RaEyttpWVX6GvakV
X-Gm-Gg: ASbGnctH+CK1z0RClBLGzO3OSU7p14pev+uxGBbXg/b08Oiw+pWtmq1vVKB9NSfqGWK
	d7u7plJ0bh0r4cl3x5k1TdyeFYxYHEgiRiiIQ9vUA2YZJwlvac2qrH4Vh25q4sq6Oex6R4xk6OV
	JmQnf2bAq5NwJhjdDWX9pGVhApDa69FmkHeKULVur0Rx9kgIhhDcIZV3alH5ANBHoKdeQosHRwi
	oho3YRmEWg7U9hJ4ep55fE3k/0OkjI9fJDi3lQuD8gtswzIrATVFUjjiZ3LnUHeT0PNCyS4Qig+
	qSnQJYlelW6pXDtvv2VJ7pFDR4+3GlA5auDyrsH7973ZD2FF7PV+OY5CATE8bcromY5h0Nl7mnH
	1MEVAHffFpbDVqjQ6Wium7aOiMv7PMhsLDnl8TIIHNAcR75iXOfE5HZnjXFfQ41k+OU1KChqakI
	e+VVA6qUZnss06oJkxctFWa/6V
X-Google-Smtp-Source: AGHT+IHymbTcbH235aXvQeVtJWuH5sno4WRQtI5oIYoYQBt9QK1TA5w0gykjqr/O4pXkL3QYwNj9hA==
X-Received: by 2002:a05:6a20:939d:b0:250:1407:50a1 with SMTP id adf61e73a8af0-334a85763b5mr27844617637.24.1761162407500;
        Wed, 22 Oct 2025 12:46:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fa8d:1a05:3c71:d71? ([2620:10d:c090:500::7:b877])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b5a007sm13513736a12.31.2025.10.22.12.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:46:47 -0700 (PDT)
Message-ID: <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, KaFai Wan
 <kafai.wan@linux.dev>, 	ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, 	martin.lau@linux.dev,
 song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me, 	haoluo@google.com,
 jolsa@kernel.org, shuah@kernel.org, paul.chaignon@gmail.com, 
	m.shachnai@gmail.com, luis.gerhorst@fau.de, colin.i.king@gmail.com, 
	harishankar.vishwanathan@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>
Date: Wed, 22 Oct 2025 12:46:45 -0700
In-Reply-To: <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
	 <20251022164457.1203756-2-kafai.wan@linux.dev>
	 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 11:14 -0700, Yonghong Song wrote:
>=20
> On 10/22/25 9:44 AM, KaFai Wan wrote:
> > When conditional jumps are performed on the same register (e.g., r0 <=
=3D r0,
> > r0 > r0, r0 < r0) where the register holds a scalar with range, the ver=
ifier
> > incorrectly attempts to adjust the register's min/max bounds. This lead=
s to
> > invalid range bounds and triggers a BUG warning:
> >=20
> > verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds violat=
ion u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x0] s32=3D[0x1, 0x0] var=
_off=3D(0x0, 0x0)
> > WARNING: CPU: 0 PID: 93 at kernel/bpf/verifier.c:2731 reg_bounds_sanity=
_check+0x163/0x220
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 93 Comm: repro-x-3 Tainted: G        W           6.1=
8.0-rc1-ge7586577b75f-dirty #218 PREEMPT(full)
> > Tainted: [W]=3DWARN
> > Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-=
debian-1.16.3-2 04/01/2014
> > RIP: 0010:reg_bounds_sanity_check+0x163/0x220
> > Call Trace:
> >   <TASK>
> >   reg_set_min_max.part.0+0x1b1/0x360
> >   check_cond_jmp_op+0x1195/0x1a60
> >   do_check_common+0x33ac/0x33c0
> >   ...
> >=20
> > The issue occurs in reg_set_min_max() function where bounds adjustment =
logic
> > is applied even when both registers being compared are the same. Compar=
ing a
> > register with itself should not change its bounds since the comparison =
result
> > is always known (e.g., r0 =3D=3D r0 is always true, r0 < r0 is always f=
alse).
> >=20
> > Fix this by adding an early return in reg_set_min_max() when false_reg1=
 and
> > false_reg2 point to the same register, skipping the unnecessary bounds
> > adjustment that leads to the verifier bug.
> >=20
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail=
.kaiyanm@hust.edu.cn/
> > Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > ---
> >   kernel/bpf/verifier.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6d175849e57a..420ad512d1af 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16429,6 +16429,10 @@ static int reg_set_min_max(struct bpf_verifier=
_env *env,
> >   	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCAL=
AR_VALUE)
> >   		return 0;
> >  =20
> > +	/* If conditional jumps on the same register, skip the adjustment */
> > +	if (false_reg1 =3D=3D false_reg2)
> > +		return 0;
>=20
> Your change looks good. But this is a special case and it should not
> happen for any compiler generated code. So could you investigate
> why regs_refine_cond_op() does not work? Since false_reg1 and false_reg2
> is the same, so register refinement should keep the same. Probably
> some minor change in regs_refine_cond_op(...) should work?
>=20
> > +
> >   	/* fallthrough (FALSE) branch */
> >   	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_j=
mp32);
> >   	reg_bounds_sync(false_reg1);

I think regs_refine_cond_op() is not written in a way to handle same
registers passed as reg1 and reg2. E.g. in this particular case the
condition is reformulated as "r0 < r0", and then the following branch
is taken:

   static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_r=
eg_state *reg2,
                                 u8 opcode, bool is_jmp32)
   {
 	...
         case BPF_JLT: // condition is rephrased as r0 < r0
                 if (is_jmp32) {
                         ...
                 } else {
                         reg1->umax_value =3D min(reg1->umax_value, reg2->u=
max_value - 1);
                         reg2->umin_value =3D max(reg1->umin_value + 1, reg=
2->umin_value);
                 }
                 break;
 	...
   }

Note that intent is to adjust umax of the LHS (reg1) register and umin
of the RHS (reg2) register. But here it ends up adjusting the same register=
.

(a) before refinement: u64=3D[0x0, 0x80000000] s64=3D[0x0, 0x80000000] u32=
=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
(b) after  refinement: u64=3D[0x1, 0x7fffffff] s64=3D[0x0, 0x80000000] u32=
=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
(c) after  sync      : u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x0] s=
32=3D[0x1, 0x0]

At (b) the u64 range translated to s32 is > 0, while s32 range is <=3D 0,
hence the invariant violation.

I think it's better to move the reg1 =3D=3D reg2 check inside
regs_refine_cond_op(), or to handle this case in is_branch_taken().

