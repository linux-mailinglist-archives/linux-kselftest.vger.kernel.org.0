Return-Path: <linux-kselftest+bounces-48293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C4ACF87F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 14:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDE8930DC16B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79C9330320;
	Tue,  6 Jan 2026 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZjfKFhh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC732F761
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767705306; cv=none; b=Ubw01ZmtxhXRMCbKciL1MLbjem6t3I3F0UQBzpAOXzduvyL0JpNjQ/qAqYMnuCmpBBZmTV2UVBXta3Yp+3kiHhwNXyl/j9C3lx7KFLy7r8TYdt3LmOtTIqKVuvOQAwPj97cPyzSg4Mfoz80ie2XX26TeuqswtTxLEEKZNKcJjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767705306; c=relaxed/simple;
	bh=oeQfbG3YXkVorqOxo5ToI8t7EzLqBrUOMDj1P0VzPpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXaLOB5xNs+cAuVF6CCrnFmzzj1D/qUKv9KgrObcwy/nTUFZTTIAizPZQpzJLOVdb5hoYRskrUY5K626WkGj+zT8zX2Wvr8I0OQHeFig+trlGv1QP9N5MTHEZk+qICGBJNTO2WAQbLz+Aq6NOdVf/tIOqhHda6SKR5Su7HrP/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZjfKFhh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767705303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa8r7E52wSsWJY4CuomkcvnqW024CYAaKP2i8APhpbY=;
	b=JZjfKFhhBbxIGt70MXY1hvAtWogKoT45BBkW/nvTRtLkAp5oW8QxISTculGimk503FC1AK
	3881rU83p1nMZvRx019RkLAw5deVyXwckW3nJ2abKw+35yxrk4Kg6LoGWxB+aVHR3FwETl
	9ibMUy4zZYW9G25qBVbqrMV1As1X2Zs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-DVhyaenNPnmtWmYE-v-8yw-1; Tue,
 06 Jan 2026 08:15:01 -0500
X-MC-Unique: DVhyaenNPnmtWmYE-v-8yw-1
X-Mimecast-MFC-AGG-ID: DVhyaenNPnmtWmYE-v-8yw_1767705300
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE2A4195FCDD;
	Tue,  6 Jan 2026 13:14:59 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8EEC19560B2;
	Tue,  6 Jan 2026 13:14:50 +0000 (UTC)
Date: Tue, 6 Jan 2026 21:14:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 05/19] ublk: add ublk_copy_user_bvec() helper
Message-ID: <aV0Kv4s8Iqp-E8Ge@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-6-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106005752.3784925-6-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jan 05, 2026 at 05:57:37PM -0700, Caleb Sander Mateos wrote:
> Factor a helper function ublk_copy_user_bvec() out of
> ublk_copy_user_pages(). It will be used for copying integrity data too.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 52 +++++++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2b0a9720921d..2ce9afdecc15 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1000,10 +1000,39 @@ static const struct block_device_operations ub_fops = {
>  	.open =		ublk_open,
>  	.free_disk =	ublk_free_disk,
>  	.report_zones =	ublk_report_zones,
>  };
>  
> +static bool ublk_copy_user_bvec(const struct bio_vec *bv, unsigned *offset,
> +				struct iov_iter *uiter, int dir, size_t *done)
> +{
> +	unsigned len;
> +	void *bv_buf;
> +	size_t copied;
> +
> +	if (*offset >= bv->bv_len) {
> +		*offset -= bv->bv_len;
> +		return true;
> +	}
> +
> +	len = bv->bv_len - *offset;
> +	bv_buf = kmap_local_page(bv->bv_page) + bv->bv_offset + *offset;
> +	if (dir == ITER_DEST)
> +		copied = copy_to_iter(bv_buf, len, uiter);
> +	else
> +		copied = copy_from_iter(bv_buf, len, uiter);
> +
> +	kunmap_local(bv_buf);
> +
> +	*done += copied;
> +	if (copied < len)
> +		return false;
> +
> +	*offset = 0;
> +	return true;
> +}
> +
>  /*
>   * Copy data between request pages and io_iter, and 'offset'
>   * is the start point of linear offset of request.
>   */
>  static size_t ublk_copy_user_pages(const struct request *req,
> @@ -1012,33 +1041,12 @@ static size_t ublk_copy_user_pages(const struct request *req,
>  	struct req_iterator iter;
>  	struct bio_vec bv;
>  	size_t done = 0;
>  
>  	rq_for_each_segment(bv, req, iter) {
> -		unsigned len;
> -		void *bv_buf;
> -		size_t copied;
> -
> -		if (offset >= bv.bv_len) {
> -			offset -= bv.bv_len;
> -			continue;
> -		}
> -
> -		len = bv.bv_len - offset;
> -		bv_buf = kmap_local_page(bv.bv_page) + bv.bv_offset + offset;
> -		if (dir == ITER_DEST)
> -			copied = copy_to_iter(bv_buf, len, uiter);
> -		else
> -			copied = copy_from_iter(bv_buf, len, uiter);
> -
> -		kunmap_local(bv_buf);
> -
> -		done += copied;
> -		if (copied < len)
> +		if (!ublk_copy_user_bvec(&bv, &offset, uiter, dir, &done))
>  			break;
> -
> -		offset = 0;
>  	}
>  	return done;
>  }

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming


