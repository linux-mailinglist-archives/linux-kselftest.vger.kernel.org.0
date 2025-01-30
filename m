Return-Path: <linux-kselftest+bounces-25406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2520DA22799
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 03:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D21287A2A6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 02:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2362A70814;
	Thu, 30 Jan 2025 02:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNm7qmWW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A442556E
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738202566; cv=none; b=ID6dsyupBxoyS7WecUfwWZDAcFZcJXTiIzPDrC84CafANvx4PTDG2E4qUXiRr1qpnOHndOd9YAF68QqSwcQ1n/mAwuLsHUnhQzXlstQggg+HXhHfVheDZA75L0Zx37fxfibt8ScrISlRA+ZQJhN2JM/66rB9Aoh43J+PKgbwPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738202566; c=relaxed/simple;
	bh=n/OeGdeZMVIJFEVcwDCl7iqV15bGqS8grI/CpofheSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbfFuyPLWezG3KD0b7pjSGX+pC4oiOAl+/2xKRauQ4AL3E0sLsdqFm5kuV5IG54iZclhHP+jGsp2G/gqzE3XH3PpgCsTXiQfWTWTB8sJd1HEvj3cXSgqeq0qEOhSqzlFekAs7IQdlDcplRwvgvl76jghq/J1zCz6nCDX1CsGsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNm7qmWW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2163affd184so41935ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 18:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738202563; x=1738807363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjUEKGcrUN8SEEUn3045QyzgbV2Muq4d8woD1luLXEo=;
        b=eNm7qmWWTXmn2+VkKG3q0+oPZyixQ21wqQYBZqY8GDrGDlleD7XFm/8TN+Oqqx80M3
         S/f2X5hbWwderjxXwXbgLU2FxNjEGOCKK6R5+ZYAKf6QSofDYVKgbnJx9uxNMUkR3K73
         cYmqc0caKkQz7IEsQjspeOAoiGvc9yyjCu3qfNFpk5VxjpOSeLqacwEQfTT0IJI4Yo+x
         mIcAQHk34O4iPu1XMdrTtUxSao2j4SrRcSUQUUHmoHQlaCRb+huHW8Y4rjzqWEvttiT1
         rCU8YUuoC77sA+RF8BeNqZb7LBxC6eWuVrgJX3g9XVtVOFwZDJfZpbJ4HEH3x6g1MMkX
         LXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738202563; x=1738807363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjUEKGcrUN8SEEUn3045QyzgbV2Muq4d8woD1luLXEo=;
        b=VZzdt1kj01lI0y2xVyRDpE3S7eW2RvywLvqZ9WJRcg7gtIVW7DAN6CtSUs0od33iAP
         JyEsBo41hCUt83sd7yJsWTqV+jYW/Zul+TcWeW/QLEVglOFKtecUORU3Ku69W/DcQFjI
         bGLcs00cfZZoHBrPNBXEoOkoIBrsFLmXxXAUTdvh2kSI/ca+LFSU7jEmSW1vmdA5+7z1
         YS3fOE9dZd0gfYYnf0mYH4o77lYzNqd3AQl81MqPOuV4mJBlJpMk0KNeTRmau5+qeeqO
         i0q1k0oO0hIKCbT5UeAFW/PDnywh7zUE8dXkwFrKy8BZ7mxJ3n+VxxmZchbTSzCjj38K
         aVBA==
X-Forwarded-Encrypted: i=1; AJvYcCUsAJeOcR8ArpdNr+A096SfRWJjCcChisZcW23PXpsJmAWT07UqUHScY33gr6G0rfwzCyZg+WbdMv7k43sLI74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+GdmDR3Jkc8QQc1fmfQsoJzKKFBDGJ2VEK6V0Iwa2a0dnjxXc
	rRF/UAkCHNZVrDK5kjcxwR/WaNNyGDKSsR9xS8APiG9HfoyvZHMbMFD/VYHR0A75AENkRkfXKoX
	aVfxqSiruaIfGzicacqgFMKWAy6QS8bQV/H3i
X-Gm-Gg: ASbGncvPeVRQACkDVgDwjEaZC/i5j00i0oa0iW3Te3yUIBoXbohqeACoDVXN8BYXnZQ
	Pmkn7QXtuNoely0i3rcesi4TSbj0svh5+FdsCoCupEmomCGQ7YclvkUTsWQ8JqU56EjddZrhtPP
	td02oQHtvyrkDCg5rxi/Yezuvbow==
