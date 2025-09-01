Return-Path: <linux-kselftest+bounces-40406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2885B3DC8B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 10:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8723B80C1
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3FC2FC02F;
	Mon,  1 Sep 2025 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPqha5At"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CCB2FB608
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715676; cv=none; b=fsF+Pn2WzcZC7tS8x/SoWu3TMtt6EJM57knpG4KeTyFmqFw79jQMHYwWQGG2Y677IyRLVqyLfxN2tgzM+645c97fW4U8c/pzACGDafukbfte3LGqkqIy8nXS/joBEy+KDxyEIBSyGWvd8Xp9Lp0MltMCPfaKz/65qFqOhOx0BNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715676; c=relaxed/simple;
	bh=yWXgILAuWHBBihp+0jTGf3BSVjsaEg9/Ao7az73pLuw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i+oj2V2wsVgb2iRCWFD175aLHor8q1mqLX56pqbq8sp3mBUfjDUZIxOrSoDez4WahKNwn2VzY4NjQJH+CuCtiRcfhlhTh9Uh97y03A3GUm9AHSm7/YRbOXVijTEgjb6Ljw5S4xC7SiwllvjcrKIjKbXMiMl7We3W53yV/42q8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPqha5At; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-249406d5878so14220735ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 01:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756715674; x=1757320474; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbrHRTPmVoKlWV8ebWI6m112D0ytwDz7+ZvqI/2/bKM=;
        b=YPqha5At1BMSbRO5jzIHxYe7rLqJNY6GG+P7ongNL+6AgTv6zbJ5gozlhTwr4V98Jd
         crNalfp1unwGpsWxoO3NAzb5TWkAMWAnF26dEbSf6qo/+U8il9iJAaqx5BniA9D/MPle
         ZHOuQhPyUTPyL5PhAWpH0KGUJfssqkFBlZAJ7/0+2VDD9LWmLNuS9hyDisw3ugL6ETFr
         iFgqsvcCTZ+4b6bMJs0mw8v2bkjidMvc4pq2/tUF2YMvfT82OyeCeNzXsH9jutiUs6f6
         O/ZIcfPx+eHPzqfJP9h6leGqo98zzvkRLzBK5E/5EQahnHYKeCdOku1pgqxbm9HwrIrc
         GErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715674; x=1757320474;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbrHRTPmVoKlWV8ebWI6m112D0ytwDz7+ZvqI/2/bKM=;
        b=lU0fceTVw9qT5nTQTb0Lr4NwoJbj3cvLXSJnuGRDFCcdNmlEUTRPvAhnNOgAk9em9+
         pI0AQ7p+18rCJvU7NTjIhA4Mzrj3oXcZilVpaC8BbyC+5GTIpYDKnf2O7z50bsI5J/pu
         FPumOP1ooC6sd7yvhiXlK6U2yC5jM8jWgANF1wTNCKdwX+bZkAB9HMQ11fgnRT7FkGLH
         640UxREK1fBGGaOyPrCfwVBCWCkkR8G8J3rb/WUKedMmvMYv1g2pcZxPYZR0CNasc0w3
         bGyFVap2Pi5zMV3Iyj6lr16UTVgCSkyUylatYc2pStDqjpFOvfs2czvBblIG+pzSqHbR
         mDLw==
X-Forwarded-Encrypted: i=1; AJvYcCUCzllSTFhuqZ3UQy/iTcICw49E6IN2WQezUbYndqitiDAPAff8zrs7PiJRCjPyTnbQx0oK6qZmGvcY975UY7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Kr/BBqSrlweV75j+btRIW5zFzEDvE6dOpVsOUkRpUr+FG9/7
	T32NhxKA32jJF8mOMQq6uLwt+cODsldbCkci0g8nqowSVufUHPzbLGkuFrM7HbWnZNE=
X-Gm-Gg: ASbGncuk/iE+6E+xTNvSoi07PoujOjRmaIsyH2TyZ56IbGa5Q61FpCHhq6rps+jKRZ9
	EAftTgrph8zLkc5O6h3saLX4tVAc2UFtrg6r/u7dJEXChQeMUd0u5HaoOqbVB9pFCEBmaR60Q9J
	QRbEp83+lZkw6NwiKSWVx7LhfKf4Dskkpq1P43t4uQXCj4TkeTnxw0vcM7GbBQI0vd1kGCP2/48
	Ibr2LTCC1cAkEtRWUVUBHG0pEnH9WR9Y3dfJRjtRNOyC2jqf0fcDprjd/Ls1dbgS9LZUUrCpF2i
	ZtE2MqmNa3+msz77esIb9ANDtPxCmTqqEub9j5sRXD1+d4qVFI8XRuzDg6tkgYRdg6O3LMdkdEj
	tNTpRBU0AXw==
X-Google-Smtp-Source: AGHT+IEZfowSjilBRafTP9QexzPy8Z2u9xh/wUFr+pZVwMnJoB0ioWxzEc4yKBd0BShD54d8i51GmA==
X-Received: by 2002:a17:903:1211:b0:246:464d:118a with SMTP id d9443c01a7336-24944ae8610mr105522365ad.46.1756715673865;
        Mon, 01 Sep 2025 01:34:33 -0700 (PDT)
Received: from smtpclient.apple ([2400:d320:2231:7720::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903724c62sm95960595ad.34.2025.09.01.01.34.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:34:33 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
From: wang lian <lianux.mm@gmail.com>
In-Reply-To: <df27d5cc-bac8-47ee-a03d-eb1eff6dbe39@redhat.com>
Date: Mon, 1 Sep 2025 16:34:14 +0800
Cc: akpm@linux-foundation.org,
 baolin.wang@linux.alibaba.com,
 linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com,
 richard.weiyang@gmail.com,
 ziy@nvidia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <604B12DD-4BF7-481D-8E09-0D97C8843639@gmail.com>
References: <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <20250901081109.52460-1-lianux.mm@gmail.com>
 <df27d5cc-bac8-47ee-a03d-eb1eff6dbe39@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81)



> On Sep 1, 2025, at 16:16, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 01.09.25 10:11, wang lian wrote:
>>> I'm confused, don't we have that exact check later in the function?
>>> Your v1 might have been better, unless I am missing something.
>> Hi David,
>> Perhaps you missed this in the v1 feedback:
>> =
https://lore.kernel.org/linux-mm/E0C570E7-C4CD-4E41-9590-DDB64757CA2C@nvid=
ia.com/ ?
>=20
> We have:
>=20
> 	/* smap does not show THPs after mremap, use kpageflags instead =
*/
> 	thp_size =3D 0;
> 	for (i =3D 0; i < pagesize * 4; i++) {
> 		if (pte_mapped[i] !=3D (char)i)
> 			ksft_exit_fail_msg("%ld byte corrupted\n", i);
>=20
> 		if (i % pagesize =3D=3D 0 &&
> 		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, =
kpageflags_fd))
> 			thp_size++;
> 	}
>=20
> Sure, it's after the split, but if mremap would have corrupted the =
pages, surely
> it would still be corrupt after the mremap+split.

Yes, so I think it is correct to add this check in mremap.
The check after splitting already exists
>=20
> --=20
> Cheers
>=20
> David / dhildenb
>=20

Best regards,
wang lian


