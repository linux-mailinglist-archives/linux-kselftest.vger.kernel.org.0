Return-Path: <linux-kselftest+bounces-29846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F8A7280E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 02:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BBF188667C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 01:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A31B35959;
	Thu, 27 Mar 2025 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTrZflFb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C1D528
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Mar 2025 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743038620; cv=none; b=MoSbevFdAqKFMxqdkbqN5gPCPiJ3IsOzDzXJfUL1aT3UJSdxVB2XxFfQiHDiGwPFjNcTNUlXWG0o+zpvOFjAhJ80eeulY/9lf2EqKmL7f6Z0pWcdAIPBW+WP1yXxoHXJ+JwLlM/g1dM0HZLxNXUKPrSc80M/UjgzAN2UgSHkdMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743038620; c=relaxed/simple;
	bh=VbDuCviSyn2+FMz/uQocVuEzCrumYKtb2Jv266ekAHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFY9DjsayqVXJ4GjtbtHzs77qrOJLe9vfXTPUacCdbtGPhZpP9uq1V9FeRXP5hoamgSx71+cVbHIQOrKuwhQIeseQY11pr27OhkwRCoMfkb0PrZkFTrCrOMhyoXl0DZcmGDVHQTl44sJ8XiAlGs6e+kQfQmNhJDM/Nl6mqy8oqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTrZflFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743038617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SRmBC+T0tFuM74bqrj1Echv7uq9vZ+375RhEm+MV7cc=;
	b=PTrZflFb986SKqNiOuCRwzhcL6SfQqpTGHhKdoHjmbeVBYNi8PntirYZKH0eLiCIdLuUkG
	zaxCTwii3Z10QBP1AYohEuM2j9i5ip+F4E28MKUEojwHoILEgU2bUOYWTS0PKltbYUuImc
	ud+ohdNHAN3tSKGVU6mwsl+l3yja7HY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-SOLYfYIoO2WXXJAIrp4wew-1; Wed,
 26 Mar 2025 21:23:33 -0400
X-MC-Unique: SOLYfYIoO2WXXJAIrp4wew-1
X-Mimecast-MFC-AGG-ID: SOLYfYIoO2WXXJAIrp4wew_1743038612
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CBF21956067;
	Thu, 27 Mar 2025 01:23:32 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0AD2C180B487;
	Thu, 27 Mar 2025 01:23:26 +0000 (UTC)
Date: Thu, 27 Mar 2025 09:23:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z-SoibOdOmzOWB-C@fedora>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
 <Z-OS2_J7o0NKHWmj@fedora>
 <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Mar 26, 2025 at 11:54:16AM -0600, Uday Shankar wrote:
