Return-Path: <linux-kselftest+bounces-26938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E557AA3B39D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 09:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7B47A58A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E21C760D;
	Wed, 19 Feb 2025 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tq95LEUC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1642A93
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953569; cv=none; b=MXprod0eD1oZ6BbXfOT2YBJv8iw6H/B8HqgSHvPwZVB9nzE0m3zAPN0nP1eOODd7w9bMzenaoO7KW8flLu0z/a05UevGot+QlocYYJ7/IDi6yLZFVBbfb8pCfzemt0xiLQ346qalYpRtm+DkSyv9EIzsAQ+xnGxcWB4nbdi3lWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953569; c=relaxed/simple;
	bh=vrFCMIA7KIYH8LaNLZG0B9v640qqPtsEhFjTdIsfPJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6EcXfyo2YllBtKHu+VmdmCw13KbFC0IT8RPM/0yZ77OfmyBFN38oQ6ASKWHYIW36gCnzA9yNW0nCHb56b2zCtzEqZJ5wh8RSExF3TJ9shJhHwqC7iTKSp8np0E2riMzYF4cfZZeTCx7yKzOfr0od5YxjHrlUplKVdEsYWngafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tq95LEUC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220e0575f5bso617285ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 00:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739953563; x=1740558363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t5Onokz1b/svrph82CzzTpTF1Pr5YEmQG97WWbLUbs=;
        b=Tq95LEUCsk3ndAqVXjtcpKhnrR+ZRUhcLcPSEa42LSMM6ar++fPe5UprmQTdMF/Eha
         0UEwyuy14Q2qTsL4NHU+3JgYHJDgkxzQBhb5xvDcCDUtZMZwFTNgA6zokIl/OmmwfB5D
         zddaiQKAhmuTDXEYUDHZ81wK84hhbtQRwSfF7GvyG+7shVZGqJoN65NqqsvF7MKTMpcH
         h73XxlTqzXrk4xUZitODEMuSFY6reSqIloz1lNVcPF2RJwQLDpsmklWTpcQdO+z1bns4
         4XzEjDmAK6U//7RdVMLDPKqBIQDepxcKNlaA65e9nKJaVux3bPUvTym7yoGUcO2G/M0v
         8a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739953564; x=1740558364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+t5Onokz1b/svrph82CzzTpTF1Pr5YEmQG97WWbLUbs=;
        b=B6DyRWL3l10eAFhXEL8tqc31YFxaOfleWrNbUOckzfsEm5wPmy4Kw+mkCnn5J41OjX
         AV9mpQtLO6Hy3n6VCLOB+erITKBhDZ8akZcUagam17Q6aEd2CI/Saip+p6vDss9SAYQ4
         mOmt/1V/T9JYmPVWxZznLnAdQDQzYdhOMhz5Kpq3Dv2jzX21sNLkGFURa0l09BVneMFE
         BNlcjO6OMytfv4fDr/qNxqVS+yxo4QtySzZXmV7OT7aEgoe6CuMOaj2kTRxRKFar3Pgg
         AH2Wf5XowaG0Z1CHERPkFU6hkZh+q9XtjaUJk6GnHbfDd/utxv+XLzZBRc04acdybVaP
         RAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX214fGFtKbfeDMUx7WPTb1EYaARk0i9ZEMMTQJ4k8orebSyoIyTnqkQITlQfKIDWyzoPoYq5HoLyYUswSY39E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2y7QoFCbsny69JwLD1Ab+JnfRLWvlrGNqGs4MkAELfPJyiOzJ
	5crWgy+TsdnI1Zfl3nENGwLr2UzokFN6HS2Sq8A1KVSgK/mo9UBRFZcA1EBkdUkzS91lvLzWrKA
	EVkCPmCclB/Z3JEThxyeING80yPQQvaOJ0xZ7
