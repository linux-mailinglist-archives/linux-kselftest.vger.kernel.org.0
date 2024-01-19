Return-Path: <linux-kselftest+bounces-3265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCC08331B1
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 00:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEAC284497
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 23:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1613F59173;
	Fri, 19 Jan 2024 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRV46JY9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1EA55E63;
	Fri, 19 Jan 2024 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705708458; cv=none; b=LcF9o8qGmNLkDi8oxBYK4gy+bMGtJ/QSuGoip96n6SZq7YWZbw4efSw2c1msTRLiw4KsFdNE0W5JlXKW7+ME/+QY39s3LidLt5uGYftlFmHslNTquuls9CEK1SZF5xx2XwKgf7wS09SvSi0lZHsiIKyEzPSZE1cHeUDOYD7L+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705708458; c=relaxed/simple;
	bh=Tw1kfBbroK0xUIYhHQUqENaxo7vsNmH/RC4xN3Xsuso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTfalXDATsjSI/k8j+XnEFTq6c4WdAC5+yNI6J/pVi+DLQ6t/MetHTADBeDUdWvdPE/O4XGrhWnxinLEn9/lvOBZ2IFBotx7AZZv/CMp7Pw1Hoqu7AFx3CB8N5fdx7snaFtM5YWbOJz/re14BgEMcn+SU16WruLY7MJ8GKL83C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRV46JY9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4298e866cd6so8653011cf.0;
        Fri, 19 Jan 2024 15:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705708455; x=1706313255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIpC1Yh2GbIKhd5D8mXJR+ySfViqLAS3kNAflIvdAKM=;
        b=YRV46JY9TQM+8ewi6zPPIh93tsyZ/Qwq1nPg2mkXhqkIhXdT4pJ3Cxm/fyVd62irDu
         CbfwiaEZTfe+n/hX5XzcoOkxNz1RiSZtTuF6O6q4nHRhBL9YhqvAEpjbH252BThiwBUP
         sDvZJoSxSwgFaFY077SttOZHj62xFXaLmjPBSeGaCCEXPCRsKsqgg/JTqbdb+oQFkMvo
         ozgwsSoIAqYVbJmijQAPDbzzHfun8fpIK18QwMQPiEu16GctDOBQoyHFmjLpu2CLwyq2
         fox9rAyUp3sC0AQ07A0IVsXmFiCTKC++r7LeX1T1PMuAv/J1L//r/N8Ti61yaqsrvjID
         YMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705708455; x=1706313255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIpC1Yh2GbIKhd5D8mXJR+ySfViqLAS3kNAflIvdAKM=;
        b=b/60xdNIHjX6hclzWJyObwbXyrHTuc3JNVdbjzpuf5M9m90m55Z4Fro8wKOifEswsB
         y+DktKflCijkaw3lYMMZS5eh0tfW4S7+jHQaUupw++Fj+r4yuFDgoh9+C2qkc71jG+ZB
         YranMJa6uPU++b+5SxSsHTPR8n4uG6bzOMVfSEEbazLjfI0YIL2Lu3Hx3z9GUjGaRjFK
         qA+wU9mYgKoM2n6JRUqgHhOjY2lKlMJG57pAqBrqDbE2V/d+auG7S2o1EYzCld65WNsO
         i7EUgutWn3iJ7cl6gmITHiFfuC1BSgaor9c/rAdMXMwzDFbFc4PK+MkdCIgNjDGxNEBX
         efKA==
X-Gm-Message-State: AOJu0YyNkzVXQsKvU9gTD5AoxXR9i/c2uFU2R4nW7uxzsw3XZfa2gHFB
	wYVS/RLlEBc+Qf/nTncUy8FYsKhBLoXmnBRe3xga/OB9wiiNFlbv7Qf3xGnPobkJWmLOa8A0bou
	pca/JOSlOWCHnIJZ8bH90u27EyMY=
X-Google-Smtp-Source: AGHT+IF/dfEg52iF8Fr7LCdYwjTvBj3XYBYnaquvHBJPojqniPmgblDW6hmT5RC8L9fU+1h1X65kNhbjMyi2SSHd1qU=
X-Received: by 2002:a05:622a:282:b0:42a:8c3:65f with SMTP id
 z2-20020a05622a028200b0042a08c3065fmr615932qtw.137.1705708455323; Fri, 19 Jan
 2024 15:54:15 -0800 (PST)
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
 <CAK3+h2yQBHRxp+rv7VBJqMQWeudADiDnwXZ+KesT4XSOupFMzA@mail.gmail.com>
 <CAADnVQKMy_YchC2RVaGFiho7Qgdwxm9uPaQ74BMcwNE_zwbR4Q@mail.gmail.com>
 <CAK3+h2waCj=GF2LdV+nWL3N+s9Ke-eHo-NVBhqm6CEsNE6zA5Q@mail.gmail.com> <CAEf4BzaGoR4+EYM3jQVQba19r818UR7HoobYPvrNK05V6gYV9g@mail.gmail.com>
