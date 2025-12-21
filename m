Return-Path: <linux-kselftest+bounces-47798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4153CD3FA7
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 12:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B50DA3008F87
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 11:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7362F6193;
	Sun, 21 Dec 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlIr0vWT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qgAZugZY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389223EAB7
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766318180; cv=none; b=h9ZayWArGxUY/M2jr4FvboIASUJAfIfwx1XvHe1PS22rE9B9BvDiiY+WrbN8/FpPXB3/HQ8Zv/uLK74q40a4bvw+qLIxn5UNz5IcxFerM40TVo0jDRK772O+nShLrNyQGV/0W7dZRrmVVgowVI7yZPxsFkfjn9yGxRlKs1pZCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766318180; c=relaxed/simple;
	bh=RldbKbuVOo2HDrYCBnZXZ7Q5oCHYTlXhYRBybhRuZXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXFYwsXkspATYB2n5/8qZ80dFGpWuqagXY67O1puHezbJS3V6bABAn+WlNzgTh8xFwbew450pApZiM/oh1P87CaLj+Ib325mDm4sXOYebI4IAW7iWJer+550SHbGSWQaoR23qL84CDcmgslNHJ3YD2b/9XVhhnK6m3p/VSvW9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlIr0vWT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qgAZugZY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766318177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LCjjNpAq7py4ZgzH4dDChl16tZ45LVwU5qE17zmzSxA=;
	b=YlIr0vWTCV6BzDUsLFvSV7Q5E9Sk0lOGMokIMg8MngZaz2MeMaR16xIMktOnFJfzO9rSBy
	FEvTPPoVLaoMQB+qrBWWpsrcbSEOjPvUT/s/ZJAckff+3PTtFDq5xKo7n3edXKsRvM20Gj
	0+Wa65romeuqFCV16Zz+fXVGX7r6S4U=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-guQAmEYEMCufBrdg9pwCbQ-1; Sun, 21 Dec 2025 06:56:16 -0500
X-MC-Unique: guQAmEYEMCufBrdg9pwCbQ-1
X-Mimecast-MFC-AGG-ID: guQAmEYEMCufBrdg9pwCbQ_1766318175
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ac34c4b41fso3869917eec.1
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 03:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766318175; x=1766922975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCjjNpAq7py4ZgzH4dDChl16tZ45LVwU5qE17zmzSxA=;
        b=qgAZugZYFti4Vjz/iVBhedlxV7J6cEPhasGy77BUvNzYw56EUQt+VTAhSDM9jX4s+c
         3Gym3mnUUTs98S7MINfO63Y7tyI3MGXWjUrpydf5I0FThnywGZ0WTbA1ibev9JX4WMEq
         CbdQYiDqU4O4tzhjMU3IC9usd6FY95DB+zq8QsZB7KsZgod5nX5jA6h0LdDUysSkUOF4
         c2Atxk9Cpo6qm+4lbOzqPO9y2k01CDh/Kc1GUkt892t6wFWoRl/8bmgvP8VlKMs8Sleu
         2sZi03oWSCJlb/1xSFqNMLTxjIhZr6HwthItRcP32QlA7If6jEzBX9bakc7mbOm/FAR+
         9P9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766318175; x=1766922975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LCjjNpAq7py4ZgzH4dDChl16tZ45LVwU5qE17zmzSxA=;
        b=oiH3wnQ64hOXoCKdNO7K0LosrsNKSLlpkKb4A0+F8YlTrkZm/xf1PhB5hzRbCRPkwf
         zusxCKuja2jnUBdn+RpSZrKvISmTUfYEggKMIHwPYplrbyVM6kwqPqn9HOYXk6numyXp
         laTY8Dc595tGI10nGaRUhGNn89WpWhoOTZ4Y3/iQHga5WtzY3Al5iyNnYQh1ffapbpAi
         +H+PKoTXG3NBJFi5fX6WYzdQZvJ5bGYxSgtHmRX+xh5SxS6c4ikb1msi/N4sTPa67EUo
         urR03FyjFT01DGHesAGQ+nS6OpVa9ZkLJLR5fziQe4MyGgKXkvEnlo/gVJk9lhgLcHLN
         6sHg==
