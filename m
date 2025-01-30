Return-Path: <linux-kselftest+bounces-25412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3551BA2297F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 09:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55697A1AA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94E1AF0A4;
	Thu, 30 Jan 2025 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=commonscaretakers.com header.i=@commonscaretakers.com header.b="WtawRq14"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.commonsconservancy.org (mail.commonsconservancy.org [145.0.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD51547C9;
	Thu, 30 Jan 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.0.6.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225387; cv=none; b=IUWd4SytRTliklUxZBqNzKpo2oQwMdB5RJss6sTQFGaZv8nQtOkkJ5x756AEgprzIVXRxKgDRV7NChdXZ6Nyi/QhLWoI2SRMcRBTz/q4q2L8Eh+X7Y7cid2tAEtzdtZ1ivdlWWofKxapAJEwVQ/8M7VYloXJ9qnX/rzr590D14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225387; c=relaxed/simple;
	bh=W1HGQeWiI7DGarfdPCTexu2vnq+AI71U1x1FITmeeU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCTVMGF9z2W6F4J206cfQCv+DEfPuno97y0ACa1baz6ysv+KoW7BiwVibWzJZEDmTVI5ax59uhYYn0xpRSC11vUleJj6xNG1GXA09qSb+UpbQ48817vB78BZ0cJ7T5nPVwGw33XOytdMwwz3wVYBcWgcdFk1B68onWN3LSFSqfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commonscaretakers.com; spf=pass smtp.mailfrom=commonsconservancy.org; dkim=pass (1024-bit key) header.d=commonscaretakers.com header.i=@commonscaretakers.com header.b=WtawRq14; arc=none smtp.client-ip=145.0.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commonscaretakers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commonsconservancy.org
Message-ID: <d85d8d0e-0f87-4aff-8717-0ce0e0287b48@commonscaretakers.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=commonscaretakers.com; s=mail; t=1738225380;
	bh=F3oF2vdiNpWzLeHJSWldOsAUvw/98RatHqWOT4t+fRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WtawRq14KNSHVfxPBuIRMp1hSaUOsSipwlbWFZdahUPMpSUieEr4p+Z86ERjGCST0
	 VJ5eHtgZcLkUZ0YMGSIOoRAhWXYNY1VM0SC5+PoGXSX9JbHR9nvLjhGufHQ7PbA74T
	 E/CSEjitCtk2SxBtHPYECmo3r/C6dW7LCNsY0HXk=
Date: Thu, 30 Jan 2025 09:23:00 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 01/21] bcachefs: remove dead code in is_aligned
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Shuah Khan
 <shuah@kernel.org>, linux-bcachefs@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250128163859.1883260-1-agruenba@redhat.com>
 <20250128163859.1883260-2-agruenba@redhat.com>
 <aaac3569-2c96-45dd-bd3b-4a5080833767@commonscaretakers.com>
 <CAHc6FU5rWFosNax-1f9K4ihk-Y==Cd5RXj+xsHzxkyLvmdLmng@mail.gmail.com>
Content-Language: en-US, en-GB, nl
From: Eric Herman <eric@commonscaretakers.com>
In-Reply-To: <CAHc6FU5rWFosNax-1f9K4ihk-Y==Cd5RXj+xsHzxkyLvmdLmng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Andreas,

On 2025-01-29 14:19, Andreas Gruenbacher wrote:
> On Wed, Jan 29, 2025 at 11:32 AM Eric Herman <eric@commonscaretakers.com> wrote:
>> Hello Andreas,
>>
>> On 2025-01-28 17:38, Andreas Gruenbacher wrote:
>>> This statement does nothing.
>> I would suggest this statement does nothing only in the case of #ifndef
>> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
>>
>> In the case where CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS _is_ defined,
>> it tells the compiler that it should not emit a warning for an unused
>> parameter.
>>
>> Perhaps it should be moved in to an #else of the #ifndef in order to
>> more clearly communicate that it is expected and okay to ignore this
>> parameter in this case.
> How about declaring base __maybe_unused?

Yes, that would be better.

Cheers,

-Eric


>
> Thanks,
> Andreas
>
>> Cheers,
>> -Eric
>>
>>> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>>> ---
>>>    fs/bcachefs/eytzinger.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/fs/bcachefs/eytzinger.c b/fs/bcachefs/eytzinger.c
>>> index 2eaffe37b5e7..c0fdfe909cf2 100644
>>> --- a/fs/bcachefs/eytzinger.c
>>> +++ b/fs/bcachefs/eytzinger.c
>>> @@ -20,7 +20,6 @@ static bool is_aligned(const void *base, size_t size, unsigned char align)
>>>    {
>>>        unsigned char lsbits = (unsigned char)size;
>>>
>>> -     (void)base;
>>>    #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>>>        lsbits |= (unsigned char)(uintptr_t)base;
>>>    #endif

