Return-Path: <linux-kselftest+bounces-28079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F29EA4C8A7
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B89A166FEB
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 17:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA882241105;
	Mon,  3 Mar 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNft3v+5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE21023C8C6;
	Mon,  3 Mar 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019949; cv=none; b=sgxWYK4/NHvtkYSE2ZRBpmPTLxMwndcuLI5FEDwm8mh+CmvUSjYk3G9deHD8Bhdt8Z6JqaRtQW+GkySonrmsbGpno1cCFz4izNFjgp/J1KzwMkhMpeOjySfGBImIBWKIicg4zPbOAt9sqtWZ0Yn9pK/wPRR47V+wd5+dZT26+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019949; c=relaxed/simple;
	bh=QPfkATgquTERDhGCt9aWlkqA2HdE4q8VEe95HfOR4xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtqLHAqW+3c7FIfz1WiKYCJ3hJtxafvr76Z6ESn3M7iqdWWVM3I8nTUMAjqEt9gDOVDYH5sBoU9i/EwXPRUQdVklVsBuwwnRKDa/kVLtM4E/ntMBS1u913Eb7yJAqbx5ByUWqOzVa2hA7Cpl7GWVnVmBzhuO2m8yvSswkz7QzMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNft3v+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8F3C4CED6;
	Mon,  3 Mar 2025 16:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019949;
	bh=QPfkATgquTERDhGCt9aWlkqA2HdE4q8VEe95HfOR4xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNft3v+5T8OLvXt9aobTpNHkAd0/UGrLN6BbaaMewdS8vIEkBB7fSBumk7JUKm5Km
	 FnU6xGrcbsGc+lzu9rgFicDCiHybyzPlnXGYkyRkRdjp43Qp4tCVlScUCkXCsrgCJd
	 bPYZAAEHZwEjZySKywTCfThAORcaKSxjrGwIZBD3tMqDSMJD/JP361rO12mRQcVOwL
	 TmxWcpWf6xEgm427rOBAimCZUXHGo/RgxLrkv0o8Y+hJ2w0WDGBv37Ce9UBHY5GzKL
	 jce/zt+eihibN23ldAVht7Kt61DZMDEvjBKOP4ITrFIFMrEINZm4paB5+1aWXUyoET
	 6xeNusgboc3sA==
Date: Mon, 3 Mar 2025 08:39:06 -0800
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
Subject: Re: [PATCH v8 4/7] mseal sysmap: enable arm64
Message-ID: <202503030838.8D991B5ED5@keescook>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-5-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-5-jeffxu@google.com>

On Mon, Mar 03, 2025 at 05:09:18AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, covering
> the vdso, vvar, and compat-mode vectors and sigpage mappings.
> 
> Production release testing passes on Android and Chrome OS.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>

Like x86, clean and simple.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

