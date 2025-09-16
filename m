Return-Path: <linux-kselftest+bounces-41550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752A8B58AD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 03:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF233B1F25
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A801AC88A;
	Tue, 16 Sep 2025 01:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXkVjG+7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB387E0E4
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 01:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984934; cv=none; b=SLQW/vZcn0XGA09zvhYOOdF/XocoZ3iuRpeUkALdObb/UFcOwAVzR7jOWHEUjz2xtGamJpGe1i01jESmolDKrSdfPyV0Al0EwV3vZ98SCBCDQWI/oAd6eXPzDzSTmkDbNgbIZxlT02tgXFYzgAKYXfABw7p/aAXQ5k7tllNIWCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984934; c=relaxed/simple;
	bh=RLxHq+ieXY28lD11U/kgpTTtUvpefKc4mYLbzO1KbPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZbL2GBVa+c2SXmzS6f3sdVWdwJJULiEY8cJ0BNLnOXs9h+QbvYxLV9UzRaDYuLqythpgs7Duyg/dyiiiXdSnLTAoaDvwTNFyWNjtPVhlLNBXcpyF+jPtXY+hBj0NuWh5B7unAeo1gMUhtfPMKQTYJzbmssFVUSc5WyHBuxxHV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXkVjG+7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-265f460ae7bso91915ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757984933; x=1758589733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPfnnggT2ndL938eIChQLKvTB/FFnYYq61IMlRsGnh4=;
        b=CXkVjG+7VFG7KXzSKSETiG/AIszysjhR8BMSC6qiRzSB1sSAQJRwguTe5+aww+l9FB
         GHCXRsHO+4wcrLRBH6mvY9QRQJIPsS66twhaxadhJu5zuD5oeC7vCyosU/Ha2aZsBJSj
         LMtFN6VBtgjCRUw4hY1g9XArn0zE0rzdR+C+ZciyziufcmJu/PZdyo3GsjocUpdN0fGZ
         LCW/bHuNmF9nGX4fPDVErMyDFG6KfGIStnq6U4w3Bnlvt+hVJ+nQFH91kUSktbS+8SUI
         nanp3H1tcrFrjQIEaGY4sjAMHcbRrmYIxAnKYqecMW0r8VGL72jvcno7dq6QTfjwjBJc
         mFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757984933; x=1758589733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPfnnggT2ndL938eIChQLKvTB/FFnYYq61IMlRsGnh4=;
        b=C6N3fPWFip7gWcofj5bTvldX/Wk0Z3JwrhHiPYFYLsM0bmFX3q+q9hoztoO/ixcSaF
         YmJda+bdjaQ/22OWGxk1BA1DuuAosTXOvf8HAmtzw2wAH1jl9k0uCo6csHy+YjiqUGIV
         0KiA90kjM5vWUCIrCFSHNQ/jNGkLwFbPbJANawfjagRFKhTbUKC1FriBtK8zuhvg+7Y5
         0KnNRcDExhTwSgTbwaCZ9uoyayAr1eS8h2sC3eI9Xoq0tMrOxjiV8bdbF3RSms9iYFCr
         nw/uf5pZiijJmdDN2J2uJCBD0BjiFwrvi/Yy5ljakKpZQMUwsoPpLiNlpVVcA+5Ehe8a
         YlYg==
X-Forwarded-Encrypted: i=1; AJvYcCWSu1usFENwfkv5UZa7mbhlTXpiMgW5XG/FeeKYYpR7Z01jczuCyaWMAY+n25r5Rv4Mc0B3ha6OceMqhXU0puc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCP8WxZD8cVFdcrGqcvyudkrs8E4/QTu11N/nEbLcEC4h31Qma
	LS8sNyrxNSqZ/hIskixp7VfRz9IZywkaxDkhRtbXLiPzf/lDdUQ/GmMRTLEwFUpiHm6cj99VC7K
	r3Mx2WM1GuCr1Xf2a6OX2s2TgeosnYC7MLPJlZoDq
X-Gm-Gg: ASbGncuDZmCn/ssIY6aF9fxoVLusB0DFflxBZYDD3kcrL6iA3myBRjHMWIbJHT7C5N5
	/klXhkKM58ZTFxrgcotA0QCwttEeZTjPRP5eNUh6k+Gs2LMbVYs4pjRwy2X63VGaQKcWPjXIIGt
	DSDfg6G4mBu5kkGKJ6Ph3yz/byaYvQhwB+1Rj6uA8v56ZwcpbanKQGNEgos3LljcEmmaXal50aX
	y7iYVZK9TOacBUn2wR65gLt/bRMQ5wUXNIDdI0aM2NzKLg=
