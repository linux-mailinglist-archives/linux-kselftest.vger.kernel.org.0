Return-Path: <linux-kselftest+bounces-43969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B267C0477D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 08:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA91AA3910
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 06:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919862737E0;
	Fri, 24 Oct 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB1tTKiu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6742F271476;
	Fri, 24 Oct 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286616; cv=none; b=GfP27mKpG0aigC0K/np5eX1ZaqRa7zjZSp+Hxxpe2g1lVxXPqj44Daa8yhdW4y3aNIk+15gMc+e0eGBIvtjt5ZdibozHxFGUW+3f1CF/fYUR58DA6FZTFMQtbwNV2yt4rIDvFQYRbK4CTzxS3H1B6d2PrwwqCgXOLZF6pBbJqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286616; c=relaxed/simple;
	bh=J6WIkfXnPdWT+D0UqznjgN5ZqG6M9x/P4cC88zuW9ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a90SfZ29DMH1iMQ0dPJm33JxL/yHWf/yuhWnLmrkOXkTWfrqBybuP2BG/xHmSjtz1xUGnWSmgrVTRIb+QErvrqZMm0PXEF3/Oky+l/AzBWUAkHZuLC4er7Lf1mPlaPGceuSlJPfG8W2Oe/1p2xe6WmBaGZyKjkC0/+97cwMHGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB1tTKiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D15C4CEFF;
	Fri, 24 Oct 2025 06:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761286615;
	bh=J6WIkfXnPdWT+D0UqznjgN5ZqG6M9x/P4cC88zuW9ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kB1tTKiuaZ4sHGOEBDene7o2a9UDxqLw/HjLZkhLhd9Dy3QAwHrIDBNiFftVHcdJo
	 gyuh9gdj92162HPyYBXCk8QciuYLejTYCOBQQlaVuMoiC8YPJ5RI9RKQPeUGwaaIgC
	 dydI51f47MEcnCighnQ+DsimDY2nqtrL2Z05UphmwfViM4gCdzYZuz/grMedBMzhLt
	 ErwD+OnIslmYeKISIEIWpjlV3VND5nxE7macxEFFju7EVaTllwmcYWt3VPlJkM6+ml
	 gUgQRR02ohL5AmMghYoAEe4dPh1O8pIzyDGn5TLhR0LGUlUOTxqnZeWZhcNkdzXgnn
	 J0TRiOAxRgm+A==
Date: Fri, 24 Oct 2025 09:16:47 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
	brauner@kernel.org, corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCHv7 3/7] kho: drop notifiers
Message-ID: <aPsZzxmGjrJSzB4q@kernel.org>
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-4-pasha.tatashin@soleen.com>
 <mafs0ikg7fbez.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0ikg7fbez.fsf@kernel.org>

On Wed, Oct 22, 2025 at 01:01:08PM +0200, Pratyush Yadav wrote:
> Hi Pasha,
> 
> On Tue, Oct 21 2025, Pasha Tatashin wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > The KHO framework uses a notifier chain as the mechanism for clients to
> > participate in the finalization process. While this works for a single,
> > central state machine, it is too restrictive for kernel-internal
> > components like pstore/reserve_mem or IMA. These components need a
> > simpler, direct way to register their state for preservation (e.g.,
> > during their initcall) without being part of a complex,
> > shutdown-time notifier sequence. The notifier model forces all
> > participants into a single finalization flow and makes direct
> > preservation from an arbitrary context difficult.
> > This patch refactors the client participation model by removing the
> > notifier chain and introducing a direct API for managing FDT subtrees.
> >
> > The core kho_finalize() and kho_abort() state machine remains, but
> > clients now register their data with KHO beforehand.
> >

...

> > @@ -1280,7 +1298,7 @@ static __init int kho_init(void)
> >  	kho_enable = false;
> >  	return err;
> >  }
> > -late_initcall(kho_init);
> > +fs_initcall(kho_init);
> 
> Is this change related to this patch? Also, why fs_initcall?

memblock registers sub-fdt in late_initcall(), so we should have the root
fdt ready by then. 
  
> -- 
> Regards,
> Pratyush Yadav
> 

-- 
Sincerely yours,
Mike.

