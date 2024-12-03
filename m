Return-Path: <linux-kselftest+bounces-22777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E65419E2E3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 22:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBE8163EFB
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546C205E07;
	Tue,  3 Dec 2024 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q1oFMMPq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924820A5C2
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 21:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262037; cv=none; b=phQMR48M8wfmqWCuNr9NduI05EEtoctxFwwVS7Ey5gGUgSwlbp9QJTgxso1EMl37gOaxJp5FEZ19oLM0nVWXgisrt4OCUcF9gdg5AbkIBbdYFFkWnBdM1h/u2U6pJS1AzKIhtWpCdQS2rrssDQLxaHWnGLhZFwLOGf6uhCAXqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262037; c=relaxed/simple;
	bh=TL7NNcboBRw+u0U/0XJWPG/O4JlBO8FBSu18p5zeI7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeAypGN4O9ep3hvHPrMITmCVL7+D0KIuiFPwUw/JNQAUQ+gcxl1YvmEluyt9FubbxlioexwsVR2QpFtRU6JPG7eFip0TTlNcnvMnYYhyy/c8FXi9ObeKyKhiRGzFAQ9ZyLrKqOBOCTU2BRUkWegEOIlhYlC4m54eRCug0mvL2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q1oFMMPq; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a79911ac70so26240475ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 13:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733262034; x=1733866834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qM7KSOsD8erGpBwu4XmxDy5UG6JA4dUx7y9RJZFxbcY=;
        b=Q1oFMMPqFijd7WRWehz2CEHCS8HybkVkaUwacU3q+0OHpuUyscgrEeu2SRcgb7P5qQ
         9J99xzvizCUt3LMZyXBk5JYoiivNKxGNTsLTm8IWtx8uuhEqvKOi4NjZEsHEvMwOu8nv
         TGtSbSWkk96BibZ8XorxP16HsfNcGbQtYEd9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262034; x=1733866834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qM7KSOsD8erGpBwu4XmxDy5UG6JA4dUx7y9RJZFxbcY=;
        b=l+31ce62LP5hI76+iVn1eoPk2hykXodqtt9KCk3DFxGFhGVALfEBOM5MlTNGJoHP5W
         +HVcfx3sZkh2bALgnwfIAPZTKLB+Ckn0dP9MJGq+26uSc3yVgV36XJkdI4Eyv64Zm/FY
         b1k38+e5FN25c22h2qIpS5ZWtIxXss1dGOyyOWFTdAEkntvwoqvVVB+RuoYRj3XNB6Nu
         jriWc2w5EBC1D/6EMa2qHsYjgl9etQ6sPkP9jR+hy5BadQt3JE9TTNUV//1esULywMFn
         zMNqu2b1cs2NdVKesCk2aZvusDmNGxFEr/D7/3e+pH3ARBftLzOa9CSY1EwA/8QzsFcf
         vKag==
X-Gm-Message-State: AOJu0YxBIK544hAXFbYmTxckvzB8A5QRWbCh5Ucn8sJMwd9GKZuVw22/
	7D5ul6WUxhAsaoxIJzq7JX1vRcM//vgE08oRQlmMF4qKtKhjoeruoyXqH1RCbnQ=
X-Gm-Gg: ASbGnctS7kB34o7eU6jnrfP8ETG66SkQ7rXJXZlDSqLSRfcLDxQbmPRaUrkAibHV+D3
	ZpipmRRJFtC6onOZOw8C+OrnPN4E8XPCkG66U52kOsEZKDIUA11wiwYtcrAfY53MXTixmFztgTD
	H307qd2gcoHsLu5uglu0wZYu/BQrt4eb+YSBjQH1FzM/vqXNoRMROmBZnhVtki7oQDQxoMtT9gP
	zMB06VC3JdTmnv/EEQlORamdVMKLbEX1ueelKJjY9M9Xtkc7s0PJ4HNpXHWOw==
X-Google-Smtp-Source: AGHT+IGcCgiSiPMG4IWRRA7S3qbf0jUp6oiRy/fO5CjDu0IzR+tGuqUjn0+sxzpQiSkobfCdAbWyGw==
X-Received: by 2002:a05:6e02:174b:b0:3a7:5cda:2769 with SMTP id e9e14a558f8ab-3a7f9a4e226mr44814475ab.12.1733262034454;
        Tue, 03 Dec 2024 13:40:34 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7e9380606sm15800645ab.57.2024.12.03.13.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 13:40:33 -0800 (PST)
Message-ID: <1e770394-00ab-42c0-a940-97976993184d@linuxfoundation.org>
Date: Tue, 3 Dec 2024 14:40:32 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: acct: Add ksft_exit_fail if not running as
 root
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org,
 abdulrasaqolawani@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115191721.621381-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115191721.621381-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 12:17, Shivam Chaudhary wrote:
> If the selftest is not running as root, it should fail and
> give an appropriate warning to the user. This patch adds
> ksft_exit_fail_msg() if the test is not running as root.

This change introduces a problem - skip is the right exit code
when a test requires root privileges.

> 
> Logs:
> 
> Before change:
> 
> TAP version 13
> 1..1
> ok 1 # SKIP This test needs root to run!
> 
> After change:
> 
> TAP version 13
> 1..1
> Bail out! Error : Need to run as root# Planned tests != run tests (1 != 0)
> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>   tools/testing/selftests/acct/acct_syscall.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
> index e44e8fe1f4a3..7c65deef54e3 100644
> --- a/tools/testing/selftests/acct/acct_syscall.c
> +++ b/tools/testing/selftests/acct/acct_syscall.c
> @@ -24,8 +24,7 @@ int main(void)
>   
>   	// Check if test is run a root
>   	if (geteuid()) {
> -		ksft_test_result_skip("This test needs root to run!\n");

You can change this to ksft_exit_skip and keep the same message.
> -		return 1;
> +		ksft_exit_fail_msg("Error : Need to run as root");

This is incorrect - should be skip not fail. There is no need to
change the message.

>   	}
>   
>   	// Create file to log closed processes

thanks,
-- Shuah


