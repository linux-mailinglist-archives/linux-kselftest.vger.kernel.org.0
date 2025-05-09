Return-Path: <linux-kselftest+bounces-32724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C31AB08E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 05:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C239883B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 03:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770AB238D52;
	Fri,  9 May 2025 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cn4/m/Bd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54219CC02
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746761396; cv=none; b=JTvWFvV+wcgrdQxHz4xbwDBiY9OcuRYgizUgBa0LQEy2xESkMKrNuMYQlwvx7pRk+0SAaTkRDzz6XLwLBLb2G1e5ItKvDuiBBCx8HQaRaOZHPr2m/IFfp7VBKS3Ahnb3XoDv9bPP7HhfGfeVRxErmFtbqenQTZD4NmCAyhr0054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746761396; c=relaxed/simple;
	bh=S1yi6rnhNlMVa5dLotn8dcdofZ1p332V+ifvPLisQj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh9yAhcGGmj1+Y9JvW+fp/S+9DHseMsO5fJz3DRS0niINkPKXaUpmopANia+CqJ4P1kERWVIZo0sqb9X4wN2imglPXLHikeZILEbP11k/zt8xafp5UVmUy+/TzTt0cgelTNZMHmfS26Zzeh5pTt8d+RVXjsHZnm8qbnqRtLArl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cn4/m/Bd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746761393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aX5g4T/ui8zYWG/CR78eBjg3zZKc3gVFjYjjZQSVWQc=;
	b=Cn4/m/BdAy4Gjba3tqQR2few+GUy5g24NvPvzpY/EfSbRiS9kAJD3fGmbdH+RMkFm2ctmh
	71Z6MnU0kOTrFQaLimecvudNa3emHTdoY59+YRfr7Jb73H7304Q3dO9WMYWT2h+FR1tFbr
	Mv1JOXd8A8Bt7qL+OG+aTF2WOqcymLM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-wz6MvrzNP5OeqswktbK8zQ-1; Thu,
 08 May 2025 23:29:49 -0400
X-MC-Unique: wz6MvrzNP5OeqswktbK8zQ-1
X-Mimecast-MFC-AGG-ID: wz6MvrzNP5OeqswktbK8zQ_1746761388
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79D1219560AE;
	Fri,  9 May 2025 03:29:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.120])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CBA219560AE;
	Fri,  9 May 2025 03:29:40 +0000 (UTC)
Date: Fri, 9 May 2025 11:29:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 1/8] ublk: have a per-io daemon instead of a per-queue
 daemon
Message-ID: <aB12n00oLKp2Db6p@fedora>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
 <20250507-ublk_task_per_io-v6-1-a2a298783c01@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-ublk_task_per_io-v6-1-a2a298783c01@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, May 07, 2025 at 03:49:35PM -0600, Uday Shankar wrote:
