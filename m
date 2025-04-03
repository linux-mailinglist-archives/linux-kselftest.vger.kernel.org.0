Return-Path: <linux-kselftest+bounces-30041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BECAA799F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 04:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE1807A539A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 02:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5256D1419A9;
	Thu,  3 Apr 2025 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7FUPlbJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641448828
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743647505; cv=none; b=A7E6YbBaxQ4pEAMDAs7kLNvFbQm+w96gDlfSuL9FjcEh6rw9P4sTyo/dDiOWnIZHeqrcA+GRYl7rg6vhRRYxl5yf+hT7K5QaiRSFB12WO2lVHhptJOMDi6N0hrJIA85KdIojiRNzCItoAH695ZWNYSRw5/E9BNyLRxpnX2bnpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743647505; c=relaxed/simple;
	bh=fLacezKuaH0ETCqgYL6ohJzkXJ7aSaCEeOJhf2gqHQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCN3UnsqoYrTaxwgQcG7VtFc66oQvcQh5ajtzmBgJ3uvRhJVd9soclx1u8RbWF7cSQYr2/2gJtta7Flo1x34dZF10WfWT3u7miU1RqPK0/eZuLuJ4GcJRsf0K14dmulQMvzTmpCOyd+xmhytwgh4IcCNJMtXKVhFowMhkV9fxZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7FUPlbJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743647501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MwDaYqNXooXUQ9qjnsgGZS1LSVLece8/UiALn1kOcjs=;
	b=e7FUPlbJ1GTaCgskc9+a4VYnzHs5+KagQw7Q3/IrG/tUi/IFpo1BqpIW9ssRNI/YXTGGIx
	WoElS9lPFPM1+ROCXFJZ+igqsq/LPMmlFE/qbcBywQIFCvoXIs9Y7a4tgCHzXD8NzenrQo
	YV1k+5k3VwDTn2gZvKEmd1FigDdKD+A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-uU2Xzv0gNES5Zb2ZgdCE5A-1; Wed,
 02 Apr 2025 22:31:36 -0400
X-MC-Unique: uU2Xzv0gNES5Zb2ZgdCE5A-1
X-Mimecast-MFC-AGG-ID: uU2Xzv0gNES5Zb2ZgdCE5A_1743647495
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B42EB1801A06;
	Thu,  3 Apr 2025 02:31:34 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFD7D195DF89;
	Thu,  3 Apr 2025 02:31:29 +0000 (UTC)
Date: Thu, 3 Apr 2025 10:31:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ublk: improve detection and handling of ublk server
 exit
