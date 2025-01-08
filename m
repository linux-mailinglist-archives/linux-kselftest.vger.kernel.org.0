Return-Path: <linux-kselftest+bounces-24047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A21A054F1
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 09:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E182165579
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2991ACEAF;
	Wed,  8 Jan 2025 08:02:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8B5225D7
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323353; cv=none; b=Zc1905JMvKQ+iV4nhzkC+SqtFZPSPv7dUoz/kEuIwAZBVOOm8P41OYkkPgeh6Xqn45kP6CVUsekKN0UluAUJPAIbz6U+wjuNL9LLD64j5nY8y18pnXfL8eUiW5csxf/jhf0dxbuqKTz9HisWNrvHsYRSdeC2/Arv3GrjldLhoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323353; c=relaxed/simple;
	bh=WPWrGqpOb32XUXsktatecxNwmsf45YBsTWyW9jvflZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThgMc3x9bQvp3Es+UesYI19nna/UV6B+Jx6cDVVvzskZN7NTIfQC0AUtBwxXPIPc6e6s0zofx+SJXkyRrQe55qRZt2crha8JobUYm7nH0KUTIn4ByfphYWZpaiqatUyNch+AJav43OgVOTXZ1hTOLUnxvarVxpfklEzlUqwfSK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCC931063;
	Wed,  8 Jan 2025 00:02:57 -0800 (PST)
Received: from [10.57.94.40] (unknown [10.57.94.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 434A53F59E;
	Wed,  8 Jan 2025 00:02:28 -0800 (PST)
Message-ID: <759caa1e-f747-4b7e-83d6-9d084346e918@arm.com>
Date: Wed, 8 Jan 2025 08:02:24 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: Set allocated memory to non-zero content
 in cow test
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Usama Arif <usamaarif642@gmail.com>, Yu Zhao <yuzhao@google.com>
References: <20250107142555.1870101-1-ryan.roberts@arm.com>
 <20250107205631.6db80f0947102792c3f956a3@linux-foundation.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250107205631.6db80f0947102792c3f956a3@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2025 04:56, Andrew Morton wrote:
> On Tue,  7 Jan 2025 14:25:53 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> After commit b1f202060afe ("mm: remap unused subpages to shared zeropage
>> when splitting isolated thp"), cow test cases involving swapping out
>> THPs via madvise(MADV_PAGEOUT) started to be skipped due to the
>> subsequent check via pagemap determining that the memory was not
>> actually swapped out. Logs similar to this were emitted:
>>
>> ...
>>
>> The commit in question introduces the behaviour of scanning THPs and if
>> their content is predominantly zero, it splits them and replaces the
>> pages which are wholly zero with the zero page. These cow test cases
>> were getting caught up in this.
>>
>> So let's avoid that by filling the contents of all allocated memory with
>> a non-zero value. With this in place, the tests are passing again.
>>
> 
> Thanks, I'll add
> 
> Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")

Thanks, given it's not really a bug but a deliberate change of behaviour I
wasn't sure that a Fixes tag was appropriate, but thanks for seting me straight.

> ...
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: <stable@vger.kernel.org>


