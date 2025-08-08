Return-Path: <linux-kselftest+bounces-38605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B463B1ED20
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 18:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 548B64E0F74
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195B428750D;
	Fri,  8 Aug 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLVfNRp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D93627FB07;
	Fri,  8 Aug 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671390; cv=none; b=VPZ0iQYm70gdUPA94j8wPiX/NVGtUGQ3WNEczxt2F4n90hNKzd6zTmk1CGzY0pn+n2UTKLaz/3Obh/Wu3QMuc1NRqQWGdU38jqVtrtuVlgZQ9o2ePzLPvF5FQE7/z7deI/w5TFF4TW+CtMrropE4P5o5Y50HO++EbJ9aIiAiyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671390; c=relaxed/simple;
	bh=hBz7QODq6cwIwzLsI0Vrawc39RQX3Q+gtmpK3tbIgsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwEmbFDpdTejkK1H/nbjMylutDrK220EV3n/ApdhIdJN44b91q8uiPFdyr2KlJhbQ+VZHuL6skTcGwiUxPPjSI49BOGBNfgrBnDBZX5i9ptizs4YulDHJjdKXENpoyQh6PDShnBVp27cxr2H09bpqzqsFlOqBbLTiipaLEiR+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLVfNRp/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b780bdda21so1771263f8f.3;
        Fri, 08 Aug 2025 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754671387; x=1755276187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBz7QODq6cwIwzLsI0Vrawc39RQX3Q+gtmpK3tbIgsw=;
        b=eLVfNRp/0C0kMs4BB1G2sqSdSXnoKcLdY3Uh4h1+DVoGEfVY8hQ7YWj/QGfqiWhrlp
         teL3FFcCq3tNXl+qxHBpopgYyo6qfjoShBBeQlGkYgsqPgv0Y65O4jKlISgffacYvs4F
         2xIouW+0iO3VS/8Y/vBwMgezlvcLKwlvv7x0mcj0/kSVEgOF13QsK50gWRtsdGSmPFif
         O2fbTedUPGpskgapE408O0+ybt+m04MD+LN/iMf5n7MvIE6R83LvOBWz4AIHIkEmcC7O
         A3WlysVRKxWrAuOgSe/A37gvCZQfFqmZ410Jwg2YoWT1KaahP03yRNmW2xbkWDZEhSeq
         aVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754671387; x=1755276187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBz7QODq6cwIwzLsI0Vrawc39RQX3Q+gtmpK3tbIgsw=;
        b=flsbYclaPz/1K40iHQdYqMzhnQtlGilBn3nAgWE9Ixzoms+NvDkkJ5CDjfPYQ6aeLA
         eqhJ0ORUvTc6hkKzjfXCM7FCsg7JtSSdbf4LSIkUpzT3tWq3lIXc6iSFDg13GVwXa2Ef
         OvR1e9LjvDoYbRr4wbV9uYwUjYE87vE/VunkCUo1ya2lbqzkFaL40zDsDorUMt0hNf7d
         vtSoN1IrwvaI6ukAuKMId+KiE7Ne2LdRvQPRK3WzTG8W/BcUcenyF++xahNmTsE6FBKL
         HPg/vZt2/x+WvKLePey09H7/HUsZ0wTEbUZSUS0tdp86nF9rsilbivlgXDzXNLTimsJu
         a3eg==
X-Forwarded-Encrypted: i=1; AJvYcCULCQmyzcyOQrTjJUZdLa+yJ8b18BnzKncJCZxHiHUL6jZUqwKK2brhc3asKccgqCHr7H8rRExv@vger.kernel.org, AJvYcCUtp664MMVv0JmWuoeD3KU+3aQKyozIeqZlVT5o+pEMsZT8GQBetpyEUD2GRuco7vDvDKrDi9NRiv58m8c7@vger.kernel.org, AJvYcCVA7k9EuaCBEccShRO10wGFqWOjUZYAGpQeYRw7MQoBOMirtZAQdHTkXlkvbTqkUG+RJhk=@vger.kernel.org, AJvYcCW53DKtIBTf7PRLyWEFLuE7c8K3ORBRqZaZXwWQRSEzGtlY2XYh7aiCG24WwsKVfqlIXatkay9bQYDyAyb0VgNR@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPUd2lVM+V0lY9ViTK0pwGAfl6VqS7O+DRmb4ffWYmT5E1FLG
	x+byzohzCf47qUdjAYTg9W7LUT5PdKdbGbHNzK8s7f++9HdukCnmczfA6mEZxZrXEil4iYBznFB
	Sre9X+yu/ZHdkpjbJfGT7F9qyhdNtJkM=
