Return-Path: <linux-kselftest+bounces-45261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2BEC496A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FAD188D872
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 21:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84142338918;
	Mon, 10 Nov 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="dYFR2eoS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NhWQPMA9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D0331A63;
	Mon, 10 Nov 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810330; cv=none; b=Ps+bMzaNvoK9ibncCzDPbc8x6QznKQqlB22DGZD4CONBSPcsSHz1iSCbqB29u8HFd1sjvyEZt+qaWfu2XeiF/i9xwmcpP5OHv3l1+vkCTl/YOu+cZzLOjYtTfIKnX9UcWIFz441oS90NopmC2AFCOAOYpbk+oDV3yLV8OIgQcIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810330; c=relaxed/simple;
	bh=vxBi0nvyAkJDE1yP7hrlOq7bh6+WO3W1QC4fXD1XMKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7Icj/qx4Hkq1Rcv6DrXCOJJb6zdGcNQo4HLt0heRP6nmcFSzSDgYcwSn3GQxq6W6uvTnPopC3f+rou25NTwjO/YJjBUMSJTYGQQG4BqU6n/4YmLNi59zNL8SkGKsKjbglOX6tsFsR7Ekd3m+LTkaNjoi3N+vVDYchUXeVAjgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=dYFR2eoS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NhWQPMA9; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D01997A00F7;
	Mon, 10 Nov 2025 16:32:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 10 Nov 2025 16:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762810327;
	 x=1762896727; bh=25GjsnAAs1TRFEpPcIW2mW9ndg7EOK3Ky9AP3YJIP1I=; b=
	dYFR2eoSfXCx6EDRLdne30kGxwLJa1Yh74eNMz7TAuFic97LrpaB9XEePd4eqkMV
	jPtgml/Wf1rpnRDhgOewa4XS5/wmGmxwULcBCvDMrmFbVh0h/CdhP88Ujk9SDwwN
	CbAIB0g38v27ZXnbj153G7BQC7c6guWkPeI1kluNGSJVVJa5yOxWtKJwDXmJgYw5
	zx1Qd3mD6YVE5VVs3zeAng1W8Nz7TKolV0DQ56Tmep5cU8+JtZEefvbzM1WVlAHt
	HqD8VeDs1r4Pl4V2KNTBzQD4tGHdK0feVpNzYfk4bvdJoAS0kbPeXdUbeVWTOL08
	aE3AQwr9wle7JAHqqwG4Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762810327; x=
	1762896727; bh=25GjsnAAs1TRFEpPcIW2mW9ndg7EOK3Ky9AP3YJIP1I=; b=N
	hWQPMA9aeO6sT61Qbipsc6rjmDigJG91gU5efJtZANdLCoDuMTglMDOv5EzdqFRB
	TFfV+MLeo+EEQbKJnCMoyxqh09H0vyywAR6hfImen7INKt28yR1buM8S5PqvOUVO
	tl/sQ8/9P9R5CUpSnipY3Ei7yqofHZudlUL3G2QNFxv2xDeOmV0NGRpAbI4gaTt+
	dCZpaRnBpXyPN8iHgI+8/G6aHon95Lfyqzk1rIb7+Sl6VZBKstiZPoRZL7LXYB0E
	3VUmw920R91d0Klf2le4k1Siu/TM6armMYtXgPC1IN3Q17zjuJmY43DGeNYAFgPr
	ei5lBZ39TuEVK9dmvVZsA==
X-ME-Sender: <xms:11kSaYCQ0CHxzPVVICT_yDxhZaWaTQkJA5eYC9Abi4qYltgiOnnpHg>
    <xme:11kSaUnm7U8y1rTFEM68WybWxz9tgk6sAgECPKpfPO2RE1wv-ba0oB3IEY2JnstCY
    QUfGBrsIDv6tIET10Z-02AOeXJvsig8szOyN3BZkkwEnyNDl1Ki>
X-ME-Received: <xmr:11kSabf-VtLJcmymwgoSEsC11aQB65taj2gRTWV5lroRtHtRy3jXIhQH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepteetudelgeekieegudegleeuvdffgeehleeivddtfeektdekkeehffehudet
    hffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrmhgrshhtrhhosehfsgdrtghomhdprhgtphhtthhope
    gumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhgghesiihivghpvgdrtggr
X-ME-Proxy: <xmx:11kSaQTZ_8i49bqB55AXmpOxa2kYvVhG6MWmZ6_IKQwQqdOpOGVxyQ>
    <xmx:11kSaau8JY0SNh10eelV8QjjVdboU1PvPclmDb2-P4ncMVXBDKxQTg>
    <xmx:11kSaZcUIK0rQl3WtiblyWWlFL4p2V4qu05D7cQ-1UptziriOUHGcA>
    <xmx:11kSacb8mp61akmALVMDexgil9I2b07bvGrLVwaJ9Rrsv-T3rnRR8w>
    <xmx:11kSaa24-zMlZu7nxDHKfwomQ_s04hQ4795YXA-5jCWiBFB-DIpZd7Eg>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 16:32:06 -0500 (EST)
Date: Mon, 10 Nov 2025 14:31:56 -0700
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 4/4] vfio: selftests: update vfio_dma_mapping_test to
 allocate iovas
Message-ID: <20251110143156.08d1859b.alex@shazbot.org>
In-Reply-To: <20251110-iova-ranges-v1-4-4d441cf5bf6d@fb.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
	<20251110-iova-ranges-v1-4-4d441cf5bf6d@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 13:10:44 -0800
Alex Mastro <amastro@fb.com> wrote:

> vfio_dma_mapping_test currently uses iova=vaddr as part of DMA mapping
> validation. The assumption that these IOVAs are legal has held up on all
> the hardware we've tested so far, but but is not guaranteed. Make the
> test more robust by using iova_allocator to vend IOVAs, which queries
> legally accessible IOVAs from the underlying IOMMUFD or VFIO container.
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
>  tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> index 37c2a342df8d..c1a015385b0f 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> @@ -95,6 +95,7 @@ static int iommu_mapping_get(const char *bdf, u64 iova,
>  
>  FIXTURE(vfio_dma_mapping_test) {
>  	struct vfio_pci_device *device;
> +	struct iova_allocator iova_allocator;
>  };
>  
>  FIXTURE_VARIANT(vfio_dma_mapping_test) {
> @@ -118,11 +119,16 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB |
>  
>  FIXTURE_SETUP(vfio_dma_mapping_test)
>  {
> +	int ret;
> +
>  	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
> +	ret = iova_allocator_init(self->device, &self->iova_allocator);
> +	VFIO_ASSERT_EQ(ret, 0);
>  }
>  
>  FIXTURE_TEARDOWN(vfio_dma_mapping_test)
>  {
> +	iova_allocator_deinit(&self->iova_allocator);
>  	vfio_pci_device_cleanup(self->device);
>  }
>  
> @@ -144,7 +150,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
>  	else
>  		ASSERT_NE(region.vaddr, MAP_FAILED);
>  
> -	region.iova = (u64)region.vaddr;
> +	region.iova = iova_allocator_alloc(&self->iova_allocator, size);
>  	region.size = size;
>  
>  	vfio_pci_dma_map(self->device, &region);
> 

There's another in the driver test.  Thanks,

Alex

