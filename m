Return-Path: <linux-kselftest+bounces-36195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E3AEFF7B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 18:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659663B3ADE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1792827C844;
	Tue,  1 Jul 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JeQhMPj5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3D27B4E0;
	Tue,  1 Jul 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386807; cv=none; b=ZDDSCXTfov+U/M2nbNz/E0G5C1x4FZyahY1a8lO4Os9qMhgzbq6KpELK+KATT5/7Q0D0D0KMUXI7nS4hxqPUoYmAo1Xv9w97B7OJNzBgnQGwSPRk7jywGBajmypKdB2ni2+VmQHNY2qFOJeycZGW6F/kJjCmuGdMnbUQw8vBec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386807; c=relaxed/simple;
	bh=XUewoyTGaS8PN53cLTlQP620TGbHYjMWIgOh0zhlOow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zz5MbTAONh8izeC2zvOFM0z+wv6Rg3YhiEpJYU0i/g1hZCyx3fjuRyR0UCKfQL9U1tbipBYYzP8c9XGQFCZ4PAKV7/zItatqHslR2G45dqAsPtDQPNojPyQlJ7A6QxuhCtwdrAKqFbayuaGkJkayZc/XkNlqKR9EkIsReyDGuPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JeQhMPj5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kNr4GTpz5KDYcbRPJrWcHcS/NbX5xNC8V+Q6OcQRh5k=; b=JeQhMPj5SZnA9DL5MCK8l8TURi
	VuXrqEA3N2/kNkEqGqt10IJsx74wwX9oK1Xq2QG2slypgKWxyYYStdQcJOZlxgRzHANyYFVCg8+m3
	yPK0+zmUtf2Qfa35WSVZ4zxXmtPCoetcfFmHz+JtlmnJDV7HqXahWYEIo7tsPr47cG9MFA3OiWtTt
	yrAViKUeyW8NkJ5TzKN6716ooTfj4jVq0j6b4QEkRm0L0jcwBoy8E8jtmSwbRuG+BkjzeCm6qhjKi
	DM5bkb3JEPXNEQreu7FETDdX9UEL9GnI6Zvt324ccEYsvqHsfg/hSoffKOlc11RrCD2dYGVjLm4S3
	kj0kShxQ==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uWdi3-00B2kM-I4; Tue, 01 Jul 2025 18:19:51 +0200
From: Luis Henriques <luis@igalia.com>
To: "Achill Gilgenast" <fossdd@pwned.life>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Linus Torvalds"
 <torvalds@linux-foundation.org>,  "Shuah Khan"
 <skhan@linuxfoundation.org>,  <linux-kselftest@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <stable@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] kallsyms: fix build without execinfo
In-Reply-To: <DB0OSTC6N4TL.2NK75K2CWE9JV@pwned.life> (Achill Gilgenast's
	message of "Tue, 01 Jul 2025 13:37:37 +0200")
References: <20250622014608.448718-1-fossdd@pwned.life>
	<20250622113602.48092b368afc5f1729b45cb6@linux-foundation.org>
	<DATW4DAU81FO.388H7H1WSUKAB@pwned.life>
	<DB0OSTC6N4TL.2NK75K2CWE9JV@pwned.life>
Date: Tue, 01 Jul 2025 17:19:51 +0100
Message-ID: <87ecuz51eg.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01 2025, Achill Gilgenast wrote:

> On Mon Jun 23, 2025 at 1:53 PM CEST, Achill Gilgenast wrote:
>> On Sun Jun 22, 2025 at 8:36 PM CEST, Andrew Morton wrote:
>>> On Sun, 22 Jun 2025 03:45:49 +0200 Achill Gilgenast <fossdd@pwned.life>=
 wrote:
>>>
>>>> Some libc's like musl libc don't provide execinfo.h since it's not part
>>>> of POSIX. In order to fix compilation on musl, only include execinfo.h
>>>> if available (HAVE_BACKTRACE_SUPPORT)
>>>>=20
>>>> This was discovered with c104c16073b7 ("Kunit to check the longest sym=
bol length")
>>>> which starts to include linux/kallsyms.h with Alpine Linux' configs.
>>>>=20
>>>> ...
>>>>
>>>> --- a/tools/include/linux/kallsyms.h
>>>> +++ b/tools/include/linux/kallsyms.h
>>>> @@ -18,6 +18,7 @@ static inline const char *kallsyms_lookup(unsigned l=
ong addr,
>>>>  	return NULL;
>>>>  }
>>>>=20=20
>>>> +#ifdef HAVE_BACKTRACE_SUPPORT
>>>>  #include <execinfo.h>
>>>>  #include <stdlib.h>
>>>>  static inline void print_ip_sym(const char *loglvl, unsigned long ip)
>>>
>>> I'm not seeing anything in there which needs execinfo.h.  Can we simply
>>> remove the inclusion?
>>
>> No, since backtrace_symbols is provided by execinfo.h.
>
> Is there some status on it? I saw you picked it in mm-hotfixes-unstable,
> but it got dropped out again.
>
> Is there something I can do to push it?

FWIW I can confirm this is indeed a regression.  And specially annoying
because it has been backported into stable kernels (even if having kunit
tests backported sounds odd to me).

It would be great to have this fixed, or reverted.

Cheers,
--=20
Lu=C3=ADs