X-Google-Smtp-Source: AGHT+IFJAwHXee6Yr2rlSgFzR1W6KmuFM2AmQV7u+C+LW88ZIxPQ1NthTP/QNnO6EiXNfW/zo3fYwDpWfY06zM6keSU=
X-Received: by 2002:a17:902:ea0f:b0:24b:131c:48b4 with SMTP id
 d9443c01a7336-267ca0ea180mr1360815ad.5.1757984932255; Mon, 15 Sep 2025
 18:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902111951.58315-1-kalyazin@amazon.com> <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com> <CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com>
 <CAGtprH_LF+F9q=wLGCp9bXNWhoVXH36q2o2YM-VbF1OT64Qcpg@mail.gmail.com> <b325fb38-d34d-45e1-a5cb-eaf2b8c59549@amazon.com>
In-Reply-To: <b325fb38-d34d-45e1-a5cb-eaf2b8c59549@amazon.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Mon, 15 Sep 2025 18:08:39 -0700
X-Gm-Features: Ac12FXzyKYuqCZZsxxrtjECaM8gnlnpPAkbnGEzt2I2OQ5pY2bh2gNnFAoMROiY
Message-ID: <CAGtprH8PJa-hV6DsfUKevZQs=73CUf8ow9i2-sdxbj555De9Aw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: kalyazin@amazon.com
Cc: James Houghton <jthoughton@google.com>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "michael.day@amd.com" <michael.day@amd.com>, 
	"david@redhat.com" <david@redhat.com>, "Roy, Patrick" <roypat@amazon.co.uk>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, 
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 4:01=E2=80=AFAM Nikita Kalyazin <kalyazin@amazon.co=
m> wrote:
>
> On 13/09/2025 01:32, Vishal Annapurve wrote:
> > On Fri, Sep 12, 2025 at 3:35=E2=80=AFPM James Houghton <jthoughton@goog=
le.com> wrote:
> >>
> >>>>> +
> >>>>> +       if (folio_test_uptodate(folio)) {
> >>>>> +               folio_unlock(folio);
> >>>>> +               folio_put(folio);
> >>>>> +               return -ENOSPC;
> >>>>
> >>>> Does it actually matter for the folio not to be uptodate? It seems
> >>>> unnecessarily restrictive not to be able to overwrite data if we're
> >>>> saying that this is only usable for unencrypted memory anyway.
> >>>
> >>> In the context of direct map removal [1] it does actually because whe=
n
> >>> we mark a folio as prepared, we remove it from the direct map making =
it
> >>> inaccessible to the way write() performs the copy.  It does not matte=
r
> >>> if direct map removal isn't enabled though.  Do you think it should b=
e
> >>> conditional?
> >>
> >> Oh, good point. It's simpler (both to implement and to describe) to
> >> disallow a second write() call in all cases (no matter if the direct
> >> map for the page has been removed or if the contents have been
> >> encrypted), so I'm all for leaving it unconditional like you have now.
> >> Thanks!
> >
> > Are we deviating from the way read/write semantics work for the other
> > filesystems? I don't think other filesystems carry this restriction of
> > one-time-write only. Do we strictly need the differing semantics?
>
> Yes, I believe we are deviating from other "regular" filesystems, but I
> don't think what we propose is too uncommon as in "special" filesystems
> such as sysfs subsequent calls to attributes like "remove" will likely
> fail as well (not due to up-to-date flag though).
>
> > Maybe it would be simpler to not overload uptodate flag and just not
> > allow read/write if folio is not mapped in the direct map for non-conf
> > VMs (assuming there could be other ways to deduce that information).
>
> The only such interface I'm aware of is kernel_page_present() so the
> check may look like:
>
>         for (i =3D 0; i < folio_nr_pages(folio); i++) {
>                 struct page *page =3D folio_page(folio, i);
>                 if (!kernel_page_present(page)) {
>                         folio_unlock(folio);
>                         folio_put(folio);
>                         return -ENOSPC;
>                 }
>         }
>
> However, kernel_page_present() is not currently exported to modules.

I think it should be exposed if there is no cleaner way to deduce if a
folio is mapped in the direct map. That being said, we should probably
cleanly separate the series to add write population support and the
series for removal from direct map [1] and figure out the order in
which they need to be merged upstream.  I would still vote for not
overloading folio_test_uptodate() in either series.

Ackerley and Fuad are planning to post a series just for supporting
in-place conversion for 4K pages which is going to introduce a maple
tree for storing private/shared-ness of ranges. We could possibly
augment the support to track directmap removal there. RFC version [2]
is a good reference for now.

[1] https://lore.kernel.org/kvm/20250912091708.17502-1-roypat@amazon.co.uk/
[2] https://lore.kernel.org/kvm/d3832fd95a03aad562705872cbda5b3d248ca321.17=
47264138.git.ackerleytng@google.com/#t

