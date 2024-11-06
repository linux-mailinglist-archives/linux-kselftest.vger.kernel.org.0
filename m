Return-Path: <linux-kselftest+bounces-21546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16659BF3E5
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 18:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FBC1F21566
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1378C2064E8;
	Wed,  6 Nov 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WwZg7eGl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644761DEFE7
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912770; cv=none; b=UICTZjUvPiIntkq0dyXIL3LDneR3swnjX1cgXEWK6vQiKflpsPJ6tTluahDg5+GMcXUXtGvhjh5mKNEK8PcYtdMbO7JMGWOa/D6cIjClJbm2rzPWnrghKEg9y1RvdK5d1fC3+yzuHRJPbFczpl63iBTCudyTGMHk6C8gamxaGQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912770; c=relaxed/simple;
	bh=EHHfV01+YzBryJK6oqy+NG1HYmJOBrkQ3gPa9wHwugA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvyEhTpzkuzXVV+y5+HiAhn4fwPZfHUD0nyu7p7mxjBgKQjWu0Htae9+MAKwwCyf0jQ2+prElaCTIiLJDZDspepmh7ZeqkUrvRpMjXh/8VKpnzVV1tiQH6yu0gwNoMse3Dh+Py0mmNffwLvkx8u/SHrnYWgT9EHLPcWwiyv9nDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WwZg7eGl; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e6104701ffso52460b6e.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Nov 2024 09:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730912767; x=1731517567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6ZhbKhfLK1nW6cUD5V1lnrveGjn3mERSf9IypO38E0=;
        b=WwZg7eGlRU0H8MVDkJtHTxvQt78jeZoVfh9PpUakVnbBne7VGIIxnlY3xj/ezVcNvq
         EFi0i0X7jTuL/PD+AOtg3EfMZesHa41DEQcF9oEyVxgMNtzEHMYdr9lQCNNVffYFlP3y
         Kmkmtq+S/cwTrFINTCazhzTbgaaACM0tQdTO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912767; x=1731517567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6ZhbKhfLK1nW6cUD5V1lnrveGjn3mERSf9IypO38E0=;
        b=Y3sc2PXe4S23jTrmfSz/yedII8DmYgf96IGpq0dHINlkEChOttssEMl/JqJoIhAn/L
         7glTmZkefPA7eyRzI/3p7JNiPDocVoOUUjQ7oLLnOQE2MoC5q+S0HMP4DTi0AGOOW2nN
         NTxWiOhhXha8eDIrhwSonzKswQXqP6OM8xQxL7W6MhdjRidXr66uJKv11k6lb0qbKQdy
         EsWDoMnVvOlz5uQIwYj0ls5q36hsCv4ZwE83XtSU20nYwLZ9oVYJDMEkTLSbXRrJ7eTi
         HK/VEejPiDxDq7+D9txv1T8WEN73N9Ms1qjulLCPs9Cgv9SHXVC/8NYF2qr5iExBMjwm
         HS+Q==
X-Gm-Message-State: AOJu0YxoA0OUvGvJ10UYAjw5khN1JAHaHVrjYwwHl8aJZn0xYZEGEhS/
	vVRIfkwYhR4amQSMGJzPh/jiBGVa8RZk6Z6BAHs9Cv0WsfRwjReHmluKYu45WdA=
X-Google-Smtp-Source: AGHT+IGd+6QAHwLm4BRK4KI/o1F57lC601S2uhu+juKFHx8TGA5Du5HsaaVln/kyanZ/EY60PQ8t+w==
X-Received: by 2002:a05:6808:179f:b0:3e6:3647:ba55 with SMTP id 5614622812f47-3e6384b4cacmr39288877b6e.32.1730912767262;
        Wed, 06 Nov 2024 09:06:07 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049a474asm3008087173.146.2024.11.06.09.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 09:06:06 -0800 (PST)
Message-ID: <8db9feab-0600-440b-b4b2-042695a100b5@linuxfoundation.org>
Date: Wed, 6 Nov 2024 10:06:06 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] selftests:tmpfs: Add Skip test if not run as root
To: Shivam Chaudhary <cvam0000@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org
References: <20241105202639.1977356-1-cvam0000@gmail.com>
 <20241105202639.1977356-2-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241105202639.1977356-2-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/24 13:26, Shivam Chaudhary wrote:
> Add skip test if  not run as root, with an appropriate Warning.
> 
> Add 'ksft_print_header()' and 'ksft_set_plan()' to structure test
> outputs more effectively.
> 
> Test logs :
> 
> Before change:
> 
> - Without root
>   error: unshare, errno 1
> 
> - With root
>   No, output
> 
> After change:
> 
> - Without root
> TAP version 13
> 1..1
> 
> - With root
> TAP version 13
> 1..1
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>    
>   tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> index b5c3ddb90942..cdab1e8c0392 100644
> --- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> +++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
> @@ -23,10 +23,23 @@
>   #include <sys/mount.h>
>   #include <unistd.h>
>   
> +#include "../kselftest.h"
> +
>   int main(void)
>   {
>   	int fd;
>   
> +	/* Setting up kselftest framework */
> +	ksft_print_header();
> +	ksft_set_plan(1);
> +
> +	/* Check if test is run as root */
> +	if (geteuid()) {
> +		ksft_print_msg("Skip : Need to run as root");
> +		exit(KSFT_SKIP);

These two can be replaced by ksft_exit_fail_msg() - refer to the
kselftest.h for the right API to use for each of these cases.

> +
> +	}
> +
>   	if (unshare(CLONE_NEWNS) == -1) {
>   		if (errno == ENOSYS || errno == EPERM) {
>   			fprintf(stderr, "error: unshare, errno %d\n", errno);

thanks,
-- Shuah

