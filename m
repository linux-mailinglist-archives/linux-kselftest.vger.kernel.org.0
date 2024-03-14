Return-Path: <linux-kselftest+bounces-6318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C94D87B9BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 09:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1501C20B31
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7232D6BB47;
	Thu, 14 Mar 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kZVhG8GF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977643ADD;
	Thu, 14 Mar 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406466; cv=none; b=TlZJBwbR9+zzxo9V64H3bc0kbveW0KdBQPV3j+yhYnsJTztwirXzCFOOZQxHGl+Gm8nxGzyzbDQEcAO5+cVsTWKar6TUucWm6E8wHyGBik9NW9oBPo2vE9ZcmslfL/UZtzpqRXuvx3s6pMl1HvaJlEfA5bydMcYJrJ3beXUQF3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406466; c=relaxed/simple;
	bh=Hug4VpcwNwwqAOdVuGR3r5w2hzLyi1ZErcpgeoCjrpg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fUl2A7YaQiDns87HUAseqBWL60d1SO2gYY7//Gsun6APKFSqTCfAFi1f7GZkfuAcgJJia1kauwPR6WYUJ7E/cK8ABfcYr8aW4ZcmPQbWCj1jRhr70MjlSOlvWqkjFPND1VezyxpQxMEJY1BJumC4Q5Qab8Q4LqEB7nHbi9k7p4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kZVhG8GF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710406462;
	bh=Hug4VpcwNwwqAOdVuGR3r5w2hzLyi1ZErcpgeoCjrpg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kZVhG8GFZYYC3OAzSAy08JnBI7ueSsyszQUf5fEmjQ2II8WGNRD/wgTbcyAhltdca
	 MhX/nATboCzW2kCOzEjw200OyBhiHWNi28f+Fd+CF34xT/cGtMpvxqs/HpBWXPzb5Y
	 qxiBfmUXTOs078rdLjOkbZ3cRZYX9bGtVSx5svoldhVQ6/3Bh0AL+rblWfyAAQpfWZ
	 gPtW+AA3MdPR0h8MwGVzD7p2bORCWGQ2kq+cYRnrCemV5qYCWemsZpFJGCXNrrZZDO
	 glDgKLSjJjuhnhYBKNjVFoCvbhaj+BZUq8o7TqrhP48UsGCGqdi4+LuVbzRJwLhi9p
	 R8ea4uLifDcRw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A3105378105A;
	Thu, 14 Mar 2024 08:54:19 +0000 (UTC)
Message-ID: <1dd87e89-2306-4669-844f-ffe9e56523b6@collabora.com>
Date: Thu, 14 Mar 2024 13:54:50 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests/exec: execveat: Improve debug reporting
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>
References: <20240313185606.work.073-kees@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240313185606.work.073-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 11:56 PM, Kees Cook wrote:
> Children processes were reporting their status, duplicating the
> parent's. Remove that, and add some additional details about the test
> execution.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kselftest@vger.kernel.org
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/exec/execveat.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
> index 0546ca24f2b2..6418ded40bdd 100644
> --- a/tools/testing/selftests/exec/execveat.c
> +++ b/tools/testing/selftests/exec/execveat.c
> @@ -98,10 +98,9 @@ static int check_execveat_invoked_rc(int fd, const char *path, int flags,
>  	if (child == 0) {
>  		/* Child: do execveat(). */
>  		rc = execveat_(fd, path, argv, envp, flags);
> -		ksft_print_msg("execveat() failed, rc=%d errno=%d (%s)\n",
> +		ksft_print_msg("child execveat() failed, rc=%d errno=%d (%s)\n",
>  			       rc, errno, strerror(errno));
> -		ksft_test_result_fail("%s\n", test_name);
> -		exit(1);  /* should not reach here */
> +		exit(errno);
>  	}
>  	/* Parent: wait for & check child's exit status. */
>  	rc = waitpid(child, &status, 0);
> @@ -226,11 +225,14 @@ static int check_execveat_pathmax(int root_dfd, const char *src, int is_script)
>  	 * "If the command name is found, but it is not an executable utility,
>  	 * the exit status shall be 126."), so allow either.
>  	 */
> -	if (is_script)
> +	if (is_script) {
> +		ksft_print_msg("Invoke script via root_dfd and relative filename\n");
>  		fail += check_execveat_invoked_rc(root_dfd, longpath + 1, 0,
>  						  127, 126);
> -	else
> +	} else {
> +		ksft_print_msg("Invoke exec via root_dfd and relative filename\n");
>  		fail += check_execveat(root_dfd, longpath + 1, 0);
> +	}
>  
>  	return fail;
>  }

-- 
BR,
Muhammad Usama Anjum

