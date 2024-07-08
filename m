Return-Path: <linux-kselftest+bounces-13323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3198592A785
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 18:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33B6281CA9
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 16:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149C0146595;
	Mon,  8 Jul 2024 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhl2y14B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1E143881
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jul 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456965; cv=none; b=PMbCMEtJvmHXn2GveiwJHp9C5qBnUHcOgundbQS7hRonELvckRVKynTP5Vf6qYavhIMseWbrj4X9bWCs9gLGH5S4TmbbivicIB1WfvgkT5ZGVQ1rcbc87cdSyogQE3wqKawkT0iD4ciuyyyJmEAp8BvzqBRDh7xV88fyqdRRUGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456965; c=relaxed/simple;
	bh=SMSXQy/4fLhK2QipqoruTLc7ydPAgk2ANoH8rp63Jis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT1fi70WqfYT5gfHov71Y3J2qqNi76Q1Q1z0/hTjmke+K7Fmza4hbc+70nncgKMPfvYhUT1SRRxpxFp5hsGBYkfH9XMyJm8IB1DsXP7yAvF94N01i0ZS4grHkc44t5HF4RI8gILF3uLIyjTvyCk/YXA1qlnMCRBG55qmc1hbSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhl2y14B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96814C4AF0E
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jul 2024 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720456964;
	bh=SMSXQy/4fLhK2QipqoruTLc7ydPAgk2ANoH8rp63Jis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qhl2y14BeeVEDy0eOdkxoyxNmMv8hqiDNQJgwyj2Pg46zbeonXs4u3EEqCgbwBLCJ
	 UGJf0D30adjef4PsCZ22JcIIYa3V9aiKPoqDvl5sFSkb439bS5actA3gdrWy46ObFu
	 oLN1ltT1EN20hnT8iFWB6GA7rRyFnnnX6218pht7REdmV3Jqz5x1Hd5E+vD38zOnEB
	 2TvSuDNPNaE4VaeJRtvmsauBVyNUa1ExJymnd+Ea7vyIVTt8PZRcCiL4Evu+D6iYvs
	 NEwmOa16Jk7idZj8YS2okepnHTkOoeCUky3CU+nG0l/2Eo4AyiP9puDdv5IlN/fO37
	 8KAhuuRCYWsNg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57cbc2a2496so4800244a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jul 2024 09:42:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeFoFtt0pqkidcn4eJLbmzm+/tU136g782aUyc5ETXXH+pwBGoXGXBfnnpn3yf/JaN8JhY30T0TuWB9+oriul2lHNmD7TXCgXvH/LFY7bb
X-Gm-Message-State: AOJu0Yy0PVfqN14n3paPGe1hsb+a7koqoyk6orP3RiA57jycLpPAKnhI
	x0tVW/MUeRM8yBKoXb9XcXmZ3r3mJ5bGVrDL5D9vgwda1GoDIuDtQc1Mu+BtFRZZO7qNNlYLvhR
	g3oIJoUsMbbE33jVGaBpvupJ3qOhX1URgH6rP
X-Google-Smtp-Source: AGHT+IEn/+zjOxNlsBbi8sx43v/ohZLMhX0KlqE0oZIG6iZ1BHYOnNlwXxTHtOhQXzhPvikWp9mzFU3o7Y7l6KCRW/o=
X-Received: by 2002:a05:6402:354f:b0:57d:2c9:6497 with SMTP id
 4fb4d7f45d1cf-594bab80106mr125789a12.3.1720456963027; Mon, 08 Jul 2024
 09:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705145009.32340-1-puranjay@kernel.org> <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org> <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net> <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
In-Reply-To: <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net>
From: KP Singh <kpsingh@kernel.org>
Date: Mon, 8 Jul 2024 18:42:31 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
Message-ID: <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Puranjay Mohan <puranjay@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Manu Bretelle <chantra@meta.com>, 
	Florent Revest <revest@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 6:09=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 7/8/24 5:35 PM, Puranjay Mohan wrote:
> > Daniel Borkmann <daniel@iogearbox.net> writes:
> >
> >> On 7/8/24 5:26 PM, KP Singh wrote:
> >>> On Mon, Jul 8, 2024 at 5:00=E2=80=AFPM Puranjay Mohan <puranjay@kerne=
l.org> wrote:
> >>>>
> >>>> Daniel Borkmann <daniel@iogearbox.net> writes:
> >>>>
> >>>>> On 7/5/24 4:50 PM, Puranjay Mohan wrote:
> >>>>>> fexit_sleep test runs successfully now on the CI so remove it from=
 the
> >>>>>> deny list.
> >>>>>
> >>>>> Do you happen to know which commit fixed it? If yes, might be nice =
to have it
> >>>>> documented in the commit message.
> >>>>
> >>>> Actually, I never saw this test failing on my local setup and yester=
day
> >>>> I tried running it on the CI where it passed as well. So, I assumed =
that
> >>>> this would be fixed by some commit. I am not sure which exact commit
> >>>> might have fixed this.
> >>>>
> >>>> Manu, Martin
> >>>>
> >>>> When this was added to the deny list was this failing every time and=
 did
> >>>> you have some reproducer for this. If there is a reproducer, I can t=
ry
> >>>> fixing it but when ran normally this test never fails for me.
> >>>
> >>> I think this never worked until
> >>> https://lore.kernel.org/lkml/20230405180250.2046566-1-revest@chromium=
.org/
> >>> was merged, FTrace direct calls was blocking tracing programs on ARM,
> >>> since then it has always worked.
> >>
> >> Awesome, thanks! I'll add this to the commit desc then when applying.
> >
> > The commit that added this to the deny list said:
> > 31f4f810d533 ("selftests/bpf: Add fexit_sleep to DENYLIST.aarch64")
> >
> > ```
> > It is reported that the fexit_sleep never returns in aarch64.
> > The remaining tests cannot start.
> > ```

It may also have something to do with sleepable programs. But I think
it's generally in the category of "BPF tracing was catching up with
ARM", it has now.

- KP

> >
> > So, if the lack of Ftrace direct calls would be the reason then the
> > failure would be due to fexit programs not being supported on arm64.
> >
> > But this says that the selftest never returns therefore is not related
> > to ftrace direct call support but another bug?
>
> Fwiw, at least it is passing in the BPF CI now.
>
> https://github.com/kernel-patches/bpf/actions/runs/9841781347/job/2716961=
0006

