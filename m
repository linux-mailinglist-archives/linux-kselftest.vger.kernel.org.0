Return-Path: <linux-kselftest+bounces-48118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA60CF00D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 15:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE258301D5FD
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437C230CD94;
	Sat,  3 Jan 2026 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6vyGI/3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640B1B0F19
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767449695; cv=none; b=pbI1pMUKtpz65qnmzmAHbHpSWnCz/Vo2PEMFWdaIXcObGRLlJH4Cdl1pepbi0aBzmW77/TzlmYyByGWo2OFL7YXwaiF0ZOFbh58GeYDd2gjN6GuXSfXfmCG7F8dOyuWIOP3eBuOaFd11snELIM0mk3tRlWUfuJ6ql0Ah2LPEs84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767449695; c=relaxed/simple;
	bh=5TPvSvo3LXqU3rGbqWnYD5rCziwBBug8JDx8BzGtH9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAw4Rv10p9zeeVkuQGr/y6QNB3ai07a3VYRoGlI6XAWe48a0bfnjoEgwQlMHjuWDAcSEsP1jox0PDRLxL0WAt7/SkHMRwYr0UL+xAiCgpy8Bg223w0cyaQF5MxqZ3l5ladlkL2KlG8QQJsuT68lyQZ34lHxbIPWKY0izEc3VZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6vyGI/3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767449691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MjENUdGrgDrShWJm6ofVyEv4RgoSnGWRB8yy1V/0ggQ=;
	b=Q6vyGI/3/VRx4yYGUjVbjCyhKIQosQGGe1GTdDknMb7e22G5kti5G/E/OZPCCJYEoq4eg0
	Sxxu5orNeBPeIi6wEtuZohRBn6cZ2uejRqExVI35hcajfWp5LLjFMIBRpq+tsYx3D0hozK
	PruzmHzZxFGm0KJOux3IX76+9QVKYBI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-kg0e9oyyPzOpYAvuBTviRQ-1; Sat,
 03 Jan 2026 09:14:48 -0500
X-MC-Unique: kg0e9oyyPzOpYAvuBTviRQ-1
X-Mimecast-MFC-AGG-ID: kg0e9oyyPzOpYAvuBTviRQ_1767449687
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7D5019560A5;
	Sat,  3 Jan 2026 14:14:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.49])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1101F30001A2;
	Sat,  3 Jan 2026 14:14:40 +0000 (UTC)
Date: Sat, 3 Jan 2026 22:14:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH v2 04/19] ublk: set request integrity params in
 ublksrv_io_desc
Message-ID: <aVkkSxNNUBMz9E61@fedora>
References: <20260103004529.1582405-1-csander@purestorage.com>
 <20260103004529.1582405-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103004529.1582405-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jan 02, 2026 at 05:45:14PM -0700, Caleb Sander Mateos wrote:
> Indicate to the ublk server when an incoming request has integrity data
> by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.
> If the ublk device doesn't support integrity, the request will never
> provide integrity data. If the ublk device supports integrity, the
> request may omit the integrity buffer only if metadata_size matches the
> PI tuple size determined by csum_type. In this case, the ublk server
> should internally generate/verify the protection information from the
> data and sector offset.
> Set the UBLK_IO_F_CHECK_{GUARD,REFTAG,APPTAG} flags based on the
> request's BIP_CHECK_{GUARD,REFTAG,APPTAG} flags, indicating whether to
> verify the guard, reference, and app tags in the protection information.
> The expected reference tag (32 or 48 bits) and app tag (16 bits) are
> indicated in ublksrv_io_desc's new struct ublksrv_io_integrity integrity
> field. This field is unioned with the addr field to avoid changing the

It might be fine to set per-rq app_tag, but bios in one request might have
different app_tag in case of io merge actually.

Also block layer builds ref_tag for each internal, please see
t10_pi_generate() and ext_pi_crc64_generate().

So looks this way is wrong.

More importantly reusing iod->addr for other purpose not related with IO
buffer is very unfriendly for adding new features, and one lesson is for ZONED support
by reusing ublksrv_io_cmd->addr for zoned's append lba.

For example, there is chance to support dma-buf based zero copy for ublk, and
please see the io-uring dma-buf support[1], and iod->addr might carry IO buffer info
in dma-buf format in future.

[1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gmail.com/#t


> size of struct ublksrv_io_desc. UBLK_F_INTEGRITY requires
> UBLK_F_USER_COPY and the addr field isn't used for UBLK_F_USER_COPY, so
> the two fields aren't needed simultaneously.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c      | 43 +++++++++++++++++++++++++++++++----
>  include/uapi/linux/ublk_cmd.h | 27 ++++++++++++++++++++--
>  2 files changed, 64 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2f9316febf83..51469e0627ff 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -316,10 +316,36 @@ static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
>  static inline bool ublk_queue_is_zoned(const struct ublk_queue *ubq)
>  {
>  	return ubq->flags & UBLK_F_ZONED;
>  }
>  
> +static void ublk_setup_iod_buf(const struct ublk_queue *ubq,
> +			       const struct request *req,
> +			       struct ublksrv_io_desc *iod)
> +{
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +	if (ubq->flags & UBLK_F_INTEGRITY) {
> +		struct bio_integrity_payload *bip;
> +		sector_t ref_tag_seed;
> +
> +		if (!blk_integrity_rq(req))
> +			return;
> +
> +		bip = bio_integrity(req->bio);
> +		ref_tag_seed = bip_get_seed(bip);

As mentioned, t10_pi_generate() and ext_pi_crc64_generate() builds
per-internal ref tag.


> +		iod->integrity.ref_tag_lo = ref_tag_seed;
> +		iod->integrity.ref_tag_hi = ref_tag_seed >> 32;
> +		iod->integrity.app_tag = bip->app_tag;

In case of io merge, each bio may have different ->app_tag.

Given you have to copy meta data via user copy, I suggest to follow the PI
standard and make it per-internal.

Thanks, 
Ming


