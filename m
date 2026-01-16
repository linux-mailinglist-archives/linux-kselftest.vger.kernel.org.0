Return-Path: <linux-kselftest+bounces-49215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8DDD38946
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 23:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B6963030236
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 22:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB36E311C32;
	Fri, 16 Jan 2026 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLjDx/UI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCCC2F0C7A
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602826; cv=none; b=pUAMjYP1kmumOG8P0SUKN1viyEijbU6revkInJyPXG/NPRwg4C5emQeLgIFVTqLYbvarPgf0/9JtAR3nCmr5aDMpkg5T1gsdszfvqjn6Jl8SXIVEJf+TSnPKHMg61hH/ur25mpol2EB06/EGmZLcNVZOZc7qJSFa3GQdKXelhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602826; c=relaxed/simple;
	bh=7eJDuDaRU4HEnFjD8M5xCWB8csrNTe+bMKyIlAUEPvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdHZcK9ym9gB3pIyCv/G+JX3KqAQrv8UKdLsMrAIlreSOb60SV8e7o7FHQm0bHt1F2m8ifLOo3juPiQ6SIo1+Z+n2JTyjKJfNQqHjby3d0GN35/JOcHOMyHfEbLbANVOs58LWnJIoNQwucWI6zDg/N/ePuUnyzWj3YBuUKOyqRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uLjDx/UI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a1022dda33so15395315ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 14:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768602825; x=1769207625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOMjigGknPXeAyP77SuRzqAAm/mO2t7w32/ztq/sln8=;
        b=uLjDx/UIvhhO0lkiZqk4zzfxdsA/Qq74jN86NfhO52juO43p6BEDO+lkeBeeAQofdy
         Dgbrvu48LZgCPqzYjgjmZ7AocXbWGSVkc7/OS4h0hFHB3nvNBuwQVWVkY9GKdOfLS+KV
         d28WaqQO4PL5EKLzsmYHYvrp/uWqFmQTgwE9pOHMkG48URIkGUp0w9ysteRmp5NmU2ZK
         66Oqvt5HDthwszlvJCuXhCT3RWy2PooyFnF6Hmpp7qjQ+0n54m3m5kC9lReP+OHIFAFU
         ZJSl5ho0Bz3qw+Ltf/zqFrsya9R8PfHGMREnF98i5y9o8aWcOJs0PLHMkfGNbnnR8JZw
         cHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602825; x=1769207625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOMjigGknPXeAyP77SuRzqAAm/mO2t7w32/ztq/sln8=;
        b=j4C9Oa8k5Zua+HviH0AIqF3tSIAkUPM6bXKI205BLIVqgeKSO3c8FjnV6c6xD6uzYM
         ZtujcVuSBmENLn+oueG6KbqSiNURpdUztH75EJ1Mmkh7Yb9rFvNt4l2gPWE0oMr9VUff
         Dy5HsAAB5q1NAYZZMXZwJi3/kS3/GO0jb+i65fiRn/xfRDyZoORYD/6/0wzodFVQhCFH
         IyoG6OZGg5dZQasLGsC7YmBn3YIC6XY08oF3FcDvJK7ft6ecB8cFqchQ+ypggN8e5K5Z
         HNMtuShL5UK1uzmmYWw02VDo13lVBUWXfQEUH+9fAcPctu0MgNajAytW0kW0hOoE81WT
         P4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXs+xpQdptLEv320W+Meh5t8cGGg1UzsgrGPaXMX6rUoiEjLnJvaHRPqinRS5jZT4kDtDa99PEa2a58+/79Izg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyXnAYgtBDDK3FEPuPDm4regg3JYJ9SdJeltmWIsnh4tsHUYA
	7qEkMX7nVBYX6R3A4YQv/nnzbUOYvwv7jOTf+mYV4/awH9iUl+B6i1XjiTrSjJ1fjQ==
X-Gm-Gg: AY/fxX6dKIvp2Md5vgDxamb39G24920FxsgXMwiYYZ/aBfPHYUyiNA65b3yVZ3rR8DT
	lr7iLRsyagUlDjVHVl073gEq9nnqlOy5vU29Gg+UrapEdx7tEisK2oqG9sdu4E0EWzTKfmdecj3
	CTg1TnNBxoY2tLTqo+ubrts/55uYAqRHDiE86+ycFgSRMjskijCSliL1/J5LJCnAUjd177JbXhj
	WoHXskaMjHd1ZbMlo/QB3gynDG46bBrECIsYPdqBTN0gIcPpFFy/b9U2R/3347c/qqKIbhmGadN
	ipJcvfLRbpIsZ64JOp2Rde/lPs6STYRk8YxdX2lv8VnjWQjSgRPdApDLveH2YLeroSUY8e/iHfS
	FAXoihNRR2rQKlcSnpX5p9mCEkd2L8xsZKi13cYugLop5IZ4nNYlV/6OZSmhSW/hvqykHMUYnUI
	UYg51xW3dqf1INCPbR8LoN5PMH2p5dmMuo3cL9HO37hunxvnzpP9jRl55clk9S
X-Received: by 2002:a17:903:3846:b0:2a5:8c1c:744f with SMTP id d9443c01a7336-2a7177ce31cmr41826535ad.40.1768602824591;
        Fri, 16 Jan 2026 14:33:44 -0800 (PST)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a71941c088sm29731605ad.91.2026.01.16.14.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 14:33:42 -0800 (PST)
Date: Fri, 16 Jan 2026 22:33:38 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 0/3] vfio: selftests: Add MMIO DMA mapping test
Message-ID: <aWq8woXQ1E6XO9tA@google.com>
References: <20260114-map-mmio-test-v3-0-44e036d95e64@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-map-mmio-test-v3-0-44e036d95e64@fb.com>

On 2026-01-14 10:57 AM, Alex Mastro wrote:
> Test IOMMU mapping the BAR mmaps created during vfio_pci_device_setup().
> 
> All IOMMU modes are tested: vfio_type1 variants are expected to succeed,
> while non-type1 modes are expected to fail. iommufd compat mode can be
> updated to expect success once kernel support lands. Native iommufd will
> not support mapping vaddrs backed by MMIO (it will support dma-buf based
> MMIO mapping instead).
> 
> Changes in v3:
> - Rename mmap_aligned() to mmap_reserve()
> - Reorder variable declarations for reverse-fir-tree style
> - Update patch 2 commit message to mention MADV_HUGEPAGE and MAP_FILE
> - Move BAR size check into map_partial_bar test only
> - Link to v2: https://lore.kernel.org/r/20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com
> 
> Changes in v2:
> - Split into patch series
> - Factor out mmap_reserve() for vaddr alignment
> - Align BAR mmaps to improve hugepage IOMMU mapping efficiency
> - Centralize MODE_* string definitions
> - Add is_power_of_2() assertion for BAR size
> - Simplify align calculation to min(size, 1G)
> - Add map_bar_misaligned test case
> - Link to v1: https://lore.kernel.org/all/20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>

Reviewed-by: David Matlack <dmatlack@google.com>
Tested-by: David Matlack <dmatlack@google.com>

