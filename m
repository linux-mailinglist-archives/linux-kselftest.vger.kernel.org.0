Return-Path: <linux-kselftest+bounces-44005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD03FC073D0
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1FE188C6AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D4B271A9D;
	Fri, 24 Oct 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="AYhIiJNS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0041FC7C5
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322575; cv=none; b=tOemDjkXUkdfRNeC2OcsBNW7E3PUqd4suNCPk74GtWWj9W5A903UvKXSqk8nATkSGNOYizVttyyeFGiccyUdvO3XCaYrXO8n8qv20olHGv/p1n6/61SnPjUcR/zIOLtRN5MCDPy1oYUYUEY5vsmXcEmgoAZl3vfQsP7icHhKa8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322575; c=relaxed/simple;
	bh=5TtwmnLbDDTqvZTxESC4gxv7z3uy/Gk67LVww9+74lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oksYknHr3LKNAtntMUO2IQ8SQQ3ahcDBbZcCBP8JT7xN71L4LnFPh4ENHW+fhION99l74waNpOS0m8+YIL8ENXmCtUfjQ118SAr+/gdpsISl+RF6yiHc6uQt5DzV4QdDCurYsWZiumIw6xWvN9IlDqZF+JCjm8qDQ2d+uGQNdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=AYhIiJNS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-378d50162e0so27370551fa.2
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761322571; x=1761927371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hoXtHHA5k7qKtUM3YbUnyrHBlYIGcj0sn2V7B2w8uw=;
        b=AYhIiJNSgW9VfySWCqhv8vusgRNE0Xyz4rRuFPljaIV+rKixnuML7H56bpNKIod08N
         emvQHQGDdyQao6oi3K6/J+qxOOsHhJQKSUJ6ALrqJEWrgOGC+04KLQgRtJnw3nmhYIGV
         Xulx4f7CBwhhnGHF5QojhNtX478qnCBi5TSfxdNPHnoO/gFI7QWtzRXmJ2s2DT6+HYss
         El5pLH92HLYX1a1k7lGJNw0n6fCa1BSGfFDwn9JVe6Rhf5fLlXA8+TTI/rWQZRLwchkt
         bpmLCEQ3Qzcmew/86eCUyezpSSMg8Iz4y2OINNPbCDUcJ5AijJm7Q61b9DhHoWmXq8SL
         9ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322571; x=1761927371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hoXtHHA5k7qKtUM3YbUnyrHBlYIGcj0sn2V7B2w8uw=;
        b=USKO6iocqnbHGUAKsu29kkgnkmVMKNqhS2D/dG/dmESPZnJ9DQMz5zFJuYAuLVty80
         k/+aDaXUyp7iEOLwk8QWj8O2iDtBwcP9QWSuQiLBSEjnybAN5XaopZzF0n+qDxflMOMp
         Ef12G7BgvobW4fKjpu/T+sbOMm6gSewMeI+D78T3IM3nZhbgXHm1mQl7OcFKAWQknHsm
         YmKTcVWhmkZmps5ulP4Y0KM+9tvv+glgfODAitjcIi08JfqoNdUMP1xg/oStEtCjoO+Z
         j7kDXmhGXTLXFGYbP4ntmSRLcQA1rqrFUAQk10J1ZRi90AT2Wkr5lYxxqkQcerDvBpEB
         AEog==
X-Forwarded-Encrypted: i=1; AJvYcCWUOK9N1F1wcZaxY3TzT0bUJLUBjjMm+r90M0ZPBJ1V/kNSNi4v7UERHiU3Wlcsopgk0zmVSggYmEw5dFg2lDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjJw2wOZRvz0t14G0MeQsg96MyUaZChSZtS5wFF4jgGfJOOmM
	pKlftICOgB95IrGdo3cmZOgL4LkHhxAX/fk1v5hUSRGpYosWnc7nuMFCq7tt7IDSmqCE57glP1N
	ee68sq76zF2Bb7p6nIX9bJkgLmGXi5J6HR/finI62fpwnPQH1KT1I