X-Forwarded-Encrypted: i=1; AJvYcCVhTh+yxsyoRYB6gVy+vdn8ZheYwFtmIq1A1P/BNCAkys1Wyech1cFb2bOQOWlmyqxBSLmpXWO85Pyh59Oe4S0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm03fYappkFOpWD33NNlO+36Wu9CD/fotYfSa8jbXf+orHGXvZ
	c5ksNZztZHC0GHsuq7QyT/KwsgE3GtMkqjZ8itwhhoVmonKp5CSeyAhh3zihkHn+igj/n7kDA0+
	g1VJ/QYB0JX4BzwSYy41zBrMR1mqXqlrDY+WuCsnpbPMSVLsCDAtV6SVDR3pLtd/W5VbcafbLW3
	wNW71TnF6bKnvJYTo2RAgz8NyF9WXdkgQfsL1XtBMDP9ui
X-Gm-Gg: AY/fxX7BATo8/+fH84TnjgVveHUANQs8LMtEYXuW2CbwOX5N8/UBbRXG87KR3Te5kV7
	HKPGFwvFC+mk20qaGNiq8d0CNe7Up1w7jw1Jb1o4gVVXnB19F/23WIxX5T7Ym5pw0X9Som01yJg
	KHJZGULnKDxoW1AYRy4wBB+YwHi8jbJCRvu6mKyW7beHfp+r3uxZg5agnsr9rI+SkPDcA=
X-Received: by 2002:a05:7300:e2c4:b0:2a9:9125:ac0c with SMTP id 5a478bee46e88-2b04cb3be5emr12990285eec.9.1766318174859;
        Sun, 21 Dec 2025 03:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbDZTnEf44rDqj8hHqQAxV1KoSZTcLVemuS1ecVvfAr45R0qzwVV95SbMyrWAN6bz/OZrSlNFuL2khBXpkMVE=
X-Received: by 2002:a05:7300:e2c4:b0:2a9:9125:ac0c with SMTP id
 5a478bee46e88-2b04cb3be5emr12990257eec.9.1766318174398; Sun, 21 Dec 2025
 03:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221085810.3163919-1-liwang@redhat.com> <20251221085810.3163919-4-liwang@redhat.com>
 <970fa015-9ec8-4903-8e2f-f3e847d550d1@kernel.org> <CAEemH2f67p=wqGrwYnoVCP1fR82xxwJv1xfbMmFrvNaP7LZJog@mail.gmail.com>
 <30a75bb5-7edd-42b1-9a94-8ffe017bdb0b@kernel.org>
In-Reply-To: <30a75bb5-7edd-42b1-9a94-8ffe017bdb0b@kernel.org>
From: Li Wang <liwang@redhat.com>
Date: Sun, 21 Dec 2025 19:56:01 +0800
X-Gm-Features: AQt7F2rnI-Hbfbtj1tUEzQSNIk4NyI7PS4n0WTNPViVW7sxU6wgWxbTOvJmvIYY
Message-ID: <CAEemH2cqZycJ2m1s=UDaCG0XfkaHc57632pbhNaDkV9py+U77g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftests/mm/charge_reserved_hugetlb: fix
 hugetlbfs mount size for large hugepages
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 5:49=E2=80=AFPM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 12/21/25 10:44, Li Wang wrote:
> > David Hildenbrand (Red Hat) <david@kernel.org> wrote:
> >> On 12/21/25 09:58, Li Wang wrote:
> >>> charge_reserved_hugetlb.sh mounts a hugetlbfs instance at /mnt/huge w=
ith
> >>> a fixed size of 256M. On systems with large base hugepages (e.g. 512M=
B),
> >>> this is smaller than a single hugepage, so the hugetlbfs mount ends u=
p
> >>> with effectively zero capacity (often visible as size=3D0 in mount ou=
tput).
> >>>
> >>> As a result, write_to_hugetlbfs fails with ENOMEM and the test can ha=
ng
> >>> waiting for progress.
> >>
> >> I'm curious, what's the history of using "256MB" in the first place (o=
r
> >> specifying any size?).
> >
> > Seems the script initializes it with "256MB" from:
> >
> > commit 29750f71a9b4cfae57cdddfbd8ca287eddca5503
> > Author: Mina Almasry <almasrymina@google.com>
> > Date:   Wed Apr 1 21:11:38 2020 -0700
> >
> >      hugetlb_cgroup: add hugetlb_cgroup reservation tests
>
> What would happen if we don't specify a size at all?

It still works well, I have gone through the whole file and
there is no subtest that relies on the 256M capability.

So we could just:

    mount -t hugetlbfs -o pagesize=3D${MB}M none /mnt/huge

--=20
Regards,
Li Wang


