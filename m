Return-Path: <linux-kselftest+bounces-10631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782A78CDA8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 21:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A544C1C216A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03D682D68;
	Thu, 23 May 2024 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0PL4Ar5s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A40860BBE;
	Thu, 23 May 2024 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491627; cv=none; b=pUX9NKjImsWhOPKdnsRFQRAuK+IN3rjE4ibdWWUf94HWEjF868NzjHi2AVYJbtbZcsqy6YeIuKrMhx9KJEmvYUbFg8NeAWjope9mG7mSbyJUwcmLTC+pxEtR4VfYZRq9VBEadjOWCD/QP0pzvY2cQIgM22f/tLzPaRK9e+shDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491627; c=relaxed/simple;
	bh=+JOFaXZ73U5uGnk9S9gTiM6JcwXiBpR5hDiNMxbHwEs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kiiWXtmVbEfkDnGZnCBhiRNLnbEIAFcgIiHuNnN818UXM25cS2ac8L8uUtTnT8LQJUWcwH1n8YDIgqyuPpD6avJUB4U4XZQPEggLiFBy08dxu8EtHxchOERqsH0xEzNaFn4qRococ31rqH66q6E+eJ9DCNnetOhwnjjBikkKdhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0PL4Ar5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88791C2BD10;
	Thu, 23 May 2024 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716491625;
	bh=+JOFaXZ73U5uGnk9S9gTiM6JcwXiBpR5hDiNMxbHwEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0PL4Ar5sbdb9hd+8AwsrwqUSMI0PeChmRoviG1HBMJXK22+BmiR2yY5/loVJ7TH86
	 /kUFqgPLQNauTjDcASYiUW/QhCFYj5Vtngv18YndVjQ85l4RGgnMzIDl4cO9IOgmQo
	 GwEFRy1I4FOOsvUe0iHS0V+Llx4IUJN1X/03mynw=
Date: Thu, 23 May 2024 12:13:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Ritesh
 Harjani <ritesh.list@gmail.com>, Mike Rapoport <rppt@kernel.org>, Muchun
 Song <songmuchun@bytedance.com>, David Hildenbrand <david@redhat.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked
 during __bio_release_pages()
Message-Id: <20240523121344.6a67a109e0af2ba70973b34b@linux-foundation.org>
In-Reply-To: <20240523063905.3173-1-donettom@linux.ibm.com>
References: <20240523063905.3173-1-donettom@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 01:39:05 -0500 Donet Tom <donettom@linux.ibm.com> wrote:

> Commit 1b151e2435fc ("block: Remove special-casing of compound
> pages") caused a change in behaviour when releasing the pages
> if the buffer does not start at the beginning of the page. This
> was because the calculation of the number of pages to release
> was incorrect.
> This was fixed by commit 38b43539d64b ("block: Fix page refcounts
> for unaligned buffers in __bio_release_pages()").
> 
> We pin the user buffer during direct I/O writes. If this buffer is a
> hugepage, bio_release_page() will unpin it and decrement all references
> and pin counts at ->bi_end_io. However, if any references to the hugepage
> remain post-I/O, the hugepage will not be freed upon unmap, leading
> to a memory leak.
> 
> This patch verifies that a hugepage, used as a user buffer for DIO
> operations, is correctly freed upon unmapping, regardless of whether
> the offsets are aligned or unaligned w.r.t page boundary.
> 

You have stable@vger.kernel.org in the mail headers, so I assume you're
proposing this for backporting.  When doing this, please include 

Cc: <stable@vger.kernel.org>

in the changelog footers and also include a Fixes: target.  I'm
assuming the suitable Fixes: target for this patch is 38b43539d64b?

