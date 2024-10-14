Return-Path: <linux-kselftest+bounces-19676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 395C399D996
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 00:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0183B21799
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 22:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4DB1CEE84;
	Mon, 14 Oct 2024 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JGFaoR6k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h1QAgbnR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795813BC02;
	Mon, 14 Oct 2024 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943414; cv=none; b=PrpROlUVRgSJ3//uWhWInexbBZ1Z5XGrt4Kxi2LD+E7kliXyfKAywD7tzh4D3c1xowPEo5pX0cxQRsmJ0WVN5imYwFY0KXujM7B7suSR9ttQHpolFL7tNllMhDacNuybuKS3+RzB09ykAePnXWw2/ggS9SZWmO+1Pbj75BTd1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943414; c=relaxed/simple;
	bh=Zxy8QELMEx2E93QesbYM0YH1CfErUGx78v2aKitkTMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dp6uZtgjmGToFaRIas4PWN+dxWoBLVrfNL9YsWXG4HUD7UXgUQG+kIHKxDGAdsE5X6VzA0xOrD48lnQEbaZ+EZSLca5QBaZx46E9kfDHma4mF+w5AMQJ9wKVVEcjkjQHg1mZISv3zjH5Pswc5lzelDZRrRG2lOzB2j2lO8MJIMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JGFaoR6k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h1QAgbnR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728943403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zxy8QELMEx2E93QesbYM0YH1CfErUGx78v2aKitkTMY=;
	b=JGFaoR6k7xKfrUhoz19Jq2Vtpsf4khSvSxq5hmYIYpN0S9BGVgcfs0auf7PtPalmmm3d2X
	XdnKy9cpvqFkkwMnhGj69Mph/ACGbNgly57n8ykjK2r+BZJctBIfV5XwpNXHL4WTI7egwu
	5ewH3p14zxF2DILMTHL3zckcihiB7BWZE2BDWd7n+5mUvFDXMCciCjaUNSL+75mOx3Z5/u
	czSPgZkrrOYm4+9tD4S9gb6JjBPtCHx2B7PlZvpoj9ztTRm1rnAn1KkjTq4hKAL1eQnmwv
	y+xqXnXKxAgLqUtSPP4+tep+H3rxRjg8lbq+5aL1tDTCZcEJuZdFbC+N3BPItQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728943403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zxy8QELMEx2E93QesbYM0YH1CfErUGx78v2aKitkTMY=;
	b=h1QAgbnRlX8f/WvWe5SQb8ArGvcCuDxf928TwEoI4dAtdiID4DRPIni2loOaL3qtltkWfD
	DwwX7l2/QJ/PQqDQ==
To: Shuah Khan <skhan@linuxfoundation.org>, jstultz@google.com,
 sboyd@kernel.org, shuah@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests:timers: remove local CLOCKID defines
In-Reply-To: <20241011225236.27677-1-skhan@linuxfoundation.org>
References: <20241011225236.27677-1-skhan@linuxfoundation.org>
Date: Tue, 15 Oct 2024 00:03:23 +0200
Message-ID: <87zfn6e40k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 11 2024 at 16:52, Shuah Khan wrote:
> timers tests defines CLOCKIDs locally. Remove all local CLOCKIDs except
> CLOCK_HWSPECIFIC and use defines from time.h header file.
>
> CLOCK_HWSPECIFIC and CLOCK_SGI_CYCLE are the same and CLOCK_SGI_CYCLE
> is deprecated,
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thank you!