X-Gm-Gg: ASbGncvjh1s7MfxYzzbnk8CNyIz8uIrJHhxximkYVPnqo6Rn4OzveUJUUbfotYH2fOz
	zvYzTQydpaQCO77MvLzkQm/kAsRGefa7NIKi4iynbLqVrZrndguKKqzEAm2P/b7D2YXglXEQ0qL
	hgMZm4sIf/Th8XiQl4Opoof49jZaDwuQ==
X-Google-Smtp-Source: AGHT+IEtWm56/q0Ma1nZnd6a0UtnIqMxj4FqJa/1GqPlJ/2nNKHewuObdmh1s2j/K5XMPESqCPuxQ8/36BYaDous39E=
X-Received: by 2002:a17:902:e883:b0:220:c905:68a2 with SMTP id
 d9443c01a7336-22175a85109mr1518545ad.5.1739953563410; Wed, 19 Feb 2025
 00:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 19 Feb 2025 00:25:51 -0800
X-Gm-Features: AWEUYZnXTwP78vbAHDN0pfKRVGtNSGUzzBBn7zOfu-Xg7h4c2hpipi0C25LOOb4
Message-ID: <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
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

On Thu, Feb 13, 2025 at 10:18=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> The guard regions feature was initially implemented to support anonymous
> mappings only, excluding shmem.
>
> This was done such as to introduce the feature carefully and incrementall=
y
> and to be conservative when considering the various caveats and corner
> cases that are applicable to file-backed mappings but not to anonymous
> ones.
>
> Now this feature has landed in 6.13, it is time to revisit this and to
> extend this functionality to file-backed and shmem mappings.
>
> In order to make this maximally useful, and since one may map file-backed
> mappings read-only (for instance ELF images), we also remove the
> restriction on read-only mappings and permit the establishment of guard
> regions in any non-hugetlb, non-mlock()'d mapping.

Hi Lorenzo,

Thank you for your work on this.

Have we thought about how guard regions are represented in /proc/*/[s]maps?

In the field, I've found that many applications read the ranges from
/proc/self/[s]maps to determine what they can access (usually related
to obfuscation techniques). If they don't know of the guard regions it
would cause them to crash; I think that we'll need similar entries to
PROT_NONE (---p) for these, and generally to maintain consistency
between the behavior and what is being said from /proc/*/[s]maps.

-- Kalesh

