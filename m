Return-Path: <linux-kselftest+bounces-11249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BAC8FCE87
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 15:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805851F29FCD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37EB19B3F8;
	Wed,  5 Jun 2024 12:26:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5377219B3DF;
	Wed,  5 Jun 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717590393; cv=none; b=JeUjOphUhKFUlAQ8LEvtCyCw7ITOptOtOp2xPUo1Xjta3tTNxPFHmA/6tSOWS+trLIo7GEMAQ9eXugzHD8TCuxe6Ldi3omgxT9S2LJhnL0bLusVgbn7qemdnCds451eb9zC6OCNLEHsKInADKAEgj0Fp5vbXfIfVpSn3q4xZC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717590393; c=relaxed/simple;
	bh=OpM7hf33K9cNQBheqRJr3tktJceZPUA/A8LQOs1Ns34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCr+NkR2raabwZ0pju/H9LMHwDZeaIdL9A/Y7ZMAkZDeFyrl+fFU2yElkWJf5ce//MysB2CgSwuS93eInfn6jCqYtsffdK5+3k7/Jp6/o8KroktOo1XYXRz1K6ZiTfx5CRDaKpGZ26D9mRh1N7GRqT3zNxJIoPHHjCAF2tBN8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29038DA7;
	Wed,  5 Jun 2024 05:26:56 -0700 (PDT)
Received: from [10.162.40.27] (e116581.arm.com [10.162.40.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B878B3F762;
	Wed,  5 Jun 2024 05:26:28 -0700 (PDT)
Message-ID: <9710a691-1c94-4f0b-b320-9fc78ee15ae8@arm.com>
Date: Wed, 5 Jun 2024 17:56:25 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: arm64: Fix redundancy of a testcase
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 will@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com
References: <20240605115448.640717-1-dev.jain@arm.com>
 <a518770a-371e-4333-b85d-6a5808a7ac09@sirena.org.uk>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <a518770a-371e-4333-b85d-6a5808a7ac09@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/5/24 17:30, Mark Brown wrote:
> On Wed, Jun 05, 2024 at 05:24:48PM +0530, Dev Jain wrote:
>> Currently, we are writing the same value as we read, into the TLS
>> register; hence, we cannot confirm updation of the register, making the
>> testcase "verify_tpidr_one" redundant. Fix this; while at it, do a style
>> change.
> Please don't combine unrelated changes into a single patch.


I shall take care of that in the future.

>
>>   	/* ...write a new value.. */
>>   	write_iov.iov_len = sizeof(uint64_t);
>> -	write_val[0] = read_val[0]++;
>> +	write_val[0] = read_val[0] + 1;
>>   	ret = ptrace(PTRACE_SETREGSET, child, NT_ARM_TLS, &write_iov);
>>   	ksft_test_result(ret == 0, "write_tpidr_one\n");
> This is a good fix:
>
> Reviewed-by: Mark Brown <broonie@kernel.org>


Thanks!

>
>> @@ -108,7 +108,7 @@ static void test_tpidr(pid_t child)
>>   		/* Writing only TPIDR... */
>>   		write_iov.iov_len = sizeof(uint64_t);
>>   		memcpy(write_val, read_val, sizeof(read_val));
>> -		write_val[0] += 1;
>> +		++write_val[0];
> I'm less convinced that this is a good style change.


Well, what I have seen usually is, when we add 1, we

use prefix/postfix increment, and do a "+=" when it

is not 1. But, I get your point: such style may confuse

people into thinking that we are doing an index/pointer

increment, since that is the usual usecase for this.


