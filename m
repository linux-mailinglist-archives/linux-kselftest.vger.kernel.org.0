Return-Path: <linux-kselftest+bounces-16834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1179666E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABC6283248
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070B61B81CB;
	Fri, 30 Aug 2024 16:29:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3021B5820;
	Fri, 30 Aug 2024 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035395; cv=none; b=ItEUWy6AOZs/bJp5/vQisMQBwXTSq8gZg0BmmIPJHuCXs/OLvw9e5yektUFdrPsFTaF/WwZum8qPwH4/ALBOeVhoxg6QGHDS/32f5W6mMmbfmkvUzjm2WRMEPx1cMZignvutelwHMsH9mkRNYZYswCF7f0cyg1fnHaPkgU16O2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035395; c=relaxed/simple;
	bh=1Z8hPmy3Wx1wsMWj+S1BDLgBHjtC2Y3UOXjH1vhVow4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pzlpp8n/VJKiDuvpLbO6rrxZyp6QGepipCWlXhJu4pG3C29ciazOz/52EL1Id7JZpixR0MN5lqdggEJr621TtOmwikqU2IwMN7hjzqMXjC7/Pg05QcfaPkWhjIPhVqOhikiei63CjYay8r7bYHh1EXIp6gw8IkQH+dZ1hgFCukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD0FF1063;
	Fri, 30 Aug 2024 09:30:19 -0700 (PDT)
Received: from [10.163.89.61] (unknown [10.163.89.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0693C3F762;
	Fri, 30 Aug 2024 09:29:48 -0700 (PDT)
Message-ID: <806e4be0-4b1f-4818-806f-a844d952d54e@arm.com>
Date: Fri, 30 Aug 2024 21:59:43 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
From: Dev Jain <dev.jain@arm.com>
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240822121415.3589190-1-dev.jain@arm.com>
 <20240822121415.3589190-2-dev.jain@arm.com>
 <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
 <42d0fa4b-eb67-42fd-a8e1-05d159d0d52f@arm.com>
Content-Language: en-US
In-Reply-To: <42d0fa4b-eb67-42fd-a8e1-05d159d0d52f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/27/24 17:16, Dev Jain wrote:
>
> On 8/27/24 17:14, Shuah Khan wrote:
>> On 8/22/24 06:14, Dev Jain wrote:
>>> Rename sigaltstack to generic signal directory, to allow adding more
>>> signal tests in the future.
>>
>> Sorry - I think I mentioned I don't like this test renamed. Why are 
>> you sending
>> this rename still included in the patch series?
>
> I am not renaming the test, just the directory. The directory name
> is changed to signal, and I have retained the name of the test -
> sas.c.

Gentle ping: I guess there was a misunderstanding; in v5, I was
also changing the name of the test, to which you objected, and
I agreed. But, we need to change the name of the directory since
the new test has no relation to the current directory name,
"sigaltstack". The patch description explains that the directory
should be generically named.

>
>>
>> thanks,
>> -- Shuah

