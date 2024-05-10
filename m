Return-Path: <linux-kselftest+bounces-10061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EF68C2CA1
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 00:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4AB1F24131
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 22:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6494116F26B;
	Fri, 10 May 2024 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7PXvsdy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D514F130;
	Fri, 10 May 2024 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715380344; cv=none; b=onrb33ZG44NCdxgDYvP5kQRoUz01Y+SarMjtXneT3EGuwXa8XzCZK9IP/iZzxsZ/P1h8qY21rMPmEUYiNt/v+pQyjlu/KUsfph9KjJ3kwbjnz+g6yjfjhjujw2i2kooXE2ntPEWtibP8ykrTgd43r7MHRMpCbNqFZjZIwZeP+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715380344; c=relaxed/simple;
	bh=BplohyCDLbrqKI8Dro3eag9DCXAwc4L5fx0gsf0ZTSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKMqadQa3+GveC230MyOL7CB3FHcT0uMVSwyboM4Qp/BVavnblYn6/i3ZAAQNZnYgNWbkZi0vzD5ifiz6eXaFiCnRTQLAuDcAkKKlj0V99MJ6Uq7pzky4wL1+FnCVs+HDq75D4VUputt52QMiCqxFv0SXnJcdvZ7y9y+KzTF4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7PXvsdy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec4b2400b6so23993795ad.3;
        Fri, 10 May 2024 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715380341; x=1715985141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BplohyCDLbrqKI8Dro3eag9DCXAwc4L5fx0gsf0ZTSM=;
        b=D7PXvsdyzGhDgduj69VRjBVBhbCw1gQ8fekekLUJt8IQrSktkMtwMAwwp0oZphY31m
         yQTU+mwPWpP1sMPbd4cOwpACUJfnu4/k7e7VZOJx6AJcjFgIYRD8SVmDSttMJVgw1uXh
         RdbcwSFxHUJ9shfalAhKyleZDZGm3zGs8QHKm8nJfhSCQudFhd+KCNsuNegyyFPvL3+8
         6MYMGiW7fgFbL7wpMhtTrilS5BJnXVGe8JRuPX4BGHBqRqMffWrzuGDnPsj8WpW5+nVt
         eS1ZQVo/tyoGeCfHhTVvhJnHlk7ElyjBoOWsU/dlmeY9lQc/8hxFplwrVEX8Te67i+vQ
         wOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715380341; x=1715985141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BplohyCDLbrqKI8Dro3eag9DCXAwc4L5fx0gsf0ZTSM=;
        b=jBmcHV0Qg1QajKFXaNFyRTAQVPR6hWLqU+G9XsDXRATP/o9QmhkYlUKvMS8mBScKKT
         76fGdvvLPAyeZwnKshMbyhe0qXFN9W/H3L1b9sm6sl+uALNONUmceDRtAGeBzaf6zfBw
         z4v6mfGp/5ypuCc6VRH/dcym+XjfZ5hXGFvpMz/R9IPZV8UuVCLMV5q0FYXywK5H1vSE
         BxAxYhDbf5SLPL+9ILgQPQI9537Dm/RzHSRU/Owhu7yFeEdkyYO2d9oiv+vFQeIPkGO6
         nxlz4dxv83k8mL+FiJ3RTpFlPT6JUwEfMMDZ+EfhTMVVJo4m2Qm/k7CSw1ViZPddxY0B
         +QAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+gmKd0NXCj0NJuW+qgdSwCCYKDBR9GMlTtGKK5xJBqdS/LFYtO7/xYPYELxK9bFsLy8HvhxJSDFqPd7fwRbHqbjPilSAtgms74V+cD0NP
X-Gm-Message-State: AOJu0YzMEScHMDljcJCK856oxMXvB+iIe5xTWoo51i/9iUg2Y05wu3dY
	9N3nzM+UzmE7P9IUNWzpH+QTXmy6I8psgmxr9pdrXKWXCaJ70+HYJbR2J+N9Qow6Gz07/fZID08
	b604Scb+tCVoqWIrzpw+NzJ+OR8U=
X-Google-Smtp-Source: AGHT+IFQOGr3C92gBBGSE2ufj7CHXHG5zr+Uk8P1+LFP9+6Mtchub6DFEXkGwkaL1ajCOOVvOdIiKHU2P+8Gy/8F63A=
X-Received: by 2002:a17:90a:fe87:b0:2b2:9621:ffef with SMTP id
 98e67ed59e1d1-2b6ccef6ba9mr3517867a91.46.1715380341164; Fri, 10 May 2024
 15:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com> <CAEf4BzZ+Gymr9hgJog3NddVVhtvcGiYwLHGGUVEruUUy-h8t8Q@mail.gmail.com>
 <CADKFtnQCbWm4geSJ0FBhb7kJtLC3sLmdnKOpZbc5k=mc+HwExA@mail.gmail.com>
In-Reply-To: <CADKFtnQCbWm4geSJ0FBhb7kJtLC3sLmdnKOpZbc5k=mc+HwExA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 May 2024 15:32:08 -0700
Message-ID: <CAEf4Bzb9rDmAQiXiZLEvPUFZkd0wrzD1-tyhFROwGSgOoenM0w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 00/17] Retire progs/test_sock_addr.c
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 3:13=E2=80=AFPM Jordan Rife <jrife@google.com> wrot=
e:
>
> Andrii,
>
> It looks like the PR bot dropped one of the commits from the patch
> series which is why it didn't build.
>
> > selftests/bpf: Handle ATTACH_REJECT test cases
>
> Is there any way to get it to recreate the PR with all 17 patches?
>

I marked it back as "New" in patchworks and this time BPF CI picked up
all patches, I think. Will let it run, thanks for noticing this! You
don't need to resend anything just yet.


> -Jordan

