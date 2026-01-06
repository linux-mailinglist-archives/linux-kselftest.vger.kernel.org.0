Return-Path: <linux-kselftest+bounces-48292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 260FACF86D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 14:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F8F4303F7DB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D3F32E6AC;
	Tue,  6 Jan 2026 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccGtdV1E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425CE32F74D
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704969; cv=none; b=Bpevgsykn4AmR/WSlK974RZB3p6VCaopwCEOTlVs4h4ymndiRNhNChFLgY7XjHLeumn8WpgztCfst41sc33pQbecLHpzuGfYdG1UmHYk1ciKw490J06J5aiv9fRFfwGxScbIwEInRYcGpNxQgCYHU+21M4ILowiEFTzovwemtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704969; c=relaxed/simple;
	bh=LxUYvzkrRayFzKFU6UJFbzsBDT2UEJcsF5EIgzVaUMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVqQhmGId03RlSFPp4Y7KJkvat3p0raQXkA439sC4Km69fqLLU2j/UigCAzxQdWHQ79YUYSmvLlHst/DDXdIkkHVW27g617fDsHa0uQ47fNigDB8KK6OrhKWmeXYcLUlbkizoSljq5zLxny+pEKZ6eEGWl/gAKfGDpkHCcJTz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccGtdV1E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767704966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XDkWG5umDq+hIkzVAvhpKK76E6qgdKCA/hJEYRZlNvI=;
	b=ccGtdV1ERgK8pApO6Vu8xrnU8Em+hI2FCuWMxQUVojRhwI8X2muWYe97ztsaCA5XgogLiJ
	rUawc1yn6OB8PM+qSZE9yHyzql6iFnOVQ4lh74Qb9lYb9Mefwe0jCD1RTTbkJPHE+3jNJi
	1ygSYwZZlc4NLDPs9HsVD6ssDHy2U7w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-QHCLCtnyNCiCLjtL-kT_HQ-1; Tue,
 06 Jan 2026 08:09:24 -0500
X-MC-Unique: QHCLCtnyNCiCLjtL-kT_HQ-1
X-Mimecast-MFC-AGG-ID: QHCLCtnyNCiCLjtL-kT_HQ_1767704963
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27F141801210;
	Tue,  6 Jan 2026 13:09:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECFD4180049F;
	Tue,  6 Jan 2026 13:09:16 +0000 (UTC)
Date: Tue, 6 Jan 2026 21:09:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 03/19] ublk: support UBLK_PARAM_TYPE_INTEGRITY in
 device creation
