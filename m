Return-Path: <linux-kselftest+bounces-25362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B0A21DCA
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 14:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0572E161D83
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5375C42A80;
	Wed, 29 Jan 2025 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSEMauXy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B868F23AD
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156808; cv=none; b=M4fpIe0b6bz95GKu9sVqhFxP1vvZ+ZItvol8/U0SJXYJ8xmArf43rxmgsWsmDmarRL+RGugCUZc6TxvpU3NTF81Wna/l1XXxdfipDPyBqjnhpbSMT9Aag1BZfuALbukjOAcBbWOXUWeoD8PBwN7QeTD5TQ8ZpvW/4CExCFllbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156808; c=relaxed/simple;
	bh=peuzQRxLcZOMOzgrWwphrulzp+cj5EWTU/8yNTxbp5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dexkRJsLxOF1V9FPvIzUErIDzB/ZvscG1X/YaccP+SqtN+73OmOlUWeLkSf3lnBJ/qVFpn2peVhAqCHmfQdV/jzNsuBuh79+fIpXrtDcCoaptyRGqUpTG42pEthJ/D36JMaK+cmmj99roB/VS/aRomBRN4pddbxAHmdS2gVRDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSEMauXy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738156805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnrxopPQtzOwNQ5afpRaG6zifnqXxokYRkRHUpSs4uU=;
	b=TSEMauXyq1bL2oLn7u2RE/4Hc7qJV6YNCRtIk4XCgkdRUr5Rq/qFE7cAZZut2y3mMaleFP
	oY+Oo8yNIr+Vj804QGB1/6tP69d/Zev4VKpFK9tWyJjsM7Tne+lqea4hgCs7uXauhpbvHT
	q4xBU5pXL29WgESAg0l7CxyyejZQGio=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-P_f5M7BEOZ2QFR4PQJFL9Q-1; Wed, 29 Jan 2025 08:20:02 -0500
X-MC-Unique: P_f5M7BEOZ2QFR4PQJFL9Q-1
X-Mimecast-MFC-AGG-ID: P_f5M7BEOZ2QFR4PQJFL9Q
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216430a88b0so133074965ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 05:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738156801; x=1738761601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnrxopPQtzOwNQ5afpRaG6zifnqXxokYRkRHUpSs4uU=;
        b=f4xSVaRhqq/kL4quoq5RaCoHLm9hLHRpKP4HuVOC8ZSiWx1mS9g5LxFjgqOwv2ttcz
         oOkeAPE4JKlMji1E0aLkzlgYOL0N1QzfjSmOTDpoexZwrUyjpUCKBxxpzuXsHDOYujh9
         RLLs+JHKPVlvSU4tOW2fU7f25Hpo8W88b+R+jBha3jv0GupCGZdu7LZ+Cy3IsjOlBN2h
         OCVAlq0+IKsmACqR8E3+HOLHL6yih4vC2g2HEmkhCAn+ENTeq9LJpxLzINXiiH21LTDP
         bYBRKWrUhn+4m2ylgLFFDZlL8C+HNrwP4dUVq3K5tSC2i4vAJvfGnecjRsW12ca0eI86
         7E5w==
X-Forwarded-Encrypted: i=1; AJvYcCVRIsdG+CHGNL4Bh5vZWQW3hu3kh1qOtNh8DUKzYlwuMgaly8vT0u8HIFRMNJ5fvgYKNPSmf3tZMCbv3RQcO/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YygMnX9dUnyDkr02FcggZvgoP1wcwioQ20jKM+zewf9PM+e9veR
	DWpVUWwrlhQR+XAFmGzok3IbvH7vZwB7cvCS8TCwCF7PwKKfmmxhyQaSONc/dmdk6WKy/Ar7O61
	SE7R8DzAwA6LbEELVNad3W4luVFsxs4rkCbxHYMhQ7oqJHEVXg1AP5yB2gR0S/hVxLSdH3hdoWN
	Idlfr9nrM2PvWBPcoPI7U8EAbYOd+5+bp7RZD0szlC
X-Gm-Gg: ASbGncvpl6kRwxxxNZ8X0aA1aWBrtZL5MnIuY3Bn+7SLMB3FEP4KyXeGOWKAPVgYMwz
	9XL1ZyVCJ48VfegkjjNcKKcKtBbKL0dIxm66d1qRftU3gGcq7f0QShY6VyXcZ
X-Received: by 2002:a17:903:11c3:b0:215:b1a3:4701 with SMTP id d9443c01a7336-21dd7d64c1emr46673095ad.13.1738156801131;
        Wed, 29 Jan 2025 05:20:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQOZFr2V4TbmZwoo+kjh3T0bkY5fZi6e4r8aC+hRmcxbxhVHpJsolfTlYRNmwWDDXduhCBAbyy0OdHsGwDTmE=
X-Received: by 2002:a17:903:11c3:b0:215:b1a3:4701 with SMTP id
 d9443c01a7336-21dd7d64c1emr46672865ad.13.1738156800881; Wed, 29 Jan 2025
 05:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128163859.1883260-1-agruenba@redhat.com> <20250128163859.1883260-2-agruenba@redhat.com>
 <aaac3569-2c96-45dd-bd3b-4a5080833767@commonscaretakers.com>
In-Reply-To: <aaac3569-2c96-45dd-bd3b-4a5080833767@commonscaretakers.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 29 Jan 2025 14:19:49 +0100
X-Gm-Features: AWEUYZmtzUeFlio5DE8H9dBw0ziDp6A5hWvbBPuPSisEKGVu7uJfHu9v2WZB-U4
Message-ID: <CAHc6FU5rWFosNax-1f9K4ihk-Y==Cd5RXj+xsHzxkyLvmdLmng@mail.gmail.com>
Subject: Re: [PATCH 01/21] bcachefs: remove dead code in is_aligned
To: Eric Herman <eric@commonscaretakers.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	linux-bcachefs@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 11:32=E2=80=AFAM Eric Herman <eric@commonscaretaker=
s.com> wrote:
> Hello Andreas,
>
> On 2025-01-28 17:38, Andreas Gruenbacher wrote:
> > This statement does nothing.
>
> I would suggest this statement does nothing only in the case of #ifndef
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
>
> In the case where CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS _is_ defined,
> it tells the compiler that it should not emit a warning for an unused
> parameter.
>
> Perhaps it should be moved in to an #else of the #ifndef in order to
> more clearly communicate that it is expected and okay to ignore this
> parameter in this case.

How about declaring base __maybe_unused?

Thanks,
Andreas

> Cheers,
> -Eric
>
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >   fs/bcachefs/eytzinger.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/bcachefs/eytzinger.c b/fs/bcachefs/eytzinger.c
> > index 2eaffe37b5e7..c0fdfe909cf2 100644
> > --- a/fs/bcachefs/eytzinger.c
> > +++ b/fs/bcachefs/eytzinger.c
> > @@ -20,7 +20,6 @@ static bool is_aligned(const void *base, size_t size,=
 unsigned char align)
> >   {
> >       unsigned char lsbits =3D (unsigned char)size;
> >
> > -     (void)base;
> >   #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> >       lsbits |=3D (unsigned char)(uintptr_t)base;
> >   #endif
>


