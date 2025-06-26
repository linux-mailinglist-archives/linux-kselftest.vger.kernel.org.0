Return-Path: <linux-kselftest+bounces-35940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF945AEA920
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 23:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDC13AABCD
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D8260579;
	Thu, 26 Jun 2025 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WCaLtdU1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cqtg9Jxa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8698238141;
	Thu, 26 Jun 2025 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975071; cv=none; b=NSR2PoYH3CfiM5z+ydvsRAFzwJwaAKP9xVHU/Fpi3StNk6pWT1NIansSD/OMi5o+obK5+JMwzAYgNvLl2HsCGhEdnhr10KclypYT8qdSi+xdKqEadfg/NcYAz8TPN/RIehPy5e1lcLpnPanW3OAoy7x0ITfzhfNMqJGYKyNU08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975071; c=relaxed/simple;
	bh=xesDUzy5KFg8MgFwzfjLZ6Rzxtks1lLbUr4/8Nzwl2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hYGh90RDyHZx96mJVJ+xErPbjt7oLZGTUqp1ejUyX9NpuiCp3TfvjYmpFv79ae0cHItShgJpZHXguk9ne5PlEKVDOK+aUHJy+GZy9npqdeeMm3DA4BdEKQ4xFME47HLgjLn4HeKqFaznJTJKYttTomo1aJh+LQkKgbDD1zkm7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WCaLtdU1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cqtg9Jxa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750975068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otIwEUD4MnfA+ApsQ6g3fYceIHcbh7sTqwImrXm2izI=;
	b=WCaLtdU1QlYxmHtrLu0z/tkeaSHoGJ0UYeLPWzhXA3D+ISV9eSYZWmIi5iyYM0PGenQPCh
	ZzRD5MevlnlhtMoNbJzOSKBzZmzfxbUOGHeiniyE5Lon4nTRHXnKh1Yt1pIu1r0BnJDXaV
	Uo9W0wZiLAukoOMDL91wxsfd8Xi2xT3qv75sLf6uD1fgKJtUyblP4h2C7u8TUUl/OhEBx1
	H3t7VB4U/CazSArc2YXb9eInuJBAiIZmLQeWtVln3PT5+FBSLYmnlDvFwE/V9F9T+1gICr
	NhN6nBH4NQUNNEwijpoD2q6K+5blIQ8/on0LPZ/DO02J6QwKAmDM5hSiJMumrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750975068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otIwEUD4MnfA+ApsQ6g3fYceIHcbh7sTqwImrXm2izI=;
	b=Cqtg9JxaYNfSfSRrBjVcw9/tnU37FOnETGr/ezE3fMdC8XX5nz1XN1/YgBHwqGv5j/wkeD
	OUpjiY+H9579yeBg==
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
 dave@stgolabs.net, andrealmeid@igalia.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 tim609@andestech.com, Ben Zong-You Xie <ben717@andestech.com>, Cynthia
 Huang <cynthia@andestech.com>
Subject: Re: [PATCH] selftests: futex: define SYS_futex on 32-bit
 architectures with 64-bit time_t
In-Reply-To: <20250527093536.3646143-1-ben717@andestech.com>
References: <20250527093536.3646143-1-ben717@andestech.com>
Date: Thu, 26 Jun 2025 23:57:47 +0200
Message-ID: <87h602p3ms.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 27 2025 at 17:35, Ben Zong-You Xie wrote:
> glibc does not define SYS_futex for 32-bit architectures using 64-bit
> time_t e.g. riscv32, therefore this test fails to compile since it does not
> find SYS_futex in C library headers. Define SYS_futex as SYS_futex_time64
> in this situation to ensure successful compilation and compatibility.
>
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> Signed-off-by: Cynthia Huang <cynthia@andestech.com>

This Signed-off-by chain is broken. See

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

and the following chapters.

Thanks,

        tglx

