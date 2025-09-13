Return-Path: <linux-kselftest+bounces-41436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FA6B55AB5
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 02:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B43566BFF
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Sep 2025 00:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC28BFBF0;
	Sat, 13 Sep 2025 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yL32FsNx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1D29CE1
	for <linux-kselftest@vger.kernel.org>; Sat, 13 Sep 2025 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723571; cv=none; b=ZSQcBCXNCKW3Q5TkhZ62+6xJVzhY8pqb9dOtkLfwNjplHZ8lkHdKkypT5zVYoEEz9y8AJW2rAfTF7py2e7kS+a/UdgqGCfnru8oOhcxCiJpQ1ewSjaXYP1mJPzRuWWM+OhRdC7iS3d+hLIPYwUk8B5q4kyJqoiTsOClKrOb2SnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723571; c=relaxed/simple;
	bh=IT6MSLnpFHgFKYjMuFi70CbKYPgsH9aVuiAyxa9oN5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icBMUCfQC1aiJXj/BAIU9aNGw0APe7BNPbeuOWL3Hp2C+SBOCkUq6Ze/F70AQKlIGvtyNeYWqcUiN7+mpJCfDDf0EcFQT70/3uNwoNbR9g6IZUpccdpB7/kFcIWwFNvuraDoqiTREGG29o7PDBVSfOPJcEvgyF8tU7CFb9/q3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yL32FsNx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24b2d018f92so42905ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 17:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757723569; x=1758328369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPwE7Pme5w6u5U8aFVe8q7Weh+CgFUkRYwar8edwhNk=;
        b=yL32FsNxuFUdMw9k4d3pEDlTXrWRrPS4QdM2S7A9MRS4WqkOQCfJN1PlmT5S5uTsUM
         gJhsiSaCVnHDzfbvG/PThD68ePeRmiu87WfWGchXzLXKFjjC5CMZ4+wMf6Hpjrb7ztw4
         6DK6O5T/GR3Nn9uh+oir3B0cuNJHn0xj2mMX6To/hgKDcVCwa7S59saoOgRKQBGBabkc
         Z/HpyB5q3anRJOVr4p2lXhJbkteSujGA+uzc5xtqdFDCJifd9iPyEPxDJeALM9dPIyhn
         Qr60gTqp7t0f1NeXGTlpkpBIy4KgkkTI4gaKIfBUgJPaWLwcLOTNe++uZKnp3zglrVcD
         QsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757723569; x=1758328369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPwE7Pme5w6u5U8aFVe8q7Weh+CgFUkRYwar8edwhNk=;
        b=rg2pSwbC/LjUwEnZR3Qy60FqkBY5oCTYSQEEG+JdriIccGB3fJleCmOBvxUtSVl/Tz
         S2eTvYLU7oQXAd4Wb1+20+IyNCL5i74ix9rxB4sMhGZgHN8XBnFjrEvWxyjp8h48gfZB
         Oqrt1MX0ldyjMaiwj/+iuY1jaJe/frWoQ8Pn934V9HwEwjUBd7nSBHg8ZiKMsqaWX6z8
         n3yrNEMApItrTxlqlmV7tNNxiFW+XodAn333nEmzA7h5rxRQs/1WxI7zAWmEmLDeNzX8
         9FwRzDE8G22/I3SQPU733nbaZhkuYomV+6KqFuIuUJei+A92y0P3BWApr85+ySmvNAKI
         R7/w==
X-Forwarded-Encrypted: i=1; AJvYcCXHqtYLLg4zLi5qTR0+SLq06SpqoOBRw8Y92KYMqfVtPH8GmyohTRuR9wIS9Slgxjsk5Shp5CJEESrWclfVxJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBAmzTNYiKxQ9846mQ3CuWPWEElfN9t+qXXmb7V5XUGmmVszow
	ARJlRjiN01Fm6UI/Flp1JHhUZea3/noM5ed+gl/lHKmmqEv+KMbSzzureyJMdwGJu7Gl9WuGfQh
	DUHUqVDurDpWS6pTKEiqzt/hu8O8KqGPAD4BzS82N/ROiOAB3ugMiCXcD
X-Gm-Gg: ASbGncvY/kMKNciRimufTbWyXpxkN0AssSv6gZi2fM8LwRjjaZZRUpoSUxQMqC4G/7E
	kHZLA8Jy53nR5+HKsguXZ1wudNRW7LKRb7Agotej7Amz4CKlfOU/6CfbOl3/fHuGSiBy2q1GtVB
	CqOw1d6aSZMeriBTbDrUw4Qjhfm0FOGGy2qt/inXL8aE8DVMPk+d3xLY4IGGCf5iR3HDW/CKgcP
	08LhQGRzfTJkpt9I6w2x6X0z4+oL6a889sEoPB/IBA6d6NdhUdQk6k=
X-Google-Smtp-Source: AGHT+IGyniyNvC+5dYajzXHs7b1Mzj6QmpCkTIBoREKn+Xp9wM0uMHekuGSQTf8LNSd1b9GQgUor0v1MNkX25vcyoi0=
X-Received: by 2002:a17:903:2343:b0:25b:fba3:afa7 with SMTP id
 d9443c01a7336-260e5f7673cmr1180545ad.10.1757723568813; Fri, 12 Sep 2025
 17:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902111951.58315-1-kalyazin@amazon.com> <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com> <CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com>
In-Reply-To: <CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 12 Sep 2025 17:32:36 -0700
X-Gm-Features: Ac12FXwAFGev-hCtU5uGjoLOuij4m50OSdUHMCxeiDSrTcweNfyyj3SZXIqeY0M
Message-ID: <CAGtprH_LF+F9q=wLGCp9bXNWhoVXH36q2o2YM-VbF1OT64Qcpg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: James Houghton <jthoughton@google.com>
Cc: kalyazin@amazon.com, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "michael.day@amd.com" <michael.day@amd.com>, 
	"david@redhat.com" <david@redhat.com>, "Roy, Patrick" <roypat@amazon.co.uk>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, 
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 3:35=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> > >> +
> > >> +       if (folio_test_uptodate(folio)) {
> > >> +               folio_unlock(folio);
> > >> +               folio_put(folio);
> > >> +               return -ENOSPC;
> > >
> > > Does it actually matter for the folio not to be uptodate? It seems
> > > unnecessarily restrictive not to be able to overwrite data if we're
> > > saying that this is only usable for unencrypted memory anyway.
> >
> > In the context of direct map removal [1] it does actually because when
> > we mark a folio as prepared, we remove it from the direct map making it
> > inaccessible to the way write() performs the copy.  It does not matter
> > if direct map removal isn't enabled though.  Do you think it should be
> > conditional?
>
> Oh, good point. It's simpler (both to implement and to describe) to
> disallow a second write() call in all cases (no matter if the direct
> map for the page has been removed or if the contents have been
> encrypted), so I'm all for leaving it unconditional like you have now.
> Thanks!

Are we deviating from the way read/write semantics work for the other
filesystems? I don't think other filesystems carry this restriction of
one-time-write only. Do we strictly need the differing semantics?
Maybe it would be simpler to not overload uptodate flag and just not
allow read/write if folio is not mapped in the direct map for non-conf
VMs (assuming there could be other ways to deduce that information).
Can there be users who want to populate the file ranges multiple times
as it seems more performant?

>
> >
> > [1]: https://lore.kernel.org/kvm/20250828093902.2719-1-roypat@amazon.co=
.uk
> >
> > >

