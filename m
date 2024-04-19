Return-Path: <linux-kselftest+bounces-8468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DA8AB38E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C501C20AD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FFD1350F1;
	Fri, 19 Apr 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2uGRoL+o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F77E783;
	Fri, 19 Apr 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545090; cv=none; b=adc/orT01JJtzbyxa3vaN6rF9CVTbKy3jsyWLMjkCoKYC+01xLeWxOgGbqXey5Yn5OV1G8gWyThFBPh8vKGJ3leytwMwsc/6oMrY0KBA3dZPsO1AHga+/k8isQi6mk7ZwYVb6kLRGJQnuPEENLZIwKI7xYugV0VHfi8uukBY/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545090; c=relaxed/simple;
	bh=PCIE9E7dp38ZmFyU9fzDU6AeNgGCE9sGYThG6+uMTPI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CknWSr4tX6d8MtabNE9oVjXpNj0bN0hiY1lzZ0gXAJMaL+tl8Fb6q1IH2sb0SOwJ4GKN1J6dKJ1V7MWE5/DHz0e2Ngl1UHc7Qhi02v6ETZhEmGaTuIC1zVYPgxL/5zv91ORCAFOqiVSHQKs8S4kKtkyiCAwuMlW66C8RNOgWo3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2uGRoL+o; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713545086;
	bh=PCIE9E7dp38ZmFyU9fzDU6AeNgGCE9sGYThG6+uMTPI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=2uGRoL+oaCqQx+I1zYr4zJbpi6171b65znHJ7yU8G0+g65eiLDC6oYcg1WzOH74se
	 LHAVsVzG4IC1hOs3xnagO1m7zX3efznHpubw67O/IxoPj+dRvNlXcGeQD0vX48J7uT
	 rggxjokKZKg13fk1YLgkuswI5Il4giYlu9Hg/J/kl58KRIimTXnIHQQO8XHUncYHTy
	 a9SfZtUs1rePrB2APZ8hxbQVcmVIXKv5vq6+AT9xjcHIUz/+nwHVB+Z40DlKFss+tp
	 p8eDTPZ5OTfRQpeMH7ixNBGVAA/IRfoLj/Nr5L2IzziNxzAij55ytZKUszQaaLG+JB
	 FGBZwg6vstEGg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6B0053782153;
	Fri, 19 Apr 2024 16:44:41 +0000 (UTC)
Message-ID: <4b66cfb8-5d42-4432-b930-e23482a48dc6@collabora.com>
Date: Fri, 19 Apr 2024 21:45:06 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH] selftests: filesystems: add missing stddef header
To: Amer Al Shanawany <amer.shanawany@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240417161623.37166-1-amer.shanawany@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240417161623.37166-1-amer.shanawany@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/24 9:16 PM, Amer Al Shanawany wrote:
> fix compiler warning and errors when compiling statmount test.
The error description or the compiler with version is required to reproduce
the error easily. I'm unable to reproduce the error by gcc 12 and clang 17.

> 
> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
> ---
>  tools/testing/selftests/filesystems/statmount/statmount_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> index 3eafd7da58e2..e6d7c4f1c85b 100644
> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
> @@ -3,6 +3,7 @@
>  #define _GNU_SOURCE
>  
>  #include <assert.h>
> +#include <stddef.h>
>  #include <stdint.h>
>  #include <sched.h>
>  #include <fcntl.h>

-- 
BR,
Muhammad Usama Anjum

