Return-Path: <linux-kselftest+bounces-48783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28384D14B60
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 19:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58E363008177
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 18:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A72238736C;
	Mon, 12 Jan 2026 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="i2XveRec"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DAC215055;
	Mon, 12 Jan 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768241873; cv=none; b=DjBnyE04p8PI1jPGLIuAPy/KU7AMqSWcV1OSSd3tNIx61kGL3KdE3iuF51SxgiZlBcW9T8ygMIL5EJ6NOv1z1KfIlRJWQqw5gaUQPO0T2c5qVTya6pyQTlrgbJXrYS8O7V6TAnLlYlN4z16lyRJSifGr+CaCmqtVVxRiEDmTI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768241873; c=relaxed/simple;
	bh=XHxyedfHCtV1Oik5LQCvcp2sX9uVbPWKWwB2XNfx5EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pm7rsAbiwyU4F+eRMLH/knegj4GkBQ2fWmumsfEQ9xWele8m9bxK2hVtpW78tvO7EveIGUUzmNHSlM49oE9ID/6MemzCA+e0Wo+7q8Z+yvDfQ/oyE5YUKFkxPF2Gax8rXbFPrXLJbTMSAX/s+eEJvoz93M8CaFtx/4YvmrdAIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=i2XveRec; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
X-Virus-Scanned: Yes
Message-ID: <f0c205d9-609f-4b08-af67-3d8730eb6fce@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1768241867; bh=XHxyedfHCtV1Oik5LQCvcp2sX9uVbPWKWwB2XNfx5EA=;
	h=Subject:To:Cc:References:From:Reply-To:In-Reply-To;
	b=i2XveRecMvUx91O6wYe1eU9GAha2NimfJ2l4iRFRFB5JkOU2o5rLJ8bP8Mpo22C8g
	 Ittw9wBcsi2+RJ4SM9q1k2V9eMQhPS6BDyFE5z3nmAHZO9cr4AUB6w/4RrNnTw6P+o
	 E13MgGbHw6kzqODVCylq1WoqIU0SPxUGJa/d6Bceg6ZtqqPA80sl7tDWhmkxTPrc8O
	 RIgDMRj00awNPjc7NkLDpHIllcXTrT9k3fAVHKYjvwBBJlcadd8dnDOolVQmJC5rC1
	 TtXKwGeIV5oEq/dKhC1WFQa6mrtjZIkXfB8oBLzZ+8o4YPdq/q6IIBLnt6jQ+cTBTz
	 knb+5xVOKRJ6/+I3y7+gUlJXn3h7MNC/fhfVcpr1RaAAWrJ2HV/1hNPotr0gxVhTRg
	 LbVyOMuwi5fQ4mkNY3NVffCz/NUW+mhFRdUDvCWq6O3dggTQjMwLGXZYSNHSDhQPUi
	 +VGA3MTFjgw6kVjLaKFlA/wpsbsL+VA8/+cxHGIWyw9c7YlruxlAqbS7fbS+BAr6XP
	 Z3FyLkf9uS/aI6HwAzriv6uz3R1kIQJrMg/emChYOpEO+lMFuOsPZ/OyjlCFwuC62P
	 O8fRMjNDH0ybK4EdScDGLrzE7ToIDardKHWUCpm0+kuIh/DRDNyfuXSXspv7C9uI0e
	 mbfW7cXq/u6JD+nxJcovedrI=
Date: Mon, 12 Jan 2026 20:17:44 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 08/19] ublk: move offset check out of
 __ublk_check_and_get_req()
Content-Language: en-GB
To: Caleb Sander Mateos <csander@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stanley Zhang <stazhang@purestorage.com>,
 Uday Shankar <ushankar@purestorage.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-9-csander@purestorage.com>
From: Alexander Atanasov <alex@zazolabs.com>
Reply-To: alex+zkern@zazolabs.com
In-Reply-To: <20260108091948.1099139-9-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8.01.26 11:19, Caleb Sander Mateos wrote:
> __ublk_check_and_get_req() checks that the passed in offset is within
> the data length of the specified ublk request. However, only user copy
> (ublk_check_and_get_req()) supports accessing ublk request data at a
> nonzero offset. Zero-copy buffer registration (ublk_register_io_buf())
> always passes 0 for the offset, so the check is unnecessary. Move the
> check from __ublk_check_and_get_req() to ublk_check_and_get_req().
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/block/ublk_drv.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index e7697dc4a812..8eefb838b563 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -253,11 +253,11 @@ struct ublk_params_header {
>   

[snip]

> @@ -2603,13 +2603,10 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
>   		goto fail_put;
>   
>   	if (!ublk_rq_has_data(req))
>   		goto fail_put;
>   
> -	if (offset > blk_rq_bytes(req))
> -		goto fail_put;
> -
>   	return req;
>   fail_put:
>   	ublk_put_req_ref(io, req);
>   	return NULL;
>   }
> @@ -2687,14 +2684,19 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
>   
>   	if (tag >= ub->dev_info.queue_depth)
>   		return -EINVAL;
>   
>   	io = &ubq->ios[tag];
> -	req = __ublk_check_and_get_req(ub, q_id, tag, io, buf_off);
> +	req = __ublk_check_and_get_req(ub, q_id, tag, io);
>   	if (!req)
>   		return -EINVAL;
>   
> +	if (buf_off > blk_rq_bytes(req)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +

Offset is zero based, bytes are count so it should be >= here.

It will work this way but for buf_off == blk_rq_bytes(req) user will get 
0 instead of EINVAL.

static size_t ublk_copy_user_pages(const struct request *req,
                 unsigned offset, struct iov_iter *uiter, int dir)
{
	size_t done = 0;
...
         rq_for_each_segment(bv, req, iter) {
...
                 if (offset >= bv.bv_len) {
                         offset -= bv.bv_len; // bv_len is same as 
blk_rq_bytes(req)
                         continue; // this breaks the loop when ==
                 }
...
	}
	return done; // done is never incremented
}

>   	if (!ublk_check_ubuf_dir(req, dir)) {
>   		ret = -EACCES;
>   		goto out;
>   	}


-- 
have fun,
alex


