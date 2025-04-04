Return-Path: <linux-kselftest+bounces-30096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A52A7B96F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 11:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CCB3B66C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F471A23AD;
	Fri,  4 Apr 2025 09:01:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0C611E;
	Fri,  4 Apr 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743757283; cv=none; b=tEXUSb9A1luoFgLZhR5sHIZ8UlFnB3eZjbGwCzT/NBn8saZqghCDJroqdYZHevqfJtzeN2eMgzR/DWGE7ZJQDitB5U6vJoaVGaYaegnV+mTHHfuz8OYZfCDd/+RpGkI6UKgMFFaVmeBywHyq4c5AA+GV0xNdwjyznZ7V/u66/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743757283; c=relaxed/simple;
	bh=FUkQE59vOl2KrCQ+b2YhVodynXOMSSv8eih8WYtzQlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFvkJLvY3FQacUkc9wwC9kARp52fm8QfIRoFdJ9FUh7OZwM7tGzqNiO9u3IhA9eXTbWJByyf0uATEfsPB8QwgnGt61kDV5IVpC7IRivQfdw8WMX5FdslZ+FoGvRXIcQsvBURnOiUD5DGDvgPYxdyowB8v99GgIJvF/804t06O78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 04C5168B05; Fri,  4 Apr 2025 11:01:12 +0200 (CEST)
Date: Fri, 4 Apr 2025 11:01:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Huan Yang <link@vivo.com>
Cc: bingbu.cao@linux.intel.com, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>, Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	opensource.kernel@vivo.com, Muchun Song <muchun.song@linux.dev>
Subject: CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is broken, was Re: [RFC PATCH
 0/6] Deep talk about folio vmap
Message-ID: <20250404090111.GB11105@lst.de>
References: <20250327092922.536-1-link@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327092922.536-1-link@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

After the btrfs compressed bio discussion I think the hugetlb changes that
skip the tail pages are fundamentally unsafe in the current kernel.

That is because the bio_vec representation assumes tail pages do exist, so
as soon as you are doing direct I/O that generates a bvec starting beyond
the present head page things will blow up.  Other users of bio_vecs might
do the same, but the way the block bio_vecs are generated are very suspect
to that.  So we'll first need to sort that out and a few other things
before we can even think of enabling such a feature.


