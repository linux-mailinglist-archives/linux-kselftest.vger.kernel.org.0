Return-Path: <linux-kselftest+bounces-49421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F19D3B8A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 174D930242A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09DF2F619A;
	Mon, 19 Jan 2026 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="VGf1EbRR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qpn9XrPj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D832F690D;
	Mon, 19 Jan 2026 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855195; cv=none; b=mWIX3PbN5+V/H6L5bPnCidEXAmT8INfY4e3omAiwZOfOI2SN5/1T5ROoSq/KAPoe+QGFuUBIwzU9nWuaXlB3tJm8HiHWfioqvxyPlJr4cYjT7mM22+3+RI/2H8y7qc8VFuQV7jCgXd/IPmnetniWpiO5oC5iGqhS1sGo8jrdzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855195; c=relaxed/simple;
	bh=/J/i1acOycNz8T4DELOF9HyT9o8g2mtdDpes6BLAQUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRmXAJVlu2Eosqxz86MBewEUdkLiUmrHgE9dhOZuyJT/67dgex2ljAaUfiLLAkU2nElXfgrGnDmZhltXuQyGv9fjTxs+E3463SEYwB/9b3d4FFN+VW2aUyFRaQxejs/K/c4mtDExG0n26hu6B/yDZbQjgIRcsVrL+EKsYYkBdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=VGf1EbRR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qpn9XrPj; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E52DCEC00D4;
	Mon, 19 Jan 2026 15:39:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 19 Jan 2026 15:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768855184;
	 x=1768941584; bh=y8LiynsXSNIKWy1cthcnlLPIPiY4yXcDV0dK86wY0u4=; b=
	VGf1EbRREbG88iFrXPTVbPLQnoOXfoLQ22WkFOBR3FtdrlugjqT0tuZQfP8uzV+s
	xiIxcvSJB3Gy/z04XOv+nk0ciu1fd8mEsap1xAm+Yy0gIaNZcBI8s4SsNfLP/21g
	xR8pq3/haS2zF5w+ycklbvqenLI4vFhJ/1pTsi33qV47mQpsCVqTBbMuBQ/xVcHZ
	/mCj8T2PXuhhSfQ29y4xqXEMyWb0NJkvB8qbCMzgospFFrlf4NM3aCCl5Eic1iHR
	qQjHqhiIGEbs5op06aCxaFfBgRkBQ/TSYbq919d7SK1G9pD9yRdXF2G7Yo0kcbaA
	yuK7HeAPbrfoClXpdmMx3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768855184; x=
	1768941584; bh=y8LiynsXSNIKWy1cthcnlLPIPiY4yXcDV0dK86wY0u4=; b=q
	pn9XrPj6kXqnPyb8fcXT3ZOHkuPrbVqVpDMDpIYfxwoj+jP4vjr7RIs0674BcJiv
	gG5OqQ0YAssDy/WJVbJ9wukvt6ioWcALcpLYGbnfrZsjRxeGxqRfikiY5YMhhbuZ
	1/l6zAYJoestO2JHpwRvCKLNqmqIFUpOVnG65QezX4v1VzEVUa7VJFSd2mTy2PLe
	tKrBZlkMG15ql3+PGn9hbp3ZI3wKtimHCfJx0LqdcSjkG1vYB4H0eTjCwSEz+av6
	mcY/MmV9Wb894fKH2y8H6R2BPIKzvV5xx7/ELoabA7jXhJzbOd0v/Y9Qjt/l1FY2
	cF2TaN+oivcwsO+n29x7w==
X-ME-Sender: <xms:kJZuaT6KTM16_Rm_LiTc_CLD1G_ZSK73IJupfVaOb5iowYiiOu01Eg>
    <xme:kJZuaU6OqkPJksPyVZ8Xoup2BBrnVzK5272facMfaUVUcVAlfCxBJSmkHFZN5Ib_b
    tmgENAsp23yTLEqrquM9K9x3i-wHyk3K9OoY1qdZg7JxpiBYlHs-iU>
