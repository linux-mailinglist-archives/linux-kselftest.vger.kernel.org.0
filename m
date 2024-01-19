Return-Path: <linux-kselftest+bounces-3260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586BA8330BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 23:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC911C21A7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 22:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9F758AB9;
	Fri, 19 Jan 2024 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlf2EJAQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842328694;
	Fri, 19 Jan 2024 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705703199; cv=none; b=rZpT7Z50N8Ylwz+6nRmcSmsxWwZmw70yi/KqqLyGT58AopSrZiErC978O8e6WQzeuI7QgYVZGoYIAdn3gGaMya8zhA5ixagrB3Q1iw7/GOj25j7BBWiJYA3je8d0Pxpsnc4gu+1wwj4jrCWbun7XRKy8lFiR5a4CqDSUJwjNb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705703199; c=relaxed/simple;
	bh=EPXwzBFLey4oPX8vmCyJCNLS/rHGXvWziCeUHH7LSmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvNFYoda2A7LVTbQqqsFOdp1puxZkuriYvSYc7ioRDVu25rrfjFsq7LFiYh7cUwmvGu72KlF7Rwk25NXeDxuSm93g6SzCng4f/kiNqx3UPLStb7T8LDOvod/Ud+yte1Ngp8Fs6iQkVktY0wgRNuNbeDeKp77SQfokiBJ80lyzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rlf2EJAQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-337be1326e3so1162950f8f.2;
        Fri, 19 Jan 2024 14:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705703196; x=1706307996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/lEydBLMKgOs6AOAMqBboJyW2zuEXt5CeuJI5/2RCY=;
        b=Rlf2EJAQK5Bw1vK/ouxhcFwqUicYuT+Y/UmqhRju3XZv1589drVSkOdUCBAqsEzVL8
         bfvko2ZWO4wbf1Q4wAoHVV1rAYwY5ETMoBauvoE+M8hvIBEbhHE7ZT+7wtFWY4XVSp5u
         xNLkq7QPFEtTy1auoo27QHxioZd3xKyc7aRLKckMqe1loBh2Y3gXh2r2EMZSIgcTHCXe
         69aqL18RJGcxMizgBt7YaHL4jx2kEM5MBy5BqoErEaSsng4Xl1mbAMdnmiHxENcljFbr
         M+oWvhJet3CwOdcjAFoIlgBnI9mgTH0hyiAETXcmA9jcTtUvw+rHW/XWMzmLCb0xWrFx
         lb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705703196; x=1706307996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/lEydBLMKgOs6AOAMqBboJyW2zuEXt5CeuJI5/2RCY=;
        b=JGJC/L7r5JFr1FE1MeG3gKiiuJY6oBDai5Sxizkc6yxqfI4fuV77eeHVBUc1RNix00
         bHkjxlsXok0BlLudS737v0nVWVW6exfo3i8Msd/8awb0ebIB2XV6ReDiM+yd1fFz6zM9
         UkvnFX+/00eMJo3fpPtKEQh6vo2R3z5bJM9taFJnljU+5VyFgDbv193emJHwaQ0+DNbW
         O7wQTL8gMbMghgwsmShz4MQ9oBAR4d/uRO34kMLvH+PedOj5hv705+rSBbWc0/3RqWkf
         ecWoh1aqL9yUrA8EW/UjytACmjg2sRN43MxuwAsaV1WE9jimEO5zMQ3JDMtBBh5+IMW+
         gKZg==
X-Gm-Message-State: AOJu0YyJ7tH9mubOBd2QP3JvTCK4uAKA56d1JraKH/gIDm/41ds0QCwO
	VtnohqaAFUnZfcG2U7lQwYvfyAGfYFM8WLiAwslVmZrzbE2xTr/IeNR3opn6nvppch0qxQ2XYGU
	olwMW6yxohdRz1StxVYXF/2Cf90g=
X-Google-Smtp-Source: AGHT+IGqyZpZoe+b4cqkQMyWeZOye3WOat67MCz2XG1JMNMPPkAfz0I58/eJEIK3Rwg2pKJWGM0dY9fRDG1YZqomb54=
X-Received: by 2002:a5d:6a4d:0:b0:339:21c4:8248 with SMTP id
 t13-20020a5d6a4d000000b0033921c48248mr268400wrw.131.1705703196208; Fri, 19
 Jan 2024 14:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f4l6fadtxnvttlb27heyl3r2bxettwwfu5vrazqykrshvrl3vm@ejw2ccatg3wi>
 <0c0a7705e775b2548f3439600738311830dbe1a9.camel@gmail.com>
 <uf7fpvox2s3ban33ybixlg2buxbh2ys2gl7wjrphuip2qrdsjr@56dp2546tuuu>
 <71ac757d092c6103af7c6d0ebb4634afcaa0969a.camel@gmail.com> <CAK3+h2yQBHRxp+rv7VBJqMQWeudADiDnwXZ+KesT4XSOupFMzA@mail.gmail.com>
In-Reply-To: <CAK3+h2yQBHRxp+rv7VBJqMQWeudADiDnwXZ+KesT4XSOupFMzA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Jan 2024 14:26:24 -0800
Message-ID: <CAADnVQKMy_YchC2RVaGFiho7Qgdwxm9uPaQ74BMcwNE_zwbR4Q@mail.gmail.com>
Subject: Re: Re: lsm_cgroup.c selftest fails to compile when CONFIG_PACKET!=y
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 7:00=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.com=
> wrote:
>
> On Fri, Jan 19, 2024 at 4:23=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Fri, 2024-01-19 at 16:04 +0800, Shung-Hsi Yu wrote:
> >
> > [...]
> >
> > > Final goal would be have BPF selftests compiled and test against our =
own
> > > kernel, without having to come up with a specific kernel flavor that =
is
> > > used to build and run the selftest. For v5.14 and v5.19-based kernel =
it
> > > works: compilation is successful and I was able to run the verifier
> > > tests. (Did not try running the other tests though)
> >
> > You mean ./test_verifier binary, right?
> > A lot of tests had been moved from ./test_verifier to ./test_progs sinc=
e.
> >
> > > > As far as I understand, selftests are supposed to be built and run
> > > > using specific configuration, here is how config for x86 CI is prep=
ared:
> > > >
> > > > ./scripts/kconfig/merge_config.sh \
> > > >          ./tools/testing/selftests/bpf/config \
> > > >          ./tools/testing/selftests/bpf/config.vm \
> > > >          ./tools/testing/selftests/bpf/config.x86_64
> > > >
> > > > (root is kernel source).
> > > > I'm not sure if other configurations are supposed to be supported.
> > >
> > > Would it make sense to have makefile target that builds/runs a smalle=
r
> > > subset of general, config-agnostic selftests that tests the core feat=
ure
> > > (e.g. verifier + instruction set)?
> >
> > In ideal world I'd say that ./test_progs should include/exclude tests
> > conditioned on current configuration, but I don't know how much work
> > would it be to adapt build system for this.
> >
>
> I would also suggest skipping building the specific bpf test code when
> a specific CONFIG is removed, sometimes
> I only want to test some bpf selftests code I am interested in :)

I don't think we should be complicating bpf selftests to test
configurations with reduced kconfig.
bpf/config.* is what we target in bpf CI and we expect
developers do the same amount of testing before they send patches.

