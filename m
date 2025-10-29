Return-Path: <linux-kselftest+bounces-44274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DFBC193CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 002DF563139
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B783031BC91;
	Wed, 29 Oct 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTwtpv8o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D88A31A059;
	Wed, 29 Oct 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727701; cv=none; b=rphAeBQt0Za38Rini1Fpr3aBeiKMZlLNN6EP+8FGIFclu3PusHWGebncvIDi4KY0zTLp2rscIumPvSxxquDThNQi644Yvir8dp+UypSdrRn4F9GhByo4+EaTHWzPbd6i7k5LsoGwlZT9gh0e1lI7Fe1cPBNJtr60f0ogYOA1rZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727701; c=relaxed/simple;
	bh=8LCr7xd/jmmNjcvpirRO3kvfys/9fQeeVOSR54kjbeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBkTiKfBSsZb0brANpYDSlLAAJ9dNN9ZK9UVYpG+KSUD/iChPIJ6EPu1ct+GpA/tvrjqdrA1q1/IssWUzPbTBnE+PFjgt+WUa3D3YLi5ATjxz2ArEs/xvsC6E3FwiASfgH4cje9jlkRBRh601tdBvrKbYufzW/AduE5IagRTDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTwtpv8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69DCC4CEF7;
	Wed, 29 Oct 2025 08:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761727701;
	bh=8LCr7xd/jmmNjcvpirRO3kvfys/9fQeeVOSR54kjbeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTwtpv8oJD8EZiajnivSmX6Fc7GX8PIFPB+LboAL/lm5CE66mEi9sRdekgYGUs+9D
	 XgTH3OyTZTg51j0rUaloNpReW/Y88yGWDwFlg5WQGP42MWrytUW4vdgDVDJ+CmGPNL
	 NmOcQqrJ0FTTq8daOxy3FpjwVYRR+pbMENuYac5nBMe92KQ6TS2kCcTx1Z4LFP59YM
	 CzCx26duht1FqOdD2OTYFa03z/JjVS6zsGvbeNswRpEstkEHMHo8g56uIPC1GqDd3h
	 h1/QZmyXKBCdqFGw+6Zuwbv+EZWJx4QejFElSIYzWmMUC+6SdoW1bcoXXa2XTrBf+B
	 W45p2x9UApgpQ==
Date: Wed, 29 Oct 2025 10:48:11 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, jasonmiu@google.com,
	dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
Message-ID: <aQHUyyFtiNZhx8jo@kernel.org>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021000852.2924827-2-pasha.tatashin@soleen.com>

Hi Pasha,

On Mon, Oct 20, 2025 at 08:08:50PM -0400, Pasha Tatashin wrote:
> It is invalid for KHO metadata or preserved memory regions to be located
> within the KHO scratch area, as this area is overwritten when the next
> kernel is loaded, and used early in boot by the next kernel. This can
> lead to memory corruption.
> 
> Adds checks to kho_preserve_* and KHO's internal metadata allocators
> (xa_load_or_alloc, new_chunk) to verify that the physical address of the
> memory does not overlap with any defined scratch region. If an overlap
> is detected, the operation will fail and a WARN_ON is triggered. To
> avoid performance overhead in production kernels, these checks are
> enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/Kconfig.kexec             |  9 ++++++
>  kernel/Makefile                  |  1 +
>  kernel/kexec_handover.c          | 53 ++++++++++++++++++++++----------
>  kernel/kexec_handover_debug.c    | 25 +++++++++++++++
>  kernel/kexec_handover_internal.h | 16 ++++++++++
>  5 files changed, 87 insertions(+), 17 deletions(-)
>  create mode 100644 kernel/kexec_handover_debug.c
>  create mode 100644 kernel/kexec_handover_internal.h
> 
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 422270d64820..c94d36b5fcd9 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -109,6 +109,15 @@ config KEXEC_HANDOVER
>  	  to keep data or state alive across the kexec. For this to work,
>  	  both source and target kernels need to have this option enabled.
>  
> +config KEXEC_HANDOVER_DEBUG
> +	bool "Enable Kexec Handover debug checks"
> +	depends on KEXEC_HANDOVER_DEBUGFS

I missed that in the earlier review, should be "depends on KEXEC_HANDOVER"

@Andrew, can you please fold this into what's now commit 0e0faeffd144
("kho: warn and fail on metadata or preserved memory in scratch area")

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index c94d36b5fcd9..54e581072617 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -111,7 +111,7 @@ config KEXEC_HANDOVER
 
 config KEXEC_HANDOVER_DEBUG
 	bool "Enable Kexec Handover debug checks"
-	depends on KEXEC_HANDOVER_DEBUGFS
+	depends on KEXEC_HANDOVER
 	help
 	  This option enables extra sanity checks for the Kexec Handover
 	  subsystem. Since, KHO performance is crucial in live update

> +	help
> +	  This option enables extra sanity checks for the Kexec Handover
> +	  subsystem. Since, KHO performance is crucial in live update
> +	  scenarios and the extra code might be adding overhead it is
> +	  only optionally enabled.
> +
>  config CRASH_DUMP
>  	bool "kernel crash dumps"
>  	default ARCH_DEFAULT_CRASH_DUMP

-- 
Sincerely yours,
Mike.

