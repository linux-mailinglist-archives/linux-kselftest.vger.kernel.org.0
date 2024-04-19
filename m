Return-Path: <linux-kselftest+bounces-8466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 515028AB385
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075B41F22729
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA38130E5C;
	Fri, 19 Apr 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3GGFvgjb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DED130A5B;
	Fri, 19 Apr 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544903; cv=none; b=kewFfhgwkhD3NtpintJYe2RD3Q8ETtrAUROV98LQbai/AmuBoPlHJlZJscI7LyhqhBlVK3LUn6DwJ4tLEJ/IL9TxmLHF7spo/Zg33dvZ5mtcwjd9SqTPRZLB1PHYTyRS8hQzZVGB5vE5YtbGM6npi5bRZE9nL5MfLCyP49zVaX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544903; c=relaxed/simple;
	bh=5Z86YDj4EGLTHzKnsTgG+U6a/TFj/lqltG1ku3tLxyM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E60eZy4xU2x9UWnhwzqidyWIiv+i8VGJ5QJcsZ6fTctnxwhIuJETpbedGBXR6yU1qbN39MfYMFsinv6ig+5PNz6mysZXzPlQHkLlPpQmCauOqSbAQgssdJXWxQUF+C4Hf7v0y713uEZkGDQy9SFywNqu5awYpvBE4X+PLLiO5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3GGFvgjb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713544900;
	bh=5Z86YDj4EGLTHzKnsTgG+U6a/TFj/lqltG1ku3tLxyM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=3GGFvgjbkS2Uhqwpgpau1x6o5G92jZ62keoxo/wkjq4CEvKMAfB37TUzlus/8Jn3D
	 5PXqXt+uFBud7FcGGVnSSI5ljImlFEVDKCSlub8uj5/5wZFrcD4vTqy5ZlU/HY77ul
	 JdoIv0CtW4hKubI6C/siDWjSt1xJIEybp5yMtHLAPh8ms3AL8xPZyNqZPqNuMGK4KN
	 anOOnGepTkaHTMwEepMHjZz3D/pHkE2z80B3diYFJ7GFgqBkuPG/Z+h0EnYDApDLI3
	 n3noGohuaq/YHDNRb67uzPgcQQEpFM0/PB+Towyc6mucjgggkL/MNuvB6Kc1hq6T3m
	 9SdYst0RAtsWg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6500D378214A;
	Fri, 19 Apr 2024 16:41:32 +0000 (UTC)
Message-ID: <58e0539d-423e-42e0-9ee4-8fc8e1eed94f@collabora.com>
Date: Fri, 19 Apr 2024 21:41:59 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH] selftests: filesystems: fix warn_unused_result build
 warnings
To: Amer Al Shanawany <amer.shanawany@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240417184913.74734-1-amer.shanawany@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240417184913.74734-1-amer.shanawany@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/17/24 11:49 PM, Amer Al Shanawany wrote:
> Fix the following warnings by adding return check and error messages.
> 
> statmount_test.c: In function ‘cleanup_namespace’:
> statmount_test.c:128:9: warning: ignoring return value of ‘fchdir’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   128 |         fchdir(orig_root);
>       |         ^~~~~~~~~~~~~~~~~
> statmount_test.c:129:9: warning: ignoring return value of ‘chroot’
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   129 |         chroot(".");
>       |         ^~~~~~~~~~~
> 
> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  .../selftests/filesystems/statmount/statmount_test.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> index e6d7c4f1c85b..e8c019d72cbf 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> @@ -125,8 +125,16 @@ static uint32_t old_root_id, old_parent_id;
>  
>  static void cleanup_namespace(void)
>  {
> -	fchdir(orig_root);
> -	chroot(".");
> +	int ret;
> +
> +	ret = fchdir(orig_root);
> +	if (ret == -1)
> +		ksft_perror("fchdir to original root");
> +
> +	ret = chroot(".");
> +	if (ret == -1)
> +		ksft_perror("chroot to original root");
> +
>  	umount2(root_mntpoint, MNT_DETACH);
>  	rmdir(root_mntpoint);
>  }

-- 
BR,
Muhammad Usama Anjum

