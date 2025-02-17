Return-Path: <linux-kselftest+bounces-26801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E934EA38C4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 20:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC8416B2FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FEB236445;
	Mon, 17 Feb 2025 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJXuGHRP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26F137C35
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Feb 2025 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820255; cv=none; b=EdL1cmNZ9b4etvCzjIOH54OHIyN1U7R5bpYEIpBU4rhcP4yuEEmtNhdlfza28PQYzfQGvA92ldelohtK+UgJ9VYmZueLn/VK5r9qNVGoIpRq+O2Mj42o+p9keYpDKsWr7O/jcdFfHtRnh0SNHjYn1EKmIT06MKXMZJev3izphOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820255; c=relaxed/simple;
	bh=rdbMLJJGNPMZE86U034IIF2tHWWv7Jlyf8ALOn6BLhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taorotN1D75AMDlEOSV+7tTV+0TjEWyGcbIS3P2kObC7LBzULTdz/OAWc1+3J17AH4pxig7fvCQTvfRPLbWSHlD/HM1kHGxNCHK0qE1xlE+py9SzZl5FmDZUFnDGldCMxbrA/Yw8c7WgJNXLzgeSTmfYhfeFbD57bDykxwtZ4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJXuGHRP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739820253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdbMLJJGNPMZE86U034IIF2tHWWv7Jlyf8ALOn6BLhI=;
	b=HJXuGHRP55kFxTuu1I9ElP5O+f94fJKpLcNHNok4jxZSIkjd97TYXZpHi7NNo/juWGrp3c
	sXLMHftbnBFMGiZZIxX6prmFceuOkp0gCIxWojttp3pCTW4N+T2ygM+gjM575aXLgMAgNV
	GQC9iwGVNrSZGx6CGCXLvH0lf8oj/XA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-4JBpNYHbMLSYnK4u1tI6rA-1; Mon, 17 Feb 2025 14:24:11 -0500
X-MC-Unique: 4JBpNYHbMLSYnK4u1tI6rA-1
X-Mimecast-MFC-AGG-ID: 4JBpNYHbMLSYnK4u1tI6rA_1739820251
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e5b0f2778d6so5088594276.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Feb 2025 11:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739820251; x=1740425051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdbMLJJGNPMZE86U034IIF2tHWWv7Jlyf8ALOn6BLhI=;
        b=RgSXq/NQH/3HyrRXscoMLUddSP9RhgigK1GKKGgUOpNZpCh2Nku2zCB9JIB//CSwyc
         cv6G3ID31f8wnqKD54TS+XQyvbxwiQw73nTCz88z+WnNjON7S2TNbne96egHIsyxlAWy
         j4QaTl+zYZs7h/iIzfjPjqWDmIHpGq/IEiqfaRQALPD50zMAOQca5LoEP5YCTwEYABe6
         Fm7s7QNlDI2pGNlazBezH/wn6D+x9f/adE13ciJGFoZ5qc/Go/B6c0bTNfTKCBr4psXc
         jI13hX9YPFXIo41tjWIz34FTvZnhPNeQo419Ly6agYWLdBln7lw9hG6jBHG1e2vF7bUv
         9ERw==
X-Forwarded-Encrypted: i=1; AJvYcCXDUhyERA9hkA6hfcdCfZzxT7h9xp9bd0KJys8UG0nSXyEPTIOx2CwRsC5hzEefFtoXqnE8AFgNkb5r3o6HVf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuKtCGmvaZEcI7pk2WtwN5+quigMN1SYXhhfGOYihPaTpz47zS
	69GEp2rhbdTI66gUgOqFMKq8E/pb1ZHurYOddXTSjDXKEg1GaEnKP2wivGoJNGs2+BLRKuLAPGM
	xOVrSUOPYv4RENWtf3HVIhqMVV6WPko/UaBXdJJ0JCdeXyf/MRsnMGTyq3A2M5poEGvsUYCiqx4
	3CDZr7zBxJ7VLswSGaXL88podKYu6jfZo7hnWrFzs5j7y67pUrVJQ4hA==
X-Gm-Gg: ASbGnctvXpEU8jS9TfYnuGQIoWGgcAILIIoRzJ/EfvHztU2Kqb9rvwDbBmF2xqU5sR9
	Ldjpum47r2FKiuInQHizMfzY50WdhdWoW7sbSeR/G4Qaov0aH9UW9lYXu51+6KTgl6aqEd9nH6m
	k=
X-Received: by 2002:a05:6902:707:b0:e58:14b:6f99 with SMTP id 3f1490d57ef6-e5dc901f547mr8915032276.1.1739820251044;
        Mon, 17 Feb 2025 11:24:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrYJ+VsXOI7bm6RpW9QE+8ogDjp6XZe+FrO+0Ua+m+u7LfKjMyLDagrscG092+H3ywzM9KEOxGNYAFwBDzmPg=
X-Received: by 2002:a05:6902:707:b0:e58:14b:6f99 with SMTP id
 3f1490d57ef6-e5dc901f547mr8915020276.1.1739820250714; Mon, 17 Feb 2025
 11:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211004054.222931-1-npache@redhat.com> <cd75eafc-e20a-4c32-bd29-7ab2c5c03008@gmail.com>
In-Reply-To: <cd75eafc-e20a-4c32-bd29-7ab2c5c03008@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 17 Feb 2025 12:23:45 -0700
X-Gm-Features: AWEUYZnrFfBm_wbf5EFCjaf6bQ2dpqtlNGkqHB1w5LssQl9ZQBUHAWZR74WN2LQ
Message-ID: <CAA1CXcAK8tMVhWJLO9OrkyBpA6ZdPv7f99igBphLhLxVM5zJxA@mail.gmail.com>
Subject: Re: [RFC v2 0/5] mm: introduce THP deferred setting
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org, 
	vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	srivatsa@csail.mit.edu, haowenchao22@gmail.com, hughd@google.com, 
	aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, ziy@nvidia.com, 
	jglisse@google.com, surenb@google.com, vishal.moola@gmail.com, 
	zokeefe@google.com, zhengqi.arch@bytedance.com, jhubbard@nvidia.com, 
	21cnbao@gmail.com, willy@infradead.org, kirill.shutemov@linux.intel.com, 
	david@redhat.com, aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	sunnanyong@huawei.com, audra@redhat.com, akpm@linux-foundation.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de, 
	baolin.wang@linux.alibaba.com, corbet@lwn.net, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 7:54=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 11/02/2025 00:40, Nico Pache wrote:
> > This series is a follow-up to [1], which adds mTHP support to khugepage=
d.
> > mTHP khugepaged support was necessary for the global=3D"defer" and
> > mTHP=3D"inherit" case (and others) to make sense.
> >
>
> Hi Nico,
>
> Thanks for the patches!
Hi Usama,

Thank you for the review!

>
> Why is mTHP khugepaged a prerequisite for THP=3Ddefer?
> THP=3Ddefer applies to PMD hugepages as well, so they should be independe=
nt.

Its not a hard prerequisite, but I explained it a little here:
https://lore.kernel.org/lkml/CAA1CXcBPt4jHfH0Ggio5ghSYAQAXf08rO8R6b1faHzdjF=
f_Ajw@mail.gmail.com/

In general, the sysfs didnt really make sense without it, and given
mTHPs came along right when i was working on defer, I decided to add
it to mTHP too.

I worked on and tested these together so it felt right to sync up the
V2s for both of them.

Cheers,
-- Nico


>
>
>


