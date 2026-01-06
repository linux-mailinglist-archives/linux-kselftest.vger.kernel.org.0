Return-Path: <linux-kselftest+bounces-48339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE7CFA1D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 19:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEA5F302015E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43409366545;
	Tue,  6 Jan 2026 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfG8s8+t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF7364EBF
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723950; cv=none; b=dVUYPuDX/h46ZK7yYbPDQu3L+ZRNg72YTCZchbFko9jv+6dhlLP1Ix3PL1ga4X4DyuY6q/ShbODnA1Dk1ELBAoeI71y3k5wiRn+BwUeqNqY2OYSYLRGFHspn9fulZPlqHi9BcarpgNo1U8ADE56OpuBtmtoE8TLq//3MW6gHiws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723950; c=relaxed/simple;
	bh=4/uoYwkQGGTtpzX8u/eo6P+kwZj4cFQPvTLf1lRyWpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGtiVJPpxe9XXxK/K0s+Ch/zfVKMZkgOCcKoVmAjUr91+7aKg8DR8+Bb1OHPh9aOKQh+bvwkbFT4FDVTz5bgX82NkpKXO4Yy/7z5JzIrFz4a8ztN5yUJ2UWSzfYaKepC2SjLMiO+8i4VMHW5tsAVEqA7DQ6gpMM2OblmxodFFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfG8s8+t; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so638966f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 10:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767723947; x=1768328747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AoW3ejQJ9eJjCHqIfu+Ch/7dBIUphGUj0Go0KFZrfM=;
        b=DfG8s8+tadcL4jRIo/J0HtPnNGyrbsa2sDc8TZ93u+c0UQEbolmmt/zfQQZwxU2ilz
         jsF3QysM8ChrgxrHkl+fYTjVpqTrQJoQegvNajGXOVS8d071ho4vzUqIw3qoTsp7/EKd
         Uo6vxiRCoYD69EUESADbGPWXUeXHJLgcctzp8ZZeaPxXm3cfzIKvvA0tBv6lxLuKI/aD
         El8l/VDbIkvpEm/QU+oOBNSM3EUsbApmjDvqkm+jsJscvKqmmeiHlX8n2BA/WoE4NVSG
         GUQcH7el3obAojQ8EG//K+EkOuYXUlOPAtylwG+o7hR2qrJpiRaKrDmYprBZqKCUu08I
         HkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767723947; x=1768328747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8AoW3ejQJ9eJjCHqIfu+Ch/7dBIUphGUj0Go0KFZrfM=;
        b=Q8uPUkyy1jLqFQaWfOim0XbrlaDo1zXO9+dBfdLng83AUhBTdwNyJeQPIiksZxPAfP
         ltqaEFcqy2vQXqePbh5LExRV7zYb6BETyErnK1ereZu8bjtLUnzsdhvrVcDSqy9Tg4R3
         1ZPdJp/bVATpQEZAgCX1BuR+0Q8RMHcWOS/IndsiECNsLOsmUQepm/z1cSUhH1jMSUoD
         yqETSm/OYf15N9RJIpSgGOJ7230uj+EoXolriXDcFdm6MgpahGXhpAHnGWl1g71ogUjU
         ksBHY8q2qKr1xi1Oi/OXTjBUlXiIm6Lu2D1RQt18BPfuD8RDi/R0GfOdyiegmOKK6Y4Y
         Alrg==
X-Forwarded-Encrypted: i=1; AJvYcCWPgsl5tibA8mnYdUW5he69PrPgiJUgKeAicCGr9BU1m0GLUSPHsXHNg4USQJjOCKnxrOo4BmVNPkNMGoloOgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzykGTH2Fn4B4NMlaAA7XFOQG2pjizWEYefEmhDnjhFQGy+vNE
	45DLyHdnbqD+cNRg8lgNUDUVVUrjt+SaTLsIbSSdrOqRG4jYrNYsCrZnZf4WIhHu5QdcSF+L/Ns
	GMKJHITWyO+YCxD5OlOc7cSAq2pVoVvA=
X-Gm-Gg: AY/fxX4DQqALgaaW7/dBVc0dKP8/Vu5vlyAjH0Bl7l7lH2h4OqvXyqhcokevtW3UK0z
	HCHLeYnnm5Om5vE/l6i/MGMa/sJzyQfbKGTsXajL1HknfRk3p3pnyuHvZykPpRsPlDmfSl5HYzH
	j+Z6LpxpmkVUPIVhbFoSExQ1uGGYLfEsLxLN+L2l22IbcudGzdjGYKc1ErJ49wpzJvZX58OKSaS
	ehnN8Gv3MhoWZ7KGlCkn2CYeDSAJSawtACutpSAPuAY0S7vNjFUzEEiXUuYLECq6NqZPqISVUDk
	GMX2gJx5pjI=
X-Google-Smtp-Source: AGHT+IGsGnfJfAF5gkbuaYurEsk4m0EVmraVoF9eJkmzNVjRcPqqWh0CPN/0EqZ+853//q0ziJrMzLBUR+RerHVtZoI=
X-Received: by 2002:a05:6000:1862:b0:431:8ff:206b with SMTP id
 ffacd0b85a97d-432c3628095mr123323f8f.2.1767723946574; Tue, 06 Jan 2026
 10:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126145039.15715-1-leon.hwang@linux.dev>
In-Reply-To: <20251126145039.15715-1-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 Jan 2026 10:25:33 -0800
X-Gm-Features: AQt7F2pJ_Liu0LKeNcvMVLFvGCOlEacrr7yy9EMutoWB-gdLesv_S3yuLaz6VF4
Message-ID: <CAADnVQLisw1HFdDKWvSyWGdpVE1wSUdUBB=5aE7srHjsLNELPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 0/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags for percpu maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Tobias Klauser <tklauser@distanz.ch>, kernel-patches-bot@fb.com, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 6:51=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch set introduces the BPF_F_CPU and BPF_F_ALL_CPUS flags for
> percpu maps, as the requirement of BPF_F_ALL_CPUS flag for percpu_array
> maps was discussed in the thread of
> "[PATCH bpf-next v3 0/4] bpf: Introduce global percpu data"[1].
>
> The goal of BPF_F_ALL_CPUS flag is to reduce data caching overhead in lig=
ht
> skeletons by allowing a single value to be reused to update values across=
 all
> CPUs. This avoids the M:N problem where M cached values are used to updat=
e a
> map on N CPUs kernel.
>
> The BPF_F_CPU flag is accompanied by *flags*-embedded cpu info, which
> specifies the target CPU for the operation:
>
> * For lookup operations: the flag field alongside cpu info enable queryin=
g
>   a value on the specified CPU.
> * For update operations: the flag field alongside cpu info enable
>   updating value for specified CPU.
>
> Links:
> [1] https://lore.kernel.org/bpf/20250526162146.24429-1-leon.hwang@linux.d=
ev/
>
> Changes:
> v11 -> v12:
> * Dropped the v11 changes.
> * Stabilized the lru_percpu_hash map test by keeping an extra spare entry=
,
>   which can be used temporarily during updates to avoid unintended LRU
>   evictions.

Please rebase and resend.
This set got lost during holidays.

