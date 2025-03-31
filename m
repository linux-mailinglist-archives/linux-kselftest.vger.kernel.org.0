Return-Path: <linux-kselftest+bounces-29966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53FDA77151
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 01:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6697E3A95F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 23:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C621C9F2;
	Mon, 31 Mar 2025 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="euH7M5my"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62F29D0D
	for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743463042; cv=none; b=WSx58YUwYUlc42p+pZBB39alCqxTO2ZvvCQqDDGOrJV5jOQXsKFBzhySrJjXiGFvQIZnp776boa4RUC6As86WwyVoPONykVCh2D/fURYRxXRCNvgil/53m8+CO12+jMmsp5FVYifmoQvZB40iYs+6bjsDVPSOkI/xqNfFE/wTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743463042; c=relaxed/simple;
	bh=V4zcS3VHy00LSstytvIhBcw93HmwPluCvtf3eTnTJiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIXnxub0OlB3K8h/37Cm0DOGi6nHMhD+5aPcvNNjNo25NawW4xiqHO2cAtxOOhMjga4eRg3b1x5B2Ecq6PdE1izFbK/VcTG4t59K9dO0lVKP3a5Tc5fHm88voW8jsNHpNworyZbDgg7hHYPKMo2UJ2G98m80+8GADpDoQS6wS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=euH7M5my; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-85b41281b50so113594039f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743463038; x=1744067838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=253IVXqvyimIRaeq5FLc2Fwm51XlkeZhNQDnFWpHFz8=;
        b=euH7M5myN/naLJsh5BzbgsVbMPfo3b0+atANvOzQmIUSsASiIKmz0lIEdWLh55Lj3v
         yv0K8g+gBcQxFFLvnrYUAfRsXeZLNdJD578NrN+h4jZZxLmF9ckUtfipXZl0IOF1p8Gh
         ZwRPuoCpA80GMzXfvtpmHgIDOdnbZdw5wRWTTXlSc4UY7uCrPNQB59JQPyQJthLyasgG
         pccxwnaTb16P05pUO2mF2/iswEPzBCxzv9N5zYprZ5mF6qgL6OSZETFs+UH1LjVfBCSi
         VhBmjh/+nZcxe6GDe2o7K3FoN2rCZz1l0pNRD8QurzU8U5lfyjJcucWW5jAy2xCrgRMF
         bLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743463039; x=1744067839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=253IVXqvyimIRaeq5FLc2Fwm51XlkeZhNQDnFWpHFz8=;
        b=LJJBF4TTt8pl6gd2dTA+wKIdrCWGdFEfdAnMPoJIIoSC+5yMOX8TbQj/uUlM93BVgA
         SuN542pnEAOLWx0T8v4h8ob2+A+Vza8ppSDG0jv1GDn6tWr6hwWiOHCz2FWhDpgpHvcB
         y9ZoPH2VX9yDDYvNdA1eqXn524nWqUhAg3TrIVuv6lq/ek+1yGUy7rz62mIPGZhZ7izp
         TxWi9AkDoQgLW81+GkNzKWxk0d/C+n0fO7ruOVKRmkVon0dQgKtQTx4oT3rkT9mYXd18
         hqcl/wKQLvgzk74cTGmNa1QtFxXFtB4EXcVEdYPcps75M+veLPPsEUeUJ9aAUzmln85s
         gWng==
X-Forwarded-Encrypted: i=1; AJvYcCWk7USva1JX+B3anhIRcXek+rLgnTVV8zOd0eJsie224n8a4Oes5EGYlybKu0ipeDi2oFXpWXAzU5ad2vXmO3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+G3NHvOgXWCBGXUepWjhb5IwvMRF296GlcSVZzeMBd0hfXYY
	NA1BeghcE0TDjXoYt9GtCBT+WZpC4skr3VTNRCkVJ/1pvUc1O0tb2dcsL6+NJASZ3SD4rLDq0dx
	Y1ltyaGUUY50dhrSbG0W3H9mwxSZAGh5QJ6l2bxJIgmabOcn+
