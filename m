Return-Path: <linux-kselftest+bounces-26940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26041A3B48D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 09:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A06317859B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B1C1DF724;
	Wed, 19 Feb 2025 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RnBz6kWs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A81DF277
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954127; cv=none; b=Y+5E5cFDxaugAT/P12UuIENkxJHiYU6sdPtjPgZFDv9u0QBDzgi+3BcW6S6tUnkl7ESzdiQjTbFoz707VgpLxlO6ZRQwxiYHxuYoaqh4LF0Vpb7V2SkbdAdTi2OaU7mDtQIDZ3UpngYo1c4pqM7iyDUevQclzI0tN1W+JSyF+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954127; c=relaxed/simple;
	bh=mS2ERImW1IWdcM2cHUONXcpUeVpV6rwp0Wo9NrUajqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXetsyIpYgU+oXqqSCtG3c45wEhYM83P1zBO7n8J2e5W6gdaN7o5dofVMMkJqtOtwsoOhZ7bzXg2aM3XXU/3DP+chl1ffNnlkzTlNLXHdeVpo4HYC5sO4Z2ZcEJShCW4U/fx8QEt7LmY+eSdbmkbIU0hJZ4tD7cO/GJzvBR4Pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RnBz6kWs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220e0575f5bso618855ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 00:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739954125; x=1740558925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh11V3R3PpQccWp7H0vYXQcsX+FHgC2HvQI3gNl8VR0=;
        b=RnBz6kWs79eMemi6iEUZfopQql4LGTqhWtQYz1vS7FKSApLJw+6tY51qp751kl3V9r
         fEooS42rQEGh8WcYJH90bnc1G5OXEV1KT7Lez4BB+KfCgs0mFg5R7zHmJzVadHTvl9z5
         z439NpPO/u5t/p34Blz+CQvq14T39BgHCjVQd+Te0v7jEeGKYRmQY9XrF7W29NIcQxIQ
         tImXdNIFRAf0qeu9IxMa+/1inoYKy1AQ+0W14tFcJpK+Dj9qeffhyVtkq+kjWPs+POtZ
         ls0HMER6fM42nGJ9rLIugKNr46k62nVUJINPpxfpgJteYisruTYNFPCoAait383n95Si
         BkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739954125; x=1740558925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nh11V3R3PpQccWp7H0vYXQcsX+FHgC2HvQI3gNl8VR0=;
        b=Q6ePVvhrWWtJrsyjTwp3aS4U9CDjn8RsNPdBLoMqX+lvnfoXj3XcZndtTZUvKwoC0t
         MHQEOdDmi0bEG/Ld52zpzolCJmnJGMjYajK2YUCsye5oChV1TNWVrEaB9r4PRsDauYcf
         +bK3Cw8qMKTzTFYDS4dEkY5xUC2UM5vHljRfvu333zyIwcWwtZVALBMgkDTI2GweXzIN
         S9AqGidqfBD6O6sizH4e3g7xKyW/gnpXgVzr/6bUK476lB0tiw0G+rHdYBqhSSY7E/co
         LOz3+pXBrjo9pQk1eQb5Ukzhfm4wYxBngoINqPGdOyjVsH0zsfrefUKs7dy7QQ3Efp3f
         3qnA==
X-Forwarded-Encrypted: i=1; AJvYcCVsIYJckX17PD895Q6K+cYkk13Ct2EJk+k8f8jflh8uMjZuQGFXV+jlIrukjc6ZakqTK/ZnLxoyl7Pr68WSsbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8O1uXj3xmjvi42s/2K6WLJCj4aBA1dR+p0topXvZ1vtUww3Uv
	JWWx4VCFRKX+luZZvTXI89gcSOIm9dHuakjl09aAo3QSfxYSPN7NzooQ0F5xz1d1JnY7h9D5ous
	p0Fgeuh/NnhCYH4anyK/JSlwhiPWuOaR6ZQJl
X-Gm-Gg: ASbGncu480MNcHWFGkngXCqvYjv4fpPV2jT44sIhsZ5D3Hp+MAV2Uik/eKzNLboiosm
	zTWiuli00y76R0AQ4BPv8pDNkO7Yv1TYrX9GS7/Ei1GIgnK5l2SAqzUqpUdapClrBuEk8ZXP9Tg
	6Jdv644iEq2i4kT91L3pTFN/yTkMscBg==