X-Google-Smtp-Source: AGHT+IFE4A3aWM8yz21uOrZOg4SChpOzryWR+ItPTzgeX3qzwaFRLrgsLB6RJr5+4uESj8JF/qvVZaYyrmavlvqmppA=
X-Received: by 2002:a17:902:fc4b:b0:215:9ab0:402 with SMTP id
 d9443c01a7336-21de24504dfmr1287495ad.18.1738202562597; Wed, 29 Jan 2025
 18:02:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJj2-QFdP6DKVQJ4Tw6rdV+XtgDihe=UOnvm4cm-q61K0hq6CQ@mail.gmail.com>
 <20241211195329.60224-1-sj@kernel.org>
In-Reply-To: <20241211195329.60224-1-sj@kernel.org>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 29 Jan 2025 18:02:26 -0800
X-Gm-Features: AWEUYZmCJuhnrHdMr4LNNVLS2bbqy0msDks-3N4T6wXtjurzCtTNwSUNxZIoRCo
Message-ID: <CAJj2-QEaLTasfQgb=VFfnbOmkcXU3kw2VbsNummNEq0V3b9jdw@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] mm: workingset reporting
To: SeongJae Park <sj@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Lance Yang <ioworker0@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
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

On Wed, Dec 11, 2024 at 11:53=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Fri, 6 Dec 2024 11:57:55 -0800 Yuanchu Xie <yuanchu@google.com> wrote:
>
> > Thanks for the response Johannes. Some replies inline.
> >
> > On Tue, Nov 26, 2024 at 11:26\u202fPM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> > >
> > > On Tue, Nov 26, 2024 at 06:57:19PM -0800, Yuanchu Xie wrote:
> > > > This patch series provides workingset reporting of user pages in
> > > > lruvecs, of which coldness can be tracked by accessed bits and fd
> > > > references. However, the concept of workingset applies generically =
to
> > > > all types of memory, which could be kernel slab caches, discardable
> > > > userspace caches (databases), or CXL.mem. Therefore, data sources m=
ight
> > > > come from slab shrinkers, device drivers, or the userspace.
> > > > Another interesting idea might be hugepage workingset, so that we c=
an
> > > > measure the proportion of hugepages backing cold memory. However, w=
ith
> > > > architectures like arm, there may be too many hugepage sizes leadin=
g to
> > > > a combinatorial explosion when exporting stats to the userspace.
> > > > Nonetheless, the kernel should provide a set of workingset interfac=
es
> > > > that is generic enough to accommodate the various use cases, and ex=
tensible
> > > > to potential future use cases.
> > >
> > > Doesn't DAMON already provide this information?
> > >
> > > CCing SJ.
> > Thanks for the CC. DAMON was really good at visualizing the memory
> > access frequencies last time I tried it out!
>
> Thank you for this kind acknowledgement, Yuanchu!
>
> > For server use cases,
> > DAMON would benefit from integrations with cgroups.  The key then would=
 be a
> > standard interface for exporting a cgroup's working set to the user.
>
> I show two ways to make DAMON supports cgroups for now.  First way is mak=
ing
> another DAMON operations set implementation for cgroups.  I shared a roug=
h idea
> for this before, probably on kernel summit.  But I haven't had a chance t=
o
> prioritize this so far.  Please let me know if you need more details.  Th=
e
> second way is extending DAMOS filter to provide more detailed statistics =
per
> DAMON-region, and adding another DAMOS action that does nothing but only
> accounting the detailed statistics.  Using the new DAMOS action, users wi=
ll be
> able to know how much of specific DAMON-found regions are filtered out by=
 the
> given filter.  Because we have DAMOS filter type for cgroups, we can know=
 how
> much of workingset (or, warm memory) belongs to specific groups.  This ca=
n be
> applied to not only cgroups, but for any DAMOS filter types that exist (e=
.g.,
> anonymous page, young page).
>
> I believe the second way is simpler to implement while providing informat=
ion
> that sufficient for most possible use cases.  I was anyway planning to do=
 this.
For a container orchestrator like kubernetes, the node agents need to
be able to gather the working set stats at a per-job level. Some jobs
can create sub-hierarchies as well, so it's important that we have
hierarchical stats.

Do you think it's a good idea to integrate DAMON to provide some
aggregate stats in a memory controller file? With the DAMOS cgroup
filter, there can be some kind of interface that a DAMOS action or the
damo tool could call into. I feel that would be a straightforward and
integrated way to support cgroups.

Yuanchu