X-Gm-Gg: ASbGncuI74hMjbah71E2BJ6VINBBTzQn7FcnX1mzlb9pLcOrkFmyt95yMn48Q33xyKr
	e6fg9W36auLqPhDXLLo55Osxc0kDSy1gkRpy++zLSVoRCjUHkHP6e0qmS2ZC3iSOhH+3i32u/7I
	SAZWYobtY1qGZj/FGfL13uDYCe6Wr5qQLp3r/NhIJUmnLGu+gXi4+Xyv18tN4bERmGdrrD9VfLM
	kapQB8I61aUezuvLrwJFikP+1tXDqxJxE4vpF7UuyEtjGWZ3RGUqp00+9bEiYpo7ZXuIHMMyia/
	k7a1Q4+1Gj81n9HS2mTnkz6yEChEOqBuKOA=
X-Google-Smtp-Source: AGHT+IFAfHUOd3wpQObzKgKlayEtIa9KGQW2qhc+r4SeeD3o705EDeaJHnUKCpwklXgxM7GAIwpSa7Eklgd+
X-Received: by 2002:a05:6602:4c0e:b0:85e:2eba:20ad with SMTP id ca18e2360f4ac-85e9e84a5d6mr1019300939f.2.1743463038674;
        Mon, 31 Mar 2025 16:17:18 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-85e9026b56bsm52135739f.22.2025.03.31.16.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 16:17:18 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 090E33404B9;
	Mon, 31 Mar 2025 17:17:17 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id F17C6E402D8; Mon, 31 Mar 2025 17:17:16 -0600 (MDT)
Date: Mon, 31 Mar 2025 17:17:16 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z+sifI6fujsc186S@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
 <Z-OS2_J7o0NKHWmj@fedora>
 <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>
 <Z-SoibOdOmzOWB-C@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-SoibOdOmzOWB-C@fedora>

