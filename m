Return-Path: <linux-kselftest+bounces-48588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9ADD07C40
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 09:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAA08301C81B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973553033CE;
	Fri,  9 Jan 2026 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk+RzwZJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0503302176;
	Fri,  9 Jan 2026 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946873; cv=none; b=ptPGU3GgUYow7HJP1IDQzupqVDmXfNWQX/qj5qMU4G0ahWSeGY8FkH+kQ7K3SFZTl2xLkxu/sGO7tGuU3ev8sDc6ZsOnL7bJ041hl0B23OKAYmRDgKYF6VYl53riXIw1ZJ+IYnqhf9q5PA5auqSKbmWBEs6QFpgkr2rArITZnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946873; c=relaxed/simple;
	bh=KUFuE5V8UAiIurL6g3Fp/lJo2ewluF8KzNFw5f5PUjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2DOlzGeLNV3Pw8FLyo7bQLnB6qzYxng/dnX4iGjcdqVm0B4IMAwKhTpui/g4jw0EZB/ad2uYpy+65YKem65mI98X11jBe8w4iqmMGWEOBxa3NihE+Noa6M8Ohtu1TVD+LRNJ39xsnN80kVCYIRvNyDdh+CSz/F1gE+STLjG4Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk+RzwZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA62C19422;
	Fri,  9 Jan 2026 08:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767946871;
	bh=KUFuE5V8UAiIurL6g3Fp/lJo2ewluF8KzNFw5f5PUjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gk+RzwZJgqFqDXbdeT7Ij2ANvkctK08svhshZT4R6yu6GK6U5FU7oH4Xe+zv8qwMi
	 4CjPgeTPbBjv8HsMIltG5ewdwonA8kjSIA667gREwSdMJ3RS+7Buq5U6Eos8SvbK+J
	 nKkrMxUoT4X8Q0FyxCy4EZdhe4iqJhr4V6t7/UJCAhTlbVpUQXR/gm208md0TMmWZM
	 HkmXt9IdJ7rCxhmZTAD0oRgGfDs7xzYOTVswLzOoZ7GMgJgYq9abd0Ivcl84yf5tq9
	 J4AmlCsrCF8YDst8YMFTNmMfuhpye4VlBUo7YM7KAkx0A9LACF/F+ezsCZLKZlQrcl
	 B6Hco6Rs0QnpA==
Date: Fri, 9 Jan 2026 10:21:00 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Lain Fearyncess Yang <fearyncess@aosc.io>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	Kexy Biscuit <kexybiscuit@aosc.io>, Mingcong Bai <jeffbai@aosc.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] loongarch: wire up memfd_secret system call
Message-ID: <aWC6bIEg6UqvX1DO@kernel.org>
References: <20260109051054.188030-1-fearyncess@aosc.io>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109051054.188030-1-fearyncess@aosc.io>

On Fri, Jan 09, 2026 at 01:10:51PM +0800, Lain Fearyncess Yang wrote:
> From: "Lain \"Fearyncess\" Yang" <fearyncess@aosc.io>
> 
> LoongArch supports ARCH_HAS_SET_DIRECT_MAP, therefore wire up the
> memfd_secret system call, which depends on it.

LoongArch version of set_memory* does not support splitting of leaf PMD
entries. Does LoongArch always use PTE-level mappings in the direct map?
 
> Signed-off-by: Lain "Fearyncess" Yang <fearyncess@aosc.io>
> ---
>  arch/loongarch/include/asm/unistd.h     | 1 +
>  arch/loongarch/kernel/Makefile.syscalls | 6 +++---
>  tools/testing/selftests/mm/Makefile     | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)

-- 
Sincerely yours,
Mike.

