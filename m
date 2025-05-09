Return-Path: <linux-kselftest+bounces-32738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9FAB0D25
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 10:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A491F502FF3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 08:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505922741C2;
	Fri,  9 May 2025 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y54H9TvO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43587269AE3
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746779517; cv=none; b=aVvI2HBNyXnl1pDlm7579S3UwC26wzafAqPNm7D2oqeuQHEODLq8Zfbc1CnUpeJVoxYwftV0kQgtH+pqMkc1smz2+waXvUm+qZ6o9dAYDZ//3GqUVWuXx3kIdRClthuHHMbeObqDFn41kVPIFdn3OOSI7Jy4bdcCW6bS8zDqfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746779517; c=relaxed/simple;
	bh=9lQZozOT//ZQ/czf66UkcCEnEqMNT17DHsbR/6BKiCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STxgcxW0HRSU9/6Ssj0H1MwmXrcdIUZ54BsjoD/13PISv3KR7gjxLSbTydDuc4JYzhifpcqtzG6FMJXrEvwJNTFj9WC/77XN+kWqIeczS4gMKhQ8/zCBCAKmTPnlh83LdNcajQH5Vms8d4iFkcbZ6+W3fmyXhioiH/z6WBqq8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y54H9TvO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746779513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mxQK0cexvFnlqB7R/upvH/pd3k+8Oz9YpLbSOHmnD6g=;
	b=Y54H9TvOmadXmvOTg+dYHe91+ozZUfAvwUsPsy4yduglyeQShZu7WcACZP27VTwbdBF0p6
	IYsTVarjjvVDoKOEDtxIx6xBR+CKkRP6pxKvcc0XemgdDGfnQ4qNvijLSw1ilm4dLjHj5N
	aqo+/kn9KiPl2cocH/xhZFV2SEZO3z8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-OxVlxgQBMmyiGSCjS0-IVw-1; Fri,
 09 May 2025 04:31:49 -0400
X-MC-Unique: OxVlxgQBMmyiGSCjS0-IVw-1
X-Mimecast-MFC-AGG-ID: OxVlxgQBMmyiGSCjS0-IVw_1746779508
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D115C1800446;
	Fri,  9 May 2025 08:31:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B33EC1953B85;
	Fri,  9 May 2025 08:31:41 +0000 (UTC)
Date: Fri, 9 May 2025 16:31:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 7/8] selftests: ublk: kublk: decouple ublk_queues from
 ublk server threads
Message-ID: <aB29Y6OTjESOPVlc@fedora>
References: <20250507-ublk_task_per_io-v6-0-a2a298783c01@purestorage.com>
 <20250507-ublk_task_per_io-v6-7-a2a298783c01@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-ublk_task_per_io-v6-7-a2a298783c01@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, May 07, 2025 at 03:49:41PM -0600, Uday Shankar wrote:
> Add support in kublk for decoupled ublk_queues and ublk server threads.
> kublk now has two modes of operation:
> 
> - (preexisting mode) threads and queues are paired 1:1, and each thread
>   services all the I/Os of one queue
> - (new mode) thread and queue counts are independently configurable.
>   threads service I/Os in a way that balances load across threads even
>   if load is not balanced over queues. requires passing --round_robin
> 
> The new mode of operation is exercised by the new test_generic_08, which
> issues I/O against a single queue and verifies that each of the 8 ublk
> server threads handles exactly 1/8 of the total I/O count. Under the old
> mode of operation (i.e. without --round_robin), all I/O goes to one ublk
> server thread, and the test fails.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/Makefile              |  1 +
>  tools/testing/selftests/ublk/file_backed.c         |  4 +-
>  tools/testing/selftests/ublk/kublk.c               | 96 ++++++++++++++++++----
>  tools/testing/selftests/ublk/kublk.h               |  3 +
>  tools/testing/selftests/ublk/null.c                |  4 +-
>  tools/testing/selftests/ublk/stripe.c              |  4 +-
>  tools/testing/selftests/ublk/test_generic_08.sh    | 61 ++++++++++++++
>  .../selftests/ublk/trace/count_ios_per_tid.bt      |  9 ++
>  8 files changed, 160 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index e2e7b1e52a06252f626df5606221d17e3106d0d3..f8579019f0d1f9185df098440611c3b75087073b 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -14,6 +14,7 @@ TEST_PROGS += test_generic_04.sh
>  TEST_PROGS += test_generic_05.sh
>  TEST_PROGS += test_generic_06.sh
>  TEST_PROGS += test_generic_07.sh
> +TEST_PROGS += test_generic_08.sh
>  
>  TEST_PROGS += test_null_01.sh
>  TEST_PROGS += test_null_02.sh
> diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
> index 563f11a21604bbf5b9531f69f806d09cdd785960..72e22f54f7fe60d26096ace4eb4001987fbe7b15 100644
> --- a/tools/testing/selftests/ublk/file_backed.c
> +++ b/tools/testing/selftests/ublk/file_backed.c
> @@ -50,7 +50,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
>  
>  	ublk_io_alloc_sqes(ublk_get_io(q, tag), sqe, 3);
>  
> -	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, tag);
> +	io_uring_prep_buf_register(sqe[0], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);

