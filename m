Return-Path: <linux-kselftest+bounces-4933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB1A85A7F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 16:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0893F1C21656
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 15:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81803A1BF;
	Mon, 19 Feb 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GPxqfQHd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XviUiotF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BC38393;
	Mon, 19 Feb 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358303; cv=none; b=T2M0xZZHKCszg/H6Bzo111dJPbqn4Kz+bvR8Yk4kUkblF7dthy+FgNbilSvS7B2wUx3pZK9Zawz4lCPBxHRk+r8cjmYyYyeoWc5qf+2LFE+Uc2svTRrIfjtfIemWyw+mFN9CMAy7J9JlO/r+24jlUPX92ASMKSEGlPYYXdF4GdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358303; c=relaxed/simple;
	bh=rFwMMBFUdhPcTvNaPk2xYMZYHAzjVITuhv7BgExyKIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IcHTRiM7zUYHxH7kDZs0e5dHnvo3JfLZHbFSYVIQjQoGWlJgZDRQ3mkvjjhihkmQdo8/ceX/y0rm+5B2D6gO2UJGcnMngh6XjzWkKOpUgrqc0nfNMvWkQrqxw/62j0i8qDQvz9X35Ue6eRShxf9zCS9tsqG6Lcpe7QbHExwRyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GPxqfQHd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XviUiotF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708358300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFwMMBFUdhPcTvNaPk2xYMZYHAzjVITuhv7BgExyKIE=;
	b=GPxqfQHdDVGPe16hxyMjbQmPM/E5x6D4fw1znsaz5lQUIgLRrj4Kda1rV4BVrRy86wnStf
	TcX2FspPrnWSUF3vyE/zfnTrN79gK/gfZ/Yqfuog+hAw6jQGkUI6Q06tqmaTJv/M75nttw
	/jxRjvxxdO2uRH8HZpaIgLEuXjpTUlr4Eq2s6e7tcmHeEYISY1zusahH/5E63/FxCVHPr/
	HX2BX41MOxESfzzyq6pFO6t/ugEAOe4IFonFJIu+YpbP32gFtGSr5CeBrqbLu8r4c3Ieta
	DJRSU8Ga07U0VI/sHaAAWb4i/98/y8UcafSWg+fzFao2Lv1tnodfPHDV3E2PAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708358300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFwMMBFUdhPcTvNaPk2xYMZYHAzjVITuhv7BgExyKIE=;
	b=XviUiotFDKVgubYpneSdMvTQX2cvw5F4KosxH74OTmdxeWWgphD3VIu+qFEXw4G7/w2b5O
	Obhe9kaToGvCdgDA==
To: Mark Brown <broonie@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Mark
 Brown <broonie@kernel.org>
Subject: Re: [PATCH] selftests: fuxex: Report a unique test name per run of
 futex_requeue_pi
In-Reply-To: <20240213-kselftest-futex-requeue-pi-unique-v1-1-fa160a4a7ade@kernel.org>
References: <20240213-kselftest-futex-requeue-pi-unique-v1-1-fa160a4a7ade@kernel.org>
Date: Mon, 19 Feb 2024 16:58:20 +0100
Message-ID: <87a5nwjvj7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 13 2024 at 19:06, Mark Brown wrote:
> The futex_requeue_pi test program is run a number of times with different
> options to provide multiple test cases. Currently every time it runs it
> reports the result with a consistent string, meaning that automated systems
> parsing the TAP output from a test run have difficulty in distinguishing
> which test is which.
>
> The parameters used for the test are already logged as part of the test
> output, let's use the same format to roll them into the test name that we
> use with KTAP so that automated systems can follow the results of the
> individual cases that get run.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

