Return-Path: <linux-kselftest+bounces-44854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E365C38610
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 00:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E764834E0B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BF2F3C21;
	Wed,  5 Nov 2025 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd3MaR6M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B92D0631
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385622; cv=none; b=exXwRmiOiYOUUAZkM/eIk5PYRwC8uXZdkTTrtLkE1xcslBVKdd++sf62mNrVAzJ4+Prii+NvY/waDP3uNiPChMdJflEfr2/URbRMWKbjvbPL4qKXAtuu2sJlZB5bcWjo/BlslKVQGlxjYVnk8N3zJCqfgTXeI/fYHl8PDmX9Eh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385622; c=relaxed/simple;
	bh=RoHqgdm7fFl5Yh0xwlNj+CL9/T7cunCVRJpIqPbD+E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImHIacm1nPHj5Qq7xl3AZqMQ1XbvS2P5Qm4fxISjtjgUrZHkteS3GiviDUvoYqHfZovWm77K4DrCoJIAloC7HxYM7FKe1M4i/HW/69mrsNfC6T923Gk0eFbiTnmey+P/mLuR1WfvSEGmvErYsQTyyeQwm07akLTy5n5R9Cxaa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rd3MaR6M; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso821139f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 15:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385618; x=1762990418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A32nXO43+m2kR+8eaRzNcHIYkEApDPiVW8pHqnBOQt0=;
        b=Rd3MaR6Mbkr6u3FFERkInTigl5NhDD/8zcLQSTTEDG90Uz7a/zhgpMIEDqGFOdL/1w
         429p4UHQCrqmonvW/oJUzb/avDv5Dxl8XibBmrw3YdTphlmYtyzEUY8f7wGYU983aFMQ
         BRg9CbOki3kLWiSDq4cgRVg82BFRb1+2HGtjZTykCtLy6RaTKkZ1DaofgAM7mD8MkJq6
         U+kCDbIfwM4PPEBA2Py6b9Lxuz3ub0x3nmozII/zVxGnpR3dlDmsjnuLFNQDg7oLMGJj
         j7L+BNKXYbqTQk2LEb3QYQQ4lb9WrbNFsSuWjFGB6LbXRQ5KOB4HFHdkzc4SN9zwF3ej
         hUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385618; x=1762990418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A32nXO43+m2kR+8eaRzNcHIYkEApDPiVW8pHqnBOQt0=;
        b=C7J3sUHREjYguBKCz/7IrMnHMfWqXdClJPRmoMYdBhG6SEsvOdidBxo8qSc6G85By+
         6dwiEHbfh39RKUpzN0a/5mJg1YyoVAWdkMASeKUGHfPNhYzGiwWZP8Aw3p/CbNHGRuc2
         cLfeZzR5HWIevYIa/ELpU2OZZbgxcC1D686/8lWXxbusOVXmLsWlun7JWJbGOmvwGFfn
         fA5PhVsg9YcyAv4xXzG/08ayIxIph9jCQUrSo/B2vSq+hUrbQ2WjSmQZHLmf6vyqB+Oi
         9/xQIwvVYz6VTeJzB5yFEmrySx3vZAKouJQigsOrgcvhXa/JTtcvMwrCeg1ANP2KzRD7
         ZBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6kq46i/7QE/zlcLNgPhQjoRu0iHwcP0qmz+8UKs9g11GVZXD2237UOKntgzBdzsX/v4rxMWcmq0BJQfhvR5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsEY09Dmb9Q47NWE/ktl2Ls7mfKFEZSXSDQ32WSFyCpiZPOmQQ
	mNR/5Rxwyj7kaGsQX4aYYDMwPR/iyZt/AHjzw8XektjevopS6SJGD7zL637BGFeTRLMtpnBZtR3
	Bn78fDeOkeiIrA6yjk6yoob6R+rGcouE=
