Return-Path: <linux-kselftest+bounces-30238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4833DA7D8EB
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 11:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83A5175968
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23D922AE7E;
	Mon,  7 Apr 2025 08:59:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F022AE4E;
	Mon,  7 Apr 2025 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016395; cv=none; b=XhLvnoFrg6ben7uPWEGIpXekNWk587LnqXMo5LMxUcNv3WejS1b8UeUJGGP2ne6DBzgCX10b0uXBqwU6kPVHvK+CrHVH/sdebKTud2YFK3gEOnRozDlHgzWjBElfSCSU389m8Ibmiy9y7l0Vd33IocgzEuEQmKJIbu/FB7mzoRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016395; c=relaxed/simple;
	bh=/KZr0izSTAZMM0jVYPGx+EQyA76KAy1RBD0L3EszOIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdTcI6fiNiE+nXwqGpp9oFgLzZa+afKKeHwoXx7oBoX/OYfiTl55s9B4Cw9vqM4HyC/c06l2/8/DYSafsCWaKekgTdw65CgNHYLvCl2hvnRkRrmAfiXJ1Om3DKlQXqhfCHnH2mdoqdoh17xMd/HNFQSQH3dQGpV+FFNoomRO6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DB0768BFE; Mon,  7 Apr 2025 10:59:44 +0200 (CEST)
Date: Mon, 7 Apr 2025 10:59:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Muchun Song <muchun.song@linux.dev>
Cc: Huan Yang <link@vivo.com>, bingbu.cao@linux.intel.com,
	Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is broken, was Re: [RFC
 PATCH 0/6] Deep talk about folio vmap
Message-ID: <20250407085943.GA27481@lst.de>
References: <20250327092922.536-1-link@vivo.com> <20250404090111.GB11105@lst.de> <9A899641-BDED-4773-B349-56AF1DD58B21@linux.dev> <43DD699A-5C5D-429B-A2B5-61FBEAE2E252@linux.dev> <e9f44d16-fd9a-4d82-b40e-c173d068676a@vivo.com> <E4D6E02F-BC82-4630-8CB8-CD1A0163ABCF@linux.dev> <6f76a497-248b-4f92-9448-755006c732c8@vivo.com> <FDB7F930-8537-4B79-BAA6-AA782B39943A@linux.dev> <35D26C00-952F-481C-8345-E339F0ED770B@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35D26C00-952F-481C-8345-E339F0ED770B@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 07, 2025 at 02:43:20PM +0800, Muchun Song wrote:
> By the way, in case you truly struggle to comprehend the fundamental
> aspects of HVO, I would like to summarize for you the user-visible
> behaviors in comparison to the situation where HVO is disabled.
> 
> HVO Status		Tail Page Structures	Head Page Structures
> Enabled			Read-Only (RO)		Read-Write (RW)
> Disabled		Read-Write (RW)		Read-Write (RW)
> 
> The sole distinction between the two scenarios lies in whether the
> tail page structures are allowed to be written or not. Please refrain
> from getting bogged down in the details of the implementation of HVO.

This feels extremely fragile to me.  I doubt many people know what
operations needs read vs write access to tail pages.  Or for higher
level operations if needs access to tail pages at all.


