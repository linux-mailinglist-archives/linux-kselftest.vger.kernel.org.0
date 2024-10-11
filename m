Return-Path: <linux-kselftest+bounces-19487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C27439997EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 02:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900551C24F56
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 00:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10DF198822;
	Fri, 11 Oct 2024 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eabn3HjJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9103FE4
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Oct 2024 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606202; cv=none; b=upaHUt8f5432N9PY38FMqIm7gzFKKMphRpURSVetzn5kOhdigI9pDypX3UZ8aMuoEu04yHQlLfXWI9Ur4aB+a5UNwLkXnQ7dJQcqkz7cEyW92VDvaLjx6FRyr7wEuQhzfsMQhyg31bcyCzKxHnKaUoJWRzZq+IXj7wTRCaqW45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606202; c=relaxed/simple;
	bh=IdU0NaITwVmuazq/pnPGvgKsS/eq1DvtYLNflhg9uP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtEm9UKGroobIbPBvJnlXfjuxwi8VnkbjZSmuSdoyUYbvyASqSsc/d5Mf2cl3knYa3MiB7YyuIZu4JpStQ1YEKdVszq3gNZ+TGFZXhnDhzaytzPYm2NVCEXtH+8Iepo6nSLt8+n3lH0MSGEhZm25ZFt2CCDUbU362U3Q02EDWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eabn3HjJ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-26456710cfdso145774fac.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 17:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728606199; x=1729210999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVGdgRMRF72j9LkSnHZOZlGd3on28rqlWSf6lpgKKqM=;
        b=Eabn3HjJsGByZktmfwlcsO/ZN51+EgTXxF+GDyS/pwXx/9Kh9q3HC0FE0y98+L8a48
         ZGdUYIB3LkG157e+rezSvZ5mTwKmA1qzTMOukLXXQRvWV1JZoGTofz8DQsraKOvT18+v
         P1o3dzu/UnkyVkhHSuXhkJh0152QP6Lllde/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606199; x=1729210999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVGdgRMRF72j9LkSnHZOZlGd3on28rqlWSf6lpgKKqM=;
        b=ZIKrSf7WnP0PpUhhUiwb8XGKEwkSePLzgFM+KvnATOUMq+4ggRjdQybzawB0vkYCSL
         dtC5t1R/HB+FWkF5M29+J6YPMrHUNSBwXbgbF2vtxeBTZHlxLYG7hk5L7ZtERpA6dvE1
         YsgrsL2MhP6Vjp2/12Wt2bm4x8bjL07l9lCIvrew+8ZuxZaQocml00LbiZaS1Dk5pvPL
         dODflNY0u/wPIKM02EHonM4hW1swYBEk2fp/L/3KInq4Smnv6CMXMAoRZoaM8lcCCAqR
         dinECFezFGQb4172ioOr2/OEDrMdkvXhlVvgVAVjTQGyHvpb35DbEM9h+DgYKObXHEqo
         XWTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAxPFVyrrD1HBE9IsbR5xXcm1KCApkRtqJRyA6A6ca3zYukjhCtv8E4Ni/XaLIIc0a/F+FDFQ0BHOAZk3aw/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsV5Cf/Cm9YO/IsOanPTMF6j56GsH3dB3WvT/wPZWUsAc7ub9r
	V8FBX/x330HKhAki8wO0nvEJJYw4Pq7Ft8vRGs9LOWabPgNsXRPqzQjkfQ531OzsaTJGBrMZb1X
	kK5OnKSe+10Fzut9Tq4DLd0mhfZNUvcZ14IOu
X-Google-Smtp-Source: AGHT+IFT9pJJLCUSM/YLQyqqRxIfC3K7gw6udoC8IuTRrW138RcWE2mO/y2HCtMWqB0/IdaYqzd2MKMsfG/AmfyOKCo=
X-Received: by 2002:a05:6870:7252:b0:260:ccfd:1efe with SMTP id
 586e51a60fabf-2886ddd8c92mr182982fac.6.1728606199035; Thu, 10 Oct 2024
 17:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008040942.1478931-2-jeffxu@chromium.org> <20241008041804.1481453-1-jeffxu@chromium.org>
 <5e1ef8a0-f063-4166-9d93-cf047cdd2792@infradead.org>
In-Reply-To: <5e1ef8a0-f063-4166-9d93-cf047cdd2792@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 10 Oct 2024 17:23:06 -0700
Message-ID: <CABi2SkXecdseZBeEJOeP8boP7aEAf815-1H6eMHDy=a4d1oXMg@mail.gmail.com>
Subject: Re: [PATCH] mseal.rst additional fix
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, corbet@lwn.net, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, 
	merimus@google.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 9:37=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 10/7/24 9:18 PM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Change "overwrite" to overwrites"
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/userspace-api/mseal.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/user=
space-api/mseal.rst
> > index 41102f74c5e2..54bbcce330ec 100644
> > --- a/Documentation/userspace-api/mseal.rst
> > +++ b/Documentation/userspace-api/mseal.rst
> > @@ -97,7 +97,7 @@ Blocked mm syscall for sealed mapping
> >     The first set of syscalls to block is munmap, mremap, mmap. They ca=
n
> >     either leave an empty space in the address space, therefore allowin=
g
> >     replacement with a new mapping with new set of attributes, or can
> > -   overwrite the existing mapping with another mapping.
> > +   overwrites the existing mapping with another mapping.
>
> No, that one is correct as is.
>
Ah, yes. Please ignore this additional patch.

> >
> >     mprotect and pkey_mprotect are blocked because they changes the
> >     protection bits (RWX) of the mapping.
>
> --
> ~Randy

