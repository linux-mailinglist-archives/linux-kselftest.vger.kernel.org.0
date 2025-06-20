Return-Path: <linux-kselftest+bounces-35441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A118AE1DC2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 16:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDDD7A59A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCB628DF1F;
	Fri, 20 Jun 2025 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="M912qE+6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979C13790B;
	Fri, 20 Jun 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430786; cv=pass; b=bRXmwRATbeBBouv2Gcrsggt8WIxNOnr1Tnk9DlchRwooQrSurrBoN367Is7ul4dGwhwXaaj3zbY+EtWSoBcOfUIU3batvZC2iRLO4hDFmaRlQIYQxPYZ6xlI7hmJ7DDmkKfeXeGtWZuY0DFL67wLy7mlHKTC5nxpxUy8w2drxIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430786; c=relaxed/simple;
	bh=PpvyrQkffxhmR1q7V20K+UlimjIQx+HRj6CKHqnnVy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmYy23TtTW/uRoGahdPyyFTKNPheNXhHP8gBpZizfUTGMaF8g8N2tzqUqS7xmRfhUgAHyRYC+vE4VLKmMcSILAEMsMyBt2kWWiDeDg3X0d9cRidWW1e95pag/Yq7r0Iiis1RHApz558gjWRFcyjz+3sOzPMnPPJtuuyTAr6iGCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=M912qE+6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750430769; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SP6gEDuvqjKpHkatoJnIdb28sGkv+AsrhmWz8hm8rrBRwfLnQ/mdmvaRCsxKltRBuLh5OPwjTIG82ANpBSmNcJE+43E56hXoJ4hMPCMzh+Fo3otbQipriWdPAps+T5Awl6XaeXUp+IFd0NVgukSF796mfaFK9oHtUiMqbH5jHsA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750430769; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Psu+xuzYQO6iudnLnIdn9XrtXD88c1Y/UAcusUMIZuw=; 
	b=SqPQmv7vRf05q2cEGJ7sUSCs5/9ePlhazUG70l13w2epk3YlmMFGf5WkCZGMpWXaKSeMGUrVsSCqr5tZJPIIpdwQGqucEU47Mv8En8yAIzAKsz/0zkbrDgECMCyCR99BalSHgqVvGcUhMsFfvmVLRrv244gicJWHnS1fADDlEig=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750430769;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Psu+xuzYQO6iudnLnIdn9XrtXD88c1Y/UAcusUMIZuw=;
	b=M912qE+6ds7HgMbPbv061y8fi4J+IZ6UPlSTOSb9iTNKFvzv9Oe4HpyGVW84dgYh
	xgEnuilPSoxhcohBmAGpEXJV40dy3w5y2tcZDHa/ugPuIh77Wh/f9eBaGR8SDDbciLT
	bUviDI/+JV8mfJnjryme1w+FctLnHy7f6zcrGltQ=
Received: by mx.zohomail.com with SMTPS id 1750430767312803.3818926664306;
	Fri, 20 Jun 2025 07:46:07 -0700 (PDT)
Message-ID: <213adda0-1db2-46e7-9342-cc97fbd58d96@collabora.com>
Date: Fri, 20 Jun 2025 19:46:05 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/filesystems/mount-notify: fix unused unused
 result warning
To: Chen Linxuan <chenlinxuan@uniontech.com>, Shuah Khan <shuah@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Miklos Szeredi <mszeredi@redhat.com>,
 Jan Kara <jack@suse.cz>
Cc: zhanjun@uniontech.com, niecheng1@uniontech.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620035125.2938774-2-chenlinxuan@uniontech.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250620035125.2938774-2-chenlinxuan@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 6/20/25 8:50 AM, Chen Linxuan wrote:
> When running `make kselftest`, the following compilation warning was encountered:
> 
> mount-notify_test.c: In function ‘fanotify_rmdir’:
> mount-notify_test.c:490:17: warning: ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   490 |                 chdir("/");
>       |                 ^~~~~~~~~~
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> ---
> Changes in v2:
> - Apply changes suggested by Shuah Khan
> - Link to v1: https://lore.kernel.org/all/20250610020758.2798787-2-chenlinxuan@uniontech.com/
> ---
>  .../filesystems/mount-notify/mount-notify_test.c  | 15 ++++++++++-----
>  .../mount-notify/mount-notify_test_ns.c           | 15 ++++++++++-----
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> index 5a3b0ace1a88c..f8e0c6b06e2d9 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
> @@ -458,12 +458,17 @@ TEST_F(fanotify, rmdir)
>  	ASSERT_GE(ret, 0);
>  
>  	if (ret == 0) {
> -		chdir("/");
> -		unshare(CLONE_NEWNS);
> -		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> -		umount2("/a", MNT_DETACH);
> +		if (chdir("/"))
Please use the APIs provided by the kselftest_harness.h instead of checking
return types manually. For example:
use ASSERT_EQ(chdir("/", 0)).

> +			exit(-1);
> +		if (unshare(CLONE_NEWNS))
> +			exit(-1);
> +		if (mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL))
> +			exit(-1);
> +		if (umount2("/a", MNT_DETACH))
> +			exit(-1);
>  		// This triggers a detach in the other namespace
> -		rmdir("/a");
> +		if (rmdir("/a"))
> +			exit(-1);
>  		exit(0);
>  	}
>  	wait(NULL);
> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> index d91946e69591a..d6a6a7ee87028 100644
> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
> @@ -486,12 +486,17 @@ TEST_F(fanotify, rmdir)
>  	ASSERT_GE(ret, 0);
>  
>  	if (ret == 0) {
> -		chdir("/");
> -		unshare(CLONE_NEWNS);
> -		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
> -		umount2("/a", MNT_DETACH);
> +		if (chdir("/"))
> +			exit(-1);
> +		if (unshare(CLONE_NEWNS))
> +			exit(-1);
> +		if (mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL))
> +			exit(-1);
> +		if (umount2("/a", MNT_DETACH))
> +			exit(-1);
>  		// This triggers a detach in the other namespace
> -		rmdir("/a");
> +		if (rmdir("/a"))
> +			exit(-1);
>  		exit(0);
>  	}
>  	wait(NULL);


