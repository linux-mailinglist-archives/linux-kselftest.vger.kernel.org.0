Return-Path: <linux-kselftest+bounces-41734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1020B80A6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 17:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E90468290
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B188362089;
	Wed, 17 Sep 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZADxscQ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECED33AE87
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123533; cv=none; b=Wy/RN+N//n6c1J33e9xy2gWKhmWHzfqRpzgUVfBz0T7aiEi2xgPZLmwhySY+JhItae7eNqMyvYMBKrtGEqNp5+zKlA+j3hTUOqbr5lu7hjtW+CFHFdnndP7ftmmZpN3kHSw79Fi1J+6FKWkKMFmC17Y9txy12ez6z1UgbT/CQeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123533; c=relaxed/simple;
	bh=LB7piiKR7QrRUi/bNOQ3i5gVlRn+pQtHDDNHk6T+viw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNy4QAVgBmkaZDZlaNUZmD2ds/A6EOi/JJYBeHUlKbP34GJfkexL3KTdHV7HiJBioEuNjUPX/26RhRC3gp1JoPChRswHkyjEpQvsQQL2E99+wb21FjkxVtZUDpUixQ9jWITacfmv0TOF2ca/hFaRkghJMLwm75FIDjU9trHySI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZADxscQ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758123530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzDrhoqrJLVBFYiFwQ2SZoCYFfAfOJ2dJ5Nixz692Nk=;
	b=ZADxscQ2sBs6IDit/ADxXQP3JbxYbXWjPlwwq46jndQ6aRXi1k75PsBs1Y+zOoEyYjCL/T
	6WzN6KcDBc3mkw8JCIpVBFBxYAJDEXDXyYVyKrIw4kbSUZnwPbDn9rm1054nARsgxRul10
	A59/LKWmHSP227iUGvY+SZ9QstOL6sw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-Hce-dmhhNP6DHAQWVJvN_g-1; Wed, 17 Sep 2025 11:38:38 -0400
X-MC-Unique: Hce-dmhhNP6DHAQWVJvN_g-1
X-Mimecast-MFC-AGG-ID: Hce-dmhhNP6DHAQWVJvN_g_1758123518
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b302991816so134890621cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 08:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123518; x=1758728318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzDrhoqrJLVBFYiFwQ2SZoCYFfAfOJ2dJ5Nixz692Nk=;
        b=ZsW3FuPyun1L0HavT0hCrE77L/cN3yfZzFdbQgeASrpOBJX1SQEvTdM+8i90P5uqaF
         yIhVDV8CCc+WXcrwT/SM4Mt7+0B6Cxf+8ozmtIEmCKdKcgF7GWkAoEn/f9n5dGZXozc8
         sxHdggSFYwdU8f3ASI4oEYFrYo+GO9Dz45TEit3GNHS6ziwMSNCxk915tYDPblaJ3FQo
         dinw4A5BnRB+fXXPvWuFZ6PyAO7Lze2A9KB6hC1TNrKpY9F6zOSrKP2gei9eoF5W3938
         QCBTr9pKkI7JvGdiWQlMIdtchLgpk5hzXT6MjX1TF0FOJo/ewgPKPRrtvEOVLiozpEQi
         fklA==
X-Forwarded-Encrypted: i=1; AJvYcCU/1WbrUgjqpHMlRxaO80s105frVk0GBlAkM/OADaypwFSq3E3TT7IL8ll6tVyopee2D1z/wyrjUt8DNdxVtds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxURBLsW4Mkj32p2N6CvgG2IcBw/L20pllNpZLZ/RpvFCrETyQJ
	NliRqRDltEMEcw5+YK1KVPP57GtMRDu2FZOGZqnM5qieYiQkwByzx9zW6hC3WTffDBmjTlzAomX
	a4j9d8/cCxnuSRV+wzCU/V79UJiVVsf0zqwOp5eefeXBzkpCqQT5ybrNMZu1D1PzvH350BOVijC
	5MSJ1iZOiXlstxkD2RV6iiFtEfCbzAgT+z4uf2qP6qcmIS
X-Gm-Gg: ASbGnctePVarqe1fhbY3CnTHgq699U5iwY7qQ+O6s0D7HGtpXeP2azucuS/+D8Td3qN
	Xv/wjZeoBG1NUfmtS+2auBAoWsqV/IPwjaF17Wl62sIfWTWMiyBSKia8msA3TmxffYR9HH6d6OI
	sVEQ/S5wi4rHr+fhXAj+FORTrBtBZJc5hWP7aH0kTOw5+H3RUGyeaQ8A==
X-Received: by 2002:ac8:6f1b:0:b0:4b2:fdda:f7be with SMTP id d75a77b69052e-4ba6618b9aemr26320411cf.3.1758123517637;
        Wed, 17 Sep 2025 08:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPZbhJSMxuKHfrTjKxJCkJbacm2wHdKQT9Bzco4e/BiqN9eL3IFcF/vIvKnAOF3my7lb81Pi2uNb/6ZJFMKnU=
