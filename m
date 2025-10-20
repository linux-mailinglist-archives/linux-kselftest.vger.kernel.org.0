Return-Path: <linux-kselftest+bounces-43540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDFFBEFF9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 10:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBC9A34A18F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DB22E972E;
	Mon, 20 Oct 2025 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir95mbod"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE62E336E;
	Mon, 20 Oct 2025 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949251; cv=none; b=C1oqGlNFiSX05zHf/SgJ/PXkv9YMkm9atW7mh4FiQRjyGWf1mxGaxPT72affg1Mx60HxM2hKzdjILhs8eqLji6ZCK4aDvlQFBd0bNzM/L+JS+XcI7pEZ6yC4ML1Qlxhl1Pf5CATDI5sMTqUkgjvuLIWFnD0Tucwo/Y8601uFrS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949251; c=relaxed/simple;
	bh=Xvry6+L+zYDKF402OGrEL2Sp57xE5MGQjq5jn1pdWmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw81OZMp83J/lJN90VkPTooIhvzzpody7QauSIAiRmgObl+LoIRIVGvEo/AAbcl6HNOMtIf7qv8wrZzrhHlu4A+ifIgw9ilhnmPyei7EfPoo6WUnhSQ6XnW1+Ildjt5AedWvL02QoEdT+sMHuUf6W5HXzpVW8AiChkIyvKOkcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir95mbod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BCEC4CEF9;
	Mon, 20 Oct 2025 08:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760949249;
	bh=Xvry6+L+zYDKF402OGrEL2Sp57xE5MGQjq5jn1pdWmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ir95mbodFzEwdGgwaKAzCgUv1XVRzdu9N9eZyzDR/WCkVPnpeeIjeoz9Le4z5eQbY
	 0WwGobTOrVlGgvWyVLGTJB7rbHA0OAe0s620+sG/9uCOWGIxujoIrKxY9K59KUBDCU
	 btD4n4yf1TIDPeec7eQ4wHImOmHQRsh3hlAY/+qlElIsCAXNRvyWyR9LLESWSDrpaV
	 RkUcMIzUHHcFGOCi1IR2vUdSJyyFxdRpxIozSjdaE2mDfhAfhnqDXLddsrBuqytJ3S
	 7HC7RiSk7Qr7XxXRTX2jFQDIUi6ZF2zZ3JNQt3SEdvPRf87wcSh/fdCZLEvfAl/RTH
	 nCrftv2oclFEQ==
Date: Mon, 20 Oct 2025 11:34:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, jasonmiu@google.com,
	dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH v6 00/10] liveupdate: Rework KHO for in-kernel users &
 Fix memory corruption
Message-ID: <aPXz-IPDRniMHN0u@kernel.org>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018171756.1724191-1-pasha.tatashin@soleen.com>

On Sat, Oct 18, 2025 at 01:17:46PM -0400, Pasha Tatashin wrote:
> This series addresses comments and combines into one the two
> series [1] and [2], and adds review-bys.
> 
> This series refactors the KHO framework to better support in-kernel
> users like the upcoming LUO. The current design, which relies on a
> notifier chain and debugfs for control, is too restrictive for direct
> programmatic use.
> 
> The core of this rework is the removal of the notifier chain in favor of
> a direct registration API. This decouples clients from the shutdown-time
> finalization sequence, allowing them to manage their preserved state
> more flexibly and at any time.
> 
> Also, this series fixes a memory corruption bug in KHO that occurs when
> KFENCE is enabled.
> 
> The root cause is that KHO metadata, allocated via kzalloc(), can be
> randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
> early memblock allocator is restricted to a "scratch area". This forces
> the KFENCE pool to be allocated within this scratch area, creating a
> conflict. If KHO metadata is subsequently placed in this pool, it gets
> corrupted during the next kexec operation.
> 
> [1] https://lore.kernel.org/all/20251007033100.836886-1-pasha.tatashin@soleen.com
> [2] https://lore.kernel.org/all/20251015053121.3978358-1-pasha.tatashin@soleen.com
> 
> Mike Rapoport (Microsoft) (1):
>   kho: drop notifiers
> 
> Pasha Tatashin (9):
>   kho: allow to drive kho from within kernel
>   kho: make debugfs interface optional
>   kho: add interfaces to unpreserve folios and page ranes
>   kho: don't unpreserve memory during abort
>   liveupdate: kho: move to kernel/liveupdate
>   kho: move kho debugfs directory to liveupdate
>   liveupdate: kho: warn and fail on metadata or preserved memory in scratch area
>   liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
>   liveupdate: kho: allocate metadata directly from the buddy allocator

The fixes should go before the preparation for LUO or even better as a
separate series.

I've reread the LUO preparation patches and I don't think they are useful
on their own. They introduce a couple of unused interfaces and I think it's
better to have them along with the rest of LUO patches.

-- 
Sincerely yours,
Mike.

