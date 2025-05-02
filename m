Return-Path: <linux-kselftest+bounces-32172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE242AA7152
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9001BA65FD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B684D24C083;
	Fri,  2 May 2025 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="hGtTGPzg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3E252905;
	Fri,  2 May 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188061; cv=pass; b=dxithaM9ljm4GfzJx7ZCuxLp/LTptYEorZ3kPX51EnyXjR+1Ldt821ZqKmWP2ub3wfARpu3ZKOKJlIr1AjuavvGfU+vSBW1JTrtZgdVix2+BypKuDLHGgLzite4NUqyeWQfqv+yOsICNQ4ZGhQbSDardlgAQvT8DXod9nYV48xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188061; c=relaxed/simple;
	bh=QWQ0tYUydSfvMr+CPdPk2VH7cysCF2J6Vz3KTfOueMA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZSrOwiB57EIbCFj+N7bnv3P0wecrXTbRq33p3Hr5mFR3h4NFyxkqItgibydBVtJNpqMhr48QatiZloDq3dgIQMVgRApa38CJExc3zWjiJJxMxqA/tkxMnE8AbPn/DTNsy8899hctnFo+k7/oRyggciE5Ygeu72TGyrSFBvqaIJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=hGtTGPzg; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746188049; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GbJQBUcLrVskjQDydlPHVXHWh4/z8entqzW57nLfZLw6dmynYihABXs4L9oKwBLOJfpURysXCUaSDTsg85IcVKZi6n9TIlF6+MvTWXclhcVWIRnr3h9PIRmOUMqNLewofLKFcqJpc4ma+I26I3UxIAXiEx8R+cu49Vj1ZELvklI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746188049; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4ws5VbGnfhpvS/oFMBDujAqRrocy+NzsCJj/FruTxjw=; 
	b=B4l+0br4CrJVYJqs1vnn2pDqrAwgcaFUynkso+RGWJbcQjy3sZcBqS45p+06+m1Nz9i7EHwdftu0zIJNZpb4Qa/k67yno/T3sOkQV/0TGrDkIC9JUIBEUQRYWYMNeiYvgp68gB1vM/LEn/6YVQ4YlfchZPLDAnbJ0ORMg/kzaO8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746188049;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4ws5VbGnfhpvS/oFMBDujAqRrocy+NzsCJj/FruTxjw=;
	b=hGtTGPzgYR/YsJTPCgz9TuBf6aD7T54LPkyZT8+JIbImCnLZB7IgE5vhVuh4FiLn
	B8f98+drMN1wx+wjJBXkVyQOUNOvtyomZUVrGpyb3XHh2qRa5sfxEaZVxVXFp2h2TLE
	TnKQgrAjyryV1PWvTFomuPbJcvm5QavOc1rSdx/Y=
Received: by mx.zohomail.com with SMTPS id 1746188046798467.3546517732965;
	Fri, 2 May 2025 05:14:06 -0700 (PDT)
Message-ID: <5203d87f-a098-4f76-81cb-4966181de4eb@collabora.com>
Date: Fri, 2 May 2025 17:14:02 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/timens: timerfd: Use correct clockid type
 in tclock_gettime()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>
References: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
 <20250502-selftests-timens-fixes-v1-3-fb517c76f04d@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250502-selftests-timens-fixes-v1-3-fb517c76f04d@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/2/25 5:03 PM, Thomas Weißschuh wrote:
> tclock_gettime() is a wrapper around clock_gettime().
> The first parameter of clock_gettime() is of type "clockid_t",
> not "clock_t".
> 
> Use the correct type instead.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/timens/timerfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
> index d6adf66bd8df064f5b76ccc265c13217d7a53f5b..402e2e4155450d946796b8297a8be85f93cea16f 100644
> --- a/tools/testing/selftests/timens/timerfd.c
> +++ b/tools/testing/selftests/timens/timerfd.c
> @@ -15,7 +15,7 @@
>  #include "log.h"
>  #include "timens.h"
>  
> -static int tclock_gettime(clock_t clockid, struct timespec *now)
> +static int tclock_gettime(clockid_t clockid, struct timespec *now)
>  {
>  	if (clockid == CLOCK_BOOTTIME_ALARM)
>  		clockid = CLOCK_BOOTTIME;
> 


-- 
Regards,
Usama