Message-ID: <Z-3y-3k16yaDlRaj@fedora>
References: <20250402-ublk_timeout-v2-1-249bc5523000@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402-ublk_timeout-v2-1-249bc5523000@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Apr 02, 2025 at 01:27:23PM -0600, Uday Shankar wrote:
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
> There are a couple of issues with this approach:
> 
> - It is complex and inelegant to have two methods to detect the same
>   condition
> - The second method detects ublk server exit only after a long delay
>   (~30s, the default timeout assigned by the block layer). This delays
>   the nosrv behavior from kicking in and potential subsequent recovery
>   of the device.
> 
> The second issue is brought to light with the new test_generic_04. It
> fails before this fix:
> 
> selftests: ublk: test_generic_04.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 30.0611 s, 0.0 kB/s
> DEAD
> dd took 31 seconds to exit (>= 5s tolerance)!
> generic_04 : [FAIL]
> 
> Fix this by instead detecting and handling ublk server exit in the
> character file release callback. This has several advantages:
> 
> - This one place can handle both saturated and unsaturated queues. Thus,
>   it replaces both preexisting methods of detecting ublk server exit.
> - It runs quickly on ublk server exit - there is no 30s delay.
> - It starts the process of removing task references in ublk_drv. This is
>   needed if we want to relax restrictions in the driver like letting
>   only one thread serve each queue
> 
> There is also the disadvantage that the character file release callback
> can also be triggered by intentional close of the file, which is a
> significant behavior change. Preexisting ublk servers (libublksrv) are
> dependent on the ability to open/close the file multiple times. To
> address this, only transition to a nosrv state if the file is released
> while the ublk device is live. This allows for programs to open/close
> the file multiple times during setup. It is still a behavior change if a
> ublk server decides to close/reopen the file while the device is LIVE
> (i.e. while it is responsible for serving I/O), but that would be highly
> unusual. This behavior is in line with what is done by FUSE, which is
> very similar to ublk in that a userspace daemon is providing services
> traditionally provided by the kernel.
> 
> With this change in, the new test (and all other selftests, and all
> ublksrv tests) pass:
> 
> selftests: ublk: test_generic_04.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.0376731 s, 0.0 kB/s
> DEAD
> generic_04 : [PASS]
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
> Changes in v2:
> - Leave null ublk selftests target untouched, instead create new
>   fault_inject target for injecting per-I/O delay (Ming Lei)
> - Allow multiple open/close of ublk character device with some
>   restrictions
> - Drop patches which made it in separately at https://lore.kernel.org/r/20250401-ublk_selftests-v1-1-98129c9bc8bb@purestorage.com
> - Consolidate more nosrv logic in ublk character device release, and
>   associated code cleanup
> - Link to v1: https://lore.kernel.org/r/20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com
> ---
>  drivers/block/ublk_drv.c                        | 187 +++++++-----------------
>  tools/testing/selftests/ublk/Makefile           |   4 +-
>  tools/testing/selftests/ublk/fault_inject.c     |  58 ++++++++
>  tools/testing/selftests/ublk/kublk.c            |   6 +-
>  tools/testing/selftests/ublk/kublk.h            |   4 +
>  tools/testing/selftests/ublk/test_generic_04.sh |  43 ++++++
>  6 files changed, 165 insertions(+), 137 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2fd05c1bd30b03343cb6f357f8c08dd92ff47af9..d06f8a9aa23f8b846928247fc9e29002c10a49e3 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -162,7 +162,6 @@ struct ublk_queue {
>  
>  	bool force_abort;
>  	bool timeout;
> -	bool canceling;
>  	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
>  	unsigned short nr_io_ready;	/* how many ios setup */
>  	spinlock_t		cancel_lock;
> @@ -199,8 +198,6 @@ struct ublk_device {
>  	struct completion	completion;
>  	unsigned int		nr_queues_ready;
>  	unsigned int		nr_privileged_daemon;
> -
> -	struct work_struct	nosrv_work;
>  };
>  
>  /* header of ublk_params */
> @@ -209,8 +206,9 @@ struct ublk_params_header {
>  	__u32	types;
>  };
>  
> -static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
> -
> +static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> +static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> +static void __ublk_quiesce_dev(struct ublk_device *ub);
>  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
>  		struct ublk_queue *ubq, int tag, size_t offset);
>  static inline unsigned int ublk_req_build_flags(struct request *req);
> @@ -1314,8 +1312,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> -	unsigned int nr_inflight = 0;
> -	int i;
>  
>  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
>  		if (!ubq->timeout) {
> @@ -1326,26 +1322,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
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
> @@ -1368,9 +1344,6 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq)
>  	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
>  		return BLK_STS_IOERR;
>  
> -	if (unlikely(ubq->canceling))
> -		return BLK_STS_IOERR;
> -
>  	/* fill iod to slot in io cmd buffer */
>  	res = ublk_setup_iod(ubq, rq);
>  	if (unlikely(res != BLK_STS_OK))
> @@ -1391,16 +1364,6 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	if (res != BLK_STS_OK)
>  		return res;
>  
> -	/*
> -	 * ->canceling has to be handled after ->force_abort and ->fail_io
> -	 * is dealt with, otherwise this request may not be failed in case
> -	 * of recovery, and cause hang when deleting disk
> -	 */
> -	if (unlikely(ubq->canceling)) {
> -		__ublk_abort_rq(ubq, rq);
> -		return BLK_STS_OK;
> -	}
> -
>  	ublk_queue_cmd(ubq, rq);
>  	return BLK_STS_OK;
>  }
> @@ -1461,8 +1424,52 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
>  static int ublk_ch_release(struct inode *inode, struct file *filp)
>  {
>  	struct ublk_device *ub = filp->private_data;
> +	int i;
>  
> +	mutex_lock(&ub->mutex);
> +	/*
> +	 * If the device is not live, we will not transition to a nosrv
> +	 * state. This protects against:
> +	 * - accidental poking of the ublk character device
> +	 * - some ublk servers which may open/close the ublk character
> +	 *   device during startup
> +	 */
> +	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> +		goto out;
> +
> +	/*
> +	 * Since we are releasing the ublk character file descriptor, we
> +	 * know that there cannot be any concurrent file-related
> +	 * activity (e.g. uring_cmds or reads/writes). However, I/O
> +	 * might still be getting dispatched. Quiesce that too so that
> +	 * we don't need to worry about anything concurrent
> +	 */
> +	blk_mq_quiesce_queue(ub->ub_disk->queue);
> +
> +	/*
> +	 * Handle any requests outstanding to the ublk server
> +	 */
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +		ublk_abort_queue(ub, ublk_get_queue(ub, i));
> +
> +	/*
> +	 * Transition the device to the nosrv state. What exactly this
> +	 * means depends on the recovery flags
> +	 */
> +	if (ublk_nosrv_should_stop_dev(ub)) {
> +		ublk_stop_dev_unlocked(ub);
> +	} else if (ublk_nosrv_dev_should_queue_io(ub)) {
> +		__ublk_quiesce_dev(ub);
> +	} else {
> +		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
> +		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +			ublk_get_queue(ub, i)->fail_io = true;
> +	}
> +
> +	blk_mq_unquiesce_queue(ub->ub_disk->queue);
> +out:
>  	clear_bit(UB_STATE_OPEN, &ub->state);
> +	mutex_unlock(&ub->mutex);
>  	return 0;
>  }

