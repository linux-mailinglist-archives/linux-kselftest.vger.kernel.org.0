Return-Path: <linux-kselftest+bounces-44472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B903DC22F38
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9D23A4D85
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 02:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029D26ED51;
	Fri, 31 Oct 2025 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQCZiZa9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B22726ED3D
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761876744; cv=none; b=D8LogFwYz8/kklsDhVRRsXmrkuVg/uw+ZhEiibKY4cvC1gX6YGYH7/XcvS1GOYHoNgfousJ3j+QwuEX3FhyhMozoMX43LNMNLrkBGpHFqkMZ1Ro1hrLP/AOVMb/qgSShfZnQ02epzABFpYVpuSAhf0QBQrv+mj7JE0Jyw3bjzkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761876744; c=relaxed/simple;
	bh=2GBCKfmPbb6f5HmaLcUbmF6GHEIkAK69+2Ehy+CjHms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw+psQmQjcOAsmbtXhQMrq7fy4MRgQsHed88t6ZSwLDTnXXcUZ7WKY45O7lO25euOPJWHR20k5GVwZ0bXWzIny6K0YvJh30TdKsV1HE1AkOr7BXMr4CxXBdfwpIyWR0lfK7W7iJkv15Dc/I3cr+Pww58z6Jvs/oQyn3AaorvXrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQCZiZa9; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-63e1e1bf882so1776449d50.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 19:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761876742; x=1762481542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GBCKfmPbb6f5HmaLcUbmF6GHEIkAK69+2Ehy+CjHms=;
        b=VQCZiZa9BmQZw4l0gHiGxB9Dn8+nmLEMg/UBBFPqe+z2TwgvXoxrCzy56gJxZTjl2X
         GfkGayh3dLu8TRL/uCJ9FeZSEXE4MWDWKTP1Rhoxn0K/MgDTMZ6drdU1dzsZPilB3Dqz
         tC70VdezTklD4t9hGyEgBLYbYIEChWyVpfIyTtRXssnY/q8u/6B8aQzWfbV26cVw/oFw
         3ZB3gRaA0Dt8zkFSvmHJfITkrxPQ3ygdDpI9ukpD3Aek3cMconGO24Q3zJCH6i6LgY3S
         2fQewxRg/FCgI1aVtZ9wRHW5cWcrkVCQZYePQXrfscUzxht6Qb0WoXVdFXUB9amQI2T2
         ATMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761876742; x=1762481542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GBCKfmPbb6f5HmaLcUbmF6GHEIkAK69+2Ehy+CjHms=;
        b=YvOVjkOcjMNWkQaz+jnekdA09x0oKk6nRrf9UQdgGIxGil1vvxYRdApm7Dag3dD/VZ
         8nkkp0L47TJYQHQQ2wd8wIyWdVy3NH9eBISqQcKODzXh9Dp+WMiyPKPlkPMgmWQFHd0i
         7jTdrG5R4B73uPrHNsR9wmphYjUDZetyzc0gC39jhlSKVFoNCL8hXV3MsDnAhiD+FEze
         HQ5Mmb3E2eVIoC4riMdhpj5V2baTOlDXMY/+vDe7Z+VB7tic+9dc6nNKn4HQ6A6JWifJ
         5ERS0dDt0nnDGIoOX4vgzRUFvKe0Ru+axWREuaoVDBq7vgHsvMoMT73+ohE98A14sQZu
         nePQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6N9Kb9+D3LkR3WGc5lQMgw6NWDR93VF+aY5EBygQr9S4EJGrLzuBYRPqgPuftn7KsVte7ngtD0CsmaZ8MPJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbuwi1hYwMH809VIqHylOszaFE0vjIX2lwiyHub5Cfi2d544KP
	eYJLj8GmJPmVD7vwu8KHK/Lx+lVKAMTVBuT13Bq6RMar1aCTDWSiSjXS9EBHoTr7RxXPH1F4L/N
	N+7ZP56N0aFMMMUs1b1csPsuT86Qm1KM=
X-Gm-Gg: ASbGncsO621gogzA6WxPMFo+xvBMvIUkpexD/D8HlJGmLmJe7gITqHwoNG0u+775ujk
	iRhn46vwlyw9P57+BOWnRaLifQJJLkfWceH6qCxvWQmH6b+82kailjrKPJQgvNxSNnlc23yHhoh
	K17wYV9DYnKEB+NZWJtSu8ZPZEsH0+enWQygAF15seajMJ+aVmw0C0XOWEx5q+3lGJYWEM1Myis
	WByppqM8ft/ApVEhfzktxWsvVf8NlSNKvXzQT1OXZByA24pk7WrnSg/pDvkIS+6oSe+GvjXjYg=
X-Google-Smtp-Source: AGHT+IHffQl5FgjKvOXwHef4yLh5FMM4Q7oG4aR1q1KRlnUUxJxGdE24Yn0jM6kh+TLFx5oNundQdSjBtNpFtJef46Q=
X-Received: by 2002:a05:690c:4445:b0:786:1e02:6349 with SMTP id
 00721157ae682-786484df95cmr24640587b3.34.1761876742095; Thu, 30 Oct 2025
 19:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030030010.95352-2-dongml2@chinatelecom.cn>
 <18b6f2c755710330b0c7399d17606a46c977f1ba3de4f37319aa1783638b1d2f@mail.kernel.org>
 <CAADnVQKaUqRMvbno2RKo+kfK98377hkUjxSGMBV5qzgHOvkoMg@mail.gmail.com>
In-Reply-To: <CAADnVQKaUqRMvbno2RKo+kfK98377hkUjxSGMBV5qzgHOvkoMg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 31 Oct 2025 10:12:11 +0800
X-Gm-Features: AWmQ_bnu-O704DO6Gm4dvbLW5guR5dtS4wS151DdVv8ip72tAF7lJj_Ztcg7Bxg
Message-ID: <CADxym3aLA=p1Brea_+BPcKS8swHm2fwNrAM54Ag2UOrG_njDEQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: use rqspinlock for lru map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Leon Hwang <leon.hwang@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, jiang.biao@linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Chris Mason <clm@meta.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 6:38=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 29, 2025 at 8:38=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >
[......]
>
> AI is right. Here and in other places you can just leak the objects.
> res_spin_lock() is not a drop-in replacement.
> The whole thing needs to be thought through.

Yeah, I see. I'll analyse how to handle the "return" path.

Thanks!
Menglong Dong

