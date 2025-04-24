Return-Path: <linux-kselftest+bounces-31565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBD3A9B1C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF6A1B82AD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AEB1B4227;
	Thu, 24 Apr 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SrypTBa6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-71.smtpout.orange.fr [193.252.22.71])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B211B3956;
	Thu, 24 Apr 2025 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507349; cv=none; b=SoueQVMtfYNUoU7bZLJl9OQAnUZSBYDzZrv8ew+Q8x5i/lNpL3Y0qMejwvqLKg5CM/lIbaE0wisnKFH1BSRZR0xjZQxAW3qpWafk645r+alMzGDDHUWeyccmuHbTuNcAVj4d62w+YNRvzr0quD0j1r+mxxQ66W6pDKWLQ1YILMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507349; c=relaxed/simple;
	bh=Lw33CZ8S79X/sR2PtH1q63uqsef97qH8S6qxtNaV+dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=il0ALyWbDPrrUIYzsSIXxoZiZYGLG/VnD0+xBEADGgbu5MJAY116MhXE6xF04aVcVBPN689H9E2WYaloiQ+u5EW1uvTv9ecDWjP0zsLhZTb26kBgUDNlcEHVcuA9htNFsifZ7FYEWcesn7XE9JCFyZlqCw6asAn+CgB2ZaEMSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SrypTBa6; arc=none smtp.client-ip=193.252.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id 7yC7ua2ZRwRVI7yCBuN2L4; Thu, 24 Apr 2025 17:09:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745507344;
	bh=DAICTEEOZvKDrL2D579hybhlxPmVYQ2G5S8tYo/Bfag=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=SrypTBa6g8VkOb5W2VfUGqRuZfRu68xAsgWvlAIEIGZxdzbdV3iDmnmNqZVw+U+Ri
	 7Ejm/ApvntEuB+KKq8BHDAqyrj/DC0hml5CN04s2OOa53PmZhXK1WcKqpYpdzlxmAL
	 sXN4qOLLORx/yQCD129wdg6TG80NHMcDbMVWdW+qKxLZUXQT7YZC3R2kONRIm10/X2
	 bZcudWrBO6a9Sw5RMTaSTKk6Vfls1tY7NOzKPnIPmUvMPjddjz5WLHsD4ueQvTbIaM
	 m3MjfVT5r2mNsh0FawAdLIfysmre+U8WHJlUIOoM3pryOKzxkPz4o03woFUP6UvMBv
	 shT68c6Or7eow==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Apr 2025 17:09:04 +0200