->buf_index can be calculated runtime by adding helper of ublk_io_buf_idx(io), so
the extra field can be avoided, CPU is fast than memory.

>  	sqe[0]->flags |= IOSQE_CQE_SKIP_SUCCESS | IOSQE_IO_HARDLINK;
>  	sqe[0]->user_data = build_user_data(tag,
>  			ublk_cmd_op_nr(sqe[0]->cmd_op), 0, q->q_id, 1);
> @@ -62,7 +62,7 @@ static int loop_queue_tgt_rw_io(struct ublk_queue *q, const struct ublksrv_io_de
>  	sqe[1]->flags |= IOSQE_FIXED_FILE | IOSQE_IO_HARDLINK;
>  	sqe[1]->user_data = build_user_data(tag, ublk_op, 0, q->q_id, 1);
>  
> -	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, tag);
> +	io_uring_prep_buf_unregister(sqe[2], 0, tag, q->q_id, ublk_get_io(q, tag)->buf_index);
>  	sqe[2]->user_data = build_user_data(tag, ublk_cmd_op_nr(sqe[2]->cmd_op), 0, q->q_id, 1);
>  
>  	return 2;
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index 313689f94cd6361a9a0f4b9257085b2a62bc8b8c..27046bb6a13b99879ad164ff8eaabeba57e17387 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -478,8 +478,11 @@ static int ublk_thread_init(struct ublk_thread *t)
>  	}
>  
>  	if (dev->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY) {
> +		unsigned nr_ios = dev->dev_info.queue_depth * dev->dev_info.nr_hw_queues;
> +		unsigned max_nr_ios_per_thread = nr_ios / dev->nthreads;
> +		max_nr_ios_per_thread += !!(nr_ios % dev->nthreads);
>  		ret = io_uring_register_buffers_sparse(
> -			&t->ring, dev->dev_info.queue_depth);
> +			&t->ring, max_nr_ios_per_thread);
>  		if (ret) {
>  			ublk_err("ublk dev %d thread %d register spare buffers failed %d",
>  					dev->dev_info.dev_id, t->idx, ret);
> @@ -612,18 +615,42 @@ int ublk_queue_io_cmd(struct ublk_io *io)
>  
>  static void ublk_submit_fetch_commands(struct ublk_thread *t)
>  {
> -	/*
> -	 * Service exclusively the queue whose q_id matches our thread
> -	 * index. This may change in the future.
> -	 */
> -	struct ublk_queue *q = &t->dev->q[t->idx];
> +	struct ublk_queue *q;
>  	struct ublk_io *io;
> -	int i = 0;
> +	int i = 0, j = 0;
>  
> -	for (i = 0; i < q->q_depth; i++) {
> -		io = &q->ios[i];
> -		io->t = t;
> -		ublk_queue_io_cmd(io);
> +	if (t->dev->dev_info.flags & UBLK_F_RR_TAGS) {

You shouldn't depend on the generic feature of UBLK_F_RR_TAGS, which can be
used for non-io-task too.

Here you need one helper of ublk_use_io_task(), or sort of flags.

> +		/*
> +		 * Lexicographically order all the (qid,tag) pairs, with
> +		 * qid taking priority, and give this thread every Nth
> +		 * entry, where N is the total number of threads. The
> +		 * offset is controlled by the thread index. This takes
> +		 * load which may be imbalanced across the queues and
> +		 * balances it across the threads.
> +		 */
> +		const struct ublksrv_ctrl_dev_info *dinfo = &t->dev->dev_info;
> +		int nr_ios = dinfo->nr_hw_queues * dinfo->queue_depth;
> +		for (i = t->idx; i < nr_ios; i += t->dev->nthreads, j++) {
> +			int q_id = i / dinfo->queue_depth;
> +			int tag = i % dinfo->queue_depth;

I understand UBLK_F_RR_TAGS means that IO with adjacent tag should be
handled locally, but the above actually does the opposite, only IOs with
non-adjacent tags are handled in same pthread, can you explain a bit
why UBLK_F_RR_TAGS helps for this way?

> +			q = &t->dev->q[q_id];
> +			io = &q->ios[tag];
> +			io->t = t;
> +			io->buf_index = j;
> +			ublk_queue_io_cmd(io);
> +		}
> +	} else {
> +		/*
> +		 * Service exclusively the queue whose q_id matches our
> +		 * thread index.
> +		 */
> +		struct ublk_queue *q = &t->dev->q[t->idx];
> +		for (i = 0; i < q->q_depth; i++) {
> +			io = &q->ios[i];
> +			io->t = t;
> +			io->buf_index = i;
> +			ublk_queue_io_cmd(io);
> +		}
>  	}
>  }
>  
> @@ -778,7 +805,8 @@ static void *ublk_io_handler_fn(void *data)
>  		return NULL;
>  	}
>  	/* IO perf is sensitive with queue pthread affinity on NUMA machine*/
> -	ublk_thread_set_sched_affinity(t, info->affinity);
> +	if (info->affinity)
> +		ublk_thread_set_sched_affinity(t, info->affinity);
>  	sem_post(info->ready);
>  
>  	ublk_dbg(UBLK_DBG_THREAD, "tid %d: ublk dev %d thread %u started\n",
> @@ -844,7 +872,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
>  
>  	ublk_dbg(UBLK_DBG_DEV, "%s enter\n", __func__);
>  
> -	tinfo = calloc(sizeof(struct ublk_thread_info), dinfo->nr_hw_queues);
> +	tinfo = calloc(sizeof(struct ublk_thread_info), dev->nthreads);
>  	if (!tinfo)
>  		return -ENOMEM;
>  
> @@ -867,17 +895,24 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
>  				 dinfo->dev_id, i);
>  			goto fail;
>  		}
> +	}
>  
> +	for (i = 0; i < dev->nthreads; i++) {
>  		tinfo[i].dev = dev;
>  		tinfo[i].idx = i;
>  		tinfo[i].ready = &ready;
> -		tinfo[i].affinity = &affinity_buf[i];
> +		/*
> +		 * If threads are not tied to queues, setting thread
> +		 * affinity based on queue affinity makes no sense.
> +		 */
> +		if (!(dinfo->flags & UBLK_F_RR_TAGS))
> +			tinfo[i].affinity = &affinity_buf[i];
>  		pthread_create(&dev->threads[i].thread, NULL,
>  				ublk_io_handler_fn,
>  				&tinfo[i]);
>  	}
>  
> -	for (i = 0; i < dinfo->nr_hw_queues; i++)
> +	for (i = 0; i < dev->nthreads; i++)
>  		sem_wait(&ready);
>  	free(tinfo);
>  	free(affinity_buf);
> @@ -901,7 +936,7 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
>  		ublk_send_dev_event(ctx, dev, dev->dev_info.dev_id);
>  
>  	/* wait until we are terminated */
> -	for (i = 0; i < dinfo->nr_hw_queues; i++)
> +	for (i = 0; i < dev->nthreads; i++)
>  		pthread_join(dev->threads[i].thread, &thread_ret);
>   fail:
>  	for (i = 0; i < dinfo->nr_hw_queues; i++)
> @@ -1011,6 +1046,7 @@ static int ublk_stop_io_daemon(const struct ublk_dev *dev)
>  
>  static int __cmd_dev_add(const struct dev_ctx *ctx)
>  {
> +	unsigned nthreads = ctx->nthreads;
>  	unsigned nr_queues = ctx->nr_hw_queues;
>  	const char *tgt_type = ctx->tgt_type;
>  	unsigned depth = ctx->queue_depth;
> @@ -1034,6 +1070,23 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
>  		return -EINVAL;
>  	}
>  
> +	/* default to 1:1 threads:queues if nthreads is unspecified */
> +	if (nthreads == -1)
> +		nthreads = nr_queues;

