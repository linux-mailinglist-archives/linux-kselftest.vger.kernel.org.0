Return-Path: <linux-kselftest+bounces-30240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58977A7DA38
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 11:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220D6188BCD8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFE922FF21;
	Mon,  7 Apr 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ioe0kTZU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0878422FE06
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019351; cv=none; b=iC+Gczw55civwXp2RaA/w/CbpXWKNMf5X+ONlBE3IGFypGFRhY6GxytCHl7hOXjUSIkeUyE1lpk50Z9+RlTTjhQh9ocMJqe35iKxDWmwC6/0FHfM/G8BtTVaUT+w6211HXOncIlTdkUhwhdR8b+RQTLSwuibeiULHZvKpg9G6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019351; c=relaxed/simple;
	bh=DZ63rrAsGHtRItIF9LO8Z69pVpRXdsG0UIOS3yY/ZAw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gSZZlX5wDlmtPEgwOWGaxykVIlz1TKJKDy4HmHLaRrNIY9Qqqol1Hl9B/zwO8RfBvFkvPzA7Rn3q2ZCNXbxVmoOpHuv0V16HCTQsHLDZPuHto/dYMx8hpnigA3FPD8gEN50Hon5FhU3QGrYFZNHSKYlewCyGpgvd6THLcPxOu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ioe0kTZU; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744019347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xY51UqUYs+eWoTOCBh+Jna/CIahu4dovjoMPFMGK+94=;
	b=Ioe0kTZUDluJBwKyn71CrZez9rDEMB6zSMKpo+dmuXKcVyV5HkxteDiPlNtuTXAxXh/YCr
	+tbcirKNDPJAdHtNsPEF1atCVV+4DI5qhgzgJZ4zN4T0Zb/lhbjyS94pgHzTZEKgOPARLl
	daq/dx6lgL303v132nfYFpVxFTfuwUI=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is broken, was Re: [RFC
 PATCH 0/6] Deep talk about folio vmap
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20250407085943.GA27481@lst.de>
Date: Mon, 7 Apr 2025 17:48:27 +0800
Cc: Huan Yang <link@vivo.com>,
 bingbu.cao@linux.intel.com,
 Matthew Wilcox <willy@infradead.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org,
 opensource.kernel@vivo.com
Content-Transfer-Encoding: 7bit
Message-Id: <3DC6E604-3CE9-49E3-A688-DC7F424382DA@linux.dev>
References: <20250327092922.536-1-link@vivo.com>
 <20250404090111.GB11105@lst.de>
 <9A899641-BDED-4773-B349-56AF1DD58B21@linux.dev>
 <43DD699A-5C5D-429B-A2B5-61FBEAE2E252@linux.dev>
 <e9f44d16-fd9a-4d82-b40e-c173d068676a@vivo.com>
 <E4D6E02F-BC82-4630-8CB8-CD1A0163ABCF@linux.dev>
 <6f76a497-248b-4f92-9448-755006c732c8@vivo.com>
 <FDB7F930-8537-4B79-BAA6-AA782B39943A@linux.dev>
 <35D26C00-952F-481C-8345-E339F0ED770B@linux.dev>
 <20250407085943.GA27481@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Migadu-Flow: FLOW_OUT



> On Apr 7, 2025, at 16:59, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Mon, Apr 07, 2025 at 02:43:20PM +0800, Muchun Song wrote:
>> By the way, in case you truly struggle to comprehend the fundamental
>> aspects of HVO, I would like to summarize for you the user-visible
>> behaviors in comparison to the situation where HVO is disabled.
>> 
>> HVO Status Tail Page Structures Head Page Structures
>> Enabled Read-Only (RO) Read-Write (RW)
>> Disabled Read-Write (RW) Read-Write (RW)
>> 
>> The sole distinction between the two scenarios lies in whether the
>> tail page structures are allowed to be written or not. Please refrain
>> from getting bogged down in the details of the implementation of HVO.
> 
> This feels extremely fragile to me.  I doubt many people know what
> operations needs read vs write access to tail pages.  Or for higher
> level operations if needs access to tail pages at all.
> 

A compound page should modify its head page structure (e.g., refcount),
which is why `compound_head()` is widely used. Modifying its tail page
structures is incorrect. Users needn't worry about whether to modify
tail page structures. They should use `compound_head(tail)` to get the
head page structure and update it. All users must follow this rule (I
think folio-infrastructure also requires this). If a user tries to write
to a HugeTLB page's tail page, an exception will be raised as these tail
pages are read-only mapped to catch invalid operations.


