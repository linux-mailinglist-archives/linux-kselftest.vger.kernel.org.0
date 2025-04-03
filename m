Return-Path: <linux-kselftest+bounces-30047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D4A79E36
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 10:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571001895364
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 08:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB1E1EF0BA;
	Thu,  3 Apr 2025 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vi8pjbUB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9591A01B0
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669157; cv=none; b=jtwseFypko7vjk5NcBCvf2qq1f+OrmJNkvIp9kpJ3y9LUDlTj7PzIVV5grhfbE0XjFJOJ3PgqDzURM9H043RLUA4zReK2FVvfJoJ68RmDBtiem3Ny8VCx5OaipdEmKyVuGOG8IZyAG/mvYn7Qxm0G9s4HOI805c/8rywap01KOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669157; c=relaxed/simple;
	bh=bP9BTqO6uOeKb9OB+ydFZqLPOoJTDBOLELlzwI0vg6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyA0Qz2nM8bPzoQ5IGcHoBoN6GsAa8klkbOdMUMUX10aymoGhDgw3o7PeqCbigNsOYeoEdXeg4n0+aObdGDNuLIDOCk1JX+0sBJJh9NAHxBi7rxG4oKnS02GqkaOD9PSWhUIM+peHwmuHlEn1uUTZ6owClztyUsw9fxvcWP9q88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vi8pjbUB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743669155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/o3+FKdxD4NW/8hxmNNkTDl22sR+l8JS5qoSmV4kVXg=;
	b=Vi8pjbUBkTXbhaSirnMrFJX+IaDq7TeLmEeFAZfr+lp8v88Mm7lmW3l08MJjqiEjMWhGEk
	5BfrZ1U9xtH+tNjfSa3y25GXrdQ3UPurqSLXXEi24DH2LsVmGadLB5vilW3+3CUS3uCfiU
	rn7AFJ6lIQKh6iTDY+kAqCBpBoFf4Jc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-50448r1bNvKzx8pPmhx0yg-1; Thu,
 03 Apr 2025 04:32:29 -0400
X-MC-Unique: 50448r1bNvKzx8pPmhx0yg-1
X-Mimecast-MFC-AGG-ID: 50448r1bNvKzx8pPmhx0yg_1743669147
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6591619560B8;
	Thu,  3 Apr 2025 08:32:27 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 525CC19560AD;
	Thu,  3 Apr 2025 08:32:24 +0000 (UTC)
Date: Thu, 3 Apr 2025 10:32:21 +0200
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
Message-ID: <Z-5HlSUEh1xgCi4f@localhost>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost>
 <874izezv3c.ffs@tglx>
 <Z-Vx8kV4M3khPknC@localhost>
 <Z-qsg6iDGlcIJulJ@localhost>
 <87o6xgwftc.ffs@tglx>
 <Z-vL3cVZuQ8XQXhG@localhost>
 <87iknnwxa4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iknnwxa4.ffs@tglx>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Apr 01, 2025 at 08:29:23PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 01 2025 at 13:19, Miroslav Lichvar wrote:
> > It seems to improve the worst cases, but overall it's still
> > a regression.
> >
> > Mult reduction	Updates/sec	Skew
> > 16		4		0.012
> > 16		16		0.014
> > 16		64	        0.033
> > 64		4		0.012
> > 64		16		0.105
> > 64		64		0.138
> 
> That's weird as it only delays the update to the next tick.

Ok, so it's not an instability of the clock, but rather an instability
of the chronyd synchronization loop, which since kernel 4.19 expects
the frequency to be applied as soon as the adjtimex call is finished.
To confirm that, I tried a different test with chronyd configured to
only monitor the clock without making any adjustments (-x option) and
another process repeatedly setting the same frequency. The one-line
patch does fix that test.

> My original
> approach of maintaining seperate state for the coarse time keeper is
> preserving the existing NTP behaviour.
> 
> Patch applies after reverting 757b000f7b93 ("timekeeping: Fix possible
> inconsistencies in _COARSE clockids").

I ran multiple longer tests to be able to compare the small values in
the noise and yes, from the adjtimex point of view this seems to work
as well as before the first COARSE fix. I didn't run any tests of the
COARSE clock.

Thanks,

-- 
Miroslav Lichvar


