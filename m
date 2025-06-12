Return-Path: <linux-kselftest+bounces-34834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD85AD799D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5095170169
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CC729DB86;
	Thu, 12 Jun 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MtqaZQgw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650641F03EF;
	Thu, 12 Jun 2025 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749751971; cv=none; b=Au7FxnU6iIMKSkPoAyaQM6aNC2+ZK+JzCc2rdqFPcs8Ihn/WjEja4UuqkcYvI1L60+Wmn1vsTgDBSoYF3AY7ftCiQcgkAxkc8pHVCZhXPKkHM1kZmoT6eck4BNHuDeJC16bsOmbk2kMQDWUNCaWh5CcJ9ftUc+/RxpKFxlW7bcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749751971; c=relaxed/simple;
	bh=W6hcqUdXy8CqRMhltXJvswv0y/Bk2o7f+pYcaBXuBZg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pcK4TqLpKdjQSFgHe9QEN0qBK2MFnK2yDeyoMZhWxm3+Wm6u0A+QtsyGrvQRdS/3F4onC+W4StA3cdHfOvXgSNqPgo0CD/Jyp9PU967qU/OG3rMUY64m0lCEkjPSNQU3E9c6OqMS0AaMI5ofhyECVix43vJf05C4/fa3BVtTCXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=MtqaZQgw; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 55CICBwY3491064
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Jun 2025 11:12:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 55CICBwY3491064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1749751936;
	bh=CYYqu6bI47VUkF0jgCUXpW0R05kZziYss1zdb1XWJdg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=MtqaZQgwwSTYESgLIeefZRce7wvVmLCvsZx6xbjkmOE3wz7AGuz5J9f4YVsqXI2IK
	 lA9jOB5aLDfpg3ZbOtI5VR9sB92FfKAEXzM7o3qGwnKpGoIv68DqP27tryPqE5x/3X
	 xhC0BoI0jQIBBvd226m5UNdOb3fa+snGh2OOzPXoYHbLI7tvHCC0RulAebwSiWZuiM
	 vuv6YMiAsderQ4zJoOiW1HXdC9UgKH5chFYCt+LIX6tpsJWMhqH2xLT1rdNUQqFT6Z
	 NKFj2brOg6vphGmawPgV5oOs4GT9wc4p55MyNudNEfn997Vthx6mWXnHERZ4sn1ScP
	 dWBbSxMaxQ9kA==
Message-ID: <b65054ae-9bd8-4a7a-9554-a85eb4f445fc@zytor.com>
Date: Thu, 12 Jun 2025 11:12:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xin Li <xin@zytor.com>
Subject: Re: [PATCH v4 0/2] x86/fred: Prevent single-step upon ERETU
 completion
To: Sohil Mehta <sohil.mehta@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, andrew.cooper3@citrix.com
References: <20250605181020.590459-1-xin@zytor.com>
 <8264e653-6570-4c2a-a9a7-c4104da26f76@intel.com>
 <06e68373-a92b-472e-8fd9-ba548119770c@intel.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <06e68373-a92b-472e-8fd9-ba548119770c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/2025 2:51 PM, Sohil Mehta wrote:
>>> Xin Li (Intel) (2):
>>>    x86/fred/signal: Prevent single-step upon ERETU completion
>>>    selftests/x86: Add a test to detect infinite sigtrap handler loop
>>>
>> I tested the patches on a machine that supports FRED. The results are as
>> expected:
>>
> Seeing a split lock warning when running the test:
> x86/split lock detection: #DB: sigtrap_loop_64/4614 took a bus_lock trap
> at address: 0x4011ae
> 
> Wanted to get this out sooner for awareness. Will figure out more
> details and send out an update.

We investigated this issue, and figured out the reason why we see a
split lock warning when running the test:

1) The warning is not caused by the test.
2) It's a false warning.
3) It happens even when bus lock detection (BLD) is not enabled.
4) It happens only on the first #DB on a CPU.

The root cause is that Linux writes 0 to DR6 at boot time, which results
in different values in DR6 depending on whether they support BLD or not.

On CPUs that support BLD, writing 0 to DR6 sets DR6 to 0xFFFF07F0, i.e.,
bit 11 of DR6, its BLD flag, is cleared.  Otherwise 0xFFFF0FF0.

But Intel SDM says, other than BLD induced #DB, DR6.BLD is not modified.
To avoid confusion in identifying debug exceptions, software debug-
exception handlers should set bit 11 to 1 before returning.  DR6.BLD
is always 1 if the processor does not support OS bus-lock detection.

Because Linux clears DR6.BLD on CPUs that support BLD at boot time, the
first #DB will be INCORRECTLY interpreted as a BLD #DB, thus the
warning, no matter whether BLD is enabled or not.

We will be working on a fix to initialize DR6 and DR7 with their
architectural reset values instead of 0s.

Thanks!
     Xin



