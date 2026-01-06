Return-Path: <linux-kselftest+bounces-48298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13414CF8A48
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BEF830BB26B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10403328608;
	Tue,  6 Jan 2026 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6ROIDuo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7762A322A2E
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707220; cv=none; b=MvUGZJXlgxEWbomaiLl6yfzkSfgwG6c4WdsxN85HTNJzuhIo/p1USlOQ1x6Tqwhz6euuYPBCqjeFGh0ula1Y9ZuS/+6XAOVw/SOv93V/COyh+Xbplo4SVhgflYCLwubb8v1TfG9q7g8oUrYACr5OcaNFn6R1T5Q7np7vUfa7yz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707220; c=relaxed/simple;
	bh=IFWtfZCxwnizNmOQ4YaunGOHc3Atsm5NGJ4J2TeJ1M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvgNZx1H+AtEgS/uocX2Izn21Kz9nqx3pTonVBXITJfS6f/r51xKgDrO4tzb/Hescah6u4gDGABjFxvDzPy5e33MA9qNniB22kksuXBpLDW02vvJw6SFYlaFSvDnCF8bF9M3lBGXFYQf4JGoej4TpB1xu7On4oBBXLq+C7xAkAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6ROIDuo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYaObXGToIAIvRRny42n4tl1EbiM1ZMTYOqecmqvK/4=;
	b=D6ROIDuoSr2i6HOsdMykEsuS/J21G8Xbpgg263wlKBWJtuYSkGk0Cw8tiKhNBEAXeU9BuG
	kXa8K3IsD24FTq2FW8NFVlgKsIoDOzw53P+I5LTG47GdPZaY3+lNeO7Lm7BTqUeCNGm10U
	ibQ3mXyPUiy9YgMU6yxTt+oiFbqjzL0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-0vLK66FFNKWjplHQY-aPkw-1; Tue,
 06 Jan 2026 08:46:55 -0500
X-MC-Unique: 0vLK66FFNKWjplHQY-aPkw-1
X-Mimecast-MFC-AGG-ID: 0vLK66FFNKWjplHQY-aPkw_1767707214
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF02B195FCDC;
	Tue,  6 Jan 2026 13:46:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 227B530001A8;
	Tue,  6 Jan 2026 13:46:45 +0000 (UTC)
Date: Tue, 6 Jan 2026 21:46:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 09/19] ublk: implement integrity user copy
Message-ID: <aV0SQHzUEF8f9ryn@fedora>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

...

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

UBLKSRV_IO_INTEGRITY_FLAG is actually one flag, not same with other encoded
fields, maybe it is better to define it from top bit(62) and not mix with
others? Then it can be helpful to extend in future.


Thanks,
Ming


