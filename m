Return-Path: <linux-kselftest+bounces-28078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F25A4C89B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA2B174767
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B4E23ED6A;
	Mon,  3 Mar 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzeAP3xR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D03214A60;
	Mon,  3 Mar 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019923; cv=none; b=VLHnXUtaHUERUpaeUezyR5G2WngstUsBX+Gs+wOadFNXNsnSTXW8DyXIi3PBJw3HSA0Y7sNi74e0Sdyd5+s4/F+kSv54osnlSaCqPH8m9yP4N2K2TcI5/2F2Sd2+5mQ5xLipE7O3z5tLkztl2NJB6FOcG3boQwX3oc3myXvpnZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019923; c=relaxed/simple;
	bh=ItXRa2uqt/C9qeLij/vvz0rp/Rg3JjhhUzFdeg6ND0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzSYBsAHA8eIgf4kXEcTueQuttGqpF8KKv7Ge3CpwjJ8QEngXT6ii+ysq6ZDxCq9z74//rTTlZ0IPuRANVQfZuD2qnmpMEaSLBD9vbIhwK8KQiA3jFOhy/+aCc9oDTehlnHdNLDklytF3x5SCCeRUYcocOigsj7Snwix570x/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzeAP3xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2949C4CED6;
	Mon,  3 Mar 2025 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019921;
	bh=ItXRa2uqt/C9qeLij/vvz0rp/Rg3JjhhUzFdeg6ND0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PzeAP3xR5Revl4EJY+aRrDdCoPXrPAervQ6D4Z992Jx1etThQtrw3iRtovmZASb9S
	 nMlxjGGLFwvcHNdQjcasjLy1YRLE4siQS92eU9V/jcOyEUkrh2zHahw6vGoac8l4LH
	 ny90SeLv/uSnkb7/Z6Ws9RddYuchgjQG69Q/HzViwBRruvQzADjhENSq+IoFv3QXIx
	 l+GnvhWl5P+BH7tOTh3wx8vHDjJYqZxe1N0mRR/S3wbEfJXZS4L+7btN2D7xMapHnr
	 eNjMyRhUsTuT9egrf0eDeqH7IrJEnlGs3PAR3uXUUHy9i08eguYdb8/nqRXmwMWZ12
	 FlBUKVynk/F7w==
Date: Mon, 3 Mar 2025 08:38:37 -0800
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
Subject: Re: [PATCH v8 3/7] mseal sysmap: enable x86-64
Message-ID: <202503030838.E05CCEC78@keescook>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-4-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-4-jeffxu@google.com>

On Mon, Mar 03, 2025 at 05:09:17AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> covering the vdso, vvar, vvar_vclock.
> 
> Production release testing passes on Android and Chrome OS.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Short and to the point. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

