Return-Path: <linux-kselftest+bounces-35614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6676EAE3E93
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 13:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F91176727
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 11:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C09823F412;
	Mon, 23 Jun 2025 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="BNBbYErO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADFC188CC9;
	Mon, 23 Jun 2025 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679605; cv=none; b=ew51RNJ+GjehW5lZaONZuFKwd0v9sT/mlhvv1HLo0wbjjqsC3Y8KTX6kxyfKYNW8R53kL6OOfiDgs06vO/8dS7BtgBuTftI/+UqBcgelM67h381NNq19+uucyJaTyQk6S81bsQxG/mBN4C5+lotZptWyYdhMBOtXQIcQ7VHZTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679605; c=relaxed/simple;
	bh=Q+Vh0f3FEfaSjdhyV9/D3F33UGK3JGdNTHOi6QDQrLY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=td0UCtfGbM/GfYVnKmioz3sg+CngWuUYDEzV90hR57Ww/qRMLu3UFXBHX8zqt84+p2nK3bF+5Cv+ZgEio6hkLOgMfCrsPZrxReFqWrfDUIrRxqwPJpvWh5LGwRdyIAcyajBAX2Wxjhs0tdl4vMnjeUa4pjqYltVH4AH3z6/ylfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=BNBbYErO; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 82F3C7D3B8;
	Mon, 23 Jun 2025 13:53:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1750679593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRaI4i7DYLsfm/jQj9FFBzNDsdP4kcTnLOTUm/S2ckY=;
	b=BNBbYErO0rytOESS4LBixCk9HjwnNbGQTiSWnV0RiTnKwDEo9/rEZKTq62o9tsd8F08zu9
	NSfSLHnsDCnBB79U1CFF3rspaaVeUJt1MdEwlzWlGwmINsScN37Qzvh9G+ieyjla8AyzL5
	1VovUmDDhU+tbqciaSQ/iAMk/QVuyFw=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Jun 2025 13:53:11 +0200
Message-Id: <DATW4DAU81FO.388H7H1WSUKAB@pwned.life>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] kallsyms: fix build without execinfo
From: "Achill Gilgenast" <fossdd@pwned.life>
To: "Andrew Morton" <akpm@linux-foundation.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250622014608.448718-1-fossdd@pwned.life>
 <20250622113602.48092b368afc5f1729b45cb6@linux-foundation.org>
In-Reply-To: <20250622113602.48092b368afc5f1729b45cb6@linux-foundation.org>

On Sun Jun 22, 2025 at 8:36 PM CEST, Andrew Morton wrote:
> On Sun, 22 Jun 2025 03:45:49 +0200 Achill Gilgenast <fossdd@pwned.life> w=
rote:
>
>> Some libc's like musl libc don't provide execinfo.h since it's not part
>> of POSIX. In order to fix compilation on musl, only include execinfo.h
>> if available (HAVE_BACKTRACE_SUPPORT)
>>=20
>> This was discovered with c104c16073b7 ("Kunit to check the longest symbo=
l length")
>> which starts to include linux/kallsyms.h with Alpine Linux' configs.
>>=20
>> ...
>>
>> --- a/tools/include/linux/kallsyms.h
>> +++ b/tools/include/linux/kallsyms.h
>> @@ -18,6 +18,7 @@ static inline const char *kallsyms_lookup(unsigned lon=
g addr,
>>  	return NULL;
>>  }
>> =20
>> +#ifdef HAVE_BACKTRACE_SUPPORT
>>  #include <execinfo.h>
>>  #include <stdlib.h>
>>  static inline void print_ip_sym(const char *loglvl, unsigned long ip)
>
> I'm not seeing anything in there which needs execinfo.h.  Can we simply
> remove the inclusion?

No, since backtrace_symbols is provided by execinfo.h.

