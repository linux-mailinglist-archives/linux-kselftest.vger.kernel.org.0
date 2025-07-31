Return-Path: <linux-kselftest+bounces-38096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F96B172A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 15:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6F64E1514
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333712D0C8C;
	Thu, 31 Jul 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dv/wFPjl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GTnPA4/n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939BA23536A;
	Thu, 31 Jul 2025 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970299; cv=none; b=gQVbjXD23bUdfOzVkc3h5zUtjC1kKcs0qsNfaSnSiFJx4fffV1pplaaH3CLeFW+kSmpx7LuiCLNdNPZhDrCAiJLUUXmTXjKyVpvb7g4GpLVoS6kOrjsS5qGjQ6a3CJIpfxd8SxBiu4rzoY30aBCJv933fCY1Mlghl/J/AkpucqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970299; c=relaxed/simple;
	bh=QBd0pefYh+td5X4uaS/l2areTAr44b2USwB596vvfsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gtJMe+q/VogkVw6vClcKu12Q2LOat42ddPMPc0MjowmbouDkFYdvo4dRX1NxeGrxCxQWiNXRZxYIEUa1XfxsKexxYZ1ykae19Rq14mpVsMXfrGSwqSs8n/uYD+l3CUHU6I71afBW6CUPMIaMekexlDA6qArhh7+/ZFGgEpCzSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dv/wFPjl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GTnPA4/n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753970294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JY9R7tyBArJkfNbVWcneAgmEfp9mLBB0a5xwIKDKlOI=;
	b=dv/wFPjlxc/zfq9HoLrUxibcsBxVlBpiJmPuKSkwWk4XA78PdaUtwlOL6nJ96odXNJNdSi
	YDj11ozn3I88NM0NRiGlKm058uUlnGLDdlFPvFGmCvgKOU6FORej+0n8i7V4cx/eBf9Oet
	YrHC/MZjXUQfyuZTmyQmLgXGAujSS6ugnk5+u0Hpu1QtWkGM5WKSovfw4LdoSCLYqf2uVb
	5S1OwdadTkXgOGsKcRAYegJNmb76QC24BP8xS1/vvZBMTSQLRKMryg/N0iTmPyhS6Yg5tu
	MCGfvLbMENw0VzQgZ8HxSFrBrqAiNFnS5tLOnFO/+av7EkjY4mtwj+WHgSH5eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753970294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JY9R7tyBArJkfNbVWcneAgmEfp9mLBB0a5xwIKDKlOI=;
	b=GTnPA4/nnpm/YaZS87D/W1DNNc6aXTTqReaVyuRDEIWXohWRifVbP0jb/ZDpIW7fJYy7Eh
	bh2ClypK9MwrBiDQ==
To: Vishal Parmar <vishistriker@gmail.com>, John Stultz <jstultz@google.com>
Cc: shuah@kernel.org, anna-maria@linutronix.de, frederic@kernel.org,
 sboyd@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: timers: improve adjtick output readability
In-Reply-To: <CAEOVoRwsHdAmn1d_SekD+ddWeUDJCooNsK_wDHxEyvtqkDXQZw@mail.gmail.com>
References: <20250728160304.929942-1-vishistriker@gmail.com>
 <CANDhNCpp5DxzRufL9iVj8p0tpNSXG7WPEcTDpLbb2TzrY9HyOw@mail.gmail.com>
 <CAEOVoRwsHdAmn1d_SekD+ddWeUDJCooNsK_wDHxEyvtqkDXQZw@mail.gmail.com>
Date: Thu, 31 Jul 2025 15:58:12 +0200
Message-ID: <877bzoihsb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vishal!

On Wed, Jul 30 2025 at 23:35, Vishal Parmar wrote:

Please do not top-post and trim your replies.

> The intent behind this change is to make output useful as is.
> for example, to provide a performance report in case of regression.

The point John was making:

>> So it might be worth looking into getting the output to be happy with
>> TAP while you're tweaking things here.

The kernel selftests are converting over to standardized TAP output
format, which is intended to aid automated testing.

So if we change the outpot format of this test, then we switch it over to
TAP format and do not invent yet another randomized output scheme.

> CSV format is also a good alternative if the maintainer prefers that.

The most important information is whether the test succeeded or not and
CSV format is not helping either to conform with the test output
standards.

For the success case, the actual numbers are uninteresting. In the
failure case it's sufficient to emit:

        ksft_test_result_fail("Req: NNNN, Exp: $MMMM, Res: $LLLL\n", ...);

In case of regressions (fail), a report providing this output is good
enough for the relevant maintainer/developer to start investigating.

No?

Thanks,

        tglx

