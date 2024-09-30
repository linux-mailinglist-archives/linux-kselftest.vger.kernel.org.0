Return-Path: <linux-kselftest+bounces-18558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C419898BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 02:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F786B21950
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 00:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48AF2904;
	Mon, 30 Sep 2024 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="h80VGuTo";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="pjU241CP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331689476
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657916; cv=none; b=E0PZM9T2tfKqJd8MQXTs8thFQ8t+OHy2JPHgTrTA8Y6eFn3XfKDM8WVsJKqT8ITEp4TSRR7Xiy1i/ouSvAlZfOiXbtfC+DYGZRMsjLKKiayj/qwIgzXj4qsYpeFaoIcjn/MbE/Lg217PSjSsQoU+clZQOEwBkcAg/Fkl8eOvo9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657916; c=relaxed/simple;
	bh=RZ2+hM4JWTT7vSVgHINHTT3hEK1s/2ZkTFw4nXl266Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWTCZh5FGB7VH4Ux8SlJFLZXgceeWBb5cNSrtWAjkhuLC1B4rJvKxmPcsXj//ksTMXQBPK/aXjhAqUYnt7SguA9HzuTo1QQpWS9pyZ5AOz2uqzDRo1CtytCGQfrQtU3xv29UCCtebghUWJAh56AX+uANTfd/guTf9wBCGKiwc9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=h80VGuTo; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=pjU241CP; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
DKIM-Signature: a=rsa-sha256; b=h80VGuTo0MfIOBRETQGEISWzMqVnsE08XhM6rqwmykCPYZFya/dj3nElbICgvQcu1N8iz38PEdCtXcAHdN0SCoEhhG6dSdPI4PwUMeDXqqDjkx+eXmykTqTcH0OV0QpM5PK1BIk/741KSuJ+TmslJk7p7G5UWMP133J3vxJnCkZDbCMkES7VnVD7QynYfd8RmWUVRcYaBJPLz0nCcWGLLu9jEV2lWrwCeWDZdpbZE9fdeL3d+IYFAROi4jYMigNn2KhSLLve2yY4M4FzJqjjk3oqSk2M7IH6WNHMP0XrasRySJlUsweOerjXHOmc2JC+TMvpb297QcmYyTsaow8JHw==; s=purelymail1; d=lkcamp.dev; v=1; bh=RZ2+hM4JWTT7vSVgHINHTT3hEK1s/2ZkTFw4nXl266Y=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=pjU241CP7pD84It60WJ2bK/UkGSwpQ+3vF5OcB513BtANWpWL1O4HWbu9a/N0sP1SND8+lupB9CUYu5uQ/LMRwX21UoIQLXhtQNcf3//g5MSl6I1k9jtIYV/iCPsYbfeK62OoEdQ8Xq2iLXp9p6uWfp8JOB4bUnS94O+vW5Lqo2MMeMEHKI7Kog0/5GeZSmS2hTrpVLffJ/3QHcUxLENUuWSIw48hrZcRtbtOcvp2zAYMFhcvEu5TTJxrt1RskgYGw91td5ce1SNrd+urlHKna0rok+rqaXXKbIQ4V637+UhiNcEaoepKgI+sooX+cDiY7kwm2Y5OQuC1KWvlzbwMQ==; s=purelymail1; d=purelymail.com; v=1; bh=RZ2+hM4JWTT7vSVgHINHTT3hEK1s/2ZkTFw4nXl266Y=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1761403759;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 30 Sep 2024 00:57:50 +0000 (UTC)
Message-ID: <7d2ad97c-6a0e-4113-9f30-c30b5db7a028@lkcamp.dev>
Date: Sun, 29 Sep 2024 21:57:45 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Add KUnit tests for lib/crc16.c
To: David Laight <David.Laight@ACULAB.COM>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
 "~lkcamp/patches@lists.sr.ht" <~lkcamp/patches@lists.sr.ht>,
 Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20240922232643.535329-1-vpeixoto@lkcamp.dev>
 <8291c6eb-750a-4ab2-8904-65d723d034dd@riseup.net>
 <6d3025ed-e00d-4f8a-bab7-256cf78774af@lkcamp.dev>
 <7f67ae7f15524e4eab6b15cdfd750a04@AcuMS.aculab.com>
Content-Language: en-US
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
In-Reply-To: <7f67ae7f15524e4eab6b15cdfd750a04@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi David,

On 9/26/24 13:21, David Laight wrote:
> ...
>> The checksums for the randomly-generated test cases were calculated
>> using a reference implementation [1] and this test compares them against
>> the values yielded by the kernel's implementation.
>=20
> I'd just use a na=C3=AFve implementation - doesn't really matter
> if it is a bit slow.

Thanks for the feedback. I agree that it makes more sense to use a naive=20
implementation to validate the results from the kernel's crc16 instead=20
of having a table of pre-computed results. I will include in v2 a=20
bog-standard implementation of crc16 similar to yours (using a loop=20
instead of a lookup table) to validate the results.

Thanks,
Vinicius

>=20
> Slow is relative - this code only takes 35ms to crc-64 over 5MB of data.
>=20
> {
>      volatile const uint32_t *r =3D (const void *)buf;
>      for (crc =3D 0; r < (const uint32_t *)buf_end; r++) {
>          uint64_t val =3D le32toh(*r);
>          crc ^=3D bswap64(val);
>          for (i =3D 0; i < 32; i++) {
>              if (crc & (1ull << 63))
>                  crc =3D (crc << 1) ^ 0x42f0e1eba9ea3693ull;
>              else
>                  crc =3D crc << 1;
>          }
>      }
> }
>=20
> =09David
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)


