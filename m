Return-Path: <linux-kselftest+bounces-25392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7998CA223CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 19:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E667A32F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B51E25F1;
	Wed, 29 Jan 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etSLQXVd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2E1E1C36
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174929; cv=none; b=RjQ6bjL4VJXAP82mAfiEKDY3HmuGOoiJ3lS3CZUt8MxAzkqk467WNZTjW8Tzp+50shbcsaKu2l8QixTsfIn5ADGesaIlJ48BoYtZQ2MTTPuQXufmcyE8Rkl85g3F60MhSWIoEOmYM1/MpURvN8Tn+98iqap5Yx/Ew1ZkLhlS5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174929; c=relaxed/simple;
	bh=lsaUG6o3qihqxjqzbj4fHVtLhJfu4dvDi15dE28PoFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNZvzP7LTM+tbHALg2F0Glt9r1B1wNXmW1Mlaqnw3zPbN4cbvkCLrDFYHVc1w1yF0X3zj+FIuSQBrwd/f+1o47vG1T1RKrNLSHosyEWlL0lw8V6vGq1l2Rgw6SzFDZ/UWS5upPg68oXVdSHB9RyDZKM1DaGfu4X2Zpkpw416Ew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etSLQXVd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738174926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vwvdh5o59AfjX+xyiOuePStNuB1CoftM4eJYE4dSFr0=;
	b=etSLQXVdtEiDaOsZsunez475TOE4JR6DnQE+0m5jbgr124cfu2Co4z5b8Rv+itSciw4whi
	4TehHl9szJjo1iWy1xWwEBjhr27rNMFa6m/GC3jsXZfeFFCUxfMCocBD/RupBMmKnKZhEX
	LxGfF6Xu+hZCrY199daYKjdkkmDQIxg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-uEkfur81Nai3a1z9I4VnPw-1; Wed, 29 Jan 2025 13:22:03 -0500
X-MC-Unique: uEkfur81Nai3a1z9I4VnPw-1
X-Mimecast-MFC-AGG-ID: uEkfur81Nai3a1z9I4VnPw
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21661949f23so214163675ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 10:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738174921; x=1738779721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vwvdh5o59AfjX+xyiOuePStNuB1CoftM4eJYE4dSFr0=;
        b=VuD8JrzI2PR3oOu+Wc0Nv9OUmoXSHPaEl6ZcqMtjZyJuYLUf5QSUaSbB9lwhjd723D
         WqbcbPf06imzOPAjwnEl8m6KZH7hnrdFUHDOC94Bc/VHFYl4UmuGszXNfaGcpIkWN57R
         Oz43E2vIrE5ecpiKtILGZ8wQg7BQEJXw2E3BMvGq8ryfgeWZ0fOIjelW9Ofi4otIe+BT
         x/9DU8xEopsYhbgKmez4Kx1ezWqyG5RqMvqMXaMXJXBQzqCU5vV5ytVHvtsdkQNfiLMS
         2CGmUCkx60i8YSsOEpxJAuxlo3SJOV4HsmeNR6NbhcE4UygHl018Y78j5Hc6498wirn8
         eIgA==
X-Forwarded-Encrypted: i=1; AJvYcCVnHTRiwK/3pKj4qyPFT+DE78t6we3AZAzwnwstVyaUv/oPHYLTav33T8g+Ek16GzqdZ53TW3CeRk+01tmgbFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpS1LqT3rbTZ/1eXvxnvHRSo1suhtYPPk7iv/2GtJdpU2CDi8a
	AJv8cXOL13+ZqyGwFeGrX7AUdNrNPFG0s8055BcgHhVYfTX4661tPKnBqYVnXeLGhSwLM2k8IQS
	K4IictGuGsjPZTfBvOZmc/JxnkXNuaf1WzvGlP3XKWPZvSzTzEq32KjcthrBOVi9gkADrjtLA/x
	s1yonV6Ji2Rlxu/NIkyrPupG/+j0u8n77gGiy7nTw8nnQ4Vc89k5M=
X-Gm-Gg: ASbGncu+FFr4yvX1mgX+fIJC6B3qM5UxBHWqsdbcO26d4al2as8dE58+kdK+B2+g1lt
	GQCG0iNWzBd+xzNADbFW6vVg1p9cdjmEPbK8lzTPnU9vew3eIgH5HGRWyXswH
X-Received: by 2002:a17:903:191:b0:215:a3fb:b4d6 with SMTP id d9443c01a7336-21dd7c46c2bmr52962935ad.8.1738174921341;
        Wed, 29 Jan 2025 10:22:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFptm1UwGo2W05+wxJUDKK2S8w38oe09PVLSommj0ey+wlSbU7v2JPCWDRl68vDt0awHZUBWs4SYgdxF0NnzuM=
