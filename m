Return-Path: <linux-kselftest+bounces-37078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 273CEB018F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 11:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE5A544FDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 09:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B14027F74E;
	Fri, 11 Jul 2025 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjoUNNwQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4BC27E06D;
	Fri, 11 Jul 2025 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227874; cv=none; b=lYKqFigPwe0DvwZ33yS0DRcrfE1ey1Dzhr66LE8VOOewD7ZmGSHkA9opyj9A4eLCVha53UfRyoQGb9ue4gKx+00VKt58HVcLyswMASIo5OLVoJri0FW6CZJ7zDrDFT3GIuZJ4BT0+c9jZRxpU1JUwl+ZZJThrgU3+bLp2v77Qes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227874; c=relaxed/simple;
	bh=HdPeTB4OpvLmQsZ6TzAhg07c6wp7BnT+ZTIPurOkt7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndkNfoIYbWum6yoCIpLvKlzxHMi5CO0w45f6GMyE3VtpIPU4JAIYGTvcSjOs8M4V2Jtx0rIQV1xjAOi15LsUI9/TC8WYIeaFM73HIAOuxtI66/TEhRlRu5w1oDEdXwUZnWv54xNSNG9tlv6hRiSFWjaHmqgnC91dU36WU6zK1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjoUNNwQ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a8244e897fso22487481cf.1;
        Fri, 11 Jul 2025 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752227872; x=1752832672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF8ni1Qabwm5EDAGgO1yhgcz/0k2BPrIUU0X84lGYks=;
        b=ZjoUNNwQ8CH0rpC/YZbNW3yyu4vhlf7GqVYEJu8IDPUzbZ2i9NM/dbZ0QW0FsI/E/v
         zinTu2MZ8gE/oFYP/Gr4yqZB3g1Lk5NVZ/tTRKA4YQiTPSdl8u8bZDz3YAW964xMqEXo
         AFqlrjGHfRHqENupkikmtoo2h+1q/6CBsCb98Cu6qe9vVIj7YZvJITUT21R5RI1aIDNu
         qolIateIKgntqFWT6Jt7CWURPYWmQ2FX5RQeU9Rv6SaZZgCO+zhkf8nFBLrY+BQd6FTo
         QQhiOg2vtPLmMgZSq9OAgMjIszBEXnfUUD4ndpx9l8Fp9F7pqb7U6E799cZK4DqR7HLi
         AizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227872; x=1752832672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VF8ni1Qabwm5EDAGgO1yhgcz/0k2BPrIUU0X84lGYks=;
        b=fcIAkGFEtuDJMBTTtMJKl9zXqtvQUnwaVfDFjg7gMZFFDK5YgOA3xSkSlH0hiGwWfK
         NukvQFP1RcQcHjc/A3NsbllByxjhtHvJouANfZHJjz8ukusIERkN82950fLtbFsGg2Ed
         n7FETzGTNyf9lvairHJZCfQHZ+Qs5TOdQPwRGtnQ7coRlwY8f9lI2BEJK0+dapsFH5Sa
         dOmkYc0d64h15Ppl93zVbWpn+vQ3b9jsjCzG4vjetCylqw+q7YjvHjz0GHTF8kedRq0S
         XV/iyKqWtPl4pELo+LSFBaFGnWJ1yxZkbO3B6oAdva4mpbf182omb6UAKPZP/FqDA3P3
         FKNg==
