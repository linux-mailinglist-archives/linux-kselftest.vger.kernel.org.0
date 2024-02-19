Return-Path: <linux-kselftest+bounces-4926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFECE85A1CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 12:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF031C21137
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF562C195;
	Mon, 19 Feb 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h1p2jKgq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Twcl0Bk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE62577C;
	Mon, 19 Feb 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341700; cv=none; b=sDx0ehH9IQv5IAzSP9EgHarcGWQ4+VRAhFGVDziu6coyoheFCN0heT2vrP2m1QWmfizRmugY6+INX0krOaAYxLQ4a6TpzhxrTcXWyOXOyvqwr8KW4PPhgx7qJuWfu8Y2hKycO1uS+6U7yHsRQIqCoBS7umB4bU8nG5cn5Y0H30Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341700; c=relaxed/simple;
	bh=vrHqKXwagZKp+wtCGTswoy1NCpqZymYPf+H1eT74R8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FwI5h5k6HsT+Hes8UJWtol0u4pS13vNgFBVprpr+ZI/zD3NyHfwfQcxtmKTaVfNYfxO+crD+1KDr1M8p8OYVUjJgEaNlBbu7uoffg/DASpvYU5lqZqD+Jbp/7eqJlECL3ZI6Ibk9icWqNygNY2CvmbKFNK6H7cJy3IMH5pXzg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h1p2jKgq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Twcl0Bk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708341697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vrHqKXwagZKp+wtCGTswoy1NCpqZymYPf+H1eT74R8c=;
	b=h1p2jKgqA6YUYFBs9K6MGvaMSpgXfGyfe8eKn74rqnY1jGf1tkRsHDiiIJnuh3Q6Gg9eGA
	McCn8bfiyNocKRon1FBeSe8r5pihJpIXKEVtrTvdaUBqOEEp+At/e3IuWsk4/agCweYnCq
	ymEsjxCtwYkchxweVCGnVYHh2Us4Ilen2J3piQlbgFZ5PnbO/SyMRzOoMlDe/qdAMgVboU
	MOIZpOaI+tNWteeYuBTiF2GEgIvJpqWOuPhSU3dkfBWiocpNlFOcEc4J+9zxYeFrkyMyD9
	kiN3NmIa/l2ZUT0YbU0HTFXtVYU7B7k2unA4JKZLOrhf5X70lvUJGhnWmX1VCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708341697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vrHqKXwagZKp+wtCGTswoy1NCpqZymYPf+H1eT74R8c=;
	b=/Twcl0Bk87bP1Zxh2omV2wAKv6JxpxzShy91zuxu+vHhDmMoFfJYtaus6ox9PrUHS5lVuz
	yS6Yb2pZHHa+AHAw==
To: Geert Uytterhoeven <geert+renesas@glider.be>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH resend] selftests: timers: clocksource-switch: Adapt
 progress to kselftest framework
In-Reply-To: <7960007c8517109b592995ad10a3058fbe5aae75.1708003520.git.geert+renesas@glider.be>
References: <7960007c8517109b592995ad10a3058fbe5aae75.1708003520.git.geert+renesas@glider.be>
Date: Mon, 19 Feb 2024 12:21:37 +0100
Message-ID: <87plwsaeda.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 15 2024 at 14:28, Geert Uytterhoeven wrote:

> When adapting the test to the kselftest framework, a few printf() calls
> indicating test progress were not updated.
>
> Fix this by replacing these printf() calls by ksft_print_msg() calls.
>
> Fixes: ce7d101750ff8450 ("selftests: timers: clocksource-switch: adapt to kselftest framework")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

