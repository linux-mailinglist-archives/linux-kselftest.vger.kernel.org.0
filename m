Return-Path: <linux-kselftest+bounces-5129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD285CF30
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 04:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF411C22EA7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 03:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B267F38DDD;
	Wed, 21 Feb 2024 03:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h4YroqIt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF812E842
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 03:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708487891; cv=none; b=ptSYOlonj1HGVygz2oslWxAa7bstDWTIV1coIKHsEcudTgehgQhQSfCztCBjCxhM7l2TvQsfYttQNF/8Zs/z3WgMJ+iXZrUM3ByCynDfZDTP/Vgz2mTnQ06gQiRpD8cGvC11BlIQ1y54EuG2f73jkKUaOiDJFcfvOsS0ZNd7IeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708487891; c=relaxed/simple;
	bh=jquv4CpaBSqhtiqh7lJvpOasNrgo49Zb1h9viA+rxj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBNXAUvAPVW+ExgD6C6Q50cJKqotBg4/qXhZUMIs5eM3ouCnKfo3IW+qyJ4MlKzh3ofYi8JtF8tGZ8ih7b0QHmawyaBobMYDp9z5UPX2cprU3EBmZLcbG/gV5CR01EGR5kc3RYOFsyOePvCLvDu34hQt5wKyQykb7gTa+H66fII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h4YroqIt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e471caaa71so1531929b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 19:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708487889; x=1709092689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jquv4CpaBSqhtiqh7lJvpOasNrgo49Zb1h9viA+rxj4=;
        b=h4YroqIt5P77JejHMWjSsaMAKdFmGgF4PT1GYzOEpSOoielziWlNBY+ssvhLJWt9Is
         7/2Rb5ZfEw7TQqU70aPIz2PYRWRa7cEYyQ8B/g9Y+Z8JQxJ7bwUoFO7Ycw/yF0qUSZFP
         tbb7v1xDmAXLwQbJHM52skxZGq/oJJhNSpLdRic2CIlO529A7DE8hyrYtQUqKnnkPV93
         6vBj6t42bHc1vdLZGDCYaxYIlHBW4G7EW3D6Gvjpcw2e4DMMmfiCnDhjYyqZfM1LRb/N
         FDBU2R3Gf+Ts65ay+rFdrRXOdcvWRpK9X/ICdfnskuvgIuvyEMD3m8gcunUr7xFXGgai
         SB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708487889; x=1709092689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jquv4CpaBSqhtiqh7lJvpOasNrgo49Zb1h9viA+rxj4=;
        b=S4cmFjPqGs532oLPR9xgVe+IWYT1umTRKsNcpChwv3bKe7BEK7lpMBBnYJe+poXN/Q
         d+Rrtjt4ZCe4KhgYgB7fLK68y0ByxaZ7+9L5XlbmV4XTPJni4PuIoRk7p001ZsdM0rzf
         YkCfQU7bV4/bPMGv9hT8yeor5a8u9ftxWiiJtXMfc2g/knoSH9thx+wCNj5jgcCRFhDI
         bDWsfPyvgwDntCUKC8EsGbJlgvJmIQiKmXXT5pL9TYEIlAVGfQvH1G31xbx/Q5I7wIgy
         vfvWMeHPLtMmrpMuoMMlXOM2cRw7Oj81As2/R1zy8a7PVr7DpQaWRiTGa9JRCq3NMCCB
         ubGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPrlYNmO7WzTmCkPPmab21LKLYIi5E4t18DbCPtZzRFGqdHo+2zcrZTlqrcoWRzTxURx1DLRMqaKpoY4fI38Qm3aHBUYk4pIkUntOs6Nqf
X-Gm-Message-State: AOJu0YyTKujcA9m7mN432yEvJI98tG7Cosv+EhOLoH2Bd7c02wP+smeF
	VCRZkRTDO/imi8qmK8Hw/RRMv2KFUQPb334RhFVVUEh5qPWJURm62R/p1LGj5veblDPNmvHc/hl
	2RxJEOrmxoSGoaAoA8xe0Vt1Tg8T81ga/M+6+ZA==
