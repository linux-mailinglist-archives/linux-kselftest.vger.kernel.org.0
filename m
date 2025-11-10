Return-Path: <linux-kselftest+bounces-45260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6394C49691
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24FF34EA403
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31E334C0E;
	Mon, 10 Nov 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="e1KY6Dl4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aWAmI+oD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129432D0D0;
	Mon, 10 Nov 2025 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810329; cv=none; b=j4Kh6OyVskDcM7PbdChE5BtehVaLH39LIuuF8HOCQGllBEvPUCFm5/MDownXiPXAg4RQvortGmTLZjkHK4v1g/k3ISqEotzDEvTAsBxTZZmNFqjW0Hs6MeUBBrJcG0+RFJ6kbQolxTKHAsmDGhEOVxxD2MNK9XS0YtLyQlJQMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810329; c=relaxed/simple;
	bh=MCilM5LehRXK/jRHJuvH+tCbuQlTkTvEIGzXHS2eMRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=io6d4EXb6iBOS4ZVbBwxkljG0fxOdAuvN06IkzBI68+c8G54KtmPNnXSaopmpVAC/0a0uY0k/WbZj4LVxk4laONsglJL6r5vJXzKt4vdIBkTd3eEMN1RAKIgRv2kbozsy1v9VFNGyeAOpmpfMXE1y0/EEUDLZ9DgL3NEM4XfH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=e1KY6Dl4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aWAmI+oD; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DE461D000C3;
	Mon, 10 Nov 2025 16:32:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 10 Nov 2025 16:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762810326;
	 x=1762896726; bh=Nvr3v2IdFq6z26yieZyCxtOgb/hX4txgIDXKOBDMeHA=; b=
	e1KY6Dl4Gu5ebc3VF8QwOTj3gj7k3VNFGcR8ooKao4U9k2ovm/Er5YwNGYqknJB6
	mZnTmh7mrUPd8KtdhKlSIz82ILWtxqGXQyplKJife10QbTg/c085BUmjGJ3W97IN
	6n1OgT2VD5z5d4ddf2eyiq/hUBUe+SMLETNBdnQ2arx3/1VEPmewW6cLdhcB6gc4
	k9KlESletWRqCSec/IR/7z4hEsFqvbg4mkvx4aCnfigzptqpqQ0lSPH/YzMi1JPl
	tzQ98Hb7ZCyiyhduE9Nq6evMA+Z7BGDTEgogp3BToTf44eOs3vd0aPFo1UX3buCn
	LW6L9W6V5nX8S3Z0dMxjKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762810326; x=
	1762896726; bh=Nvr3v2IdFq6z26yieZyCxtOgb/hX4txgIDXKOBDMeHA=; b=a
	WAmI+oDEXz4xKBm1zZlfpgfxL7cO4b4XvqsLURcnuZXMohIlxEsYH0yflmCzkKRV
	s1myjI/P/imV60ZvVcK/HinKQAbsSNUk5vKWMNFQcAifzBL0TuhYcMiN32zsIOue
	ff+N+Wnh7/I5pLFF0XQK6JDnuDTndaZ/BIu52nqpqGn1Mqg7CZSnXOHaQYPI8979
	CBD397iHUrmVBx4j0PdPYUAZXnlagR1LVm8kyP4Bxph+/opvF+/abAewwqou0LAY
	JTOFm+iS3SOGrMFsg3rlpvIdyof8UbbghXx8kORhqdIZZfIHgSVPtAvHF28KfcJq
	7cIi+tDEZ+XJCId2Ze/og==
X-ME-Sender: <xms:1VkSabEMpOMPrPl3TeCcgX6NZgZcra3OVLIaAflaBSC4uNyBvQcI5Q>
    <xme:1VkSaSbNudPCRShr2uXKk4uxYzTC_5ktHsDVwRMji5i5ZRYPCsUmY2EIJ6kCPyfX0
    q4N20DMP6PTSabbvJ8Kovk7Gtlz-xnH7wzIv34f4c6WvgzYukxT>
X-ME-Received: <xmr:1VkSadDYTpu5gBkx_90KEG9tI0XawMNx-l1keJ6p5WiyIxWXDt7kBZCe>
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
X-ME-Proxy: <xmx:1VkSaakrhsWDMCThDf--lthidA43QzICHV7UM-fkAX-OV19GpZBNcw>
    <xmx:1VkSaewqswa6Y8E0pP04V39tpCo-_mV18D_xDk_0JmW96v0xM_V3Hw>
    <xmx:1VkSaURsUoFkbN42U9-VcwxUAOGc7wZSWGfkaDvFddYbxAGWBryOIw>
    <xmx:1VkSaW-_SwzwBU481bB4loET9FGSuJcPfrjTtijS4XnraR7yS3L5zA>
    <xmx:1lkSaUrIWktTDViwyKx17KXhjWuWDjWQgrj5H6WppFthpmSlvPcZRrOj>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 16:32:05 -0500 (EST)