>
> It is permissible to permit the establishment of guard regions in read-on=
ly
> mappings because the guard regions only reduce access to the mapping, and
> when removed simply reinstate the existing attributes of the underlying
> VMA, meaning no access violations can occur.
>
> While the change in kernel code introduced in this series is small, the
> majority of the effort here is spent in extending the testing to assert
> that the feature works correctly across numerous file-backed mapping
> scenarios.
>
> Every single guard region self-test performed against anonymous memory
> (which is relevant and not anon-only) has now been updated to also be
> performed against shmem and a mapping of a file in the working directory.
>
> This confirms that all cases also function correctly for file-backed guar=
d
> regions.
>
> In addition a number of other tests are added for specific file-backed
> mapping scenarios.
>
> There are a number of other concerns that one might have with regard to
> guard regions, addressed below:
>
> Readahead
> ~~~~~~~~~
>
> Readahead is a process through which the page cache is populated on the
> assumption that sequential reads will occur, thus amortising I/O and,
> through a clever use of the PG_readahead folio flag establishing during
> major fault and checked upon minor fault, provides for asynchronous I/O t=
o
> occur as dat is processed, reducing I/O stalls as data is faulted in.
>
> Guard regions do not alter this mechanism which operations at the folio a=
nd
> fault level, but do of course prevent the faulting of folios that would
> otherwise be mapped.
>
> In the instance of a major fault prior to a guard region, synchronous
> readahead will occur including populating folios in the page cache which
> the guard regions will, in the case of the mapping in question, prevent
> access to.
>
> In addition, if PG_readahead is placed in a folio that is now inaccessibl=
e,
> this will prevent asynchronous readahead from occurring as it would
> otherwise do.
>
> However, there are mechanisms for heuristically resetting this within
> readahead regardless, which will 'recover' correct readahead behaviour.
>
> Readahead presumes sequential data access, the presence of a guard region
> clearly indicates that, at least in the guard region, no such sequential
> access will occur, as it cannot occur there.
>
> So this should have very little impact on any real workload. The far more
> important point is as to whether readahead causes incorrect or
> inappropriate mapping of ranges disallowed by the presence of guard
> regions - this is not the case, as readahead does not 'pre-fault' memory =
in
> this fashion.
>
> At any rate, any mechanism which would attempt to do so would hit the usu=
al
> page fault paths, which correctly handle PTE markers as with anonymous
> mappings.
>
> Fault-Around
> ~~~~~~~~~~~~
>
> The fault-around logic, in a similar vein to readahead, attempts to impro=
ve
> efficiency with regard to file-backed memory mappings, however it differs
> in that it does not try to fetch folios into the page cache that are abou=
t
> to be accessed, but rather pre-maps a range of folios around the faulting
> address.
>
> Guard regions making use of PTE markers makes this relatively trivial, as
> this case is already handled - see filemap_map_folio_range() and
> filemap_map_order0_folio() - in both instances, the solution is to simply
> keep the established page table mappings and let the fault handler take
> care of PTE markers, as per the comment:
>
>         /*
>          * NOTE: If there're PTE markers, we'll leave them to be
>          * handled in the specific fault path, and it'll prohibit
>          * the fault-around logic.
>          */
>
> This works, as establishing guard regions results in page table mappings
> with PTE markers, and clearing them removes them.
>
> Truncation
> ~~~~~~~~~~
>
> File truncation will not eliminate existing guard regions, as the
> truncation operation will ultimately zap the range via
> unmap_mapping_range(), which specifically excludes PTE markers.
>
> Zapping
> ~~~~~~~
>
> Zapping is, as with anonymous mappings, handled by zap_nonpresent_ptes(),
> which specifically deals with guard entries, leaving them intact except i=
n
> instances such as process teardown or munmap() where they need to be
> removed.
>
> Reclaim
> ~~~~~~~
>
> When reclaim is performed on file-backed folios, it ultimately invokes
> try_to_unmap_one() via the rmap. If the folio is non-large, then map_pte(=
)
> will ultimately abort the operation for the guard region mapping. If larg=
e,
> then check_pte() will determine that this is a non-device private
> entry/device-exclusive entry 'swap' PTE and thus abort the operation in
> that instance.
>
> Therefore, no odd things happen in the instance of reclaim being attempte=
d
> upon a file-backed guard region.
>
> Hole Punching
> ~~~~~~~~~~~~~
>
> This updates the page cache and ultimately invokes unmap_mapping_range(),
> which explicitly leaves PTE markers in place.
>
> Because the establishment of guard regions zapped any existing mappings t=
o
> file-backed folios, once the guard regions are removed then the
> hole-punched region will be faulted in as usual and everything will behav=
e
> as expected.
>
> Lorenzo Stoakes (4):
>   mm: allow guard regions in file-backed and read-only mappings
>   selftests/mm: rename guard-pages to guard-regions
>   tools/selftests: expand all guard region tests to file-backed
>   tools/selftests: add file/shmem-backed mapping guard region tests
>
>  mm/madvise.c                                  |   8 +-
>  tools/testing/selftests/mm/.gitignore         |   2 +-
>  tools/testing/selftests/mm/Makefile           |   2 +-
>  .../mm/{guard-pages.c =3D> guard-regions.c}     | 921 ++++++++++++++++--
>  4 files changed, 821 insertions(+), 112 deletions(-)
>  rename tools/testing/selftests/mm/{guard-pages.c =3D> guard-regions.c} (=
58%)
>
> --
> 2.48.1

