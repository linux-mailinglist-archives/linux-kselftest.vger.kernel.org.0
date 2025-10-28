Return-Path: <linux-kselftest+bounces-44163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE310C12235
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 01:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9826B1887BC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A09191;
	Tue, 28 Oct 2025 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HqHpw3Ne"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E49A937
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609833; cv=none; b=khyJR05ZWSyXasxIje12RgRR6DVB27lEaOu1b6jowF64rt81wPkSNQD4w3gTUqIgkwdam5V0TKgMe4wq/AnXhErBOAiOITRLoHcbCWBbzMlctmHdA4Kt33Z5rEBjXYCZk8VEj8j0rlrdbILAAt6llxdX4fHwlGWKhtwpgK659wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609833; c=relaxed/simple;
	bh=1jYIhckYsIG0396E3JQfz5P20qWqblZQBv8T5hjwnTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPi84NzTBbhbNErinSOmg4zGmNKXNtJ9LzAkkVOd2gN6Fsu0DIoNq/iHsiVdx8PLFOwSE/nFHsYbnGkWEdtz7RPNx1CWQnJGHZ4b3G5h5DYP+6QnF1o3+ATwpS3C11+5PrI40BQ2cGyxiLlb348JMiGQTnckg9gzaLL3wJJhiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HqHpw3Ne; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c3d913b3bso9084555a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761609830; x=1762214630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIf9RmyxDj8h+YpH5/36r1Zq7AreK8JR3usDRLV8Ek4=;
        b=HqHpw3NelI2mCag9ovG6qv/Tch/ZpLZFtZ+rA0c2AE4Gy0MBYm6mIlyEJnPQX+/Xq+
         8Sej4sc6BgCBJ5okV6+ILBUd9wqlM6aDtUuZiAah5MHAdhLz0ap8xnxa1Ae5JGzhaFuH
         OkIQBDibHaiDm98C3cOf/dRezHZIRz5IY0D1aFRPswylD5QfysnZdc1qinRLeqQstvMQ
         Oywgff+g4QjL24B0GJQBfEMBJbZ1uqi9f4ecUDTdgIa3JYu4eqAIpcZDvyIQS/uV8swu
         loAZYA7FWwDN8PWptrALpYIhwlIOjeMad9NMK0FLQ+3CsWzVlf8h1A14xRPVYpzmtuaU
         22kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609830; x=1762214630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIf9RmyxDj8h+YpH5/36r1Zq7AreK8JR3usDRLV8Ek4=;
        b=sfW/Cr9dd4uuh+i+rO3UIajGWK50CSw7eew5FWrhp8Z77YQoY3nNN9S3DUBxGOxBgg
         UKpym8ymklCS1RlR72Z/n2uHXXqS66/UXD2s9YOrnvstsdxTyFRifQ/A312SR1BuX3s3
         nmZNKGYua7g1ZKlO0iqZzb5KvQ4gPl4rlTgw2fpygfxlAReYAafSCtY2l7JQMV4q2GKl
         1+4iSJC5JnyZoXv+uQMA2lML8v7Pe59C/pqqKHal+bjsKcuV3ThpD1rcwAtHJlUO5MZv
         M2mo1KTkv0OlmH7BpTbIWORKAdCe1Ce1ClCha6YJ4cBc1EvMyyJc5Qc2mAAYaLwfQxWl
         /s3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyfrc0zHkSXGU3yrHpuYTnvnQit07y0Xi0sth/4OclYu6qSa+HuJvpFT+6zzbVjB4PC5D6w4BzecMT80cX3Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBXw3edKS4VIxccR7+AgYfiygYL8Z3wM5Eg0ME2jhQpegp/X1l
	whIeLTiWRYlpbsayPejT3iN+0pfDxeHQ0XLPBCrWqMv0TJqyI/Pn/CtxZcfHnP03kaFJv2JHcbi
	91eIiEDl5tNbH0It/4VhHwlqlz2eN6ASYJPzQypZXXQ==