The above approach looks really nice for aborting inflight ublk requests.

>  
> @@ -1556,57 +1563,6 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>  	}
>  }
>  
> -/* Must be called when queue is frozen */
> -static bool ublk_mark_queue_canceling(struct ublk_queue *ubq)
> -{
> -	bool canceled;
> -
> -	spin_lock(&ubq->cancel_lock);
> -	canceled = ubq->canceling;
> -	if (!canceled)
> -		ubq->canceling = true;
> -	spin_unlock(&ubq->cancel_lock);
> -
> -	return canceled;
> -}
> -
> -static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
> -{
> -	bool was_canceled = ubq->canceling;
> -	struct gendisk *disk;
> -
> -	if (was_canceled)
> -		return false;
> -
> -	spin_lock(&ub->lock);
> -	disk = ub->ub_disk;
> -	if (disk)
> -		get_device(disk_to_dev(disk));
> -	spin_unlock(&ub->lock);
> -
> -	/* Our disk has been dead */
> -	if (!disk)
> -		return false;
> -
> -	/*
> -	 * Now we are serialized with ublk_queue_rq()
> -	 *
> -	 * Make sure that ubq->canceling is set when queue is frozen,
> -	 * because ublk_queue_rq() has to rely on this flag for avoiding to
> -	 * touch completed uring_cmd
> -	 */
> -	blk_mq_quiesce_queue(disk->queue);
> -	was_canceled = ublk_mark_queue_canceling(ubq);
> -	if (!was_canceled) {
> -		/* abort queue is for making forward progress */
> -		ublk_abort_queue(ub, ubq);
> -	}
> -	blk_mq_unquiesce_queue(disk->queue);
> -	put_device(disk_to_dev(disk));
> -
> -	return !was_canceled;
> -}
> -
>  static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
>  		unsigned int issue_flags)
>  {
> @@ -1635,8 +1591,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
>  	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
>  	struct ublk_queue *ubq = pdu->ubq;
>  	struct task_struct *task;
> -	struct ublk_device *ub;
> -	bool need_schedule;
>  	struct ublk_io *io;
>  
>  	if (WARN_ON_ONCE(!ubq))
> @@ -1649,16 +1603,9 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
>  	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
>  		return;
>  
> -	ub = ubq->dev;
> -	need_schedule = ublk_abort_requests(ub, ubq);
> -
>  	io = &ubq->ios[pdu->tag];
>  	WARN_ON_ONCE(io->cmd != cmd);
>  	ublk_cancel_cmd(ubq, io, issue_flags);

Here we cancel any active uring_cmd and don't use ->canceling flag for
fast-fail new coming requests.

But new IO still come, and is dispatched with the canceled uring cmd,
this causes use-after-free on uring_cmd.

> -
> -	if (need_schedule) {
> -		schedule_work(&ub->nosrv_work);
> -	}
>  }
>  
>  static inline bool ublk_queue_ready(struct ublk_queue *ubq)
> @@ -1756,13 +1703,13 @@ static struct gendisk *ublk_detach_disk(struct ublk_device *ub)
>  	return disk;
>  }
>  
> -static void ublk_stop_dev(struct ublk_device *ub)
> +static void ublk_stop_dev_unlocked(struct ublk_device *ub)
> +	__must_hold(&ub->mutex)
>  {
>  	struct gendisk *disk;
>  
> -	mutex_lock(&ub->mutex);
>  	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
> -		goto unlock;
> +		return;
>  	if (ublk_nosrv_dev_should_queue_io(ub)) {
>  		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
>  			__ublk_quiesce_dev(ub);
> @@ -1771,38 +1718,12 @@ static void ublk_stop_dev(struct ublk_device *ub)
>  	del_gendisk(ub->ub_disk);
>  	disk = ublk_detach_disk(ub);
>  	put_disk(disk);
> - unlock:
> -	mutex_unlock(&ub->mutex);
> -	ublk_cancel_dev(ub);
>  }
>  
> -static void ublk_nosrv_work(struct work_struct *work)
> +static void ublk_stop_dev(struct ublk_device *ub)
>  {
> -	struct ublk_device *ub =
> -		container_of(work, struct ublk_device, nosrv_work);
> -	int i;
> -
> -	if (ublk_nosrv_should_stop_dev(ub)) {
> -		ublk_stop_dev(ub);
> -		return;
> -	}
> -
>  	mutex_lock(&ub->mutex);
> -	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> -		goto unlock;
> -
> -	if (ublk_nosrv_dev_should_queue_io(ub)) {
> -		__ublk_quiesce_dev(ub);
> -	} else {
> -		blk_mq_quiesce_queue(ub->ub_disk->queue);
> -		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
> -		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> -			ublk_get_queue(ub, i)->fail_io = true;
> -		}
> -		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> -	}
> -
> - unlock:
> +	ublk_stop_dev_unlocked(ub);
>  	mutex_unlock(&ub->mutex);
>  	ublk_cancel_dev(ub);
>  }
> @@ -2388,7 +2309,6 @@ static void ublk_remove(struct ublk_device *ub)
>  	bool unprivileged;
>  
>  	ublk_stop_dev(ub);
> -	cancel_work_sync(&ub->nosrv_work);
>  	cdev_device_del(&ub->cdev, &ub->cdev_dev);
>  	unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
>  	ublk_put_device(ub);
> @@ -2675,7 +2595,6 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
>  		goto out_unlock;
>  	mutex_init(&ub->mutex);
>  	spin_lock_init(&ub->lock);
> -	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
>  
>  	ret = ublk_alloc_dev_number(ub, header->dev_id);
>  	if (ret < 0)
> @@ -2807,7 +2726,6 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
>  static int ublk_ctrl_stop_dev(struct ublk_device *ub)
>  {
>  	ublk_stop_dev(ub);
> -	cancel_work_sync(&ub->nosrv_work);
>  	return 0;
>  }
>  
> @@ -2927,7 +2845,6 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
>  	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
>  	ubq->ubq_daemon = NULL;
>  	ubq->timeout = false;
> -	ubq->canceling = false;
>  
>  	for (i = 0; i < ubq->q_depth; i++) {
>  		struct ublk_io *io = &ubq->ios[i];
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index c7781efea0f33c02f340f90f547d3a37c1d1b8a0..afee027cccdd1b8f13f1cb9a90a3348cd54b18bc 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -6,6 +6,7 @@ LDLIBS += -lpthread -lm -luring
>  TEST_PROGS := test_generic_01.sh
>  TEST_PROGS += test_generic_02.sh
>  TEST_PROGS += test_generic_03.sh
> +TEST_PROGS += test_generic_04.sh
>  
>  TEST_PROGS += test_null_01.sh
>  TEST_PROGS += test_null_02.sh
> @@ -26,7 +27,8 @@ TEST_GEN_PROGS_EXTENDED = kublk
>  
>  include ../lib.mk
>  
> -$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c
> +$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c \
> +	fault_inject.c
>  
>  check:
>  	shellcheck -x -f gcc *.sh
> diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..e92d01e88e478a23df987ebff2a997212b831d31
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/fault_inject.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Fault injection ublk target. Hack this up however you like for
> + * testing specific behaviors of ublk_drv. Currently is a null target
> + * with a configurable delay before completing each I/O. This delay can
> + * be used to test ublk_drv's handling of I/O outstanding to the ublk
> + * server when it dies.
> + */
> +
> +#include "kublk.h"
> +
> +static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
> +{
> +	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
> +	unsigned long dev_size = 250UL << 30;
> +
> +	dev->tgt.dev_size = dev_size;
> +	dev->tgt.params = (struct ublk_params) {
> +		.types = UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DMA_ALIGN |
> +			UBLK_PARAM_TYPE_SEGMENT,
> +		.basic = {
> +			.logical_bs_shift	= 9,
> +			.physical_bs_shift	= 12,
> +			.io_opt_shift		= 12,
> +			.io_min_shift		= 9,
> +			.max_sectors		= info->max_io_buf_bytes >> 9,
> +			.dev_sectors		= dev_size >> 9,
> +		},
> +		.dma = {
> +			.alignment		= 4095,
> +		},
> +		.seg = {
> +			.seg_boundary_mask	= 4095,
> +			.max_segment_size	= 32 << 10,
> +			.max_segments		= 32,
> +		},

`dma` and 'seg' parameter looks not necessary for this fault-inject target.

> +	};
> +
> +	dev->private_data = (void *)ctx->delay_us;
> +	return 0;
> +}
> +
> +static int ublk_fault_inject_queue_io(struct ublk_queue *q, int tag)
> +{
> +	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
> +
> +	usleep((unsigned long)q->dev->private_data);

The usleep should be replaced with async io_uring timeout, otherwise
it block the whole thread, and the delay is actually accumulated for
every IO.

> +
> +	ublk_complete_io(q, tag, iod->nr_sectors << 9);
> +	return 0;
> +}
> +
> +const struct ublk_tgt_ops fault_inject_tgt_ops = {
> +	.name = "fault_inject",
> +	.init_tgt = ublk_fault_inject_tgt_init,
> +	.queue_io = ublk_fault_inject_queue_io,
> +};
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index 91c282bc767449a418cce7fc816dc8e9fc732d6a..0fbfa43864453471219703451271540d5dfef593 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -10,6 +10,7 @@ static const struct ublk_tgt_ops *tgt_ops_list[] = {
>  	&null_tgt_ops,
>  	&loop_tgt_ops,
>  	&stripe_tgt_ops,
> +	&fault_inject_tgt_ops,
>  };
>  
>  static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
> @@ -1041,7 +1042,7 @@ static int cmd_dev_get_features(void)
>  
>  static int cmd_dev_help(char *exe)
>  {
> -	printf("%s add -t [null|loop] [-q nr_queues] [-d depth] [-n dev_id] [backfile1] [backfile2] ...\n", exe);
> +	printf("%s add -t [null|loop|stripe|fault_inject] [-q nr_queues] [-d depth] [-n dev_id] [backfile1] [backfile2] ...\n", exe);

'delay_us' is missed.

We could support per-target command line handling in future, but definitely not a
blocker for this patch.

In short, it is one really nice simplification if the use-after-free on
uring_cmd is addressed.


Thanks,
Ming


