Return-Path: <linux-kselftest+bounces-6263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79787989A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 17:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BE9B237A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 16:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161C7D3F8;
	Tue, 12 Mar 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQZF+FKV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF637A733;
	Tue, 12 Mar 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259916; cv=none; b=eInpm4tDVgOHP66sP3aTVBJg6RwNiKwwiq73lRLThnUFKZuhw5tAkasGPcLpNYHzyu+8fteOI54uGvtfs7V3Fr6/L18bFXLCOeVqm5ujSdNNML6iqcDA2u/yYgNQwpxXFXhafwAoAlOE2kR0zfB+yFrZW675i9i6UjWwOWtzPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259916; c=relaxed/simple;
	bh=pK5/KZXV6dGLZcSbEQLvyxdyemAdcpgwpgjSR+FzciQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9cJOC/ut3JGPGi0vjF6lJd2GPsmbv9vKQog2VFLsJJDxnjT7lrjkjyADjSGMIpXgwE4QkOecMYrT0h4YuA2YiuUupycb/RSoKvoth3H40wTECYEwxO9jPSPPZRKQ7KL/44EbrJN0JNweqWUnq43kJ3fd3Hyf2mgHw3VdLE3Y5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQZF+FKV; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e99b639e0so1410165f8f.0;
        Tue, 12 Mar 2024 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710259913; x=1710864713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlMGohocih4/vv8NN3ExYyD4aDTNUoH7ERTwZOWg+9o=;
        b=aQZF+FKVulDD0cD6twny7vFQuct4bMGN7AEwkOwIR3HS+hs4inJmjoZg5bzKqLbGHp
         0kuOsotVuQtutGuq4sR7//h5NP2HJw+Zam6DgZpluUiOH9d+KUgrQImpOMfo9TStuCF9
         PFUP70DjifLJStO30F0BeNoJxjHfbd4/6Hq32nfz+8RRj5ix1+1zjuFrqio9hh11ApV+
         tc2iHR2fiicsH8ls8POlBJb9PiVDPiF4lcVtqF/II6kFahdp3Qd8n7K36FZU38lU4LFY
         4DxapN8kj9fn9Krh8JvFXoaHQak4wVIxd3hf+gaa6cc/zfzHSuXZoGx/EA/dltX0DpK2
         mLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259913; x=1710864713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlMGohocih4/vv8NN3ExYyD4aDTNUoH7ERTwZOWg+9o=;
        b=EJnhgzG+e2kx5raLIy1y7mWK5x855plVwFeTwqE8q/Qj7ueLFHBk5XPQriZSiFbylA
         jX1sFx0ww94nWrVJj5VLyyWTjNt39sHTNnKRRQ1QYvzacOmAvLoOUniVEUe8U0iXXH38
         Ol1tnt9XpJSAdeJpfcS3cR3+t163bwJHOV+yDLjcVFdlsxEJ4gw4hgeLYUke5PMEPPXO
         1TcgZRf3e3tFx+YWodFJsW2oNOR3Ge3m+XzvNZMSgLk6dv7ONiSswWdXWYNS7YZXTPnq
         ncwW8h1Z+pIQFtouenLiqVh17DLlVnMMErk+QjKzPEQ7dK0nqP7r+ghLbtI+ky9Y+spE
         M86Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPKXvDBXb3yAv7Tj4DYSdnjYksswD+BXRS7tNZb198Ky5/cbuSaNSfrS+3BP+YHc8bHzHjQaMRMvKVxCpWYgFVLnUvTyQ9NQbhpvZJla/H1Qo0x0Jy/x8pa1C9izyiTGDJYvcW2FC40puqPPauHlRshTtQsYpqImrEJxXUeA2bgIpoOk1WmfwM501N+oJVReIEuxamNLGy2nrY5aJPKSGLMlu6RK8ziJcay5WX3M29F7spwRiGS4IS6UTr0yqs9qgL17uoOufB6HnZ1bXJf6j5jxWlkRCQKPsE3A==
X-Gm-Message-State: AOJu0YwR0ICy4wGJrRYu9dNdob3cmLuuh+oIGyQm4I001mDVoINHS45Y
	54cMSmOfG9eje96VI/1IVz66AmhkCKXOjRATUcXuFh+sxKTeaefaffAE4FvsAn2v7Mh4z+4dnQs
	7BdIMpK19V4A9MCsYg+DBQ4CHmnM=
X-Google-Smtp-Source: AGHT+IEluJaPH2ZbEhOuqEk+ZR7WjEJU3XS86GzKec4PZE8B7+fsWbUJbxd+Mrhd/TndoYPK/al8v9EOlZQdZgQXq3Y=
X-Received: by 2002:adf:f60a:0:b0:33c:e396:b035 with SMTP id
 t10-20020adff60a000000b0033ce396b035mr458814wrp.69.1710259912730; Tue, 12 Mar
 2024 09:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-9-dongmenglong.8@bytedance.com> <CAADnVQK+s3XgSYhpSdh7_9Qhq4DimmSO-D9d5+EsSZQMX4TxxA@mail.gmail.com>
 <CALz3k9hZxsbUGoe5JoWpMEV0URykRwiKWLKZNj4nhvnXg3V=Zg@mail.gmail.com>
In-Reply-To: <CALz3k9hZxsbUGoe5JoWpMEV0URykRwiKWLKZNj4nhvnXg3V=Zg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Mar 2024 09:11:41 -0700
Message-ID: <CAADnVQJ87Ov6ny2hj-0_WymGB3TeuEZu373EmqmRJqZv-8Ze_Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 8/9] libbpf: add support for
 the multi-link of tracing
To: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 7:44=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dongme=
nglong.8@bytedance.com> wrote:
>
> On Tue, Mar 12, 2024 at 9:56=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Mar 11, 2024 at 2:35=E2=80=AFAM Menglong Dong
> > <dongmenglong.8@bytedance.com> wrote:
> > >
> > >
> > > -               err =3D libbpf_find_attach_btf_id(prog, attach_name, =
&btf_obj_fd, &btf_type_id);
> > > +               name_end =3D strchr(attach_name, ',');
> > > +               /* for multi-link tracing, use the first target symbo=
l during
> > > +                * loading.
> > > +                */
> > > +               if ((def & SEC_ATTACH_BTF_MULTI) && name_end) {
> > > +                       int len =3D name_end - attach_name + 1;
> > > +                       char *first_tgt;
> > > +
> > > +                       first_tgt =3D malloc(len);
> > > +                       if (!first_tgt)
> > > +                               return -ENOMEM;
> > > +                       strncpy(first_tgt, attach_name, len);
> > > +                       first_tgt[len - 1] =3D '\0';
> > > +                       err =3D libbpf_find_attach_btf_id(prog, first=
_tgt, &btf_obj_fd,
> > > +                                                       &btf_type_id)=
;
> > > +                       free(first_tgt);
> > > +               } else {
> > > +                       err =3D libbpf_find_attach_btf_id(prog, attac=
h_name, &btf_obj_fd,
> > > +                                                       &btf_type_id)=
;
> > > +               }
> >
> > Pls use glob_match the way [ku]probe multi are doing
> > instead of exact match.
>
> Hello,
>
> I'm a little suspecting the effect of glob_match. I seldom found
> the use case that the kernel functions which we want to trace
> have the same naming pattern. And the exact match seems more
> useful.
>
> Can we use both exact and glob match here?

exact is a subset of glob_match.
Pls follow the pattern that[ku]probe multi established
in terms of user interface expectations.