> Currently, ublk_drv associates to each hardware queue (hctx) a unique
> task (called the queue's ubq_daemon) which is allowed to issue
> COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> to do so, the command fails immediately with EINVAL. When considered
> together with the block layer architecture, the result is that for each
> CPU C on the system, there is a unique ublk server thread which is
> allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> performance under imbalanced load generation. For an extreme example,
> suppose all the load is generated on CPUs mapping to a single ublk
> server thread. Then that thread may be fully utilized and become the
> bottleneck in the system, while other ublk server threads are totally
> idle.
> 
> This issue can also be addressed directly in the ublk server without
> kernel support by having threads dequeue I/Os and pass them around to
> ensure even load. But this solution requires inter-thread communication
> at least twice for each I/O (submission and completion), which is
> generally a bad pattern for performance. The problem gets even worse
> with zero copy, as more inter-thread communication would be required to
> have the buffer register/unregister calls to come from the correct
> thread.
> 
> Therefore, address this issue in ublk_drv by allowing each I/O to have
> its own daemon task. Two I/Os in the same queue are now allowed to be
> serviced by different daemon tasks - this was not possible before.
> Imbalanced load can then be balanced across all ublk server threads as
> follows:
> 
> - specifying the new UBLK_F_RR_TAGS flag when creating the ublk device,
>   to ensure round-robin tag allocation
> - having the ublk server threads issue FETCH_REQs in a round-robin
>   manner. As a small toy example, consider a system with a single ublk
>   device having 2 queues, each of depth 4. A ublk server having 4
>   threads could issue its FETCH_REQs against this device as follows
>   (where each entry is the qid,tag pair that the FETCH_REQ targets):
> 
>   ublk server thread:	T0	T1	T2	T3
> 			0,0	0,1	0,2	0,3
> 			1,3	1,0	1,1	1,2
> 
> The combination of these two changes allow a ublk server to balance
> load. For example, suppose a program quickly issues 4 I/Os concurrently.
> Before this change, all 4 I/Os would have had to be serviced by the same
> thread, and that thread may become a bottleneck. With this change, those
> 4 I/Os would get tags 0-3 for the same queue, and would thus spread out
> evenly over all the ublk server threads. Peak bandwidth in CPU-limited
> workloads under imbalanced load thus will increase.
> 
> The UBLK_F_RR_TAGS flag is also added as a feature, so that ublk servers
> can essentially test for the presence of this patch and tailor their
> behavior accordingly.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c      | 82 ++++++++++++++++++++++---------------------
>  include/uapi/linux/ublk_cmd.h |  8 +++++
>  2 files changed, 50 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index cb612151e9a1de7630c49a2b78d278e005d52856..ff5beab32220ea96a1e15ab26c02f4883a6c3d6e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -66,7 +66,8 @@
>  		| UBLK_F_USER_COPY \
>  		| UBLK_F_ZONED \
>  		| UBLK_F_USER_RECOVERY_FAIL_IO \
> -		| UBLK_F_UPDATE_SIZE)
> +		| UBLK_F_UPDATE_SIZE \
> +		| UBLK_F_RR_TAGS)
>  
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>  		| UBLK_F_USER_RECOVERY_REISSUE \
> @@ -148,6 +149,8 @@ struct ublk_io {
>  		/* valid if UBLK_IO_FLAG_OWNED_BY_SRV is set */
>  		struct request *req;
>  	};
> +
> +	struct task_struct *task;
>  };
>  
>  struct ublk_queue {
> @@ -155,11 +158,9 @@ struct ublk_queue {
>  	int q_depth;
>  
>  	unsigned long flags;
> -	struct task_struct	*ubq_daemon;
>  	struct ublksrv_io_desc *io_cmd_buf;
>  
>  	bool force_abort;
> -	bool timeout;
>  	bool canceling;
>  	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
>  	unsigned short nr_io_ready;	/* how many ios setup */
> @@ -1069,11 +1070,6 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
>  	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
>  }
>  
> -static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
> -{
> -	return !ubq->ubq_daemon || ubq->ubq_daemon->flags & PF_EXITING;
> -}
> -
>  /* todo: handle partial completion */
>  static inline void __ublk_complete_rq(struct request *req)
>  {
> @@ -1207,13 +1203,13 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
>  	/*
>  	 * Task is exiting if either:
>  	 *
> -	 * (1) current != ubq_daemon.
> +	 * (1) current != io->task.
>  	 * io_uring_cmd_complete_in_task() tries to run task_work
> -	 * in a workqueue if ubq_daemon(cmd's task) is PF_EXITING.
> +	 * in a workqueue if cmd's task is PF_EXITING.
>  	 *
>  	 * (2) current->flags & PF_EXITING.
>  	 */
> -	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
> +	if (unlikely(current != io->task || current->flags & PF_EXITING)) {
>  		__ublk_abort_rq(ubq, req);
>  		return;
>  	}
> @@ -1286,13 +1282,10 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> +	struct ublk_io *io = &ubq->ios[rq->tag];
>  
>  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> -		if (!ubq->timeout) {
> -			send_sig(SIGKILL, ubq->ubq_daemon, 0);
> -			ubq->timeout = true;
> -		}
> -
> +		send_sig(SIGKILL, io->task, 0);
>  		return BLK_EH_DONE;
>  	}
>  
> @@ -1405,17 +1398,6 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
>  	/* All old ioucmds have to be completed */
>  	ubq->nr_io_ready = 0;
>  
> -	/*
> -	 * old daemon is PF_EXITING, put it now
> -	 *
> -	 * It could be NULL in case of closing one quisced device.
> -	 */
> -	if (ubq->ubq_daemon)
> -		put_task_struct(ubq->ubq_daemon);
> -	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
> -	ubq->ubq_daemon = NULL;
> -	ubq->timeout = false;
> -
>  	for (i = 0; i < ubq->q_depth; i++) {
>  		struct ublk_io *io = &ubq->ios[i];
>  
> @@ -1426,6 +1408,17 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
>  		io->flags &= UBLK_IO_FLAG_CANCELED;
>  		io->cmd = NULL;
>  		io->addr = 0;
> +
> +		/*
> +		 * old task is PF_EXITING, put it now
> +		 *
> +		 * It could be NULL in case of closing one quiesced
> +		 * device.
> +		 */
> +		if (io->task) {
> +			put_task_struct(io->task);
> +			io->task = NULL;
> +		}
>  	}
>  }
>  
> @@ -1447,7 +1440,7 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
>  	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
>  		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
>  
> -	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
> +	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
>  	ub->mm = NULL;
>  	ub->nr_queues_ready = 0;
>  	ub->nr_privileged_daemon = 0;
> @@ -1722,7 +1715,7 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
>  		return;
>  
>  	task = io_uring_cmd_get_task(cmd);
> -	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
> +	if (WARN_ON_ONCE(task && task != ubq->ios[pdu->tag].task))
>  		return;
>  
>  	if (!ubq->canceling)
> @@ -1861,8 +1854,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  {
>  	ubq->nr_io_ready++;
>  	if (ublk_queue_ready(ubq)) {
> -		ubq->ubq_daemon = current;
> -		get_task_struct(ubq->ubq_daemon);
>  		ub->nr_queues_ready++;
>  
>  		if (capable(CAP_SYS_ADMIN))
> @@ -1995,6 +1986,7 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
>  	}
>  
>  	ublk_fill_io_cmd(io, cmd, buf_addr);
> +	WRITE_ONCE(io->task, get_task_struct(current));
>  	ublk_mark_io_ready(ub, ubq);
>  out:
>  	mutex_unlock(&ub->mutex);
> @@ -2062,6 +2054,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  			       const struct ublksrv_io_cmd *ub_cmd)
>  {
>  	struct ublk_device *ub = cmd->file->private_data;
> +	struct task_struct *task;
>  	struct ublk_queue *ubq;
>  	struct ublk_io *io;
>  	u32 cmd_op = cmd->cmd_op;
> @@ -2076,13 +2069,14 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  		goto out;
>  
>  	ubq = ublk_get_queue(ub, ub_cmd->q_id);
> -	if (ubq->ubq_daemon && ubq->ubq_daemon != current)
> -		goto out;
>  
>  	if (tag >= ubq->q_depth)
>  		goto out;
>  
>  	io = &ubq->ios[tag];
> +	task = READ_ONCE(io->task);
> +	if (task && task != current)
> +		goto out;
>  
>  	/* there is pending io cmd, something must be wrong */
>  	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
> @@ -2332,9 +2326,15 @@ static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
>  {
>  	int size = ublk_queue_cmd_buf_size(ub, q_id);
>  	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
> +	struct ublk_io *io;
> +	int i;
> +
> +	for (i = 0; i < ubq->q_depth; i++) {
> +		io = &ubq->ios[i];
> +		if (io->task)
> +			put_task_struct(io->task);
> +	}
>  
> -	if (ubq->ubq_daemon)
> -		put_task_struct(ubq->ubq_daemon);
>  	if (ubq->io_cmd_buf)
>  		free_pages((unsigned long)ubq->io_cmd_buf, get_order(size));
>  }
> @@ -2487,6 +2487,8 @@ static int ublk_add_tag_set(struct ublk_device *ub)
>  	ub->tag_set.numa_node = NUMA_NO_NODE;
>  	ub->tag_set.cmd_size = sizeof(struct ublk_rq_data);
>  	ub->tag_set.driver_data = ub;
> +	if (ub->dev_info.flags & UBLK_F_RR_TAGS)
> +		ub->tag_set.flags |= BLK_MQ_F_TAG_RR;
>  	return blk_mq_alloc_tag_set(&ub->tag_set);
>  }
>  
> @@ -3062,14 +3064,14 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
>  	int ublksrv_pid = (int)header->data[0];
>  	int ret = -EINVAL;
>  
> -	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
> -			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
> -	/* wait until new ubq_daemon sending all FETCH_REQ */
> +	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
> +		 header->dev_id);
> +
>  	if (wait_for_completion_interruptible(&ub->completion))
>  		return -EINTR;
>  
> -	pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n",
> -			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
> +	pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
> +		 header->dev_id);
>  
>  	mutex_lock(&ub->mutex);
>  	if (ublk_nosrv_should_stop_dev(ub))
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> index be5c6c6b16e098838a2bf790e588b79656defdda..3ba8f26d60bc70ade95b4f4d5990157af2bd5b2e 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -219,6 +219,14 @@
>   */
>  #define UBLK_F_UPDATE_SIZE		 (1ULL << 10)
>  
> +/*
> + * Force tags to be allocated round-robin on each queue. If ublk server
> + * threads also issue FETCH_REQs against the queues in a round-robin
> + * manner, load can be balanced across all threads even if it is issued
> + * to the queues in an imbalanced way.
> + */
> +#define UBLK_F_RR_TAGS (1ULL << 11)

Please make UBLK_F_RR_TAGS as one standalone patch, which is also helpful
for evaluating round-robin performance, and doesn't have to be used by
per-io task.

Thanks,
Ming