X-Google-Smtp-Source: AGHT+IEFB9mgAouA35P/IFzUU88J+61x2Pg2aLsGi1Cb2/PG/KohmSs7+vl57fDt/Eq95l7k+PyXxygh+8rDDdHcp2E=
X-Received: by 2002:a05:6a20:d38f:b0:19e:a353:81b0 with SMTP id
 iq15-20020a056a20d38f00b0019ea35381b0mr17920299pzb.11.1708487889551; Tue, 20
 Feb 2024 19:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
 <CAADnVQ+E4ygZV6dcs8wj5FdFz9bfrQ=61235uiRoxe9RqQvR9Q@mail.gmail.com>
 <CALz3k9g__P+UdO2vLPrR5Y4sQonQJjOnGPNmhmxtRfhLKoV7Rg@mail.gmail.com>
 <CALz3k9h8CoAP8+ZmNvNGeXL9D_Q83Ovrubz9zHECr6C0TXuoVg@mail.gmail.com>
 <CAADnVQ+bOhh1R_eCoThyNg50dd4nA4-qhpXxOWheLeA_44npXg@mail.gmail.com>
 <CALz3k9jDsmNMrXdxdx152fgvBxDoY4Lj_xMf8z-pwPtpm75vXQ@mail.gmail.com> <CAADnVQLtHQO9X7EBxe4x6YyAdQi33aqzTirTJff5epTcBatd3g@mail.gmail.com>
In-Reply-To: <CAADnVQLtHQO9X7EBxe4x6YyAdQi33aqzTirTJff5epTcBatd3g@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 21 Feb 2024 11:57:58 +0800
Message-ID: <CALz3k9gM9Leuztxs9ZrM5YgwLXFQ4FMnBxHr6P=Q+GppPv5d=g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next 0/5] bpf: make tracing program
 support multi-attach
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Kui-Feng Lee <thinker.li@gmail.com>, 
	Feng Zhou <zhoufeng.zf@bytedance.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:18=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 20, 2024 at 7:06=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <dong=
menglong.8@bytedance.com> wrote:
> >
> > On Wed, Feb 21, 2024 at 11:02=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Feb 20, 2024 at 6:45=E2=80=AFPM =E6=A2=A6=E9=BE=99=E8=91=A3 <=
dongmenglong.8@bytedance.com> wrote:
> > > >
> > > > On Wed, Feb 21, 2024 at 10:35=E2=80=AFAM =E6=A2=A6=E9=BE=99=E8=91=
=A3 <dongmenglong.8@bytedance.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Wed, Feb 21, 2024 at 9:24=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 19, 2024 at 7:51=E2=80=AFPM Menglong Dong
> > > > > > <dongmenglong.8@bytedance.com> wrote:
> > > > > > >
> > > > > > > For now, the BPF program of type BPF_PROG_TYPE_TRACING is not=
 allowed to
> > > > > > > be attached to multiple hooks, and we have to create a BPF pr=
ogram for
> > > > > > > each kernel function, for which we want to trace, even throug=
h all the
> > > > > > > program have the same (or similar) logic. This can consume ex=
tra memory,
> > > > > > > and make the program loading slow if we have plenty of kernel=
 function to
> > > > > > > trace.
> > > > > >
> > > > > > Should this be combined with multi link ?
> > > > > > (As was recently done for kprobe_multi and uprobe_multi).
> > > > > > Loading fentry prog once and attaching it through many bpf_link=
s
> > > > > > to multiple places is a nice addition,
> > > > > > but we should probably add a multi link right away too.
> > > > >
> > > > > I was planning to implement the multi link for tracing after this
> > > > > series in another series. I can do it together with this series
> > > > > if you prefer.
> > > > >
> > > >
> > > > Should I introduce the multi link for tracing first, then this seri=
es?
> > > > (Furthermore, this series seems not necessary.)
> > >
> > > What do you mean "not necessary" ?
> > > Don't you want to still check that bpf prog access only N args
> > > and BTF for these args matches across all attach points ?
> >
> > No, I means that if we should keep the
> >
> > "Loading fentry prog once and attaching it through many bpf_links to
> > multiple places"
> >
> > and only keep the multi link.
>
> I suspect supporting multi link only is better,
> since the amount of kernel code to maintain will be less.

Okay!

