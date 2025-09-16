Return-Path: <linux-kselftest+bounces-41560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 912D8B58C42
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 05:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2F51BC45F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 03:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877A23A9B3;
	Tue, 16 Sep 2025 03:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qLiL7R0f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4F2EAE3;
	Tue, 16 Sep 2025 03:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757992580; cv=none; b=HKbZVdnGZYt74KU/+S1WeRav/3f3zIA+066BqXdbmnCxA68BhqbYT1TWvYhITI123y6iA2sm1XJdrz+0LImHDoNzvsVSBzvX6R3+SvSY9DBXF8k1kGjRtU4iqacLQi3Upew6ODppTKVGJ5KmLxMhaSTNi4aPIfKf5UypUCF2/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757992580; c=relaxed/simple;
	bh=KQgIDFeYj6BfahlWkfqkbzH/E4fZL8fqkKbPwk5VHm8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lpC+tvoQzVAlavu/i+HH80J7euY37ed0YbzA0Qssfk06absh7rmHfELK9DlvxlOpYXVYLE2N/jnDJPnunmngZamT3XHAsV6SGxATH6X2lHVuKmD34/DHf+xHODcHTKYMDAnIPzKXIV/83OHD6S4KR2nbDaqzJ7QWd4YgO/dEiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qLiL7R0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8A2C4CEF0;
	Tue, 16 Sep 2025 03:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757992579;
	bh=KQgIDFeYj6BfahlWkfqkbzH/E4fZL8fqkKbPwk5VHm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qLiL7R0fKERFaeUDekpvnT0bCQ6X1MJ36FqoZwhuZrNzvtGm9MkQu9m08+MI4WZwM
	 TzBCMurJMdOsYoEgNdNN3ZGQpUPubYUYOjWvvM/9imNNEYhG6BNYZqtqjDxf7V2NNc
	 F/gly7u3moLwHxdh8lc10HKrP88+9PrO3jsPjU6s=
Date: Mon, 15 Sep 2025 20:16:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: corbet@lwn.net, david@redhat.com, linmiaohe@huawei.com,
 shuah@kernel.org, tony.luck@intel.com, jane.chu@oracle.com,
 jiaqiyan@google.com, Liam.Howlett@oracle.com, bp@alien8.de,
 hannes@cmpxchg.org, jack@suse.cz, joel.granados@kernel.org,
 laoar.shao@gmail.com, lorenzo.stoakes@oracle.com, mclapinski@google.com,
 mhocko@suse.com, nao.horiguchi@gmail.com, osalvador@suse.de,
 rafael.j.wysocki@intel.com, rppt@kernel.org, russ.anderson@hpe.com,
 shawn.fan@intel.com, surenb@google.com, vbabka@suse.cz,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline
 for HugeTLB pages
Message-Id: <20250915201618.7d9d294a6b22e0f71540884b@linux-foundation.org>
In-Reply-To: <aMiu_Uku6Y5ZbuhM@hpe.com>
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 19:27:41 -0500 Kyle Meyer <kyle.meyer@hpe.com> wrote:

> Soft offlining a HugeTLB page reduces the HugeTLB page pool.
> 
> Commit 56374430c5dfc ("mm/memory-failure: userspace controls soft-offlining pages")
> introduced the following sysctl interface to control soft offline:
> 
> /proc/sys/vm/enable_soft_offline
> 
> The interface does not distinguish between page types:
> 
>     0 - Soft offline is disabled
>     1 - Soft offline is enabled
> 
> Convert enable_soft_offline to a bitmask and support disabling soft
> offline for HugeTLB pages:
> 
> Bits:
> 
>     0 - Enable soft offline
>     1 - Disable soft offline for HugeTLB pages
> 
> Supported values:
> 
>     0 - Soft offline is disabled
>     1 - Soft offline is enabled
>     3 - Soft offline is enabled (disabled for HugeTLB pages)
> 
> Existing behavior is preserved.

um, why?  What benefit does this patch provide to our users? 
Use-cases, before-and-after scenarios, etc?

> Update documentation and HugeTLB soft offline self tests.
> 
> Reported-by: Shawn Fan <shawn.fan@intel.com>

Interesting.  What did Shawn report? (Closes:!).

> Suggested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
>
> ...
>
>  .../ABI/testing/sysfs-memory-page-offline     |  3 ++
>  Documentation/admin-guide/sysctl/vm.rst       | 28 ++++++++++++++++---
>  mm/memory-failure.c                           | 17 +++++++++--
>  .../selftests/mm/hugetlb-soft-offline.c       | 19 ++++++++++---
>  4 files changed, 56 insertions(+), 11 deletions(-)

I'll add it because testing, but please do explain why I added it?

