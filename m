Return-Path: <linux-kselftest+bounces-47861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91796CD6EE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 20:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CDCA300BEE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 19:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6D338F54;
	Mon, 22 Dec 2025 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EKF5GeOi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9313B307AD5;
	Mon, 22 Dec 2025 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766430495; cv=none; b=NwxABOMKJ5i2PmKBpHFpQcaUyYia9RLMFPJACXQGRXTe8cNfI2BMqkSqdbbq7ldeHCkhzAo8WZEwkaK3ebDryiZXOmfv77NeivvhOGuUzqhyL9Td89O/9cf6J4RcwQRmleFF0YgkpCkVv93PP3AjvFqZWKOgyH+xrz79zuNySiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766430495; c=relaxed/simple;
	bh=Gb3RFjZQ8t7BxcEou9Uz2XwHSIj5SHa5Q1InugjLUv0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UhHr7k+kz5zWYO1UWRzy8h1GtwNHSBo6wk9EolssipEao4onsxhc34f4DM3YofXEpR4/6/r+NXDfA0A6D6S1C7BTXOlrgMKAOivgEXX0DNend+IFeT+EuUOoa4tNNKjLpxc0/FuZxS4G7xO+skdygHnqjv9ILX3yPvdqGoLhDRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EKF5GeOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7175BC116D0;
	Mon, 22 Dec 2025 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766430494;
	bh=Gb3RFjZQ8t7BxcEou9Uz2XwHSIj5SHa5Q1InugjLUv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EKF5GeOipp3kX1ozPFWa/ZETbsBmwbuwImUk8D5rw/92gNYdOt4YBhUQYWUr28bkf
	 92VCN8JLfCUAJ91oeio9y0OZ1zeFAPzZrmGDMd+5IeHEL06aC+LQ10gN2hcGFlIgUD
	 8ch3Q5tHsypgAmEIW1DGN5mecl40tPIQ1Re+k0bM=
Date: Mon, 22 Dec 2025 11:08:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Li Wang <liwang@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, Waiman Long
 <longman@redhat.com>
Subject: Re: [PATCH v3 2/3] selftests/mm/charge_reserved_hugetlb: drop mount
 size for hugetlbfs
Message-Id: <20251222110813.3d353b8c49b628e4997263e4@linux-foundation.org>
In-Reply-To: <53e302a7-1c78-4b76-87e8-1cc10c76535d@kernel.org>
References: <20251221122639.3168038-1-liwang@redhat.com>
	<20251221122639.3168038-3-liwang@redhat.com>
	<53e302a7-1c78-4b76-87e8-1cc10c76535d@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 11:01:17 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> > Fixes: 29750f71a9 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
> 
> Likely Andrew should add a CC of stable
> 

yep, thanks.