X-Received: by 2002:a17:903:191:b0:215:a3fb:b4d6 with SMTP id
 d9443c01a7336-21dd7c46c2bmr52962655ad.8.1738174921020; Wed, 29 Jan 2025
 10:22:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128163859.1883260-1-agruenba@redhat.com> <20250128163859.1883260-12-agruenba@redhat.com>
 <ajfehauvtid4d7pqy7o3uhe6p7buohwe542wqddkwpdq62lr4g@6cgcfpzcyag3>
In-Reply-To: <ajfehauvtid4d7pqy7o3uhe6p7buohwe542wqddkwpdq62lr4g@6cgcfpzcyag3>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 29 Jan 2025 19:21:49 +0100
X-Gm-Features: AWEUYZkSBdaXjPPHE2wqhh6qQSkUStuBuJVEdnsHM8It449daZy7EWOkh9lv5f0
Message-ID: <CAHc6FU6Yzk1Si37nRji-5uDZF9uaYo=G5tbtuS_5FiW6BDVTAg@mail.gmail.com>
Subject: Re: [PATCH 11/21] bcachefs: improve the eytzinger0_find_le tests
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Shuah Khan <shuah@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 7:04=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Tue, Jan 28, 2025 at 05:38:48PM +0100, Andreas Gruenbacher wrote:
> > Rename eytzinger0_find_test_val() to eytzinger0_find_test_le() and add =
a
> > new eytzinger0_find_test_val() wrapper that calls it.
> >
> > We have already established that the array is sorted in eytzinger order=
,
> > so we can use the eytzinger iterator functions and check the boundary
> > conditions to verify the result of eytzinger0_find_le().
> >
> > Only scan the entire array if we get an incorrect result.  When we need
> > to scan, use eytzinger0_for_each_prev() so that we'll stop at the
> > highest matching element in the array in case there are duplicates;
> > going through the array linearly wouldn't give us that.
>
> For test code, wouldn't it be simpler to iterate over the test array,
> testing with every element as a search value? There's enough corner
> cases in lookup that I think it'd be worthwhile (and probably add some
> extra test values, e.g. first/last elements +1/-1).

If you expect to get the same index back, that won't work when there
are duplicates.

Andreas

> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/bcachefs/util.c | 41 ++++++++++++++++++++++++++++++-----------
> >  1 file changed, 30 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
> > index 3fe9a3b8c696..c772629783f3 100644
> > --- a/fs/bcachefs/util.c
> > +++ b/fs/bcachefs/util.c
> > @@ -782,29 +782,48 @@ static inline int cmp_u16(const void *_l, const v=
oid *_r)
> >       return (*l > *r) - (*r > *l);
> >  }
> >
> > -static void eytzinger0_find_test_val(u16 *test_array, unsigned nr, u16=
 search)
> > +static void eytzinger0_find_test_le(u16 *test_array, unsigned nr, u16 =
search)
> >  {
> > -     int i, c1 =3D -1, c2 =3D -1;
> > -     ssize_t r;
> > +     int r, s;
> > +     bool bad;
> >
> >       r =3D eytzinger0_find_le(test_array, nr,
> >                              sizeof(test_array[0]),
> >                              cmp_u16, &search);
> > -     if (r >=3D 0)
> > -             c1 =3D test_array[r];
> > +     if (r >=3D 0) {
> > +             if (test_array[r] > search) {
> > +                     bad =3D true;
> > +             } else {
> > +                     s =3D eytzinger0_next(r, nr);
> > +                     bad =3D s >=3D 0 && test_array[s] <=3D search;
> > +             }
> > +     } else {
> > +             s =3D eytzinger0_last(nr);
> > +             bad =3D s >=3D 0 && test_array[s] <=3D search;
> > +     }
> >
> > -     for (i =3D 0; i < nr; i++)
> > -             if (test_array[i] <=3D search && test_array[i] > c2)
> > -                     c2 =3D test_array[i];
> > +     if (bad) {
> > +             s =3D -1;
> > +             eytzinger0_for_each_prev(j, nr) {
> > +                     if (test_array[j] <=3D search) {
> > +                             s =3D j;
> > +                             break;
> > +                     }
> > +             }
> >
> > -     if (c1 !=3D c2) {
> >               eytzinger0_for_each(j, nr)
> >                       pr_info("[%3u] =3D %12u\n", j, test_array[j]);
> > -             pr_info("find_le(%2u) -> [%2zi] =3D %2i should be %2i\n",
> > -                     i, r, c1, c2);
> > +             pr_info("find_le(%12u) =3D %3i should be %3i\n",
> > +                     search, r, s);
> > +             BUG();
> >       }
> >  }
> >
> > +static void eytzinger0_find_test_val(u16 *test_array, unsigned nr, u16=
 search)
> > +{
> > +     eytzinger0_find_test_le(test_array, nr, search);
> > +}
> > +
> >  void eytzinger0_find_test(void)
> >  {
> >       unsigned i, nr, allocated =3D 1 << 12;
> > --
> > 2.48.1
> >
>


