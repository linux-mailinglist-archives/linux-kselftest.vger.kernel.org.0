Return-Path: <linux-kselftest+bounces-6317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3330887B9AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 09:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C786E1F2225A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Mar 2024 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7C6E61E;
	Thu, 14 Mar 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GeJQuTwT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C856E2BD;
	Thu, 14 Mar 2024 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406166; cv=none; b=YiyzVTK+YhCpD+tL5UZ0ivNjqOmGzxO8YEFt9EiOFWKekfYG8fF8ENoDsHg0dFZH3AEqg6b7n6pJlQsPbC6RbOlt8YrqTf/63Ec14kmJ0aL16ysL9QpJDUEl4w1qxwRKx6+K7o15HjYGTx/2WY+M4VIDHR+qFYnTuJpmm4JM/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406166; c=relaxed/simple;
	bh=Oe3BH7USiNUFWKTKhcA9+9IjBgMb9I3pa6CrE41kAjg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VfW6WX/TKW1IMd3pqAHjCZCFAlNGw+UUiKnVKVEqpeJhIfY291/ED/Fb/L3xuWGDH8wJmaX+A+OmX19e4lexxm5jnpwVk/8O5sYCMa/r09uWj63Dwh8d77Xu+liRqwrw6PynDLm5/tAKTTd002DxsusyLqdOgB0FylA2nyEGyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GeJQuTwT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710406163;
	bh=Oe3BH7USiNUFWKTKhcA9+9IjBgMb9I3pa6CrE41kAjg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GeJQuTwT5jRMjSydCuhTtQLMeOC0n16/LaJX9cWExlWBjrAESWPs3EuGPBBE7uV3d
	 m2VewCjjJ27T1xFjaycTfpa0o6Y7hDNrdQZDII1v1INDiPmy9x6K0CNNN7tpa3Agem
	 ahRZBNmZygr9p9ZXKmdwfB3pw1FwsqEYa1e/RPa5xcw/ftSFgw++BfjcsTz69yOGRo
	 1meEqv/y5/BYiPucBnCREN78o0HE4d4Ip3/IIPhrFTUoakoRsvwp7qMjLdKIl4Gvai
	 xxdcGXma0Ux+StwpRw4CPVMDJl1inIjbN+mVvWeLIsKPX4FGlhAgDMQyvm1fAH4gc7
	 pf61fuiAfyCFg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B413D378105A;
	Thu, 14 Mar 2024 08:49:20 +0000 (UTC)
Message-ID: <0459b58d-972e-42cf-8516-befc39fbe97c@collabora.com>
Date: Thu, 14 Mar 2024 13:49:50 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [Test Failure Report] exec: Test failures in execveat
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
References: <02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com>
 <202403051256.7A50FE28E7@keescook>
 <fd210d04-cc98-4e29-a051-bdb7e1367494@collabora.com>
 <202403071238.AC7BD90@keescook>
 <cf98ff2f-66a8-4800-855f-5c03c952b514@collabora.com>
 <202403132004.84C9C50A5@keescook>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202403132004.84C9C50A5@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/24 8:05 AM, Kees Cook wrote:
> On Mon, Mar 11, 2024 at 10:08:36PM +0500, Muhammad Usama Anjum wrote:
>> On 3/8/24 1:39 AM, Kees Cook wrote:
>>> On Thu, Mar 07, 2024 at 02:22:27PM +0500, Muhammad Usama Anjum wrote:
>>>> I've tested this patch. Still getting same failures.
>>>
>>> Okay, thanks for testing!
>>>
>>> What environment are you testing under? It would seem like some unexpected
>>> userspace conditions exist that the test isn't prepared for. (I was able
>>> to reproduce one error with /bin/dash, for example, but not the others,
>>> so something must be different in the set up.)
>> I'm testing on Debian Bookworm with v6.1, v6.7 and next-20240304 kernels.
>> I've tested it on another VM which is also Debian Bookworm. The default
>> shell is dash on Debian as well.
> 
> Do you know which kernel version this _passes_ on? I haven't been able
> to find when this actually returned the expected values...
I'd tried to find a kernel on which it used to pass i.e., I rewinded the
kernel to the last change in this test. But still it was failing on that.
Not sure if the test is wrong or the environment is making the test to
output wrong values.

> 

-- 
BR,
Muhammad Usama Anjum

