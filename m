Return-Path: <linux-kselftest+bounces-29868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E678A735DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3D416D22C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC5E1991C9;
	Thu, 27 Mar 2025 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE++LuMW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1604D17A2F9
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Mar 2025 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743090178; cv=none; b=jRtdgrriReBgVKrkBDAvDrxtBTmtUzcpxyn6914yjhN2ngKfJg5xbs5tQ1Nm2eW1v2gQhzCcHh86YckyGR1AHbZs5TD5jP6Bd6PrE+eBJzQLcLMFDCrRqZzlte/+LC9OzUeMKejt1JhSo/ap33tloRVav2pOFAF0zqFADA//RWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743090178; c=relaxed/simple;
	bh=WRQNcLxuP7Sg1bSvVZx3fZjubW0m+qyrd7ZxYVrqC9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgzpmP63i1UkElLoI7l7T4l1todlislcZDxkR8IlTsu6OsrHZwqxtqvDRyd9wM3VlEjNj3I5rYqz/TCOGA64vMFY8A/mrmMdsyT1Ft+6j5iGfSv0DBS6phgpnusAu3Tj+t7c+brbuSOOSWdmwjWPvZT2g+AVDTKSAFExS8UGHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FE++LuMW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743090176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L82rJDmXYHF+F3mDdR469/s//yRTKRk3iXxXUc2i3RU=;
	b=FE++LuMWLX/21BSGqRcyd7OWaUL1/coi9yTGHHeLq+Xp+UBSA4Ja/6fd3Tx8T0YCf++i0b
	g9Dd8S0RPDs4sa5N746yI9Vv3WcXvM8vlHuirgax1Cp4LR4gRyWeXTjMRoeRp6fLwD0Q+5
	v+0fL4mzApgLCZ4qm8tZP9+rJ3HxhVg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-K4fY_wARNAms4rURa0nGkQ-1; Thu,
 27 Mar 2025 11:42:52 -0400
X-MC-Unique: K4fY_wARNAms4rURa0nGkQ-1
X-Mimecast-MFC-AGG-ID: K4fY_wARNAms4rURa0nGkQ_1743090170
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B2A618EBE95;
	Thu, 27 Mar 2025 15:42:50 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00AF619560AB;
	Thu, 27 Mar 2025 15:42:46 +0000 (UTC)
Date: Thu, 27 Mar 2025 16:42:42 +0100
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Subject: Re: [PATCH v2 1/2] time/timekeeping: Fix possible inconsistencies in
 _COARSE clockids
Message-ID: <Z-Vx8kV4M3khPknC@localhost>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost>
 <874izezv3c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874izezv3c.ffs@tglx>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Mar 27, 2025 at 10:22:31AM +0100, Thomas Gleixner wrote:
> On Tue, Mar 25 2025 at 12:32, Miroslav Lichvar wrote:
> > Resetting the NTP error causes a small time step. An NTP/PTP client
> > can be setting the frequency very frequently, e.g. up to 128 times per
> > second and the interval between updates can be random. If the timing
> 
> I never observed that behaviour, but I'm not a NTP/PTP wizard/power user.

On a machine that has a /dev/ptp device available, a simple test to
observe such a high update rate is to run:

1) phc_ctl /dev/ptp0 set
2) phc2sys -m -q -O 0 -s /dev/ptp0 -R 128
or alternatively
2) chronyd -d 'refclock PHC /dev/ptp0 poll -7'

> The original implementation respected this base period, but John's
> approach of forwarding, which cures the coarse time getter issue,
> violates it. As a consequence the previous error accumulation is not
> longer based on the base period because the period has been reset to the
> random point in time when adjtimex() was invoked, which makes the error
> accumulation a random number.

I see, so that value of the NTP error is already wrong at that point
where it's reset to 0.

To clearly see the difference with the new code, I made an attempt
to update the old linux-tktest simulation that was used back when the
multiplier adjustment was reworked, but there are too many missing
things now and I gave up.

Maybe I could simply patch the kernel to force a small clock
multiplier to increase the rate at which the error accumulates.

-- 
Miroslav Lichvar


