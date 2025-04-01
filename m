Return-Path: <linux-kselftest+bounces-29973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C439FA77497
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 08:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EA916AFA5
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 06:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21351E32A2;
	Tue,  1 Apr 2025 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="juB1EP4W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TI7ZdQVI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075C21E22FC;
	Tue,  1 Apr 2025 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489274; cv=none; b=YelBmxNiiHsomyfMyyyPkg5ZFH5ZZ742TGLwlLoyeEgyagHXG7jc2v46zOh963TQzHP5Dyx5XhQPwyKb23wN1DxOVnvUkPxUC0VKv1zVrFKT0OMW05f5ER+RxrkhW1kEcRW7sx4RRdSL2Z86pV4xtC+pYJWXmw/xICs11fZYbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489274; c=relaxed/simple;
	bh=pMLha2aqVEv0PrrCgtbKTveYBj1RIdteN402dFa1DoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CO/MtIp/oggyePDHAc7lyZRmMeqFulLA801mZihrdCBCg8i3K53J1rmd4gpOrhSR8MDAZfea6vpActhUn3eYY04AJUXSZ0dA9GzWxd4hnqKSq4e7KkT+eplSnQ9/9v+HXaiEdjZO6a2CaoYapzxp/8hcHfBq35NkyDsvjwLytsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=juB1EP4W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TI7ZdQVI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743489264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWo0S2UEXmtpRdfnjz/FxEkKD7n+cWWQrfjGy/XF5pQ=;
	b=juB1EP4WbCGJ4Oe0+o/qCtG0HElam58g87ezgrMTTXMcSlL+gt7Lnmzy1NZ4IB4X/RYCtW
	uV1gAlGUK5FaAZkRotfvTSUwDzBvUCeow4ghB+QtTmK47qLtiKvEdxdjT7cGuCkyrZ0pU9
	0sE9fxZNjkvWF99+Xywy0YPsBmFu0+nIH9dUFN24grkqL7x8nwg80D/Ob6szcIzPXYO8Iu
	0OUVqTrk4iu4tyYk+JAzyVdxxbRpZXaSBHbm3uyJj1teoQ3Q1mGhLctUEYJZoYHMN+prSf
	RwhWjjDYvE6m17LvGiQuifgZHcU7S6817viBTDYl5eoR4lLIpGFATPErmh9FMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743489264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWo0S2UEXmtpRdfnjz/FxEkKD7n+cWWQrfjGy/XF5pQ=;
	b=TI7ZdQVIuy/d3kShw8DBNAkdH4XgTtuRcHfRcuuUI4/pEs4gOtf29CYf/QTJkb6twnwlkw
	8bnZrO2886Q7oZDQ==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Subject: Re: [PATCH v2 1/2] time/timekeeping: Fix possible inconsistencies
 in _COARSE clockids
In-Reply-To: <Z-qsg6iDGlcIJulJ@localhost>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost> <874izezv3c.ffs@tglx>
 <Z-Vx8kV4M3khPknC@localhost> <Z-qsg6iDGlcIJulJ@localhost>
Date: Tue, 01 Apr 2025 08:34:23 +0200
Message-ID: <87o6xgwftc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 31 2025 at 16:53, Miroslav Lichvar wrote:
> On Thu, Mar 27, 2025 at 04:42:49PM +0100, Miroslav Lichvar wrote:
>> Maybe I could simply patch the kernel to force a small clock
>> multiplier to increase the rate at which the error accumulates.
>
> I tried that and it indeed makes the issue clearly visible. The COARSE
> fix makes the clock less stable. It's barely visible with the normal
> multiplier, at least for the clocksource I tested, but a reduced
> multiplier forces a larger NTP error and raises it above the precision
> and instability of the system and reference clocks.
>
> The test was done on a machine with a TSC clocksource (3GHz CPU with
> disabled frequency scaling - normal multplier is 5592407) and tried a
> multiplier reduced by 4, 16, 64 with this COARSE-fixing patch not
> applied and applied. Each test ran for 1 minute and produced an
> average value of skew - stability of the clock frequency as reported
> by chronyd in the tracking log when synchronizing to a free-running
> PTP clock at 64, 16, and 4 updates per second. It's in parts per
> million (resolution in the chrony log is limited to 0.001 ppm).
>
> Mult reduction	Updates/sec	Skew before	Skew after
> 1		4		0.000		0.000
> 1		16		0.001		0.002
> 1		64		0.002		0.006
> 4		4		0.001		0.001
> 4		16		0.003		0.005
> 4		64		0.005		0.015
> 16		4		0.004		0.009
> 16		16		0.011		0.069
> 16		64		0.020		0.117
> 64		4		0.013		0.012
> 64		16		0.030		0.107
> 64		64		0.058		0.879

Hrm.

Can you try the delta patch below?

Thanks,

        tglx
---
 kernel/time/timekeeping.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2234,8 +2234,8 @@ static bool timekeeping_advance(enum tim
 				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
 				   tk->tkr_mono.clock->max_raw_delta);
 
-	/* Check if there's really nothing to do */
-	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
+	/* Check if there's really something to do */
+	if (offset < real_tk->cycle_interval)
 		return false;
 
 	offset = timekeeping_accumulate(tk, offset, mode, &clock_set);

