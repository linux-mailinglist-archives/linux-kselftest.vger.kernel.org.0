Return-Path: <linux-kselftest+bounces-18330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A19E984E9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 01:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DDFB262A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 23:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C7518593F;
	Tue, 24 Sep 2024 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="ol3TPljd";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="RH2AzJEL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B305183CCD
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218864; cv=none; b=iKfWe1k4IJvlmFfwOP4EfvexiKy6/Acmys5tS4WxQmo9VODsJukj7JAzD779OFlaiKXyRuZS1moMc/xEvxpLrFLz72TXc0hiKo183VsM/CunuJstpIetfIUbzsIdlofSQ4+VdP8zUfDF2gnXk5N2vshVxrMX5tqx6beI4W7Q6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218864; c=relaxed/simple;
	bh=2bZ2QjhUxtrcmCd1aeLBq1AehNwWii0833L9Y9DH4/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pF5JmM9X53RazF+Ynl24npQq9LOBIuFrhxLwEFplH5ht0CJToNxLWgdgaFSb8iZyaMuwqu3Y18bflgMO6WHMamkiwiEIzNSIuRWxzK2sMhFDor6c8ZBZgyyawnMg2mYFV7W+cv3Cvggr+UwyCKKPu3wk1rKI7Zgi3wEy0pzNU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=ol3TPljd; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=RH2AzJEL; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
DKIM-Signature: a=rsa-sha256; b=ol3TPljdANgRxYCl1bOK58yVha0axzwNJvjTt9HNn9MpLlLEmYhES44en+QhQX54l6t+IgwYZfenDqCsiUn0dECQQxY9HAQwKStH+MlBeqrDfnX6g9Wdm6241dA7EIMIeBxUCziBeF7cvTCeO37vL/b4X8GAB0bP6BUXIvCcmh5AZdm88ALAxUXiTaF98oCbjbaRJe7vnrrK2gIAtt25FADoz+x11f+R4txHRKjpdioCT/nx57AaEoLn1BItIuXuSuURMOW+q3Qb/Qn0iu9F2LeJjFws2HFvkzFBpmoj41ftkbHVXdYmSNC51ROgAY+z0pe4Svd32FvC2MOEKOTppw==; s=purelymail1; d=lkcamp.dev; v=1; bh=2bZ2QjhUxtrcmCd1aeLBq1AehNwWii0833L9Y9DH4/A=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=RH2AzJELkw7bEHbwbJp/mkojFjcLtwYuK7fegZT6ybXDtHfwakRDi5zDIW6m4MQ97IcSp46RlvPU5Ezmfh0PcYr2E4Aqqz5VXsSRywkhJTvbWwKbY6PwHD4joByEqP99KbnnRsx1hHng/lezBXLiogkdTe7W0R2SiA8HlnZXyPF4N1V28/4hpd8hGOiV4mQHEd6iay82GCQ0vYWgTFrECUHtyOxVX5r9++JYg8e8Pf0/QvDjuYvPtEMVK3uUhWR5oT6YjyPj5SXqsKS7zxqD/18rPTCAMe7m7/rFVe6Edaj3YSBNuQCPedT3dvnbkE13oL+4H5cZULCboU3JejNLqg==; s=purelymail1; d=purelymail.com; v=1; bh=2bZ2QjhUxtrcmCd1aeLBq1AehNwWii0833L9Y9DH4/A=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2145792936;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 24 Sep 2024 23:00:30 +0000 (UTC)
Message-ID: <6d3025ed-e00d-4f8a-bab7-256cf78774af@lkcamp.dev>
Date: Tue, 24 Sep 2024 20:00:09 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Add KUnit tests for lib/crc16.c
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, ~lkcamp/patches@lists.sr.ht,
 Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240922232643.535329-1-vpeixoto@lkcamp.dev>
 <8291c6eb-750a-4ab2-8904-65d723d034dd@riseup.net>
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
Content-Language: en-US
In-Reply-To: <8291c6eb-750a-4ab2-8904-65d723d034dd@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Andre=CC=81,

On 9/24/24 6:33 PM, Andr=C3=A9 Almeida wrote:
> Hey!
>=20
> On 9/23/24 01:26, Vinicius Peixoto wrote:
>> Hi all,
>>
>> This patch was developed during a hackathon organized by LKCAMP [1],
>> with the objective of writing KUnit tests, both to introduce people to
>> the kernel development process and to learn about different subsystems
>> (with the positive side effect of improving the kernel test coverage, of
>> course).
>>
>> We noticed there were tests for CRC32 in lib/crc32test.c and thought it
>> would be nice to have something similar for CRC16, since it seems to be
>> widely used in network drivers (as well as in some ext4 code).
>>
>> Although this patch turned out quite big, most of the LOCs come from
>> tables containing randomly-generated test data that we use to validate
>> the kernel's implementation of CRC-16.
> Can you share how you created the tables? Given that is impossible to=20
> review the table itself, at least people will be able to see how they=20
> got created at least.

Yes, of course, that was an oversight on my part. I'll make sure to add=20
a more detailed explanation in the cover letter/commit message for the=20
next revisions. Thanks for the suggestion!

This test follows lib/crc32test.c very closely; the data table is filled=20
with 4096 random bytes, and the idea is to calculate several checksums=20
within it by randomly choosing a i) start offset within the data buffer,=20
ii) number of bytes after the start offset and iii) input CRC.

The checksums for the randomly-generated test cases were calculated=20
using a reference implementation [1] and this test compares them against=20
the values yielded by the kernel's implementation.

Thanks,
Vinicius

[1] https://github.com/lammertb/libcrc/blob/master/src/crc16.c

>> We would really appreciate any feedback/suggestions on how to improve
>> this. Thanks! :-)
>>
>> Vinicius Peixoto (1):
>> =C2=A0=C2=A0 lib/crc16_kunit.c: add KUnit tests for crc16
>>
>> =C2=A0 lib/Kconfig.debug |=C2=A0=C2=A0 8 +
>> =C2=A0 lib/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 lib/crc16_kunit.c | 715 +++++++++++++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 3 files changed, 724 insertions(+)
>> =C2=A0 create mode 100644 lib/crc16_kunit.c
>>


