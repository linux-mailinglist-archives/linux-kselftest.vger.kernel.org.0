Return-Path: <linux-kselftest+bounces-47850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69513CD6758
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 16:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9BF930F3D52
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 14:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9F532E72B;
	Mon, 22 Dec 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwMKVEjy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813732E123
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414852; cv=none; b=S8tIqrvokALaBrPy66MMWyDzlh3blfb1vNuTTYTf89eIx2BTfYsaSgiwWFTqdne2Wq5mWj/Qp1fstimwluOlm+W5cgpGcZhdBfmTlNP79+oItDrZXRksv95Q0K+h0CFzcH4mtlW3vikgjUk5B08NutX3jL06647qbkpSPTDMidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414852; c=relaxed/simple;
	bh=nSttEXdT4PtcMNl70HHlKORopev1z3qyqkOnKfGFczc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlmOG2+YB4AKFArPTl/N6AysWxkcDndaylmTE1atKLPGaCkilJsQ63bE6WarKeYJfO2U22595RVW1HRoQlVswNaT3qpHtl+1k0Ne5OnIhYwnQuJgSmIhNe4sJc+hUkw8ZnHowENUJ1IEnFAXM8Ndzct/XjtBM9wzx3FxZuiUBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwMKVEjy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766414849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otvKqmDVc/2D0N0EJSTnX++7FlqgtFs+0qSfIazVFDs=;
	b=ZwMKVEjyt6Fd6vO1YbxggcP58QvwE/KpkGjUP4GJaN0TanUItEBuwJ3XJArFMHQsk9/kZb
	g0JEJxV++iY8a15MBAfvWyx44gpcKanlnEBxJ25Z0AoWDaObLubm0Eo4rk5r/ZT7DLoF5g
	kP8Jva8iicqSYgzzaMr2qf73xHyJcGs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-q8pDApIoMMqsjxmoTlzKlA-1; Mon,
 22 Dec 2025 09:47:24 -0500
X-MC-Unique: q8pDApIoMMqsjxmoTlzKlA-1
X-Mimecast-MFC-AGG-ID: q8pDApIoMMqsjxmoTlzKlA_1766414842
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54F6F1808881;
	Mon, 22 Dec 2025 14:47:22 +0000 (UTC)
Received: from fedora (unknown [10.72.116.92])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69FDB19560B4;
	Mon, 22 Dec 2025 14:47:14 +0000 (UTC)
Date: Mon, 22 Dec 2025 22:47:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 06/20] ublk: support UBLK_PARAM_TYPE_INTEGRITY in device
 creation
Message-ID: <aUlZ7APsr7tIdrWq@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-7-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-7-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Dec 16, 2025 at 10:34:40PM -0700, Caleb Sander Mateos wrote:
> From: Stanley Zhang <stazhang@purestorage.com>
> 
> If the UBLK_PARAM_TYPE_INTEGRITY flag is set, validate the integrity
> parameters and apply them to the blk_integrity limits.
> UBLK_PARAM_TYPE_INTEGRITY requires CONFIG_BLK_DEV_INTEGRITY=y,
> UBLK_F_USER_COPY, and metadata_size > 0. Reuse the block metadata ioctl
> LBMD_PI_CAP_* and LBMD_PI_CSUM_* constants from the linux/fs.h UAPI
> header for the flags and csum_type field values.
> The struct ublk_param_integrity validations are based on the checks in
> blk_validate_integrity_limits(). Any invalid parameters should be
> rejected before being applied to struct blk_integrity.
> 
> Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> [csander: add param validation]
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 92 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4da5d8ff1e1d..2893a9172220 100644
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
> @@ -613,10 +616,57 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
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
> @@ -675,10 +725,35 @@ static int ublk_validate_params(const struct ublk_device *ub)
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
> +		if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
> +			return -EINVAL;
> +		if (!ublk_dev_support_user_copy(ub))
> +			return -EINVAL;

UBLK_IO_F_INTEGRITY should be checked here, and ublk_dev_support_user_copy() can be
validated with UBLK_IO_F_INTEGRITY together in ublk_ctrl_add_dev(), so
mis-matched features can be failed earlier.

Same for IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY).

> +		if (flags < 0)
> +			return flags;
> +		if (pi_tuple_size < 0)
> +			return pi_tuple_size;
> +		if (!p->metadata_size)
> +			return -EINVAL;

blk_validate_integrity_limits() allows zero p->metadata_size with
LBMD_PI_CSUM_NONE, maybe document ublk's support for zero metadata_size & LBMD_PI_CSUM_NONE?



Thanks, 
Ming