X-ME-IP: 124.33.176.97
Message-ID: <08cb8dd7-5685-4a41-b6a9-c8758a804ed1@wanadoo.fr>
Date: Fri, 25 Apr 2025 00:08:54 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests: can: Document test_raw_filter test cases
To: Felix Maurer <fmaurer@redhat.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, fstornio@redhat.com
References: <cover.1745323279.git.fmaurer@redhat.com>
 <710557cef8fb8472628862d9b65edcf7aeb32bb5.1745323279.git.fmaurer@redhat.com>
 <CAMZ6RqKcp=JNcbZjX6xSGo9Hyw=1nXbpS9Nc36xuDkbGG+=wtA@mail.gmail.com>
 <a28ff624-c73a-4e16-867a-66e423315c29@redhat.com>
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
In-Reply-To: <a28ff624-c73a-4e16-867a-66e423315c29@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/04/2025 at 23:02, Felix Maurer wrote:
> On 24.04.25 09:44, Vincent Mailhol wrote:
>> On Tue. 22 Apr. 2025 at 21:03, Felix Maurer <fmaurer@redhat.com> wrote:
> [...]
>>> diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
>>> index 7fe11e020a1c..8d43053824d2 100644
>>> --- a/tools/testing/selftests/net/can/test_raw_filter.c
>>> +++ b/tools/testing/selftests/net/can/test_raw_filter.c
>>> @@ -101,94 +101,113 @@ FIXTURE_VARIANT(can_filters) {
>>>         int exp_num_rx;
>>>         int exp_rxbits;
>>>  };
>>> +#define T_EFF (CAN_EFF_FLAG >> 28)
>>> +#define T_RTR (CAN_RTR_FLAG >> 28)
>>
>> I do not like this
>>
>>   >> 28
>>
>> shift. I understand that it is part of the original design, but for
>> me, this is just obfuscation.
>>
>> Why just not using CAN_EFF_FLAG and CAN_RTR_FLAG as-is for the
>> expected values? What benefit does this shift add?
> 
> I agree, that looks like magic numbers and the original design is not
> very nice here. The main reason for the >>28 is that later on values are
> shifted by T_EFF and/or T_RTR, so they shouldn't be too large (with the
>>> 28, the shift value later is in the range 0-14). See below for a
> slightly different idea.
> 
>>> +/* Ignore EFF flag in filter ID if not covered by filter mask */
>>>  FIXTURE_VARIANT_ADD(can_filters, base_eff) {
>>>         .testcase = 2,
>>>         .id = ID | CAN_EFF_FLAG,
>>>         .mask = CAN_SFF_MASK,
>>>         .exp_num_rx = 4,
>>> -       .exp_rxbits = 4369,
>>> +       .exp_rxbits = (1 | 1 << (T_EFF) | 1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
>>                          ^
>> What is the meaning of this 1?
> 
> The 1 means that a packet will be received with no flags set.

OK. Now I understand.

> The whole rxbit thing took me a while to understand and the result now
> is not straightforward either. Let's see if we can come up with
> something better.
> 
> The exp_rxbits is basically a bitfield that describes which flags should
> be set on the received frames. Maybe this could be made more explicit
> with something like this:
> 
> .exp_rxbits = FRAME_NOFLAGS | FRAME_EFF | FRAME_RTR | FRAME_EFFRTR,

This is better. But yet, how would this scale in the future if we introduce the
CAN FD? For n flags, you have n combinations.

> And in the receive loop something like this:
> 
> rxbits |= FRAME_RCVD(frame.can_id);
> 
> Of course, the definitions of these macros would still have the >>28,
> but at a central point, with better explanation. Do you think that's
> more understandable? Or do you have a different idea?

The

  >> 28

trick just allows to save a couple line but by doing so, adds a ton of
complexity. What is wrong in writing this:


  FIXTURE_VARIANT(can_filters) {
  	int testcase;
  	canid_t id;
  	canid_t mask;
  	int exp_num_rx;
  	canid_t exp_flags[];
  };

  /* Receive all frames when filtering for the ID in standard frame format */
  FIXTURE_VARIANT_ADD(can_filters, base) {
  	.testcase = 1,
  	.id = ID,
  	.mask = CAN_SFF_MASK,
  	.exp_num_rx = 4,
  	.exp_flags = {
  		0,
  		CAN_EFF_FLAG,
  		CAN_RTR_FLAG,
  		CAN_EFF_FLAG | CAN_RTR_FLAG,
  	},
  };

And then, in your TEST_F(), the do {} while loops becomes a:

  for (int i = 0; i <= variant->exp_num_rx; i++) {
  	/* FD logic here */
  	ret = FD_ISSET(self->sock, &rdfs);
	if (i == variant->exp_num_rx) {
  		ASSERT_EQ(ret == 0);
  	} else (i < variant->exp_num_rx)
  		/* other relevant checks */
  		ASSERT_EQ(frame.can_id & ~CAN_ERR_MASK ==
  		          variant->exp_flags[i]);
  	}
  }

Here, you even check that the frames are received in order.

OK, the bitmap saved some memory, but here, we are speaking of selftests. The
priority is readability. I will happily get rid of the bitmap and just simplify
the logic.



Yours sincerely,
Vincent Mailhol


