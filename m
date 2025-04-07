Return-Path: <linux-kselftest+bounces-30278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E70A7ED2B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BDE17171A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B978222562;
	Mon,  7 Apr 2025 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D+6mOkbB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DD183CB0
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053400; cv=none; b=GOyf4+t3wcMPcUt0nlgD/UsplypvPAKdxgVqjFSkvslRrt199fGwfY7xvMI8Vf50gtmbOSYkuRdhEqfwezqxWvaqHLgKXOziygxwepo8oOjOBHRs6LixwQm0w7w6WQGnd79O3cI2Xfg0bftMFmzaAWymNC84jPyDaXLzhjVqdFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053400; c=relaxed/simple;
	bh=jY2Jpd11jcvdDInmM044QbaXxmP7Xos8IFT3u2JvVZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBp2Oy961vHSseK1Ge0wTkXoQ9HSsIhsfbOF7c5DSiUW5PEs8kxmIr6ct83IyiksiP8OZLG8AINDNMRx033hWfGIpZr9yXoDgEBcv01KASpEww7lZ7qKxhahp34VHyvfrsTpcCjkMr+RabK75xWtKZrzAc0zpivLKng9HWZmRgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D+6mOkbB; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso74684116d6.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Apr 2025 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744053397; x=1744658197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9DeShEzAF15A7h3elAoOuHtSB63WfEr7n2IOVCSLbQ=;
        b=D+6mOkbBjFUKfUxu08C+7rthQdf0fsnMQ3YLW5g65cxrvFewIB1tZ1JzfPBmOITz3n
         wska/M7n2C/12tUOnd7ImQzzs5nsGqRDzA/s6wPG68VBGtFCQqn557UqnQ5xbmTIGRSK
         BlC4OaM8KRFnxF/VBtpuLQFoajw5nnmONjwIegqCRLWbbVNwIhhc2s28t21BflErt6kQ
         9vOLqYbKcEa4KJO6i2mqARE22m+PN02SrzQvJ6+3iI6j/45ohfrvo88+eSghvfeuWxH6
         mCFGi1nYRlBQF8l2fNSpJABa377w6sbcKDEbbUJT8ooj1xbYgZahh4dbbZl5j3T2YdDJ
         Z9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744053397; x=1744658197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9DeShEzAF15A7h3elAoOuHtSB63WfEr7n2IOVCSLbQ=;
        b=Po9SbwZXTewohRoa0MCGOGfM6Ua51mNZLiO9g+o9sZS7oqn1cxn2oTXUDyb+jwEfr4
         xTqvFGY6kUh7AbY+Ta7TiGAkiK/bLF/YX1FcApebf0k8kDJSMX4qjnafBScMBMW1PWe6
         SeIKr8kK+bPVK7K9ljDIceI6CtSwBSXbiVQ2+Su/0+iqOPzx8FQm2nzRMxmAlTdMw+O4
         1Ae6ILIJWUAoSFz7V1QuDk5uUC0EqSIIRbWELvXKMArIvyBrrnKyNSo6bQgu6i59/Mtg
         U1ZkvYo59FtnLZNlZwKPiaoTjAbYdybTtgKWYs7nrCg+yCiSXNSwXcIB/rQwEl42NP5w
         u8yw==
X-Forwarded-Encrypted: i=1; AJvYcCWsI5WMEPj9T+dt9ElclAYXSGwbfuRy89tX4MrazNbYUuCpAYNkn/h0kbkZjZiBQWLXeMC31dgSYCYwXYln32c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGU1W9cZkkxAUS8aYKRqVDjqN09ro3gnOrJn7mR6GquMqEgqHq
	JD9u65+c5eO4Vc5oP1CAPLGxCJxZ4XJO6kOdgywnILaCuLav3aIrZuOZW9SvOL3F/0ZtprsfWUJ
	1ZLLIJez7PcBES4KhHOCmAGTRS6u/WmxD
