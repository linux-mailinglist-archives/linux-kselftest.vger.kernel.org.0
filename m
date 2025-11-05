Return-Path: <linux-kselftest+bounces-44855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF81EC3861C
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 00:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8433B2C92
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 23:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD2B2F5316;
	Wed,  5 Nov 2025 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts7QTdIw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC172E54B2
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385883; cv=none; b=PSH+nIoBIU8VxxE2ZypXuf97ifRDafJwz4UgfO7PiZ3n2r/GbzEM6Vo6UomKMZ8tQ41Yyz698N6NGUmG6nJ5/haBVtr7lncxM9zvtohKV4X6vVflu1dJxmPKIai5carik0MtCpEBljm0rdpdKww5gJ59hqtdy7qYm7IsYJpOd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385883; c=relaxed/simple;
	bh=gddbQ+Itd7Ojfjtk5FdtrnY3uKmgUByG80qPQ8ZvjtI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Be32l/MHahZr90sePsnLBwrCMDWa1swg8pYlLhPbuy30Dbnu8lPwl0S3XvL/1WcnshCqJ7url4FQcaYfLgti/hgoWZXdPNnezDVrovw1HMSfD6G/nB2cLYqzYrSLXo6+0BZ+ZK2Z6eW5Uj+j6D4O++TZC/jRa3u9XjHrkLWWtOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts7QTdIw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7810289cd4bso378848b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 15:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762385882; x=1762990682; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9fVUkHQDwvPqUlHZQUDqXxahAxilIHdqJl6WVxMgWaU=;
        b=Ts7QTdIwxedzHjNtuBEutS8NMj3e0wM2n0iSMtVTksR7dN8sm42V1tkG3/v2KLJyYw
         Tv7oxmQ2DcPmWlre6lHfEA1bmsqf32R1mNM8jJ1DCblQnadH69dU5CJXXqrC+BJJq2Gc
         MZO3EAnDBap2597JRSgnA5rPEP/dRuAr0wrtt+JZWQ56d6fGHly5vDBVl7ORGyG0vLVP
         Quer3xi+3JB8s/qdnVnhJuoqC/HMuQ0qtmJif7ZuceC1mVJUTzaq3WHopKgAi63KQczw
         esegAGBRH22BWfY8t53ll8SAj/QXqhMrAapzaVH7WZQqi5Mlihb+n4tMVQaauiEeLz0J
         jrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762385882; x=1762990682;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fVUkHQDwvPqUlHZQUDqXxahAxilIHdqJl6WVxMgWaU=;
        b=Mj2odoqqbCdM07mUtWqqrhuaCZbVvENePKYCQYo0NANntJJqJPWzUipopEzVqXvJ9h
         HmFGd25c9IsBD2bX3QRas5s0RWgN8PejIIAMsdkq83XB1hkv2UlYVC8C42zGQuUEhsmA
         YLr3RauAasCw+2TqM5h39HMQKCfOKDqlP8hJi5Ybu1x/67/aVBOAZR7JaISn0f7sfTms
         HcKdRn79C0f4SPj58vuJ8gTWZ6g6F+B1H8NJWLoBOb+1qLzGrj8NCcqRnzdQki4ddP07
         WxaVHAeXR2oY1z0/8Ocpvh14HiVe8rjuSt8LiIW60hP0EA4nR4Wt07aoJ6WTgSL+HTDu
         AtIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeVW72WhgEWuHgPz+2C06o/QAKHHa/yr9YFxYDQDoIRCIrS1n0CMN6kRtR1i3AMO07GVA1HFI20675hHKHuLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHX8es8oQVfu4pI5FT5Nw0lAefR9dB1lAn4/0DOIWCNlIxL+4k
	Zs70rl/DZRgogvRfnC/lh9aKiCEL8MOj8hOZGpX0ma+1tlshWt1ZgsO5
X-Gm-Gg: ASbGncu4p01h1Ixsl7qB+ljQKm92g3LaechQAksb6gRfDgq4CE/xytS7hsHnBU6fAu+
	zJYPHamIpDI0qI+fCkfuDM8Qwdke60m/fsDQD0HvfUHsmTDliH0XAbYFmL7IYho10H8yIhXsMew
	hnfSEyjdOuzAlVaN3MT6Lxz7Obt6pSbmag6oinJyY8osJd7Hko2xTizcP3sQM6njvJOh3rpHruZ
	Qitbn02TaHv0BlZbyD+hC9yoKeYrtNNJA1gEz6ljweUWQHdf6/JGBDkPm8CxyQd6bZY6hEfG6/z
	hMFRxiNUR2FZhrPlqr98R38KYwcnhGydWR5Ybex8CNAhzo+ORnhTRtjxleyNpDd2sr3CI6gftch
	eQGiMBWnFKDajBMGkpwKflbB/wmJlovvUrmN/+/gZxL4B17Aaqc+ZnkTPsi/qZjftwiMFDnM75o
	cOdSIiJspgSWklWjxOF/cFq1Nh
