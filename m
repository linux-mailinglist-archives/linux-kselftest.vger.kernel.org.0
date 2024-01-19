Return-Path: <linux-kselftest+bounces-3263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F9683315D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 00:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F08E284C0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 23:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A14E58AC8;
	Fri, 19 Jan 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB/DAmYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484458ABF;
	Fri, 19 Jan 2024 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705705991; cv=none; b=GiOhk0xk6qgk/gfJqcY3jDNFg1WP/4hyYQG4exd+ks8eNX8/NWCJUILUlDEAIihhX8Q9o7QLRgXlSP8dc2rd7hfVjJwpqyEzyTmSm019N0Vd2gUxnoLOGWmVB7lj+jpfVNWjuhA8ajoKl/hOtXJkWdeTS9Qv4oEqoZWkeuGyoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705705991; c=relaxed/simple;
	bh=ZIIpZqUlqJ4c4JFESES4pFdqT7/WY2rHoNYSsySC1eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1g7VmKOn65NeUfI0Orqkt/XS4HlLZ3jME73Ts5+Dv57PUQ9jTVzhdg0/DAn141W2xYDvnLZ2nvEoumLY/hMUwRkMZEvriupQo3yM9n3ZPliim/1vDBq7Ch17SGM/FX2qjdzz9eoBU98LkJPyh0UNBs1ftGlH+cGxAs1HniqNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB/DAmYa; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4298e866cd6so8429891cf.0;
        Fri, 19 Jan 2024 15:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705705989; x=1706310789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SVsGFrAqe3TDNcPEh3cHm84wfyPFhb/XHrX3klObA4=;
        b=LB/DAmYaYVV95ykDJn2els4pfUROXK6jrDDcarRuKm29VqkU29dv02ImVdGQSpOrVk
         JwHwNL27nvKcRovnmberFYKkKpb1WZtnj6t7ZhN2/p+8o2zciF1uoEKBrXhE+Q1w20/F
         ALICthVcxg3DAFLVmB0sjZAfL3n+xY6O7c6TWizQthAHXHvjKOSrN2RFxZht06Xe8+xU
         3hFqsF+XQNNAG3m9Fdmnx4hXSBm+bSKhaf1gzoyXQPkDPNJhS4c2KInfvZ0DuSnqml2u
         wn9ZDWxutsVXHZQdz6PhJaOM8ReBQ3Zoz0lqytU9Tol9DTSJZ1do/Tvmds0CH4Fuc21U
         Xwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705705989; x=1706310789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SVsGFrAqe3TDNcPEh3cHm84wfyPFhb/XHrX3klObA4=;
        b=v7nx4pKiqv9r6XyuR8ORqGkxlaReVdg8qjVqWru8suCADlc0BBO+kFJV0XUtWv+2Gn
         hjWmqymiYKQbgp1hykMoxD40FYq74gxvZ/crSfDgK3PTptzFd3W0Rjr9aQux/fy0iCVB
         x7T8IlwoXv+A8oiz5uAXmzs9lQzSHKyVXTncugORmdnNk4TmXFChOoukSKdIJC+NWYhz
         og8Q5K1VZHPZ9LpXxr5Q9YukCLsbtB8a9IytFTMl0dxKXlloFz1P0EboANRlwHs1d9q6
         CrrgYkwV3JeoHCf1o3Ue1fat4lWGFSHRvyzCwNTNivLyl5GIrE1bBd1McX2wHhQAYayt
         r5uw==
X-Gm-Message-State: AOJu0YxWHGO2FSZH/DBgGgYjyXaZZhf8dwxtiPjlnWXLcSXtXpmnDYd1
	L8cjB61C9GVwLYIlRajitlVAO2c8ExyleA4KPODqdqceggPdSYMnD5wqp0/sFwmyJOdpWNja86X
	b6M4t6u1ZYr8WHVl7op5RQFffoeI=
