Return-Path: <linux-kselftest+bounces-32736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE258AB0CE0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 10:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BE45062F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 08:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A43D274658;
	Fri,  9 May 2025 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBds0J2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92C272E46
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778482; cv=none; b=hls9PywdXF/b/C5HVINZUXdqvIf5a6Se+xna146j9p8yfema6s9JgFJcGD6bCeJrfaEV3kRZf6FxmmftlX583zytuyGRh+8TsDcnXvGaNU0iBBzhhiYYm8bc5fzN1tCln4ytEkjU0BSLLSds8prjWGpb9dwm5XJnqJ2IFVIwHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778482; c=relaxed/simple;
	bh=YjChN+vh23L2FULjtmu5v2MLRZxR+OdIs3DXDmhBnOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlKGAxGK1D9u4ZsMU9xUqaXf2iCmkRCPDD+ZeJrEavqt5EBhhqeMZuvf7nlxPNlocb5LBe+dXEsgN/dHn3uxDUvLqfLkZ2eCfIrpwK+qjIKXVC7jVVu8by6xMn5aVH4dARfG/n8jYljfHWp3QQCR4FMSefuCl5F4VQn1SW4IMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBds0J2o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746778478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMY1q4CGEtr72fEml664zyG7vyi8pOMNChiBgsTWAsk=;
	b=ZBds0J2oxat5LTiNWK2KIEO9Jrn+TTPcrDhy1tRhtkLybsIwAc+2F0N+owa9gjJahuPkFF
	orQ9c4WhejV7i6a+z4XznKA52clQWDMCqvGrWhYPm/sajyMzYjNf1VW9xTvDR5MLGSYReG
	XwALGvngj7Rd2f2h5iqebgoMKq6ypiM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-_cQ1zen2MdaPl04ZnkXx0w-1; Fri,
 09 May 2025 04:14:34 -0400
X-MC-Unique: _cQ1zen2MdaPl04ZnkXx0w-1
X-Mimecast-MFC-AGG-ID: _cQ1zen2MdaPl04ZnkXx0w_1746778472
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 496BD1955DD0;
	Fri,  9 May 2025 08:14:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4591418003FD;
	Fri,  9 May 2025 08:14:23 +0000 (UTC)
Date: Fri, 9 May 2025 16:14:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 6/8] selftests: ublk: kublk: move per-thread data out
 of ublk_queue
Message-ID: <aB25WYnXBDwPCDFp@fedora>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
 <20250507-ublk_task_per_io-v6-6-a2a298783c01@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-ublk_task_per_io-v6-6-a2a298783c01@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, May 07, 2025 at 03:49:40PM -0600, Uday Shankar wrote:
