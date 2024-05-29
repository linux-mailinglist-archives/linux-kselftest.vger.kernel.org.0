Return-Path: <linux-kselftest+bounces-10828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AC98D3122
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 10:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB791C20E00
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 08:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE5D16D4CC;
	Wed, 29 May 2024 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XiRW+Zpa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11580168C3D;
	Wed, 29 May 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970998; cv=none; b=JuZSA/sqZ1CFpGvHG9O4zRM1vcpnzmX+C8KOO4U4CwaCxeZR5jperAAZPbFlo5km7UJcYOguRUO43nK+UkDmqb0qEUgdqZAvU7I/xXvCKSWJdvtukitFQfQiZSf94D09vzkkzVfs8uzg7ljM/ufEYx6OrFa+Tki0fBQZWXTI+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970998; c=relaxed/simple;
	bh=07Xjk5JBFCnOoz1mUgexuqTBZYBeWpziuUZ0TgxpGwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p5cnBcoQBDK5PA/8T8XqyHt9G6jTWL8zwQfpmppsZND3NHctddusAfhyFwY0mxFcLwq+c6SzfgEq0irvecqzY/XgEeab1G+XDNBeE+Ufg0n+zKO1aqRkDqWjND5/w4rohuzMseD7JI0NlvSvxFVXU550vGCJ/rI9GD2a8PT0+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=XiRW+Zpa; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716970993;
	bh=6/CD09y2pZU+03thgvTqiTFJgMlhZGZLAYHe+sGMc/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XiRW+ZpaTrrP8+qBXRvs8QVm2694mJVod+js/TjyavYOAfMvdoxrvDFDCvmA7Ug+5
	 BPGqItpjFl4YpQ/QTfGysW31o/qsPexH4o3uZ4+hDMW7fhaJul6jjWny+HE+tydOej
	 /s55kQXxs7aKjMPJ4FpAyGh2Qu9860h6VPhE2gFnOjcNpRWJeJ1x0D67PRsXAm0qI6
	 a8HOHEKRZav5u3lCLAaLL8WuO6VJbFWAidqdgISz5xihkORuVmnGLh3sowLCH3X77i
	 CZxQy/OUHU2+o6FkRFPReiWlqNjP1Yzl/sSvRLLsnc6OV7YY5hZedBJYxKKgOMo+26
	 mQud2qKn+6DXw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vq2Sx5Vgkz4x20;
	Wed, 29 May 2024 18:23:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests/openat2: Fix build warnings on ppc64
In-Reply-To: <94964224-1796-4610-a42d-3aacb4d47341@collabora.com>
References: <20240521030325.58095-1-mpe@ellerman.id.au>
 <94964224-1796-4610-a42d-3aacb4d47341@collabora.com>
Date: Wed, 29 May 2024 18:23:13 +1000
Message-ID: <87bk4p3u32.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Muhammad Usama Anjum <usama.anjum@collabora.com> writes:
> I was looking at if we can add this flag for ppc64 for all selftests
> somewhere. But there isn't any suitable place other than in KHDR_INCLUDES.
> But there is a series already trying to add _GNU_SOURCE to it.

IMHO adding other flags to KHDR_INCLUDES is not the right solution, it
conflates unrelated things. Some tests may want the kernel headers but
not _GNU_SOURCE, or vice versa.

Adding a separate define for "standard kselftest flags" would be
preferable, and then something like __SANE_USERSPACE_TYPES__ would make
sense being added to it.

> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thanks.

cheers

> On 5/20/24 8:03 PM, Michael Ellerman wrote:
>> Fix warnings like:
>>=20
>>   openat2_test.c: In function =E2=80=98test_openat2_flags=E2=80=99:
>>   openat2_test.c:303:73: warning: format =E2=80=98%llX=E2=80=99 expects =
argument of type
>>   =E2=80=98long long unsigned int=E2=80=99, but argument 5 has type =E2=
=80=98__u64=E2=80=99 {aka =E2=80=98long
>>   unsigned int=E2=80=99} [-Wformat=3D]
>>=20
>> By switching to unsigned long long for u64 for ppc64 builds.
>>=20
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  tools/testing/selftests/openat2/openat2_test.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/test=
ing/selftests/openat2/openat2_test.c
>> index 9024754530b2..5790ab446527 100644
>> --- a/tools/testing/selftests/openat2/openat2_test.c
>> +++ b/tools/testing/selftests/openat2/openat2_test.c
>> @@ -5,6 +5,7 @@
>>   */
>>=20=20
>>  #define _GNU_SOURCE
>> +#define __SANE_USERSPACE_TYPES__ // Use ll64
>>  #include <fcntl.h>
>>  #include <sched.h>
>>  #include <sys/stat.h>
>
> --=20
> BR,
> Muhammad Usama Anjum

