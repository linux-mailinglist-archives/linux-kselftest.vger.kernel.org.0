Return-Path: <linux-kselftest+bounces-3246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ECD832C03
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 16:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2D01F21253
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B295F53E24;
	Fri, 19 Jan 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V63X4I0i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A61373;
	Fri, 19 Jan 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676422; cv=none; b=h7uHoqg/xoZIKZ1gRIffqTC9owjnaygEw6TyAif/GXSTe/eDr5XSjjZmSGuaVzgEpkziD65xCvxmqydCUdQ47iCd6NGXUNa5BGYY+Skkx5LIEgAVC5kO9sm/ClEtwVj3+kqm36k/qTKGbZHPQE+iR1l1QrkXjafXh1EEUX6haZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676422; c=relaxed/simple;
	bh=bWIUTavYMubqwaSpp8iZSwdZMoqAFEZR4yiW7lTlw9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSokje8tRfmS6PUR7/fNJ5y24VU1uBSzCLu8IxhqijPVNVy/vBYCQ0HsPQ0EMwu9SDzOuLvOTI0V8GbpdNISpsXstOrYOe6PJ8h87qE8As6iAfVsP3ALjoGKyjP8iY46fIYJ4hq22QgUCCjZV28h4+/6ps3j3eKQ2NyYKWvIArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V63X4I0i; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a2945464aso3043651cf.0;
        Fri, 19 Jan 2024 07:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705676420; x=1706281220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPEaBZ/KNPZsAhj1QLyGMcDCE3IdnDYTZxSGHiKFnUM=;
        b=V63X4I0i/WC7e1BBkvtUX9EriN1zJjBxXmAoCI1m0zg5FJHn5N6PR8PjO0SlHe2Uyr
         QORJyNPGB0snxsf0YWuoAzGvZNfBJu/CUdBIEqBHCkj8jTKsr7vmbdnqtZz7NknIpx1C
         9BuYCAMLahnbAebfTgENUgzc9K0LU6rgiwwh9iLlokADJKpkEvOz38rcGrdmXeLUFPG6
         SOqwtXHEods/RFvoRuRBq2ztK2L9V8Wwk3Bfkh9NOjzOeModaD/m6InfCVOZUKpMzQkx
         5yE+xRpc/TMoTVaaTwNnbAEtd6AVhdzsGEStOxntLhVw7UYaibPufdIuz8kq/y/4Mzpq
         L4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705676420; x=1706281220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPEaBZ/KNPZsAhj1QLyGMcDCE3IdnDYTZxSGHiKFnUM=;
        b=XiOhTd23fZ1yUXhyYarInXGA+C6xTLAE7kO2P61CZlPOjjFAnjQ7zijE/DUU8McUbF
         K1ZVlVw0VcK2BS6NfpYe5ExCabIr415fVEix7DQPmcm8ZqEcRvWPbe5clCfdgVDhL5oc
         qTJXeSYaV1BLbyDX1sMh+n2Mzspzv1ef1PULDcYWlO8s1e1/Q29VeWiqrtj2ayFPGo98
         VVtJdRVfycIPNzWSx4+wkPYsj3GL1COY4SAnTqN/07ho+P0kdQALnARPgNQBYercrIAE
         O6hOjrZnTnH7PkUCmTg8JFa8ZoTYvkd6xkmFjZlw9JXEbSuLyaDPhdAAOsJsjpGBRgrs
         MM1A==
X-Gm-Message-State: AOJu0YwKnMxKm3pauM05AkPGelIFWpnHumk6YC7Um3bv3T7/IxDkXBwK
	y2fobI0B1u0VRfUoDyK81JIyaogz1QenExcJD1lhUAoG3AroJk2qJl6MEaRHxFC6mp3L2O5u2Qo
	eEkz9nVVa99+W6Kl517gxR8Tgmu8=
X-Google-Smtp-Source: AGHT+IEsnFNyRPZz6YrAq5qI8dC+tk4lHEoLsb37UawIDZJLBMVHGX4HsRIXwRfMNpL5SFuHconB97HAFzufcUly7cY=
X-Received: by 2002:a05:622a:202:b0:429:c9b7:a437 with SMTP id
 b2-20020a05622a020200b00429c9b7a437mr3662630qtx.6.1705676420181; Fri, 19 Jan
 2024 07:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f4l6fadtxnvttlb27heyl3r2bxettwwfu5vrazqykrshvrl3vm@ejw2ccatg3wi>
 <0c0a7705e775b2548f3439600738311830dbe1a9.camel@gmail.com>
 <uf7fpvox2s3ban33ybixlg2buxbh2ys2gl7wjrphuip2qrdsjr@56dp2546tuuu> <71ac757d092c6103af7c6d0ebb4634afcaa0969a.camel@gmail.com>
In-Reply-To: <71ac757d092c6103af7c6d0ebb4634afcaa0969a.camel@gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Fri, 19 Jan 2024 07:00:09 -0800
Message-ID: <CAK3+h2yQBHRxp+rv7VBJqMQWeudADiDnwXZ+KesT4XSOupFMzA@mail.gmail.com>
Subject: Re: Re: lsm_cgroup.c selftest fails to compile when CONFIG_PACKET!=y
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 4:23=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-01-19 at 16:04 +0800, Shung-Hsi Yu wrote:
>
> [...]
>
> > Final goal would be have BPF selftests compiled and test against our ow=
n
> > kernel, without having to come up with a specific kernel flavor that is
> > used to build and run the selftest. For v5.14 and v5.19-based kernel it
> > works: compilation is successful and I was able to run the verifier
> > tests. (Did not try running the other tests though)
>
> You mean ./test_verifier binary, right?
> A lot of tests had been moved from ./test_verifier to ./test_progs since.
>
> > > As far as I understand, selftests are supposed to be built and run
> > > using specific configuration, here is how config for x86 CI is prepar=
ed:
> > >
> > > ./scripts/kconfig/merge_config.sh \
> > >          ./tools/testing/selftests/bpf/config \
> > >          ./tools/testing/selftests/bpf/config.vm \
> > >          ./tools/testing/selftests/bpf/config.x86_64
> > >
> > > (root is kernel source).
> > > I'm not sure if other configurations are supposed to be supported.
> >
> > Would it make sense to have makefile target that builds/runs a smaller
> > subset of general, config-agnostic selftests that tests the core featur=
e
> > (e.g. verifier + instruction set)?
>
> In ideal world I'd say that ./test_progs should include/exclude tests
> conditioned on current configuration, but I don't know how much work
> would it be to adapt build system for this.
>

I would also suggest skipping building the specific bpf test code when
a specific CONFIG is removed, sometimes
I only want to test some bpf selftests code I am interested in :)