On Thu, Mar 27, 2025 at 09:23:21AM +0800, Ming Lei wrote:
> On Wed, Mar 26, 2025 at 11:54:16AM -0600, Uday Shankar wrote:
> > On Wed, Mar 26, 2025 at 01:38:35PM +0800, Ming Lei wrote:
> > > On Tue, Mar 25, 2025 at 04:19:34PM -0600, Uday Shankar wrote:
> > > > There are currently two ways in which ublk server exit is detected by
> > > > ublk_drv:
> > > > 
> > > > 1. uring_cmd cancellation. If there are any outstanding uring_cmds which
> > > >    have not been completed to the ublk server when it exits, io_uring
> > > >    calls the uring_cmd callback with a special cancellation flag as the
> > > >    issuing task is exiting.
> > > > 2. I/O timeout. This is needed in addition to the above to handle the
> > > >    "saturated queue" case, when all I/Os for a given queue are in the
> > > >    ublk server, and therefore there are no outstanding uring_cmds to
> > > >    cancel when the ublk server exits.
> > > > 
> > > > The second method detects ublk server exit only after a long delay
> > > > (~30s, the default timeout assigned by the block layer). Any
> > > > applications using the ublk device will be left hanging for these 30s
> > > > before seeing an error/knowing anything went wrong. This problem is
> > > > illustrated by running the new test_generic_02 against a ublk_drv which
> > > > doesn't have the fix:
> > > > 
> > > > selftests: ublk: test_generic_02.sh
> > > > dev id is 0
> > > > dd: error writing '/dev/ublkb0': Input/output error
> > > > 1+0 records in
> > > > 0+0 records out
> > > > 0 bytes copied, 30.0611 s, 0.0 kB/s
> > > > DEAD
> > > > dd took 31 seconds to exit (>= 5s tolerance)!
> > > > generic_02 : [FAIL]
> > > > 
> > > > Fix this by instead handling the saturated queue case in the ublk
> > > > character file release callback. This happens during ublk server exit
> > > > and handles the issue much more quickly than an I/O timeout:
> > > 
> > > Another solution is to override default 30sec 'timeout'.
> > 
> > Yes, but that still will introduce unnecessary delays, since it is a
> > polling-based solution (very similar to monitor_work we used to have).
> > Also it will add complexity to the unprivileged case, since that
> > actually cares about timeout and we will have to track the "real"
> > timeout separately.
> > 
> > > 
> > > > 
> > > > selftests: ublk: test_generic_02.sh
> > > > dev id is 0
> > > > dd: error writing '/dev/ublkb0': Input/output error
> > > > 1+0 records in
> > > > 0+0 records out
> > > > 0 bytes copied, 0.0376731 s, 0.0 kB/s
> > > > DEAD
> > > > generic_02 : [PASS]
> > > > 
> > > > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > > > ---
> > > >  drivers/block/ublk_drv.c                        | 40 +++++++++++------------
> > > >  tools/testing/selftests/ublk/Makefile           |  1 +
> > > >  tools/testing/selftests/ublk/kublk.c            |  3 ++
> > > >  tools/testing/selftests/ublk/kublk.h            |  3 ++
> > > >  tools/testing/selftests/ublk/null.c             |  4 +++
> > > >  tools/testing/selftests/ublk/test_generic_02.sh | 43 +++++++++++++++++++++++++
> > > >  6 files changed, 72 insertions(+), 22 deletions(-)
> > > > 
> > > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > > index c060da409ed8a888b7e414c9065efd2cbd6d57d7..1816b2cac01056dc9d01455759594af43c5f78d6 100644
> > > > --- a/drivers/block/ublk_drv.c
> > > > +++ b/drivers/block/ublk_drv.c
> > > > @@ -1247,8 +1247,6 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> > > >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> > > >  {
> > > >  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > > > -	unsigned int nr_inflight = 0;
> > > > -	int i;
> > > >  
> > > >  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> > > >  		if (!ubq->timeout) {
> > > > @@ -1259,26 +1257,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> > > >  		return BLK_EH_DONE;
> > > >  	}
> > > >  
> > > > -	if (!ubq_daemon_is_dying(ubq))
> > > > -		return BLK_EH_RESET_TIMER;
> > > > -
> > > > -	for (i = 0; i < ubq->q_depth; i++) {
> > > > -		struct ublk_io *io = &ubq->ios[i];
> > > > -
> > > > -		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
> > > > -			nr_inflight++;
> > > > -	}
> > > > -
> > > > -	/* cancelable uring_cmd can't help us if all commands are in-flight */
> > > > -	if (nr_inflight == ubq->q_depth) {
> > > > -		struct ublk_device *ub = ubq->dev;
> > > > -
> > > > -		if (ublk_abort_requests(ub, ubq)) {
> > > > -			schedule_work(&ub->nosrv_work);
> > > > -		}
> > > > -		return BLK_EH_DONE;
> > > > -	}
> > > > -
> > > >  	return BLK_EH_RESET_TIMER;
> > > >  }
> > > >  
> > > > @@ -1351,6 +1329,24 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
> > > >  static int ublk_ch_release(struct inode *inode, struct file *filp)
> > > >  {
> > > >  	struct ublk_device *ub = filp->private_data;
> > > > +	bool need_schedule = false;
> > > > +	int i;
> > > > +
> > > > +	/*
> > > > +	 * Error out any requests outstanding to the ublk server. This
> > > > +	 * may have happened already (via uring_cmd cancellation), in
> > > > +	 * which case it is not harmful to repeat. But uring_cmd
> > > > +	 * cancellation does not handle queues which are fully saturated
> > > > +	 * (all requests in ublk server), because from the kernel's POV,
> > > > +	 * there are no outstanding uring_cmds to cancel. This code
> > > > +	 * handles such queues.
> > > > +	 */
> > > > +
> > > > +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> > > > +		need_schedule |= ublk_abort_requests(ub, ublk_get_queue(ub, i));
> > > > +
> > > > +	if (need_schedule)
> > > > +		schedule_work(&ub->nosrv_work);
> > > 
> > > ublk_abort_requests() should be called only in case of queue dying,
> > > since ublk server may open & close the char device multiple times.
> > 
> > Sure that is technically possible, however is any real ublk server doing
> > this? Seems like a strange thing to do, and seems reasonable for the
> > driver to transition the device to the nosrv state (dead or recovery,
> > depending on flags) when the char device is closed, since in this case,
> > no one can be handling I/O anymore.
> 
> ublk server should be free to open & close the char device multiple times,
> but you patch limits ublk server to open & close the char device just once.
> 
> The limit looks too strong...

Tying a userspace daemon lifetime to the file seems to also be done in
fuse, which is very similar to ublk_drv. See e.g. the description here:

https://lore.kernel.org/lkml/20240524064030.4944-1-jefflexu@linux.alibaba.com/T/

This seems required to support certain workflows, e.g. using an fdstore
with ublk devices. While we still keep task references in ublk_drv,
these workflows will be broken.

I am not familiar with fuse so I don't know for sure, but it sounds like
if the file is closed after some setup is performed, then the connection
is aborted. The analogy in ublk might be - if the file is closed while
the device is LIVE, then we transition to the nosrv state. Otherwise
nothing happens and the file can be reopened freely. This will allow
libublksrv to continue working as it opens/closes the fd early to
determine if it is accessible. Does that sound any better?


