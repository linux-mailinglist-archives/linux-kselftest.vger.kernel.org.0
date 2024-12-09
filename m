Return-Path: <linux-kselftest+bounces-23097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069449EA19C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 23:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7CE165F5E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 22:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD2419DF40;
	Mon,  9 Dec 2024 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="eq6rBrXE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3B19D09C;
	Mon,  9 Dec 2024 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782096; cv=none; b=jq9ZPC6CRSxEfIqv6najnCKG7obwqYTndo8sLYxgelnZY1318z8M5pbhO+oIU8RMOxWOAPYZCiWAvhM85HQrFG/I9XrKDNeErXQmxcNNUMe9Pkm5/p9QzlX9F8l7rF72/4VXwQL+MFaPlKYTnrtguXQ/Fmu44z6uxPw3zQ+dut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782096; c=relaxed/simple;
	bh=YQP7Vm9Rxid83J7kxwOmzl2MBLiP1Ksx4ETsVRk0CQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fl4sfXAcISsdBIs/CLVyrVuzuIhtWvx4NXXOr8xnZ4tJLZOHGDrunxAf+RnWcEmII0qlce68QAuoiXHks/CEGv2h9hI/EQQr2j/91rU1+yq3ESNl1NVXhQFecjo4W5FJNq+UDLstybxk7q+WLrZmjOoJlanQWTKf/6GSrqwwl7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=eq6rBrXE; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iWvx2x9ooVEYNbiylKsyE1zaerIXD/mHg0CGYlYga6Y=; b=eq6rBrXEmYnzziiWUvvbnuQBYz
	MMGI3UTv5SV7kahOnXo1kirzwd2wSVDMjrv6dKUzK0S6lwXL+DrJUqUoJUts7bN2LGc0bQSJiE/Yc
	eTqlEgaBcCGJAJ7xjnTd652ClIwhUgQII1vap0FWyUUhMCjaLZmwkR1x1X6TjzELdC0VT5viMB5L0
	7EkUDxpxppRV/coEVL6hIF6KRBChKcyLoVzRRFeOb/YeOi3gsDDJYRJkzQmGC1mfyUeX7UoPttJa3
	pWP3noyiuc3ZCQW6raiRKA2KiD8W12N/2CiNtJxuZ9f5q1BeDg1su7wzs+VmFLHFd3p0ViJzvigI0
	uJ/+l/Yg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKlvE-001XdL-1u;
	Mon, 09 Dec 2024 16:08:08 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, shuah <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v6 00/28] NT synchronization primitive driver
Date: Mon, 09 Dec 2024 16:08:08 -0600
Message-ID: <6110961.lOV4Wx5bFT@camazotz>
In-Reply-To: <a6ec954d-7794-483d-a1f3-d58d33c5fc7a@app.fastmail.com>
References:
 <20241209185904.507350-1-zfigura@codeweavers.com>
 <a6ec954d-7794-483d-a1f3-d58d33c5fc7a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 9 December 2024 14:24:36 CST Arnd Bergmann wrote:
> On Mon, Dec 9, 2024, at 19:58, Elizabeth Figura wrote:
> > == Previous versions ==
> >
> > No changes were made from v5 other than rebasing on top of the 6.13-rc1
> > char-misc-next tree.
> >
> > I would like to repeat a question from the last round of review, though. Two
> > changes were suggested related to API design, which I did not make because the
> > APIs in question were already released in upstream Linux. However, the driver is
> > also completely nonfunctional and hidden behind BROKEN, so would this be
> > acceptable anyway? The changes in question are:
> 
> If it was impossible to use the driver, there is no regression.
> I feel the entire point of marking it as broken was to be able
> to add that type of change.

Makes sense. [I figured that the BROKEN was just there to prevent anyone from trying to use a half-finished driver, and the point of committing a half-finished driver was just to reduce the number of patches that needed to be resent.]

I'll make these changes and resend.

> > * rename NTSYNC_IOC_SEM_POST to NTSYNC_IOC_SEM_RELEASE (matching the NT
> >   terminology instead of POSIX),
> 
> No objections my me on either name.
> 
> > * change object creation ioctls to return the fds directly in the return value
> >   instead of through the args struct. I would also still appreciate a
> >   clarification on the advice in [1], which is why I didn't do this in the first
> >   place.
> >
> >   [1] https://docs.kernel.org/driver-api/ioctl.html#return-code
> 
> The git log tells me that I have written that, but I don't remember
> why I put that in, maybe someone else suggested it.
> 
> My feeling right now is that returning a file descriptor number
> as a small positive integer from the ioctl() return code makes
> sense. On the other hand, returning pointers, negative signed
> integers or large (> 32bit) 'unsigned long' values can cause
> a number of issues, so I would avoid all those the same way we
> discourage passing those integers as a literal 'arg' into ioctl()
> instead of going through a pointer.

Ah, that makes sense to me, thanks.



