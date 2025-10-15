Return-Path: <linux-kselftest+bounces-43168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C2DBDD506
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 10:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A9424E1493
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B692D060C;
	Wed, 15 Oct 2025 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKJXzUHh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2312C0296;
	Wed, 15 Oct 2025 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515780; cv=none; b=fiMNzk/medM1ea2hHWiZqUTpLThgWtgc/LpOnZPTWl3fo67rRm9ZeBTG/UTMqjE5AQMKA7JG+AdQ5gmMXAk/lK0sbGoSpe9gIWoiy55X5we6I5BJb3hDfE6RCiFGYWAqcxdMc0KbrWciAcYh2qen4pLu5dwRPVtM5K2dB7IGJ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515780; c=relaxed/simple;
	bh=TvFSqbcGd3/w9zlIUZI587yIGf6KC0toARU6q7rKKqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTMzLn3RR7uMenWqsyS6N4UlyqlVET5cutBKf+KZCXNLM2wclrNE3Md2OeAwe3FatCR8PeX+yIME5ZlDQfSpK6izahIOsjLnTf4/2K8dGfHqxMg+kmWr7xAKRZX2r26XhS6SIRxwT30KED1QBLlORFChMkIw89zqj6rmeBvWRnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKJXzUHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD03C4CEF8;
	Wed, 15 Oct 2025 08:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760515779;
	bh=TvFSqbcGd3/w9zlIUZI587yIGf6KC0toARU6q7rKKqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKJXzUHhRhbwK9P/unoPTYFgotjilicrECi5KClgaJ9t3x963PsSXqd6egSOR5aPa
	 DbU1AmDfFaF3GpEXN/aZ0PMwYPGPLiKbn74QEqQvq/LWMt3lRieCaLZh6FCvPYgHVx
	 l7McR6/Kbqsy7hoLdN16s8HUOJ5f45kkWvJX2S8pUQf8Ko/JFsNa/At5SNlxDP0Zy4
	 UnCRnzeOU2DGn9lZcfeAcVaOJnR/NR4c0IDIkrTtWGb6FUMfaRLqAAFGSFIJ56Wr7/
	 Nprv5bM1AB+tUHDmOn1zfxIAZKhcSsJ3/k6h7hdeCYx2F8w4aby/P+RS2j0EStPsna
	 gAw1m4geR47vg==
Date: Wed, 15 Oct 2025 11:09:32 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCH v5 6/7] liveupdate: kho: move to kernel/liveupdate
Message-ID: <aO9WvF_WMkKKqYo5@kernel.org>
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
 <20251007033100.836886-7-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007033100.836886-7-pasha.tatashin@soleen.com>

On Tue, Oct 07, 2025 at 03:30:59AM +0000, Pasha Tatashin wrote:
> Move KHO to kernel/liveupdate/ in preparation of placing all Live Update
> core kernel related files to the same place.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

One comment below.

> ---
>  Documentation/core-api/kho/concepts.rst       |  2 +-
>  MAINTAINERS                                   |  2 +-
>  init/Kconfig                                  |  2 ++
>  kernel/Kconfig.kexec                          | 25 ----------------
>  kernel/Makefile                               |  3 +-
>  kernel/liveupdate/Kconfig                     | 30 +++++++++++++++++++
>  kernel/liveupdate/Makefile                    |  4 +++
>  kernel/{ => liveupdate}/kexec_handover.c      |  6 ++--
>  .../{ => liveupdate}/kexec_handover_debug.c   |  0
>  .../kexec_handover_internal.h                 |  0
>  10 files changed, 42 insertions(+), 32 deletions(-)
>  create mode 100644 kernel/liveupdate/Kconfig
>  create mode 100644 kernel/liveupdate/Makefile
>  rename kernel/{ => liveupdate}/kexec_handover.c (99%)
>  rename kernel/{ => liveupdate}/kexec_handover_debug.c (100%)
>  rename kernel/{ => liveupdate}/kexec_handover_internal.h (100%)
> 
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> new file mode 100644
> index 000000000000..522b9f74d605
> --- /dev/null
> +++ b/kernel/liveupdate/Kconfig
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menu "Live Update"

KHO can be used without Live Update, let's make this "Kexec HandOver and
Live Update"

> +

-- 
Sincerely yours,
Mike.