X-Gm-Gg: ASbGncvdK2RGUrmTEYB/HtJn5+//0HuRGSzCvSXB6s6iQvEB7rm6BGa87qef2swQZVv
	7QqY8+bcNzKhxNvatu/+hiC6Ib6eJyjjUgPkhxBr+HVESx7bCM7GKy2aBUvtyS6YVT96RWFdOt+
	fgfdW31DaB8+ssaUy0Z+INI/hVNkEt+2ngPa7BjSYpJKgM/jmM7t34JUjviMgvThZj33HfVWUQh
	l0qofb0vVi/HTUWs837J3MmX6KJC66n5AqyT1Tn2ljbFP606tMXZkUp6g==
X-Google-Smtp-Source: AGHT+IGRw73AgZE0pgL+h9bAcX5qxVKML+YkSwwVXL0+lNAI07sxHdi/1qytUtu817sC0wPtWFmC1YiZiNMsQzgmG+I=
X-Received: by 2002:a05:6402:4313:b0:639:dbe7:37b6 with SMTP id
 4fb4d7f45d1cf-63ed82669a3mr1767152a12.3.1761609830497; Mon, 27 Oct 2025
 17:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-3-pasha.tatashin@soleen.com> <CALzav=fmTVGDxAUcuqmcegAtd8gEW4F3Zp3AGMQBtXrCQgp+aA@mail.gmail.com>
 <CALzav=fD47OCZRMNqDmHs798qpZzeU6eHHuNA+wyhmZ19aJ9vA@mail.gmail.com>
In-Reply-To: <CALzav=fD47OCZRMNqDmHs798qpZzeU6eHHuNA+wyhmZ19aJ9vA@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 27 Oct 2025 20:03:13 -0400
X-Gm-Features: AWmQ_bmun6_TBMsODMO_7WW-_vSEWe2X4Vt2vU_u_Hwqc2ubbYZU9T3vQlpJuDM
Message-ID: <CA+CK2bAKjU8PmfuwGJwwOyj3U5bYaterE_KQa9uVu+mmmLmmew@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
To: David Matlack <dmatlack@google.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:02=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Mon, Oct 27, 2025 at 3:56=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> >
> > > -static void *xa_load_or_alloc(struct xarray *xa, unsigned long index=
, size_t sz)
> > > +static void *xa_load_or_alloc(struct xarray *xa, unsigned long index=
)
> > >  {
> > >         void *res =3D xa_load(xa, index);
> > >
> > >         if (res)
> > >                 return res;
> > >
> > > -       void *elm __free(kfree) =3D kzalloc(sz, GFP_KERNEL);
> > > +       void *elm __free(kfree) =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> > >
> > >         if (!elm)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
> > > +       if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), PAGE_SIZE)=
))
> > >                 return ERR_PTR(-EINVAL);
> >
> > Reading xa_load_or_alloc() is a bit confusing now.
> >
> > It seems very generic (returns a void *) but now hard-codes a size
> > (PAGE_SIZE). You have to look at the caller to see it is allocating
> > for a struct kho_mem_phys_bits, and then at the definition of struct
> > kho_mem_phys_bits to see the static_assert() that this struct is
> > always PAGE_SIZE.
> >
> > I would either keep letting the caller passing in size (if you think
> > this code is going to be re-used) or just commit to making
> > xa_load_or_alloc() specific to kho_mem_phys_bits. e.g. Change the
> > return type to struct kho_mem_phys_bits * and use sizeof() instead of
> > PAGE_SIZE.
>
> I see that you replace kzalloc() with get_zeroed_page() in the next
> patch. So the latter option is probably better, and maybe move static
> assert down here and use BUILD_BUG_ON()? That way readers can easily
> see that we are allocating for struct kho_mem_phys_bits *and* that
> that struct is guaranteed to be PAGE_SIZE'd.

The size is verified at build time via:
+static_assert(sizeof(struct kho_mem_phys_bits) =3D=3D PAGE_SIZE);

