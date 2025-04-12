Return-Path: <linux-kselftest+bounces-30630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F0DA86989
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 02:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86719C046F
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 00:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757B328FF;
	Sat, 12 Apr 2025 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTAFEmLC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58CA2D;
	Sat, 12 Apr 2025 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744416569; cv=none; b=UlQJGkB3tTBS7XbE1drG47fZWb3Qgbcq4UcqQZMZDnOjQRCkayxuWvUaooLlxpIcl4f54xdJQGbowbYGp4QlzbPgoiGvFpfjvdi2dO9rZ/mGzsrDrALfhy8x1DdL5S1dCq3n3jZur0tDJCZWocETT1YWm2B4a8cqIZkFYWLql+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744416569; c=relaxed/simple;
	bh=slG7ZFqjM0P/YPzxS6s5ruPPxuA1SgdXhHRCsMqCfpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvMoMHFUOlr1WK8jxO4lKYKVK91ePy7lvHO8a5xdrC8u68bEB7OliWQnYmbMcAg6BLSWiFEnZ+1deWymuSDT1zZ4u5lSWcLhY1nr/hjefOsi33gw/QNxEhFOCL2t/cGfeiPDb1TppButZ4DV7kmRt8HTGBZM6JWgGDVZypASTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTAFEmLC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfe574976so18309675e9.1;
        Fri, 11 Apr 2025 17:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744416566; x=1745021366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2GCjRQaYLHuBl+cFkX5JcBxBsl6uDH5BuvGq8wYLRI=;
        b=NTAFEmLCnUfrvK/ay/owjgcD5zlWR5tEsYN0yELdrRkihk6wvIW2i5BMlgZpcGFk3M
         t2qQUiAc+eQrr2ZFSGTFHLNKVY+Y7otrX0vUR4UYJSRfHn08lU2CyDKNW98migx9pj1e
         lAW003+6zbIRAaYEdUJJrTBGuegga7x7yLbxopUYX3QLl4on7P3iU6sHZxNIJ+Mgg+KP
         jfGOoTAQboACpzgz7WzH8/yTMofIVofrne0uukvqqCT0DK/3q65JRWxDfxbe9hkMXuIw
         315xQyVU3APdlmBSbMqKrtnPf9MB+QEpMj9x3RIbRX9rew6wC+P7XVxtc9iptKkNUKOm
         ZIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744416566; x=1745021366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2GCjRQaYLHuBl+cFkX5JcBxBsl6uDH5BuvGq8wYLRI=;
        b=EOWegHs5mokxmSIZfgRO7kHKynvrOb8fQLYLiH7fceWzFYswsBd5lVpaYTrO4se2Ag
         q3vGquiRA1HxoISphMNro4Vh4ykH3SwCZ9l1p2/gGjNziZjmFfMHn5vMxE1fntEAIBP0
         +psB3pbxQINNFYoMp1SeRGpswsJV3p3jDxGbi5ThSKBAbJvdHTkmBBFfaPAO/7DdjOJV
         IaR1Q93fdXui6OG/z74WsiL2xYNaxb/ZBJ0ZssoR9M05u8vO9oNqKpTa/4V0B9am1Luy
         BDewbO6qM2eKwJuDSMXDno/gxkdfZ6oKXpW+30lAQjPa8aSXcUELyOixfMD1eum9HHd/
         1U1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUL04/Ah7ct/ZCX258GTplrpbRqfqDwm5kgyy7MMjIcj3kiprjGibSLAyG6YI4ENZ3n4IzeC6pKNXbi2OuQ4M4Pkba2/r1i@vger.kernel.org, AJvYcCV/LSkZjS14CCNCsfGq7i9OCL8ZWwcBj2K5eoVLNdqKeJKK9LT32UQzBCNvdq4nHgLwZBdtZ8kOaA/JyuhL@vger.kernel.org, AJvYcCVxDNtVlpPsU/+J7MHk745qi9qV+Xdo3Uub0F1DaaVYN3Dqwlc5JUD0HFxVhmqTh3U/WXH2sOi2004Div01@vger.kernel.org, AJvYcCWkp6lSJyJC0jRRyuU0WVaMSAtu+H+zV5nPE2t2TNprFpuApLaiQpdugZvTgAfaEnqSZw0=@vger.kernel.org, AJvYcCX0PPrUPpgDxadL1Ru9xTt+YVLKeml9Ef9Vef/cC1Hu0hxg1rWb1mZVgkRpDC5ghR4eUKi17eMfmQEY22JfCXJF@vger.kernel.org, AJvYcCXJ/fAE1nc5ekHXXccxzUdchk2UHhN8SVfkktZrpAR/ShYSH9w0VNYqpJbZOMLqe6CTumfiZKVgd08=@vger.kernel.org, AJvYcCXPBmcmkqy7XRjwpW94NVDX+9O0MIOEdmDq41+PB9W/GUaDvqMmSQQjVK1uyJE3YfbfhnDW0mOHd1tuAFAF@vger.kernel.org, AJvYcCXZKk5Nl/uhEB9YCORPWEY0Uy640emCbmkyJzcuFCTG/EuJKKuZd5WUJRc0QjpbTYc4oeYmthvvf86Q@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv572RGHKcoRvXkmx8z5S1eFS/8VuAiHgSJMuf1wfXzGG6tV+r
	bmmkr2iUdySlKVw7XIR+eMQ6kTUc5TGtT4wf8gAV5CdiU/6wRxTbfaBmxpa63i+VEXJh7g33QQX
	oGV2CceHnbnYrmiPDRXNvA4Xdjn0=