> Towards the goal of decoupling ublk_queues from ublk server threads,
> move resources/data that should be per-thread rather than per-queue out
> of ublk_queue and into a new struct ublk_thread.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/kublk.c | 225 ++++++++++++++++++-----------------
>  tools/testing/selftests/ublk/kublk.h |  38 ++++--
>  2 files changed, 145 insertions(+), 118 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index 3ad9e162816c3a10e9928f9d530908cda7595530..313689f94cd6361a9a0f4b9257085b2a62bc8b8c 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -324,8 +324,8 @@ static void ublk_ctrl_dump(struct ublk_dev *dev)
>  
>  		for (i = 0; i < info->nr_hw_queues; i++) {
>  			ublk_print_cpu_set(&affinity[i], buf, sizeof(buf));
> -			printf("\tqueue %u: tid %d affinity(%s)\n",
> -					i, dev->q[i].tid, buf);
> +			printf("\tqueue %u: affinity(%s)\n",
> +					i, buf);
>  		}
>  		free(affinity);
>  	}
> @@ -395,18 +395,16 @@ static void ublk_queue_deinit(struct ublk_queue *q)
>  		free(q->ios[i].buf_addr);
>  }
>  
> -static void ublk_thread_deinit(struct ublk_queue *q)
> +static void ublk_thread_deinit(struct ublk_thread *t)
>  {
> -	q->tid = 0;
> +	io_uring_unregister_buffers(&t->ring);
>  
> -	io_uring_unregister_buffers(&q->ring);
> +	io_uring_unregister_ring_fd(&t->ring);
>  
> -	io_uring_unregister_ring_fd(&q->ring);
> -
> -	if (q->ring.ring_fd > 0) {
> -		io_uring_unregister_files(&q->ring);
> -		close(q->ring.ring_fd);
> -		q->ring.ring_fd = -1;
> +	if (t->ring.ring_fd > 0) {
> +		io_uring_unregister_files(&t->ring);
> +		close(t->ring.ring_fd);
> +		t->ring.ring_fd = -1;
>  	}
>  }
>  
> @@ -421,7 +419,6 @@ static int ublk_queue_init(struct ublk_queue *q)
>  	q->tgt_ops = dev->tgt.ops;
>  	q->state = 0;
>  	q->q_depth = depth;
> -	q->cmd_inflight = 0;
>  
>  	if (dev->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY) {
>  		q->state |= UBLKSRV_NO_BUF;
> @@ -443,6 +440,7 @@ static int ublk_queue_init(struct ublk_queue *q)
>  		q->ios[i].buf_addr = NULL;
>  		q->ios[i].flags = UBLKSRV_NEED_FETCH_RQ | UBLKSRV_IO_FREE;
>  		q->ios[i].q = q;
> +		q->ios[i].tag = i;
>  
>  		if (q->state & UBLKSRV_NO_BUF)
>  			continue;
> @@ -463,47 +461,46 @@ static int ublk_queue_init(struct ublk_queue *q)
>  	return -ENOMEM;
>  }
>  
> -static int ublk_thread_init(struct ublk_queue *q)
> +static int ublk_thread_init(struct ublk_thread *t)
>  {
> -	struct ublk_dev *dev = q->dev;
> +	struct ublk_dev *dev = t->dev;
>  	int ring_depth = dev->tgt.sq_depth, cq_depth = dev->tgt.cq_depth;
>  	int ret;
>  
> -	q->tid = gettid();
> -
> -	ret = ublk_setup_ring(&q->ring, ring_depth, cq_depth,
> +	ret = ublk_setup_ring(&t->ring, ring_depth, cq_depth,
>  			IORING_SETUP_COOP_TASKRUN |
>  			IORING_SETUP_SINGLE_ISSUER |
>  			IORING_SETUP_DEFER_TASKRUN);
>  	if (ret < 0) {
> -		ublk_err("ublk dev %d queue %d setup io_uring failed %d\n",
> -				q->dev->dev_info.dev_id, q->q_id, ret);
> +		ublk_err("ublk dev %d thread %d setup io_uring failed %d\n",
> +				dev->dev_info.dev_id, t->idx, ret);
>  		goto fail;
>  	}
>  
>  	if (dev->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY) {
> -		ret = io_uring_register_buffers_sparse(&q->ring, q->q_depth);
> +		ret = io_uring_register_buffers_sparse(
> +			&t->ring, dev->dev_info.queue_depth);
>  		if (ret) {
> -			ublk_err("ublk dev %d queue %d register spare buffers failed %d",
> -					dev->dev_info.dev_id, q->q_id, ret);
> +			ublk_err("ublk dev %d thread %d register spare buffers failed %d",
> +					dev->dev_info.dev_id, t->idx, ret);
>  			goto fail;
>  		}
>  	}
>  
> -	io_uring_register_ring_fd(&q->ring);
> +	io_uring_register_ring_fd(&t->ring);
>  
> -	ret = io_uring_register_files(&q->ring, dev->fds, dev->nr_fds);
> +	ret = io_uring_register_files(&t->ring, dev->fds, dev->nr_fds);
>  	if (ret) {
> -		ublk_err("ublk dev %d queue %d register files failed %d\n",
> -				q->dev->dev_info.dev_id, q->q_id, ret);
> +		ublk_err("ublk dev %d thread %d register files failed %d\n",
> +				t->dev->dev_info.dev_id, t->idx, ret);
>  		goto fail;
>  	}
>  
>  	return 0;
>  fail:
> -	ublk_thread_deinit(q);
> -	ublk_err("ublk dev %d queue %d thread init failed\n",
> -			dev->dev_info.dev_id, q->q_id);
> +	ublk_thread_deinit(t);
> +	ublk_err("ublk dev %d thread %d init failed\n",
> +			dev->dev_info.dev_id, t->idx);
>  	return -ENOMEM;
>  }
>  
> @@ -545,8 +542,9 @@ static void ublk_dev_unprep(struct ublk_dev *dev)
>  	close(dev->fds[0]);
>  }
>  
> -int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
> +int ublk_queue_io_cmd(struct ublk_io *io)
>  {
> +	struct ublk_thread *t = io->t;
>  	struct ublksrv_io_cmd *cmd;
>  	struct io_uring_sqe *sqe[1];
>  	unsigned int cmd_op = 0;
> @@ -571,13 +569,13 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
>  	else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
>  		cmd_op = UBLK_U_IO_FETCH_REQ;
>  
> -	if (io_uring_sq_space_left(&q->ring) < 1)
> -		io_uring_submit(&q->ring);
> +	if (io_uring_sq_space_left(&t->ring) < 1)
> +		io_uring_submit(&t->ring);
>  
> -	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 1);
> +	ublk_io_alloc_sqes(io, sqe, 1);
>  	if (!sqe[0]) {
> -		ublk_err("%s: run out of sqe %d, tag %d\n",
> -				__func__, q->q_id, tag);
> +		ublk_err("%s: run out of sqe. thread %u, tag %d\n",
> +				__func__, t->idx, io->tag);
>  		return -1;
>  	}
>  
> @@ -592,42 +590,51 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct ublk_io *io, unsigned tag)
>  	sqe[0]->opcode	= IORING_OP_URING_CMD;
>  	sqe[0]->flags	= IOSQE_FIXED_FILE;
>  	sqe[0]->rw_flags	= 0;
> -	cmd->tag	= tag;
> -	cmd->q_id	= q->q_id;
> -	if (!(q->state & UBLKSRV_NO_BUF))
> +	cmd->tag	= io->tag;
> +	cmd->q_id	= io->q->q_id;
> +	if (!(io->q->state & UBLKSRV_NO_BUF))
>  		cmd->addr	= (__u64) (uintptr_t) io->buf_addr;
>  	else
>  		cmd->addr	= 0;
>  
> -	user_data = build_user_data(tag, _IOC_NR(cmd_op), 0, q->q_id, 0);
> +	user_data = build_user_data(io->tag, _IOC_NR(cmd_op), 0, io->q->q_id, 0);
>  	io_uring_sqe_set_data64(sqe[0], user_data);
>  
>  	io->flags = 0;
>  
> -	q->cmd_inflight += 1;
> +	t->cmd_inflight += 1;
>  
> -	ublk_dbg(UBLK_DBG_IO_CMD, "%s: (qid %d tag %u cmd_op %u) iof %x stopping %d\n",
> -			__func__, q->q_id, tag, cmd_op,
> -			io->flags, !!(q->state & UBLKSRV_QUEUE_STOPPING));
> +	ublk_dbg(UBLK_DBG_IO_CMD, "%s: (thread %u qid %d tag %u cmd_op %u) iof %x stopping %d\n",
> +			__func__, t->idx, io->q->q_id, io->tag, cmd_op,
> +			io->flags, !!(t->state & UBLKSRV_THREAD_STOPPING));
>  	return 1;
>  }
>  
> -static void ublk_submit_fetch_commands(struct ublk_queue *q)
> +static void ublk_submit_fetch_commands(struct ublk_thread *t)
>  {
> +	/*
> +	 * Service exclusively the queue whose q_id matches our thread
> +	 * index. This may change in the future.
> +	 */
> +	struct ublk_queue *q = &t->dev->q[t->idx];
> +	struct ublk_io *io;
>  	int i = 0;
>  
> -	for (i = 0; i < q->q_depth; i++)
> -		ublk_queue_io_cmd(q, &q->ios[i], i);
> +	for (i = 0; i < q->q_depth; i++) {
> +		io = &q->ios[i];
> +		io->t = t;
> +		ublk_queue_io_cmd(io);
> +	}
>  }
>  
> -static int ublk_queue_is_idle(struct ublk_queue *q)
> +static int ublk_thread_is_idle(struct ublk_thread *t)
>  {
> -	return !io_uring_sq_ready(&q->ring) && !q->io_inflight;
> +	return !io_uring_sq_ready(&t->ring) && !t->io_inflight;
>  }
>  
> -static int ublk_queue_is_done(struct ublk_queue *q)
> +static int ublk_thread_is_done(struct ublk_thread *t)
>  {
> -	return (q->state & UBLKSRV_QUEUE_STOPPING) && ublk_queue_is_idle(q);
> +	return (t->state & UBLKSRV_THREAD_STOPPING) && ublk_thread_is_idle(t);
>  }
>  
>  static inline void ublksrv_handle_tgt_cqe(struct ublk_queue *q,
> @@ -645,15 +652,16 @@ static inline void ublksrv_handle_tgt_cqe(struct ublk_queue *q,
>  		q->tgt_ops->tgt_io_done(q, tag, cqe);
>  }
>  
> -static void ublk_handle_cqe(struct ublk_dev *dev,
> +static void ublk_handle_cqe(struct ublk_thread *t,
>  		struct io_uring_cqe *cqe, void *data)
>  {
> +	struct ublk_dev *dev = t->dev;
>  	unsigned q_id = user_data_to_q_id(cqe->user_data);
>  	struct ublk_queue *q = &dev->q[q_id];
>  	unsigned tag = user_data_to_tag(cqe->user_data);
>  	unsigned cmd_op = user_data_to_op(cqe->user_data);
>  	int fetch = (cqe->res != UBLK_IO_RES_ABORT) &&
> -		!(q->state & UBLKSRV_QUEUE_STOPPING);
> +		!(t->state & UBLKSRV_THREAD_STOPPING);
>  	struct ublk_io *io;
>  
>  	if (cqe->res < 0 && cqe->res != -ENODEV)
> @@ -664,7 +672,7 @@ static void ublk_handle_cqe(struct ublk_dev *dev,
>  			__func__, cqe->res, q->q_id, tag, cmd_op,
>  			is_target_io(cqe->user_data),
>  			user_data_to_tgt_data(cqe->user_data),
> -			(q->state & UBLKSRV_QUEUE_STOPPING));
> +			(t->state & UBLKSRV_THREAD_STOPPING));
>  
>  	/* Don't retrieve io in case of target io */
>  	if (is_target_io(cqe->user_data)) {
> @@ -673,10 +681,10 @@ static void ublk_handle_cqe(struct ublk_dev *dev,
>  	}
>  
>  	io = &q->ios[tag];
> -	q->cmd_inflight--;
> +	t->cmd_inflight--;
>  
>  	if (!fetch) {
> -		q->state |= UBLKSRV_QUEUE_STOPPING;
> +		t->state |= UBLKSRV_THREAD_STOPPING;
>  		io->flags &= ~UBLKSRV_NEED_FETCH_RQ;
>  	}
>  
> @@ -686,7 +694,7 @@ static void ublk_handle_cqe(struct ublk_dev *dev,
>  			q->tgt_ops->queue_io(q, tag);
>  	} else if (cqe->res == UBLK_IO_RES_NEED_GET_DATA) {
>  		io->flags |= UBLKSRV_NEED_GET_DATA | UBLKSRV_IO_FREE;
> -		ublk_queue_io_cmd(q, io, tag);
> +		ublk_queue_io_cmd(io);
>  	} else {
>  		/*
>  		 * COMMIT_REQ will be completed immediately since no fetching
> @@ -700,87 +708,92 @@ static void ublk_handle_cqe(struct ublk_dev *dev,
>  	}
>  }
>  
> -static int ublk_reap_events_uring(struct ublk_queue *q)
> +static int ublk_reap_events_uring(struct ublk_thread *t)
>  {
>  	struct io_uring_cqe *cqe;
>  	unsigned head;
>  	int count = 0;
>  
> -	io_uring_for_each_cqe(&q->ring, head, cqe) {
> -		ublk_handle_cqe(q->dev, cqe, NULL);
> +	io_uring_for_each_cqe(&t->ring, head, cqe) {
> +		ublk_handle_cqe(t, cqe, NULL);
>  		count += 1;
>  	}
> -	io_uring_cq_advance(&q->ring, count);
> +	io_uring_cq_advance(&t->ring, count);
>  
>  	return count;
>  }
>  
> -static int ublk_process_io(struct ublk_queue *q)
> +static int ublk_process_io(struct ublk_thread *t)
>  {
>  	int ret, reapped;
>  
> -	ublk_dbg(UBLK_DBG_QUEUE, "dev%d-q%d: to_submit %d inflight cmd %u stopping %d\n",
> -				q->dev->dev_info.dev_id,
> -				q->q_id, io_uring_sq_ready(&q->ring),
> -				q->cmd_inflight,
> -				(q->state & UBLKSRV_QUEUE_STOPPING));
> +	ublk_dbg(UBLK_DBG_THREAD, "dev%d-t%u: to_submit %d inflight cmd %u stopping %d\n",
> +				t->dev->dev_info.dev_id,
> +				t->idx, io_uring_sq_ready(&t->ring),
> +				t->cmd_inflight,
> +				(t->state & UBLKSRV_THREAD_STOPPING));
>  
> -	if (ublk_queue_is_done(q))
> +	if (ublk_thread_is_done(t))
>  		return -ENODEV;
>  
> -	ret = io_uring_submit_and_wait(&q->ring, 1);
> -	reapped = ublk_reap_events_uring(q);
> +	ret = io_uring_submit_and_wait(&t->ring, 1);
> +	reapped = ublk_reap_events_uring(t);
>  
> -	ublk_dbg(UBLK_DBG_QUEUE, "submit result %d, reapped %d stop %d idle %d\n",
> -			ret, reapped, (q->state & UBLKSRV_QUEUE_STOPPING),
> -			(q->state & UBLKSRV_QUEUE_IDLE));
> +	ublk_dbg(UBLK_DBG_THREAD, "submit result %d, reapped %d stop %d idle %d\n",
> +			ret, reapped, (t->state & UBLKSRV_THREAD_STOPPING),
> +			(t->state & UBLKSRV_THREAD_IDLE));
>  
>  	return reapped;
>  }
>  
> -static void ublk_queue_set_sched_affinity(const struct ublk_queue *q,
> +static void ublk_thread_set_sched_affinity(const struct ublk_thread *t,
>  		cpu_set_t *cpuset)
>  {
>          if (sched_setaffinity(0, sizeof(*cpuset), cpuset) < 0)
> -                ublk_err("ublk dev %u queue %u set affinity failed",
> -                                q->dev->dev_info.dev_id, q->q_id);
> +		ublk_err("ublk dev %u thread %u set affinity failed",
> +				t->dev->dev_info.dev_id, t->idx);
>  }
>  
> -struct ublk_queue_info {
> -	struct ublk_queue 	*q;
> -	sem_t 			*queue_sem;
> +struct ublk_thread_info {
> +	struct ublk_dev 	*dev;
> +	unsigned		idx;
> +	sem_t 			*ready;
>  	cpu_set_t 		*affinity;
>  };
>  
>  static void *ublk_io_handler_fn(void *data)
>  {
> -	struct ublk_queue_info *info = data;
> -	struct ublk_queue *q = info->q;
> -	int dev_id = q->dev->dev_info.dev_id;
> +	struct ublk_thread_info *info = data;
> +	struct ublk_thread *t = &info->dev->threads[info->idx];
> +	int dev_id = info->dev->dev_info.dev_id;
>  	int ret;
>  
> -	ret = ublk_thread_init(q);
> +	t->dev = info->dev;
> +	t->idx = info->idx;
> +
> +	ret = ublk_thread_init(t);
>  	if (ret) {
> -		ublk_err("ublk dev %d queue %d thread init failed\n",
> -				dev_id, q->q_id);
> +		ublk_err("ublk dev %d thread %u init failed\n",
> +				dev_id, t->idx);
>  		return NULL;
>  	}
>  	/* IO perf is sensitive with queue pthread affinity on NUMA machine*/
> -	ublk_queue_set_sched_affinity(q, info->affinity);
> -	sem_post(info->queue_sem);
> +	ublk_thread_set_sched_affinity(t, info->affinity);
> +	sem_post(info->ready);
>  
> -	ublk_dbg(UBLK_DBG_QUEUE, "tid %d: ublk dev %d queue %d started\n",
> -			q->tid, dev_id, q->q_id);
> +	ublk_dbg(UBLK_DBG_THREAD, "tid %d: ublk dev %d thread %u started\n",
> +			gettid(), dev_id, t->idx);
>  
>  	/* submit all io commands to ublk driver */
> -	ublk_submit_fetch_commands(q);
> +	ublk_submit_fetch_commands(t);
>  	do {
> -		if (ublk_process_io(q) < 0)
> +		if (ublk_process_io(t) < 0)
>  			break;
>  	} while (1);
>  
> -	ublk_dbg(UBLK_DBG_QUEUE, "ublk dev %d queue %d exited\n", dev_id, q->q_id);
> -	ublk_thread_deinit(q);
> +	ublk_dbg(UBLK_DBG_THREAD, "tid %d: ublk dev %d thread %d exiting\n",
> +		 gettid(), dev_id, t->idx);
> +	ublk_thread_deinit(t);
>  	return NULL;
>  }
>  
> @@ -823,20 +836,19 @@ static int ublk_send_dev_event(const struct dev_ctx *ctx, struct ublk_dev *dev,
>  static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
>  {
>  	const struct ublksrv_ctrl_dev_info *dinfo = &dev->dev_info;
> -	struct ublk_queue_info *qinfo;
> +	struct ublk_thread_info *tinfo;
>  	cpu_set_t *affinity_buf;
>  	void *thread_ret;
> -	sem_t queue_sem;
> +	sem_t ready;
>  	int ret, i;
>  
>  	ublk_dbg(UBLK_DBG_DEV, "%s enter\n", __func__);
>  
> -	qinfo = (struct ublk_queue_info *)calloc(sizeof(struct ublk_queue_info),
> -			dinfo->nr_hw_queues);
> -	if (!qinfo)
> +	tinfo = calloc(sizeof(struct ublk_thread_info), dinfo->nr_hw_queues);
> +	if (!tinfo)
>  		return -ENOMEM;
>  
> -	sem_init(&queue_sem, 0, 0);
> +	sem_init(&ready, 0, 0);
>  	ret = ublk_dev_prep(ctx, dev);
>  	if (ret)
>  		return ret;
> @@ -856,17 +868,18 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
>  			goto fail;
>  		}
>  
> -		qinfo[i].q = &dev->q[i];
> -		qinfo[i].queue_sem = &queue_sem;
> -		qinfo[i].affinity = &affinity_buf[i];
> -		pthread_create(&dev->q[i].thread, NULL,
> +		tinfo[i].dev = dev;
> +		tinfo[i].idx = i;
> +		tinfo[i].ready = &ready;
> +		tinfo[i].affinity = &affinity_buf[i];
> +		pthread_create(&dev->threads[i].thread, NULL,
>  				ublk_io_handler_fn,
> -				&qinfo[i]);
> +				&tinfo[i]);
>  	}
>  
>  	for (i = 0; i < dinfo->nr_hw_queues; i++)
> -		sem_wait(&queue_sem);
> -	free(qinfo);
> +		sem_wait(&ready);
> +	free(tinfo);
>  	free(affinity_buf);
>  
>  	/* everything is fine now, start us */
> @@ -889,7 +902,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
>  
>  	/* wait until we are terminated */
>  	for (i = 0; i < dinfo->nr_hw_queues; i++)
> -		pthread_join(dev->q[i].thread, &thread_ret);
> +		pthread_join(dev->threads[i].thread, &thread_ret);
>   fail:
>  	for (i = 0; i < dinfo->nr_hw_queues; i++)
>  		ublk_queue_deinit(&dev->q[i]);
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
> index 7c912116606429215af7dbc2a8ce6b40ef89bfbd..9eb2207fcebe96d34488d057c881db262b9767b3 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -51,10 +51,12 @@
>  #define UBLK_IO_MAX_BYTES               (1 << 20)
>  #define UBLK_MAX_QUEUES_SHIFT		5
>  #define UBLK_MAX_QUEUES                 (1 << UBLK_MAX_QUEUES_SHIFT)
> +#define UBLK_MAX_THREADS_SHIFT		5
> +#define UBLK_MAX_THREADS		(1 << UBLK_MAX_THREADS_SHIFT)
>  #define UBLK_QUEUE_DEPTH                1024
>  
>  #define UBLK_DBG_DEV            (1U << 0)
> -#define UBLK_DBG_QUEUE          (1U << 1)
> +#define UBLK_DBG_THREAD         (1U << 1)
>  #define UBLK_DBG_IO_CMD         (1U << 2)
>  #define UBLK_DBG_IO             (1U << 3)
>  #define UBLK_DBG_CTRL_CMD       (1U << 4)
> @@ -62,6 +64,7 @@
>  
>  struct ublk_dev;
>  struct ublk_queue;
> +struct ublk_thread;
>  
>  struct stripe_ctx {
>  	/* stripe */
> @@ -120,6 +123,8 @@ struct ublk_io {
>  	unsigned short refs;		/* used by target code only */
>  
>  	struct ublk_queue *q;
> +	struct ublk_thread *t;

Given you have to take static mapping between queue/tag and thread,
'struct ublk_thread' should have been figured out runtime easily,
then we can save 8 bytes, also avoid memory indirect dereference.

sizeof(struct ublk_io) need to be held in single L1 cacheline.

But it can be one followup.

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming


