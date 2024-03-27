Return-Path: <linux-kselftest+bounces-6732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFC588EFE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 21:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167942A42A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1248315444A;
	Wed, 27 Mar 2024 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="PC2+GKS7";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="lWFJtavM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09AE154443;
	Wed, 27 Mar 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569871; cv=none; b=iQIROD4On3zzX1jJf/kohZV4lh08VMuKUkbMViYhj+3RmHb4TtBQUrcBBgA0n/qaFkk0G50h5IeOCBH0UnfRDWAizLv9UJssBV1T8lnzD9DllaRCu11Vhsc3jOjKEpYE1zNDxm9c5tELSUQWqQv9/neFlfPsjzORiHkmzHGu1is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569871; c=relaxed/simple;
	bh=Ld6HrLqtuw7crMLsCyP8gsr/CSuqB+o5MzFpyBX3MuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMopCdejrgjrcz6nEYJp4hOXMWEOpv4n4wwIysYl0A4oVB0fYzXhZhtfoOyKP045bQK8Q7Lq6Yfr+LNampo5ujNIhDfMc8qKDWmBsnoOKHpIuKnMpaJq+vtupvYwZTQMeIsvxioOfN25IbOZ23HZ7S++z0y/2fPxet2rzwOVxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=PC2+GKS7; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=lWFJtavM; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id CF2436015E;
	Wed, 27 Mar 2024 21:04:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711569857; bh=Ld6HrLqtuw7crMLsCyP8gsr/CSuqB+o5MzFpyBX3MuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PC2+GKS7Ac4kwpM4fTB41Rare2g71xW+I3p+wGU1pvbY0zx269WaEIvMJH7wiPOSp
	 trSdOquY9FRFfy20rezD4w4lg+TyDCXGLeUJ6LpdHfXJ1ueQhSUJaDv1R2NYSFoAZG
	 y997SVPUiBp/SgPCzuNweTTfpLJJ660YE7bT1SxXFEjEbwMs53G5sJnRzgCWFROVvO
	 /bz1XnXn1Ay7RUGZlDPw0eF4+/DeqTO1Ai5sdOl3zjjlL2l1iFUVxHx2UwzBO7Rkev
	 v10R1r6tl26bKhVhWSJVp5iGbSro6e0Ushwp6KfLXaFc7D+oSvlAAiMBR4nVkK1z4s
	 JV9KzKOM8wt+A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VXsdPIWA-2IT; Wed, 27 Mar 2024 21:04:15 +0100 (CET)
Received: from [192.168.178.20] (dh207-41-201.xnet.hr [88.207.41.201])
	by domac.alu.hr (Postfix) with ESMTPSA id 24FA16015F;
	Wed, 27 Mar 2024 21:04:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1711569855; bh=Ld6HrLqtuw7crMLsCyP8gsr/CSuqB+o5MzFpyBX3MuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lWFJtavMe5WgV7tBQiIC1mIUZqOAeFey4enMQD67L6kMIQHtRpxRrxbe5iiFWxBMI
	 sRMBZfOkZxK6k+ngBYIzOJ1G26WZCqKwWP4P1Vxv0Jh+W+ieFsLIVfFtFrPFweWXZO
	 86jVFYXA2E+UFXtfYKvQCaBfxw02AJbulwUqxnX8TvYmRHY0RHA9GwoenhOanO1l1T
	 yg0sCh/Nseo9VcT/lMlKVJeXeDUtwcGFwBmu0/foy2pdgK2iDQJmk6HnYhHTQHiqVC
	 kGUYA69hOnoQCKiH0qR2d71matlP7QdjzNY27qh/idLGkNnCUv3iy2ysSC7RdxLPaI
	 NjChKfqX7c9Cg==
Message-ID: <08a13b79-e94a-4f80-96e9-ce223d928b3e@alu.unizg.hr>
Date: Wed, 27 Mar 2024 21:04:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after a
 failed assert()
To: Joao Martins <joao.m.martins@oracle.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
 <20240319135852.GA393211@nvidia.com>
 <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
 <cdc9c46b-1bad-41cd-8f98-38cc2171186a@oracle.com>
 <20240325135207.GC6245@nvidia.com>
 <f8e03425-98cf-4076-8959-d85eda846bab@oracle.com>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <f8e03425-98cf-4076-8959-d85eda846bab@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/27/24 11:41, Joao Martins wrote:
> On 25/03/2024 13:52, Jason Gunthorpe wrote:
>> On Mon, Mar 25, 2024 at 12:17:28PM +0000, Joao Martins wrote:
>>>> However, I am not smart enough to figure out why ...
>>>>
>>>> Apparently, from the source, mmap() fails to allocate pages on the desired address:
>>>>
>>>>    1746         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>>    1747         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ |
>>>> PROT_WRITE,
>>>>    1748                    mmap_flags, -1, 0);
>>>> → 1749         assert(vrc == self->buffer);
>>>>    1750
>>>>
>>>> But I am not that deep into the source to figure our what was intended and what
>>>> went
>>>> wrong :-/
>>>
>>> I can SKIP() the test rather assert() in here if it helps. Though there are
>>> other tests that fail if no hugetlb pages are reserved.
>>>
>>> But I am not sure if this is problem here as the initial bug email had an
>>> enterily different set of failures? Maybe all you need is an assert() and it
>>> gets into this state?
>>
>> I feel like there is something wrong with the kselftest framework,
>> there should be some way to fail the setup/teardown operations without
>> triggering an infinite loop :(
> 
> I am now wondering if the problem is the fact that we have an assert() in the
> middle of FIXTURE_{TEST,SETUP} whereby we should be having ASSERT_TRUE() (or any
> other kselftest macro that). The expect/assert macros from kselftest() don't do
> asserts and it looks like we are failing mid tests in the assert().
> 
> Maybe it is OK for setup_sizes(), but maybe not OK for the rest (i.e. during the
> actual setup / tests). I can throw a patch there to see if this helps Mirsad.

Well, we are in the job of making the kernel better and as bug free as we can.

Maybe we should not delve too much into detail: is this a kernel bug, or the kselftest
program bug?

Some people already mentioned that I might have sysctl variable problems. I don't see
what the mmap() HUGEPAGE allocation at fixed address was meant to prove?

Thanks,
Mirsad

