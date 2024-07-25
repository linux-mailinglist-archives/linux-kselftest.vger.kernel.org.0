Return-Path: <linux-kselftest+bounces-14191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3371F93B9E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 02:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CAD1C2176D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 00:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F2B139B;
	Thu, 25 Jul 2024 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT3QPV9L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D0181;
	Thu, 25 Jul 2024 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721868326; cv=none; b=GNYoQzhyxXDLG17CaaIhfiqpstRqpSyq4ZhTAp83fwWwXvkQZVXxM2RxyENWOPRFMPMuovVMj0B5AZhhceHfUF1VpOjicL7VBF1Oc4GkB/ie/XENP+ZKSzAntOoS71Jya9qJgny6o27vQrdgE3gaV7A2ljfheu5Bd3CNEW2+HMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721868326; c=relaxed/simple;
	bh=RX0NpOtwf06unnvg66Qlmru8ASJ2XmU/kbK2UXQWNPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+4btsO/yhsNaDBSeN7EchPLKaVEy44vc3q+OkXhWT2+U+l8M4XRNhuFZWObt4j4EJKwbqISWrNvyVUQS9oV66mzJgkINRxtBnbgx2fvlJeHWw4UwUUS3k9PO/yfCQDNti5DWq229eP8G1f03EwppdIlG6+Ux4DhDedFUb+DeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT3QPV9L; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-75ee39f1ffbso319552a12.2;
        Wed, 24 Jul 2024 17:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721868324; x=1722473124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYR0w03CdyewfJexhBUDkGe6RTeDkTXH7PP0JS6blf0=;
        b=mT3QPV9LvWXrpzA80FpFaI1RcLNgc3mG0nuXFQeIoCdYsfeZBe4ivvUuW4DvYKWKN8
         +uzs37MEIFVIQ73o53U+P+pI314VwLNEE+hdqc2zFQFB6XCLZtGw0NT5C0LmEi6LuitK
         Dn7cBqx1JkNhPcbXyIxQxilhUZKOkeur3B08XlVSXaYdAwMCFoNvNnEkEzdlruJ8qkOY
         m74I45jnTU0QytHEDbzMbS/pX0QV2rfddcD23WfjPhP+guplDHCM/qu3E/e0TCIW5zXX
         XZmipK4YrWYcid+SRNCEHxyw+6iNbW7XFQgbk7s13I8hqUGqhGo5Io1UdGV0WUns68X8
         gmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721868324; x=1722473124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYR0w03CdyewfJexhBUDkGe6RTeDkTXH7PP0JS6blf0=;
        b=ecxeS8+652MFcRvub5WU4dCvJ+xoLEGqSk91/HaWJWPo/sjid33Qkvp/Ne/rVHMuOs
         ZU5ub7kwCBpMv9xXx0Pj4bo92dK4fWE8AkgOetlcdvjCLIVE6tAOZP5O+EHrs/CkcFq1
         FltRZwpxiBfPiit2UNedFQUfeZwY2VT2rUYZoqSVyaPQTsumoH5rlEQN7q2i99PQILHO
         UXHQg7LNi9yVtM6ta+WRMgax5JtGyvi0LtZUsDWTWw2eN7NdobXUySjau0LIGYC5lV+L
         PC2FraZUHaqVfRHeuojHqTz1KXsbTwnFcDUnyZicuNVOQ6ZGsKK4VjM9MjU9qKpK7Bzj
         piEg==
X-Forwarded-Encrypted: i=1; AJvYcCXva4uwdsg7Od7TVqe0C1Tz3LgL3AUys7ylyBFKC7CZJ7S2LfKEulTROJDW3b4zbFSgMYLevZ4E2hrOxVFHc1GhXopd2T8BbYM2eUzrg5Uo
X-Gm-Message-State: AOJu0YztIYpW9CcuoIyNYTQTUFFStUMtTH6Df00Qrfjn+DIGQ0Gp2eee
	0KnvsAlIhS6fW1lES114nL/w1sUcOCjVApzQhGrT8H9iciRXVnEpCwelJztZ8Fg7PiyT+GeMSm9
	ZhmgqBhKBmxJIiPK9A3htZ9zeORI=
X-Google-Smtp-Source: AGHT+IGtMp8ZtlsR3MqgVu4oeaLSMMrTWNfK7NbhK9ChdfFTLDrhXhTLCy1N7hqiyVk/iWXfsT/qdmUycrDCpyhrcR4=
X-Received: by 2002:a17:90b:3010:b0:2c2:df58:bb8c with SMTP id
 98e67ed59e1d1-2cf237d7696mr1544196a91.18.1721868324405; Wed, 24 Jul 2024
 17:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721713597.git.tony.ambardar@gmail.com> <CAEf4BzYaOVDitzcY+j=vpAqeNC+KZXk9pcTVht=npCmnPpoKmQ@mail.gmail.com>
 <ZqGcRGTo8xQxZy4r@kodidev-ubuntu>
In-Reply-To: <ZqGcRGTo8xQxZy4r@kodidev-ubuntu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jul 2024 17:45:12 -0700
Message-ID: <CAEf4BzZhdidsqawhkv2ich=dKLAajt6ft7Nrt0apUc3S9XcSGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/19] selftests/bpf: Improve libc portability
 / musl support (part 1)
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Yucong Sun <sunyucong@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.co.jp>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	David Vernet <void@manifault.com>, Carlos Neira <cneirabustos@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Yan Zhai <yan@cloudflare.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	YiFei Zhu <zhuyifei@google.com>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 5:28=E2=80=AFPM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> Hi Andrii,
>
> On Wed, Jul 24, 2024 at 04:52:57PM -0700, Andrii Nakryiko wrote:
> > On Mon, Jul 22, 2024 at 10:55=E2=80=AFPM Tony Ambardar <tony.ambardar@g=
mail.com> wrote:
> [...]
> > >
> > > Tony Ambardar (19):
> > >   selftests/bpf: Use pid_t consistently in test_progs.c
> > >   selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
> > >   selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl
> > >     libc
> > >   selftests/bpf: Drop unneeded include in unpriv_helpers.c
> > >   selftests/bpf: Drop unneeded include in sk_lookup.c
> > >   selftests/bpf: Drop unneeded include in flow_dissector.c
> >
> > I squashed the above three patches into one, as they are the same kind
> > of fix with the same reasoning. The rest at least have a specific
> > error example, so I didn't touch them.
> >
> > But generally speaking, I think it's fair to combine the same kind of
> > fixes across a few files (for the future).
>
> Thanks for clarifying this and reviewing. My concern earlier was that
> squashing "Fixes:" tags could hinder backporting. Is that a non-issue?
>

The fixes are small, so probably not. It's also fixes for selftests,
so I'm not even sure how much that matters (for backporting).

> > Applied to bpf-next, thanks.
> >
>
> And thanks to Geliang Tang, YiFei Zhu, and Vadim Fedorenko for their
> feedback.
>
> Cheers,
> Tony Ambardar
>
> [...]

