Return-Path: <linux-kselftest+bounces-29804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DA9A71032
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 06:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1579172413
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 05:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732FA17A58F;
	Wed, 26 Mar 2025 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcCjUKN8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F8CA6F
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 05:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742967534; cv=none; b=J5KtSiwfNHXn9fSM0PeQNPj2YzeE6RV3345UhvJ1hy+8wM5EVlDigkQcSXQZSHcRb6QB9VAQXdW75Gq+pw2ugkugmAbrOGIZS1kMc5mM5wkLbStpqpKcbR6OJHqNqvUk9khZGZL7LCeBVkZ6rczrQsVbg6Gyy4/J9fizWUjwgsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742967534; c=relaxed/simple;
	bh=DxoLpaqbqZ4kdhe9+xNl3DCD85BJxqzhmkvnX2inMsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGpOC1vW3yxQeaaGRdcVVsSFI/b8MvGjBOClwEMnCICkG7yrR6TF1kXUKL1aoZgno9+CLerDtvH8PIXGheJlvP3WdgBc9wwl4v7406KyUESKb+CXthMHHGlkxB7MiUO/zL9k9hawB4BfMBJKfeivxotk3kWt3nnIOOQe4IGce0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcCjUKN8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742967531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gr16xAxVKTK8eEubHhDUKuB0xsseNvLaJMvC1Rs5EPg=;
	b=TcCjUKN8GE7p0f2rDJ42jLbgqrxoMG7/oSwUuQ3QYAHWoBAiTT09q8tF/U0XNnOtT31wi0
	tj7a+w3lFnPqF3Dt920pPheyU+4VOrrEXSNhiSK9yyTtGEqMKJH85ku5p4gaBZFytbsylD
	mhYAm1LFkKTaa6M0Dm78K8FAIE0H040=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-uaY4AsPGPoqNAfHT9SCyqw-1; Wed,
 26 Mar 2025 01:38:47 -0400
X-MC-Unique: uaY4AsPGPoqNAfHT9SCyqw-1
X-Mimecast-MFC-AGG-ID: uaY4AsPGPoqNAfHT9SCyqw_1742967526
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F845180034D;
	Wed, 26 Mar 2025 05:38:46 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5090619541A6;
	Wed, 26 Mar 2025 05:38:40 +0000 (UTC)
Date: Wed, 26 Mar 2025 13:38:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z-OS2_J7o0NKHWmj@fedora>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Mar 25, 2025 at 04:19:34PM -0600, Uday Shankar wrote:
> There are currently two ways in which ublk server exit is detected by
> ublk_drv:
> 
> 1. uring_cmd cancellation. If there are any outstanding uring_cmds which
>    have not been completed to the ublk server when it exits, io_uring
>    calls the uring_cmd callback with a special cancellation flag as the
>    issuing task is exiting.
> 2. I/O timeout. This is needed in addition to the above to handle the
>    "saturated queue" case, when all I/Os for a given queue are in the
>    ublk server, and therefore there are no outstanding uring_cmds to
>    cancel when the ublk server exits.
> 
> The second method detects ublk server exit only after a long delay
> (~30s, the default timeout assigned by the block layer). Any
> applications using the ublk device will be left hanging for these 30s
> before seeing an error/knowing anything went wrong. This problem is
> illustrated by running the new test_generic_02 against a ublk_drv which
> doesn't have the fix:
> 
> selftests: ublk: test_generic_02.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 30.0611 s, 0.0 kB/s
> DEAD
> dd took 31 seconds to exit (>= 5s tolerance)!
> generic_02 : [FAIL]
> 
> Fix this by instead handling the saturated queue case in the ublk
> character file release callback. This happens during ublk server exit
> and handles the issue much more quickly than an I/O timeout:

Another solution is to override default 30sec 'timeout'.

