Return-Path: <linux-kselftest+bounces-44148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE601C11ED1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0293AEABE
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 23:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F45328312F;
	Mon, 27 Oct 2025 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psMW4bpZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3B155326
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606130; cv=none; b=G3Do+42kaXkagHppcO7zTaHtm9gOmNzNb3RLt7pc6yKYe9GRac3l3Ck1mWgq8jLLBkcVBEOOMPMoB4U58nkczbrq2u0GC/fgg/9Bc5jxrhfmt1qxZOctK+CGxsAphicT7VbFZ1UKb0cOZt0voNiHXz0tpZoNYLg8AWDF0Q7eXls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606130; c=relaxed/simple;
	bh=xcuVr/XJUPvW7oJnUWQelTHjgQSkL9RaZe/Yc8fW13g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKnp47mxq1jNa/vFLiXceG4uOzfx0FDClw+xzqmjFrrQXjumrSUJePnQgHPmKFf0HcMLW9gchUAJO37EuUp3fgAZQxtscia2pDb/FShSrFkTTdjbQ2CfRNlawYSF1uOyyT+LlfZa1wiNj7wTjfqGmIeO+C9q22rDdDcHT9nSCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psMW4bpZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so6247039e87.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761606126; x=1762210926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDZ/TlV/FeucZp/wZRQgeCBquQKMH6KaEcJwGGGd3/E=;
        b=psMW4bpZGMhtee5+lUxfVRnwyLy2mQ6KJTt9JTwCWZMgqKoa1w8nnUiX6OFpsiTL4m
         wRzCZ9wdFJ75NVGvE20+ZBf1dr+Y2MENyPvBbOhittyBfW8mkcP4VIB3KylKHL/TA8+K
         siNzM/ujOcaX7+M7cUV7vu55egYT3hLqPooBttluepSQ+kBdiesm3iQo8VqsvWDoY5xJ
         QnH30ok2rkdHHJNrfSdWLqHbeBNlVe0U0CoaHSrx9qP5+rGT6WB9UVuPVu0+U2UZwC72
         K96+6A7ts/KkG9D0q7UerhZFm+x+DX0rFXkzlXWGkRiDYtB/NfCa9V2PqH9U+CUF92Kn
         VCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761606126; x=1762210926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDZ/TlV/FeucZp/wZRQgeCBquQKMH6KaEcJwGGGd3/E=;
        b=TQW53EwI7cH9aoBt759nL9dmhtmcHrFwqdZ9hSzmuXo5BkddKjv8YSNTUyC8mv5TSC
         Zo90KAsEJ/603aHqJRYqgCshQcDZHU+m/hbW3vD1rTnpB7PuFZIlM4uTT2jw6lkxrh+w
         YetdJAzbypvL9K6BUxrbGVPDX5lbu15NKGVbr7+udBFpap4bbeZVRaDZQtcHQbGCeOoa
         9UUnA4RGrcjGaN+1W+ptx6FJkOjLEEEJ0gz7xXWPA+wXT8ASORmpRzMSZFdw55lx5N1p
         aIAYNshveL+ElyIZjnDaX6EVRpXWbzQwFNRtxZLdRag0HAzl84PMRMEQu1+xXQT9gDcv
         vWEA==
X-Forwarded-Encrypted: i=1; AJvYcCXaYRqj3KHkORpe5mneWBstpN/r1OGKEzp0cSDrhI7c0bECdZjrtosLLIBifjpI68rvXgwf+RlXmD2VHmYpeKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzf3b96/6OPxnSHwQcCZky98cRjQPBLCC7uRujJdv9mrX7r3u
	zL36OoceWPT35GhFlUZ6IrDa1ZNzjAszj519fxnpdc7POHdA8QO6Clx+bENDTUpafUZLrXGRIi5
	SCZ9CF9NCT3th9OnqcPaGWDN3K11ORO50r6frabwl2hO/YBE2QWr62/3/
X-Gm-Gg: ASbGncuxmP86wrI5s+xLEkPmWm+4tQOXLP0eUvCdGyTld4dl6Yx9XcRkOt8r/zlwYg2
	lcQzlh/ZIEgbYPvqx/c8O/9t6FFWcVw1uQjL2La66l9Mop1HUONvpZnI5m2eyOnYEtVj5XfVVN9
	RPwmYHC56t0jssGTqMdtjlo3fOZqADHqAjzQVecFDJIPCV30n9+Gkqbn2ozA/ELF1HDpHSW6cHd
	kZ+3M4yBzhe9WJlCI87lxaJ3qo9LIKswRO7shamtiOyVG5cipIlUcSYB1SftG+SSnepgstupnex
	grgYhw==
X-Google-Smtp-Source: AGHT+IH5GGO/QRS3unyVKP+J5rFOnjCyksUkPYUrD/2ThqVKsfIz142MePftEnso0rQ9MPp9qjMcov5TDkuNjuvVb9A=
X-Received: by 2002:a05:6512:350c:b0:593:f7d:31ae with SMTP id
 2adb3069b0e04-5930f7d328bmr191178e87.13.1761606126061; Mon, 27 Oct 2025
 16:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-3-pasha.tatashin@soleen.com> <CALzav=fmTVGDxAUcuqmcegAtd8gEW4F3Zp3AGMQBtXrCQgp+aA@mail.gmail.com>
In-Reply-To: <CALzav=fmTVGDxAUcuqmcegAtd8gEW4F3Zp3AGMQBtXrCQgp+aA@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 16:01:37 -0700
X-Gm-Features: AWmQ_bksoC09_xtubL3fsrVqg9KgYMffT0YmnVbt95BNOWTR3CmBaoOZ230HE-I
Message-ID: <CALzav=fD47OCZRMNqDmHs798qpZzeU6eHHuNA+wyhmZ19aJ9vA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 3:56=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
>
> > -static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, =
size_t sz)
> > +static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
> >  {
> >         void *res =3D xa_load(xa, index);
> >
> >         if (res)
> >                 return res;
> >
> > -       void *elm __free(kfree) =3D kzalloc(sz, GFP_KERNEL);
> > +       void *elm __free(kfree) =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
> >
> >         if (!elm)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
> > +       if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), PAGE_SIZE)))
> >                 return ERR_PTR(-EINVAL);
>
> Reading xa_load_or_alloc() is a bit confusing now.
>
> It seems very generic (returns a void *) but now hard-codes a size
> (PAGE_SIZE). You have to look at the caller to see it is allocating
> for a struct kho_mem_phys_bits, and then at the definition of struct
> kho_mem_phys_bits to see the static_assert() that this struct is
> always PAGE_SIZE.
>
> I would either keep letting the caller passing in size (if you think
> this code is going to be re-used) or just commit to making
> xa_load_or_alloc() specific to kho_mem_phys_bits. e.g. Change the
> return type to struct kho_mem_phys_bits * and use sizeof() instead of
> PAGE_SIZE.

I see that you replace kzalloc() with get_zeroed_page() in the next
patch. So the latter option is probably better, and maybe move static
assert down here and use BUILD_BUG_ON()? That way readers can easily
see that we are allocating for struct kho_mem_phys_bits *and* that
that struct is guaranteed to be PAGE_SIZE'd.

