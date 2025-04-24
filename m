Return-Path: <linux-kselftest+bounces-31566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD70CA9B1F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD4D4C0613
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631F1A3161;
	Thu, 24 Apr 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IlMatfKG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5B2701C1;
	Thu, 24 Apr 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508010; cv=none; b=u10wyZ/C0FCNnkNDm7h1LKQwaJnxmvOkE4wJ8QfPM0pgf5QziZ8kQB66J8b7f4KFA52EmyEJ6E+d2a9Ld38fGbI1L9q4oVRhZ32vsrGeOhAYPeLH8i7SsvPX51TZkONTZ+ZKWawTTZ8PcWwzthr0SzjeisBNl/MbYki0T3i3kBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508010; c=relaxed/simple;
	bh=FTR3qR4eB1xjhqvsT8gE8rQVJyifQCog9eR/lB1z9Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBNPIqPNeSBkT/ppta2zFRrpZcgjpmrcVs4KUl/ESG9QdwAMFbiTAc+c+qpml2sSWvWd/nqgcvw3m+3aJ1lMvOyboupIBv8P7lNHrxBS6O/mZ+YWpO84kLgwet8Ai9BVp3W5rukko1L2bVEuvE5dg8vMHaD9UUKbuixIoFdkFjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IlMatfKG; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 7yMoua7H5wRVI7yMsuNY8m; Thu, 24 Apr 2025 17:20:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745508006;
	bh=UcRU84HsboGldiIby4CinC7XtHRCMmOTyA35bDZzmpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=IlMatfKGSqTGw+q/4OgDCGiW2NsJPwOgVaSaY5hsyGdzVSvA5ZN77Tg7o6bGJ3MLw
	 Am3IRdS0Htvd1iGVXBg7S+Eo7y7l0E4LMld1b04Mg5oG3FYjoh/DDEaX9oV8hh5/NA
	 98Pefigb8r/NT4r1GHd29yIhm1pNgFP1WGSsSUsdh9jBhWtzUUj73LHIY3xR5+flGW
	 bvxRSMKf+LXe82z8cl0t/Lbk+f++JcmOlebir0Grfn9SH8m1kCZQ71ZYOblpgSMwDv
	 vGa8vdKvKjctyZcpZwX7rkdv4gDgUn+IGdOLrieQrMx45+fiP9uYLhVi7v/5MuSy4Y
	 bg1hjUZZizeDQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Apr 2025 17:20:06 +0200
X-ME-IP: 124.33.176.97
Message-ID: <689f5812-7836-4af7-a000-3f514565ec44@wanadoo.fr>
Date: Fri, 25 Apr 2025 00:19:58 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] selftest: can: Start importing selftests from
 can-tests
To: Felix Maurer <fmaurer@redhat.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <cover.1745323279.git.fmaurer@redhat.com>
 <CAMZ6RqK8TdzzMW645OLq5tbkyQdYW+tGGVcr7vsRBE81_u4W4Q@mail.gmail.com>
 <c2729303-8ee9-4fe3-9755-2b6d0d0d7b97@redhat.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <c2729303-8ee9-4fe3-9755-2b6d0d0d7b97@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/04/2025 at 23:01, Felix Maurer wrote:
> On 24.04.25 09:45, Vincent Mailhol wrote:
> [...]
>>> Felix Maurer (4):
>>>   selftests: can: Import tst-filter from can-tests
>>>   selftests: can: use kselftest harness in test_raw_filter
>>>   selftests: can: Use fixtures in test_raw_filter
>>>   selftests: can: Document test_raw_filter test cases
>>
>> You are doing a lot of change to the original to the point that this
>> is more a full rewrite. I have no intent of reviewing the first patch
>> which is just the copy paste from the original. If no one else has a
>> strong opinion on this, I would rather prefer if you just squash
>> everything and send a single patch with the final result. This will
>> also save you some effort when migrating the other tests.
>>
>> I have a few comments on the individual patches, but overall very
>> good. Thanks a lot!
> 
> Thank you very much for your feedback! I'll silently include most of it
> and will only reply where I think discussions are necessary.
> 
> For squashing / keeping this as individual patches: I usually like to
> have some kind of history available, but here it might not provide a lot
> of value. I would be fine with squashing as well. If there are any
> stronger opinions on this, keep them coming.

I would normally agree, but here, I did a git diff between the first patch and
the final result, and there is just fives lines of code which you did not touch.

If I want to review each patch (which I normally always do), this becomes double
work. Splitting a series in small patches should simplify the review process,
unfortunately, here, it had the opposite effect for me.


Yours sincerely,
Vincent Mailhol