X-ME-Received: <xmr:kJZuacr7I2LFzFSDbmSfb4VzussFpjiUAm85p0siunx-_Sle0XTg7e-BIHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeekheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmh
    grshhtrhhosehfsgdrtghomhdprhgtphhtthhopegumhgrthhlrggtkhesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvhhmsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjghhgseiiihgvphgvrdgtrg
X-ME-Proxy: <xmx:kJZuaVORdZpWtdlycs58FrRCpRV41zcpyxcfTTwtCJnuijEGdsFr-A>
    <xmx:kJZuaU1HQd7Sv3CEiag2mpaaF1_85xoTvJkkb44AyMEu7sE8srMkaA>
    <xmx:kJZuaUA_Y9a4LFVM0WK5iqQnRa5Hv9QKXV16GTL8LTHRy7FIA0VYLA>
    <xmx:kJZuaRKelcPF73_VBTuMiLvH-AsYkFd20wrw54IZlcktrjHoOfNurg>
    <xmx:kJZuaTOdJzjUY5k4Q9-DcmkZv7ZiWXcwFZ9zezIXjUF8lM1_E-7PMc-x>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 15:39:44 -0500 (EST)
Date: Mon, 19 Jan 2026 13:38:28 -0700
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>
Subject: Re: [PATCH v3 0/3] vfio: selftests: Add MMIO DMA mapping test
Message-ID: <20260119133828.62b1150a@shazbot.org>
In-Reply-To: <20260114-map-mmio-test-v3-0-44e036d95e64@fb.com>
References: <20260114-map-mmio-test-v3-0-44e036d95e64@fb.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 10:57:15 -0800
Alex Mastro <amastro@fb.com> wrote:

> Test IOMMU mapping the BAR mmaps created during vfio_pci_device_setup().
> 
> All IOMMU modes are tested: vfio_type1 variants are expected to succeed,
> while non-type1 modes are expected to fail. iommufd compat mode can be
> updated to expect success once kernel support lands. Native iommufd will
> not support mapping vaddrs backed by MMIO (it will support dma-buf based
> MMIO mapping instead).
> 
> Changes in v3:
> - Rename mmap_aligned() to mmap_reserve()
> - Reorder variable declarations for reverse-fir-tree style
> - Update patch 2 commit message to mention MADV_HUGEPAGE and MAP_FILE
> - Move BAR size check into map_partial_bar test only
> - Link to v2: https://lore.kernel.org/r/20260113-map-mmio-test-v2-0-e6d34f09c0bb@fb.com
> 
> Changes in v2:
> - Split into patch series
> - Factor out mmap_reserve() for vaddr alignment
> - Align BAR mmaps to improve hugepage IOMMU mapping efficiency
> - Centralize MODE_* string definitions
> - Add is_power_of_2() assertion for BAR size
> - Simplify align calculation to min(size, 1G)
> - Add map_bar_misaligned test case
> - Link to v1: https://lore.kernel.org/all/20260107-scratch-amastro-vfio-dma-mapping-mmio-test-v1-1-0cec5e9ec89b@fb.com
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>
> 
> ---
> Alex Mastro (3):
>       vfio: selftests: Centralize IOMMU mode name definitions
>       vfio: selftests: Align BAR mmaps for efficient IOMMU mapping
>       vfio: selftests: Add vfio_dma_mapping_mmio_test
> 
>  tools/testing/selftests/vfio/Makefile              |   1 +
>  tools/testing/selftests/vfio/lib/include/libvfio.h |   9 ++
>  .../selftests/vfio/lib/include/libvfio/iommu.h     |   6 +
>  tools/testing/selftests/vfio/lib/iommu.c           |  12 +-
>  tools/testing/selftests/vfio/lib/libvfio.c         |  25 ++++
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c |  24 +++-
>  .../selftests/vfio/vfio_dma_mapping_mmio_test.c    | 143 +++++++++++++++++++++
>  .../testing/selftests/vfio/vfio_dma_mapping_test.c |   2 +-
>  8 files changed, 214 insertions(+), 8 deletions(-)
> ---
> base-commit: d721f52e31553a848e0e9947ca15a49c5674aef3
> change-id: 20260112-map-mmio-test-b4e4c2d917a9
> 
> Best regards,

Applied to vfio next branch for v6.20/7.0.  Thanks,

Alex

