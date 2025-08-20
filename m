Return-Path: <linux-kselftest+bounces-39406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04508B2E7F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 00:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40BB5C86CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 22:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6BA215F4A;
	Wed, 20 Aug 2025 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjX4SZXc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34818991E;
	Wed, 20 Aug 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728138; cv=none; b=UVfIs3qOnO4QljFGluCrkGOJaqew7AfLKScqfyJkLyKoAlApcl8kA8CBMu6198BSFkMuqgj/X6eVh/9I2QXEVQXYIlUSrOks5FKXH4nNrHh1yk3FHEEkFLN9pA2dNPNUIHK4gVRWhGF6WGb+7M6DRKdhpP/OVdbfpauRXVbrAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728138; c=relaxed/simple;
	bh=w7ZhLVBtJork5lC6/PwqLofmXynK9t2XVXuul30JeBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHEdTV1UzGYcKGqGspr+rco4Jq4zRdA/xpU6zh4rpsuXtqheXkYBvQVltDsRa2N2CoAR8qATXX/9559LpGldkg8Ph4WCkPs7t+w3XNYe69WSVTBdb97gxAZM6wFY//yIEJqNKVugu24+3iliorPGx059J/Sx0zjd1jVqDfIeOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjX4SZXc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b47174beb13so202544a12.2;
        Wed, 20 Aug 2025 15:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755728136; x=1756332936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pcPQwn/g5jNJbs7+VbHJElT/HRRGmlILHSyyD8bjdFo=;
        b=bjX4SZXcDCqN1TgrTT+tWuJkHvNc+6sJXzwroFjV6NABb0+n9fgSV5qdny1pSgLVQJ
         zfRwy6r+nmJmmXy1muCMd1FMxDpIMOmPXV+tHCE3YUlZzMOGicZpRe1x/pmDYDZAY4oq
         1ffl1NAEKGE4mNA/HagqTfQkuIm2x4gkk++giW+JOTREoF0r1V7Uda+H6CB/3/HsYBLB
         eiscFfhY561KzYrxAttIKmZBlvTETyDJaZ1CbGNXRIvBDvDOvK0n2/ZXd6m0nBfoyEiC
         ZNFonWKB8B/0ZjZmPEwkHJpd10mRtFqpplglJO+pkm7qaCiwuZgpCWbcekc3ikMK4VYl
         N1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755728136; x=1756332936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcPQwn/g5jNJbs7+VbHJElT/HRRGmlILHSyyD8bjdFo=;
        b=R0A5UyEAQXaspeYWnj+3PfbSRypYHAu9zRKHjztR0nJG9FOomgNK1E6wOeSB6Z2E36
         fn5LniQtaBoKpCHqysDiuOKx7R0ggQX3+8HZmeMRZyqz+mPPRYyCe/cNq21uAmxParEU
         YCc35DzM8Vh6HvOA87u8qrX4jB/dxRkTGYr++72n7IoKdnLTIWCyKAIYDXzNk8Gfp57N
         aNFz0w0sw/7JXaCUQlCyl14YyAR2JqXK5A/9RQGOHEmMwiXeFohGjgqva5Uq/c6oAW2e
         0IF7LXq6kOyZm4ONtH9LKeM/Vo4qIsfofnyV1Q+xmQN/s+flZs12EMUfgOsVlXKkOuxi
         L2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCV+4ve/XMPr9+AwlE3OOwT/l4BVoNb4cmAQFmZE3FVBt9KFLoT+PotQj4+fyYy5ZDAA2ZUP6xfwKV2UCtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpbQ89d9R3o56wqGZlfCQK2UrE92/h1MPdsFK4IPrVqo6tFksq
	aZHIC0ZLcg6RZ74gdDEF7GWL2KMx1NzV4x9LMKSNrvBu1YxwmXCMxU4/N5+8cQ==
X-Gm-Gg: ASbGnctZ+HRVZnhF4EFnMyJVmjC8T8lx1UkP58maIibeOgD79g4M6OYaXnkrir05UYq
	g/63ozWg6jrcG+YOKqsEA5VI6CE9RqWDFbLDgzaPRYYF76/mQ+y73CxOqxu/BtbJ2t6fdlpR5lt
	uJxO13DsnUcywF8n3XsWjdLwGlEBS/zr3yv1WyJAo+v6iXdbKyDHatp8Kpy1I24x25G5Mepoukf
	JauHP6MM7UsWcS/BQVJawrlZFrDWG0SkqnlsjAp9EGmn/I3vd+5nscNtq2hc4eVxeLLm660aOnM
	S5jVIanUbr+kI6RGSl67Z6FKpd8fk2QkAP/Zm9eetJ/qV1r0EVhvvHcMzLIWl/k0APmH3RRDnBZ
	0Fr4Hytjt41EIVUdubL4aJDbXGkWR8jDz
X-Google-Smtp-Source: AGHT+IHPFyFwi4+H/VPlv9o1ob6JMSG8ZpfV+iZxZ8GWJpg19ea3g0Yd3nJ4E0bNeFXqqLIbEPq9dg==
X-Received: by 2002:a17:902:f68f:b0:234:cf24:3be8 with SMTP id d9443c01a7336-245fed88b5cmr4609625ad.28.1755728136310;
        Wed, 20 Aug 2025 15:15:36 -0700 (PDT)
Received: from [10.25.72.178] ([202.164.25.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4fa997sm36254355ad.125.2025.08.20.15.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 15:15:36 -0700 (PDT)
Message-ID: <fff77b13-1eea-4a9a-b58d-23e3d36dc866@gmail.com>
Date: Thu, 21 Aug 2025 03:45:32 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kselftests:grammer correction
To: Pavan Bobba <opensource206@gmail.com>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250820125836.14464-1-opensource206@gmail.com>
Content-Language: en-US
From: Shivam Chaudhary <cvam0000@gmail.com>
In-Reply-To: <20250820125836.14464-1-opensource206@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/08/25 6:28 PM, Pavan Bobba wrote:
> correct a minor grammer mistake

grammer should be grammar , spelling.txt does not have this, that is why 
missed by checkpatch.

Also use proper subject prefix kselftests: should be selftests: acct:

please Send v3

> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
> v1 -> v2 : changed the "corrected" word to "correct" word in message
>             description to follow the convention
>   tools/testing/selftests/acct/acct_syscall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
> index 87c044fb9293..ee2894e4f7bc 100644
> --- a/tools/testing/selftests/acct/acct_syscall.c
> +++ b/tools/testing/selftests/acct/acct_syscall.c
> @@ -22,7 +22,7 @@ int main(void)
>   	ksft_print_header();
>   	ksft_set_plan(1);
>   
> -	// Check if test is run a root
> +	// Check if test is run as root
>   	if (geteuid()) {
>   		ksft_exit_skip("This test needs root to run!\n");
>   		return 1;

