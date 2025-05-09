Return-Path: <linux-kselftest+bounces-32734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90ADAB0BE5
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 09:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E20B1BC749F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879802701D3;
	Fri,  9 May 2025 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/yDi+T2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B926FA5F
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776460; cv=none; b=EbynbHUvtEKYvDL/nR1o4WLuDc5UdOhkVVeXUpf6lhKeP7HYSDVG4MpVhBclpxei42Rl4Tfci+SfYFheVOiCHzap/nkiRQ+rd2Xdxy2Y1cvkgWNWDYQYBbteszK48KrvsPRb3YbOsaU5WYw1xHyuH6qCIgN2B4a3OZ2ME7nubWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776460; c=relaxed/simple;
	bh=KmAT6LtY7QcLblQ611owrIfQCbW1DtEAiEj0njoLyRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHR0UByMTzR+MHaXYxvYSMtzYBm4nDwoxBZXiB4Sw4LaDVuAHWeHqJ0bnMxvBqUVWuaOn3LEujboU4i5SzGwgeK6zXXM/nnLPhS1Rnn5tdophVAI747ce7dY0J5nyXRn1DnGLwr4C8tK5Lerha+cNA2c3FibctIjNpOj7QPdbLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/yDi+T2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746776457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qZadeAT3wG/Mxtz9H4xGBzCmoVYS3YynDqPksK6AKGM=;
	b=M/yDi+T2ryfYDAbJOzWT7+yRc02/6tjsU3m3S1BYMMZVoToCu2H+wUZQpwRcdwir1GryGn
	jdJuNm/aOJ8Wj8f4/V7dpF6CDu6y8OwZ4T0SM/FfBW/rFtIUz9xxVratP3YRZQi0d6lK8d
	HmwYaOtqnVLQZVQa8/57BgEgFpGf8K0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-Sc9IPGtCPy2Ug01D356qJA-1; Fri,
 09 May 2025 03:40:52 -0400
X-MC-Unique: Sc9IPGtCPy2Ug01D356qJA-1
X-Mimecast-MFC-AGG-ID: Sc9IPGtCPy2Ug01D356qJA_1746776450
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 925F5195608B;
	Fri,  9 May 2025 07:40:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73981180049D;
	Fri,  9 May 2025 07:40:44 +0000 (UTC)
Date: Fri, 9 May 2025 15:40:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 4/8] selftests: ublk: kublk: tie sqe allocation to io
 instead of queue
Message-ID: <aB2xd4593ZkWuMbB@fedora>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
 <20250507-ublk_task_per_io-v6-4-a2a298783c01@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-ublk_task_per_io-v6-4-a2a298783c01@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, May 07, 2025 at 03:49:38PM -0600, Uday Shankar wrote:
> We currently have a helper ublk_queue_alloc_sqes which the ublk targets
> use to allocate SQEs for their own operations. However, as we move
> towards decoupled ublk_queues and ublk server threads, this helper does
> not make sense anymore. SQEs are allocated from rings, and we will have
> one ring per thread to avoid locking. Change the SQE allocation helper
> to ublk_io_alloc_sqes. Currently this still allocates SQEs from the io's
> queue's ring, but when we fully decouple threads and queues, it will
> allocate from the io's thread's ring instead.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/fault_inject.c |  2 +-
>  tools/testing/selftests/ublk/file_backed.c  |  6 +++---
>  tools/testing/selftests/ublk/kublk.c        |  3 ++-
>  tools/testing/selftests/ublk/kublk.h        | 11 +++++++----
>  tools/testing/selftests/ublk/null.c         |  2 +-
>  tools/testing/selftests/ublk/stripe.c       |  4 ++--
>  6 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
> index 6bc8ee519b483ba6a365dccb03ad389425eefd3b..101c6dad6cf1f6dd45bbc46baa793493b97646bf 100644
> --- a/tools/testing/selftests/ublk/fault_inject.c
> +++ b/tools/testing/selftests/ublk/fault_inject.c
> @@ -41,7 +41,7 @@ static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
>  		.tv_nsec = (long long)q->dev->private_data,
>  	};
>  
> -	ublk_queue_alloc_sqes(q, &sqe, 1);
> +	ublk_io_alloc_sqes(ublk_get_io(q, tag), &sqe, 1);
>  	io_uring_prep_timeout(sqe, &ts, 1, 0);
>  	sqe->user_data = build_user_data(tag, ublksrv_get_op(iod), 0, q->q_id, 1);
>  
> diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
> index 69991ac7a0a947acba7b23ac89348936a3fcef75..563f11a21604bbf5b9531f69f806d09cdd785960 100644
> --- a/tools/testing/selftests/ublk/file_backed.c
> +++ b/tools/testing/selftests/ublk/file_backed.c
> @@ -18,7 +18,7 @@ static int loop_queue_flush_io(struct ublk_queue *q, const struct ublksrv_io_des
>  	unsigned ublk_op = ublksrv_get_op(iod);
>  	struct io_uring_sqe *sqe[1];
>  
> -	ublk_queue_alloc_sqes(q, sqe, 1);
> +	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
>  	io_uring_prep_fsync(sqe[0], 1 /*fds[1]*/, IORING_FSYNC_DATASYNC);
>  	io_uring_sqe_set_flags(sqe[0], IOSQE_FIXED_FILE);
>  	/* bit63 marks us as tgt io */
> @@ -34,7 +34,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
>  	struct io_uring_sqe *sqe[3];
>  
>  	if (!zc) {
> -		ublk_queue_alloc_sqes(q, sqe, 1);
> +		ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
>  		if (!sqe[0])
>  			return -ENOMEM;
>  
> @@ -48,7 +48,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
>  		return 1;
>  	}
>  
> -	ublk_queue_alloc_sqes(q, sqe, 3);
> +	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
>  
>  	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
>  	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index d0eaf06fadbbb00c0549bba0a08f1be23baa2359..7b3af98546803134dd7f959c40408cefda7cd45c 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -439,6 +439,7 @@ static int ublk_queue_init(struct ublk_queue *q)
>  	for (i = 0; i < q->q_depth; i++) {
>  		q->ios[i].buf_addr = NULL;
>  		q->ios[i].flags = UBLKSRV_NEED_FETCH_RQ | UBLKSRV_IO_FREE;
> +		q->ios[i].q = q;
>  
>  		if (q->state & UBLKSRV_NO_BUF)
>  			continue;
> @@ -554,7 +555,7 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
>  	if (io_uring_sq_space_left(&q->ring) < 1)
>  		io_uring_submit(&q->ring);
>  
> -	ublk_queue_alloc_sqes(q, sqe, 1);
> +	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
>  	if (!sqe[0]) {
>  		ublk_err("%s: run out of sqe %d, tag %d\n",
>  				__func__, q->q_id, tag);
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
> index 34f92bb2c64d0ddc7690b2654613e0c77b2b8121..7c912116606429215af7dbc2a8ce6b40ef89bfbd 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -119,6 +119,8 @@ struct ublk_io {
>  	unsigned short flags;
>  	unsigned short refs;		/* used by target code only */
>  
> +	struct ublk_queue *q;
> +
>  	int result;

In following patch, you added 'tag' to 'struct ublk_io', then 8bytes 'struct
ublk_queue *q' needn't to be added because it can be figured out by
container_of():

	- queue->ios can be calculated by 'io' address & its tag.
	
	- please add one helper ublk_io_to_queue(io) for it.

Also please try to avoid hole to 'ublk_io'.

Otherwise, this patch looks fine.



thanks,
Ming


