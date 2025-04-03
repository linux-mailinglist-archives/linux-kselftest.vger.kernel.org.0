Return-Path: <linux-kselftest+bounces-30056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0EBA7A1DE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 13:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC267A4554
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 11:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C97241689;
	Thu,  3 Apr 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQE8DGal";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="td2iEtUv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDC746E;
	Thu,  3 Apr 2025 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679775; cv=none; b=lzE1o4zQgid8ZWBTPIR21ebGSzNQqc4lfFpDyQNqSIbFxXr3LyTU/wVMiCXqRrCS8gSJpKhF9s2rt9AJKYoPT90C9k4N2AUEVM17zyYP6FZHOboEPJOwmmyESpIBP5+aWOLumeb5ZIWLXYTZFUONCx/CZ+vTBjtipVx1qyvzsq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679775; c=relaxed/simple;
	bh=5KsUfJCRg0Fk/4yM4/GbtR8fkLfnX/M6ZgFZZ4qIp+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0gYxo9+p2BAPGZGGQfvizQWfbeQ7GMaNV1mhGZbMcUpYlV1FKOAnPH58mcccXb3/N5GfKc8wSye9qQMTYBy9enKJq0xBiC725IMTF7TNZgPjlzBBeLVx3lanH0SMcpj0HYIKUcDL6TWgVuDVBByU42RJkOrU89TCSuMVhZ8l84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQE8DGal; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=td2iEtUv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743679771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCQZFIU3aQA8UI8RgbhFajYkKtNNKh+uMd0lvANG1Q4=;
	b=sQE8DGalZObUjmBaKP4ABnp4h1A5JPfIX/gc+9P0d8wQfuSIcZjr++2oxF/57GMoH/WBMG
	QRXlAIRxWlGr0aewpopP7EpDLzZg1lW6h5GA222TPQZZh8+rZpizm22OZlA8DkcKAfd6tQ
	817qerM6E8Q3t41+andndj5W/Ywf8p/m8x13TrMPYXfJMQHMb6v68oa/6L+y9/q4E9MqXE
	wc3h6s0H5wXfEnNHV3N1gyW+SiIX3aD/WOPOb1AZtW01oPmwxmElI7LELc1rRW84qL0pLW
	AB+ByPmEFJ8MV3n/h13TWrK5JINPE9sfBimz4W+BnIUfwuAux5ymu1SQbiftZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743679771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCQZFIU3aQA8UI8RgbhFajYkKtNNKh+uMd0lvANG1Q4=;
	b=td2iEtUvROtFzoz4lOGQeRRlRv/wau1YT9t0eTFL38D+YO/pVKhB/qyzoPvnUybLz/M3uZ
	tj+434/XhRFEs5Bw==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Subject: Re: [PATCH v2 1/2] time/timekeeping: Fix possible inconsistencies
 in _COARSE clockids
In-Reply-To: <Z-5HlSUEh1xgCi4f@localhost>
References: <20250320200306.1712599-1-jstultz@google.com>
 <Z-KURRE_Gr72Xv_n@localhost> <874izezv3c.ffs@tglx>
 <Z-Vx8kV4M3khPknC@localhost> <Z-qsg6iDGlcIJulJ@localhost>
 <87o6xgwftc.ffs@tglx> <Z-vL3cVZuQ8XQXhG@localhost> <87iknnwxa4.ffs@tglx>
 <Z-5HlSUEh1xgCi4f@localhost>
Date: Thu, 03 Apr 2025 13:29:31 +0200
Message-ID: <877c41wkis.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 03 2025 at 10:32, Miroslav Lichvar wrote:
> On Tue, Apr 01, 2025 at 08:29:23PM +0200, Thomas Gleixner wrote:
>> > 64		64		0.138
>> 
>> That's weird as it only delays the update to the next tick.
>
> Ok, so it's not an instability of the clock, but rather an instability
> of the chronyd synchronization loop, which since kernel 4.19 expects
> the frequency to be applied as soon as the adjtimex call is finished.

Interesting.

>> Patch applies after reverting 757b000f7b93 ("timekeeping: Fix possible
>> inconsistencies in _COARSE clockids").
>
> I ran multiple longer tests to be able to compare the small values in
> the noise and yes, from the adjtimex point of view this seems to work
> as well as before the first COARSE fix. I didn't run any tests of the
> COARSE clock.

I did run those, but did not run the adjtimex() muck :)

