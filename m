Return-Path: <linux-kselftest+bounces-11381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF01900682
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B504B1C22AF4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEE3196C72;
	Fri,  7 Jun 2024 14:27:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C9719751A;
	Fri,  7 Jun 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770427; cv=none; b=uWbD02gDF2Gix9CfMd4mlqNappa3CezKW41zh0mHi860Sut+43sCZDwyt+Lf62aYVREuQfcj1QLYb319+EwW6WiCLv9OIwDMAh0x4ag2OWZK0sf56+BxVNTxzHGiukV0WkaM6XUN3rcr3pWj1GNOlDfKy6NL6A9+JyOoJpT8tAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770427; c=relaxed/simple;
	bh=nkg5aipuVLewQWXLC5+GDdVmYg8QV1wazg4SucZBGsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOhcDVQF1RLPCD8EGtU7K+7tNPt8ttivdWlFb0jU8dQFM/gsmPAy45wQNkYpOqgwPXNJusmRSBSuEhOty5pmL3SRh3TiQ42BodIeH7YaZdfiML841qD5+Fb/GblU3IlkRHCPuRC29Hrx8qdHankz5pzfhrICgGYOP6Dt+GNp3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52256153B;
	Fri,  7 Jun 2024 07:27:29 -0700 (PDT)
Received: from [192.168.0.102] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 883C63F64C;
	Fri,  7 Jun 2024 07:27:00 -0700 (PDT)
Message-ID: <6c946ece-3663-4520-a90a-68be4d93c56d@arm.com>
Date: Fri, 7 Jun 2024 19:56:57 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: Add a test mangling with uc_sigmask
To: Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, oleg@redhat.com, stsp2@yandex.ru, mingo@kernel.org,
 tglx@linutronix.de, mark.rutland@arm.com, ryan.roberts@arm.com,
 suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
 DeepakKumar.Mishra@arm.com, AneeshKumar.KizhakeVeetil@arm.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240607122319.768640-1-dev.jain@arm.com>
 <20240607122319.768640-3-dev.jain@arm.com>
 <ZmMHNZcYfNMW1Ft7@finisterre.sirena.org.uk>
 <5d26ac17-a50a-46c4-8fcb-68eaa6d0ce2a@arm.com>
 <ZmMOOOEg06SWQ05m@finisterre.sirena.org.uk>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ZmMOOOEg06SWQ05m@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/7/24 19:12, Mark Brown wrote:
> On Fri, Jun 07, 2024 at 06:53:27PM +0530, Dev Jain wrote:
>> On 6/7/24 18:42, Mark Brown wrote:
>>> On Fri, Jun 07, 2024 at 05:53:19PM +0530, Dev Jain wrote:
>>>> + * Test describing a clear distinction between signal states - delivered and
>>>> + * blocked, and their relation with ucontext.
>>> This would be clearer if it said more positiviely what the relationship
>>> between these things is actually expected to be and how they're tested.
>>> Right now it's a bit hard to tell what the test is actually verifying.
>> I thought I had described that quite well in the code comments.
>> Anyways, I shall incorporate some detail into the initial test
>> description too.
> If the overview is confusing and people have to read the code to figure
> out what it means then that's an issue...


You are right.

I shall post a v2 rather quickly, perhaps in 1-2 days;

the SIGPIPE vs SIGSEGV mistake basically renders

this patch useless (although the test would still

pass), and makes the code unnecessarily hard

to review.


