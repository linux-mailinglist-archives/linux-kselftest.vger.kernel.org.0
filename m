Return-Path: <linux-kselftest+bounces-33253-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF493ABABB1
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 19:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760A91690BF
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 17:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B1220AF62;
	Sat, 17 May 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="FJFB4mdS";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="g38uGlfI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013831E9B1A;
	Sat, 17 May 2025 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747503412; cv=none; b=jE3Nr7WdpJVkPmPYlNaqBqvbeY4PkLhJYGeBCDRxQ/0NLJXoDRFqyhOVWRQsTtJoIaOZPSgywcnCQFehTXbPwaSGvsJMD1hbzziSQnf991SwOyVInDaj7GcX/4jSLHYpXQN6S3IuUvz2pYsf220VXhKFQF/omkTTPVkppWnBkw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747503412; c=relaxed/simple;
	bh=U4N0PRIlljAgiI2xZ1aESmjVplcg4CugebQZZJt2ji8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=i2AcMgb30DKznCIzQwhY7Ioxejq9M0jLpvCBC/nmvRSKfMpq8A2G5rxsJUD+WbpMOxiwJteCl56a34uyXh1KTTKQx4V11gBTX7rwJoZMSOJwm4c1g7KS7f2UkGEaYIv/cdLUoRAD0LtqIjv8ww4DH0AVb82yqmGYPmsdnnhYE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=FJFB4mdS; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=g38uGlfI; arc=none smtp.client-ip=160.80.4.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 54HHaCsU017523;
	Sat, 17 May 2025 19:36:17 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id EDCA112055B;
	Sat, 17 May 2025 19:36:06 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1747503367; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeIN7v3fjK5KQSpzz48J9uF1ajS37F4/hr5DQzTVUA4=;
	b=FJFB4mdS3UuPUUeupz6rn88391U//qtfOHyHSoz7FoiqqBS3+C5fh76SfZxS3ub4WAdU6S
	4UhfI1ddSgdLb6Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1747503367; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeIN7v3fjK5KQSpzz48J9uF1ajS37F4/hr5DQzTVUA4=;
	b=g38uGlfI1U4J6ErDLK8XGMwk8X5cXJHWAzVzOVvNCrGtPLH2gbZrx6euj+w0x85mvgh6Uz
	JDpRYj+7WPI5hQR+r4ZDSHOaLu0eWqzdd6fS05FUpXvj9rZcE1OwVzVSrGnaZFFVGKMA9D
	7KLI4VX4jCrR2ALn+U7vkdEdnblNLLBQ7SO9/aMNBacZMewiOZdqsLPI5dplxDFJ/c7/Zg
	mDV059tkPMF0EvD0hOJVTJ7svAfKmeLrdP9nSS9OIkRM0x5UVvhOjs8iPauZTmYGhxumDX
	fBf0/0z04Yy4bmS1XR0djzYc0y29r37g6YiW6ajIW3Iaq7QlibNVIvT1qez90A==
Date: Sat, 17 May 2025 19:36:06 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH] selftests: net: Fix spellings
Message-Id: <20250517193606.b678c3efc3ca4fa8d478f285@uniroma2.it>
In-Reply-To: <20250517032535.1176351-1-sumanth.gavini@yahoo.com>
References: <20250517032535.1176351-1-sumanth.gavini.ref@yahoo.com>
	<20250517032535.1176351-1-sumanth.gavini@yahoo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Fri, 16 May 2025 20:25:33 -0700
Sumanth Gavini <sumanth.gavini@yahoo.com> wrote:

> Fix "withouth" to "without"
> Fix "instaces" to "instances"
> 
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
> ---
>  tools/testing/selftests/net/srv6_end_flavors_test.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thank you for fixing the spelling mistakes,
Andrea

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>