Date: Mon, 10 Nov 2025 14:31:53 -0700
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/4] vfio: selftests: add iova range query helpers
Message-ID: <20251110143153.4c456ad4.alex@shazbot.org>
In-Reply-To: <20251110-iova-ranges-v1-1-4d441cf5bf6d@fb.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
	<20251110-iova-ranges-v1-1-4d441cf5bf6d@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 13:10:41 -0800
Alex Mastro <amastro@fb.com> wrote:

> VFIO selftests need to map IOVAs from legally accessible ranges, which
> could vary between hardware. Tests in vfio_dma_mapping_test.c are making
> excessively strong assumptions about which IOVAs can be mapped.
> 
> Add vfio_iommu_iova_ranges(), which queries IOVA ranges from the
> IOMMUFD or VFIO container associated with the device. The queried ranges
> are normalized to IOMMUFD's iommu_iova_range representation so that
> handling of IOVA ranges up the stack can be implementation-agnostic.
> iommu_iova_range and vfio_iova_range are equivalent, so bias to using the
> new interface's struct.
> 
> Query IOMMUFD's ranges with IOMMU_IOAS_IOVA_RANGES.
> Query VFIO container's ranges with VFIO_IOMMU_GET_INFO and
> VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE.
> 
> The underlying vfio_iommu_type1_info buffer-related functionality has
> been kept generic so the same helpers can be used to query other
> capability chain information, if needed.
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
>  .../testing/selftests/vfio/lib/include/vfio_util.h |   8 +-
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 161 +++++++++++++++++++++
>  2 files changed, 168 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> index 240409bf5f8a..fb5efec52316 100644
> --- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
> +++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> @@ -4,9 +4,12 @@
>  
>  #include <fcntl.h>
>  #include <string.h>
> -#include <linux/vfio.h>
> +
> +#include <uapi/linux/types.h>
> +#include <linux/iommufd.h>
>  #include <linux/list.h>
>  #include <linux/pci_regs.h>
> +#include <linux/vfio.h>
>  
>  #include "../../../kselftest.h"
>  
> @@ -206,6 +209,9 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_
>  void vfio_pci_device_cleanup(struct vfio_pci_device *device);
>  void vfio_pci_device_reset(struct vfio_pci_device *device);
>  
> +struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
> +					      size_t *nranges);
> +
>  int __vfio_pci_dma_map(struct vfio_pci_device *device,
>  		       struct vfio_dma_region *region);
>  int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index a381fd253aa7..6bedbe65f0a1 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -29,6 +29,167 @@
>  	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
>  } while (0)
>  
> +static struct vfio_info_cap_header *next_cap_hdr(void *buf, size_t bufsz,
> +						 size_t *cap_offset)
> +{
> +	struct vfio_info_cap_header *hdr;
> +
> +	if (!*cap_offset)
> +		return NULL;
> +
> +	/* Cap offset must be in bounds */
> +	VFIO_ASSERT_LT(*cap_offset, bufsz);
> +	/* There must be enough remaining space to contain the header */
> +	VFIO_ASSERT_GE(bufsz - *cap_offset, sizeof(*hdr));
> +
> +	hdr = (struct vfio_info_cap_header *)((u8 *)buf + *cap_offset);
> +
> +	/* If there is a next, offset must increase by at least the header size */
> +	if (hdr->next) {
> +		VFIO_ASSERT_GT(hdr->next, *cap_offset);
> +		VFIO_ASSERT_GE(hdr->next - *cap_offset, sizeof(*hdr));
> +	}
> +
> +	*cap_offset = hdr->next;
> +
> +	return hdr;
> +}
> +
> +static struct vfio_info_cap_header *vfio_iommu_info_cap_hdr(struct vfio_iommu_type1_info *buf,
> +							    u16 cap_id)
> +{
> +	struct vfio_info_cap_header *hdr;
> +	size_t cap_offset = buf->cap_offset;
> +
> +	if (!(buf->flags & VFIO_IOMMU_INFO_CAPS))
> +		return NULL;
> +
> +	if (cap_offset)
> +		VFIO_ASSERT_GE(cap_offset, sizeof(struct vfio_iommu_type1_info));
> +
> +	while ((hdr = next_cap_hdr(buf, buf->argsz, &cap_offset))) {
> +		if (hdr->id == cap_id)
> +			return hdr;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* Return buffer including capability chain, if present. Free with free() */
> +static struct vfio_iommu_type1_info *vfio_iommu_info_buf(struct vfio_pci_device *device)
> +{
> +	struct vfio_iommu_type1_info *buf;
> +
> +	buf = malloc(sizeof(*buf));
> +	VFIO_ASSERT_NOT_NULL(buf);
> +
> +	*buf = (struct vfio_iommu_type1_info) {
> +		.argsz = sizeof(*buf),
> +	};
> +
> +	ioctl_assert(device->container_fd, VFIO_IOMMU_GET_INFO, buf);
> +
> +	buf = realloc(buf, buf->argsz);
> +	VFIO_ASSERT_NOT_NULL(buf);
> +
> +	ioctl_assert(device->container_fd, VFIO_IOMMU_GET_INFO, buf);
> +
> +	return buf;
> +}
> +
> +/*
> + * Return iova ranges for the device's container. Normalize vfio_iommu_type1 to
> + * report iommufd's iommu_iova_range. Free with free().
> + */
> +static struct iommu_iova_range *vfio_iommu_iova_ranges(struct vfio_pci_device *device,
> +						       size_t *nranges)
> +{
> +	struct vfio_iommu_type1_info_cap_iova_range *cap_range;
> +	struct vfio_iommu_type1_info *buf;
> +	struct vfio_info_cap_header *hdr;
> +	struct iommu_iova_range *ranges = NULL;
> +
> +	buf = vfio_iommu_info_buf(device);
> +	VFIO_ASSERT_NOT_NULL(buf);
> +
> +	hdr = vfio_iommu_info_cap_hdr(buf, VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
> +	if (!hdr)
> +		goto free_buf;
> +
> +	cap_range = container_of(hdr, struct vfio_iommu_type1_info_cap_iova_range, header);
> +	if (!cap_range->nr_iovas)
> +		goto free_buf;
> +
> +	ranges = malloc(cap_range->nr_iovas * sizeof(*ranges));


Natural calloc() use case.

> +	VFIO_ASSERT_NOT_NULL(ranges);
> +
> +	for (u32 i = 0; i < cap_range->nr_iovas; i++) {
> +		ranges[i] = (struct iommu_iova_range){
> +			.start = cap_range->iova_ranges[i].start,
> +			.last = cap_range->iova_ranges[i].end,
> +		};
> +	}
> +
> +	*nranges = cap_range->nr_iovas;
> +
> +free_buf:
> +	free(buf);
> +	return ranges;
> +}
> +
> +/* Return iova ranges of the device's IOAS. Free with free() */
> +struct iommu_iova_range *iommufd_iova_ranges(struct vfio_pci_device *device,
> +					     size_t *nranges)
> +{
> +	struct iommu_iova_range *ranges;
> +	int ret;
> +
> +	struct iommu_ioas_iova_ranges query = {
> +		.size = sizeof(query),
> +		.ioas_id = device->ioas_id,
> +	};
> +
> +	ret = ioctl(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
> +	VFIO_ASSERT_EQ(ret, -1);
> +	VFIO_ASSERT_EQ(errno, EMSGSIZE);
> +	VFIO_ASSERT_GT(query.num_iovas, 0);
> +
> +	ranges = malloc(query.num_iovas * sizeof(*ranges));

Same.

> +	VFIO_ASSERT_NOT_NULL(ranges);
> +
> +	query.allowed_iovas = (uintptr_t)ranges;
> +
> +	ioctl_assert(device->iommufd, IOMMU_IOAS_IOVA_RANGES, &query);
> +	*nranges = query.num_iovas;
> +
> +	return ranges;
> +}
> +
> +struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
> +					      size_t *nranges)
> +{
> +	struct iommu_iova_range *ranges;
> +
> +	if (device->iommufd)
> +		ranges = iommufd_iova_ranges(device, nranges);
> +	else
> +		ranges = vfio_iommu_iova_ranges(device, nranges);
> +
> +	if (!ranges)
> +		return NULL;
> +
> +	/* ranges should be valid, ascending, and non-overlapping */

I don't recall that ranges are required to be in any particular order.
Thanks,

Alex

> +	VFIO_ASSERT_GT(*nranges, 0);
> +	VFIO_ASSERT_LT(ranges[0].start, ranges[0].last);
> +
> +	for (size_t i = 1; i < *nranges; i++) {
> +		VFIO_ASSERT_LT(ranges[i].start, ranges[i].last);
> +		VFIO_ASSERT_LT(ranges[i - 1].last, ranges[i].start);
> +	}
> +
> +	return ranges;
> +}
> +
>  iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
>  {
>  	struct vfio_dma_region *region;
> 