X-Google-Smtp-Source: AGHT+IF8lhN2VKRtkBG8lgw6HbFBNjGSvIa0tqHhUKQQlK5tOi+1VUQJdJ+dTtru3EjOzYbkzwwP/EYSufqagYHgcKs=
X-Received: by 2002:a17:902:d491:b0:217:8612:b690 with SMTP id
 d9443c01a7336-221740eacc2mr2096905ad.8.1739954124714; Wed, 19 Feb 2025
 00:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com> <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
In-Reply-To: <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 19 Feb 2025 00:35:12 -0800
X-Gm-Features: AWEUYZkFYO4honuUctBjczHtttLmlYcLayKN2sdlCl_V5hwlV_Nm6uGMdSDX7hk
Message-ID: <CAC_TJvfPNkJDWnG81GnJcFeMLYzN8=uM-oTrK6FKT7tD=E4TQg@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, 
	Juan Yescas <jyescas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 12:25=E2=80=AFAM Kalesh Singh <kaleshsingh@google.c=
om> wrote:
>
> On Thu, Feb 13, 2025 at 10:18=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > The guard regions feature was initially implemented to support anonymou=
s
> > mappings only, excluding shmem.
> >
> > This was done such as to introduce the feature carefully and incrementa=
lly
> > and to be conservative when considering the various caveats and corner
> > cases that are applicable to file-backed mappings but not to anonymous
> > ones.
> >
> > Now this feature has landed in 6.13, it is time to revisit this and to
> > extend this functionality to file-backed and shmem mappings.
> >
> > In order to make this maximally useful, and since one may map file-back=
ed
> > mappings read-only (for instance ELF images), we also remove the
> > restriction on read-only mappings and permit the establishment of guard
> > regions in any non-hugetlb, non-mlock()'d mapping.
>
> Hi Lorenzo,
>
> Thank you for your work on this.
>
> Have we thought about how guard regions are represented in /proc/*/[s]map=
s?
>
> In the field, I've found that many applications read the ranges from
> /proc/self/[s]maps to determine what they can access (usually related
> to obfuscation techniques). If they don't know of the guard regions it
> would cause them to crash; I think that we'll need similar entries to
> PROT_NONE (---p) for these, and generally to maintain consistency
> between the behavior and what is being said from /proc/*/[s]maps.

