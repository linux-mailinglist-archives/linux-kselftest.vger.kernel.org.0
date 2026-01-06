Return-Path: <linux-kselftest+bounces-48294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C95BCCF88D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 14:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 137AC30111AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8637433AD9D;
	Tue,  6 Jan 2026 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHU3cp9o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5433A9FB
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706496; cv=none; b=ddcSGvD3Foktjok2+gKZ61ygdNp1taCPJti2BWxcapCa88rBr/ZvCu9t98BEdScvmBvrRu7geSgeSTfYuUXJxzAOLJCu+/4kMoo9LB/4dBMZM+AuyQa/px3vbLlvDzLTCRvmnGM3GxA1x4YZV795IKZiizRmURbfc9WKVWi8rRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706496; c=relaxed/simple;
	bh=bp6QRbJTKgfHRkPGEk9RiMMP84O09a7e6MI2CAj62Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duyCf5JdyHqsXlpi/2OL58socXQQqmkg9meAQ4Q9HdpfczrBOacABKoEZHExxgPJOSGqBj4us7YE0mJnW8/6rQ0p03G3uk+rKOoEAk2gCbj2IDcAcNL5yBETxV/ltQxofSskYbuMPd7y7V6FS5akyXn7Jmx6QBrbI0VWkfFjUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHU3cp9o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767706493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sa0nrsEWsDoyr3jjQuCzFC+9qlZewsQvV1qBmYTG62w=;
	b=QHU3cp9o0IYoGMmNr//dPwUA10ixoY6DwoJ6tM6oSWSYC6ZltpXHtaivnfLdhgyA8byoVl
	AXC08INFDZHs59DahCP75IITYbIj5g4io8Ll9XTDcjXk7zw+Nyuv9gV+5PLUzmXL57SBXN
	rkj5sEXUQvXtp7jKfNSNc9dxTF/xs3g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-wVGnChECO_qUbN_5odV0Rw-1; Tue,
 06 Jan 2026 08:34:50 -0500
X-MC-Unique: wVGnChECO_qUbN_5odV0Rw-1
X-Mimecast-MFC-AGG-ID: wVGnChECO_qUbN_5odV0Rw_1767706488
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78D75195FCE9;
	Tue,  6 Jan 2026 13:34:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46A54180045B;
	Tue,  6 Jan 2026 13:34:39 +0000 (UTC)
Date: Tue, 6 Jan 2026 21:34:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 09/19] ublk: implement integrity user copy
Message-ID: <aV0PauBTiqWVQ-26@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-10-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106005752.3784925-10-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Jan 05, 2026 at 05:57:41PM -0700, Caleb Sander Mateos wrote:
> From: Stanley Zhang <stazhang@purestorage.com>
> 
> Add a function ublk_copy_user_integrity() to copy integrity information
> between a request and a user iov_iter. This mirrors the existing
> ublk_copy_user_pages() but operates on request integrity data instead of
> regular data. Check UBLKSRV_IO_INTEGRITY_FLAG in iocb->ki_pos in
> ublk_user_copy() to choose between copying data or integrity data.
> 
> Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> [csander: change offset units from data bytes to integrity data bytes,
>  test UBLKSRV_IO_INTEGRITY_FLAG after subtracting UBLKSRV_IO_BUF_OFFSET,
>  fix CONFIG_BLK_DEV_INTEGRITY=n build,
>  rebase on ublk user copy refactor]
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c      | 52 +++++++++++++++++++++++++++++++++--
>  include/uapi/linux/ublk_cmd.h |  4 +++
>  2 files changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e44ab9981ef4..9694a4c1caa7 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -621,10 +621,15 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
>  {
>  	return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_TAG_OFF) &
>  		UBLK_TAG_BITS_MASK;
>  }
>  
> +static inline bool ublk_pos_is_integrity(loff_t pos)
> +{
> +	return !!((pos - UBLKSRV_IO_BUF_OFFSET) & UBLKSRV_IO_INTEGRITY_FLAG);
> +}
> +

It could be more readable to check UBLKSRV_IO_INTEGRITY_FLAG only.

