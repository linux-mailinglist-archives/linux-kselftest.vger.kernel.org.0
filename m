Return-Path: <linux-kselftest+bounces-14770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E285946AD6
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 20:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF04F281A70
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 18:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C180182C9;
	Sat,  3 Aug 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="Tiw8HjQc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF317BAA;
	Sat,  3 Aug 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722709693; cv=none; b=Nxixb/aSe5XpAq+t12BHk9a+nZx5ubPSYgEdZ9HR3SaEWTo6nJho2u3GObQYKl5UCgd3GTC97eiH5lo7OSv4EfAynj1DwYdthOHwOIAOVxW2e3XR5qcyyE4XFcMz5OFC+3AEZZnLmT8LzvgncrHFKW6yNmJxSAsqkXJPe+79Tm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722709693; c=relaxed/simple;
	bh=W1e9O+CvR6TnLZbAY7SjKy1G/uQmBo+ri++lQpJMCl0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SXFi4RIDDH0IrIWZfAq0N0xdVzfIViCbXgWkxR29C9OSSU7+SY8+q4UUeJY0/OL7C5dJdSxf6jrHPwmzxeS7RBd0aDUP186+0qsxvzomkCezpH43zJ8lZDZQLZqnyIifwFJV8jGSgDp1axntBQ/7fcOXif4LQZXIHcRyRPeMqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=Tiw8HjQc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1722709688; bh=W1e9O+CvR6TnLZbAY7SjKy1G/uQmBo+ri++lQpJMCl0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Tiw8HjQcIm286rwUc9U6oe1c8h7o5jk4fGUyc+02FO607KKfK4Oe9YDDwzuSaVULZ
	 lbPeQJGD17gEf6eJVdGuCFS7AF0iXIRFaTN017Xnw3sb3hdwYtvxcCEuEHbuv3Ne+i
	 c2Y5W3GMtWyCyg7h2Rd3/mi3xhf6EDX4C/T4ZCpM=
Date: Sat, 3 Aug 2024 20:28:08 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Message-ID: <713abd5e-1f72-4cf8-9857-c6795b4b3187@t-8ch.de>
In-Reply-To: <20240803092558.GB29127@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net> <20240728-nolibc-llvm-v1-4-bc384269bc35@weissschuh.net> <20240803092558.GB29127@1wt.eu>
Subject: Re: [PATCH 04/12] tools/nolibc: use attribute((naked)) if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <713abd5e-1f72-4cf8-9857-c6795b4b3187@t-8ch.de>

Aug 3, 2024 11:26:07 Willy Tarreau <w@1wt.eu>:

> On Sun, Jul 28, 2024 at 12:09:58PM +0200, Thomas Wei=C3=9Fschuh wrote:
>> The current entrypoint attributes optimize("Os", "omit-frame-pointer")
>> are intended to avoid all compiler generated code, like function
>> porologue and epilogue.
>> This is the exact usecase implemented by the attribute "naked".
>>
>> Unfortunately this is not implemented by GCC for all targets,
>> so only use it where available.
>> This also provides compatibility with clang, which recognizes the
>> "naked" attribute but not the previously used attribute "optimized".
>>
>> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> ---
>> tools/include/nolibc/compiler.h | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>
>> diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/comp=
iler.h
>> index fe3701863634..f77bb7d3e1a8 100644
>> --- a/tools/include/nolibc/compiler.h
>> +++ b/tools/include/nolibc/compiler.h
>> @@ -9,6 +9,15 @@
>> #define __entrypoint __attribute__((optimize("Os", "omit-frame-pointer")=
))
>> #define __entrypoint_epilogue() __builtin_unreachable()
>>
>> +#if defined(__has_attribute)
>> +#=C2=A0 if __has_attribute(naked)
>> +#=C2=A0=C2=A0=C2=A0 undef=C2=A0 __entrypoint
>> +#=C2=A0=C2=A0=C2=A0 define __entrypoint __attribute__((naked))
>> +#=C2=A0=C2=A0=C2=A0 undef __entrypoint_epilogue
>> +#=C2=A0=C2=A0=C2=A0 define __entrypoint_epilogue()
>> +#=C2=A0 endif
>> +#endif /* defined(__has_attribute) */
>
> I would find it cleaner to enclose the previous declaration with the #if
> rather than #undef everything just after it has been defined. Also it's
> not very common to undo declarations just after they've been done, and
> it makes quick code analysis harder.
>
> I think that it can resolve to roughly this:
>
> #if defined(__has_attribute) && __has_attribute(naked)
> #=C2=A0 define __entrypoint __attribute__((naked))
> #=C2=A0 define __entrypoint_epilogue()
> #else
> #=C2=A0 define __entrypoint __attribute__((optimize("Os", "omit-frame-poi=
nter")))
> #=C2=A0 define __entrypoint_epilogue() __builtin_unreachable()
> #endif

We would need to duplicate the define for the
!defined(__has_attribute) case.
I wanted to avoid that duplication.

> What do you think ?

With the reasoning above I'll let you choose.


