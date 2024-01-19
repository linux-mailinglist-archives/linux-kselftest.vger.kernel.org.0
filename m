Return-Path: <linux-kselftest+bounces-3264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A08833198
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 00:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C691C224BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 23:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16365915C;
	Fri, 19 Jan 2024 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cztVmGsC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBE59149;
	Fri, 19 Jan 2024 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707349; cv=none; b=KbA8xGfNCRdyWLBO7Em+LaycdfPOnBQvYI1MVnKCv9gngDmC2RTsyOT3PcmGbCLiASUVgDmYDQFRgoC91WZ3X2BaAZBDlbIjd5sZsV1A9bVS8b5EREQq+/UPlvvwz6d5zrDTHoIyCh2G/XTVW2qDBx8Tte/lkxIN3Toj/MJWIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707349; c=relaxed/simple;
	bh=exMkkn6nljNLcxNUb/zXifJLNV/vy9/cEFYz0eOXRcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6gNpYmlbyTHgqmlj6Y1rowjE3TeBtLqoLVi8u5vfstmuHv2Aev/WgHceG14MH03ay/pE3j+5oU1iqPz1kNtzv/0WikEljt6EfD9xrvNiGz34dXBFeBC4mpm4FxW83FpJKUWALBYxCC9DgvWqr4PBrf5UOMugDCS56Z5e4QcFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cztVmGsC; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-598a2cb5a7cso622338eaf.2;
        Fri, 19 Jan 2024 15:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705707347; x=1706312147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd3OkOwVBctUQyzGL0HBggWnvI9mKt8wARF3eIT4XQc=;
        b=cztVmGsCwqfE/eohEVkKi7nfrCJH99Bb0scDcUwQ0vMXu0rDzg/8F8ywRiXCQai84w
         eYUk7KhDC4br9OcsO40O0laLxWDA8RibQ0jbWbGThZ3YqxtWuyDvcKKEpWWQz0Ad2zXq
         dWCMNb1fec2v5hEK6KOel7vXjzDBKipizdxYzTKqSbwcr2g6rBmy9FwRI8lR33zOcJt0
         2QvYhoMGMlxR7cor/L9v+4PHPZsXQN0Y33uopuIlPbbbBhsXcCZo8y+8SHqVZ3dkgNnG
         ht5V4Cq03g1Ojj20F78XeJOLluyLmdUNx1GRmKRrHBJ+tufw8sLHW6PnCX3Rht8WJ9U/
         JuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705707347; x=1706312147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wd3OkOwVBctUQyzGL0HBggWnvI9mKt8wARF3eIT4XQc=;
        b=PY8xZhPel4iViY8tzMxTGpJHwn7XUsB5Z1c1agSkYfVVX78if86ZMsDG0SwlEGhVCk
         Elm4189iqumkUVobOzIZE5E8bosf6GPdpYJjJZ9NrAkYOdhjE3fTkVhYqU23w/k/IZsP
         BKH/z5VFSGJUEmQ8K9WRBdLikrHoC7H7Lyp4vqlzKDPjxKFZ/pKLtfnCJuz02E+n1nu1
         b9dBqSTLh3Sa3gzDQUzmCIpeGMEOguXDB0KkQDoYUVAtHE5o0zMQLZ1LAzXfSCoi6WQK
         A/A+F35/bu1/3bwXCb+HWcZ9Q/B8aSbh6p9R5duyuDrj/g0R7TNJehNDgs9LN2BRNhIs
         2pjA==
X-Gm-Message-State: AOJu0YwamXxb0q5vkozzXPIoKyEU2lWp1BhjxCth5ncgpNRU4wCFTHOM
	dH20uidEhx1zlGRSa9+mY9imx/TJ+66YJ5SDK6gtEHXOWsM+ZD6XlYcfR0EqNPJz6l4MCuUgrR9
	FEGhPEY8FhiWQdtuQO+AOuJD/bI8=
