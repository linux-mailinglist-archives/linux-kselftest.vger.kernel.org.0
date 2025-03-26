Return-Path: <linux-kselftest+bounces-29824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D563A71DD3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 18:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0673A8245
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDF72405EB;
	Wed, 26 Mar 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TESBlcNX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f230.google.com (mail-pl1-f230.google.com [209.85.214.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA7214230
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011661; cv=none; b=XfQuNU9velXTwJAf/htMMRGaMrl4p0CT8x1SR9wflutnwqB8aOV8KkDNqdAzHhevECBtvVDiiiw26xBBdbHCaEBt0+eK2mlHb8Q6zFmKU7YlErp1PK46xMh51fRNBhk8ysgFQ/SRQ5QeaI/4Mffr1SiYSQLKGB5TxYyT59N//iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011661; c=relaxed/simple;
	bh=N0lV8RRCZIn/UyidsP/nKru0zl2eIEhCS97kPxg+x8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjnR5ZSZ0AUFIF3oXxRsGZXGvykL3Qu+kms+lbvuKBlTgWA+z2Tz7y9sh9dzj5FHL8ZVvEa+OtJLoA1hqmHS55IFXKd1PAA6hsnr16UCb3ZVPDXn8WVmi56yeL8tTjv+yuckFYQw7qRxTVuo6JWaWIjTE9rVF5+kwrogudTRnjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TESBlcNX; arc=none smtp.client-ip=209.85.214.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f230.google.com with SMTP id d9443c01a7336-2279915e06eso4005045ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743011657; x=1743616457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKaQiOd2i2tu5h30n0dSPwGiOC8H0CLmZU+vUbsBcTg=;
        b=TESBlcNXvhUaFtSxSTrglBoJOfFrL2wMisl+CHaUF5bpNFacCsdgvdiDYC5gF4/efe
         lNAv9q1UT1McqCniwG1npK1o/tV55KIsPimwzVMhwkR0ZeYouZ5BIecXeTo0jh/GCxFe
         Nzhjp9dNYOzJWJpQPMQlQ8VvBtdi1kV9O4lx1xrbdf+tCHoDQ9Soak4qmYY7mFZyVz0L
         o0Bhk/hUq2KThNTR6fM2JkDnhd4ZQtbs3cQn4sUC4U606/r+34Wk+WNOEoZevZyOxjDw
         xn23o0PD821iIWpA4ZEUmXhS7Cl1qtkvhrslzIUIgxqQx1ekFJWbVR/RY8KmCeDF0cOd
         fumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743011657; x=1743616457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKaQiOd2i2tu5h30n0dSPwGiOC8H0CLmZU+vUbsBcTg=;
        b=v2Ea+BZrN/d/aneRwI3kN72W2VpI72ZoX5NfLhVaw9rOAJbFwQO/NLiz+ZFz85w5cN
         7aEysE10qqmRiqCsXcWDFp4ZertEYBsUY/SFTxslexrfPnBijQqJIYBg9t092Y6SZws3
         VnjVBUCIM0gc2p0vRFRSl6djSudZcqPtKipTstyt6kb/cjRZ4q/0WV9NOfdghA1ItOWv
         /OOvVXKislz8QsjZic1HQm6B+75VNlaw9ZAKsyWiuKb9EsH78Vxxh/Ic3/ZtVpk6gd5R
         3dtdV7LNXUDNpctTC8dOl0HPj0N6kfwTmwHfDuz9Re/bhvGRI+N10IygK8QyROGSYxDt
         3CdA==
X-Forwarded-Encrypted: i=1; AJvYcCWASDgtvLGYZ9E2AfLtKh+XFxkSI3V7GGX6himSfUd/iJkVr+q9rpr7Ip+5EtvUQCAFdYxV2bW2pXBRCi20bZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/lI+15yytaLhOG6B7mlp5etw/juNaTtbNR6XqTUZwUSooFi9O
	1k0GNgNVOBT9DfSKOgDzJD9lqFzl3HrAYBHhyq56iTKf8jO8LvKGAc1sBHKAHac0IL4xbVAK5qL
	g/APf62F0YAMpNQPhKUxm19FoMf6R4Tjc
X-Gm-Gg: ASbGncvsgfx1zgS75OOk6aMB3v74QT6sk6OiT8n5CnB8dURhDNlRzZ5+BRlfMsNzBNS
	BurdMiVJ5NDjwzZx8Suf8VHArH37YkzLlfguxGuVI08Rqyhu4WRE1IlBXjPdLpphEqLM4hJMT+m
	dy5tBf2DD2YUL/AyiLQ0ow6d6ZP+W+KOMwEinrc+t1dlbut4C2I4zokQFzOpsHw1XGFcK0vqC9i
	nXe4bXd+T/Qo/0e+8yjPJkIQsEcBiG7IiIokfdrwUnCPQOGftrW0K3r5MP3d2waxWIWOVq1FuLA
	z4kO2htbBgjHC6YEMw87VAVZWfhGEKUEfqy4xqaFnrPZbZFS5Q==
X-Google-Smtp-Source: AGHT+IFhojWMr5N96HUtj0fGPWdxPOHyRJ5eqiFSCKFhlxDabkZiJK3P68ZmCwr3O3l08/qefTKWp4c/2dUV
X-Received: by 2002:a17:902:f552:b0:220:e924:99dd with SMTP id d9443c01a7336-22804913ae0mr6688105ad.34.1743011657329;
        Wed, 26 Mar 2025 10:54:17 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22780ef247fsm5085965ad.2.2025.03.26.10.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:54:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 92199340280;
	Wed, 26 Mar 2025 11:54:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 85E4DE402DF; Wed, 26 Mar 2025 11:54:16 -0600 (MDT)
Date: Wed, 26 Mar 2025 11:54:16 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: improve handling of saturated queues when ublk
 server exits
Message-ID: <Z+Q/SNmX+DpVQ5ir@dev-ushankar.dev.purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-4-262f0121a7bd@purestorage.com>
 <Z-OS2_J7o0NKHWmj@fedora>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-OS2_J7o0NKHWmj@fedora>

On Wed, Mar 26, 2025 at 01:38:35PM +0800, Ming Lei wrote:
> On Tue, Mar 25, 2025 at 04:19:34PM -0600, Uday Shankar wrote:
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
> > The second method detects ublk server exit only after a long delay
> > (~30s, the default timeout assigned by the block layer). Any
> > applications using the ublk device will be left hanging for these 30s
> > before seeing an error/knowing anything went wrong. This problem is
> > illustrated by running the new test_generic_02 against a ublk_drv which
> > doesn't have the fix:
> > 
> > selftests: ublk: test_generic_02.sh
> > dev id is 0
> > dd: error writing '/dev/ublkb0': Input/output error
> > 1+0 records in
> > 0+0 records out
> > 0 bytes copied, 30.0611 s, 0.0 kB/s
> > DEAD
> > dd took 31 seconds to exit (>= 5s tolerance)!
> > generic_02 : [FAIL]
> > 
> > Fix this by instead handling the saturated queue case in the ublk
> > character file release callback. This happens during ublk server exit
> > and handles the issue much more quickly than an I/O timeout:
> 
> Another solution is to override default 30sec 'timeout'.

Yes, but that still will introduce unnecessary delays, since it is a
polling-based solution (very similar to monitor_work we used to have).
Also it will add complexity to the unprivileged case, since that
actually cares about timeout and we will have to track the "real"
timeout separately.

> 
> > 
> > selftests: ublk: test_generic_02.sh
> > dev id is 0
> > dd: error writing '/dev/ublkb0': Input/output error
> > 1+0 records in
> > 0+0 records out
> > 0 bytes copied, 0.0376731 s, 0.0 kB/s
> > DEAD
> > generic_02 : [PASS]
> > 
> > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c                        | 40 +++++++++++------------
> >  tools/testing/selftests/ublk/Makefile           |  1 +
> >  tools/testing/selftests/ublk/kublk.c            |  3 ++
> >  tools/testing/selftests/ublk/kublk.h            |  3 ++
> >  tools/testing/selftests/ublk/null.c             |  4 +++
> >  tools/testing/selftests/ublk/test_generic_02.sh | 43 +++++++++++++++++++++++++
> >  6 files changed, 72 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index c060da409ed8a888b7e414c9065efd2cbd6d57d7..1816b2cac01056dc9d01455759594af43c5f78d6 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1247,8 +1247,6 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> >  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
> >  {
> >  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> > -	unsigned int nr_inflight = 0;
> > -	int i;
> >  
> >  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
> >  		if (!ubq->timeout) {
> > @@ -1259,26 +1257,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
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
> > @@ -1351,6 +1329,24 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
> >  static int ublk_ch_release(struct inode *inode, struct file *filp)
> >  {
> >  	struct ublk_device *ub = filp->private_data;
> > +	bool need_schedule = false;
> > +	int i;
> > +
> > +	/*
> > +	 * Error out any requests outstanding to the ublk server. This
> > +	 * may have happened already (via uring_cmd cancellation), in
> > +	 * which case it is not harmful to repeat. But uring_cmd
> > +	 * cancellation does not handle queues which are fully saturated
> > +	 * (all requests in ublk server), because from the kernel's POV,
> > +	 * there are no outstanding uring_cmds to cancel. This code
> > +	 * handles such queues.
> > +	 */
> > +
> > +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> > +		need_schedule |= ublk_abort_requests(ub, ublk_get_queue(ub, i));
> > +
> > +	if (need_schedule)
> > +		schedule_work(&ub->nosrv_work);
> 
> ublk_abort_requests() should be called only in case of queue dying,
> since ublk server may open & close the char device multiple times.

Sure that is technically possible, however is any real ublk server doing
this? Seems like a strange thing to do, and seems reasonable for the
driver to transition the device to the nosrv state (dead or recovery,
depending on flags) when the char device is closed, since in this case,
no one can be handling I/O anymore.

In general I feel like char device close is a nice place to centralize
the transition to the nosrv state. It has a few nice properties:
- Because all file references are released at this point, we're
  guaranteed that all file-related activity (uring_cmds, pread/pwrite)
  is quiesced.
- This one place can handle both saturated and unsaturated queues.
- It is "event-driven," i.e. our callback gets called when a certain
  condition is met, instead of having to poll for a condition (like the
  old monitor_work, or the timeout now)
- It looks like we can sleep in the char device close context, so we
  could inline nosrv_work.

This also is a step in the right direction IMO for resurrecting this old
work to get rid of 1:1 ublk server thread to hctx restriction

https://lore.kernel.org/linux-block/20241002224437.3088981-1-ushankar@purestorage.com/T/#u

> For understanding if queue is dying, ->ubq_damon need to be checked,
> however it may not be set yet and the current context is not same with
> the ubq_daemon context, so I feel it is a bit fragile to bring queue
> reference into ->release() callback.
> 
> Many libublksrv tests are failed with this patch or kernel panic, even
> with the above check added:
> 
>         make test T=generic

Thanks, I will look at and address these failures.

Is there any plan to bring these tests into the new ublk selftests
framework?