X-Gm-Gg: ASbGncvG4Nc3y93mlbH7S54/4t244GcwnGBAGulwUoqWJSfjXuj7WCSHOHKNsq2Uqai
	OlvMcQXz+vDLUpOCytgqAkgwyvztsSKS0yCY412G595LXSDCLNEjSwX3816DLamkkoOqQ8/hvH+
	qO0o1P0imkh3L+xhud6HlubeYLA3ZFW9yIXiFPJIK28tkn9kdY/6cdhFPdZJlQ6/im3kuidwGJa
	lNJm/GMLtRVOGCvwpDn8VH2LxfJlnKIiGJt7Vafw7cEzta9DrnE6B9bL1oHD2kBRIna
X-Google-Smtp-Source: AGHT+IH8WOU0xbwl7Y+ksyd5jD9X6PhDLczYsD+A6K0t8J7OJdygB2+hIh+k9oSvOmjM4CFOKsep5og5GveG+1uLBEs=
X-Received: by 2002:a05:651c:12c7:b0:372:93dd:681a with SMTP id
 38308e7fff4ca-37797a744bfmr92216601fa.35.1761322570537; Fri, 24 Oct 2025
 09:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-4-pasha.tatashin@soleen.com> <mafs0ikg7fbez.fsf@kernel.org>
 <CA+CK2bDrrg0UoJXpeN+Au2-sreYrZ+DHVcEUidzPw2Qk60orgg@mail.gmail.com>
 <mafs0o6pwe1sy.fsf@kernel.org> <mafs0jz0ke1qd.fsf@kernel.org>
In-Reply-To: <mafs0jz0ke1qd.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 12:15:32 -0400
X-Gm-Features: AS18NWDS5bf4nRNM2qxXHaSonlVu1EPNEq3HBS0RPvYO5kiX8yMEO_3tWdOfdcs
Message-ID: <CA+CK2bB_xPAsHXU62Hd5iBt-+Jf2BiXQM4M-QEL=AA_Xu-APhg@mail.gmail.com>
Subject: Re: [PATCHv7 3/7] kho: drop notifiers
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:52=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Fri, Oct 24 2025, Pratyush Yadav wrote:
>
> > On Fri, Oct 24 2025, Pasha Tatashin wrote:
> >
> >>> > -int kho_add_subtree(struct kho_serialization *ser, const char *nam=
e, void *fdt)
> >>> > +int kho_add_subtree(const char *name, void *fdt)
> >>> >  {
> >>> > -     int err =3D 0;
> >>> > -     u64 phys =3D (u64)virt_to_phys(fdt);
> >>> > -     void *root =3D page_to_virt(ser->fdt);
> >>> > +     struct kho_sub_fdt *sub_fdt;
> >>> > +     int err;
> >>> >
> >>> > -     err |=3D fdt_begin_node(root, name);
> >>> > -     err |=3D fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys)=
);
> >>> > -     err |=3D fdt_end_node(root);
> >>> > +     sub_fdt =3D kmalloc(sizeof(*sub_fdt), GFP_KERNEL);
> >>> > +     if (!sub_fdt)
> >>> > +             return -ENOMEM;
> >>> >
> >>> > -     if (err)
> >>> > -             return err;
> >>> > +     INIT_LIST_HEAD(&sub_fdt->l);
> >>> > +     sub_fdt->name =3D name;
> >>> > +     sub_fdt->fdt =3D fdt;
> >>> >
> >>> > -     return kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
> >>> > +     mutex_lock(&kho_out.fdts_lock);
> >>> > +     list_add_tail(&sub_fdt->l, &kho_out.sub_fdts);
> >>> > +     err =3D kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false);
> >>>
> >>> I think you should remove sub_fdt from the list and kfree() it on err=
or
> >>> here. Otherwise we signal an error to the caller and they might free
> >>> sub_fdt->fdt, which will later result in a use-after-free at
> >>> __kho_finalize().
> >>
> >> I think, it is better to simply do:
> >> WARN_ON_ONCE(kho_debugfs_fdt_add(...));
> >> Now debugfs is optional, and there is no reason to return an error to
> >> a caller if kho_debugfs_fdt_add() fails
> >
> > Yeah, that works too.
>
> On a second thought, maybe pr_warn() instead of WARN_ON()? This isn't an
> assertion since the debugfs creation can fail for many reasons. It isn't
> expected to always succeed. So a full WARN_ON() splat seems overkill.

I sent it with WARN_ON_ONCE(), I can change it to pr_warn_once() if
there is another revision, otherwise we can just send a separate patch
to make the change it is not that important.

Pasha

>
> [...]
>
> --
> Regards,
> Pratyush Yadav

