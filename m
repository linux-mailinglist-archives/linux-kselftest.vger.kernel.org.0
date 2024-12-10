Return-Path: <linux-kselftest+bounces-23114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E85D9EB783
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 18:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BA81638D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4814234985;
	Tue, 10 Dec 2024 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwHNyNAK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469F2111
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850605; cv=none; b=WfTdj0kvx2XvILQOyFI1izaRO1EG1M8DOjv1zzn8Tn1eHBt1INOpnrYQYY29kz58z9mcTx0FsGMBDF72rkodNoezbjfgIaNOE5d3Nuawh1LnpJ0qTpkRvDMj+bK4tB55h2fPhnWA6VVEJRSXI+uxfFQZZvCd0lzcKPzNbIbsWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850605; c=relaxed/simple;
	bh=n7TX/KGVtqtN/arIkiCvvxqUxQBAA9t8KQHNkd+Kzi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lH1NmZLlQzdV99C/3qwndsb/aiKNZ2apfXcQVdB3GbyQSq1CgZsoxSzS3mdaStgPUqIRjAhk648riWYD0OtxNrLAaMTYvu3Tw+hqqG89xC/YcO/GbCb+TZhPSL2cxN2XB7j4lstX7i4o/3zmv9xk0muX5vRFThoCFGF4Ce9gL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwHNyNAK; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8442ec2adc7so205427339f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733850602; x=1734455402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OVkYBvw17/WfzayXGy8io1dx1e/dJ//f+G5krTuVRXY=;
        b=IwHNyNAKw68QUf7Y0dFtF1InMFyKaTCi3KU33mGsaZKENYtNPlEtyNL6ga/L08Xceh
         5JyU9aI/98SF39V5N55km2KkQfcjwREpQtfR0AJO9jtWanv68DVFOskl2bgj85KZuWb4
         EcWVshIFBqCM4NQxYbKM/EYGhJPErXQ7CZqzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850602; x=1734455402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVkYBvw17/WfzayXGy8io1dx1e/dJ//f+G5krTuVRXY=;
        b=hk/T/eCL+DDK3U2DM39ybLnpnhIyWJjgWANCTB5fv8xbWE3dbMTMsEbwoWIJ9FqcPA
         hMvXu4aBg500IZ/hLjhJP6WBqEgMve2HpNuctDYgoliw7KTPCabwmxpeV/2hmSMmN8N0
         z7stXqKXM2fpMThDsEtdaqA9X+VVWMxPMmbkD0HmVPodQMJfIOZzudKPiA/X7Pa6TfAS
         iqIyVz06dvcpNlKMOBtkPuK29fPmhTk5agpwcBN0Na7IHr61AM2WWzbPkk17aiOwgdRv
         H88gko6I7OnHvoKD8xk1xWAwZrRRqTeXAPErANYiG9EV8rDiUSMK8p36UwRB/ROY8I4p
         Q1qw==
X-Forwarded-Encrypted: i=1; AJvYcCW9xVvZqcmS+Ftum6tSN7scdlgDVsFp6wGAKrmM+PGHSEPiw3UVpwAUwdSv7Xzl3J4N2qWokZ117McASVskP98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwTpZBR6/4b8h16awHsRnen4WVWQjsaUfXjYFjmn1K/VbSgO7B
	ChcBgbIy1oJAye5ryyfFDmgV2FWdZ+m4oH5I7YmY+w91vzwkvPATCA8r9DjSfSk=
X-Gm-Gg: ASbGncvaQnjFqaM+HPxoXh0+R3i3+W4+n98FH3TUY0Jo4+q1FlSoO4kfJNacAaCt34j
	3Ksdwto9JetP7wvY7/E/UoiO5AYNfdKne9BF5yux8F1kZuOvP7yf5P0xBwi4rFmsf5lhMk6+p+f
	DVPPPT74tTulaWE4MhzJYlluKpJ8rTuvHvBOtX4nFdcOqBhv2FQSHkgJhJLE/Udk5eE6ZeeORC0
	i90sddlgUPtcnVh892DYmRO2/zVnX07p7WYT5NVDa3mmC+Utc5CPuMOck1Sm2QZIg==
X-Google-Smtp-Source: AGHT+IEzIMlDQqNqHqbv8i4VSsCEok3zEc7VgJmYt6flLbyLvhHrDbMWrBxSWujOoiWgdpiR6ADVtQ==
X-Received: by 2002:a05:6e02:2199:b0:3a7:80ff:4a6e with SMTP id e9e14a558f8ab-3a811d9c055mr127020545ab.11.1733850601829;
        Tue, 10 Dec 2024 09:10:01 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2bff662b7sm1136449173.103.2024.12.10.09.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:10:01 -0800 (PST)
Message-ID: <57d11b05-d2ac-4fb3-beb2-cd1f45b38596@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:10:00 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v3] selftests/filesystems: Add missing gitignore
 file
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241122073725.1531483-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241122073725.1531483-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 00:37, Li Zhijian wrote:
> Compiled binary files should be added to .gitignore
> 
> 'git status' complains:
> Untracked files:
> (use "git add <file>..." to include in what will be committed)
>       filesystems/statmount/statmount_test_ns
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> Hello,
> Cover letter is here.
> 
> This patch set aims to make 'git status' clear after 'make' and 'make
> run_tests' for kselftests.
> ---
> V3:
>    sorted the ignored files
> V2:
>     split as a separate patch from a small one [0]
>     [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tools/testing/selftests/filesystems/statmount/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/filesystems/statmount/.gitignore b/tools/testing/selftests/filesystems/statmount/.gitignore
> index 82a4846cbc4b..973363ad66a2 100644
> --- a/tools/testing/selftests/filesystems/statmount/.gitignore
> +++ b/tools/testing/selftests/filesystems/statmount/.gitignore
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> +statmount_test_ns
>   /*_test
'
I am seeing duplicate signature warning on this patch. Please
fix and send a correct patch.

thanks,
-- Shuah

