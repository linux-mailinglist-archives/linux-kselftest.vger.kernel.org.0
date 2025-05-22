Return-Path: <linux-kselftest+bounces-33509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB18AC0FB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67773A6BA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E12980D8;
	Thu, 22 May 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XLPHO6rK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1E2980CF
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927051; cv=none; b=mrddtwXbwwPM3oJgGWr1/HU+rRR7hali4eePvbxvT/NeK2F9M5yWxlbvIMU1u7ju7+0KiPP5lsLq9OcTO98JBFlQWSq6Z7uqKYumxFUifZx7zuMzQddad41FW8B/utf8qRExPb5xkasFEz01w5N220jaa33F6Cx/k2+2FrFSK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927051; c=relaxed/simple;
	bh=yECD6ZktgTjXDSCFgMyFUoroNATnVYVOCITlOnNEHpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPmXynpsOUP4LZsaaETDV/9s1UvYpB9J6BTwYgCFOzjklQxg5DYlzlROEjkmBuTObULspqvwyIldV9M4578LzMiAJ78NEs9aAjQ3IGb59scj6WvtucRelA2K7JeQQXhcqk8TNgLSpgwjKZyI6n2qvkaKOCUttHfdotSe6ft2ViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XLPHO6rK; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3dc7c19a4c6so10741585ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747927047; x=1748531847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IETGeB30Ud5t90dKFtz7PPdKbD88fIhHcL4tZXb4WTs=;
        b=XLPHO6rKWko+sw+IZXc/CqddPJL2u1YVjas/lQyH6No6tywCoJ7tXRSOTQxrtLDOVH
         LNnjbQDtVPx+89YwKtWJQHrYaKnKaB2ScLHuG13vC8AwOKipjeQg3aQt1ryQnI8tvACg
         V3CIVdUvzcmWqoCUHxCjnID5DGrM0g0GvBXRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747927047; x=1748531847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IETGeB30Ud5t90dKFtz7PPdKbD88fIhHcL4tZXb4WTs=;
        b=RfWV8EfTUqDg9miuPMrJ/p3D301CsKxkDE9QL5pa/xQHzwHVh/MnCSfCvz0i91shRc
         QuUUmZTum4EKLxVoTdsVfk3AH5HSCEVKPGVqpG1DxQkVCldiAJzq+yxrLAbOSflXEfBT
         bTb5AioYZi94oTDULaQfAG5kS/OMZo/UQ8T+SSOZXT2HyrIB0kTNZbJYCNeoz28l+oYp
         kWNv1z/4ZPJusW3npDEba9TGowLdlXIBVxHWSgIwlHxirENd2GeIWBXEcV1+dbhBz7nJ
         kmMlNjDLfIE3iRlfveIEJtuml2tDkEc/hzCodTQURSJpbV5xFhUYXXXiROAK95CexthQ
         n6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuJ3L38DjP/J1Nfci6UyTdNSEtTKB+89Ye97NfH5AahWvZM/xmov5JYyT+sFkmDhYCCOFb6tSpD+sQPv4gKSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyizxcOQ5siCHu7Pdl0H6kuYbe646rJJwuUwiAZ09/KUK3uirVw
	mCSJaeQdhOjoRLVrMXmSpwQ69xab3PjKH035mhqdt1Ed/ZKS+Kv/D7zXpHRyYT9mqTY=
X-Gm-Gg: ASbGncsZNkD7katQ/UsGOdocC1oUwGB1hNSaP7uvfuogrctQpJZ2LSP7IjjlwPaK+it
	XVLiQ4jl1E76QxyRIEUifklPKiihhNMH+ha0FwruSWznIqNAj50z8XTWN23DK9SioqSeULZgvy0
	qDpIajXGWlYgoOMAaWnfwjZ45tRo7H1lJpfF4jhocw+vs9IIGEmDlcnhLCBftrFAhudycXYrxpY
	rWQSm3/tcmz77OeUdQJfWJ+YwdZW5v9W6an4k3IU0lSGwAUcG916JwjvEgH/q2Rik0mtM1snexq
	QdMtXtlM0P1H5yzC1bBmTdNDRaRw5Vxu/bV9slaTKVJF6ML2qHnuGLt6SS3x7A==
X-Google-Smtp-Source: AGHT+IE4miy92v8IzzM9z3nzWIqMhYC4PYeZ/1gnpzPA+Nm1GpEEXc0VF3cDp3wCEis+0MsO80e57g==
X-Received: by 2002:a05:6e02:3e06:b0:3d5:893a:93ea with SMTP id e9e14a558f8ab-3db843046c6mr236224255ab.13.1747927047461;
        Thu, 22 May 2025 08:17:27 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8ad89ecfsm5792365ab.26.2025.05.22.08.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 08:17:26 -0700 (PDT)
Message-ID: <2b7acb5f-65c7-4787-aac5-ebcec83c8ac0@linuxfoundation.org>
Date: Thu, 22 May 2025 09:17:26 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/cpufreq: Fix cpufreq basic read and update
 testcases
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: rafael@kernel.org, shuah@kernel.org, gautham.shenoy@amd.com,
 narasimhan.v@amd.com, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250430171433.10866-1-swapnil.sapkal@amd.com>
 <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/25 01:58, Viresh Kumar wrote:
> On 30-04-25, 17:14, Swapnil Sapkal wrote:
>> In cpufreq basic selftests, one of the testcases is to read all cpufreq
>> sysfs files and print the values. This testcase assumes all the cpufreq
>> sysfs files have read permissions. However certain cpufreq sysfs files
>> (eg. stats/reset) are write only files and this testcase errors out
>> when it is not able to read the file.
>> Similarily, there is one more testcase which reads the cpufreq sysfs
>> file data and write it back to same file. This testcase also errors out
>> for sysfs files without read permission.
>> Fix these testcases by adding proper read permission checks.

Can you share how you ran the test?

>>
>> Reported-by: Narasimhan V <narasimhan.v@amd.com>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
>> index e350c521b467..3484fa34e8d8 100755
>> --- a/tools/testing/selftests/cpufreq/cpufreq.sh
>> +++ b/tools/testing/selftests/cpufreq/cpufreq.sh
>> @@ -52,7 +52,14 @@ read_cpufreq_files_in_dir()
>>   	for file in $files; do
>>   		if [ -f $1/$file ]; then
>>   			printf "$file:"
>> -			cat $1/$file
>> +			#file is readable ?
>> +			local rfile=$(ls -l $1/$file | awk '$1 ~ /^.*r.*/ { print $NF; }')
>> +
>> +			if [ ! -z $rfile ]; then
>> +				cat $1/$file
>> +			else
>> +				printf "$file is not readable\n"
>> +			fi
> 
> What about:
> 
> if [ -r $1/$file ]; then
>      cat $1/$file
> else
>      printf "$file is not readable\n"
> fi
> 
> 

thanks,
-- Shuah

