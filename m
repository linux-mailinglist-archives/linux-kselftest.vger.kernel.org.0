Return-Path: <linux-kselftest+bounces-37094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4213B01B63
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371D31CA2BDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399F828B50A;
	Fri, 11 Jul 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezirXcrw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9827AC43;
	Fri, 11 Jul 2025 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235349; cv=none; b=SW3PE4yW/qQZZWweQKfCeb8Ozl912MCRlx2dx2pRmceB0CRuKFDMyopgmMCknamM2aqhYHHJZMDCRBfzh6XWiaNQhcSUXEuDJpZU7GFzB4Nk5KraE+LXOlaXVaxfLhAvuB/UuuEoSrL0px86krnJbg24mS2fmCJ3qkxNVgg4KV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235349; c=relaxed/simple;
	bh=YzGUBDblhCNeSMFr4wgOeXaK4kq/G4RnWlOaMEMdEXU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XOYG/FB7pcLvHyToVQ4it0JEj4H3W3MbM8wA3ik826i5q8QhyVV9uQyhMrZ28N4l/l6D89Yi4BBbbI66vZsf1P6oc8BjzMXBps1QWdQEWya96Z1HBPy+n2abUm2xpwepuY/YtbG+Bv8c07tXia0kmrm8nA4j1kM0mzPeNqDhJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezirXcrw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7426c44e014so1960112b3a.3;
        Fri, 11 Jul 2025 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752235347; x=1752840147; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YzGUBDblhCNeSMFr4wgOeXaK4kq/G4RnWlOaMEMdEXU=;
        b=ezirXcrwy0SOSJLKlTf+CTLX267/AbhOYwMSIofOecNgikIfYkBbjORosNXLPSy9Cb
         DgUAFsAFH1yc7la6dOMc1na1i3tFmMD1raJziTwQYJTPfo25ZUnDQfQVBOqWIWJhdQhx
         z2xDpu7XsRenJRLeOIehAF9i2w29sOOo2rlklyk8MDDPILNjjxtPu7TXjxJthYLhOONr
         hpLSzlTBgf98vxYfNAAIh0ND953J1IyuT5v1FemQ29lf+uA0UrcVk/FfWcDRTwrD1ues
         g2zYWZk6/hsCbNpg8wvRYXTey7K1/FK1O66cQVR2OfQo0kwla6JKE2BUSKGKACKySmmL
         qC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752235347; x=1752840147;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzGUBDblhCNeSMFr4wgOeXaK4kq/G4RnWlOaMEMdEXU=;
        b=K2tDd8tttI1sy78ne5PS8BNsXIv2O7uMSAsCxdIsiztiolcXmoknJSxyqTjxU5iqZB
         clN508CPE/DR1GbddXC1rEC10OF7FY5OxVpuxwWcQeJlIdcXwdOEFDCxdWfDz1dmvrja
         VxlDDfaVPa16CTk8pTH0S903iOcFM0SZ6V7jnrfliTT+qDEP14ubD1wwyyrvKPyj+0c+
         6UFS1oUEBPRZ5jc35oIzbDQo6UpGmcws0D2FUSAQTiqhNWU0vaO45KNKidYqCSpYi5DM
         t3kFa5bDyRGOR0I03xNqlkO5dF6Z2WB7u03jSc5NMJzA0OaAwDgkqOUT4srjbTuG/mGM
         tKnA==
X-Forwarded-Encrypted: i=1; AJvYcCUXmHwMIvjtdERp2PhmnD5Mv+EM7RM6aRb7JkKEPqCMBOq7MZBHCltjA/O9zynZX/EINLIFF/WH+VFKyHOEFH8R@vger.kernel.org, AJvYcCVKRTMcT1UMxWRMkQPTAJMuffnHfySbFHlAZx25/g+enREUCOu7DhLwwoknFI0z7sfKMFw=@vger.kernel.org, AJvYcCXUlgsdK+Lz/CtTIJR5mF6il89av2CrhLel/JseBbmZIxBUlhuWiBuYaP+9UtCVgksrX0JT6rO+NTjOvaee@vger.kernel.org
X-Gm-Message-State: AOJu0YyIqvtH1bpRjRHpLWKrD/Udz+sf0wQ3rcTh3MKYo4qGf7MxJLIP
	J94mLETsfZXxA0QFyRf9UosNqS3YXEgS8nNF4MKNgJwcbjHWHcFViqke
