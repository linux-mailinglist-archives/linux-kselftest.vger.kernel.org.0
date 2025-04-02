Return-Path: <linux-kselftest+bounces-30006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F309AA786FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 05:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BAB16D30C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 03:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F122309BE;
	Wed,  2 Apr 2025 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFP9ZNlU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BE2309B0
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Apr 2025 03:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743566391; cv=none; b=oahJKw2gsmpNM5zJiU98qEHpnw5CNJXELR0MSeuaBdxy5yKQ/BWdB7Q1GM340QEjxwSNdyYJAyVuC61QqZcGQfR29Apr8iMjIsDxle+iHnXnqGcROQ2xjfrsloCWWsCZAH7ZaHqL71t2YPoH9GDW74PdwUuTXVBu6ysByJCCbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743566391; c=relaxed/simple;
	bh=5XAaBVK3PYlu5jmU+rZarTc0x0/lrq+TgCeHcJRWMng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWj85vH6UxX9u6tExGGZZUEpIlyTKZnXHw25P/Ma9WPyXIjKHhLoxa/hNmIASXZ4OiRz8bymd7pjjT8w491+p+Kxx1JHRogKECtVftFcT/M8AsjD6gvewaO9vwJLiDZTyBiJDMZ+Eh+liJpYZ8Vj+Qt/SGqvwoB+7OkV4hXcdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFP9ZNlU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743566388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tGXy3CN7gC6EypnGhzzb76sSaOem2BZqrJYP6QEGJ/4=;
	b=MFP9ZNlUQHp2FMg0eX9FK8JLXdNp6trpGDAzRLNTx++XLWqkygSo83+L1Qu09CHOpISxwk
	YtiR8ZQrMx9Q/SfzNBUbUd7/cl96abMB2mC16as+7zX4HZa/aSq2Qx2cIvRvue9VI/0DsQ
	lDAlxWPn97OvCQmxK1iERA0peQqSB+c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-2mGvHwF1Pd6akDJCiMkKNA-1; Tue,
 01 Apr 2025 23:59:45 -0400
X-MC-Unique: 2mGvHwF1Pd6akDJCiMkKNA-1
X-Mimecast-MFC-AGG-ID: 2mGvHwF1Pd6akDJCiMkKNA_1743566384
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 069D719560BB;
	Wed,  2 Apr 2025 03:59:44 +0000 (UTC)