X-Gm-Gg: ASbGncuDKlr0629iGdKz0v2Qb0Od8Yrj3l/PuxfQEuNeSRflyMdywB2HmrK1Abz42GG
	/Y67f91PYMfySrvlfLTzieC5CAgKxo7Q4GNe8Mmfy52/LN2dMqBmWl6NfLfSuYZ+/fjGF0uCPPD
	NsvDgkqkeHOmgVsPClQOgVaWb9QO56ItDhFRuBwVM0nnc9uoyHVfwEdbbISGkHmjJVRiJh/4g3A
	A23DXSDIaUDdwhRtyXkZOygzDriRMadhfWL2YnqxxiRpRJNPPcLvcoVHui6DcwBzIqGs245RVWN
	0hG+O5yukaXFGHJ+eY7+cVicqYUk
X-Google-Smtp-Source: AGHT+IFi15XXG51xVgDDu0e2kdYsdqqcOP+5TL9/eEL9rxbiDzL6XMtse44f+Pr3b/wZshISq8Jg/ZZNqOdRK5iGPdo=
X-Received: by 2002:a05:6000:1849:b0:429:ccd0:d36c with SMTP id
 ffacd0b85a97d-429eb19d72cmr1055962f8f.14.1762385618434; Wed, 05 Nov 2025
 15:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105201415.227144-1-hoyeon.lee@suse.com> <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
 <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
In-Reply-To: <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 15:33:25 -0800
X-Gm-Features: AWmQ_bmfpzydKuHyeC5aqOqiAefI6FMJ9biunpiR2FY5nzyk7MMSFvRPKri5HKg
Message-ID: <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use bpf_strncmp
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hoyeon Lee <hoyeon.lee@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2025-11-05 at 14:45 -0800, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.com=
> wrote:
> > >
> > > The netif_receive_skb BPF program used in snprintf_btf test still use=
s
> > > a custom __strncmp. This is unnecessary as the bpf_strncmp helper is
> > > available and provides the same functionality.
> > >
> > > This commit refactors the test to use the bpf_strncmp helper, removin=
g
> > > the redundant custom implementation.
> > >
> > > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > > ---
> > >  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +------------=
--
> > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/=
tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > index 9e067dcbf607..186b8c82b9e6 100644
> > > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > @@ -31,19 +31,6 @@ struct {
> > >         __type(value, char[STRSIZE]);
> > >  } strdata SEC(".maps");
> > >
> > > -static int __strncmp(const void *m1, const void *m2, size_t len)
> > > -{
> > > -       const unsigned char *s1 =3D m1;
> > > -       const unsigned char *s2 =3D m2;
> > > -       int i, delta =3D 0;
> > > -
> > > -       for (i =3D 0; i < len; i++) {
> > > -               delta =3D s1[i] - s2[i];
> > > -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> > > -                       break;
> > > -       }
> > > -       return delta;
> > > -}
> > >
> > >  #if __has_builtin(__builtin_btf_type_id)
> > >  #define        TEST_BTF(_str, _type, _flags, _expected, ...)        =
           \
> > > @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void *m2=
, size_t len)
> > >                                        &_ptr, sizeof(_ptr), _hflags);=
   \
> > >                 if (ret)                                             =
   \
> > >                         break;                                       =
   \
> > > -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_STRSI=
ZE); \
> > > +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _expecte=
dval); \
> >
> > Though it's equivalent, the point of the test is to be heavy
> > for the verifier with open coded __strncmp().
> >
> > pw-bot: cr
>
> I double checked that before acking, the test was added as a part of [1].
> So it seems to be focused on bpf_snprintf_btf(), not on scalability.
> And it's not that heavy in terms of instructions budget:
>
> File                     Program                  Verdict  Insns  States
> -----------------------  -----------------------  -------  -----  ------
> netif_receive_skb.bpf.o  trace_netif_receive_skb  success  18152     629

Is this before or after?
What is the % decrease in insn_processed?
I'd like to better understand the impact of the change.

