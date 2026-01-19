Return-Path: <linux-kselftest+bounces-49420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896AD3B8A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49EC73014D8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34642F6183;
	Mon, 19 Jan 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="XZYs+x7H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A2urIXyg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901412C1590;
	Mon, 19 Jan 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855184; cv=none; b=ry2HnNKFnJXWkSq4+6a/oK/3uO+wlmN3qT8o7aTQWY2Lbbh16cfZZMw7KTd6+BQyOUcg/NRagsUZQ7u+iy8Sxe6jHa2RyoairpsBM5L0FyD0y/9zcGp2Qc9GJ6auKgRedqquCjFK77d+kEexpA2z94MRR0SLQb2+DDgNrQMzwRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855184; c=relaxed/simple;
	bh=Qr8BdPwUNVZNSxS2jg88Mov9losY+Fu/xaMN+Jqedbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fp9MlDSMSYMH25RND/F9nZEbJlpn/vjGu/SmgWIBtskGt+g6nhn557B7NuJWEyLnAdvyIn38vIP+QnPrRy4Ikd1WrRu/EXAIa5E367xIFwGeCfgTTc7nDSheVhJqoJa/pmfdhv4OV29QX5eY8hP7sAK0fPSk6HFT2siklPGShU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=XZYs+x7H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A2urIXyg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0238814003DB;
	Mon, 19 Jan 2026 15:39:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 19 Jan 2026 15:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768855181;
	 x=1768941581; bh=sw2805XAbGdz/kXUxd69OcqeDNBbMu4f4NgNzyYO0C4=; b=
	XZYs+x7HELFQ4RwHgCjrokYkBTkD20vMSZS/FwkxIZSfXiUZjD/x1V2DTRs1kgLd
	ZNhDE6msc+pkg/fk3VMV/+oInwcCJSd95xdwS1PH4t+K66kzyyTtEZ17PagkDku9
	mnFC7wGUPr4XlM1NEvhgdg37y9zfknYHDqm79LZry2jP7Zk9GqLVOAbfPimn0WdI
	SZebFH7W2t6ewsKKlgh8mAGd8EdIV+edHPyAbw0kUz/0W1XEOAQm3LRVIJOdX1Dq
	/hIKMBYCUBVxefKnb+4Or7v/of64aTI5NGkHeujP7rVzZn5vhFnYd13P0txnwtdj
	eXyNYwKHddtocFQ2twfz7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768855181; x=
	1768941581; bh=sw2805XAbGdz/kXUxd69OcqeDNBbMu4f4NgNzyYO0C4=; b=A
	2urIXygo1v5HWnP5B4Y6AzftjQixSMLoHvKtHXMoNXVIKfGQ31jg9CQ2bRj2Cxkd
	Ac3Zb2W7YN4mod3CD5FA8BHSmfBs5ohxwsGqJfSdbCJ3+C0cAvYwjM5Ptg3AiFcI
	wMruakB5WAl4GahHi3+rUj3YCp4cBSvz7uBU+MjthI+VKWd5oW5cJj5RUspeGuoZ
	fPvB5D5HcOeRMa6L55OCOI1J75ushYjoSgPqOg3k0IvWY44X5eyQ7Ihj4D5rvGmF
	4K4xBvrax8M6+s6I4nqfcqPu5c+YetUwqEGBoJ8GJwNocKA9n+jMGuHeXRU/sf+W
	BNowOMCiGeAuVALlTVSyQ==
X-ME-Sender: <xms:jZZuacKWZrpCuwSUgBJ2wwVE_wESTIGZdIgyDz6h3LSiQMj-qQLLkw>
    <xme:jZZuaXGbKE_8B_aEjIrL2fdScWnFeqyPi5IiGwbA5DGHsD1nwFBR0o75UbPbe5UH4
    rhBZNqVrCf_9XArHfAaT2ydg4-Vrgxl8ejyBfqXKAF_EtmfVn5G_w>
X-ME-Received: <xmr:jZZuabsrJoh4xfVttLQ7knB2agoVjo7eLx-oCcYFsXqgqAReDc5xze-HfrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeekheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheejieetffefueeiteejtdejffdvleelvdeuvdffvdefteeghfevkeeu
    vdefvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegumh
    grthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdr
    tggrpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jZZuaeukvLxLV-CF8IXuUpJw015stwJyosHIbw_M3WvODpt0G0GeUA>
    <xmx:jZZuaRA2ZZZk1c4EtqEnmkAIuMJYWm8LLVwL3HnzN3JSYSjbjv0umQ>
    <xmx:jZZuaQPTGT0u9flfyCVCaSLbV-KGXcbeyjAO37VYKovULP_MaOrqjQ>
    <xmx:jZZuaaxeDKAmC70y6-e6ic3b4c4djfyxAqHhphD6UrqwWaecYgkORg>
    <xmx:jZZuaU7t4nv9ijB1OGy-0sX_hXENjLJsHstaaZsTCKg2pmLwYq-74KL->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 15:39:41 -0500 (EST)
Date: Mon, 19 Jan 2026 13:37:48 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH] vfio: selftests: Drop IOMMU mapping size assertions for
 VFIO_TYPE1_IOMMU
Message-ID: <20260119133748.2eaf7996@shazbot.org>
In-Reply-To: <20260114211252.2581145-1-dmatlack@google.com>
References: <20260114211252.2581145-1-dmatlack@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 21:12:52 +0000
David Matlack <dmatlack@google.com> wrote:

> Drop the assertions about IOMMU mappings sizes for VFIO_TYPE1_IOMMU
> modes (both the VFIO mode and the iommufd compatibility mode). These
> assertions fail when CONFIG_IOMMUFD_VFIO_CONTAINER is enabled, since
> iommufd compatibility mode provides different huge page behavior than
> VFIO for VFIO_TYPE1_IOMMU. VFIO_TYPE1_IOMMU is an old enough interface
> that it's not worth changing the behavior of VFIO and iommufd to match
> nor care about the IOMMU mapping sizes.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Link: https://lore.kernel.org/kvm/20260109143830.176dc279@shazbot.org/
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied to vfio next branch for v6.20/7.0.  Thanks,

Alex

> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> index 5397822c3dd4..ecadd0e6b61b 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> @@ -162,12 +162,8 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
>  	if (rc == -EOPNOTSUPP)
>  		goto unmap;
>  
> -	/*
> -	 * IOMMUFD compatibility-mode does not support huge mappings when
> -	 * using VFIO_TYPE1_IOMMU.
> -	 */
> -	if (!strcmp(variant->iommu_mode, "iommufd_compat_type1"))
> -		mapping_size = SZ_4K;
> +	if (self->iommu->mode->iommu_type == VFIO_TYPE1_IOMMU)
> +		goto unmap;
>  
>  	ASSERT_EQ(0, rc);
>  	printf("Found IOMMU mappings for IOVA 0x%lx:\n", region.iova);
> 
> base-commit: d721f52e31553a848e0e9947ca15a49c5674aef3