Received: from fedora (unknown [10.72.120.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B21BD180A803;
	Wed,  2 Apr 2025 03:59:38 +0000 (UTC)
Date: Wed, 2 Apr 2025 11:59:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z-y2JGJC56ZhdYHP@fedora>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
 <Z-OS2_J7o0NKHWmj@fedora>
 <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>
 <Z-SoibOdOmzOWB-C@fedora>
 <Z+sifI6fujsc186S@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+sifI6fujsc186S@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Mar 31, 2025 at 05:17:16PM -0600, Uday Shankar wrote:
> On Thu, Mar 27, 2025 at 09:23:21AM +0800, Ming Lei wrote:
> > On Wed, Mar 26, 2025 at 11:54:16AM -0600, Uday Shankar wrote:
> > > On Wed, Mar 26, 2025 at 01:38:35PM +0800, Ming Lei wrote:
> > > > On Tue, Mar 25, 2025 at 04:19:34PM -0600, Uday Shankar wrote:
> > > > > There are currently two ways in which ublk server exit is detected by
> > > > > ublk_drv:
> > > > > 
> > > > > 1. uring_cmd cancellation. If there are any outstanding uring_cmds which
> > > > >    have not been completed to the ublk server when it exits, io_uring
> > > > >    calls the uring_cmd callback with a special cancellation flag as the
> > > > >    issuing task is exiting.
> > > > > 2. I/O timeout. This is needed in addition to the above to handle the
> > > > >    "saturated queue" case, when all I/Os for a given queue are in the
> > > > >    ublk server, and therefore there are no outstanding uring_cmds to
> > > > >    cancel when the ublk server exits.
> > > > > 
> > > > > The second method detects ublk server exit only after a long delay
> > > > > (~30s, the default timeout assigned by the block layer). Any
> > > > > applications using the ublk device will be left hanging for these 30s
> > > > > before seeing an error/knowing anything went wrong. This problem is
> > > > > illustrated by running the new test_generic_02 against a ublk_drv which
> > > > > doesn't have the fix:
> > > > > 
> > > > > selftests: ublk: test_generic_02.sh
> > > > > dev id is 0
> > > > > dd: error writing '/dev/ublkb0': Input/output error
> > > > > 1+0 records in
> > > > > 0+0 records out
> > > > > 0 bytes copied, 30.0611 s, 0.0 kB/s
> > > > > DEAD
> > > > > dd took 31 seconds to exit (>= 5s tolerance)!
> > > > > generic_02 : [FAIL]
> > > > > 
> > > > > Fix this by instead handling the saturated queue case in the ublk
> > > > > character file release callback. This happens during ublk server exit
> > > > > and handles the issue much more quickly than an I/O timeout:
> > > > 
> > > > Another solution is to override default 30sec 'timeout'.
> > > 
> > > Yes, but that still will introduce unnecessary delays, since it is a
> > > polling-based solution (very similar to monitor_work we used to have).
> > > Also it will add complexity to the unprivileged case, since that
> > > actually cares about timeout and we will have to track the "real"
> > > timeout separately.
> > > 
> > > > 
> > > > > 
> > > > > selftests: ublk: test_generic_02.sh
> > > > > dev id is 0
> > > > > dd: error writing '/dev/ublkb0': Input/output error
> > > > > 1+0 records in
> > > > > 0+0 records out
> > > > > 0 bytes copied, 0.0376731 s, 0.0 kB/s
> > > > > DEAD
> > > > > generic_02 : [PASS]
> > > > > 
> > > > > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > > > > ---
> > > > >  drivers/block/ublk_drv.c                        | 40 +++++++++++------------
> > > > >  tools/testing/selftests/ublk/Makefile           |  1 +
> > > > >  tools/testing/selftests/ublk/kublk.c            |  3 ++
> > > > >  tools/testing/selftests/ublk/kublk.h            |  3 ++
> > > > >  tools/testing/selftests/ublk/null.c             |  4 +++
> > > > >  tools/testing/selftests/ublk/test_generic_02.sh | 43 +++++++++++++++++++++++++
> > > > >  6 files changed, 72 insertions(+), 22 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > > index c060da409ed8a888b7e414c9065efd2cbd6d57d7..1816b2cac01056dc9d01455759594af43c5f78d6 100644
> > > > > --- a/drivers/block/ublk_drv.c
> > > > > +++ b/drivers/block/ublk_drv.c
> > > > > @@ -1247,8 +1247,6 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> > > > >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> > > > >  {
> > > > >  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > > > > -	unsigned int nr_inflight = 0;
> > > > > -	int i;
> > > > >  
> > > > >  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> > > > >  		if (!ubq->timeout) {
> > > > > @@ -1259,26 +1257,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> > > > >  		return BLK_EH_DONE;
> > > > >  	}
> > > > >  
> > > > > -	if (!ubq_daemon_is_dying(ubq))
> > > > > -		return BLK_EH_RESET_TIMER;
> > > > > -
> > > > > -	for (i = 0; i < ubq->q_depth; i++) {
> > > > > -		struct ublk_io *io = &ubq->ios[i];
> > > > > -
> > > > > -		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
> > > > > -			nr_inflight++;
> > > > > -	}
> > > > > -
> > > > > -	/* cancelable uring_cmd can't help us if all commands are in-flight */
> > > > > -	if (nr_inflight == ubq->q_depth) {
> > > > > -		struct ublk_device *ub = ubq->dev;
> > > > > -
> > > > > -		if (ublk_abort_requests(ub, ubq)) {
> > > > > -			schedule_work(&ub->nosrv_work);
> > > > > -		}
> > > > > -		return BLK_EH_DONE;
> > > > > -	}
> > > > > -
> > > > >  	return BLK_EH_RESET_TIMER;
> > > > >  }
> > > > >  
> > > > > @@ -1351,6 +1329,24 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
> > > > >  static int ublk_ch_release(struct inode *inode, struct file *filp)
> > > > >  {
> > > > >  	struct ublk_device *ub = filp->private_data;
> > > > > +	bool need_schedule = false;
> > > > > +	int i;
> > > > > +
> > > > > +	/*
> > > > > +	 * Error out any requests outstanding to the ublk server. This
> > > > > +	 * may have happened already (via uring_cmd cancellation), in
> > > > > +	 * which case it is not harmful to repeat. But uring_cmd
> > > > > +	 * cancellation does not handle queues which are fully saturated
> > > > > +	 * (all requests in ublk server), because from the kernel's POV,
> > > > > +	 * there are no outstanding uring_cmds to cancel. This code
> > > > > +	 * handles such queues.
> > > > > +	 */
> > > > > +
> > > > > +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> > > > > +		need_schedule |= ublk_abort_requests(ub, ublk_get_queue(ub, i));
> > > > > +
> > > > > +	if (need_schedule)
> > > > > +		schedule_work(&ub->nosrv_work);
> > > > 
> > > > ublk_abort_requests() should be called only in case of queue dying,
> > > > since ublk server may open & close the char device multiple times.
> > > 
> > > Sure that is technically possible, however is any real ublk server doing
> > > this? Seems like a strange thing to do, and seems reasonable for the
> > > driver to transition the device to the nosrv state (dead or recovery,
> > > depending on flags) when the char device is closed, since in this case,
> > > no one can be handling I/O anymore.
> > 
> > ublk server should be free to open & close the char device multiple times,
> > but you patch limits ublk server to open & close the char device just once.
> > 
> > The limit looks too strong...
> 
> Tying a userspace daemon lifetime to the file seems to also be done in
> fuse, which is very similar to ublk_drv. See e.g. the description here:
> 
> https://lore.kernel.org/lkml/20240524064030.4944-1-jefflexu@linux.alibaba.com/T/
> 
> This seems required to support certain workflows, e.g. using an fdstore
> with ublk devices. While we still keep task references in ublk_drv,
> these workflows will be broken.
> 
> I am not familiar with fuse so I don't know for sure, but it sounds like
> if the file is closed after some setup is performed, then the connection
> is aborted. The analogy in ublk might be - if the file is closed while
> the device is LIVE, then we transition to the nosrv state. Otherwise
> nothing happens and the file can be reopened freely. This will allow
> libublksrv to continue working as it opens/closes the fd early to
> determine if it is accessible. Does that sound any better?

Yes, my point is that the close shouldn't delete disk, since it may
be one normal close().

Actually I think your patch should work by the following change:

- remove 'schedule_work(&ub->nosrv_work);' done in ublk_ch_release()

- re-initialize each ublk_queue in open()

Then disk won't be deleted, but any IO is `aborted` by ubq->canceling
if the char device isn't opened. After the char device is re-opened,
everything will become fine.


Thanks,
Ming


