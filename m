Return-Path: <linux-kselftest+bounces-36175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E1AEF6EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 13:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA2C1BC2FAE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913A322DFA3;
	Tue,  1 Jul 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="p5jRpfyY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF88259C83;
	Tue,  1 Jul 2025 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370317; cv=none; b=XFLjgGn1nKvODFkyOcmQn5PGtha2eqYhBTGNDlFeutL9quH05S+/zCHEBGLcAuFHyzH0QVPy+T7KAr2vlEMPGvBGR82jNCaVasjp/+eh18wu75nOOAE0scodA1e0E6HXz91yI5oqzibPYMXe1cesWxFtV6k+Xc9YDbrFo7as0PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370317; c=relaxed/simple;
	bh=sVovuMTF5tAHPiCPKHLjhZPgKA8N730V48hVE+q9Zs8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fwiHX5mpr/y1uUH8lH/swgbhLfuFifN/WKCIl48twq782pHUYKcKFTSDMOyT3WCoUQBmVu+o1DKVDfAEoFdjbInvzPKlmtJdRAKulBN9IIwCoxECsqEK6p3nc+AwqpY+q/ckXaArssAaqSuv0zr/hBzJ4OK3VcxfHsuXlPEgs4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=p5jRpfyY; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 43C547D3B8;
	Tue,  1 Jul 2025 13:37:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1751369861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVgDAEpVfCK2rfSTwfo8zjZAUpXMr5uBg9i9X14EHcs=;
	b=p5jRpfyY83dkXaHxaCJPcaV4zjMzuqIdqo5Xi1qvNeRy+2poIk1vHlYxIPRYO5+A0GpbnR
	9A94O3kpaBmg9kOMld4bQiLBiY1rLu+6kV/3pTOn9p3nyRShzXeLmr+Bpj9PKFaGHejkQT
	m4tYZD4+qySJM1eJoIl/UE0RfDg/iL8=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Jul 2025 13:37:37 +0200
Message-Id: <DB0OSTC6N4TL.2NK75K2CWE9JV@pwned.life>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Achill Gilgenast" <fossdd@pwned.life>
Subject: Re: [RESEND PATCH v2] kallsyms: fix build without execinfo
From: "Achill Gilgenast" <fossdd@pwned.life>
To: "Andrew Morton" <akpm@linux-foundation.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250622014608.448718-1-fossdd@pwned.life>
 <20250622113602.48092b368afc5f1729b45cb6@linux-foundation.org>
 <DATW4DAU81FO.388H7H1WSUKAB@pwned.life>
In-Reply-To: <DATW4DAU81FO.388H7H1WSUKAB@pwned.life>

On Mon Jun 23, 2025 at 1:53 PM CEST, Achill Gilgenast wrote:
> On Sun Jun 22, 2025 at 8:36 PM CEST, Andrew Morton wrote:
>> On Sun, 22 Jun 2025 03:45:49 +0200 Achill Gilgenast <fossdd@pwned.life> =
wrote:
>>
>>> Some libc's like musl libc don't provide execinfo.h since it's not part
>>> of POSIX. In order to fix compilation on musl, only include execinfo.h
>>> if available (HAVE_BACKTRACE_SUPPORT)
>>>=20
>>> This was discovered with c104c16073b7 ("Kunit to check the longest symb=
ol length")
>>> which starts to include linux/kallsyms.h with Alpine Linux' configs.
>>>=20
>>> ...
>>>
>>> --- a/tools/include/linux/kallsyms.h
>>> +++ b/tools/include/linux/kallsyms.h
>>> @@ -18,6 +18,7 @@ static inline const char *kallsyms_lookup(unsigned lo=
ng addr,
>>>  	return NULL;
>>>  }
>>> =20
>>> +#ifdef HAVE_BACKTRACE_SUPPORT
>>>  #include <execinfo.h>
>>>  #include <stdlib.h>
>>>  static inline void print_ip_sym(const char *loglvl, unsigned long ip)
>>
>> I'm not seeing anything in there which needs execinfo.h.  Can we simply
>> remove the inclusion?
>
> No, since backtrace_symbols is provided by execinfo.h.

Is there some status on it? I saw you picked it in mm-hotfixes-unstable,
but it got dropped out again.

Is there something I can do to push it?

Thanks!

