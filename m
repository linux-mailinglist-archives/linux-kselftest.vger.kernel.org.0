Return-Path: <linux-kselftest+bounces-47848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D0CD65CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 15:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1DD7300EA01
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998452C029D;
	Mon, 22 Dec 2025 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5WHP3+h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9DA2C3745
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766413604; cv=none; b=W1Q5eX5cyGBJHBO3aqIG/JVROMPXmR+x86RU1RgMgAgAlVAZUGAui4r+HyphvBeV+vM9DThWy5CDvonkW5mZLRTdzFJ0HIugUbKznqXclmr7hnNJHPlV36ItbVVz0cdfYenxJAGuaaYa5+jadfiQzFTuwWAyDLnVJpYiSHgvOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766413604; c=relaxed/simple;
	bh=c6VS7kgJdCXXA0q6weCcFmjb5dzWdGtqollduEWQo7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHpW6sYDvCEDdgV/219K+6o7Mlk78Wa2UAR6fhxdquorenxlsbbDFZxNlkIZKyDMIRDsBAZfK5yfTPIEfKcQ5IVRqOmKWRqyD8/2OCJQoePhjrjI1IW+YYYLcTc3mDvOIFbNEy23nkUytADhx2MFi/L+/VrvIu1vRBGyVqZKDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5WHP3+h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766413601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8s9K/mvXy0EJ9YaBrIqIpW8RdmyR8RRUBSjdBA4sYsA=;
	b=f5WHP3+hAPsPhPdQ5yb6r6FNR8UzPnXshqNm9ks3zU2R/VfC+bXBHV1GYuXquNbIAf150F
	C1bxUFz+aBrtiSBXyb00p1IC6g1fvcurRg82X3HFVrVcAsJAqWqg2nW3iyIyRTEN3Yan9+
	xpMl8u4oSJGwSdPcdwXnCPnDgWFh2BU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-rn4-PV-POLS57zZqYxs_eg-1; Mon,
 22 Dec 2025 09:26:38 -0500
X-MC-Unique: rn4-PV-POLS57zZqYxs_eg-1
X-Mimecast-MFC-AGG-ID: rn4-PV-POLS57zZqYxs_eg_1766413597
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5ACF0195605B;
	Mon, 22 Dec 2025 14:26:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.92])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FDAE19560B4;
	Mon, 22 Dec 2025 14:26:29 +0000 (UTC)
Date: Mon, 22 Dec 2025 22:26:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 04/20] ublk: add integrity UAPI
Message-ID: <aUlVDtLgPh6NCWsC@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Dec 16, 2025 at 10:34:38PM -0700, Caleb Sander Mateos wrote:
> From: Stanley Zhang <stazhang@purestorage.com>
> 
> Add UAPI definitions for metadata/integrity support in ublk.
> UBLK_PARAM_TYPE_INTEGRITY and struct ublk_param_integrity allow a ublk
> server to specify the integrity params of a ublk device.
> The ublk driver will set UBLK_IO_F_INTEGRITY in the op_flags field of
> struct ublksrv_io_desc for requests with integrity data.
> The ublk server uses user copy with UBLKSRV_IO_INTEGRITY_FLAG set in the
> offset parameter to access a request's integrity buffer.
> 
> Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> [csander: drop feature flag and redundant pi_tuple_size field,
>  add io_desc flag, use block metadata UAPI constants]
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  include/uapi/linux/ublk_cmd.h | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index ec77dabba45b..5bfb9a0521c3 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -129,11 +129,15 @@
>  #define UBLK_QID_BITS		12
>  #define UBLK_QID_BITS_MASK	((1ULL << UBLK_QID_BITS) - 1)
>  
>  #define UBLK_MAX_NR_QUEUES	(1U << UBLK_QID_BITS)
>  
> -#define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_QID_OFF + UBLK_QID_BITS)
> +/* Copy to/from request integrity buffer instead of data buffer */
> +#define UBLK_INTEGRITY_FLAG_OFF		(UBLK_QID_OFF + UBLK_QID_BITS)
> +#define UBLKSRV_IO_INTEGRITY_FLAG	(1ULL << UBLK_INTEGRITY_FLAG_OFF)
> +

I feel it is more readable to move the definition into the patch which uses
them.

> +#define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_INTEGRITY_FLAG_OFF + 1)

It is UAPI, UBLKSRV_IO_BUF_TOTAL_BITS shouldn't be changed, or can you
explain this way is safe?

>  #define UBLKSRV_IO_BUF_TOTAL_SIZE	(1ULL << UBLKSRV_IO_BUF_TOTAL_BITS)
>  
>  /*
>   * ublk server can register data buffers for incoming I/O requests with a sparse
>   * io_uring buffer table. The request buffer can then be used as the data buffer
> @@ -406,10 +410,12 @@ struct ublksrv_ctrl_dev_info {
>   *
>   * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
>   * passed in.
>   */
>  #define		UBLK_IO_F_NEED_REG_BUF		(1U << 17)
> +/* Request has an integrity data buffer */
> +#define		UBLK_IO_F_INTEGRITY		(1U << 18)
>  
>  /*
>   * io cmd is described by this structure, and stored in share memory, indexed
>   * by request tag.
>   *
> @@ -598,10 +604,20 @@ struct ublk_param_segment {
>  	__u32 	max_segment_size;
>  	__u16 	max_segments;
>  	__u8	pad[2];
>  };
>  
> +struct ublk_param_integrity {
> +	__u32	flags; /* LBMD_PI_CAP_* from linux/fs.h */
> +	__u8	interval_exp;
> +	__u8	metadata_size;
> +	__u8	pi_offset;
> +	__u8	csum_type; /* LBMD_PI_CSUM_* from linux/fs.h */
> +	__u8	tag_size;
> +	__u8	pad[7];
> +};
> +

Just be curious, `pi_tuple_size` isn't defined, instead it is hard-coded in
ublk_integrity_pi_tuple_size().

However, both scsi and nvme sets `pi_tuple_size`, so it means that ublk PI
supports one `subset` or scsi/nvme `pi_tuple_size` can be removed too?


Thanks, 
Ming


