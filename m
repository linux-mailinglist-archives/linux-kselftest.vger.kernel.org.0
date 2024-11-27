Return-Path: <linux-kselftest+bounces-22558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07CA9DA16F
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 05:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9659128429B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 04:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CED76A8D2;
	Wed, 27 Nov 2024 04:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vIQ/OWTz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019EC18E0E;
	Wed, 27 Nov 2024 04:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732681344; cv=none; b=LX0m9rIYz8Bw460luR83bHasIgpOTZpw7InQhgORaUmd/gJlCSpHEeLowGUMgqbfOkgDvPKmbyJjM4zes06iS2NXOKdPiWlWSsf/enM8knygIrlRgPsqh+2ZEpFMuoUOd4ujxQHus7bSK0adpOyrmJkaD85KKWAEVUsZQeUCxAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732681344; c=relaxed/simple;
	bh=o6u8e0NpNmDukk8wDUY+TU+51ndzfjh95tgvttkNYTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVjOSYz8kgzSnl0Y/66VxsEVjKJBtsbRuqUyKSAOoJF+ALl64U737t40ei6gNsugkBSYP82ZXI4QHzytR3wlKebYN3GgELNEnXVcCHRqitiA0gYQ5LO5jiHYceKgNb9RFvOd4BRLtQDeDEsz1GfpCu16T/7xLK9PYkHjMm05l3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vIQ/OWTz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lsl6ovAWE+1J5VPRu7emBoNaP80Jn7k3CUy4+NuzBgo=; b=vIQ/OWTzOJMV8aZvPso4/T2Krm
	FcXIfiRo7iY8snv8wTbCWgP3cH/xrv3DDF6C543FPlzLfkcqaXvgVMv6S278Upt10mQsfPk3z+gpu
	oAcdtXtn4LHDRQgxG+00C29MHmBr7j68+dcjugVjBw0vH+ejTzetn+bdnZs18TZAZND+i5iv7DTXv
	1n1R8UVlTE9vKn3awOZ4GQ6n5X0QLkTZnmWSmzazfZfdZ39NmlWyigGF4+qNfUIAWSBzgTdSRCVQe
	2J3xAj5hn2hnlogdDDBdQr36cnSBojfyj2C2U+KrJroGFx+c4wJktJHb9+iz2my79ldVI5vUNqJZ8
	Qpwqg4vg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tG9Yl-00000000sPD-0Ish;
	Wed, 27 Nov 2024 04:21:51 +0000
Date: Wed, 27 Nov 2024 04:21:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Gregory Price <gregory.price@memverge.com>,
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Watson <ozzloy@each.do>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/9] mm: aggregate workingset information into
 histograms
Message-ID: <Z0aeXrpY-deSfO8v@casper.infradead.org>
References: <20241127025728.3689245-1-yuanchu@google.com>
 <20241127025728.3689245-2-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127025728.3689245-2-yuanchu@google.com>

On Tue, Nov 26, 2024 at 06:57:20PM -0800, Yuanchu Xie wrote:
> diff --git a/mm/internal.h b/mm/internal.h
> index 64c2eb0b160e..bbd3c1501bac 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -470,9 +470,14 @@ extern unsigned long highest_memmap_pfn;
>  /*
>   * in mm/vmscan.c:
>   */
> +struct scan_control;
> +bool isolate_lru_page(struct page *page);

Is this a mismerge?  It doesn't exist any more.