>  static void ublk_dev_param_basic_apply(struct ublk_device *ub)
>  {
>  	const struct ublk_param_basic *p = &ub->params.basic;
>  
>  	if (p->attrs & UBLK_ATTR_READ_ONLY)
> @@ -1047,10 +1052,37 @@ static size_t ublk_copy_user_pages(const struct request *req,
>  			break;
>  	}
>  	return done;
>  }
>  
> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +static size_t ublk_copy_user_integrity(const struct request *req,
> +		unsigned offset, struct iov_iter *uiter, int dir)
> +{
> +	size_t done = 0;
> +	struct bio *bio = req->bio;
> +	struct bvec_iter iter;
> +	struct bio_vec iv;
> +
> +	if (!blk_integrity_rq(req))
> +		return 0;
> +
> +	bio_for_each_integrity_vec(iv, bio, iter) {
> +		if (!ublk_copy_user_bvec(&iv, &offset, uiter, dir, &done))
> +			break;
> +	}
> +
> +	return done;
> +}
> +#else /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
> +static size_t ublk_copy_user_integrity(const struct request *req,
> +		unsigned offset, struct iov_iter *uiter, int dir)
> +{
> +	return 0;
> +}
> +#endif /* #ifdef CONFIG_BLK_DEV_INTEGRITY */
> +
>  static inline bool ublk_need_map_req(const struct request *req)
>  {
>  	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
>  }
>  
> @@ -2654,10 +2686,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
>  {
>  	struct ublk_device *ub = iocb->ki_filp->private_data;
>  	struct ublk_queue *ubq;
>  	struct request *req;
>  	struct ublk_io *io;
> +	unsigned data_len;
> +	bool is_integrity;
>  	size_t buf_off;
>  	u16 tag, q_id;
>  	ssize_t ret;
>  
>  	if (!user_backed_iter(iter))
> @@ -2667,10 +2701,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
>  		return -EACCES;
>  
>  	tag = ublk_pos_to_tag(iocb->ki_pos);
>  	q_id = ublk_pos_to_hwq(iocb->ki_pos);
>  	buf_off = ublk_pos_to_buf_off(iocb->ki_pos);
> +	is_integrity = ublk_pos_is_integrity(iocb->ki_pos);

UBLKSRV_IO_INTEGRITY_FLAG can be set for device without UBLK_F_INTEGRITY,
so UBLK_F_INTEGRITY need to be checked in case of `is_integrity`.

>  
>  	if (q_id >= ub->dev_info.nr_hw_queues)
>  		return -EINVAL;
>  
>  	ubq = ublk_get_queue(ub, q_id);
> @@ -2683,21 +2718,31 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
>  	io = &ubq->ios[tag];
>  	req = __ublk_check_and_get_req(ub, q_id, tag, io);
>  	if (!req)
>  		return -EINVAL;
>  
> -	if (buf_off > blk_rq_bytes(req)) {
> +	if (is_integrity) {
> +		struct blk_integrity *bi = &req->q->limits.integrity;
> +
> +		data_len = bio_integrity_bytes(bi, blk_rq_sectors(req));
> +	} else {
> +		data_len = blk_rq_bytes(req);
> +	}
> +	if (buf_off > data_len) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
>  	if (!ublk_check_ubuf_dir(req, dir)) {
>  		ret = -EACCES;
>  		goto out;
>  	}
>  
> -	ret = ublk_copy_user_pages(req, buf_off, iter, dir);
> +	if (is_integrity)
> +		ret = ublk_copy_user_integrity(req, buf_off, iter, dir);
> +	else
> +		ret = ublk_copy_user_pages(req, buf_off, iter, dir);
>  
>  out:
>  	ublk_put_req_ref(io, req);
>  	return ret;
>  }
> @@ -3931,11 +3976,12 @@ static struct miscdevice ublk_misc = {
>  static int __init ublk_init(void)
>  {
>  	int ret;
>  
>  	BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
> -			UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
> +			UBLKSRV_IO_BUF_TOTAL_SIZE +
> +			UBLKSRV_IO_INTEGRITY_FLAG < UBLKSRV_IO_BUF_OFFSET);

Maybe it can be simplified as:

BUILD_BUG_ON(UBLK_INTEGRITY_FLAG_OFF >= 63);  /* Must fit in loff_t */

>  	BUILD_BUG_ON(sizeof(struct ublk_auto_buf_reg) != 8);
>  
>  	init_waitqueue_head(&ublk_idr_wq);
>  
>  	ret = misc_register(&ublk_misc);
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index c1103ad5925b..3af7e3684834 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -132,10 +132,14 @@
>  #define UBLK_MAX_NR_QUEUES	(1U << UBLK_QID_BITS)
>  
>  #define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_QID_OFF + UBLK_QID_BITS)
>  #define UBLKSRV_IO_BUF_TOTAL_SIZE	(1ULL << UBLKSRV_IO_BUF_TOTAL_BITS)
>  
> +/* Copy to/from request integrity buffer instead of data buffer */
> +#define UBLK_INTEGRITY_FLAG_OFF UBLKSRV_IO_BUF_TOTAL_BITS
> +#define UBLKSRV_IO_INTEGRITY_FLAG (1ULL << UBLK_INTEGRITY_FLAG_OFF)
> +
>  /*
>   * ublk server can register data buffers for incoming I/O requests with a sparse
>   * io_uring buffer table. The request buffer can then be used as the data buffer
>   * for io_uring operations via the fixed buffer index.
>   * Note that the ublk server can never directly access the request data memory.
> -- 
> 2.45.2
> 

Thanks,
Ming