In-Reply-To: <CAEf4BzaGoR4+EYM3jQVQba19r818UR7HoobYPvrNK05V6gYV9g@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Fri, 19 Jan 2024 15:54:04 -0800
Message-ID: <CAK3+h2y9UVQsUy-COjTH3B-eot2xNNd+T1e848hZ7XDUTS-86A@mail.gmail.com>
Subject: Re: Re: lsm_cgroup.c selftest fails to compile when CONFIG_PACKET!=y
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 19, 2024 at 3:13=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.c=
om> wrote:
> >
> > On Fri, Jan 19, 2024 at 2:26=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jan 19, 2024 at 7:00=E2=80=AFAM Vincent Li <vincent.mc.li@gma=
il.com> wrote:
> > > >
> > > > On Fri, Jan 19, 2024 at 4:23=E2=80=AFAM Eduard Zingerman <eddyz87@g=
mail.com> wrote:
> > > > >
> > > > > On Fri, 2024-01-19 at 16:04 +0800, Shung-Hsi Yu wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > Final goal would be have BPF selftests compiled and test agains=
t our own
> > > > > > kernel, without having to come up with a specific kernel flavor=
 that is
> > > > > > used to build and run the selftest. For v5.14 and v5.19-based k=
ernel it
> > > > > > works: compilation is successful and I was able to run the veri=
fier
> > > > > > tests. (Did not try running the other tests though)
> > > > >
> > > > > You mean ./test_verifier binary, right?
> > > > > A lot of tests had been moved from ./test_verifier to ./test_prog=
s since.
> > > > >
> > > > > > > As far as I understand, selftests are supposed to be built an=
d run
> > > > > > > using specific configuration, here is how config for x86 CI i=
s prepared:
> > > > > > >
> > > > > > > ./scripts/kconfig/merge_config.sh \
> > > > > > >          ./tools/testing/selftests/bpf/config \
> > > > > > >          ./tools/testing/selftests/bpf/config.vm \
> > > > > > >          ./tools/testing/selftests/bpf/config.x86_64
> > > > > > >
> > > > > > > (root is kernel source).
> > > > > > > I'm not sure if other configurations are supposed to be suppo=
rted.
> > > > > >
> > > > > > Would it make sense to have makefile target that builds/runs a =
smaller
> > > > > > subset of general, config-agnostic selftests that tests the cor=
e feature
> > > > > > (e.g. verifier + instruction set)?
> > > > >
> > > > > In ideal world I'd say that ./test_progs should include/exclude t=
ests
> > > > > conditioned on current configuration, but I don't know how much w=
ork
> > > > > would it be to adapt build system for this.
> > > > >
> > > >
> > > > I would also suggest skipping building the specific bpf test code w=
hen
> > > > a specific CONFIG is removed, sometimes
> > > > I only want to test some bpf selftests code I am interested in :)
> > >
> > > I don't think we should be complicating bpf selftests to test
> > > configurations with reduced kconfig.
> > > bpf/config.* is what we target in bpf CI and we expect
> > > developers do the same amount of testing before they send patches.
> >
> > Totally understand that from the kernel bpf developer perspective. I
> > am a bpf user learning how to write a bpf program from selftests, but
> > I guess there is another way to learn,  selftests is not for teaching
> > bpf users, no need to complicate.
>
> Try libbpf-bootstrap ([0]) as a simple setup to play with new BPF
> features. minimal or bootstrap examples are usually good starting
> points.
>
>   [0] https://github.com/libbpf/libbpf-bootstrap

Thanks! I am aware of libbpf-bootstrap, I am on an old centos 8 distro
which often miss linux headers that some selftests happens to require,
especially the ones that are not using vmlinux.h, when a bpf kernel
developer submit patches and selftests that I am interested in, I want
to run that selftests and learn the new feature, and then probably
port the new useful selftests code to a real use case bpf program. I
often run into other selftests compiling errors when I want to
selftest the new feature I am interested in. Anyway, it is my build
environment problem, not selftests.

