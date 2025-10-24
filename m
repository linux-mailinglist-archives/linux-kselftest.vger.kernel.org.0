Return-Path: <linux-kselftest+bounces-43975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352FBC06736
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C3A1C00F98
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A7231C580;
	Fri, 24 Oct 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="DcA2zw/o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9B22D7818
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311971; cv=none; b=G1bN4wONTbhH1Uzbs1BTxjy027gQC0uWUHPQ/9Y0rNGq9aKbFrdI7zf1HZeDEY77HJQlKIHFQc9lLYpFCH+2D4bYbHu6Vb19VnnpLzbPOb2SdIBAB2BEzE4V2JvAO6RwpcroBDbm39COMZMl6ZUzz4irvRapt4wLn28EmlW3uN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311971; c=relaxed/simple;
	bh=1SiLH2oZKrYr6G1LOocBI3A0/FbeTXAqtSKq+LfVhhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NN2nKOR/Joo3fib932dLYP7eRGUhmDKGAarzdGHH+IZLqBjr0OOg9YZJm9uykTKjrO55mF8Pa3MT5ox7bKC0bYaid4LM7J0mEf/XCetJhp2IqL7H393CXgwsEFtuZxDToKmRuasAFo9TE9GTepVWw1f2X5TKUzhtgPi4fdqtEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=DcA2zw/o; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso3357365a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761311968; x=1761916768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd+byjApNbKDhYg7oeVVpvm1SD1excSJlnJeo52Q0hI=;
        b=DcA2zw/ouS+76DnKbt9hL1fReglb8Fm3Ksi2YNAu5MzDx7sg2apAaRPUQpBubLGqpW
         Akb4Q6Y5pYwGSVhEt3fdkBqx4VpAyHkTQC5NIPaAjtvMfZo/LFnDiNB48EWFpPbKFdhU
         A64PVv7TCPN810x5ftUWwLziCN7BZUPSIhcCfI8nwQv+OI+D5kSWLDjIKKR67A+JBHii
         tW7siOXp0rZIYMIrKP1aUYahqKfnmwb+fvqwIvYeGyi5UIgTcC3d6QWumafOcNKlDAuz
         HUzndoLZxde+uH31X2A+WPSs4J8qjGUka9SlUUUGifzjDupQzLOuF0BT+z1+7GfcR5ap
         zRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761311968; x=1761916768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cd+byjApNbKDhYg7oeVVpvm1SD1excSJlnJeo52Q0hI=;
        b=tYLNmmFv6DnZmSosE19iR2R7+2iVUCHhIxXDskT/aBtooRzMlXYMlrcLojzrwRtODL
         yglX6TJyGSO/Fgu0hxes4CKscGQ7LjNfXsJ51U3TYEHkbkeLLddGsJSYbQFH2Covdmrp
         tB1YNn3t1m9EPwjsnNxdImQOMfkx8Rt46kHabX7Ux6xRp6J3xEA5RAz9pzOuP5lfSXMP
         GF24HGbJvKgqJ9tdiIKvSeLImM19iPBPYpumai055mj0ERbU9BnYIOBuQoG+rAReE9pt
         eXqwtjC2La74J4fGWYDJPQHOyHS64h0ZwyhI/Jv3zdbPiS1kMPVRExtTdJEl8DUofnT3
         d1zg==
X-Forwarded-Encrypted: i=1; AJvYcCWlbgaN9ZfgytpRqFIpPEAZkqFVLP0mlEhwvG31l0RhZiQpefArt8+aiizH4Y57xYy7HBpZVjkw8geRyDvF0hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuXUWQ7JkUiFu5xMLnQHw48aC1NozsGJEnq7WigawOVXaYvy5
	39NaC54qYhGpjygiHxa3dfmUKRpo+IrMVXthfHU3NmM/qa+7dbhAZMSQQZTM6T4Sn7DBPELzZ7d
	FaGBjkREAa6U9L+ps3MHwcL4pen4aHDlHBLbpG1CVtQ==
X-Gm-Gg: ASbGncuAE20cGua9AlkKNgCKITPf8EN0E3BZ/+TgpcIWlFZYVx3B9CPy2fezH9ZQxeT
	Kgan8Cchy34WKPRS4kk7JoNB2wtqlDLYgavpEW9PU7qhT9lPQZSvv+XwpSKXQjlpCdxllzDyiRQ
	z5scBWQEWZsQwp3IontmaXCBRQaP3Xt2j8Bz03T4ojnimvXsqlO1ajkzGtp7XS8EGz3iadUqM4f
	Sec9+gHOkKAU4VzE5cy762BeTV4cE4DtXgzuBR5zPLZjPkYHNHRF8Qdpw==
X-Google-Smtp-Source: AGHT+IHerXBAjE+eqb3d+VEJqly91GUZl7zoRvZTnmTC+7QMZhEDWBp0kb9IGewYF1+6lcIQ+kV8dBJajelZ0Tf7+s0=
X-Received: by 2002:a05:6402:1d49:b0:63c:43e6:16f7 with SMTP id
 4fb4d7f45d1cf-63c43e618d3mr26739268a12.26.1761311967869; Fri, 24 Oct 2025
 06:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-5-pasha.tatashin@soleen.com> <mafs0ecqvfazg.fsf@kernel.org>
In-Reply-To: <mafs0ecqvfazg.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 09:18:51 -0400
X-Gm-Features: AWmQ_bnYAH8dRV1ngHGEfK3HhlURkQgl2sSokzMwDTJAswcSitgikNMtMv1tkos
Message-ID: <CA+CK2bBA46PNuwDDa2pqNoLVN5vZq0nbfo3BnDwn7fXK1MFtdw@mail.gmail.com>
Subject: Re: [PATCHv7 4/7] kho: add interfaces to unpreserve folios and page ranges
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 7:10=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Tue, Oct 21 2025, Pasha Tatashin wrote:
>
> > Allow users of KHO to cancel the previous preservation by adding the
> > necessary interfaces to unpreserve folio and pages.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/kexec_handover.h | 12 +++++
> >  kernel/kexec_handover.c        | 85 ++++++++++++++++++++++++++++------
> >  2 files changed, 84 insertions(+), 13 deletions(-)
> >
> [...]
> >
> > +/**
> > + * kho_unpreserve_pages - unpreserve contiguous pages.
> > + * @page: first page in the list.
> > + * @nr_pages: number of pages.
> > + *
> > + * Instructs KHO to unpreserve @nr_pages contigious  pages starting fr=
om @page.
>
> s/contigious/contiguous. Also drop the extra space after it.
>
> > + * This call must exactly match a granularity at which memory was orig=
inally
> > + * preserved by kho_preserve_pages, call with the same @page and
> > + * @nr_pages). Unpreserving arbitrary sub-ranges of larger preserved b=
locks is
>
> Stray closing parenthesis here. Perhaps a rewording to: "This must be
> called with the same @page and @nr_pages as the corresponding
> kho_preserve_pages() call. Unpreserving arbitrary..."

Done.

>
> Other than this,
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thank you.