Maybe we can start 1:1 for nrthreads == 0, which looks more readable,
and you needn't to set -1 default.

> +
> +	if (nthreads > UBLK_MAX_THREADS) {
> +		ublk_err("%s: %u is too many threads (max %u)\n",
> +				__func__, nthreads, UBLK_MAX_THREADS);
> +		return -EINVAL;
> +	}
> +
> +	if (nthreads != nr_queues && !(ctx->flags & UBLK_F_RR_TAGS)) {
> +		ublk_err("%s: threads %u must be same as queues %u if "
> +			"not using round robin\n",
> +			__func__, nthreads, nr_queues);
> +		return -EINVAL;
> +	}
> +
>  	dev = ublk_ctrl_init();
>  	if (!dev) {
>  		ublk_err("%s: can't alloc dev id %d, type %s\n",
> @@ -1054,6 +1107,7 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
>  	info->nr_hw_queues = nr_queues;
>  	info->queue_depth = depth;
>  	info->flags = ctx->flags;
> +	dev->nthreads = nthreads;
>  	dev->tgt.ops = ops;
>  	dev->tgt.sq_depth = depth;
>  	dev->tgt.cq_depth = depth;
> @@ -1249,6 +1303,7 @@ static int cmd_dev_get_features(void)
>  		[const_ilog2(UBLK_F_USER_COPY)] = "USER_COPY",
>  		[const_ilog2(UBLK_F_ZONED)] = "ZONED",
>  		[const_ilog2(UBLK_F_USER_RECOVERY_FAIL_IO)] = "RECOVERY_FAIL_IO",
> +		[const_ilog2(UBLK_F_RR_TAGS)] = "RR_TAGS",
>  	};
>  	struct ublk_dev *dev;
>  	__u64 features = 0;
> @@ -1290,8 +1345,10 @@ static void __cmd_create_help(char *exe, bool recovery)
>  			exe, recovery ? "recover" : "add");
>  	printf("\t[--foreground] [--quiet] [-z] [--debug_mask mask] [-r 0|1 ] [-g]\n");
>  	printf("\t[-e 0|1 ] [-i 0|1]\n");
> +	printf("\t[--nthreads threads] [--round_robin]\n");
>  	printf("\t[target options] [backfile1] [backfile2] ...\n");
>  	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
> +	printf("\tdefault: nthreads=nr_queues");
>  
>  	for (i = 0; i < sizeof(tgt_ops_list) / sizeof(tgt_ops_list[0]); i++) {
>  		const struct ublk_tgt_ops *ops = tgt_ops_list[i];
> @@ -1343,6 +1400,8 @@ int main(int argc, char *argv[])
>  		{ "recovery_fail_io",	1,	NULL, 'e'},
>  		{ "recovery_reissue",	1,	NULL, 'i'},
>  		{ "get_data",		1,	NULL, 'g'},
> +		{ "nthreads",		1,	NULL,  0 },
> +		{ "round_robin",	0,	NULL,  0 },
>  		{ 0, 0, 0, 0 }
>  	};
>  	const struct ublk_tgt_ops *ops = NULL;
> @@ -1351,6 +1410,7 @@ int main(int argc, char *argv[])
>  	struct dev_ctx ctx = {
>  		.queue_depth	=	128,
>  		.nr_hw_queues	=	2,
> +		.nthreads	=	-1,
>  		.dev_id		=	-1,
>  		.tgt_type	=	"unknown",
>  	};
> @@ -1411,6 +1471,10 @@ int main(int argc, char *argv[])
>  				ublk_dbg_mask = 0;
>  			if (!strcmp(longopts[option_idx].name, "foreground"))
>  				ctx.fg = 1;
> +			if (!strcmp(longopts[option_idx].name, "nthreads"))
> +				ctx.nthreads = strtol(optarg, NULL, 10);
> +			if (!strcmp(longopts[option_idx].name, "round_robin"))
> +				ctx.flags |= UBLK_F_RR_TAGS;

maybe `--io_task` is more readable, and you can always enable UBLK_F_RR_TAGS
for this '--io_task' ublk server feature.


Thanks, 
Ming


