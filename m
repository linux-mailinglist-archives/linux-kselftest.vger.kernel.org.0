Return-Path: <linux-kselftest+bounces-39773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57460B32605
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 02:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EDB5A002E
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 00:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A7135972;
	Sat, 23 Aug 2025 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S8hZWVU6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA30C2F85B;
	Sat, 23 Aug 2025 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909782; cv=none; b=pQvGfZtmPilm+tpo4Doeg+aldqCn6FbvfvKeSZE5apOGa5xjAd/z1Uuk/6DLVnBYGiiFPrpHqs/T8RS/erKSFEFG2tlxPBDNFIBYBAswkWuPc69JajnGG6PvAJTaxdCLUeyCs8hGxMlG0670bZ78CYwUB6xBYB3zBXsQJtYeeG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909782; c=relaxed/simple;
	bh=EKwFARSCxE6DW/3EQ5i9Wr8vmKaZVfVfckT18HUdQE8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uvRV/NkW/AaenXS5jzyHp/HB3Hn5TPCxDLaR4y4eOozKPwo025hBSlW6iOER6I6k8eGQYinGbXaTZifyFTQIoqADlus3gwVI5GHtukvgcbTycEYQF5M8My9HJmOiOGLs6IXwc5VtqCnpTSL//CsWYydV+ivySRwq7oCDqGw8ob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S8hZWVU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7C6C4CEED;
	Sat, 23 Aug 2025 00:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755909781;
	bh=EKwFARSCxE6DW/3EQ5i9Wr8vmKaZVfVfckT18HUdQE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S8hZWVU6hakZ1AbQJY4qDd9ZvCnTU2Gw+bC1eFg4cq0BeGVUmBchZh/wksiAWI8pu
	 +XFkJju44Ls9/D8MWUzK+x4U/k8MLbI6bDadFCqMj2rSDYTHoSNyxSMXs7k1OJ9ML/
	 3HkdUAtQiBgCUKib2sOu+2fDGf1bDvrdTvP73/d4=
Date: Fri, 22 Aug 2025 17:42:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard
 <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Leon Romanovsky
 <leon@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kevin.brodsky@arm.com,
 kernel@collabora.com
Subject: Re: [PATCH v3 0/8] selftests/mm: Add compiler flags and fix found
 warnings
Message-Id: <20250822174259.bf4ed76a0da7d0d6f80ba2c1@linux-foundation.org>
In-Reply-To: <20250822082145.4145617-1-usama.anjum@collabora.com>
References: <20250822082145.4145617-1-usama.anjum@collabora.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 13:20:57 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> Recently, I reviewed a patch on the mm/kselftest mailing list about a
> test which had obvious type mismatch fix in it. It was strange why that
> wasn't caught during development and when patch was accepted. This led
> me to discover that those extra compiler options to catch these warnings
> aren't being used. When I added them, I found tens of warnings in just
> mm suite.
> 
> In this series, I'm adding these flags and fixing those warnings. In the
> last try several months ago [1], I'd patches for individual tests. I've
> made patches better by grouping the same type of fixes together. Hence
> there is no changelog for individual patches.

I think it would be best to avoid adding warnings to selftests which
aren't present in the main kernel code.  If only to avoid surprising
people over what isn't permissible in selftests/.

In particular, there's an expectation that we can do

#else
static inline int some_stub(type1 arg1, type2 arg2)
{
}
#endif

without warning.  We do this extensively.

Also, please be aware that there's already a patch in mm-new which
centralizes selftests' __maybe_unused definition.
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/selftests-centralise-maybe-unused-definition-in-kselftesth.patch

