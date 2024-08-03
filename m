Return-Path: <linux-kselftest+bounces-14774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E0E946B24
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 22:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5801C20DBA
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 20:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA22561B;
	Sat,  3 Aug 2024 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="gEXgUk0q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8911723;
	Sat,  3 Aug 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722718515; cv=none; b=InQIYLJPJB+Zmw3QgRbv7FAo57M0F2kSsaNYVfPXtKhvDxl+8c9lgzTRuwWz/WTJuL/3uZgCjVJBvW1pO3MPCg//rtd3qMQFikU6Kx0JEviVEkmbWCNM+MgHTItTUr9K0qWf5CylvXlsyoXWo5IjFoF4kzcA5Tq5P6DZkcWc93g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722718515; c=relaxed/simple;
	bh=jaJxLpPb7kSeIsme/cMbcOWwFvnxQMKG8EBET+VYKrU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GzwI2GPej+zMGIF2I0PVr+BnBZ8Du7qNOKiQmQ/Sgk6jtjtwjLpYMtkcFe4eRFx53Y5VFqAJZb2a5mdB7P+zzRYfQOLpB5u9Kfg1+Tbje7WPrZmpPBlRxEWJP+RPrUU1uqHeLgIBOoTzi2aA7C8VPjaAokXqHrPOTLO4FORNe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=gEXgUk0q; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1722718510; bh=jaJxLpPb7kSeIsme/cMbcOWwFvnxQMKG8EBET+VYKrU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gEXgUk0qsWcKTl00x2LFi72LBrS5ZDMSxRXZ5Sm292MWKGcGFxyYTJb9LhGLq6BEV
	 LiblZ//xcKjhzICBHcVQfGrzgbYMyjW9BdV2ptURGrHgR3YU1ib4EiGp3NyWdA2Q8z
	 GI15559/aTXVfSmhSvr0s5rYc4oGONL28e3Iez/E=
Date: Sat, 3 Aug 2024 22:55:07 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Message-ID: <d5c952c9-e7f6-4a01-9e43-2b19b586a95b@t-8ch.de>
In-Reply-To: <20240803183259.GA29716@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net> <20240728-nolibc-llvm-v1-4-bc384269bc35@weissschuh.net> <20240803092558.GB29127@1wt.eu> <713abd5e-1f72-4cf8-9857-c6795b4b3187@t-8ch.de> <20240803183259.GA29716@1wt.eu>
Subject: Re: [PATCH 04/12] tools/nolibc: use attribute((naked)) if available
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d5c952c9-e7f6-4a01-9e43-2b19b586a95b@t-8ch.de>

Aug 3, 2024 20:33:11 Willy Tarreau <w@1wt.eu>:

> On Sat, Aug 03, 2024 at 08:28:08PM +0200, Thomas Wei=C3=9Fschuh=C2=A0 wro=
te:
>>> I think that it can resolve to roughly this:
>>>
>>> #if defined(__has_attribute) && __has_attribute(naked)
>>> #=C2=A0 define __entrypoint __attribute__((naked))
>>> #=C2=A0 define __entrypoint_epilogue()
>>> #else
>>> #=C2=A0 define __entrypoint __attribute__((optimize("Os", "omit-frame-p=
ointer")))
>>> #=C2=A0 define __entrypoint_epilogue() __builtin_unreachable()
>>> #endif
>>
>> We would need to duplicate the define for the
>> !defined(__has_attribute) case.
>
> I don't understand why. Above both are tested on the first line.
> Am I missing something ?

This specifically does not work [0]:

=C2=A0=C2=A0=C2=A0 a result, combining the two tests into a single expressi=
on as shown below would only be valid with a compiler that supports the ope=
rator but not with others that don=E2=80=99t.


>
>> I wanted to avoid that duplication.
>>> What do you think ?
>>
>> With the reasoning above I'll let you choose.
>
> I'm fine with avoiding duplication, I just don't understand why there
> should be.
>
> Willy

[0] https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005fattribute.html

