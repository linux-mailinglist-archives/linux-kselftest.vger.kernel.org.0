Return-Path: <linux-kselftest+bounces-17100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAEB96B02E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 06:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463A4B20A6B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 04:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5226823A9;
	Wed,  4 Sep 2024 04:52:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0396433A9;
	Wed,  4 Sep 2024 04:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725425553; cv=none; b=u+O2AAXkD9mFEq2lLfCcc0aqXmqhiziw8eMdZsPRBh6LxqKWIr0WqRNwSRSp9jUVy5le4uChXtMMMKzVGn7b/hTkf9u3rMhC0zkcU6c+GRKOX1R46DJusutR8EqqeEsxDtsDcxn1X+5O5Gp0H1diKT/yRw+cDeEPwriWPkh3pFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725425553; c=relaxed/simple;
	bh=GrzPrCNT7mABBxSbsxg81EhR2Kv/Xk3QPAwQUFHk/tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/xM3oRYHT7zjl6e/hnuC4a4EUl+yz+L8vSwSWAyBg3NbsC6ajLb6aCAzHldfZpvPqTD28a1NjbUhLH9g3dLPzLCC/S2xby5qPZLjaExCJ86n3XH/uaVbUPtssvIdeaw3NU6xoUi4tkpSkQ7vlrKYNx930kUUoqiFOkQr2h5kvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0048CFEC;
	Tue,  3 Sep 2024 21:52:56 -0700 (PDT)
Received: from [10.162.43.14] (e116581.arm.com [10.162.43.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC2243F73F;
	Tue,  3 Sep 2024 21:52:24 -0700 (PDT)
Message-ID: <514713eb-235c-40ee-8c25-f1f3e1ca7f7a@arm.com>
Date: Wed, 4 Sep 2024 10:22:21 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj@kernel.org
References: <20240822121415.3589190-1-dev.jain@arm.com>
 <20240822121415.3589190-2-dev.jain@arm.com>
 <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
 <42d0fa4b-eb67-42fd-a8e1-05d159d0d52f@arm.com>
 <806e4be0-4b1f-4818-806f-a844d952d54e@arm.com>
 <fff2b685-a7a5-4260-a293-f2abf55d9ce4@linuxfoundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <fff2b685-a7a5-4260-a293-f2abf55d9ce4@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/4/24 03:14, Shuah Khan wrote:
> On 8/30/24 10:29, Dev Jain wrote:
>>
>> On 8/27/24 17:16, Dev Jain wrote:
>>>
>>> On 8/27/24 17:14, Shuah Khan wrote:
>>>> On 8/22/24 06:14, Dev Jain wrote:
>>>>> Rename sigaltstack to generic signal directory, to allow adding more
>>>>> signal tests in the future.
>>>>
>>>> Sorry - I think I mentioned I don't like this test renamed. Why are 
>>>> you sending
>>>> this rename still included in the patch series?
>>>
>>> I am not renaming the test, just the directory. The directory name
>>> is changed to signal, and I have retained the name of the test -
>>> sas.c.
>>
>> Gentle ping: I guess there was a misunderstanding; in v5, I was
>> also changing the name of the test, to which you objected, and
>> I agreed. But, we need to change the name of the directory since
>> the new test has no relation to the current directory name,
>> "sigaltstack". The patch description explains that the directory
>> should be generically named.
>>
>
> Right. You are no longer changing the test name. You are still
> changing the directory name. The problem I mentioned stays the
> same. Any fixes to the existing tests in this directory can no
> longer auto applied to stables releases.

I understand your point, but commit baa489fabd01 (selftests/vm: rename
selftests/vm to selftests/mm) is also present. That was a lot bigger change;
sigaltstack contains just one test currently, whose fixes possibly would 
have
to be backported, so I guess it should not be that much of a big problem?

>
> Other than the desire to rename the directory to generic, what
> other value does this change bring?

Do you have an alternative suggestion as to where I should put my new 
test then;
I do not see what is the value of creating another directory to just include
my test. This will unnecessarily clutter the selftests/ directory with
directories containing single tests. And, putting this in "sigaltstack" 
is just
wrong since this test has no relation with sigaltstack.

>