X-Gm-Gg: ASbGncsA2siEDkIkJPKmh4o53Bg9oB4krA4U3+VBvXA3LdNGQZI917at40YP4uX/50/
	A7xYfZ8rwWk2U/7c4kxNej+0V+lf+YuKZm/z31mbWqCOwTjUrtfS6af8f/Kl13uRX3eu5E/Lrw9
	aFQCjWQYgR/5nnpQprs7P50cBDdrLkqPe/jxvgPfOItOG6igEZqH5/Ay531sIJs0fLfUmOo7SsZ
	as8UZobNMNCKjEQP8SBjMfzL/dEIU40aLpW3yoU9KJTKn3iRtwqfT2rjeWoSyzMsHWz3zyzzYDO
	ltI4p41xMbK8jHdl9TSBMnDYGHmRJTCQwA6zTKgx1+u01p2ULg==
X-Google-Smtp-Source: AGHT+IEw+cDFq7qfjt6YMbE/RbUbZqe3oMfICqCCsazV7UgcYGsDVX5CAGAaCw0isAWWJ5UG47VSddgPqcW+
X-Received: by 2002:a05:6214:404:b0:6e8:fee2:aae4 with SMTP id 6a1803df08f44-6f01e769f7cmr214502116d6.28.1744053396742;
        Mon, 07 Apr 2025 12:16:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6ef0f14b0e1sm7785776d6.60.2025.04.07.12.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:16:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 002603407A8;
	Mon,  7 Apr 2025 13:16:34 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E932AE402F2; Mon,  7 Apr 2025 13:16:33 -0600 (MDT)
Date: Mon, 7 Apr 2025 13:16:33 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ublk: improve detection and handling of ublk server
 exit
Message-ID: <Z/QkkTRHfRxtN/mB@dev-ushankar.dev.purestorage.com>
References: <20250403-ublk_timeout-v3-1-aa09f76c7451@purestorage.com>
 <Z_FFUXINspN8G0y0@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_FFUXINspN8G0y0@fedora>

