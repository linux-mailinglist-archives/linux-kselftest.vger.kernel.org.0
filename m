Return-Path: <linux-kselftest+bounces-32198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB84AA742D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 15:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28F54C0FD6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0D231846;
	Fri,  2 May 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="MftJrOxA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC882522AB;
	Fri,  2 May 2025 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193762; cv=pass; b=k/quRX5wVdfJ0QODDAqj2j2Bygz+VDc8StbtG0BGYZhPf24fPVU3lWydmo48cBpoF99BhcDUytbYEPMCQgtw7W9ba0nGFCvzibepPz+Bv4SWZyuWvPMsX+DQgVu+nKiqDDaDhR678ffjDlSgT2CXE1ACXfSgLWN8MiUjZM0df7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193762; c=relaxed/simple;
	bh=WL14kTMKwwQeDRA9M/Pf0DS2xteO+pBok71KFv+gb+Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RwMLaLk6/YDwaf4UnljS6k81zzJW48RiEMW0XYM7Hc3Yc4uN7uqt2E2L8znXbutU/XSJGiiZBvzsxxPlipWf7jsoQeTqhST2ZgLUYkGzqKG+EO40btk9Lk2im+4S6g5gXa196iGPUY/YVVGRoLThGqDulw3L7FasRvR06ACGQdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=MftJrOxA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746193750; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NpCh0jiArTROBLLSsxZRomGX+lID93gH/6ylTHvpn6y+lPpiC7gb+/MsXV6izKVUCepK8bOt8C6wLnWWwFSS2nF0jVBsWOK7BU0c1iJL6UO9Nrfm2GNgnI+SXZh22Yvmmql+wKduMmwCwSFne/15yZfhsxLVD1STNC+M35NY3ZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746193750; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pE3NQLQoX7pnUAcgzy4MZ9RTz0LXx0klT8KZ0dkll3w=; 
	b=isAIJSwDbCHZKxcFxRBwy3/iGuo6e2HrFuPmqjXGuqBAJfs9c7o79BAdLlo1jCxeD4UmAv6rZs+RaH26BkYrUVgYpGOIn7SM3TC/DntxI9rzLFtBGdFxib8mIZEgbgCWOS5I1NNyszV4bYevmxQJnsDwQtxSEi48bkHdqEqImtM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746193750;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pE3NQLQoX7pnUAcgzy4MZ9RTz0LXx0klT8KZ0dkll3w=;
	b=MftJrOxAYZ2AVoxrxaTeUIuLnUouUsIJtV2w8DX8DbS0MsKHQdOzFdz0Ll39eGec
	PKS4zzi/jRSLke4WPf9YNlKR54o1kvFjsYmk3LMij9WbJFZBI1gHNjN9pYzs6H7XIm/
	2eHKkgqm1/0Rxe3qSydGazl/GvS2rNX0/H2bB2iE=
Received: by mx.zohomail.com with SMTPS id 1746193747104988.1552914913506;
	Fri, 2 May 2025 06:49:07 -0700 (PDT)
Message-ID: <27d03a23-ec61-4dbe-b9ca-1c0cf3d52d29@collabora.com>
Date: Fri, 2 May 2025 18:49:01 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 7/7] selftests: vDSO: vdso_config: Avoid
 -Wunused-variables
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
 <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
 <20250502-selftests-vdso-fixes-v1-7-fb5d640a4f78@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-7-fb5d640a4f78@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/2/25 5:40 PM, Thomas Weißschuh wrote:
> Not all users of this header make use of all its variables.
> For example vdso_test_correctness.c does not use "versions":
> 
> In file included from vdso_test_correctness.c:22:
> vdso_config.h:61:20: warning: ‘versions’ defined but not used [-Wunused-variable]
>    61 | static const char *versions[7] = {
>       |                    ^~~~~~~~
> 
> Avoid those warnings through attribute((unused)).
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/vDSO/vdso_config.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
> index 722260f9756198956f0dfccced907284b6851e76..5fdd0f36233742bc47ae79f23d2cfae5a0f56dee 100644
> --- a/tools/testing/selftests/vDSO/vdso_config.h
> +++ b/tools/testing/selftests/vDSO/vdso_config.h
> @@ -58,6 +58,7 @@
>  #define VDSO_NAMES		1
>  #endif
>  
> +__attribute__((unused))
>  static const char *versions[7] = {
>  	"LINUX_2.6",
>  	"LINUX_2.6.15",
> @@ -68,6 +69,7 @@ static const char *versions[7] = {
>  	"LINUX_5.10"
>  };
>  
> +__attribute__((unused))
>  static const char *names[2][7] = {
>  	{
>  		"__kernel_gettimeofday",
> 


-- 
Regards,
Usama

