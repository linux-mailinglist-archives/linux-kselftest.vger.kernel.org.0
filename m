Return-Path: <linux-kselftest+bounces-47851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BAECD67A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 16:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4335B301DBB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664A3314D3;
	Mon, 22 Dec 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uy2y4sds"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D08A331213
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414909; cv=none; b=CL/CjBbOofQSrP8aDR6OKADjj55JrpqtXs+0p79bvNLCnOIHzOWE59KpCHCWaRpSBtfhBkJp4Bw+JsGZ7bkRWo0+pFdV/MDXg1+WKCNKN+DgLGMYO1JAKqpscAyq/RwC9xbVJENg+3X5oUiDhAaCrxCJGktLkD0AxLj7c/puLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414909; c=relaxed/simple;
	bh=WpnwWFCOx2/8+H+uFehTzWPyQ/0uHEVNfcDpyrjzsSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLZrrVffQ1L4zAt6V4oJ2uW1/tpRW2Hvv3PMpMQzB6AOd2wJg4OUM28KpkG2zuf1Wb/6g7tNNf1Gp44t7Iaw3qsDwai5ptH1cZ7vrvK12YZWNGjb+TyJdhG4iiZTPboPHfCt5cSpf79HTuxLMO2b4lFnP3nyRIVXM12AFCKC/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uy2y4sds; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766414907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2AY/r4bP8es3kUeaaXIDfMK6938Eqz7HvfF7cKC3JFs=;
	b=Uy2y4sds/Wx2tFi4esB6wdpbG2s6llu6hRSoPdn37Dk5NwKvHQMqgDO8B3l5N6gbw5YsLb
	OYgmH6yX5UE5jbRHk4dz9ozZZoPpaL4uW1B9VT78GThOu4S/eu7PCRGzcTPhsC3jjOI+EH
	T0Sbr4JOHT3fyVsc+n6ytqyFKoXFp2A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-RZaU8CY6MVi4jMF1sNWO_w-1; Mon,
 22 Dec 2025 09:48:22 -0500
X-MC-Unique: RZaU8CY6MVi4jMF1sNWO_w-1
X-Mimecast-MFC-AGG-ID: RZaU8CY6MVi4jMF1sNWO_w_1766414900
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD451195FD11;
	Mon, 22 Dec 2025 14:48:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79614180045B;
	Mon, 22 Dec 2025 14:48:12 +0000 (UTC)
Date: Mon, 22 Dec 2025 22:48:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 07/20] ublk: set UBLK_IO_F_INTEGRITY in ublksrv_io_desc
Message-ID: <aUlaJiTWwEmCxN_N@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-8-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-8-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Dec 16, 2025 at 10:34:41PM -0700, Caleb Sander Mateos wrote:
> Indicate to the ublk server when an incoming request has integrity data
> by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2893a9172220..d3652ceba96d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1107,10 +1107,13 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
>  		flags |= UBLK_IO_F_NOUNMAP;
>  
>  	if (req->cmd_flags & REQ_SWAP)
>  		flags |= UBLK_IO_F_SWAP;
>  
> +	if (blk_integrity_rq(req))
> +		flags |= UBLK_IO_F_INTEGRITY;
> +

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


