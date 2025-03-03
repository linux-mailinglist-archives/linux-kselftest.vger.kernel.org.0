Return-Path: <linux-kselftest+bounces-28083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C185A4C8EF
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88433B4AC4
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902B122ACD6;
	Mon,  3 Mar 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kma46+1m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66821214A8A;
	Mon,  3 Mar 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020494; cv=none; b=g1p/eicSW3sY+0dVjLA2cu81VcEDfuK1DoT6RD7DA/296Sj1VNiizDOlue00gDsTblXW6pxOrGutIdgwl67eotGDjilBZ/k+tvY5u5X36ajDYobOZ//insCVTnGLCd0SxXNk7Yc6hh9PF7H1VdBvZr9nKIT2pQOQWUw2crNXfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020494; c=relaxed/simple;
	bh=bw0yJZnhs1/BZaCqXfD9wjtRb11sZ067nWTPBfuSx8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODdqkuO8A8hVpbtHK7kMaFJKSyKY36k2GgFGa9Hd/bl0y+E3jKug+sYmvFh74tDGtLebCsCI3w3KIT7bOwWYy9yDanitBNSLgTBZiED78TEiL3hUBHuYwMX9Adl01PG6RCL4Y0I9RBkX8L8RiysnoRcbKw6XsYu5nEQqCkYbTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kma46+1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D655DC4CED6;
	Mon,  3 Mar 2025 16:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741020493;
	bh=bw0yJZnhs1/BZaCqXfD9wjtRb11sZ067nWTPBfuSx8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kma46+1mbo5HVbvSYni1BkXX+MDggtOQ4udarzKeT0m3EGju2PFRlGQ9KOdvgAHYj
	 xuH7xIujwcqkI8VldRhMtzPRoJW1xMiaB8vELBXD4z94E1DPXsQnBO6FbLJSORi6yU
	 qkBnC+fe6HFJRSnmsswBb9bUF+Rn0qWZsnM2eQlgETiFjtfStyeOpbxfwZCFnbDua2
	 txE5ukd7zBvy7W2mkC4+YHInipJyqlCTnEZpJGH+vEDLOjkiMSKDVMdbPt0mcRxHxQ
	 FYuNxam14opEZtWVKlYIB+30IudERhVk3LhDfclOncqey/tJVPiDd4hmnaFcgzjjb8
	 w+RQHt2dVgslw==
Date: Mon, 3 Mar 2025 08:48:10 -0800
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org,
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
	ojeda@kernel.org, thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com, johannes@sipsolutions.net,
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
	anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com
Subject: Re: [PATCH v8 7/7] selftest: test system mappings are sealed.
Message-ID: <202503030847.5E73540@keescook>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-8-jeffxu@google.com>
 <d945816e-b01f-4a7c-b698-23ec356280f3@lucifer.local>
 <8285bc26-6afe-4141-ad1a-6d8c5d6d76f9@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8285bc26-6afe-4141-ad1a-6d8c5d6d76f9@lucifer.local>

On Mon, Mar 03, 2025 at 04:43:47PM +0000, Lorenzo Stoakes wrote:
> On Mon, Mar 03, 2025 at 12:08:49PM +0000, Lorenzo Stoakes wrote:
> >
> > On Mon, Mar 03, 2025 at 05:09:21AM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Add sysmap_is_sealed.c to test system mappings are sealed.
> > >
> > > Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
> > > config file.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >
> > We do need to add this to the general selftests Makefile, but this code is
> > fine, so have a:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Congratulations! :) and thanks for addressing the issues that were raised,
> > appreciate your efforts on this.
> >
> > Maybe you could send a fix patch? As it's such a small fix.
> >
> > Cheers, Lorenzo
> >
> >
> > > ---
> > >  .../mseal_system_mappings/.gitignore          |   2 +
> > >  .../selftests/mseal_system_mappings/Makefile  |   6 +
> > >  .../selftests/mseal_system_mappings/config    |   1 +
> > >  .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++++
> >
> > Can you add this to tools/testing/selftests/Makefile? I _think_ adding:
> >
> > TARGETS += mm
> >
> > Should do it. Thanks!
> 
> Obviously I meant to say:
> 
> 	TARGETS += mseal_system_mappings
> 
> Doh! :)

Heh. Simultaneous emails! ;)

-- 
Kees Cook

