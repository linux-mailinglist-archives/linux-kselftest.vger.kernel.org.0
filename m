Return-Path: <linux-kselftest+bounces-9093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F01CD8B6567
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 00:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161331C217CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 22:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBA19069B;
	Mon, 29 Apr 2024 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWCVms9M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F1B177992;
	Mon, 29 Apr 2024 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429109; cv=none; b=IWb92Bg3N8jO9TYcdYOAIffiI1XROjKczPlh2NGDXUoMxwZ2QWdyMIgy8w8uPvbsyd4v6tU39F3sOcI9kSmL8ztwMOOyXRAQBJGitr4acNDQ4UBskVkPfCQp+hzzwOa0C1CUCJg8c9WL9scUpU9+a/00kMSbHJVdNyoS61nVkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429109; c=relaxed/simple;
	bh=5FQU/EVBfp8zquoet4tZvLNoTnExuvFfr0UFGN2zj48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZUmsSEzOwL2HCC7khYytlm51dT0XtYb3QlY0Cjv2vVfp3BWVzJBh76iun3nriUgUzcQJYKLDKI8LjgkwltPm2Y/y5tjpM1I+FOg8x7rLP1b08Ic/tfzqsPjYyPVZBj/B5Ot0txbfk+OKOTyS3ZKRNL+L3JcpBO7FA9OlKhTB4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWCVms9M; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so4289520b3a.3;
        Mon, 29 Apr 2024 15:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714429107; x=1715033907; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cr2+1Q7+k8stldRGJ4hycgrJdY6zIBRip1L2M8qYXwY=;
        b=OWCVms9MIpsvaFyP0PdePw6QJOIzGvc0uyLOvGdqYs9gnSUuXvDhbX81RFlrx9LRqY
         Zab2301H03sb3DSCSW5H9UfnbYresdMFmuhOGk7VmuZt3RrbKc3bOBthZq/PUM+76f3P
         5pE6l5Ae8F4wkBrwcq2F1VRN2TjOJ0Bgh5cJMKH5mEZZ9MLrbTZUH7qAen3wekUkwc1P
         t4LnyqrH7I71oCvLJM5IhXjfp7QpHfaOCMwrYIJxZ+avHkPW/KD0l73VBiNeJOvaIXdX
         C7oPp6k+Igj3eNn3jP5lct0ugk6ATIQqTVOoYskEUT3o7fGicKM4fEQtIKQmP/QP681J
         iYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714429107; x=1715033907;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cr2+1Q7+k8stldRGJ4hycgrJdY6zIBRip1L2M8qYXwY=;
        b=Zf4++BWxf+T/y2nQ1tXiWc7Vb1WkS6A2E/1mkrweLxX4ZCjKraK8B0qpP1hLXvQzi+
         IuREJDcVLWRuElHBCwNIOK/oGQJInJhDdEvnOzXUHAOEi8lwvaKe8N+cDHBZUQxAn2JT
         bd//+D9oTxVokUPXqEusW1oTIuq81kfLBQzbkun8u+sWA2FWFCWXkQZVOtSpll3GG6ID
         xC8Se2dHrV6gzO7Ek/kLTEjguCrxpe2HvFXOFLZnmINByt8ADz/5/yQU38xhTS8/7tHv
         n6c1EWDwAUO0nSgNKDijLFx61qfuRzWd1CJvxCKBnQ3LxIL6ZVqwqlIKRn/g8bzsnSdk
         cDHg==
X-Forwarded-Encrypted: i=1; AJvYcCWNGfrB06PVQtIVaGSHOh7BSJxYusHArsLCEUQLcFdGlCfyXgwm5IjlTS5nXgz4Nmzl64hCxO/vDBO0unlOl6A/gntAJ4AmbsxA+z9e2KtVKPYciEJBZ1GV/t/lAYax0gs/mCqtoozasgpbaK5QdQhWXjQVXoEB/DB1nzcdB5JOBgt3vHWNVmBBAPwVF8AeTMxvgmKpA5na/zLDqsqRTK+hJA0E
X-Gm-Message-State: AOJu0YxxMvMwknqWxniMCTRsO38AXi4UvrNs0oXcWdrMqa9NYVofzZDV
	rVN0RSyr5o/6qtTerZ0XEZQZpf3ddxr6ThA566/afI8stmD5yhUT
