Return-Path: <linux-kselftest+bounces-4069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53917847E51
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 03:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0271B2661D
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 02:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3DB538D;
	Sat,  3 Feb 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="O0ul/Ycp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237863AE;
	Sat,  3 Feb 2024 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706926126; cv=none; b=b/MPN7mgH1RTc6YsjikGauH9MWnT3EnAWlnAp8XA8oB+rZuHcRc3FwJbNZk92wwTzKNBzzxf0hBimdkNSGBakyJI30nTZJtAP++iR4iFfkaEMQ+335mrOUtYsqYc6937OzrJkZC+AH3Xex7IKdRVcntX2wRb6WovtkDaK/pUojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706926126; c=relaxed/simple;
	bh=lTPYk3uP/7Hs53WTMe3kG3GlscZKfUoKB1OWY+JmyB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJ8kf7aRPD83urbXbX37O6JVi2123EFQHXDXgd+hNJXYRqMPP7qcA/RtMY6F8ifDO3X51cOeXzofwK9KLX5M6ue+DNItrRvRY/sqsykVmhnq5H1MJmXHD1rwAyPOKKt4AzwN8M8jdwiD6bdgs75f68I/p4lTj0U+3mkwCEonZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=O0ul/Ycp; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=BISZmxAxuhGywf5Psgs5bYnINGRpQwP9TOf62KALg00=; b=O0ul/Ycp0twiaFNrgQRhvbYf9U
	mKP/lf2M9IbeqHZdncibjWOB4y/TXBubUhfXY7OdwltC6Ug3kl5o2pLf//u6yBQA6483CQSOomTC+
	mBnr4EC34Ta/fIuSLNMe/adQVSwhI0AXu8cbmuMlZ3FyJGk2WB6F+V2uJdhqMIdW+nRLuxNYGPRKg
	JR8Xppl2zWfoQDh93Q8l6NWMOLqJGLtRtmm2JmVdEgZtePWIAyUKxe3f8vxBOpOm8Z1lNVO7y/hG4
	JrrbyUIOaWuSpu9shYaCHQwP3wVDVkvvF9SZQaQDkK32pj/k8lcGIqAf11Ols0E0qR90qTXbhNnPU
	UDUw5/NA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rW5SJ-006FG8-2O;
	Fri, 02 Feb 2024 20:08:32 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject:
 Re: [RFC PATCH v2 19/29] selftests: ntsync: Add some tests for
 NTSYNC_IOC_WAIT_ANY.
Date: Fri, 02 Feb 2024 20:08:31 -0600
Message-ID: <8329156.T7Z3S40VBb@camazotz>
In-Reply-To: <878r45khqc.fsf@linux.intel.com>
References:
 <20240131021356.10322-1-zfigura@codeweavers.com>
 <20240131021356.10322-20-zfigura@codeweavers.com>
 <878r45khqc.fsf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 31 January 2024 02:52:11 CST Andi Kleen wrote:
> Elizabeth Figura <zfigura@codeweavers.com> writes:
> 
> > +TEST(test_wait_any)
> > +{
> > +	struct ntsync_mutex_args mutex_args = {0};
> > +	struct ntsync_wait_args wait_args = {0};
> > +	struct ntsync_sem_args sem_args = {0};
> > +	__u32 owner, index, count;
> > +	struct timespec timeout;
> > +	int objs[2], fd, ret;
> > +
> > +	clock_gettime(CLOCK_MONOTONIC, &timeout);
> > +
> > +	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
> > +	ASSERT_LE(0, fd);
> > +
> > +	sem_args.count = 2;
> > +	sem_args.max = 3;
> > +	sem_args.sem = 0xdeadbeef;
> > +	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
> > +	EXPECT_EQ(0, ret);
> > +	EXPECT_NE(0xdeadbeef, sem_args.sem);
> > +
> > +	mutex_args.owner = 0;
> > +	mutex_args.count = 0;
> > +	mutex_args.mutex = 0xdeadbeef;
> > +	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
> > +	EXPECT_EQ(0, ret);
> > +	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
> 
> It seems your tests are missing test cases for exceeding any limits,
> especially overflow/underflow cases. Since these are the most likely
> for any security problems it would be good to have extra coverage here.
> The fuzzers will hopefully hit it too.
> 
> Also some stress testing with multiple threads would be useful.

Thanks, I'll add these.