> 
> selftests: ublk: test_generic_02.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.0376731 s, 0.0 kB/s
> DEAD
> generic_02 : [PASS]
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  drivers/block/ublk_drv.c                        | 40 +++++++++++------------
>  tools/testing/selftests/ublk/Makefile           |  1 +
>  tools/testing/selftests/ublk/kublk.c            |  3 ++
>  tools/testing/selftests/ublk/kublk.h            |  3 ++
>  tools/testing/selftests/ublk/null.c             |  4 +++
>  tools/testing/selftests/ublk/test_generic_02.sh | 43 +++++++++++++++++++++++++
>  6 files changed, 72 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c060da409ed8a888b7e414c9065efd2cbd6d57d7..1816b2cac01056dc9d01455759594af43c5f78d6 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1247,8 +1247,6 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> -	unsigned int nr_inflight = 0;
> -	int i;
>  
>  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
>  		if (!ubq->timeout) {
> @@ -1259,26 +1257,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  		return BLK_EH_DONE;
>  	}
>  
> -	if (!ubq_daemon_is_dying(ubq))
> -		return BLK_EH_RESET_TIMER;
> -
> -	for (i = 0; i < ubq->q_depth; i++) {
> -		struct ublk_io *io = &ubq->ios[i];
> -
> -		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
> -			nr_inflight++;
> -	}
> -
> -	/* cancelable uring_cmd can't help us if all commands are in-flight */
> -	if (nr_inflight == ubq->q_depth) {
> -		struct ublk_device *ub = ubq->dev;
> -
> -		if (ublk_abort_requests(ub, ubq)) {
> -			schedule_work(&ub->nosrv_work);
> -		}
> -		return BLK_EH_DONE;
> -	}
> -
>  	return BLK_EH_RESET_TIMER;
>  }
>  
> @@ -1351,6 +1329,24 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
>  static int ublk_ch_release(struct inode *inode, struct file *filp)
>  {
>  	struct ublk_device *ub = filp->private_data;
> +	bool need_schedule = false;
> +	int i;
> +
> +	/*
> +	 * Error out any requests outstanding to the ublk server. This
> +	 * may have happened already (via uring_cmd cancellation), in
> +	 * which case it is not harmful to repeat. But uring_cmd
> +	 * cancellation does not handle queues which are fully saturated
> +	 * (all requests in ublk server), because from the kernel's POV,
> +	 * there are no outstanding uring_cmds to cancel. This code
> +	 * handles such queues.
> +	 */
> +
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +		need_schedule |= ublk_abort_requests(ub, ublk_get_queue(ub, i));
> +
> +	if (need_schedule)
> +		schedule_work(&ub->nosrv_work);

ublk_abort_requests() should be called only in case of queue dying,
since ublk server may open & close the char device multiple times.

For understanding if queue is dying, ->ubq_damon need to be checked,
however it may not be set yet and the current context is not same with
the ubq_daemon context, so I feel it is a bit fragile to bring queue
reference into ->release() callback.

Many libublksrv tests are failed with this patch or kernel panic, even
with the above check added:

        make test T=generic
>  
>  	clear_bit(UB_STATE_OPEN, &ub->state);
>  	return 0;
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index 7817afe290053853ce31d28a8f4bbca570c3046c..dcc514b6d8f6e485597320636ab111a17b7e5448 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -4,6 +4,7 @@ CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)
>  LDLIBS += -lpthread -lm -luring
>  
>  TEST_PROGS := test_generic_01.sh
> +TEST_PROGS := test_generic_02.sh
>  
>  TEST_PROGS += test_null_01.sh
>  TEST_PROGS += test_null_02.sh
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index 064a5bb6f12f35892065b8dfacb6f57f6fc16aee..e883cd0f9e330eb15da5a00f6085343333a9355d 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -1065,6 +1065,7 @@ int main(int argc, char *argv[])
>  		{ "zero_copy",          0,      NULL, 'z' },
>  		{ "foreground",		0,	NULL,  0  },
>  		{ "chunk_size", 	1,	NULL,  0  },
> +		{ "delay_us",		1,	NULL,  0  },
>  		{ 0, 0, 0, 0 }
>  	};
>  	int option_idx, opt;
> @@ -1113,6 +1114,8 @@ int main(int argc, char *argv[])
>  				ctx.fg = 1;
>  			if (!strcmp(longopts[option_idx].name, "chunk_size"))
>  				ctx.chunk_size = strtol(optarg, NULL, 10);
> +			if (!strcmp(longopts[option_idx].name, "delay_us"))
> +				ctx.delay_us = strtoul(optarg, NULL, 10);
>  		}
>  	}
>  
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
> index f31a5c4d4143e28f13d4cd98d611e37f93b0c25a..6414d482ea3986a9d1973f04a1832d6fe16231bf 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -67,6 +67,9 @@ struct dev_ctx {
>  	unsigned int	all:1;
>  	unsigned int	fg:1;
>  
> +	/* null */
> +	unsigned long	delay_us;
> +
>  	/* stripe */
>  	unsigned int    chunk_size;
>  
> diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
> index 899875ff50feadbd734fbbf1f8fad1f19abd1e8f..8bf58e540f1bffc8361450484a6dc484e815378c 100644
> --- a/tools/testing/selftests/ublk/null.c
> +++ b/tools/testing/selftests/ublk/null.c
> @@ -30,6 +30,8 @@ static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
>  
>  	if (info->flags & UBLK_F_SUPPORT_ZERO_COPY)
>  		dev->tgt.sq_depth = dev->tgt.cq_depth = 2 * info->queue_depth;
> +
> +	dev->private_data = (void *)ctx->delay_us;
>  	return 0;
>  }
>  
> @@ -88,6 +90,8 @@ static int ublk_null_queue_io(struct ublk_queue *q, int tag)
>  	int zc = ublk_queue_use_zc(q);
>  	int queued;
>  
> +	usleep((unsigned long)q->dev->private_data);

We usually use ublk/null for evaluating communication cost and benchmark,
so it isn't good to add more stuff in the io path.

I'd suggest to add one 'delay' target which can be useful in future for
simulating any kind of delay behavior for test purpose at least, and
io_uring IORING_TIMEOUT can be used here.


Thanks, 
Ming


