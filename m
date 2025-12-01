Return-Path: <linux-kselftest+bounces-46783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B4C964BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 10:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D32034E18B5
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 09:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6F2FE06D;
	Mon,  1 Dec 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUQnqU3I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081702FE065;
	Mon,  1 Dec 2025 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764579595; cv=none; b=WBwqtY2TqUDvgfo8G1922xSfirRn6O3U34Wo+JxUJ0H2C3p0gw6kJQZD9/aKBSGqIFNa6ZSMteHEwr91+bkew0ywSV3g3qJ4cxndNcx5TkriLvd82tPkNuo9siVtLRCRPBT3X1gT6i1eusTypdEubSmL7J5sdNTmV6nvz+GbZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764579595; c=relaxed/simple;
	bh=XFnJpvWNqT0Iil1YFGSDXH4hktrbxLGtcmxxzhqoVxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLifZnOi0SbCFehR8p6c6Flil6sHNVIjc0V2N8DW4b3J5eYF9j+m2Li2GPsZDm903g3SBAu1iswy26gI/jzWSDieGO93HQsuV2gABj0v9JxAocfDD+v1MS0FJBT7KnNlVGCRnyAm31Jzj8BzV1AqK75r4NcTqtlIHeh887QQnCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUQnqU3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190FFC4CEF1;
	Mon,  1 Dec 2025 08:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764579594;
	bh=XFnJpvWNqT0Iil1YFGSDXH4hktrbxLGtcmxxzhqoVxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dUQnqU3IKLkudOiVLuuIXEmlc+kZnsIYDwkJW75j8OQM+SDFYy3x3JAijGlZ9NmO1
	 76Baw2b68fUlUApo91neXXzMCDpf8SmPOceJp0/whw9qYqhQlIjoCNOP+h6GQ2Eyn3
	 gM1FXpcgAUd6+Ge6UTQuLbuZEEv64px3Y9oEkQ2Pl6S3Lmm8kx6+v4617oh88WbiY8
	 NIUVCvEO+SnH6RefcuOpEeWbP1dL/44xfVtywyoAV+hEFu8OAWH+WSxXvjF6Fe3UFw
	 VtgGNpqb7MzdOSJ2XBwlvF1LWQtVzimiAEZSOcbQSV240B31+CipR8x8JMGtxLI3bp
	 Zi88BYx5W9X4w==
Message-ID: <3b1916a6-0883-4713-8334-17d3932fe3b9@kernel.org>
Date: Mon, 1 Dec 2025 09:59:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mm: introduce VM_FAULT_UFFD_MINOR fault reason
To: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, James Houghton <jthoughton@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Nikita Kalyazin <kalyazin@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251130111812.699259-1-rppt@kernel.org>
 <20251130111812.699259-4-rppt@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251130111812.699259-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/25 12:18, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> When a VMA is registered with userfaulfd in minor mode, its ->fault()
> method should check if a folio exists in the page cache and if yes
> ->fault() should call handle_userfault(VM_UFFD_MINOR).
> 
> Instead of calling handle_userfault() directly from a specific ->fault()
> implementation introduce new fault reason VM_FAULT_UFFD_MINOR that will
> notify the core page fault handler that it should call
> handle_userfaultfd(VM_UFFD_MINOR) to complete a page fault.
> 
> Replace a call to handle_userfault(VM_UFFD_MINOR) in shmem and use the
> new VM_FAULT_UFFD_MINOR there instead.
> 
> For configurations that don't enable CONFIG_USERFAULTFD,
> VM_FAULT_UFFD_MINOR is set to 0.
> 
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

LGTM and does not look too invasive for me.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

