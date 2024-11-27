Return-Path: <linux-kselftest+bounces-22581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620529DACB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 18:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A65166DC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B155201032;
	Wed, 27 Nov 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNi5VHcC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB5819
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729663; cv=none; b=XvMnbJX1vBlNgt5CXvvYKC3zlicC4sMTtGSUNuKoK4CQe4M8LloY/X0mrXaiWYd9gsk6M3j4/XM79mCSypsX6A5fp/80pFznT7jeXg5lhwBfhdC4oRR5qujiH4+X+ut/z7XRQLHtDKClBvtirbAxSQEljRDMQVvH9toYDbFIid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729663; c=relaxed/simple;
	bh=3cPCxD7H2a8Lh6owvh2XlsPsMo9YKelKbnsLwpIFa20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhqKCvda0vZaFqa9K+QWkWXxR04GObQxNHaP1OltDD6OV3SNFs1ZESoOKx8htdyt5CzEwxptJxuqLq+dTwCgGUeOhr5/WNkF3BnXywnFctfolEofYev0OMm72L3kt1AzdaDr6fYgjSMUTf5WjybKUL5ORMn+2t4ozzstqAbRvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNi5VHcC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-211eb2be4a8so196535ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 09:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732729660; x=1733334460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C10ZEuRraCO6elndBS5q/kKi7+M/Tzch8Tv1uSjbGZM=;
        b=dNi5VHcCyV7ERuNgBI9bzi17ZRrzpewNYowpO8dKTLsdR+6X5q9QkNG0rlEOgAKOr5
         KMWabk/IvN/QuVVx4qV7wDIkhx2sj14afbAO3k0av0nua/bOtoeXJoSvhrZdV/4+Kpd+
         Yql6s2IFMuyXQ7PglAFw6daN75n/XgkGIsIUWZKJEZG21jfFD015O2+yEKmtHm5db4OH
         oNc7OA1i+H2OXfAljcOSslYF14wayjkOM9TD9uXjwF4HnAI42jSCXv8PgY+BvjZ0aSIs
         AgMduWhbmVKOzM1nUn++ZLx+y4jhKpFa6FkSjx9bNZWrB3j6cZQUCKdZD4Ef6wHp2iZt
         xyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732729660; x=1733334460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C10ZEuRraCO6elndBS5q/kKi7+M/Tzch8Tv1uSjbGZM=;
        b=KbHKP5/mgNW0KvI0Pg3k6IELiqpmuHJnyOfWjCQQ7nyDrSD3nZzpiDxQkD6wRVb0QS
         /neB/k4haN4DmwcvHk/WhaNGr4748iPeyqRZPxWxoOceOnAKnhZ7XXK82WyN4WGVtXgL
         qQuuXULKdVwqUp+j7/OjirwdLvthoXt6Rhfv7o5HJ1uhuUrEoRBfEAKQEenM49bjw8Ix
         G0IsaqRap+o7gOZY/dzKrUrqSuwTgMKbxF/sCtOy1DNZh4sEyQhD26roHGC+Rmtd3+pl
         jYIoR1uakVq4dKoeSC2iV+KeLkbHMm+o6fCEpinTmg4KkBMhz4q0Am/+ArsyO5bJarrW
         He9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCLTaLl+WoF2Hq6gyV2KfUzCICqP5oupssipUwJoqMXuoFGyHxKf+SqhCk/Db0b8PFjLepYmRnAARg2XwbFZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+q7gWlg17OcNjV+TodzemTsEgVSxZK4Dw8qsY/s0mnmgEDiN
	jyNUCMuntsZvsteGDS9iDmtcnLE9RmIoi9UpQ9hWhuVRPh5jpFy6mnZsnWd22jFdouGUh9jcGvy
	WlSfT3QX6tMG9OIoZBJnlNMhhVlTula71NVfa
X-Gm-Gg: ASbGnct0khu9qufU2kePM1iPf0PUVq0Ie7xcG/mYVTvRVdUTMTVIj6RQTNzJw5hCEp2
	/X5xBTjCm0PmV7rqEO9vcWcRiCIg1GQbSn9NdlBjw8v5a78p92UOdOXA6RACR9pSo7Q==
X-Google-Smtp-Source: AGHT+IEWj4m7+heIVmeyDopSriS2JGtzJfSKycg033XDM9P61gMKjT+xPWPfu26TGwPqoI2Oh8nkmAXZluulyXqzu48=
X-Received: by 2002:a17:903:440d:b0:20c:8a97:1fd with SMTP id
 d9443c01a7336-2150640abb9mr2258805ad.19.1732729659360; Wed, 27 Nov 2024
 09:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com> <20241127025728.3689245-2-yuanchu@google.com>
 <Z0aeXrpY-deSfO8v@casper.infradead.org>
In-Reply-To: <Z0aeXrpY-deSfO8v@casper.infradead.org>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 27 Nov 2024 09:47:22 -0800
Message-ID: <CAJj2-QEq5xj7JHNS_QaxWXq0e2KDMX2OSw5rGfYeGC4+X9gx8w@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] mm: aggregate workingset information into histograms
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 8:22=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Nov 26, 2024 at 06:57:20PM -0800, Yuanchu Xie wrote:
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 64c2eb0b160e..bbd3c1501bac 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -470,9 +470,14 @@ extern unsigned long highest_memmap_pfn;
> >  /*
> >   * in mm/vmscan.c:
> >   */
> > +struct scan_control;
> > +bool isolate_lru_page(struct page *page);
>
> Is this a mismerge?  It doesn't exist any more.
Yes this is a mismerge. I'll fix it in the next version.

