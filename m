Return-Path: <linux-kselftest+bounces-45595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC2BC5AA14
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 00:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7911F355100
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 23:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77433CE9B;
	Thu, 13 Nov 2025 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DsvSKa22"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368333B6D9;
	Thu, 13 Nov 2025 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076727; cv=none; b=CLaVlK6fjQLvReL/Li1G6fbKC+W3TEM7p0aoRbXj4CUIcVbViBON1NtZR5WQ/ET/C0AgQn+4W/hdd4DpUwdudhCDuB0xgGFJ0R8JqVyvkeVkRHa8n5qQQLcDkID0PD3ex/u8XKUwvcLJlxXISTf7+/TfhQ0SOZxOaEvgm/gVG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076727; c=relaxed/simple;
	bh=0/Wu2Fbf5XL6YXzMCsU9T/GGUPwbFh2GCmkLRrlFK+U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aUKPdrl+KlnQG1KpuhFp6KH7ItMW5SWGzvMuuDBgoF6rQbN6PIadZgL+mUb+davJ/9qTzBVN6VLw86bmjhY+tiModXnM+gJ2v+rCJLToEl2xUgILzjQUC855PAEa9ZElvlj/lbbhGYzUEJr+V67a63Mbq2Hx1rC9+4tgDXehAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DsvSKa22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B28C4DE01;
	Thu, 13 Nov 2025 23:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763076727;
	bh=0/Wu2Fbf5XL6YXzMCsU9T/GGUPwbFh2GCmkLRrlFK+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DsvSKa22dmOLI50W4oxTVoFKUf84nqZZR5Kh5pCAiFxU5Wy5G+9iOCJEJsNSksOej
	 T/LZE//2cuhxzpEMmDR5zf9vE5QUSJLH0h+MC5MLMsZSEbFyQmNbhuyjhLOHIzjjGX
	 8AuW1DiXEdj4xAwcqSJ35ghaR6Oj7If5wSIObnJw=
Date: Thu, 13 Nov 2025 15:32:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Carlos Llamas <cmllamas@google.com>, "David Hildenbrand (Red Hat)"
 <david@kernel.org>, Peter Xu <peterx@redhat.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Ujwal Kundur
 <ujwal.kundur@gmail.com>, Brendan Jackman <jackmanb@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "open list:MEMORY MANAGEMENT - USERFAULTFD"
 <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: fix division-by-zero in uffd-unit-tests
Message-Id: <20251113153205.6507ecb308e7d09362905da7@linux-foundation.org>
In-Reply-To: <b4291d0d-b913-4e61-9f9d-fbebd1eb4720@lucifer.local>
References: <20251113034623.3127012-1-cmllamas@google.com>
	<e0be6864-4260-4843-a432-d47437b5d43f@kernel.org>
	<4a60a703-d9c2-46a8-83b4-a7ecff7f6ba2@lucifer.local>
	<aRXyxWeh81-aTHaC@google.com>
	<b4291d0d-b913-4e61-9f9d-fbebd1eb4720@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 15:03:06 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Thu, Nov 13, 2025 at 03:01:25PM +0000, Carlos Llamas wrote:
> > On Thu, Nov 13, 2025 at 09:54:37AM +0000, Lorenzo Stoakes wrote:
> > > On Thu, Nov 13, 2025 at 10:06:42AM +0100, David Hildenbrand (Red Hat) wrote:
> > > > On 13.11.25 04:46, Carlos Llamas wrote:
> > > > > Commit 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global
> > > > > vars into struct") moved some of the operations previously implemented
> > > > > in uffd_setup_environment() earlier in the main test loop.
> > > > >
> > > > > The calculation of nr_pages, which involves a division by page_size, now
> > > > > occurs before checking that default_huge_page_size() returns a non-zero
> > > > > This leads to a division-by-zero error on systems with !CONFIG_HUGETLB.
> > > > >
> > > > > Fix this by relocating the non-zero page_size check before the nr_pages
> > > > > calculation, as it was originally implemented.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > >
> > > > Do we CC stable on unit tests? From my recollection, no.
> > >
> > > Yeah please let's not.
> >
> > Oops, I keep getting confused about this Cc stable thing. Please let me
> > know if a v2 dropping the tag is needed.
> 
> No need, Andrew should spot the objection and drop the tag :)

I actually add cc:stable tags to selftests fixes!

Because why not.  Why leave people running known-to-be-buggy code when
our backporting processes are so well-functioning and lightweight?

I'm not getting the objection?