X-Gm-Gg: ASbGncuCY7VlUQFHRiJ6FJIKZ5YDzxVgOvuVPUSru3AImIUadwP4jfRznjW5fSZSfBg
	ZrWuAeBGhgAE7QJjUuQ+6jvxT3OWENSOCkC3WYub0U/sg6deJ/9Qodc1ehQq0N2ozrr6Fjb5FV7
	SFWNeNLFbxUgdCQO1M/QK9wM1/ui2jDJiS5Y9BEZ7FvxTOUeGr8jGEObZ80QRxXolxliTzv7App
	mi1C9sFbW6itPZ/g6ULaweP4eCuKe+kPeMR
X-Google-Smtp-Source: AGHT+IEH7Bh5BxabsxIyC+T8pE/X/o2EhezxEecYjJXKK56oTvG/5namA7BuNEyyuFoXRZlLz4c3lWwM+Tolix0kpVI=
X-Received: by 2002:a05:6000:3104:b0:3b7:9dc1:74a5 with SMTP id
 ffacd0b85a97d-3b900b80561mr2646170f8f.52.1754671386463; Fri, 08 Aug 2025
 09:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722150152.1158205-1-matt@readmodwrite.com>
 <CAADnVQ+rLJwKVbhd6LyGxDQwGUfg9EANcA5wOpA3C3pjaLdRQw@mail.gmail.com>
 <CAENh_SS2R3aQByV_=WRCO=ZHknk_+pV7RhXA4qx5OGMBN1SnOA@mail.gmail.com>
 <CAADnVQLnicTicjJhH8gUJK+mpngg5rVoJuQGMiypwtmyC01ZOw@mail.gmail.com> <CAENh_SRxK56Xr1=4MX4GhZuc0GF4z5+Q8VueTK0LDLj3wg_zXg@mail.gmail.com>
In-Reply-To: <CAENh_SRxK56Xr1=4MX4GhZuc0GF4z5+Q8VueTK0LDLj3wg_zXg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Aug 2025 09:42:55 -0700
X-Gm-Features: Ac12FXzI0SWIjlbuRKix9JN42rScdnLLmM34XmBImN01moHmeqq6Q4_oGi5PqHM
Message-ID: <CAADnVQ+Q6qqz_kCibF6MGCOWAH4WH6XypYSCZjQzW7SP2yyodA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add LPM trie microbenchmarks
To: Matt Fleming <matt@readmodwrite.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 7:21=E2=80=AFAM Matt Fleming <matt@readmodwrite.com>=
 wrote:
>
> On Thu, Jul 31, 2025 at 5:41=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > well, random-key update when the map is full is also quite different fr=
om
> > random-key update when the map is empty.
> >
> > Instead doing an update from user space do timed ops:
> > 1 start with empty map, update (aka insert) all keys sequentially
> > 2 lookup all sequentially
> > 3 delete all sequentially
> > 4 update (aka insert) all sequentially
> > 5 lookup random
> > 6 update random
> > 7 delete all random
> >
> > The elapsed time for 1 and 4 should be exactly the same.
> > While all others might have differences,
> > but all can be compared to each other and reasoned about.
>
> Having both sequential and random access for the benchmarks is fine,
> but as far as I can tell the scheme you propose is not how the bpf
> bench framework is implemented.
>
> Plus, handing off a map between subtests is brittle and prone to
> error. What if I just want to investigate the sequential access update
> time? The cost of the most expensive op (probably delete) is going to
> dwarf all over timings making it difficult to separate them and this
> scheme is going to be susceptible to noise if I can't crank up the
> number of iterations without altering the number of entries in the
> map. Microbenchmarks mitigate noise/run-to-run variance by doing a
> single op over and over again.

The bench has to repeat the operation obviously.
The point is that it cannot benchmark 'delete' in isolation.
And it cannot benchmark 'update of empty aka insert' in isolation.
So some operations have to be paired and when another one
can be done standalone then the delta is the performance for the other.
In the above 2,5,6 are repeatable. The others need to be paired.

7 with pure random is probably not a good idea, since it will
try to delete some keys that were already deleted and will skew the numbers=
.

