Return-Path: <linux-kselftest+bounces-24597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10BDA12C8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 21:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7288164C93
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 20:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EF31D90BE;
	Wed, 15 Jan 2025 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0aQhSg8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510E191F75
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972888; cv=none; b=fG7wc+4d7i1M6AildRrk1Y/bXETsTZ0Z8YbbEpxLvHgdOl3Am1nZUMdmPTvDAZVqhgWmd/SA60WQEg+nrhkjwcq3x6q1lkUUvdkp+gVOokhAWua0hJyfveagx6FlRYgNKFhxu/8QlxPpjhHHLoQGeZWl2QzU2vOjLOCDadi2LiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972888; c=relaxed/simple;
	bh=j2tbwbmQn5ojyoQrRWYpmGHNivSH/dzW0guO2sBJeaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJsytFR06dNDKxXTQxnmzdrFglst92WTHBUvHh9BrWrNNclbCiHU/0IRvpuEu+/K+8EnikbI7S0LJwiwLV/ekyA8At/8C4+rjz46wi5hGMUgYXyAcBKbQ/Y5/okukNijwpoAHOA+unX4OJG81jLxOi5/p5nvsCCaoBGspPKF/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0aQhSg8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736972885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLWon5AXaxh3rMajeQBRrd7Zc/AYxckEZbRB/3d+iIc=;
	b=B0aQhSg81U6FwQm4HyqLiUKMYZre7aLIOL0rCELZD29g1PBPyD9A13p4Q4gXlJMhSYmNgf
	tMgZTEsHyRh8r32KUkER6jkDwJwMsPGH0m1G7wqtfeGjhO5o+C0L+VVsW6Bby0fGLPVDd+
	FXmtgrm66tCYrzYrLKpAxtf3tKxLk24=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-N3BCmew0NSe91xBLu3UgxQ-1; Wed, 15 Jan 2025 15:28:04 -0500
X-MC-Unique: N3BCmew0NSe91xBLu3UgxQ-1
X-Mimecast-MFC-AGG-ID: N3BCmew0NSe91xBLu3UgxQ
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8f6903d2eso3791626d6.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 12:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972884; x=1737577684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLWon5AXaxh3rMajeQBRrd7Zc/AYxckEZbRB/3d+iIc=;
        b=NedDR9Cm8bAYB/5dICcRDdmbs2s8jHNvfdmrZIQESD76aZKFOxUuuBY3Z2vN/5Os0b
         1DCKD3nlYWz3wCh+So8xxUNrsCZWqU1XHV2utWy4HohxqJ2v7ARzT1+HHlDyj2a+vSfm
         1s4gmJRSBVLUQc/8udXvfiYukGn9b9Jlq5tG8tE2OTgjzyCDoCvQw+gZdunX/D8KD8jQ
         0qTXGL5CRYguz5kE1cKB2j4OPZPvJ+qKgA4GYRCF02Q64OpbP1yEBaWUMLIFLJ7wvp3s
         gARrfo6/Mfsqi8uvF6GJHqCbbrYsHDyBboZ+vZKnTF6eT4DrwERqkudlrq/siTg3i9Cm
         2sSw==
X-Forwarded-Encrypted: i=1; AJvYcCWOODcqeTZDEe4XSpshTwUc5r6E2TUtHq3ainaCypdrDlUrKZjZ3exXSEb82qZUgY3JV9EVt84FcK+aOwLZn7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/80cxQi4GPMq6bp4zn6kwh1SzOyJuMpDl9KZYLvQXiaCEf68
	t4wk2z4TFfbMUlIfrrTH3Ic9LyJkczTCbz8YoJ2zJxBEqfujyPV88tvM4srV9YSJmpV9ZkT0VFu
	dU3krfwvP2N+kzDYTpfXaNcR4MEdJ6rLaNeEnLYik+Jxo0b1cC0sR7fiUL9pJBARGwg==
X-Gm-Gg: ASbGncuddZRpyhd1nK7yfurzzdd8Ip4Fod0dfRpSazyjaODYIp9eiK73ZkgpyiCE9vM
	o7bRQrSvwlasrt39HaU6i0iamnlVjQudRNz2aL0jXY0xB3Fr2wL+Ak9Awh6+xrPu1LnOyLlrf87
	kmoRfQKoaxZDABGu2k3JOAoUTKnwk1DfHYfg/upaOZUcQqL8m8tWaUI7DGxgIpw7x6rMf17fgMZ
	TuxP4gohluayLMayax/fY1mTNT86FSt/lWE4vbmsdiZgpuSDMGWDVMWDz9sW5BO5gGEQ/ToQxUU
	a40ehyp/fq7N9fYPxg==
X-Received: by 2002:ad4:576c:0:b0:6d8:8b9d:1500 with SMTP id 6a1803df08f44-6df9b2ddabfmr548161456d6.36.1736972883928;
        Wed, 15 Jan 2025 12:28:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkSIbuo3F6Xt9mSQetiuDbpnaGmRVyr2seY+8TScQrao1ZzQitek2oxSDQy2ErmvKglV0oCg==
X-Received: by 2002:ad4:576c:0:b0:6d8:8b9d:1500 with SMTP id 6a1803df08f44-6df9b2ddabfmr548161216d6.36.1736972883643;
        Wed, 15 Jan 2025 12:28:03 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad9adf79sm68242536d6.51.2025.01.15.12.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:28:02 -0800 (PST)
Date: Wed, 15 Jan 2025 15:28:00 -0500
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Message-ID: <Z4gaUAt9w8s1rLPK@x1n>
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
 <20250107144755.1871363-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107144755.1871363-2-ryan.roberts@arm.com>

On Tue, Jan 07, 2025 at 02:47:52PM +0000, Ryan Roberts wrote:
> When mremap()ing a memory region previously registered with userfaultfd
> as write-protected but without UFFD_FEATURE_EVENT_REMAP, an
> inconsistency in flag clearing leads to a mismatch between the vma flags
> (which have uffd-wp cleared) and the pte/pmd flags (which do not have
> uffd-wp cleared). This mismatch causes a subsequent mprotect(PROT_WRITE)
> to trigger a warning in page_table_check_pte_flags() due to setting the
> pte to writable while uffd-wp is still set.
> 
> Fix this by always explicitly clearing the uffd-wp pte/pmd flags on any
> such mremap() so that the values are consistent with the existing
> clearing of VM_UFFD_WP. Be careful to clear the logical flag regardless
> of its physical form; a PTE bit, a swap PTE bit, or a PTE marker. Cover
> PTE, huge PMD and hugetlb paths.
> 
> Co-developed-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Closes: https://lore.kernel.org/linux-mm/810b44a8-d2ae-4107-b665-5a42eae2d948@arm.com/
> Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Cc: stable@vger.kernel.org

Nothing I see wrong:

Reviewed-by: Peter Xu <peterx@redhat.com>

One trivial thing: some multiple-line comments is following the net/ coding
style rather than mm/, but well.. I don't think it's a huge deal.

https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting

Thanks again.

-- 
Peter Xu


