Return-Path: <linux-kselftest+bounces-35250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B2EADE44F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 09:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B838917BDFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442E627E06D;
	Wed, 18 Jun 2025 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MXsffNgP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WYBe9HNJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8878F36;
	Wed, 18 Jun 2025 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750230520; cv=none; b=RO6BhAXUWheheHraV0xJFRZNUQutb7uS9fQRNnVJIeUyQfBzq2WE63EbufzbVrOzNP6KzThLDvLOLwY8g0O3JwhxeuhAUU094cGFVRugYOKDF8ZVjBz5M/LGW3Ksxnjf/CZA9ftnyp3C/XtSgNf3s6wMMpT0WLnlt3kRZ0cs3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750230520; c=relaxed/simple;
	bh=cHNGWjr3X5xw71GSXE5j9c2WF7a5O2/l2rfVpkeyTus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRFFmXVnJczlg0e1CvmQrMHzfpw76abqNbB6G8Xeh0v8XZlstq9T5TQlK87uKcayg1ZfCDRVxuCTIw0nLsbGIXpyZH2579WMZnlUw3+5BpuE2d6Bta24laxIO9hmII2octo8VYFD21Tzw94wcgPIV2sfqf2HXmYD4BN3448/dGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MXsffNgP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WYBe9HNJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Jun 2025 09:08:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750230514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv+QWbqSIJiJdEEysO8YVV6U0lSqwpLJFjq5bgPk5uo=;
	b=MXsffNgPYniWRqsOfEgtTPfNzwqWD8WDLcObD0TkBBd0Rd8k8MIwdaUO0+pR0zOTwbA9r/
	RJhi2yIJB80TlQgq4Zyc7HiCHOEHQQfwGVICNci1NlB8MoR3re0rtr+ex1a4esAyzdIyh+
	Cb4BFi6MlCVM0+cImnLL5uNt8RfyzOUZ2u9Nj4AZ6DXa2GbgxqeutlOqp2wGEwXiETevOc
	3Pn+8S3bDgCI6ZVKeQ5pT7a3S1smkucfeLlNt3/W6amrNf+9K8U4aotNcvJtZX5kEMOy+q
	rAI9bhcWirWeRh9NeXMW8oM6aFUi4uXErfbHdgoFfLErh+SUVHwof0ByvcBQCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750230514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gv+QWbqSIJiJdEEysO8YVV6U0lSqwpLJFjq5bgPk5uo=;
	b=WYBe9HNJxGZPAIYdwN+XrWmq1mD3UbAg+GxdfBtsZRl/jPeziQStfKvzA09RfWOmLyst1o
	pAMUtqCZ/JIn/iAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH RESEND v4 0/7] futex: Create set_robust_list2
Message-ID: <20250618070833._qeCcHLx@linutronix.de>
References: <20250617-tonyk-robust_futex-v4-0-6586f5fb9d33@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250617-tonyk-robust_futex-v4-0-6586f5fb9d33@igalia.com>

On 2025-06-17 15:34:17 [-0300], Andr=C3=A9 Almeida wrote:
> This patch adds a new robust_list() syscall. The current syscall
> can't be expanded to cover the following use case, so a new one is
> needed. This new syscall allows users to set multiple robust lists per
> process and to have either 32bit or 64bit pointers in the list.

Thank you for the reminder. It was on my list, it slipped. Two
questions:
- there was a bot warning for v3 but this v4 is a RESEND. It the warning
  addressed in any way?

- You say 64bit x86-64 does not have the problem due the compat syscall.
  Arm64 has this problem. New arm64 do not provide arm32 facility. You
  introduce the syscall here. Why not introduce the compat syscall
  instead? I'm sorry if this has been answered somewhere below but this
  was one question I had while I initially skimmed over the patches.

Sebastian