X-Google-Smtp-Source: AGHT+IF5T6+DOCSnDpoLDg2pzh3olheTdfkjvm41AL9sLBEpMp4B3RXVO38qeeSA3u2FwUTtP18r/A==
X-Received: by 2002:a05:6a20:12c3:b0:331:e662:c97e with SMTP id adf61e73a8af0-34f85511aabmr6954608637.37.1762385881643;
        Wed, 05 Nov 2025 15:38:01 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ad143sm4020376a91.3.2025.11.05.15.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:38:01 -0800 (PST)
Message-ID: <8541c5bb758bc06e8c865aaa4f95456ac3238321.camel@gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use
 bpf_strncmp
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hoyeon Lee <hoyeon.lee@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK"	 <linux-kselftest@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Date: Wed, 05 Nov 2025 15:37:59 -0800
In-Reply-To: <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com>
References: <20251105201415.227144-1-hoyeon.lee@suse.com>
	 <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
	 <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
	 <CAADnVQJVYDbOCuJnf9jZWdFya7-PfFfPv2=d2M=75aA+VGGayg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 15:33 -0800, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Wed, 2025-11-05 at 14:45 -0800, Alexei Starovoitov wrote:
> > > On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.c=
om> wrote:
> > > >=20
> > > > The netif_receive_skb BPF program used in snprintf_btf test still u=
ses
> > > > a custom __strncmp. This is unnecessary as the bpf_strncmp helper i=
s
> > > > available and provides the same functionality.
> > > >=20
> > > > This commit refactors the test to use the bpf_strncmp helper, remov=
ing
> > > > the redundant custom implementation.
> > > >=20
> > > > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > > > ---
> > > >  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +----------=
----
> > > >  1 file changed, 1 insertion(+), 14 deletions(-)
> > > >=20
> > > > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c =
b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > index 9e067dcbf607..186b8c82b9e6 100644
> > > > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > > > @@ -31,19 +31,6 @@ struct {
> > > >         __type(value, char[STRSIZE]);
> > > >  } strdata SEC(".maps");
> > > >=20
> > > > -static int __strncmp(const void *m1, const void *m2, size_t len)
> > > > -{
> > > > -       const unsigned char *s1 =3D m1;
> > > > -       const unsigned char *s2 =3D m2;
> > > > -       int i, delta =3D 0;
> > > > -
> > > > -       for (i =3D 0; i < len; i++) {
> > > > -               delta =3D s1[i] - s2[i];
> > > > -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> > > > -                       break;
> > > > -       }
> > > > -       return delta;
> > > > -}
> > > >=20
> > > >  #if __has_builtin(__builtin_btf_type_id)
> > > >  #define        TEST_BTF(_str, _type, _flags, _expected, ...)      =
             \
> > > > @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void *=
m2, size_t len)
> > > >                                        &_ptr, sizeof(_ptr), _hflags=
);   \
> > > >                 if (ret)                                           =
     \
> > > >                         break;                                     =
     \
> > > > -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_STR=
SIZE); \
> > > > +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _expec=
tedval); \
> > >=20
> > > Though it's equivalent, the point of the test is to be heavy
> > > for the verifier with open coded __strncmp().
> > >=20
> > > pw-bot: cr
> >=20
> > I double checked that before acking, the test was added as a part of [1=
].
> > So it seems to be focused on bpf_snprintf_btf(), not on scalability.
> > And it's not that heavy in terms of instructions budget:
> >=20
> > File                     Program                  Verdict  Insns  State=
s
> > -----------------------  -----------------------  -------  -----  -----=
-
> > netif_receive_skb.bpf.o  trace_netif_receive_skb  success  18152     62=
9
>=20
> Is this before or after?
> What is the % decrease in insn_processed?
> I'd like to better understand the impact of the change.

That's before, after the change it is as follows:

File                     Program                  Verdict  Insns  States
-----------------------  -----------------------  -------  -----  ------
netif_receive_skb.bpf.o  trace_netif_receive_skb  success   4353     235
-----------------------  -----------------------  -------  -----  ------

So, the overall impact is 18K -> 4K instructions processed.

