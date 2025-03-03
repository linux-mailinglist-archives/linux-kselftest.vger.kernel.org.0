Return-Path: <linux-kselftest+bounces-28080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE59A4C8AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE9F174FF2
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA1F23C8C6;
	Mon,  3 Mar 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onc99M3H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636FD21C186;
	Mon,  3 Mar 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019976; cv=none; b=nqxgode0KJ8hPEW6B1KPVe0RXK4u40S59qWJXrdfDkTal5ZbVVriOGu2geN6vgkDpN9e39O0cX58ju0PzXF6NjD8+mYhALCfEyKoMffd96hb0fzLfddAI6Ld3z7nk+SpuHVVeozXzs24ILNrunnEPt12m+M0R5LVMlDAJgLgoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019976; c=relaxed/simple;
	bh=zwtGLARRnKbqh6KymCpIlBQVR/uzH1mgO7Bo/JUe4BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGl2i4baAXnwV0Iu+zcsLUGrULM4Q5Lg42hCwTjf8BGvKGVB+h2vjQne3qGYreH+Qbfvxzj054P/ZPE3OAEVz03QsbgMgoT8cldJHTc35DMOmw7U0R3F3kXH4BM+GwhxWlFQhuKcteOqDj+NyBrrN/rX9M0cX49mOqTFBRnRezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onc99M3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9A7C4CED6;
	Mon,  3 Mar 2025 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019975;
	bh=zwtGLARRnKbqh6KymCpIlBQVR/uzH1mgO7Bo/JUe4BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Onc99M3HOtj4PWSLc24/2tOMzX3rWDXGz3ckeBHfIU0L2Kx/ftQMTwST75DC33knk
	 SrqQpfz11owMFv3jocga3xHpZlHzf4JaUlPUEUHlBnYNDqFAqruWqyGlNKaVD7oaOa
	 N4icBkVOgChGdxppM1XCsBr4wFfxyFEHZ+g2/8wvtVjlvXjL0EBxPkHP/WDVfi6JJX
	 Y0tMWvaLZg8XJ98O/kb9stEgg71rvODX+68MC7I0REFzn7B7thNF3SdSSwHRs37Eza
	 j/d3RvKN1k52jpPorH+10qyHTaZOJGBRDIRuuYWkjdsVv4A9NioJyhuNnjsEgXITh4
	 UlX6r3JL6AN+w==
Date: Mon, 3 Mar 2025 08:39:33 -0800
From: Kees Cook <kees@kernel.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
	sroettger@google.com, hch@lst.de, ojeda@kernel.org,
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
	johannes@sipsolutions.net, pedro.falcato@gmail.com,
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de,
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net,
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org,
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org,
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org,
	ardb@google.com, enh@google.com, rientjes@google.com,
	groeck@chromium.org, mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Subject: Re: [PATCH v8 5/7] mseal sysmap: uprobe mapping
Message-ID: <202503030839.6333DA9@keescook>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-6-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-6-jeffxu@google.com>

On Mon, Mar 03, 2025 at 05:09:19AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide support to mseal the uprobe mapping.
> 
> Unlike other system mappings, the uprobe mapping is not
> established during program startup. However, its lifetime is the same
> as the process's lifetime. It could be sealed from creation.
> 
> Test was done with perf tool, and observe the uprobe mapping is sealed.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

