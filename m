Return-Path: <linux-kselftest+bounces-31102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA2A92DD8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27991B661FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D637221DA0;
	Thu, 17 Apr 2025 23:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oJgJBS7Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145321C177;
	Thu, 17 Apr 2025 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931518; cv=none; b=oHK1+lpfDDRitCkhydh2HfEcUHphXrIZv9iDNU7Zt/D6f6tDNyebDEJFzXJDgz7fcvwVMArEBE0B6KuvT2sSohhOvdLqrZdieLYhoSr3sz+R9sCc7045JNqL7abMzXfSQVFJvs9jFYS74/a1o6cuGLQu4Pb4dySBFvyxu9Olzm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931518; c=relaxed/simple;
	bh=EeKnel7qr9AOqAQgn2twWI0/sIIDoxrDQ4CYwhn6dvw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IKyrhvJUEemHKpDKer+VxyMTjkXLA2GaJY9jmGCaFUFmGUBj1vX3p01p+00RMMtAoImRB286mC44jwVU1Z2i+6/A/jg2y+cM/f8Njusox+isMVXVlP9JlBepua195tvEfgEZ3qTaQv8gFtH3j860JxJyMGHZ50aZP1vwFMeCMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oJgJBS7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B834C4CEE4;
	Thu, 17 Apr 2025 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744931517;
	bh=EeKnel7qr9AOqAQgn2twWI0/sIIDoxrDQ4CYwhn6dvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oJgJBS7Zxa9b5NbMPZl0Jcm5lskpEWwWaGjQ1kf0v6DOi2JTp4gfB3WbxYlrxdzCA
	 47V6tY4qvSyH+ig+W1tBNa/Gjx374KGNvigMyGAoKa1RUYW9HkNOwl0JO8LHwB8buJ
	 tzXY6MC/3OBRXqHma594adAOlNRTKnPpWHEgJOEI=
Date: Thu, 17 Apr 2025 16:11:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, david@redhat.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, shuah@kernel.org, ziy@nvidia.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
Subject: Re: [PATCH v4 0/4] mm: introduce THP deferred setting
Message-Id: <20250417161155.3e160d8af14eac86c80d1e49@linux-foundation.org>
In-Reply-To: <20250417001846.81480-1-npache@redhat.com>
References: <20250417001846.81480-1-npache@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 18:18:42 -0600 Nico Pache <npache@redhat.com> wrote:

> This series is a follow-up to [1], which adds mTHP support to khugepaged.
> mTHP khugepaged support is a "loose" dependency for the sysfs/sysctl
> configs to make sense. Without it global="defer" and  mTHP="inherit" case
> is "undefined" behavior.
> 
> We've seen cases were customers switching from RHEL7 to RHEL8 see a
> significant increase in the memory footprint for the same workloads.
> 
> Through our investigations we found that a large contributing factor to
> the increase in RSS was an increase in THP usage.
> 
> For workloads like MySQL, or when using allocators like jemalloc, it is
> often recommended to set /transparent_hugepages/enabled=never. This is
> in part due to performance degradations and increased memory waste.
> 
> This series introduces enabled=defer, this setting acts as a middle
> ground between always and madvise. If the mapping is MADV_HUGEPAGE, the
> page fault handler will act normally, making a hugepage if possible. If
> the allocation is not MADV_HUGEPAGE, then the page fault handler will
> default to the base size allocation. The caveat is that khugepaged can
> still operate on pages thats not MADV_HUGEPAGE.
> 
> This allows for three things... one, applications specifically designed to
> use hugepages will get them, and two, applications that don't use
> hugepages can still benefit from them without aggressively inserting
> THPs at every possible chance. This curbs the memory waste, and defers
> the use of hugepages to khugepaged. Khugepaged can then scan the memory
> for eligible collapsing. Lastly there is the added benefit for those who
> want THPs but experience higher latency PFs. Now you can get base page
> performance at the PF handler and Hugepage performance for those mappings
> after they collapse.
> 
> Admins may want to lower max_ptes_none, if not, khugepaged may
> aggressively collapse single allocations into hugepages.
> 
> TESTING:
> - Built for x86_64, aarch64, ppc64le, and s390x
> - selftests mm
> - In [1] I provided a script [2] that has multiple access patterns

Namely https://gitlab.com/npache/khugepaged_mthp_test?

Looks useful and could perhaps be directly linked to from this
patchset's [0/N] changelog?