> On Wed, Mar 26, 2025 at 01:38:35PM +0800, Ming Lei wrote:
> > On Tue, Mar 25, 2025 at 04:19:34PM -0600, Uday Shankar wrote:
> > > There are currently two ways in which ublk server exit is detected by
> > > ublk_drv:
> > > 
> > > 1. uring_cmd cancellation. If there are any outstanding uring_cmds which
> > >    have not been completed to the ublk server when it exits, io_uring
> > >    calls the uring_cmd callback with a special cancellation flag as the
> > >    issuing task is exiting.
> > > 2. I/O timeout. This is needed in addition to the above to handle the
> > >    "saturated queue" case, when all I/Os for a given queue are in the
> > >    ublk server, and therefore there are no outstanding uring_cmds to
> > >    cancel when the ublk server exits.
> > > 
> > > The second method detects ublk server exit only after a long delay
> > > (~30s, the default timeout assigned by the block layer). Any
> > > applications using the ublk device will be left hanging for these 30s
> > > before seeing an error/knowing anything went wrong. This problem is
> > > illustrated by running the new test_generic_02 against a ublk_drv which
> > > doesn't have the fix:
> > > 
> > > selftests: ublk: test_generic_02.sh
> > > dev id is 0
> > > dd: error writing '/dev/ublkb0': Input/output error
> > > 1+0 records in
> > > 0+0 records out
> > > 0 bytes copied, 30.0611 s, 0.0 kB/s
> > > DEAD
> > > dd took 31 seconds to exit (>= 5s tolerance)!
> > > generic_02 : [FAIL]
> > > 
> > > Fix this by instead handling the saturated queue case in the ublk
> > > character file release callback. This happens during ublk server exit
> > > and handles the issue much more quickly than an I/O timeout:
> > 
> > Another solution is to override default 30sec 'timeout'.
> 
> Yes, but that still will introduce unnecessary delays, since it is a
> polling-based solution (very similar to monitor_work we used to have).
> Also it will add complexity to the unprivileged case, since that
> actually cares about timeout and we will have to track the "real"
> timeout separately.
> 
> > 
> > > 
> > > selftests: ublk: test_generic_02.sh
> > > dev id is 0
> > > dd: error writing '/dev/ublkb0': Input/output error
> > > 1+0 records in
> > > 0+0 records out
> > > 0 bytes copied, 0.0376731 s, 0.0 kB/s
> > > DEAD
> > > generic_02 : [PASS]
> > > 
> > > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > > ---
> > >  drivers/block/ublk_drv.c                        | 40 +++++++++++------------
> > >  tools/testing/selftests/ublk/Makefile           |  1 +
> > >  tools/testing/selftests/ublk/kublk.c            |  3 ++
> > >  tools/testing/selftests/ublk/kublk.h            |  3 ++
> > >  tools/testing/selftests/ublk/null.c             |  4 +++
> > >  tools/testing/selftests/ublk/test_generic_02.sh | 43 +++++++++++++++++++++++++
> > >  6 files changed, 72 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index c060da409ed8a888b7e414c9065efd2cbd6d57d7..1816b2cac01056dc9d01455759594af43c5f78d6 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -1247,8 +1247,6 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> > >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> > >  {
> > >  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > > -	unsigned int nr_inflight = 0;
> > > -	int i;
> > >  
> > >  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> > >  		if (!ubq->timeout) {
> > > @@ -1259,26 +1257,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> > >  		return BLK_EH_DONE;
> > >  	}
> > >  
> > > -	if (!ubq_daemon_is_dying(ubq))
> > > -		return BLK_EH_RESET_TIMER;
> > > -
> > > -	for (i = 0; i < ubq->q_depth; i++) {
> > > -		struct ublk_io *io = &ubq->ios[i];
> > > -
> > > -		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
> > > -			nr_inflight++;
> > > -	}
> > > -
> > > -	/* cancelable uring_cmd can't help us if all commands are in-flight */
> > > -	if (nr_inflight == ubq->q_depth) {
> > > -		struct ublk_device *ub = ubq->dev;
> > > -
> > > -		if (ublk_abort_requests(ub, ubq)) {
> > > -			schedule_work(&ub->nosrv_work);
> > > -		}
> > > -		return BLK_EH_DONE;
> > > -	}
> > > -
> > >  	return BLK_EH_RESET_TIMER;
> > >  }
> > >  
> > > @@ -1351,6 +1329,24 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
> > >  static int ublk_ch_release(struct inode *inode, struct file *filp)
> > >  {
> > >  	struct ublk_device *ub = filp->private_data;
> > > +	bool need_schedule = false;
> > > +	int i;
> > > +
> > > +	/*
> > > +	 * Error out any requests outstanding to the ublk server. This
> > > +	 * may have happened already (via uring_cmd cancellation), in
> > > +	 * which case it is not harmful to repeat. But uring_cmd
> > > +	 * cancellation does not handle queues which are fully saturated
> > > +	 * (all requests in ublk server), because from the kernel's POV,
> > > +	 * there are no outstanding uring_cmds to cancel. This code
> > > +	 * handles such queues.
> > > +	 */
> > > +
> > > +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> > > +		need_schedule |= ublk_abort_requests(ub, ublk_get_queue(ub, i));
> > > +
> > > +	if (need_schedule)
> > > +		schedule_work(&ub->nosrv_work);
> > 
> > ublk_abort_requests() should be called only in case of queue dying,
> > since ublk server may open & close the char device multiple times.
> 
> Sure that is technically possible, however is any real ublk server doing
> this? Seems like a strange thing to do, and seems reasonable for the
> driver to transition the device to the nosrv state (dead or recovery,
> depending on flags) when the char device is closed, since in this case,
> no one can be handling I/O anymore.

ublk server should be free to open & close the char device multiple times,
but you patch limits ublk server to open & close the char device just once.

The limit looks too strong...

> 
> In general I feel like char device close is a nice place to centralize
> the transition to the nosrv state. It has a few nice properties:
> - Because all file references are released at this point, we're
>   guaranteed that all file-related activity (uring_cmds, pread/pwrite)
>   is quiesced.
> - This one place can handle both saturated and unsaturated queues.
> - It is "event-driven," i.e. our callback gets called when a certain
>   condition is met, instead of having to poll for a condition (like the
>   old monitor_work, or the timeout now)
> - It looks like we can sleep in the char device close context, so we
>   could inline nosrv_work.

I agree all above, unless:

1) open() / close() need to be allowed multiple times

2) for dealing with 1), you may have to check if queue is dying, and this
way may have to use ->ubq_daemon, which is set when starting ublk, and cleared
when freeing ublk char. So race is added here, which need to be addressed.

> 
> This also is a step in the right direction IMO for resurrecting this old
> work to get rid of 1:1 ublk server thread to hctx restriction
> 
> https://lore.kernel.org/linux-block/20241002224437.3088981-1-ushankar@purestorage.com/T/#u

That is definitely one good direction.

> 
> > For understanding if queue is dying, ->ubq_damon need to be checked,
> > however it may not be set yet and the current context is not same with
> > the ubq_daemon context, so I feel it is a bit fragile to bring queue
> > reference into ->release() callback.
> > 
> > Many libublksrv tests are failed with this patch or kernel panic, even
> > with the above check added:
> > 
> >         make test T=generic
> 
> Thanks, I will look at and address these failures.
> 
> Is there any plan to bring these tests into the new ublk selftests
> framework?

The two stress tests should be very similar with ublksrv's, just MQ isn't enabled.

I will enable them later.

The other big part is recovery test, which may take some time. I am a little busy
recently, it is great if anyone would like to pull recovery test in. Otherwise,
it may take a while.



thanks,
Ming