X-Received: by 2002:ac8:6f1b:0:b0:4b2:fdda:f7be with SMTP id
 d75a77b69052e-4ba6618b9aemr26320041cf.3.1758123517106; Wed, 17 Sep 2025
 08:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <20250910170000.6475-3-gpaoloni@redhat.com>
 <874it3gx2q.fsf@trenco.lwn.net>
In-Reply-To: <874it3gx2q.fsf@trenco.lwn.net>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 17 Sep 2025 17:38:25 +0200
X-Gm-Features: AS18NWDxjPkZ_bdK-V6Pzd1fFU51OydVEbc_fWStALboJrBYI93hRwf9Wba0uR8
Message-ID: <CA+wEVJatTLKt-3HxyExtXf4M+fmD6pXcmmCuhd+3-n2J_2Tw8A@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 2/3] /dev/mem: Add initial documentation of
 memory_open() and mem_fops
To: Jonathan Corbet <corbet@lwn.net>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	safety-architecture@lists.elisa.tech, acarmina@redhat.com, 
	kstewart@linuxfoundation.org, chuckwolber@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan

On Tue, Sep 16, 2025 at 12:39=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Gabriele Paoloni <gpaoloni@redhat.com> writes:
>
> > This patch proposes initial kernel-doc documentation for memory_open()
> > and most of the functions in the mem_fops structure.
> > The format used for the specifications follows the guidelines
> > defined in Documentation/doc-guide/code-specifications.rst
>
> I'll repeat my obnoxious question from the first patch: what does that
> buy for us?

I tried to explain my reply on patch 1

>
> > Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> > ---
> >  drivers/char/mem.c | 231 +++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 225 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> > index 48839958b0b1..e69c164e9465 100644
> > --- a/drivers/char/mem.c
> > +++ b/drivers/char/mem.c
> > @@ -75,9 +75,54 @@ static inline bool should_stop_iteration(void)
> >       return signal_pending(current);
> >  }
> >
> > -/*
> > - * This funcion reads the *physical* memory. The f_pos points directly=
 to the
> > - * memory location.
> > +/**
> > + * read_mem - read from physical memory (/dev/mem).
> > + * @file: struct file associated with /dev/mem.
> > + * @buf: user-space buffer to copy data to.
> > + * @count: number of bytes to read.
> > + * @ppos: pointer to the current file position, representing the physi=
cal
> > + *        address to read from.
> > + *
> > + * This function checks if the requested physical memory range is vali=
d
> > + * and accessible by the user, then it copies data to the input
> > + * user-space buffer up to the requested number of bytes.
> > + *
> > + * Function's expectations:
> > + *
> > + * 1. This function shall check if the value pointed by ppos exceeds t=
he
> > + *    maximum addressable physical address;
> > + *
> > + * 2. This function shall check if the physical address range to be re=
ad
> > + *    is valid (i.e. it falls within a memory block and if it can be m=
apped
> > + *    to the kernel address space);
> > + *
> > + * 3. For each memory page falling in the requested physical range
> > + *    [ppos, ppos + count - 1]:
> > + *   3.1. this function shall check if user space access is allowed (i=
f
> > + *        config STRICT_DEVMEM is not set, access is always granted);
> > + *
> > + *   3.2. if access is allowed, the memory content from the page range=
 falling
> > + *        within the requested physical range shall be copied to the u=
ser space
> > + *        buffer;
> > + *
> > + *   3.3. zeros shall be copied to the user space buffer (for the page=
 range
> > + *        falling within the requested physical range):
> > + *     3.3.1. if access to the memory page is restricted or,
> > + *     3.2.2. if the current page is page 0 on HW architectures where =
page 0 is
> > + *            not mapped.
> > + *
> > + * 4. The file position '*ppos' shall be advanced by the number of byt=
es
> > + *    successfully copied to user space (including zeros).
>
> My kneejerk first reaction is: you are repeating the code of the
> function in a different language.  If we are not convinced that the code
> is correct, how can we be more confident that this set of specifications
> is correct?  And again, what will consume this text?  How does going
> through this effort get us to a better kernel?

In summary specifications provide the criteria to be used in verifying the
code (both when reviewing and testing).
Otherwise:
1) Developers and reviewers have no criteria to evaluate the code, other
than their expertise and judgement when they read it;
2) Testers would write test cases based on the code itself (so it is more
likely that a wrong code is not detected due to wrong test cases).

WRT your first point, if specifications are wrong, a reviewer or a test
would detect a gap between code and associated specs, hence leading
to process of scrutiny of both code and specs where such a gap must
be resolved. This is the reason why the duality of specification and tests
VS the code being verified lead to confidence in code becoming more
dependable (also from a user point of view that can now clearly see
the assumptions to be met when invoking the code)

Thanks
Gab

>
> Despite having been to a couple of your talks, I'm not fully
> understanding how this comes together; people who haven't been to the
> talks are not going to have an easier time getting the full picture.
>
> Thanks,
>
> jon
>


