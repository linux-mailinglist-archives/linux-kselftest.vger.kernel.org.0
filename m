Return-Path: <linux-kselftest+bounces-10892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1314B8D43E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 05:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB23B22127
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 03:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D461C68F;
	Thu, 30 May 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FlBbOh4Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E12F5E;
	Thu, 30 May 2024 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717038029; cv=none; b=QXJWQUKcx27xeCagiqNtSUkyxt9rWvefQ6BM+cVOG27jDHMLrNWdIR5VyyF1a9yUKY0pDqJ5PNQI6MCvfuZlANlFMS1MTSwJxqMEvnKaeuA58+1hRkfK+DuyHiAdCDLbYH5VgGVWJ6QXIQcYNYrR93UZOCx52p6zTrTvPn7HoQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717038029; c=relaxed/simple;
	bh=S1JN+YOHRKwZSlLNcsByxZodhlNSnIR4+CNmMXywLjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qPmDjKgB0DGjVw6Vdkt6fQYzAhcCbU+e/6dNti2FqnAdwvF0yN7zk4RjH64IUbNFO7gm9crdz0oApkcYIa5ymrc60tGE/zD1BDunXwKMKjXW35P88BXTxCDDJcljNkOxc6g40+YSjjgtJGB4yU67rhNhkTQ7wKJs0K7UWxshJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=FlBbOh4Y; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1717038022;
	bh=iylmbElts6rbIaBJgVgvReqoNsA+FU35YPufgnhE8Do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FlBbOh4Y78Fxlvp6m2kkxiz/CGCkxiwvegkQt2vP5IJIo8Pj16HZ5Oyjk250J2gA7
	 rSnu65YAx6Mw7YfRUCfLyZZV/HiYlFCnZyBYcuRJYXu8gfDlGdwD7QuXITo0Q2A6xg
	 ZHXCgnNmLl7FEDescz8psPJssk++rS1a09TjCNcCuMwc5tFOLkafLlCTEVW2yBSQkt
	 khQ4Ks+Fkvv6XxK7NDUKchc191iBZp2yB80gsSE9/xZu4qa1XMU70yqZjTLwMG9V2b
	 yanBof6OB4Pq58aEtehNgtLAgl0R6/jQohS18NpmozlnQF/9oKWeMOlVuuplCKozfh
	 NOJGnhBmx5UfA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VqWFy33wKz4wqK;
	Thu, 30 May 2024 13:00:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Shuah Khan
 <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>
Subject: Re: [PATCH] selftests/overlayfs: Fix build error on ppc64
In-Reply-To: <3f3a70ba-40d2-4624-b8c5-7c3ae2a025fb@linuxfoundation.org>
References: <20240521022616.45240-1-mpe@ellerman.id.au>
 <3f3a70ba-40d2-4624-b8c5-7c3ae2a025fb@linuxfoundation.org>
Date: Thu, 30 May 2024 13:00:20 +1000
Message-ID: <878qzs3sxn.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shuah Khan <skhan@linuxfoundation.org> writes:
> On 5/20/24 20:26, Michael Ellerman wrote:
>> Fix build error on ppc64:
>>    dev_in_maps.c: In function =E2=80=98get_file_dev_and_inode=E2=80=99:
>>    dev_in_maps.c:60:59: error: format =E2=80=98%llu=E2=80=99 expects arg=
ument of type
>>    =E2=80=98long long unsigned int *=E2=80=99, but argument 7 has type =
=E2=80=98__u64 *=E2=80=99 {aka =E2=80=98long
>>    unsigned int *=E2=80=99} [-Werror=3Dformat=3D]
>>=20
>> By switching to unsigned long long for u64 for ppc64 builds.
>>=20
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 1 +
>>   1 file changed, 1 insertion(+)
>>=20
>> diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c=
 b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
>> index 759f86e7d263..2862aae58b79 100644
>> --- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
>> +++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   #define _GNU_SOURCE
>> +#define __SANE_USERSPACE_TYPES__ // Use ll64
>>=20=20=20
>>   #include <inttypes.h>
>>   #include <unistd.h>
>
> Applied to linux-kselftest fixes for the next rc.

Thanks.

> Michael, If you want to take this through, let me know, I can drop this.

I'm happy for you to take this one and the others.

cheers

