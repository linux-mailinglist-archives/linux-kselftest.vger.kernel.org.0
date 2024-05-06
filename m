Return-Path: <linux-kselftest+bounces-9501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5CB8BC69B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 06:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712A128161D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 04:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9B45009;
	Mon,  6 May 2024 04:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4GFRZ6GJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F843AD5;
	Mon,  6 May 2024 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714971136; cv=none; b=e5T1Vp7rHPNwuWR5TEXT/REK9mvgctXbyTuDu+Cjw0EvSOFd70zFT3FV3ZGFLusz/aGpGEO2f2IxZIcBqmRIzStDn6EJebmzsm/Rh2/l5s/iC1zG8fSEJ4JmJn14TPpEexEw0i3dVOpM7lnO4V9RJFUmugmT6SXqpzuLTsCsIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714971136; c=relaxed/simple;
	bh=Qo9oR0uLK9UQeYxvmrg6jiYCbiXcdox6/UsyUwzx4Jg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R/7048s5oRzFNCkklRAiDCBLIy9XBmwuv8qlE15WqrR+oGv2D7llXeTeyvnVdMlYh46iBHWOI3D3x5o7aLB09YV6p4pLHBxot8vTJf4SQ2rnIgw6B440nI/PLxBoSlhABakONw2nBaohXimiZYEwLBvvLkET+Oc7t1O5rJo81XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4GFRZ6GJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714971126;
	bh=Qo9oR0uLK9UQeYxvmrg6jiYCbiXcdox6/UsyUwzx4Jg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=4GFRZ6GJbXZXVRYJVVH0MQtuv064RaK1pBFCLNS0YNGKmss4nNKuOys7zZhqXOZJ+
	 N+bnX8SvajDXtTAIdq3R0AGw7lNVfbmTO6TtU18BOClPzhnj1WKHqNUYGPtKGQ14ZK
	 W76ns2WhDZOBGtty8YhduKSc5VAdieTYIRDWeW0yrPic/5NASZgkGgSbjzrnjtTgsu
	 C1sX3b2U8lF6a/XHOWJL/O+MObhjevRvbAMOzIuhUCYzGGbvzTxZ/LWZIClfPRx91m
	 FgLQQ0dDBntz7cawQfgxeq9eb9/tse1WRe45i+FpAfKn9FQQTb/8sR4rUSMawEEVtf
	 4XwXH48ln9FGw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 687B6378205A;
	Mon,  6 May 2024 04:52:04 +0000 (UTC)
Message-ID: <4d565066-5e4a-48fb-a0dc-17c4380ccd65@collabora.com>
Date: Mon, 6 May 2024 09:52:13 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>,
 Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Subject: Re: [PATCH] selftests/capabilities: fix warn_unused_result build
 warnings
To: Amer Al Shanawany <amer.shanawany@gmail.com>
References: <20240504170916.131580-1-amer.shanawany@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240504170916.131580-1-amer.shanawany@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the patch!

On 5/4/24 10:09 PM, Amer Al Shanawany wrote:
> Fix the following warnings by adding return check and error handling.
> 
> test_execve.c: In function ‘do_tests’:
> test_execve.c:100:17: warning: ignoring return value of
>  ‘capng_get_caps_process’
>  declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   100 |                 capng_get_caps_process();
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> validate_cap.c: In function ‘main’:
> validate_cap.c:47:9: warning: ignoring return value of
>  ‘capng_get_caps_process’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>    47 |         capng_get_caps_process();
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>

LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/capabilities/test_execve.c  | 12 +++++++++---
>  tools/testing/selftests/capabilities/validate_cap.c |  7 ++++++-
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
> index 7cde07a5df78..47bad7ddc5bc 100644
> --- a/tools/testing/selftests/capabilities/test_execve.c
> +++ b/tools/testing/selftests/capabilities/test_execve.c
> @@ -82,7 +82,7 @@ static bool create_and_enter_ns(uid_t inner_uid)
>  {
>  	uid_t outer_uid;
>  	gid_t outer_gid;
> -	int i;
> +	int i, ret;
>  	bool have_outer_privilege;
>  
>  	outer_uid = getuid();
> @@ -97,7 +97,10 @@ static bool create_and_enter_ns(uid_t inner_uid)
>  			ksft_exit_fail_msg("setresuid - %s\n", strerror(errno));
>  
>  		// Re-enable effective caps
> -		capng_get_caps_process();
> +		ret = capng_get_caps_process();
> +		if (ret == -1)
> +			ksft_exit_fail_msg("capng_get_caps_process failed\n");
> +
>  		for (i = 0; i < CAP_LAST_CAP; i++)
>  			if (capng_have_capability(CAPNG_PERMITTED, i))
>  				capng_update(CAPNG_ADD, CAPNG_EFFECTIVE, i);
> @@ -207,6 +210,7 @@ static void exec_validate_cap(bool eff, bool perm, bool inh, bool ambient)
>  
>  static int do_tests(int uid, const char *our_path)
>  {
> +	int ret;
>  	bool have_outer_privilege = create_and_enter_ns(uid);
>  
>  	int ourpath_fd = open(our_path, O_RDONLY | O_DIRECTORY);
> @@ -250,7 +254,9 @@ static int do_tests(int uid, const char *our_path)
>  			ksft_exit_fail_msg("chmod - %s\n", strerror(errno));
>  	}
>  
> -	capng_get_caps_process();
> +	ret = capng_get_caps_process();
> +	if (ret == -1)
> +		ksft_exit_fail_msg("capng_get_caps_process failed\n");
>  
>  	/* Make sure that i starts out clear */
>  	capng_update(CAPNG_DROP, CAPNG_INHERITABLE, CAP_NET_BIND_SERVICE);
> diff --git a/tools/testing/selftests/capabilities/validate_cap.c b/tools/testing/selftests/capabilities/validate_cap.c
> index 60b4e7b716a7..65f2a1c89239 100644
> --- a/tools/testing/selftests/capabilities/validate_cap.c
> +++ b/tools/testing/selftests/capabilities/validate_cap.c
> @@ -28,6 +28,7 @@ static bool bool_arg(char **argv, int i)
>  int main(int argc, char **argv)
>  {
>  	const char *atsec = "";
> +	int ret;
>  
>  	/*
>  	 * Be careful just in case a setgid or setcapped copy of this
> @@ -44,7 +45,11 @@ int main(int argc, char **argv)
>  		atsec = " (AT_SECURE is not set)";
>  #endif
>  
> -	capng_get_caps_process();
> +	ret = capng_get_caps_process();
> +	if (ret == -1) {
> +		ksft_print_msg("capng_get_caps_process failed\n");
> +		return 1;
> +	}
>  
>  	if (capng_have_capability(CAPNG_EFFECTIVE, CAP_NET_BIND_SERVICE) != bool_arg(argv, 1)) {
>  		ksft_print_msg("Wrong effective state%s\n", atsec);

-- 
BR,
Muhammad Usama Anjum