On Sat, Apr 05, 2025 at 10:59:29PM +0800, Ming Lei wrote:
> On Thu, Apr 03, 2025 at 06:05:57PM -0600, Uday Shankar wrote:
> > There are currently two ways in which ublk server exit is detected by
> > ublk_drv:
> > 
> > 1. uring_cmd cancellation. If there are any outstanding uring_cmds which
> >    have not been completed to the ublk server when it exits, io_uring
> >    calls the uring_cmd callback with a special cancellation flag as the
> >    issuing task is exiting.
> > 2. I/O timeout. This is needed in addition to the above to handle the
> >    "saturated queue" case, when all I/Os for a given queue are in the
> >    ublk server, and therefore there are no outstanding uring_cmds to
> >    cancel when the ublk server exits.
> > 
> > There are a couple of issues with this approach:
> > 
> > - It is complex and inelegant to have two methods to detect the same
> >   condition
> > - The second method detects ublk server exit only after a long delay
> >   (~30s, the default timeout assigned by the block layer). This delays
> >   the nosrv behavior from kicking in and potential subsequent recovery
> >   of the device.
> > 
> > The second issue is brought to light with the new test_generic_04. It
> > fails before this fix:
> > 
> > selftests: ublk: test_generic_04.sh
> > dev id is 0
> > dd: error writing '/dev/ublkb0': Input/output error
> > 1+0 records in
> > 0+0 records out
> > 0 bytes copied, 30.0611 s, 0.0 kB/s
> > DEAD
> > dd took 31 seconds to exit (>= 5s tolerance)!
> > generic_04 : [FAIL]
> > 
> > Fix this by instead detecting and handling ublk server exit in the
> > character file release callback. This has several advantages:
> > 
> > - This one place can handle both saturated and unsaturated queues. Thus,
> >   it replaces both preexisting methods of detecting ublk server exit.
> > - It runs quickly on ublk server exit - there is no 30s delay.
> > - It starts the process of removing task references in ublk_drv. This is
> >   needed if we want to relax restrictions in the driver like letting
> >   only one thread serve each queue
> > 
> > There is also the disadvantage that the character file release callback
> > can also be triggered by intentional close of the file, which is a
> > significant behavior change. Preexisting ublk servers (libublksrv) are
> > dependent on the ability to open/close the file multiple times. To
> > address this, only transition to a nosrv state if the file is released
> > while the ublk device is live. This allows for programs to open/close
> > the file multiple times during setup. It is still a behavior change if a
> > ublk server decides to close/reopen the file while the device is LIVE
> > (i.e. while it is responsible for serving I/O), but that would be highly
> > unusual. This behavior is in line with what is done by FUSE, which is
> > very similar to ublk in that a userspace daemon is providing services
> > traditionally provided by the kernel.
> > 
> > With this change in, the new test (and all other selftests, and all
> > ublksrv tests) pass:
> > 
> > selftests: ublk: test_generic_04.sh
> > dev id is 0
> > dd: error writing '/dev/ublkb0': Input/output error
> > 1+0 records in
> > 0+0 records out
> > 0 bytes copied, 0.0376731 s, 0.0 kB/s
> > DEAD
> > generic_04 : [PASS]
> > 
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > ---
> > Changes in v3:
> > - Quiesce queue earlier to avoid concurrent cancellation and "normal"
> >   completion of io_uring cmds (Ming Lei)
> > - Fix del_gendisk hang, found by test_stress_02
> > - Remove unnecessary parameters in fault_inject target (Ming Lei)
> > - Fix delay implementation to have separate per-I/O delay instead of
> >   blocking the whole thread (Ming Lei)
> > - Add delay_us to docs
> > - Link to v2: https://lore.kernel.org/r/20250402-ublk_timeout-v2-1-249bc5523000@purestorage.com
> > 
> > Changes in v2:
> > - Leave null ublk selftests target untouched, instead create new
> >   fault_inject target for injecting per-I/O delay (Ming Lei)
> > - Allow multiple open/close of ublk character device with some
> >   restrictions
> > - Drop patches which made it in separately at https://lore.kernel.org/r/20250401-ublk_selftests-v1-1-98129c9bc8bb@purestorage.com
> > - Consolidate more nosrv logic in ublk character device release, and
> >   associated code cleanup
> > - Link to v1: https://lore.kernel.org/r/20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com
> > ---
> >  drivers/block/ublk_drv.c                        | 228 +++++++++---------------
> >  tools/testing/selftests/ublk/Makefile           |   4 +-
> >  tools/testing/selftests/ublk/fault_inject.c     |  72 ++++++++
> >  tools/testing/selftests/ublk/kublk.c            |   6 +-
> >  tools/testing/selftests/ublk/kublk.h            |   4 +
> >  tools/testing/selftests/ublk/test_generic_04.sh |  43 +++++
> >  6 files changed, 215 insertions(+), 142 deletions(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 2fd05c1bd30b03343cb6f357f8c08dd92ff47af9..73baa9d22ccafb00723defa755a0b3aab7238934 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -162,7 +162,6 @@ struct ublk_queue {
> >  
> >  	bool force_abort;
> >  	bool timeout;
> > -	bool canceling;
> >  	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
> >  	unsigned short nr_io_ready;	/* how many ios setup */
> >  	spinlock_t		cancel_lock;
> > @@ -199,8 +198,6 @@ struct ublk_device {
> >  	struct completion	completion;
> >  	unsigned int		nr_queues_ready;
> >  	unsigned int		nr_privileged_daemon;
> > -
> > -	struct work_struct	nosrv_work;
> >  };
> >  
> >  /* header of ublk_params */
> > @@ -209,8 +206,9 @@ struct ublk_params_header {
> >  	__u32	types;
> >  };
> >  
> > -static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
> > -
> > +static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> > +static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> > +static void __ublk_quiesce_dev(struct ublk_device *ub);
> >  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
> >  		struct ublk_queue *ubq, int tag, size_t offset);
> >  static inline unsigned int ublk_req_build_flags(struct request *req);
> > @@ -1314,8 +1312,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
> >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  {
> >  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > -	unsigned int nr_inflight = 0;
> > -	int i;
> >  
> >  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> >  		if (!ubq->timeout) {
> > @@ -1326,26 +1322,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  		return BLK_EH_DONE;
> >  	}
> >  
> > -	if (!ubq_daemon_is_dying(ubq))
> > -		return BLK_EH_RESET_TIMER;
> > -
> > -	for (i = 0; i < ubq->q_depth; i++) {
> > -		struct ublk_io *io = &ubq->ios[i];
> > -
> > -		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
> > -			nr_inflight++;
> > -	}
> > -
> > -	/* cancelable uring_cmd can't help us if all commands are in-flight */
> > -	if (nr_inflight == ubq->q_depth) {
> > -		struct ublk_device *ub = ubq->dev;
> > -
> > -		if (ublk_abort_requests(ub, ubq)) {
> > -			schedule_work(&ub->nosrv_work);
> > -		}
> > -		return BLK_EH_DONE;
> > -	}
> > -
> >  	return BLK_EH_RESET_TIMER;
> >  }
> >  
> > @@ -1356,19 +1332,16 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq)
> >  	if (unlikely(ubq->fail_io))
> >  		return BLK_STS_TARGET;
> >  
> > -	/* With recovery feature enabled, force_abort is set in
> > -	 * ublk_stop_dev() before calling del_gendisk(). We have to
> > -	 * abort all requeued and new rqs here to let del_gendisk()
> > -	 * move on. Besides, we cannot not call io_uring_cmd_complete_in_task()
> > -	 * to avoid UAF on io_uring ctx.
> > +	/*
> > +	 * force_abort is set in ublk_stop_dev() before calling
> > +	 * del_gendisk(). We have to abort all requeued and new rqs here
> > +	 * to let del_gendisk() move on. Besides, we cannot not call
> > +	 * io_uring_cmd_complete_in_task() to avoid UAF on io_uring ctx.
> >  	 *
> >  	 * Note: force_abort is guaranteed to be seen because it is set
> >  	 * before request queue is unqiuesced.
> >  	 */
> > -	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
> > -		return BLK_STS_IOERR;
> > -
> > -	if (unlikely(ubq->canceling))
> > +	if (unlikely(ubq->force_abort))
> >  		return BLK_STS_IOERR;
> >  
> >  	/* fill iod to slot in io cmd buffer */
> > @@ -1391,16 +1364,6 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  	if (res != BLK_STS_OK)
> >  		return res;
> >  
> > -	/*
> > -	 * ->canceling has to be handled after ->force_abort and ->fail_io
> > -	 * is dealt with, otherwise this request may not be failed in case
> > -	 * of recovery, and cause hang when deleting disk
> > -	 */
> > -	if (unlikely(ubq->canceling)) {
> > -		__ublk_abort_rq(ubq, rq);
> > -		return BLK_STS_OK;
> > -	}
> > -
> 
> If `ubq->canceling` is removed, how to handle recovery? The request has to
> be requeued in case of ublk_nosrv_dev_should_queue_io().

