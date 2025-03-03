Return-Path: <linux-kselftest+bounces-28082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA6A4C8CC
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DD4188CC20
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4686B24E4A9;
	Mon,  3 Mar 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsRv0MyW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1936922332D;
	Mon,  3 Mar 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020439; cv=none; b=CkW7PBn2dckMML+sDV8Z52DJmZho6mIyHJ3J7lwojsmD070KHFW4tnLbUPtOHsq58RmS4RnuBEU0tRf8SOhGRDk5kLFe1BtZ5h/1ZBwwgC3qFvfBKjIe9weaPbuhUFSWLYFCm6xImvjuNLb6j9IHJcH9t/Qiwaz2im6Sjio2Ofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020439; c=relaxed/simple;
	bh=4yX2ove+H3YjYb7KFBwrFbNCLgvX35Q86cuMFRmKlmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOfLGbEz2H5QKxzJ2rvMxvR3DG04kg6nythPQONy0Ia9kntQWYNTfQ78ndDmNiAXw/zXoEMafJ+XWDqtKap4h5dhJmNyEp6iMo10zL090pHYFXcNoPnpcpy0fLIhxZsymVXUjuBiENgNO99z4SI7G0X0ah2vum3W1eUx0aslVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsRv0MyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8464FC4CED6;
	Mon,  3 Mar 2025 16:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741020436;
	bh=4yX2ove+H3YjYb7KFBwrFbNCLgvX35Q86cuMFRmKlmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsRv0MyWb+t3rjCyUZTUyqI56U/wOdbvhCqw7g+9KdrxzR3/QeNOxqJ65ZG4omkdd
	 ruH0sc6mTJoa6DU3Vb4Y6MTZ2RpmRisWPO5hgfOX+r8wpMIL5VAQMJQ/cmlX63MZcy
	 ek8rOlVpJc3p0sfU3yTqqqkAo+DdPepnQmjAMgz7lHMzarDpqMFtvGSmuXMAmk1YPK
	 D3/l/IdInHqvuXDEUQ9BurqRH20feH0B1krtXTp+KxxEPNasrAbjCSqIkFYFNEA58i
	 ajZ0QzoQZlC96mxyDoJvdYJPGkrOeFRQKnWp69A5QaWUp0SQunJz1Mc3Q5vnY210aF
	 nztTqWcHF922g==
Date: Mon, 3 Mar 2025 08:47:13 -0800
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
Message-ID: <202503030843.553DA01@keescook>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-8-jeffxu@google.com>
 <d945816e-b01f-4a7c-b698-23ec356280f3@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d945816e-b01f-4a7c-b698-23ec356280f3@lucifer.local>

On Mon, Mar 03, 2025 at 12:08:49PM +0000, Lorenzo Stoakes wrote:
> 
> On Mon, Mar 03, 2025 at 05:09:21AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add sysmap_is_sealed.c to test system mappings are sealed.
> >
> > Note: CONFIG_MSEAL_SYSTEM_MAPPINGS must be set, as indicated in
> > config file.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> 
> We do need to add this to the general selftests Makefile, but this code is
> fine, so have a:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Congratulations! :) and thanks for addressing the issues that were raised,
> appreciate your efforts on this.
> 
> Maybe you could send a fix patch? As it's such a small fix.
> 
> Cheers, Lorenzo
> 
> 
> > ---
> >  .../mseal_system_mappings/.gitignore          |   2 +
> >  .../selftests/mseal_system_mappings/Makefile  |   6 +
> >  .../selftests/mseal_system_mappings/config    |   1 +
> >  .../mseal_system_mappings/sysmap_is_sealed.c  | 113 ++++++++++++++++++
> 
> Can you add this to tools/testing/selftests/Makefile? I _think_ adding:
> 
> TARGETS += mm

You mean this, I think?

TARGETS += mseal_system_mappings

(But while we're here, why is "mm" where it is in that Makefile?
Everything else is alphabetical?)

-Kees

-- 
Kees Cook