X-Google-Smtp-Source: AGHT+IHxOWeHGkUl75J0B7agdy3qcCMAUSuiLNzs7G9dqeo5L5X4AcHLQwKhdO7YuZHPWRFiudZY/hcmHzTlniaT8mM=
X-Received: by 2002:a05:6358:4b4f:b0:176:277d:347c with SMTP id
 ks15-20020a0563584b4f00b00176277d347cmr530937rwc.27.1705707347302; Fri, 19
 Jan 2024 15:35:47 -0800 (PST)
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
 <CAADnVQKMy_YchC2RVaGFiho7Qgdwxm9uPaQ74BMcwNE_zwbR4Q@mail.gmail.com> <CAK3+h2waCj=GF2LdV+nWL3N+s9Ke-eHo-NVBhqm6CEsNE6zA5Q@mail.gmail.com>
In-Reply-To: <CAK3+h2waCj=GF2LdV+nWL3N+s9Ke-eHo-NVBhqm6CEsNE6zA5Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jan 2024 15:35:34 -0800
Message-ID: <CAEf4BzaGoR4+EYM3jQVQba19r818UR7HoobYPvrNK05V6gYV9g@mail.gmail.com>
Subject: Re: Re: lsm_cgroup.c selftest fails to compile when CONFIG_PACKET!=y
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:13=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.com=
> wrote:
>
> On Fri, Jan 19, 2024 at 2:26=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jan 19, 2024 at 7:00=E2=80=AFAM Vincent Li <vincent.mc.li@gmail=
.com> wrote:
> > >
> > > On Fri, Jan 19, 2024 at 4:23=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > On Fri, 2024-01-19 at 16:04 +0800, Shung-Hsi Yu wrote:
> > > >
> > > > [...]
> > > >
> > > > > Final goal would be have BPF selftests compiled and test against =
our own
> > > > > kernel, without having to come up with a specific kernel flavor t=
hat is
> > > > > used to build and run the selftest. For v5.14 and v5.19-based ker=
nel it
> > > > > works: compilation is successful and I was able to run the verifi=
er
> > > > > tests. (Did not try running the other tests though)
> > > >
> > > > You mean ./test_verifier binary, right?
> > > > A lot of tests had been moved from ./test_verifier to ./test_progs =
since.
> > > >
> > > > > > As far as I understand, selftests are supposed to be built and =
run
> > > > > > using specific configuration, here is how config for x86 CI is =
prepared:
> > > > > >
> > > > > > ./scripts/kconfig/merge_config.sh \
> > > > > >          ./tools/testing/selftests/bpf/config \
> > > > > >          ./tools/testing/selftests/bpf/config.vm \
> > > > > >          ./tools/testing/selftests/bpf/config.x86_64
> > > > > >
> > > > > > (root is kernel source).
> > > > > > I'm not sure if other configurations are supposed to be support=
ed.
> > > > >
> > > > > Would it make sense to have makefile target that builds/runs a sm=
aller
> > > > > subset of general, config-agnostic selftests that tests the core =
feature
> > > > > (e.g. verifier + instruction set)?
> > > >
> > > > In ideal world I'd say that ./test_progs should include/exclude tes=
ts
> > > > conditioned on current configuration, but I don't know how much wor=
k
> > > > would it be to adapt build system for this.
> > > >
> > >
> > > I would also suggest skipping building the specific bpf test code whe=
n
> > > a specific CONFIG is removed, sometimes
> > > I only want to test some bpf selftests code I am interested in :)
> >
> > I don't think we should be complicating bpf selftests to test
> > configurations with reduced kconfig.
> > bpf/config.* is what we target in bpf CI and we expect
> > developers do the same amount of testing before they send patches.
>
> Totally understand that from the kernel bpf developer perspective. I
> am a bpf user learning how to write a bpf program from selftests, but
> I guess there is another way to learn,  selftests is not for teaching
> bpf users, no need to complicate.

Try libbpf-bootstrap ([0]) as a simple setup to play with new BPF
features. minimal or bootstrap examples are usually good starting
points.

  [0] https://github.com/libbpf/libbpf-bootstrap

