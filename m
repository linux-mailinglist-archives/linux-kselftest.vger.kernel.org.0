Return-Path: <linux-kselftest+bounces-35941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D07AEA955
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 00:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B951C42C64
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 22:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CE52609CC;
	Thu, 26 Jun 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lf/H7SPI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GH86Pf0x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3023B634;
	Thu, 26 Jun 2025 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975672; cv=none; b=ftVnhJ9OgS1TQSd6eqc27s+5Yjk/N7WqazTkukrpqq8Og95S/fD3U1UizHCyPm3gbsm9WmLMzaS0nsPvV+Eu+Pt62nlD9j1wpGAhjsIebKlA21pzdcsneBSqxS0hDnaWqe//1CtLKZGFBq+8AHm9+fCg4scgM/GFt5rUv8nxTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975672; c=relaxed/simple;
	bh=bUTpjLkfsFNOyjEtEopr5we1x3Roxq22HlCVo4NPojg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fE4fBLCowK+WBJogZPSWQ7l7VW/jFsULdUiK0c82H2u5xJsNwjBeBQn7iRZ4Bwz+CLA3Md9ICDLNRav6VovDOXNm+5n8Cl19aTR/H3AnG5zoQ8olTKmJ0PsMhJ7xJOpySVw513RZ52Z7wTb5Zrkk8qw7NHuup4FstLLF0rQF3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lf/H7SPI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GH86Pf0x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750975668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HC18m67HnK1X7lBUoyKEQKdHSun378qI4UuLYILh+NY=;
	b=Lf/H7SPI9D1X41sl8/1PmcSDXSU+nBDjIp75Y8ag9fGOojziddK0AyFpAalXGu3vIbVxCA
	XdE8ndUKS9SqPYuGgbBHs9yfM+pVczvyz/10yu1TfFDUF6CG1DYJKv0M5JqMJEgTPswQ51
	I4e1doPL7tEQq4MViRBvq6YtpKV3dSBkfw6g5e6U1Gp27j3tOJJqBiukeC5uKq1avDA2b5
	qzG/5SeV6IPNSTKgfOgsL0ByG8NQ5YHS+g7uTmQWVmYQQobRn0l0lf6myNo4hf5GQCyK+e
	rig5SKzFcjIU0kJopQxB/s1r7D/9eTUMzC8yg/b46Wk8KZgepzxIthvKTO5L1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750975668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HC18m67HnK1X7lBUoyKEQKdHSun378qI4UuLYILh+NY=;
	b=GH86Pf0xVcsQMuaOc7ow/3xdfB1Ix9yyJQEkxG1NLTStZfk85b0HXAsHlgduJf47xXELdh
	/GrYTgk9Z0qckhCw==
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Ingo Molnar
 <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, kernel-dev@igalia.com, =?utf-8?Q?Andr=C3=A9?=
 Almeida
 <andrealmeid@igalia.com>
Subject: Re: [PATCH v5 1/7] selftests/futex: Add ASSERT_ macros
In-Reply-To: <20250626-tonyk-robust_futex-v5-1-179194dbde8f@igalia.com>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
 <20250626-tonyk-robust_futex-v5-1-179194dbde8f@igalia.com>
Date: Fri, 27 Jun 2025 00:07:47 +0200
Message-ID: <87ecv6p364.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26 2025 at 14:11, Andr=C3=A9 Almeida wrote:

> Create ASSERT_{EQ, NE, TRUE, FALSE} macros to make test creation easier.

What's so futex special about this that it can't use the same muck in

tools/testing/selftests/kselftest_harness.h

or at least share the implementation in some way?

Thanks,

        tglx