X-Gm-Gg: ASbGncsz3v+9459BJIWXHYHlKDMT2Ry5UCexSVOePJxbwt+dTxOHVqaExaaS7Zhg6Bb
	MbMNgBPPJEwDKCZ0LgH/rt4NzeIodTIXHyp30hXw1pc/6a1Oih5rL+EYU7QsBzGM+Vbsw9Frv6n
	ysW+1sCRrWAyD54VGajJYNwTdtq6zQRZoM75zeag==
X-Google-Smtp-Source: AGHT+IER5g1V+SGACXD789HoA96PF5Q+6oEkXwJNtoTADXBrV4pog5v9nyOvdiwVLDKGrhB5NiVs+frZTCfJMF//ErQ=
X-Received: by 2002:a05:600c:1e1c:b0:43c:f8fc:f687 with SMTP id
 5b1f17b1804b1-43f3a9adc61mr49442465e9.27.1744416565507; Fri, 11 Apr 2025
 17:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com> <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250404215527.1563146-2-bboscaccy@linux.microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Apr 2025 17:09:14 -0700
X-Gm-Features: ATxdqUGoWOEoj9dKHnOcyxWEmhHLYFaTJ3UVlV4EkUb8mJP4lqeOyUKxu-D0tAo
Message-ID: <CAADnVQJyNRZVLPj_nzegCyo+BzM1-whbnajotCXu+GW+5-=P6w@mail.gmail.com>
Subject: Re: [PATCH v2 security-next 1/4] security: Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 2:56=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> +
> +static int hornet_find_maps(struct bpf_prog *prog, struct hornet_maps *m=
aps)
> +{
> +       struct bpf_insn *insn =3D prog->insnsi;
> +       int insn_cnt =3D prog->len;
> +       int i;
> +       int err;
> +
> +       for (i =3D 0; i < insn_cnt; i++, insn++) {
> +               if (insn[0].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
> +                       switch (insn[0].src_reg) {
> +                       case BPF_PSEUDO_MAP_IDX_VALUE:
> +                       case BPF_PSEUDO_MAP_IDX:
> +                               err =3D add_used_map(maps, insn[0].imm);
> +                               if (err < 0)
> +                                       return err;
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +               }
> +       }

...

> +               if (!map->frozen) {
> +                       attr.map_fd =3D fd;
> +                       err =3D kern_sys_bpf(BPF_MAP_FREEZE, &attr, sizeo=
f(attr));

Sorry for the delay. Still swamped after conferences and the merge window.

Above are serious layering violations.
LSMs should not be looking that deep into bpf instructions.
Calling into sys_bpf from LSM is plain nack.

The verification of module signatures is a job of the module loading proces=
s.
The same thing should be done by the bpf system.
The signature needs to be passed into sys_bpf syscall
as a part of BPF_PROG_LOAD command.
It probably should be two new fields in union bpf_attr
(signature and length),
and the whole thing should be processed as part of the loading
with human readable error reported back through the verifier log
in case of signature mismatch, etc.

What LSM can do in addition is to say that if the signature is not
specified in the prog_load command then deny such request outright.
bpf syscall itself will deny program loading if signature is incorrect.

