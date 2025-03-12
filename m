Return-Path: <linux-kselftest+bounces-28828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1CDA5E1F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 17:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94443189B4E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6461D63D8;
	Wed, 12 Mar 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciHXz99f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0A16D4E6;
	Wed, 12 Mar 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797914; cv=none; b=VW67rtmRx5bKjV27hJEEK7Ny8jzGkzNLzDEA0D2p3HKtuxwtxx0P3umTenTSIUC40haeAaT593otOKjhiBjhVgobv3dp55/NtW3G5hZqdTda7D5PDZJ/wMi2aSqtqkkP7Ra2ILyP+HTEmTKUNl/G3PW8tPLtksuFD5QjZp6hSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797914; c=relaxed/simple;
	bh=TaBL3DRUz6zYFeMlXsdcM29mTzw5As4+GXLcyh8kqqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM0snADYnIsLgGUiJrWm15w3DFTFeYO1ojk+kn86roMAEB3w399oyRTb4nQxnbBdIOnXM7ScYZp+gPItktADmLgq1yZu3+vrDXv0nRbwFZFszG/MC/VK4XsWey8w/Ys/OMVUKttZroTvWx/oAaqORW50vU1l+gxhZigmPHh5Ul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciHXz99f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF82C4CEEB;
	Wed, 12 Mar 2025 16:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741797914;
	bh=TaBL3DRUz6zYFeMlXsdcM29mTzw5As4+GXLcyh8kqqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciHXz99fGb5B0cEhiZ9bJENrAhhbjSas0N3a4t5aBuTm20qGPFUUmmVTnOZw2lxOG
	 hpYLJ/MtYrEf8l4St60yfQLPEVNl+B6cq8LUMoY4Z/G/jXpJox02xpAM5+0BFfNo+p
	 78EljrTa3GIU4lqvzAhlWbq2hUaP829zr+AK/nLJuqksc+3C6xT4JYS2MHXbJir/f9
	 h7DzEjBGOasBSxDpv9fdhzNt9KBOqmkYE3YdHb28zou1stCoUOKQI7E3XS6ZWI+qJ8
	 vyA5ubKXEEaPXCUIFXM+y6q/ndigJsJzLpBFwaiDFdLC9RHNvjSPxGE6V1i1f4fprn
	 A3qEZjVHUwXiQ==
Date: Wed, 12 Mar 2025 09:45:09 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, vbabka@suse.cz,
	Liam.Howlett@oracle.com, broonie@kernel.org,
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, jorgelo@chromium.org, pedro.falcato@gmail.com,
	rdunlap@infradead.org, jannh@google.com
Subject: Re: [RFC PATCH v1 2/2] mseal: allow noop mprotect
Message-ID: <202503120931.3BD7A36445@keescook>
References: <20250312002117.2556240-1-jeffxu@google.com>
 <20250312002117.2556240-3-jeffxu@google.com>
 <c867bff9-2293-4890-af46-8a797cf512c2@lucifer.local>
 <64B6294F-B059-4744-8548-89D7B519BE72@kernel.org>
 <9b3a3ac6-a947-4be2-98b3-c35c195d87ab@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b3a3ac6-a947-4be2-98b3-c35c195d87ab@lucifer.local>

On Wed, Mar 12, 2025 at 03:50:40PM +0000, Lorenzo Stoakes wrote:
> What about madvise() with MADV_DONTNEED on a r/o VMA that's not faulted in?
> That's a no-op right? But it's not permitted.

Hmm, yes, that's a good example. Thank you!

> So now we have an inconsistency between the two calls.

Yeah, I see your concern now.

> I don't know what you mean by 'ergonomic'?

I was thinking about idempotent-ness. Like, some library setting up a
memory region, it can't call its setup routine twice if the second time
through (where no changes are made) it gets rejected. But I think this
is likely just a userspace problem: check for the VMAs before blindly
trying to do it again. (This is strictly an imagined situation.)

> My reply seemed to get truncated at the end here :) So let me ask again -
> do you have a practical case in mind for this?

Sorry, I didn't have any reply to that part, so I left it off. If Jeff
has a specific case in mind, I'll let him answer that part. :)

-Kees

-- 
Kees Cook

