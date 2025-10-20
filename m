Return-Path: <linux-kselftest+bounces-43538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0748BEFC99
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 10:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 990D34EA670
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A2F2E093C;
	Mon, 20 Oct 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd0ZDtoE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BDF2DE714;
	Mon, 20 Oct 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947417; cv=none; b=Y8zgTRdbfeGQZ/FctyzlUYJwOKQWA9n1Ghz1ZeZSPCp+IJ/pXHETgmpDxE3aJmT5XW8+jkgnBC5OHjin3mBUT/gesGQnDclFIheSBOQAD/KRv2GviVpkMtnFQhtS61NVJFUpm5TLBy0hfUmKEf9Y1l4+z3l+8ADo9Yf49kvscbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947417; c=relaxed/simple;
	bh=RlHfCrz1VcpgYnaW4DqMzk0+iamM6HgIG4/sR6KXbB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opZA+tKKRECOkxcjStNH5UmTuQ9N7dvcDFDaxU2t2vGTj4QXrS3RPx0MFW6WHJAy7Q78pxHkyA9dvr3uvW3vNXyzn5r1gLxwP8oWyxtUWqcdCrutaAyyFtfX2206MjNNm6dGpiQsMOpzIAFNZfCh1U3Ojli256iWVdrvc6ljBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd0ZDtoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1AEC4CEF9;
	Mon, 20 Oct 2025 08:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760947416;
	bh=RlHfCrz1VcpgYnaW4DqMzk0+iamM6HgIG4/sR6KXbB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nd0ZDtoEuFOr+zoWoSMvb4XzMTaYscSYSJMWOmFsE7Qxub0TAoPqFHR7bX9fFW39X
	 LkhOKYUgdo9ZFYeks2Kagf/RlYbLwy6Q7L9Djw0+WcKn3fC+iqd9r5/tiPurqJkLxo
	 FIxmJCbWLpvmL4Gf688hl/e1aM83KdUe1K7pRblXH8Jb5FAdO9XFL2C/Z0bMYcHcEz
	 DHIEyTGuFAsHD2XGYXNbQAxg5XG2KV2tG2g87NRhRkQiItfHBFGAXiVsr0M6SeNDej
	 PWhCgW8HIBEKYkVZUYhdRVf4s3CL4kA+9/Mb7bVN0j/zXlbEI6Rkm6hwBKkCBjcWjz
	 2JK74TNLMXU8g==
Date: Mon, 20 Oct 2025 11:03:27 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, jasonmiu@google.com,
	dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH v6 09/10] liveupdate: kho: Increase metadata bitmap size
 to PAGE_SIZE
Message-ID: <aPXszzdehAbkPOAh@kernel.org>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <20251018171756.1724191-10-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018171756.1724191-10-pasha.tatashin@soleen.com>

On Sat, Oct 18, 2025 at 01:17:55PM -0400, Pasha Tatashin wrote:
> Metadata is preserved via 512-bytes, which requires using slabs. Slabs

KHO memory preservation metadata is preserved in 512 byte chunks which
requires their allocation from slab allocator.

> are not safe to be used with KHO because of kfence, and because partial

Please add more details why kfence is not safe here.

> slabs may lead leaks to the next kernel. Change the size to be
> PAGE_SIZE.
> 
> While this change could potentially increase metadata overhead on
> systems with sparsely preserved memory, this is being mitigated by
> ongoing work to reduce sparseness during preservation via 1G guest
> pages. Furthermore, this change aligns with future work on a stateless
> KHO, which will also use page-sized bitmaps for its radix tree metadata.

With the stateless memory preservation there would be no problem with
kfence, right?
Maybe we should accelerate the stateless preservation work?
 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Sincerely yours,
Mike.

