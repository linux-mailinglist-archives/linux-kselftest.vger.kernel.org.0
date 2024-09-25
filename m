Return-Path: <linux-kselftest+bounces-18359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B9A986408
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 17:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72631C27C09
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9A01AAC4;
	Wed, 25 Sep 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F8T8uUgD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939C4DDC5
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279177; cv=none; b=qtn/NgnM6zW2TQFXWO+tfYBS/aXPYj1N5S6l8au/dVRsRLeUZ/hTQo/HMblrbg0fu2fq8MUOs0jj/9HGAC+id6T6Ikx5ivOPeDOblLuUfmSHtdOXDwM5KuSwXsPc+HHnGYEwJBTAKQ2zKgHDUy+yZSb1UcOiFNDFDlzewHudIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279177; c=relaxed/simple;
	bh=x+4F0wBUmKeHDpIxKuL0c2Jd8c4z4haxH1Lz4gdI+B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaH6JSiDRznJCgkrbnKKsEQR+paw7ERFh/CfYOI1pzOj1ZejagJTdeZJx4rucu3y/UKsTAut4F3Vh/0MFs+Az+KrItd3pZr0lJ0V5gbfu2KDiB6JKuZDqU/ixnVqQwpOsRSkYF40gUmk2glQECSA23ja6bVozX9OaFlkOBtnaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F8T8uUgD; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-82aa3f65864so256317239f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727279174; x=1727883974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJM9B0m/lek0u1t6zaan4eSGVrdWrKVx/I5Nl82tDpg=;
        b=F8T8uUgD65pCCfeML4s+ow3na+bLKQGV0RTf8Jq2GBeC4/f0jL2akCULf2Rx3wf0Wx
         85iMiepTkrYMkdjYC0BNmI+a+qtaTLlFRIyY/RYm1ZSKkB+wizTHkHug7b7aY6PjTnQp
         xc7RpGZahhZGhTcqkD7ogypaMNI118h5/fpwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727279175; x=1727883975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJM9B0m/lek0u1t6zaan4eSGVrdWrKVx/I5Nl82tDpg=;
        b=PdU4OP2U7ao6cgYY0/If/gBRyFPXJ8pKi3Hs3GUz8Vj9x7SItnDnsro0MDrQcWDPLU
         7crZbpI3RqKRWevH9IWk+6SidmpMLHMRY8+KWTCtgGciZg2FhuGWnJdYV0B9AhzGyp+i
         IJYS1bmPHWueK8bob8rJxzRy3ByEcdbO0e2F9S/xCIo2HAb07LmIhoXGRrdCYu3Ov20u
         C+83WEAT3mreGqvnRnHWS3XS8D8VDre6HfnlCpmsZWd4KyFpuI7wSZu6IV+zPzegyJO3
         /TUpZTsdunHKJws4npks3Tjx5sL/zWjl6zVRzNqcWRqx63i/DHDM4E2BYNRKYbgWVioV
         mL4Q==
X-Gm-Message-State: AOJu0YxBZU7FOftzFOzWUqHBKpL2e7Okzs+KDe7+u5cq+b0oJZuXHVmu
	KD53GJaZxW3+YTIDn19d1L9AE/KKvNYxrZWME0t9cv1fSd2AoNYcsWJbccd7diA=
X-Google-Smtp-Source: AGHT+IHRidj4X8LYl5IH0Bj18RNFExR+Bckr7+2ammy4QZdJGrRo2Cl1ySSH9rbblKME1zD62cNhWw==
X-Received: by 2002:a05:6602:6424:b0:82d:f4f:f49b with SMTP id ca18e2360f4ac-83247f9003fmr365137839f.16.1727279174659;
        Wed, 25 Sep 2024 08:46:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8323f5dbf4dsm112899639f.11.2024.09.25.08.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 08:46:14 -0700 (PDT)
Message-ID: <e537539f-85a5-42eb-be8a-8a865db53ca2@linuxfoundation.org>
Date: Wed, 25 Sep 2024 09:46:12 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests: exec: update gitignore for load_address
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
 <20240924-selftests-gitignore-v1-4-9755ac883388@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240924-selftests-gitignore-v1-4-9755ac883388@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 06:49, Javier Carrasco wrote:
> The name of the "load_address" objects has been modified, but the
> corresponding entry in the gitignore file must be updated.
> 
> Update the load_address entry in the gitignore file to account for
> the new names.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   tools/testing/selftests/exec/.gitignore | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
> index 90c238ba6a4b..4d9fb7b20ea7 100644
> --- a/tools/testing/selftests/exec/.gitignore
> +++ b/tools/testing/selftests/exec/.gitignore
> @@ -9,7 +9,7 @@ execveat.ephemeral
>   execveat.denatured
>   non-regular
>   null-argv
> -/load_address_*
> +/load_address.*

Hmm. This will include the load_address.c which shouldn't
be included in the .gitignore?

>   /recursion-depth
>   xxxxxxxx*
>   pipe
> 

thanks,
-- Shuah