X-Forwarded-Encrypted: i=1; AJvYcCV/KS+xv5Ep0gODc2Ydp8nnsUILkCE7Hgc13Cljj0cXiQjrqufTzXH1BPOpYdRG5KRqaaNd593M+F/rM5Os@vger.kernel.org, AJvYcCWvJdx5Qb9ffJfvqJ9Qy7qADoiwb0dFdu3F9qxOpDUYHL/yOCDjFE7ZTyGadp2dwxtjtDo=@vger.kernel.org, AJvYcCXrTmM9zqGsAQgW26xpdhBjSp0AB1ZA6eZkn6sQgRl+YJ7Ru+KuJu6Ekztunlsi+5xBDxVdaGw4Vjr72elyHk0L@vger.kernel.org
X-Gm-Message-State: AOJu0YxSmgRlF8ba3XaNDW393meXaCZRD4qgozziHPY10W9QsDys4peg
	n6t3BTeemwbHjE7TRK7Fy1blrZ1KTMaVBnQiMUpkrgPVsBGnd8fDS8txOJ9UagjKSn/sb7B1OWh
	7Klf+G5mhmAjw9JWc+0ERxMrur4u6sgsAaE2pES4=
X-Gm-Gg: ASbGnct9Vv+Hf0QRERXAXqawsvGY8EylEehbFx36y/QzhvYVBSVmGKIVAd9Qxuiapyx
	c6egz5mzC0MMx0++cRFsOBcHkeKToVecLDzkX9Z5ymjPEEL9OB6HouX/FTt51H9wBBOnu3trE9t
	vwlqJmSb0XuuV9szK9kFHlf8w4e9T9UQx+OTMbqTJ3tHjbZxGYrc17vQOWFYLNASLyWKsLcugSi
	tajzpUBe7REaqrE0gA=
X-Google-Smtp-Source: AGHT+IH2wevNPn/JSNpdOUj2BnaPxCEVoejrICXAJ8339nj2oPdHOpHANciP7L0NDRoLJ6wm47aLfIeGcevWFljogDA=
X-Received: by 2002:a05:6214:800f:b0:704:a91e:2874 with SMTP id
 6a1803df08f44-704a91e29c9mr12943876d6.19.1752227871571; Fri, 11 Jul 2025
 02:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710162717.3808020-1-mannkafai@gmail.com> <20250710162717.3808020-3-mannkafai@gmail.com>
 <CAADnVQ+Ca43c757zaT80B+4RJesRozx39mLoz3hOdKXEaXLBLg@mail.gmail.com>
In-Reply-To: <CAADnVQ+Ca43c757zaT80B+4RJesRozx39mLoz3hOdKXEaXLBLg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 11 Jul 2025 17:57:14 +0800
X-Gm-Features: Ac12FXz_Z6qpVB3NlzPlv-24hnyKeoodjUEF0Pr8v9RgB_Gm4IUoL8gkZwgsyz4
Message-ID: <CALOAHbCMCnYe=d04Ong5GzdMjK553CooF5XrBi0kQUwoh0oDrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Show precise rejected function when
 attaching to __btf_id functions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: KaFai Wan <mannkafai@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:19=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 10, 2025 at 9:27=E2=80=AFAM KaFai Wan <mannkafai@gmail.com> w=
rote:
> >
> > Show the precise rejected function name when attaching tracing to
> > __btf_id functions.
> >
> > $ ./fentry
> > libbpf: prog 'migrate_disable': BPF program load failed: -EINVAL
> > libbpf: prog 'migrate_disable': -- BEGIN PROG LOAD LOG --
> > Attaching tracing to __btf_id function 'migrate_disable' is rejected.
> >
> > Signed-off-by: KaFai Wan <mannkafai@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 275d82fb1a1a..2779d63e1f8b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23938,6 +23938,8 @@ static int check_attach_btf_id(struct bpf_verif=
ier_env *env)
> >                         return ret;
> >         } else if (prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> >                    btf_id_set_contains(&btf_id_deny, btf_id)) {
> > +               verbose(env, "Attaching tracing to __btf_id function '%=
s' is rejected.\n",
> > +                       tgt_info.tgt_name);
>
> "Attaching tracing to __btf_id" ?! What does it mean?

The term "tracing" refers to BPF_PROG_TYPE_TRACING. I believe it is
useful because it helps identify which functions cannot be attached by
a given BPF program type.
Perhaps we should replace "tracing" with "a tracing prog" for clarity?

> Drop "__btf_id" and "tracing" bits.

--=20
Regards
Yafang