Message-ID: <aV0Jd76i9Iru8Ge9@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106005752.3784925-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Jan 05, 2026 at 05:57:35PM -0700, Caleb Sander Mateos wrote:
> From: Stanley Zhang <stazhang@purestorage.com>
> 
> Add a feature flag UBLK_F_INTEGRITY for a ublk server to request
> integrity/metadata support when creating a ublk device. The ublk server
> can also check for the feature flag on the created device or the result
> of UBLK_U_CMD_GET_FEATURES to tell if the ublk driver supports it.
> UBLK_F_INTEGRITY requires UBLK_F_USER_COPY, as user copy is the only
> data copy mode initially supported for integrity data.
> Add UBLK_PARAM_TYPE_INTEGRITY and struct ublk_param_integrity to struct
> ublk_params to specify the integrity params of a ublk device.
> UBLK_PARAM_TYPE_INTEGRITY requires UBLK_F_INTEGRITY and a nonzero
> metadata_size. The LBMD_PI_CAP_* and LBMD_PI_CSUM_* values from the
> linux/fs.h UAPI header are used for the flags and csum_type fields.
> If the UBLK_PARAM_TYPE_INTEGRITY flag is set, validate the integrity
> parameters and apply them to the blk_integrity limits.
> The struct ublk_param_integrity validations are based on the checks in
> blk_validate_integrity_limits(). Any invalid parameters should be
> rejected before being applied to struct blk_integrity.
> 
> Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> [csander: drop redundant pi_tuple_size field, use block metadata UAPI
>  constants, add param validation]
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c      | 94 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h | 18 +++++++
>  2 files changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 8e3da9b2b93a..066c6ae062a0 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -42,10 +42,12 @@
>  #include <linux/mm.h>
>  #include <asm/page.h>
>  #include <linux/task_work.h>
>  #include <linux/namei.h>
>  #include <linux/kref.h>
> +#include <linux/blk-integrity.h>
> +#include <uapi/linux/fs.h>
>  #include <uapi/linux/ublk_cmd.h>
>  
>  #define UBLK_MINORS		(1U << MINORBITS)
>  
>  #define UBLK_INVALID_BUF_IDX 	((u16)-1)
> @@ -81,11 +83,12 @@
>  
>  /* All UBLK_PARAM_TYPE_* should be included here */
>  #define UBLK_PARAM_TYPE_ALL                                \
>  	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
>  	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
> -	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
> +	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT | \
> +	 UBLK_PARAM_TYPE_INTEGRITY)
>  
>  struct ublk_uring_cmd_pdu {
>  	/*
>  	 * Store requests in same batch temporarily for queuing them to
>  	 * daemon context.
> @@ -628,10 +631,57 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
>  		set_disk_ro(ub->ub_disk, true);
>  
>  	set_capacity(ub->ub_disk, p->dev_sectors);
>  }
>  
> +static int ublk_integrity_flags(u32 flags)
> +{
> +	int ret_flags = 0;
> +
> +	if (flags & LBMD_PI_CAP_INTEGRITY) {
> +		flags &= ~LBMD_PI_CAP_INTEGRITY;
> +		ret_flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> +	}
> +	if (flags & LBMD_PI_CAP_REFTAG) {
> +		flags &= ~LBMD_PI_CAP_REFTAG;
> +		ret_flags |= BLK_INTEGRITY_REF_TAG;
> +	}
> +	return flags ? -EINVAL : ret_flags;
> +}
> +
> +static int ublk_integrity_pi_tuple_size(u8 csum_type)
> +{
> +	switch (csum_type) {
> +	case LBMD_PI_CSUM_NONE:
> +		return 0;
> +	case LBMD_PI_CSUM_IP:
> +	case LBMD_PI_CSUM_CRC16_T10DIF:
> +		return 8;
> +	case LBMD_PI_CSUM_CRC64_NVME:
> +		return 16;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static enum blk_integrity_checksum ublk_integrity_csum_type(u8 csum_type)
> +{
> +	switch (csum_type) {
> +	case LBMD_PI_CSUM_NONE:
> +		return BLK_INTEGRITY_CSUM_NONE;
> +	case LBMD_PI_CSUM_IP:
> +		return BLK_INTEGRITY_CSUM_IP;
> +	case LBMD_PI_CSUM_CRC16_T10DIF:
> +		return BLK_INTEGRITY_CSUM_CRC;
> +	case LBMD_PI_CSUM_CRC64_NVME:
> +		return BLK_INTEGRITY_CSUM_CRC64;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return BLK_INTEGRITY_CSUM_NONE;
> +	}
> +}
> +
>  static int ublk_validate_params(const struct ublk_device *ub)
>  {
>  	/* basic param is the only one which must be set */
>  	if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
>  		const struct ublk_param_basic *p = &ub->params.basic;
> @@ -690,10 +740,33 @@ static int ublk_validate_params(const struct ublk_device *ub)
>  			return -EINVAL;
>  		if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
>  			return -EINVAL;
>  	}
>  
> +	if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
> +		const struct ublk_param_integrity *p = &ub->params.integrity;
> +		int pi_tuple_size = ublk_integrity_pi_tuple_size(p->csum_type);
> +		int flags = ublk_integrity_flags(p->flags);
> +
> +		if (!(ub->dev_info.flags & UBLK_F_INTEGRITY))
> +			return -EINVAL;
> +		if (flags < 0)
> +			return flags;
> +		if (pi_tuple_size < 0)
> +			return pi_tuple_size;
> +		if (!p->metadata_size)
> +			return -EINVAL;
> +		if (p->csum_type == LBMD_PI_CSUM_NONE &&
> +		    p->flags & LBMD_PI_CAP_REFTAG)
> +			return -EINVAL;
> +		if (p->pi_offset + pi_tuple_size > p->metadata_size)
> +			return -EINVAL;
> +		if (p->interval_exp < SECTOR_SHIFT ||
> +		    p->interval_exp > ub->params.basic.logical_bs_shift)
> +			return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
>  static void ublk_apply_params(struct ublk_device *ub)
>  {
> @@ -2941,10 +3014,25 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>  		lim.seg_boundary_mask = ub->params.seg.seg_boundary_mask;
>  		lim.max_segment_size = ub->params.seg.max_segment_size;
>  		lim.max_segments = ub->params.seg.max_segments;
>  	}
>  
> +	if (ub->params.types & UBLK_PARAM_TYPE_INTEGRITY) {
> +		const struct ublk_param_integrity *p = &ub->params.integrity;
> +		int pi_tuple_size = ublk_integrity_pi_tuple_size(p->csum_type);
> +
> +		lim.integrity = (struct blk_integrity) {
> +			.flags = ublk_integrity_flags(p->flags),
> +			.csum_type = ublk_integrity_csum_type(p->csum_type),
> +			.metadata_size = p->metadata_size,
> +			.pi_offset = p->pi_offset,
> +			.interval_exp = p->interval_exp,
> +			.tag_size = p->tag_size,
> +			.pi_tuple_size = pi_tuple_size,
> +		};
> +	}
> +
>  	if (wait_for_completion_interruptible(&ub->completion) != 0)
>  		return -EINTR;
>  
>  	if (ub->ublksrv_tgid != ublksrv_pid)
>  		return -EINVAL;
> @@ -3131,10 +3219,14 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
>  		if (info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY |
>  					UBLK_F_AUTO_BUF_REG))
>  			return -EINVAL;
>  	}
>  
> +	/* User copy is required to access integrity buffer */
> +	if (info.flags & UBLK_F_INTEGRITY && !(info.flags & UBLK_F_USER_COPY))
> +		return -EINVAL;
> +
>  	/* the created device is always owned by current user */
>  	ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
>  
>  	if (header->dev_id != info.dev_id) {
>  		pr_warn("%s: dev id not match %u %u\n",
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index ec77dabba45b..a54c47832fa2 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -309,10 +309,16 @@
>   * the I/O's daemon task. The q_id and tag of the registered buffer are required
>   * in UBLK_U_IO_UNREGISTER_IO_BUF's ublksrv_io_cmd.
>   */
>  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
>  
> +/*
> + * ublk device supports requests with integrity/metadata buffer.
> + * Requires UBLK_F_USER_COPY.
> + */
> +#define UBLK_F_INTEGRITY (1ULL << 16)
> +
>  /* device state */
>  #define UBLK_S_DEV_DEAD	0
>  #define UBLK_S_DEV_LIVE	1
>  #define UBLK_S_DEV_QUIESCED	2
>  #define UBLK_S_DEV_FAIL_IO 	3
> @@ -598,10 +604,20 @@ struct ublk_param_segment {
>  	__u32 	max_segment_size;
>  	__u16 	max_segments;
>  	__u8	pad[2];
>  };
>  
> +struct ublk_param_integrity {
> +	__u32	flags; /* LBMD_PI_CAP_* from linux/fs.h */
> +	__u8	interval_exp;
> +	__u8	metadata_size; /* UBLK_PARAM_TYPE_INTEGRITY requires nonzero */
> +	__u8	pi_offset;
> +	__u8	csum_type; /* LBMD_PI_CSUM_* from linux/fs.h */
> +	__u8	tag_size;
> +	__u8	pad[7];
> +};

Looks max_integrity_segments is missed, otherwise this patch is fine for me.


Thanks,
Ming