In the typical case, requests issued after the ublk server dies with
recovery enabled queue because the request_queue is quiesced. This is
the same way things worked before this patch. There is an edge case in
ublk_dispatch_req where we will manually requeue any request that made
it to task_work but I assume that is not what you are talking about
here.

The above test you are highlighting looks like dead code anyways. We
already test ubq->canceling and fail the I/O if it is set in
ublk_prep_req, so we cannot possibly enter the if statement above.

> 
> And that should be the reason why 'make test T=generic/004' hangs forever
> after applying this patch.

I am not able to reproduce the hang even after increasing LOOPS to 100
for more repetitions. Can you ensure you have the most recent version of
the patch? I fixed a similar hang between v2-v3.

> 
> >  	ublk_queue_cmd(ubq, rq);
> >  	return BLK_STS_OK;
> >  }
> > @@ -1461,8 +1424,71 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
> >  static int ublk_ch_release(struct inode *inode, struct file *filp)
> >  {
> >  	struct ublk_device *ub = filp->private_data;
> > +	int i;
> > +
> > +	mutex_lock(&ub->mutex);
> > +	/*
> > +	 * If the device is not live, we will not transition to a nosrv
> > +	 * state. This protects against:
> > +	 * - accidental poking of the ublk character device
> > +	 * - some ublk servers which may open/close the ublk character
> > +	 *   device during startup
> > +	 */
> > +	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> > +		goto out;
> > +
> > +	/*
> > +	 * Since we are releasing the ublk character file descriptor, we
> > +	 * know that there cannot be any concurrent file-related
> > +	 * activity (e.g. uring_cmds or reads/writes). However, I/O
> > +	 * might still be getting dispatched. Quiesce that too so that
> > +	 * we don't need to worry about anything concurrent.
> > +	 *
> > +	 * We may have already quiesced the queue if we canceled any
> > +	 * uring_cmds, so only quiesce if necessary (quiesce is not
> > +	 * idempotent, it has an internal counter which we need to
> > +	 * manage carefully).
> > +	 */
> > +	if (!blk_queue_quiesced(ub->ub_disk->queue))
> > +		blk_mq_quiesce_queue(ub->ub_disk->queue);
> > +
> > +	/*
> > +	 * Handle any requests outstanding to the ublk server
> > +	 */
> > +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> > +		ublk_abort_queue(ub, ublk_get_queue(ub, i));
> >  
> > +	/*
> > +	 * Transition the device to the nosrv state. What exactly this
> > +	 * means depends on the recovery flags
> > +	 */
> > +	if (ublk_nosrv_should_stop_dev(ub)) {
> > +		/*
> > +		 * Allow any pending/future I/O to pass through quickly
> > +		 * with an error. This is needed because del_gendisk
> > +		 * waits for all pending I/O to complete
> > +		 */
> > +		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> > +			ublk_get_queue(ub, i)->force_abort = true;
> > +		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> > +
> > +		ublk_stop_dev_unlocked(ub);
> > +	} else {
> > +		if (ublk_nosrv_dev_should_queue_io(ub)) {
> > +			__ublk_quiesce_dev(ub);
> 
> Here only inflight IOs are drained, new IO still comes after queue is
> unquiesced, then uring_cmd UAF is triggered.

No, I don't think so. There are three cases here, dependent on recovery
flags:

- no recovery flags: in this case, force_abort is set before queue is
  unquiesced, so I/Os will be errored before we try to access the
  io_uring_cmd
- just RECOVERY: queue is not actually unquiesced here at all, because
  there are two quiesce (one above, one inside __ublk_quiesce_dev), and
  only one unquiesce
- RECOVERY|FAIL_IO: similar to no recovery flags case, except we are
  setting fail_io instead of force_abort. The two flags are very similar
  and we should consolidate in a follow-up patch

In all cases we are protected against using already canceled
io_uring_cmds.

> > --- /dev/null
> > +++ b/tools/testing/selftests/ublk/test_generic_04.sh
> > @@ -0,0 +1,43 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > +
> > +TID="generic_04"
> > +ERR_CODE=0
> > +
> > +_prep_test "fault_inject" "fast cleanup when all I/Os of one hctx are in server"
> > +
> > +# configure ublk server to sleep 2s before completing each I/O
> > +dev_id=$(_add_ublk_dev -t fault_inject -q 2 -d 1 --delay_us 2000000)
> > +_check_add_dev $TID $?
> > +
> > +echo "dev id is ${dev_id}"
> > +
> > +STARTTIME=${SECONDS}
> > +
> > +dd if=/dev/urandom of=/dev/ublkb${dev_id} oflag=direct bs=4k count=1 &
> 
> stdout/stderr need to be discarded.
> 
> Also I'd suggest to make the selftest part as one standalone patch.

Sounds good, that is a nice way to split up this large patch.