X-Google-Smtp-Source: AGHT+IHvde4/0TGU/WUi9Kdh6ZHDst/sN3GUbM0YW3YIX7JtqLVGN2Xr200x9TnGFz8idAwJn1lntQ==
X-Received: by 2002:a05:6a00:1901:b0:6ea:bdbc:614 with SMTP id y1-20020a056a00190100b006eabdbc0614mr12833423pfi.13.1714429107532;
        Mon, 29 Apr 2024 15:18:27 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:a18e:a67:fdb6:1a18? ([2604:3d08:9880:5900:a18e:a67:fdb6:1a18])
        by smtp.gmail.com with ESMTPSA id z8-20020a056a00240800b006ecf6417a9bsm19724998pfh.29.2024.04.29.15.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:18:26 -0700 (PDT)
Message-ID: <7cf8b58011156af99816391d3afd5c52e48ea8b7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 07/11] bpf: Fix a false rejection caused by
 AND operation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Xu Kuohai
	 <xukuohai@huaweicloud.com>, Edward Cree <ecree.xilinx@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Matt Bobrowski
 <mattbobrowski@google.com>, Brendan Jackman <jackmanb@chromium.org>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek
 <omosnace@redhat.com>, Kees Cook <keescook@chromium.org>, John Johansen
 <john.johansen@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, Shung-Hsi Yu
 <shung-hsi.yu@suse.com>
Date: Mon, 29 Apr 2024 15:18:25 -0700
In-Reply-To: <CAEf4BzZb38EemdD8ahX4Px3vWCp=ani6vcX71Z-1_MLeATNjwQ@mail.gmail.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
	 <20240411122752.2873562-8-xukuohai@huaweicloud.com>
	 <e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com>
	 <f80991aa-3a49-451a-9a82-ac57982dcb28@huaweicloud.com>
	 <bdc84c6c-7415-4b84-a883-1988cb5f77d1@linux.dev>
	 <576c7c44-d1b4-42c8-8b6e-2e6b93d7547a@huaweicloud.com>
	 <CAEf4BzZTzftrOCFsfBd81sHDBpmNK+4Jefqa3SSS6NiuncO0tQ@mail.gmail.com>
	 <4fbce978-9687-48a9-be2a-1c4d76790f7d@huaweicloud.com>
	 <CAEf4BzZb38EemdD8ahX4Px3vWCp=ani6vcX71Z-1_MLeATNjwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-29 at 13:58 -0700, Andrii Nakryiko wrote:

[...]

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8f0f2e21699e..b69c89bc5cfc 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13478,6 +13478,28 @@ static void scalar32_min_max_and(struct bpf_re=
g_state *dst_reg,
> >                  return;
> >          }
> >=20
> > +       /* Special case: dst_reg is in range [-1, 0] */
> > +       if (dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_value =
=3D=3D 0) {
> > +               var32_off =3D tnum_union(src_reg->var_off, tnum_const(0=
));
> > +               dst_reg->var_off =3D tnum_with_subreg(dst_reg->var_off,=
 var32_off);
> > +               dst_reg->u32_min_value =3D var32_off.value;
> > +               dst_reg->u32_max_value =3D min(dst_reg->u32_max_value, =
umax_val);
>=20
> can you explain the logic behing u32 min/max updates, especially that
> we use completely different values for min/max and it's not clear why
> u32_min <=3D u32_max invariant will always hold. Same below

I agree with Andrii here.
It appears that dst_reg.{min,max} fields should be set as
{min(src.min, 0), max(src.max, 0)} for both signed and unsigned cases.
Wdyt?

>=20
> > +               dst_reg->s32_min_value =3D min_t(s32, src_reg->s32_min_=
value, 0);
> > +               dst_reg->s32_max_value =3D max_t(s32, src_reg->s32_max_=
value, 0);
> > +               return;
> > +       }
> > +
> > +       /* Special case: src_reg is in range [-1, 0] */
> > +       if (src_reg->s32_min_value =3D=3D -1 && src_reg->s32_max_value =
=3D=3D 0) {
> > +               var32_off =3D tnum_union(dst_reg->var_off, tnum_const(0=
));
> > +               dst_reg->var_off =3D tnum_with_subreg(dst_reg->var_off,=
 var32_off);
> > +               dst_reg->u32_min_value =3D var32_off.value;
> > +               dst_reg->u32_max_value =3D min(dst_reg->u32_max_value, =
umax_val);
> > +               dst_reg->s32_min_value =3D min_t(s32, dst_reg->s32_min_=
value, 0);
> > +               dst_reg->s32_max_value =3D max_t(s32, dst_reg->s32_max_=
value, 0);
> > +               return;
> > +       }
> > +
> >          /* We get our minimum from the var_off, since that's inherentl=
y
> >           * bitwise.  Our maximum is the minimum of the operands' maxim=
a.
> >           */

[...]

