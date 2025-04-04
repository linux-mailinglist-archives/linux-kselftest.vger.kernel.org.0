Return-Path: <linux-kselftest+bounces-30098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E02A7BA6E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 12:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB76117147D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A16E186295;
	Fri,  4 Apr 2025 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l55TQE1g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA051624C9
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761322; cv=none; b=GBjBz+EuIuzpwRTsXxbVO6cdGF1nQJUPO7ipED0dOOTwHgCFL92rjK02/YNj1XfTo1mgWCwvqPTTWprd6MAvCEReUfpevUiaUJJT9r4p6Ke855xx25ZDyJEXb+X26UuoX7SNA7otDmAO91lklMRK6gwhueLXBbuW3XiTBXGhS9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761322; c=relaxed/simple;
	bh=IfOkvZ5xzGioGR8Ov7Gy3KqIuipOAaItVq5A+VFLtrI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Xjds6uYBwOhFJ4+i+EZCUJmz0h+y1PobC/WLoRTABadfShLxGy6uVNAPNaXbX9Jwg07N04KkRWk5q2O5RZE+2eX0aItJkBOh4hvEMU7BpgdFr3yvboEJPqZwLps+vfX8fPhq9HUtrTQy02QmldlGJFuVuIoNzfh12m84y1ohj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l55TQE1g; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743761317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H3vWWRH8W6vSZf9b1BUtRvjzptf2hYf7bVz0hYZoaVk=;
	b=l55TQE1g/+e4KBgCOcGnu2XR1SFz6vXlDu9SB52QszYdsR2e9jqG5Puuvjqj6894HcRP7g
	AXC+6FHsyF38ePGmjeNrpYfvmhkC+Gr97PBm4ZQ2YcTxuop+qctK73VjuvsL1xsVpFVxo5
	oWgIrkZXg5yN42z6egTF3GqXNsWU2B4=
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
In-Reply-To: <9A899641-BDED-4773-B349-56AF1DD58B21@linux.dev>
Date: Fri, 4 Apr 2025 18:07:50 +0800
Cc: bingbu.cao@linux.intel.com,
 Christoph Hellwig <hch@lst.de>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <43DD699A-5C5D-429B-A2B5-61FBEAE2E252@linux.dev>
References: <20250327092922.536-1-link@vivo.com>
 <20250404090111.GB11105@lst.de>
 <9A899641-BDED-4773-B349-56AF1DD58B21@linux.dev>
To: Huan Yang <link@vivo.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 4, 2025, at 17:38, Muchun Song <muchun.song@linux.dev> wrote:
>=20
>=20
>=20
>> On Apr 4, 2025, at 17:01, Christoph Hellwig <hch@lst.de> wrote:
>>=20
>> After the btrfs compressed bio discussion I think the hugetlb changes =
that
>> skip the tail pages are fundamentally unsafe in the current kernel.
>>=20
>> That is because the bio_vec representation assumes tail pages do =
exist, so
>> as soon as you are doing direct I/O that generates a bvec starting =
beyond
>> the present head page things will blow up.  Other users of bio_vecs =
might
>> do the same, but the way the block bio_vecs are generated are very =
suspect
>> to that.  So we'll first need to sort that out and a few other things
>> before we can even think of enabling such a feature.
>>=20
>=20
> I would like to express my gratitude to Christoph for including me in =
the
> thread. I have carefully read the cover letter in [1], which indicates
> that an issue has arisen due to the improper use of `vmap_pfn()`. I'm
> wondering if we could consider using `vmap()` instead. In the HVO =
scenario,
> the tail struct pages do **exist**, but they are read-only. I've =
examined
> the code of `vmap()`, and it appears that it only reads the struct =
page.
> Therefore, it seems feasible for us to use `vmap()` (I am not a expert =
in
> udmabuf.). Right?

I believe my stance is correct. I've also reviewed another thread in =
[2].
Allow me to clarify and correct the viewpoints you presented. You =
stated:
  "
   So by HVO, it also not backed by pages, only contains folio head, =
each
   tail pfn's page struct go away.
  "
This statement is entirely inaccurate. The tail pages do not cease to =
exist;
rather, they are read-only. For your specific use-case, please use =
`vmap()`
to resolve the issue at hand. If you wish to gain a comprehensive =
understanding
of the fundamentals of HVO, I kindly suggest a thorough review of the =
document
in [3].

[2] =
https://lore.kernel.org/lkml/5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com=
/#t
[3] Documentation/mm/vmemmap_dedup.rst

>=20
> [1] =
https://lore.kernel.org/linux-mm/20250327092922.536-1-link@vivo.com/T/#m05=
5b34978cf882fd44d2d08d929b50292d8502b4
>=20
> Thanks,
> Muchun.
>=20


