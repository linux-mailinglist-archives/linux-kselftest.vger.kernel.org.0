Return-Path: <linux-kselftest+bounces-45523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02965C568CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11C424E9DD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4312C324F;
	Thu, 13 Nov 2025 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMMueHiG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6472C11C5;
	Thu, 13 Nov 2025 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024809; cv=none; b=OUgp+Bm8DVP5TfGx34piFXbBw3hjYY9uI4EFa0YZvaIrzFHDX+qSz9mknRzdk2dVYJDQAAR1rrF/Sd7CFjRrc85shqoe59fpI2q3dHWVY7IvKhYCPPl4xOkI5zHHUHtPwzAS+2Phe7OMnjTH1TSpX7ahuGRl5rnRNp4WNvEhiTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024809; c=relaxed/simple;
	bh=kzjNmKxRv2HTgs2BLleVn+WPjcFHAp+Wpu1+B0RTMcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwGAeloTQHhSampuR9Nib+lldJFh082V3OG3qp/9z6upsKlFPRsUyEeStgGxb8gLIGsnmaheFfqZSSHtzaCOFh50n7ijm7rc8Mn+zm9zpdb8Mzc5Zk96PGaRoWyXFamdPkZe2vFvAYOF4dEcQQSIVekP9EHKwJ2+oih3CwSFfqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMMueHiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871ABC16AAE;
	Thu, 13 Nov 2025 09:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763024808;
	bh=kzjNmKxRv2HTgs2BLleVn+WPjcFHAp+Wpu1+B0RTMcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rMMueHiGvlrNs0GOCrftUTNWmns+IBBzry02OQpjdL86fQD1Vt2a34qjLTyOMa6oO
	 q2CHwNgbCa4RZFauDEOSNlG6DdPb29aKc8eLeNgi88psiR5iehoQiw3AT5pafglAK0
	 lV8xWJNCMAzM4IFbXKq8i8lkO+PX4j0xY7uNPy2jrnFpSiV9/3SshWEfIR7tTWsB7H
	 ioy3iuygOXPiNUqvH1KssnH/7XuxzmU/j1CH+6xt7Nk0uuVQHLjjP1BV1kD7hMbrBv
	 MTlJDSM+sgcKd0ie3cIVt8OjXBQvoKl0cN7IQdtwUWx8bSlOAodKyl6EOH0A44NfOt
	 T5l6xJqgvIwgg==
Message-ID: <e0be6864-4260-4843-a432-d47437b5d43f@kernel.org>
Date: Thu, 13 Nov 2025 10:06:42 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: fix division-by-zero in uffd-unit-tests
To: Carlos Llamas <cmllamas@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, Ujwal Kundur <ujwal.kundur@gmail.com>,
 Brendan Jackman <jackmanb@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 "open list:MEMORY MANAGEMENT - USERFAULTFD" <linux-mm@kvack.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20251113034623.3127012-1-cmllamas@google.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251113034623.3127012-1-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.25 04:46, Carlos Llamas wrote:
> Commit 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global
> vars into struct") moved some of the operations previously implemented
> in uffd_setup_environment() earlier in the main test loop.
> 
> The calculation of nr_pages, which involves a division by page_size, now
> occurs before checking that default_huge_page_size() returns a non-zero
> This leads to a division-by-zero error on systems with !CONFIG_HUGETLB.
> 
> Fix this by relocating the non-zero page_size check before the nr_pages
> calculation, as it was originally implemented.
> 
> Cc: stable@vger.kernel.org

Do we CC stable on unit tests? From my recollection, no.

> Fixes: 4dfd4bba8578 ("selftests/mm/uffd: refactor non-composite global vars into struct")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

