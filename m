Return-Path: <linux-kselftest+bounces-29953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF040A76955
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 17:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F5B7A2369
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F188922B588;
	Mon, 31 Mar 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzS1tXy5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DC22A810
	for <linux-kselftest@vger.kernel.org>; Mon, 31 Mar 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432852; cv=none; b=T2Cc2Dgwn4d8zbGDS1gfHV1J64Gms30HjdvOFbhx9b3jEdO6oanEFkW4cPrWQfz+mOsfb8yWu5OknZ230czshpHrr8ILm7zkdeFL+Me8f2F1RefOrCUBQydobZd72FJOae3oX9XCBvV3BDMC0al/pD7O+3cLt5jHJuIBYluAHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432852; c=relaxed/simple;
	bh=z3Jo4cVEz82S1Hhr9IzTyltq1FXq8pBHA6uwkGyfZCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTYxatDMsMEayXnpsygKF6dRfGm4/p7zKTypWgTnew4l0mgJ01doQdNY/qVaKumR/+e+VeOJEtpMzhfu7BjSzRCvJVpcy8CmKQpm6F/TOLjj47qgnvw5VsvhlWAYvUgj7371p1NxHUrTSq7X+CATKHVlt28kH9WWfoOh9Qsvqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzS1tXy5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743432849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iG+qEN/dmB4J+30yyi3d8IQq23oAU9zL+9Eq8FKspqc=;
	b=AzS1tXy5nlDUedO6jEkTeo8R7QWiJpauEV3rXcH1xfMW0uY9vBRT/Tyh1vziiMuvfUyrhU
	XlJ8JiBjrL3iBpVv7HMHz5u74b1VGr8UiJ3HGRFlCJuiVSaMjfKp3LuWT3Ew2dqDDKPgnQ
	h5YRUC7TM/t2H+D4tYfGbc+McYNydzM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-Agcw7EsOPYiuCYdqwpm4Rw-1; Mon,
 31 Mar 2025 10:54:03 -0400
X-MC-Unique: Agcw7EsOPYiuCYdqwpm4Rw-1
X-Mimecast-MFC-AGG-ID: Agcw7EsOPYiuCYdqwpm4Rw_1743432842
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9A3C180035C;
	Mon, 31 Mar 2025 14:54:01 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A2F618009BC;
	Mon, 31 Mar 2025 14:53:58 +0000 (UTC)
Date: Mon, 31 Mar 2025 16:53:55 +0200
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
Message-ID: <Z-qsg6iDGlcIJulJ@localhost>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost>
 <874izezv3c.ffs@tglx>
 <Z-Vx8kV4M3khPknC@localhost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Vx8kV4M3khPknC@localhost>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Mar 27, 2025 at 04:42:49PM +0100, Miroslav Lichvar wrote:
> Maybe I could simply patch the kernel to force a small clock
> multiplier to increase the rate at which the error accumulates.

I tried that and it indeed makes the issue clearly visible. The COARSE
fix makes the clock less stable. It's barely visible with the normal
multiplier, at least for the clocksource I tested, but a reduced
multiplier forces a larger NTP error and raises it above the precision
and instability of the system and reference clocks.

The test was done on a machine with a TSC clocksource (3GHz CPU with
disabled frequency scaling - normal multplier is 5592407) and tried a
multiplier reduced by 4, 16, 64 with this COARSE-fixing patch not
applied and applied. Each test ran for 1 minute and produced an
average value of skew - stability of the clock frequency as reported
by chronyd in the tracking log when synchronizing to a free-running
PTP clock at 64, 16, and 4 updates per second. It's in parts per
million (resolution in the chrony log is limited to 0.001 ppm).

Mult reduction	Updates/sec	Skew before	Skew after
1		4		0.000		0.000
1		16		0.001		0.002
1		64		0.002		0.006
4		4		0.001		0.001
4		16		0.003		0.005
4		64		0.005		0.015
16		4		0.004		0.009
16		16		0.011		0.069
16		64		0.020		0.117
64		4		0.013		0.012
64		16		0.030		0.107
64		64		0.058		0.879

-- 
Miroslav Lichvar


