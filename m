Return-Path: <linux-kselftest+bounces-46699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C16BAC930A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 20:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33F9934A7A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EA5333748;
	Fri, 28 Nov 2025 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="m/WretVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aRdn8zLl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ACA2EA174;
	Fri, 28 Nov 2025 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764359099; cv=none; b=QGIjchFxMdXlmY8V+DXX87eiAIqk3FO4TGstLY23Q5wNnSTXBKPpcHXYBEQfwvIcyj7BAG86NSsjq9zDusB+HhQ7LRdFyQrrXHtse2jNqIzggRtL1pSO8VD2lowP+RWC+A4lWB+zmkbtsmlzB9tNjAb8DkayMnrlDClMFDhERb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764359099; c=relaxed/simple;
	bh=mUqpQ759I3HIGy8T1URVCL1cN+7lpFuxMiJ0JpZEQkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFLHQkLEKbz/IVsPOqdcduL+0bj285TCfkLTr9IVJUOEQbqOG+tL42/fzNHa5Xg6aYxK93ICW2qgH8V+6KvWAXSrQ1aGTBB9Gr0z9+ujehO5JYepXMCQHRFKoBMIdBL7agigg9O22rG4iop7KgpIW+yA4suuM3201c1ISUcRRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=m/WretVL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aRdn8zLl; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 69FDA1D00753;
	Fri, 28 Nov 2025 14:44:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 28 Nov 2025 14:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764359095;
	 x=1764445495; bh=H6PYwJK0pvsCaVg7EUDSTlJ2qBBCFgF54ku7DGRNDyQ=; b=
	m/WretVLxfUXue8pM5MgYVjsN1pfAarKGDNrDRnFvZWY88DbBH6yu2pV27cSCf0H
	h55/yw6qDvJWk1URaYHvmvKBrOhY+5+tCncZy4uaSUFfynPnridhlWWNpIuRIB50
	nQsXiryOHj2lQhYGwepcrSYBZKIrP5QOzewKZHgKxiYn5598dNZ2Ya6oVvuql0TW
	euY9FHQrDErbbUCxKui3qobc8XEz2YQ/y//PGix8rqDC8nXhYQZ6qU67ESJhgcst
	25+cyvbnrIw+c43g5eSDpJYSEWCIACwizrxZRh16m1lP7E2E3gkMo6YUuMwsazCL
	PAf9kKRU6Lnbj8ZkVE24AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764359095; x=
	1764445495; bh=H6PYwJK0pvsCaVg7EUDSTlJ2qBBCFgF54ku7DGRNDyQ=; b=a
	Rdn8zLlUrtxzVpQPmOdIoidQ3DuwESwPcnCBCUxyLPNCu8tJwJ+9uUQYyhyJobXM
	PMH0hCQDCqT0RD06GXeJcrCsCIi9B2wlt6iPbI/mxy6a6tn93AFYnnXM+QnBt1fB
	+sMSmoBx1gtYoAM/HE8nmwbCMNLngTLeXK26geAHs7qSY5x3byxeQWdRej5eNdvU
	Mz+Gvz7ZmAG46V8xrRtPp9VgyJPqsrYZjbo2s2XOyGvQFkkx/TcWjUDTeiBkteOL
	ByqBZx4f4WzKRXcfo6DEqKAzeUwMZncEWOucfnsS+fDNAInSd/PdzZL6rfliYQfx
	886lLMsvhYZBGGx9hAYxg==
X-ME-Sender: <xms:tvspaeQCh98qaD_3FbnqT4sm6H7K3xB1eVbaqM3vNs6nGGTkCX6I1Q>
    <xme:tvspaUPJ5uzVMk1KbX6gGSTM3FuI3eZWktikGXNYMaoqnsjYfnLWn-s7MeDYzQw3T
    91NJYRq5CEgOWdQ914AuzJm1QFEMs9Ox_wD3ZLjyZ4nB0HOqcb63w>
