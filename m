Return-Path: <linux-kselftest+bounces-16655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C06D963B61
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 08:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E8128628B
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 06:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189714F130;
	Thu, 29 Aug 2024 06:26:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F661537C6;
	Thu, 29 Aug 2024 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912785; cv=none; b=EKaEOXukpb0Jas8RvVhI6snlb9wPxCvoD6cV5j7LlJIN6XsNLe6sybKQVazBgw61eJVqR/xquEbpU8OXbQtLJzKyfoljx+vArmZitowyEchln4fGtj5/aUe95Hi5zD+7KRQQaknruvKbZAhtSPaorJsyL1g+/Ti6HoxrJzDauH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912785; c=relaxed/simple;
	bh=JXCgKpx+2hkiE/L2Q7X9a44fo4EAOPoARJxkEVGsU4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keb4CmbsM6/GyZNECLYLl8yo9AwYyWzLu4NGsIIpeVbxrcTMVpYt+ohUEqBu1hFFPXiDPmjaeBOVOacLkx6W31CCKL8S14uB2DWO5+pRI3zai5GnrUSW+jnEmujYq7q4NDfmCtdZygP8uBhUBk6bYeIxzB8QmgzF9V8NWtK3A2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC3FADA7;
	Wed, 28 Aug 2024 23:26:48 -0700 (PDT)
Received: from [10.162.41.23] (e116581.arm.com [10.162.41.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2783E3F66E;
	Wed, 28 Aug 2024 23:26:18 -0700 (PDT)
Message-ID: <5241c418-d5af-46ca-8188-7b67e1640f88@arm.com>
Date: Thu, 29 Aug 2024 11:55:33 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/arm64: Fix build warnings for abi
To: Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com, will@kernel.org,
 ryan.roberts@arm.com, Anshuman.Khandual@arm.com, aneesh.kumar@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240827051851.3738533-1-dev.jain@arm.com>
 <6e5588d9-c22c-4a94-afce-1274c888403e@sirena.org.uk>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <6e5588d9-c22c-4a94-afce-1274c888403e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/28/24 16:10, Mark Brown wrote:
> On Tue, Aug 27, 2024 at 10:48:51AM +0530, Dev Jain wrote:
>
>> -		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
>> +		ksft_exit_fail_perror("PTRACE_TRACEME");
>>   
>>   	if (raise(SIGSTOP))
>> -		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
>> +		ksft_exit_fail_perror("raise(SIGSTOP)");
> The idea with these is to include the error code as well so adding the
> %s would be better.

ksft_exit_fail_perror() can do that thing for us.

>
>>   	for (i = 9; i < ARRAY_SIZE(gpr_in); i++) {
>>   		if (gpr_in[i] != gpr_out[i]) {
>> -			ksft_print_msg("%s SVE VL %d mismatch in GPR %d: %llx != %llx\n",
>> +			ksft_print_msg("%s SVE VL %d mismatch in GPR %d: %lx != %lx\n",
>>   				       cfg->name, sve_vl, i,
>>   				       gpr_in[i], gpr_out[i]);
>>   			errors++;
> This is a different pattern of warning, it'd be easier to review if each
> patch only followed one pattern.  There's no code overlap between the
> changes.