X-Gm-Gg: ASbGncuRH2DlF1Zm/4GqDxn6pXyM0TZ1hpeaqnbU2otrAjggA0LlgAgTRK0+J9dj5c+
	cLyEnPsoUjLKvFKAGt2A3s7UD1wUS1ApgMx/yTWDVh1JqRxwrMY3U6VvAzk3DSQzhSpvopgkE34
	lefyXtzpvoE2TeLslnroaIkonfbLTgoGJKQ7YYRWgM+cDhDVwx8oiCT2epIYHuzKuewDarTMZjY
	pZkLOo9DcWcKIv4aVp2mF3JVe4DmAvWBSYGuFxEBS56iDEKuZgjYK+BS9VMXU1yB2C5t87liLXx
	ijjzs1OHHFAUhnIWrJ0ZAqBfY1Brv2kOgO1TUumX2RMQEloUTPRwOEJMaDvr28DcuEyNxdwdCrc
	yicGK/4fuy+z+h/U8bUzVeA==
X-Google-Smtp-Source: AGHT+IHNe58Ys1UMnITCoG7gp86G2b2/FSlpZzgnXSypLHA/Edm862V/yzRhw2fvS0mIuhzW0JNKLA==
X-Received: by 2002:a05:6a00:c95:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-74f1efc0e27mr2976860b3a.23.1752235346465;
        Fri, 11 Jul 2025 05:02:26 -0700 (PDT)
Received: from [127.0.0.1] ([62.192.175.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f8cd75sm4954105b3a.164.2025.07.11.05.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 05:02:26 -0700 (PDT)
Message-ID: <10c6fff555875e23453b5e524ad27839805e51f2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Show precise rejected function when
 attaching to __btf_id functions
From: KaFai Wan <mannkafai@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,  Shuah Khan
 <shuah@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>,  bpf <bpf@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Date: Fri, 11 Jul 2025 20:02:17 +0800
In-Reply-To: <CAADnVQ+Ca43c757zaT80B+4RJesRozx39mLoz3hOdKXEaXLBLg@mail.gmail.com>
References: <20250710162717.3808020-1-mannkafai@gmail.com>
	 <20250710162717.3808020-3-mannkafai@gmail.com>
	 <CAADnVQ+Ca43c757zaT80B+4RJesRozx39mLoz3hOdKXEaXLBLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-10 at 10:19 -0700, Alexei Starovoitov wrote:
> On Thu, Jul 10, 2025 at 9:27=E2=80=AFAM KaFai Wan <mannkafai@gmail.com>
> wrote:
> >=20
> > Show the precise rejected function name when attaching tracing to
> > __btf_id functions.
> >=20
> > $ ./fentry
> > libbpf: prog 'migrate_disable': BPF program load failed: -EINVAL
> > libbpf: prog 'migrate_disable': -- BEGIN PROG LOAD LOG --
> > Attaching tracing to __btf_id function 'migrate_disable' is
> > rejected.
> >=20
> > Signed-off-by: KaFai Wan <mannkafai@gmail.com>
> > ---
> > =C2=A0kernel/bpf/verifier.c | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 275d82fb1a1a..2779d63e1f8b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23938,6 +23938,8 @@ static int check_attach_btf_id(struct
> > bpf_verifier_env *env)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n ret;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (prog->type =3D=3D=
 BPF_PROG_TYPE_TRACING &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btf_id_set_contains(&btf_id_deny, b=
tf_id)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 verbose(env, "Attaching tracing to __btf_id
> > function '%s' is rejected.\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tgt_info.tg=
t_name);
>=20
> "Attaching tracing to __btf_id" ?! What does it mean?
> Drop "__btf_id" and "tracing" bits.
>=20

My fault, I mean=C2=A0"Attaching tracing programs to function" in
'btf_id_deny'.

I will change it in v2.

> --
> pw-bot: cr

--=20
Thanks,
KaFai