X-ME-Received: <xmr:tvspacjf4KNWpX3wLSFCz-_DrJ2-B81Q04MaYZ0SCru_0M2j6GrlGl05>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepueehgffgteeuleeiheevleegjeetvdfhffetvedtvedvgeegleekvdelffeh
    ieetnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehs
    hhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    rghmrghsthhrohesfhgsrdgtohhmpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtoh
    hmpdhrtghpthhtohepjhhrhhhilhhkvgesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    khhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    shgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrnh
    grnhhtrgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhhiphhinhhshhesghhoohhg
    lhgvrdgtohhm
X-ME-Proxy: <xmx:tvspaRnf-APuWHNWIvMtc51LeV23YK66sfcCv11vWEEfRLCJ3GEaig>
    <xmx:tvspaYisGRYgvgKsJ_4wv2pq1sADiBLcm0QCLsdjauyj-krwFHPqFQ>
    <xmx:tvspaUGnxadvAf-Rw4u3jTqah6SkQ_7UuRqyBs4nPzPL-k0_a15b3Q>
    <xmx:tvspaat0du2sH8zlj8IlfgODx1wY-R82fFXohalnYr0rgu-AW7XgwQ>
    <xmx:t_spaR_Z_YbJBqAJwzq-gQYa1wflBAbrrXwovvYWFHMFqwdtCxGD7a8k>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 14:44:54 -0500 (EST)
Date: Fri, 28 Nov 2025 12:44:44 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Alex Mastro <amastro@fb.com>, Jason Gunthorpe <jgg@nvidia.com>, Josh
 Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Raghavendra
 Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 00/18] vfio: selftests: Support for multi-device
 tests
Message-ID: <20251128124444.2d6abe55.alex@shazbot.org>
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
References: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 23:17:15 +0000
David Matlack <dmatlack@google.com> wrote:

> This series adds support for tests that use multiple devices, and adds
> one new test, vfio_pci_device_init_perf_test, which measures parallel
> device initialization time to demonstrate the improvement from commit
> e908f58b6beb ("vfio/pci: Separate SR-IOV VF dev_set").
> 
> This series also breaks apart the monolithic vfio_util.h and
> vfio_pci_device.c into separate files, to account for all the new code.
> This required quite a bit of code motion so the diffstat looks large.
> The final layout is more granular and provides a better separation of
> the IOMMU code from the device code.
> 
> Final layout:
> 
>   C files:
>     - tools/testing/selftests/vfio/lib/libvfio.c
>     - tools/testing/selftests/vfio/lib/iommu.c
>     - tools/testing/selftests/vfio/lib/iova_allocator.c
>     - tools/testing/selftests/vfio/lib/vfio_pci_device.c
>     - tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> 
>   H files:
>    - tools/testing/selftests/vfio/lib/include/libvfio.h
>    - tools/testing/selftests/vfio/lib/include/libvfio/assert.h
>    - tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
>    - tools/testing/selftests/vfio/lib/include/libvfio/iova_allocator.h
>    - tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
>    - tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
> 
> Notably, vfio_util.h is now gone and replaced with libvfio.h.
> 
> This series is based on vfio/next plus Alex Mastro's series to add the
> IOVA allocator [1]. It should apply cleanly to vfio/next once Alex's
> series makes its way to vfio/next via Linus' tree.
> 
> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/vfio/selftests/init_perf_test/v4
> 
> [1] https://lore.kernel.org/kvm/20251111-iova-ranges-v3-0-7960244642c5@fb.com/
> 
> Cc: Alex Mastro <amastro@fb.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Josh Hilke <jrhilke@google.com>
> Cc: Raghavendra Rao Ananta <rananta@google.com>
> Cc: Vipin Sharma <vipinsh@google.com>
> 
> v4:

Applied to vfio next branch for v6.19.  Thanks,

Alex

