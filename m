Return-Path: <linux-kselftest+bounces-43644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F892BF4ACC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 08:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3680A189F83D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 06:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29902222D1;
	Tue, 21 Oct 2025 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/YtPR7h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47E20102B;
	Tue, 21 Oct 2025 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761026469; cv=none; b=NIJtIRQjn8TmMZjdFolqeR86wCymX7IBntfRQJBMoNJC+ea5Qwg83hjEzOUpXLY4tXwQwuEikmFNOrWh+yOiwQ62Jcqwj9VAEClWGmo8q6ybCDFPuV7wktQwX9NzudonbEbtdC97X4AE7v7hyZ7+Rf8+QD7uj5fJZUb1+DFRKcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761026469; c=relaxed/simple;
	bh=leVGy3m3C0ox1KihNTxl75c7yMvX5DhCdvZGegMEpSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4PlYyVh/sm+yhS+qUfBf2aWtf+cgQDjNzHmsYP7A+wyaWXdXy/2JJTOnAVIcpMDv7+2Ca2+IWu51GO4Z1KQCEuAKfo0jSruA8ActFJRusmWk2Tnw9NzsD53g3CPgvEwc70eTta6ReDkaxwgdufMOeRAzp/WVD74/uGpE0xzXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/YtPR7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF29C4CEF1;
	Tue, 21 Oct 2025 06:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761026468;
	bh=leVGy3m3C0ox1KihNTxl75c7yMvX5DhCdvZGegMEpSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/YtPR7hXr7HDYt3kwPIwQPPNZ6foZPGaPyKfbiAINADLKI5mwi4LlejBVPhcUBwu
	 bKaR25r+8BksQ8fC1qOhTsdzRK1slwhQmhp+ixg7UWtAGcLi1Dfn93utOJZm3TW4z7
	 dT7Mk1jvCUk3ylCAkaMWSBW2NAQHWMd5ctkBjmxHWPGyywMiDgrmFGWL7ApjX7hNHZ
	 x6iFh5GR6qfZxk44boaJTNw/qwT/GhlVuof5/JMnSy+FC/Ocq7lIpWEACwFFClYMRL
	 l1Dagf7YKFTg7HOh+3/5j6tdi6k6m3L+sjM2u6l+FvIYMVt5t+Srji/bLytBb6WkT8
	 ox893izM8aQvw==
Date: Tue, 21 Oct 2025 09:00:59 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, jasonmiu@google.com,
	dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH v3 0/3] KHO: kfence + KHO memory corruption fix
Message-ID: <aPchmxfh4ACM0vY2@kernel.org>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021000852.2924827-1-pasha.tatashin@soleen.com>

On Mon, Oct 20, 2025 at 08:08:49PM -0400, Pasha Tatashin wrote:
> This series fixes a memory corruption bug in KHO that occurs when KFENCE
> is enabled.
> 
> The root cause is that KHO metadata, allocated via kzalloc(), can be
> randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
> early memblock allocator is restricted to a "scratch area". This forces
> the KFENCE pool to be allocated within this scratch area, creating a
> conflict. If KHO metadata is subsequently placed in this pool, it gets
> corrupted during the next kexec operation.
> 
> Patch 1/3 introduces a debug-only feature (CONFIG_KEXEC_HANDOVER_DEBUG)
> that adds checks to detect and fail any operation that attempts to place
> KHO metadata or preserved memory within the scratch area. This serves as
> a validation and diagnostic tool to confirm the problem without
> affecting production builds.
> 
> Patch 2/3 Increases bitmap to PAGE_SIZE, so buddy allocator can be used.
> 
> Patch 3/3 Provides the fix by modifying KHO to allocate its metadata
> directly from the buddy allocator instead of slab. This bypasses the
> KFENCE interception entirely.
> 
> Pasha Tatashin (3):
>   liveupdate: kho: warn and fail on metadata or preserved memory in
>     scratch area
>   liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
>   liveupdate: kho: allocate metadata directly from the buddy allocator

With liveupdate: dropped from the subjects

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
 
>  include/linux/gfp.h              |  3 ++
>  kernel/Kconfig.kexec             |  9 ++++
>  kernel/Makefile                  |  1 +
>  kernel/kexec_handover.c          | 72 ++++++++++++++++++++------------
>  kernel/kexec_handover_debug.c    | 25 +++++++++++
>  kernel/kexec_handover_internal.h | 16 +++++++
>  6 files changed, 100 insertions(+), 26 deletions(-)
>  create mode 100644 kernel/kexec_handover_debug.c
>  create mode 100644 kernel/kexec_handover_internal.h
> 
> 
> base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
> -- 
> 2.51.0.869.ge66316f041-goog
> 

-- 
Sincerely yours,
Mike.

