Return-Path: <linux-kselftest+bounces-43848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6111FBFF9F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 09:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81453AE789
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 07:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4B2D641C;
	Thu, 23 Oct 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJfjDTDO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442722C11D6;
	Thu, 23 Oct 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204065; cv=none; b=Y5qyzsB25VtiT+sdqNXic6jQWU4MRwNeOKs/+f6ZtMmDUrY1TldLu/TX/ETqbm0jQvkSSiRImW/Xit3YPPjFvw4b81RWUNc8+89O+uM3zayyhQhtpue28bkvWEq0QVWKEYyP6DM0q9ObG4N/Q4x/U/h6occmFC5CyUueNoDDFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204065; c=relaxed/simple;
	bh=GEunqVYG6q61dM4benmxjxOVFq+a4931xrkxsYdnZ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPB72xJ8yQIW2h7XoEOJpvKcvC7AMtUTqDW2I6AJbhmu1Jw5a1AVM1B1ItMUt1Yh43DBrZIReltpVO3qpUTmkwVVGZKaPgNVxpDBxFI/OtvFs64KWuhbYXUWoyTc8eo9rve08H5nUo+MTmNHnfnCuExopD/QrBZVRdnrgI8j5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJfjDTDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CF4C4CEE7;
	Thu, 23 Oct 2025 07:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761204063;
	bh=GEunqVYG6q61dM4benmxjxOVFq+a4931xrkxsYdnZ+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJfjDTDOyC/FjwMNQylaD5MrDantTgYxOhKCCP5U3juDPgS14qRbG2gc9z1//5vld
	 U5qStXNYcvSwPpKgLhqJRC2eTZZPrGY8vYdl08nF14ofhNRa45ZtQD2z52X3pXJxEH
	 jv0Nj2iq+tgTWN1+Xt30cECOfbsxtLCkXQ9EGo3wN2q6lvANrqmRuHbkjjqvwJ5cA1
	 Suq++GZGLNfjSz91IkxN0TVeO+Y7npqe0mB+o0RP8Hqwf1b6KIlMLPvFoxVQ+Avj4K
	 BjL4vzqg4vlgpK4F7uhQrPR8BYEnEKBuMU2gZu2D/YwId8MtYUZGBwx06E7gHtYVoZ
	 p+cqXQjQvXWAQ==
Date: Thu, 23 Oct 2025 10:20:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
	brauner@kernel.org, corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCHv7 5/7] kho: don't unpreserve memory during abort
Message-ID: <aPnXVmD3cNmYNRF_@kernel.org>
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-6-pasha.tatashin@soleen.com>
 <mafs0a51jfar1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0a51jfar1.fsf@kernel.org>

On Wed, Oct 22, 2025 at 01:15:30PM +0200, Pratyush Yadav wrote:
> On Tue, Oct 21 2025, Pasha Tatashin wrote:
> 
> > KHO allows clients to preserve memory regions at any point before the
> > KHO state is finalized. The finalization process itself involves KHO
> > performing its own actions, such as serializing the overall
> > preserved memory map.
> >
> > If this finalization process is aborted, the current implementation
> > destroys KHO's internal memory tracking structures
> > (`kho_out.ser.track.orders`). This behavior effectively unpreserves
> > all memory from KHO's perspective, regardless of whether those
> > preservations were made by clients before the finalization attempt
> > or by KHO itself during finalization.
> >
> > This premature unpreservation is incorrect. An abort of the
> > finalization process should only undo actions taken by KHO as part of
> > that specific finalization attempt. Individual memory regions
> > preserved by clients prior to finalization should remain preserved,
> > as their lifecycle is managed by the clients themselves. These
> > clients might still need to call kho_unpreserve_folio() or
> > kho_unpreserve_phys() based on their own logic, even after a KHO
> > finalization attempt is aborted.
> 
> I think you also need to update test_kho and reserve_mem to do this
> since right now they assume all memory gets unpreserved on failure.

I agree. 

> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