To clarify why the applications may not be aware of their guard
regions -- in the case of the ELF mappings these PROT_NONE (guard
regions) would be installed by the dynamic loader; or may be inherited
from the parent (zygote in Android's case).

>
> -- Kalesh
>
> >
> > It is permissible to permit the establishment of guard regions in read-=
only
> > mappings because the guard regions only reduce access to the mapping, a=
nd
> > when removed simply reinstate the existing attributes of the underlying
> > VMA, meaning no access violations can occur.
> >
> > While the change in kernel code introduced in this series is small, the
> > majority of the effort here is spent in extending the testing to assert
> > that the feature works correctly across numerous file-backed mapping
> > scenarios.
> >
> > Every single guard region self-test performed against anonymous memory
> > (which is relevant and not anon-only) has now been updated to also be
> > performed against shmem and a mapping of a file in the working director=
y.
> >
> > This confirms that all cases also function correctly for file-backed gu=
ard
> > regions.
> >
> > In addition a number of other tests are added for specific file-backed
> > mapping scenarios.
> >
> > There are a number of other concerns that one might have with regard to
> > guard regions, addressed below:
> >
> > Readahead
> > ~~~~~~~~~
> >
> > Readahead is a process through which the page cache is populated on the
> > assumption that sequential reads will occur, thus amortising I/O and,
> > through a clever use of the PG_readahead folio flag establishing during
> > major fault and checked upon minor fault, provides for asynchronous I/O=
 to
> > occur as dat is processed, reducing I/O stalls as data is faulted in.
> >
> > Guard regions do not alter this mechanism which operations at the folio=
 and
> > fault level, but do of course prevent the faulting of folios that would
> > otherwise be mapped.
> >
> > In the instance of a major fault prior to a guard region, synchronous
> > readahead will occur including populating folios in the page cache whic=
h
> > the guard regions will, in the case of the mapping in question, prevent
> > access to.
> >
> > In addition, if PG_readahead is placed in a folio that is now inaccessi=
ble,
> > this will prevent asynchronous readahead from occurring as it would
> > otherwise do.
> >
> > However, there are mechanisms for heuristically resetting this within
> > readahead regardless, which will 'recover' correct readahead behaviour.
> >
> > Readahead presumes sequential data access, the presence of a guard regi=
on
> > clearly indicates that, at least in the guard region, no such sequentia=
l
> > access will occur, as it cannot occur there.
> >
> > So this should have very little impact on any real workload. The far mo=
re
> > important point is as to whether readahead causes incorrect or
> > inappropriate mapping of ranges disallowed by the presence of guard
> > regions - this is not the case, as readahead does not 'pre-fault' memor=
y in
> > this fashion.
> >
> > At any rate, any mechanism which would attempt to do so would hit the u=
sual
> > page fault paths, which correctly handle PTE markers as with anonymous
> > mappings.
> >
> > Fault-Around
> > ~~~~~~~~~~~~
> >
> > The fault-around logic, in a similar vein to readahead, attempts to imp=
rove
> > efficiency with regard to file-backed memory mappings, however it diffe=
rs
> > in that it does not try to fetch folios into the page cache that are ab=
out
> > to be accessed, but rather pre-maps a range of folios around the faulti=
ng
> > address.
> >
> > Guard regions making use of PTE markers makes this relatively trivial, =
as
> > this case is already handled - see filemap_map_folio_range() and
> > filemap_map_order0_folio() - in both instances, the solution is to simp=
ly
> > keep the established page table mappings and let the fault handler take
> > care of PTE markers, as per the comment:
> >
> >         /*
> >          * NOTE: If there're PTE markers, we'll leave them to be
> >          * handled in the specific fault path, and it'll prohibit
> >          * the fault-around logic.
> >          */
> >
> > This works, as establishing guard regions results in page table mapping=
s
> > with PTE markers, and clearing them removes them.
> >
> > Truncation
> > ~~~~~~~~~~
> >
> > File truncation will not eliminate existing guard regions, as the
> > truncation operation will ultimately zap the range via
> > unmap_mapping_range(), which specifically excludes PTE markers.
> >
> > Zapping
> > ~~~~~~~
> >
> > Zapping is, as with anonymous mappings, handled by zap_nonpresent_ptes(=
),
> > which specifically deals with guard entries, leaving them intact except=
 in
> > instances such as process teardown or munmap() where they need to be
> > removed.
> >
> > Reclaim
> > ~~~~~~~
> >
> > When reclaim is performed on file-backed folios, it ultimately invokes
> > try_to_unmap_one() via the rmap. If the folio is non-large, then map_pt=
e()
> > will ultimately abort the operation for the guard region mapping. If la=
rge,
> > then check_pte() will determine that this is a non-device private
> > entry/device-exclusive entry 'swap' PTE and thus abort the operation in
> > that instance.
> >
> > Therefore, no odd things happen in the instance of reclaim being attemp=
ted
> > upon a file-backed guard region.
> >
> > Hole Punching
> > ~~~~~~~~~~~~~
> >
> > This updates the page cache and ultimately invokes unmap_mapping_range(=
),
> > which explicitly leaves PTE markers in place.
> >
> > Because the establishment of guard regions zapped any existing mappings=
 to
> > file-backed folios, once the guard regions are removed then the
> > hole-punched region will be faulted in as usual and everything will beh=
ave
> > as expected.
> >
> > Lorenzo Stoakes (4):
> >   mm: allow guard regions in file-backed and read-only mappings
> >   selftests/mm: rename guard-pages to guard-regions
> >   tools/selftests: expand all guard region tests to file-backed
> >   tools/selftests: add file/shmem-backed mapping guard region tests
> >
> >  mm/madvise.c                                  |   8 +-
> >  tools/testing/selftests/mm/.gitignore         |   2 +-
> >  tools/testing/selftests/mm/Makefile           |   2 +-
> >  .../mm/{guard-pages.c =3D> guard-regions.c}     | 921 ++++++++++++++++=
--
> >  4 files changed, 821 insertions(+), 112 deletions(-)
> >  rename tools/testing/selftests/mm/{guard-pages.c =3D> guard-regions.c}=
 (58%)
> >
> > --
> > 2.48.1

