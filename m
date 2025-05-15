Return-Path: <linux-kselftest+bounces-33076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE94AB8318
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 11:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C6B1713F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD26297B92;
	Thu, 15 May 2025 09:43:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC134297B76;
	Thu, 15 May 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747302227; cv=none; b=gDhjnZb3rYJZ01Wy4sBryJqsxqLNwzUSbnPzR8jOH91sZfkw+nMqHHlDGQPxxzfH4j4+GAyqChk8FRgHFI1uXBlqDlCWCYn0t6Wikd+aEnkTqWgV/QH8JM66uCfzrhM7qjmmEeQ2LATcDvaKdb9w+vWZ1fFOBsnLUqfrmwXpvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747302227; c=relaxed/simple;
	bh=x9KH709zOHmifpCsCRG9AIjal/wsjPYjrnsMwqGwQww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8jtJSa4XX9JnSwTaXp8tYKqNxFduJHS8oopxAx4b946zzh3pxWHpbLB3oFELdVWmPsYpYspWkgUhx9pDCdXd9za9kOZkS8JJKZTI/mcqJ2uoXygX6cnZqHp9MfLZXuZz2+TfGJP9paHwxEQM7UpcJ8DSMpQK6nXtfz4ifqxZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E21614BF;
	Thu, 15 May 2025 02:43:33 -0700 (PDT)
Received: from [10.162.40.26] (K4MQJ0H1H2.blr.arm.com [10.162.40.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AD5D3F5A1;
	Thu, 15 May 2025 02:43:42 -0700 (PDT)
Message-ID: <a5554b6e-0db0-4f34-b42a-b0b0b9a047bc@arm.com>
Date: Thu, 15 May 2025 15:13:40 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix test result reporting in gup_longterm
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250515-selftests-mm-gup-longterm-dups-v1-1-05f8f731cf63@kernel.org>
 <7c2f66f9-a928-4fda-bf3e-4180c7525fef@arm.com>
 <aCW2z7xlQk2iyEP9@finisterre.sirena.org.uk>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aCW2z7xlQk2iyEP9@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/05/25 3:11 pm, Mark Brown wrote:
> On Thu, May 15, 2025 at 03:05:07PM +0530, Dev Jain wrote:
>> On 15/05/25 2:27 pm, Mark Brown wrote:
> 
>>> @@ -189,7 +214,10 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>>>    		 * some previously unsupported filesystems, we might want to
>>>    		 * perform some additional tests for possible data corruptions.
>>>    		 */
>>> -		ksft_test_result(should_work, "Should have worked\n");
>>> +		if (should_work)
>>> +			result = KSFT_PASS;
> 
>> Missed printing "Should have worked" here.
> 
> I didn't think that output was particularly useful separate to the
> overall test result (which is logged on exit from the function), it's
> just the test result more than diagnostic information.

No hard opinion.

> 
> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.

You have mentioned that before, sorry my bad! I also hate it :)