X-Google-Smtp-Source: AGHT+IGEvIsV4Ows3IIE4NBUU0O+nfy2CvS9bncOznixN4ljFR4vQmbq4hn2VrBpkfB4hGU0vhAY9mC7gWBXYidojOI=
X-Received: by 2002:ac8:5f11:0:b0:429:d341:a11e with SMTP id
 x17-20020ac85f11000000b00429d341a11emr631302qta.135.1705705988974; Fri, 19
 Jan 2024 15:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f4l6fadtxnvttlb27heyl3r2bxettwwfu5vrazqykrshvrl3vm@ejw2ccatg3wi>
 <0c0a7705e775b2548f3439600738311830dbe1a9.camel@gmail.com>
 <uf7fpvox2s3ban33ybixlg2buxbh2ys2gl7wjrphuip2qrdsjr@56dp2546tuuu>
 <71ac757d092c6103af7c6d0ebb4634afcaa0969a.camel@gmail.com>
 <CAK3+h2yQBHRxp+rv7VBJqMQWeudADiDnwXZ+KesT4XSOupFMzA@mail.gmail.com> <CAADnVQKMy_YchC2RVaGFiho7Qgdwxm9uPaQ74BMcwNE_zwbR4Q@mail.gmail.com>
In-Reply-To: <CAADnVQKMy_YchC2RVaGFiho7Qgdwxm9uPaQ74BMcwNE_zwbR4Q@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Fri, 19 Jan 2024 15:12:58 -0800
Message-ID: <CAK3+h2waCj=GF2LdV+nWL3N+s9Ke-eHo-NVBhqm6CEsNE6zA5Q@mail.gmail.com>
Subject: Re: Re: lsm_cgroup.c selftest fails to compile when CONFIG_PACKET!=y
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 2:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 19, 2024 at 7:00=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.c=
om> wrote:
> >
> > On Fri, Jan 19, 2024 at 4:23=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Fri, 2024-01-19 at 16:04 +0800, Shung-Hsi Yu wrote:
> > >
> > > [...]
> > >
> > > > Final goal would be have BPF selftests compiled and test against ou=
r own
> > > > kernel, without having to come up with a specific kernel flavor tha=
t is
> > > > used to build and run the selftest. For v5.14 and v5.19-based kerne=
l it
> > > > works: compilation is successful and I was able to run the verifier
> > > > tests. (Did not try running the other tests though)
> > >
> > > You mean ./test_verifier binary, right?
> > > A lot of tests had been moved from ./test_verifier to ./test_progs si=
nce.
> > >
> > > > > As far as I understand, selftests are supposed to be built and ru=
n
> > > > > using specific configuration, here is how config for x86 CI is pr=
epared:
> > > > >
> > > > > ./scripts/kconfig/merge_config.sh \
> > > > >          ./tools/testing/selftests/bpf/config \
> > > > >          ./tools/testing/selftests/bpf/config.vm \
> > > > >          ./tools/testing/selftests/bpf/config.x86_64
> > > > >
> > > > > (root is kernel source).
> > > > > I'm not sure if other configurations are supposed to be supported=
.
> > > >
> > > > Would it make sense to have makefile target that builds/runs a smal=
ler
> > > > subset of general, config-agnostic selftests that tests the core fe=
ature
> > > > (e.g. verifier + instruction set)?
> > >
> > > In ideal world I'd say that ./test_progs should include/exclude tests
> > > conditioned on current configuration, but I don't know how much work
> > > would it be to adapt build system for this.
> > >
> >
> > I would also suggest skipping building the specific bpf test code when
> > a specific CONFIG is removed, sometimes
> > I only want to test some bpf selftests code I am interested in :)
>
> I don't think we should be complicating bpf selftests to test
> configurations with reduced kconfig.
> bpf/config.* is what we target in bpf CI and we expect
> developers do the same amount of testing before they send patches.

Totally understand that from the kernel bpf developer perspective. I
am a bpf user learning how to write a bpf program from selftests, but
I guess there is another way to learn,  selftests is not for teaching
bpf users, no need to complicate.

