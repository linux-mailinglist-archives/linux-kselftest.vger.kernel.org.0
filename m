Return-Path: <linux-kselftest+bounces-31564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEADFA9B10A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DFC4A6CF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 14:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488C915533F;
	Thu, 24 Apr 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Mo0zD16k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-67.smtpout.orange.fr [193.252.22.67])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F432701DA;
	Thu, 24 Apr 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505218; cv=none; b=lHVe5pPKQRFtTBmIKRTudG8Tnw0seou2gHfEM0RwDQVtPTRfZOIC+lq/JGb81Kn/BAvx+AGgiAzRxMTI6R+MXBvG0COkA/Csz2aEiTVnixhH8cOw9ostp2Lpv2aHwqCYifC9zYtqJGT7MuQdh9pjoNwtV6GKhlD9otCOWiWFIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505218; c=relaxed/simple;
	bh=bdu4AdfU3rVBoxI7dS381WsNGFKefFYdMLFb+5Z2TMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsnzu3FBpHIr5xsURRaJQ6eywc2fNo2KkcU11NxlcI8Nfw7fGkIRJKBiEIs+vqRRGP27b/OFoclMDt4kaD7rgR31GD8r/vopt5VXZo4VSIEOednu6y6arW1z1MJtoz4HZmXhKHw8but1sQGe7LMXKO3aeK1iFyN5AtHz6LyZBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Mo0zD16k; arc=none smtp.client-ip=193.252.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 7xUeu3cnoukJt7xUiuRXfG; Thu, 24 Apr 2025 16:24:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745504649;
	bh=K9cTD87TavWzyJKYV4zrWDK5k7WI86kJqfUPCYnBnpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Mo0zD16kfhROPb+1Ho5AGTv/skh9UvI9T+ybmvv0ZaPxLZk/mRql/25aIiG8QyLCe
	 tvxfUJsuopjzSih0MEig6qCnAog+5SP+EMQwFehpp9jWfjQH3UbRHUiZEDxvxAXfad
	 RNooe3PS1rVFnrCa6LKgdWKDncDCdIIdFz4n0db4lkkILWSELqJPYRLnDm3RYA43Bn
	 oM5uxlXMQYjE6e9suw2j9QZkzwlBfcEstuxJDkMkuzkds4s1w/nhnBWYe8qP4GDtVl
	 vuklKInx8Tvyi5Cahx1qUsKW6AE+SmJJfgm5+Lt52iwK2XwMrjobv6E2ulGXl00phY
	 /rpMczZfmaSPA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Apr 2025 16:24:09 +0200
X-ME-IP: 124.33.176.97
Message-ID: <6c1980f7-9cdb-4443-830d-1d76dc8e2dd6@wanadoo.fr>
Date: Thu, 24 Apr 2025 23:23:59 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] selftests: can: Import tst-filter from can-tests
To: Felix Maurer <fmaurer@redhat.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <cover.1745323279.git.fmaurer@redhat.com>
 <a4468403cc51ea6c0e8495d7d095befb37aa5aaf.1745323279.git.fmaurer@redhat.com>
 <CAMZ6RqKfdNRBKoH16=7JDC2QKB+XO68mahg2X7zKDcUAM+8bzw@mail.gmail.com>
 <96bd9677-c257-480b-be3c-7c4b9b79b238@redhat.com>
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
In-Reply-To: <96bd9677-c257-480b-be3c-7c4b9b79b238@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2025 at 23:02, Felix Maurer wrote:
> On 24.04.25 09:42, Vincent Mailhol wrote:
>> On Tue. 22 Apr. 2025 at 21:08, Felix Maurer <fmaurer@redhat.com> wrote:
> [...]
>>> +ALL_TESTS="
>>> +       test_raw_filter
>>> +"
>>> +
>>> +net_dir=$(dirname $0)/..
>>> +source $net_dir/lib.sh
>>> +
>>> +VCANIF="vcan0"
>>
>> Here, you are making the VCANIF variable configuration, but then, in
>> your test_raw_filter.c I see:
>>
>>   #define VCANIF "vcan0"
>>
>> This means that in order to modify the interface, one would have to
>> both modify the .sh script and the .c source. Wouldn't it be possible
>> to centralize this? For example by reading the environment variable in
>> the C file?
>>
>> Or maybe there is a smarter way to pass values in the kernel selftests
>> framework which I am not aware of?
> 
> Good point, I'll try to come up with something to avoid the duplication
> (either from the selftest framework or just for the CAN tests). I'd
> prefer an argument to the program though, as I find this the more usual
> way to pass info if one ever wants to run the test directly.

Passing an argument would be the best. I am not sure how to do this with the
selftests (but I did not investigate either).

>>> +setup()
>>> +{
>>> +       ip link add name $VCANIF type vcan || exit $ksft_skip
>>> +       ip link set dev $VCANIF up
>>> +       pwd
>>> +}

Speaking of which, if you allow the user to modify the interface, then you will
one additional check here to see whether it is a virtual can interface or not
(the ip link commands are not the same for the vcan and the physical can).

Something like:

  CANIF="${CANIF:-vcan}"
  BITRATE="${BITRATE:-500000}"

  setup()
  {
  	if [ $CANIF == vcan* ]; then
  		ip link add name $CANIF type vcan || exit $ksft_skip
  	else
  		ip link set dev $CANIF type can $BITRATE 500000
  	fi
  	ip link set dev $VCANIF up
  	pwd
  }

>>> +cleanup()
>>> +{
>>> +       ip link delete $VCANIF
>>> +}
>>
>> I guess that this setup() and this cleanup() is something that you
>> will also need in the other can tests. Would it make sense to declare
>> these in a common.sh file and just do a
>>
>>   source common.sh
>>
>> here?
> 
> I usually try to avoid making changes in anticipation of the future. I'm
> not sure if all the tests need a similar environment and would prefer to
> split this when we encounter that they do. Are you okay with that?

Yes, this works. Keep this idea in back of your mind and if there is a need to
reuse those in the future, then it will be a good timing to do the factorize the
code.


Yours sincerely,
Vincent Mailhol


