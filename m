Return-Path: <linux-kselftest+bounces-4711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87C6855815
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 01:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCCD1F21DE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD216440C;
	Thu, 15 Feb 2024 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="e85dqPxE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A087523A;
	Thu, 15 Feb 2024 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955291; cv=none; b=K+JNJovDxlOa0qLqr00RlztEKazCuMtxM6IUfdUNoewkqQHglX7PDHi05PMOvCdKi2NefmxLZKJkaEbeS47iIupyMcJMxetRDdwdPF+LCLiu5cM1sE/lHCoA6DUVclyyJvuU9dKGwiwJuwqRCqAjXmCdzdnZLI/XmEHHnNrosww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955291; c=relaxed/simple;
	bh=413kZihy2KHMUEMrs3SEXj+4Jj62ZkRrmUpXVGfjCnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nq2Pt5MBTYMeFy84N5WMI5Wf3r/YT1higM83uyfvJEnyGJ9WlgpVYIFXKvVzhLCXv7A2QRcKybKpJAqTOxDWkBvG2K1Y3CegPjqy1NLyJ9v9lbhBaNa2rvP9ZNfJhqMuK+dZwgrQ7eZIuxrU55zrZGthVh5eeod9tIvQNivKzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=e85dqPxE; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=413kZihy2KHMUEMrs3SEXj+4Jj62ZkRrmUpXVGfjCnQ=; b=e85dqPxE9Fm4j4ffjuLnIatBoP
	z6tR7buO5Vvq5dSWkdPMjZwqyeBQ6ayiYoOy4UGvjE2Kep/xJ7wbnfhlik8wLaGuYYiZejFegi536
	DYH7Rkvaztws9nXuqcI3u6kg8Y7MCDqCgP+Gqol50khrrGCAth3nsEVK+SuUQ4dHhSvg0bw+G9c9P
	qKZxCM/R0m7FAiDrt67tbonwY3qyGaX9RSsATmVcNCDfFNwTmXapqaFSJzG9xCJx9BR6oPGF13mWI
	G5+hz1Loeo9R3rvrj6xhH5XYq0sWKtkYsQdaUUNdpTGwwtxKHiQ6BC1+YJQALBm+G3xO4DyUkzvdR
	XYVyNOeQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raPBq-00Gd5m-22;
	Wed, 14 Feb 2024 18:01:23 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/31] NT synchronization primitive driver
Date: Wed, 14 Feb 2024 18:01:22 -0600
Message-ID: <5754084.DvuYhMxLoT@camazotz>
In-Reply-To: <20240214233645.9273-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 14 February 2024 17:36:36 CST Elizabeth Figura wrote:
> This patch series introduces a new char misc driver, /dev/ntsync, which is used
> to implement Windows NT synchronization primitives.

Ugh, sorry, I made a bit of a mess while sending this revision. I accidentally
sent 000* instead of 00*, and then tried to fix it by sending the rest with
--in-reply-to but forgot to also add --no-thread. Please let me know if I should
resend the whole series.

--Zeb



