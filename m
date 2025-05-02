Return-Path: <linux-kselftest+bounces-32171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8FAA7154
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91029466572
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14882517A5;
	Fri,  2 May 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="R4ljSBCC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D004C2512FD;
	Fri,  2 May 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188053; cv=pass; b=oFjgqysUk9+TqN9C3yh9hZzkUAlX3DOQAwC8qUA7Wc6R9bHYp6bQFE1xhBaxpRxu7IruXshvgywPx6qkf3AVqWLPbdUTLh7CkXsORGJht5QXmk9z5bAwTa8tM0Lb2FQ7OdEoseSJ2IPAM1EGblv3EBrYk7cubjE8QIlRDrCbF4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188053; c=relaxed/simple;
	bh=cukr41OREukVPcBoVBo5RwV26CbtlH9AaAKdR/n7PVE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fl9TaJbDEZXJx3nnJDYrw8oPYzcqfC8RngPJ5x5arJbPIHGZhb7IqNNCkvhmXdq+jQcDTChcnaCYT51lUbLMX56Pp3v7BmhjtV0WuEawidKzu0DULHwyBGcwZKl41DmYx0C59mnSlg2PDCz7y6Tuer+Yx/PNH9XMWq23vQ0E4kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=R4ljSBCC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746188035; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hg8QkDi5kBNol6QloGidOaGom5QULlxEBWKd433d1sgZN5+51GRdWswX2TYVTEyraU0i2sSNGRZPyKDf5EcJ2T8y9A/w+jLFV46ejJ8s68QDFxKjLAckVxiWXm5cfaX4SeltqOvnOp1R6yYGOWctL4Z6ZEeK4izhXNBioy9LYWI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746188035; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4716UgEygYpemJT8cJREUYVKbkZC8m6opgidrhDsR6Q=; 
	b=lMOHuQ0SX6bIJwCMugFvEnlCaAWh/5JI563xGYZMS84PGjBFOZ7Xhb9v3zzcjK+nQoZXHYOR8qBKmztqKt8QAeAvZCkTU9U0pgJhjM9scSkbTZ2Vc2Z30x2TfLsxVM9JX5cYc7WpUPj0JZFkrdZ+VUwoHW/Pqy8TxCE3jracHeI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746188035;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4716UgEygYpemJT8cJREUYVKbkZC8m6opgidrhDsR6Q=;
	b=R4ljSBCCvNbimcCmx0fvuqMI3HL7x3k1/qB2crm0Wi3WXr1tr/3PC5uSw08VD7HP
	xilHdWKqUD00cIh4M1g/PqnXPqTpg3gBEOP2aTWvURtps1G9O8ZUtwFsRUtRImX49Mz
	2QlqwuwTWNLPTSfduMc4MagZrW9e4DcOes3fuTwM=
Received: by mx.zohomail.com with SMTPS id 1746188033754327.06759388118746;
	Fri, 2 May 2025 05:13:53 -0700 (PDT)
Message-ID: <7868a82f-3da9-4a25-8182-4634b808ec53@collabora.com>
Date: Fri, 2 May 2025 17:13:51 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests/timens: Make run_tests() functions static
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>
References: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
 <20250502-selftests-timens-fixes-v1-2-fb517c76f04d@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250502-selftests-timens-fixes-v1-2-fb517c76f04d@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/2/25 5:03 PM, Thomas Weißschuh wrote:
> These functions are never used outside their defining compilation unit and
> can be made static.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/timens/clock_nanosleep.c | 2 +-
>  tools/testing/selftests/timens/timer.c           | 2 +-
>  tools/testing/selftests/timens/timerfd.c         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
> index 346bff3d128dfa8c8c743cc2eba74917994bb2f7..5cc0010e85ff00e00c89940a82268994a1769873 100644
> --- a/tools/testing/selftests/timens/clock_nanosleep.c
> +++ b/tools/testing/selftests/timens/clock_nanosleep.c
> @@ -38,7 +38,7 @@ void *call_nanosleep(void *_args)
>  	return NULL;
>  }
>  
> -int run_test(int clockid, int abs)
> +static int run_test(int clockid, int abs)
>  {
>  	struct timespec now = {}, rem;
>  	struct thread_args args = { .now = &now, .rem = &rem, .clockid = clockid};
> diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
> index 51babe63e233bdaaef35c1cafbcb5b5cc91c021e..79543ceb2c0f97fdd638271a762c97a8b19d9a4a 100644
> --- a/tools/testing/selftests/timens/timer.c
> +++ b/tools/testing/selftests/timens/timer.c
> @@ -15,7 +15,7 @@
>  #include "log.h"
>  #include "timens.h"
>  
> -int run_test(int clockid, struct timespec now)
> +static int run_test(int clockid, struct timespec now)
>  {
>  	struct itimerspec new_value;
>  	long long elapsed;
> diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
> index e58bc8b64ce2738dccb8c2a2c88e592c237b55d5..d6adf66bd8df064f5b76ccc265c13217d7a53f5b 100644
> --- a/tools/testing/selftests/timens/timerfd.c
> +++ b/tools/testing/selftests/timens/timerfd.c
> @@ -22,7 +22,7 @@ static int tclock_gettime(clock_t clockid, struct timespec *now)
>  	return clock_gettime(clockid, now);
>  }
>  
> -int run_test(int clockid, struct timespec now)
> +static int run_test(int clockid, struct timespec now)
>  {
>  	struct itimerspec new_value;
>  	long long elapsed;
> 


-- 
Regards,
Usama

