Return-Path: <linux-kselftest+bounces-47708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC52CCBF7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 14:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18EFC3001600
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 13:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C5E331A52;
	Thu, 18 Dec 2025 13:20:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678D933031F;
	Thu, 18 Dec 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064028; cv=none; b=C8Dgxwz9oZkTYqSYwCCqJByVlK7P8p/ooikxqYjO0oYSNsGa+NAcItRJyFCba7hGSziWCLBNTrnXlIrJZD4D9iBbPG6ZUx67Y1MWSiCVXUzuhsMeGJrRjhXqE1kIOUb26DDwLVUZYfl/o1Q5n4SecJ/jQHdxsbCVWeVeBbOlVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064028; c=relaxed/simple;
	bh=WJdPqC7chdbiDBL8sm5ziX/N6qIkYZ0PAybfC2WxtzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sl0cXNY6GjIAUZnRBw2Eff+P8sN0XlMiXR8pzhNkCxFuzP1J7aL2h2n5b4eHSeg6kJEHA+k5I2c2K6xPGnE+lRuBqYB+Gt0pCdJRTkaVitFFOpJDh9phIdfGDsgTxB/T+cHEDRyeQa9eqblV+5OinJgldjaNx69AxTnSptndEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD0EFEC;
	Thu, 18 Dec 2025 05:20:18 -0800 (PST)
Received: from [10.57.45.71] (unknown [10.57.45.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D09D3F73F;
	Thu, 18 Dec 2025 05:20:23 -0800 (PST)
Message-ID: <eb2587b2-6d5e-443b-8604-4008070e821a@arm.com>
Date: Thu, 18 Dec 2025 14:20:20 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/mm: fix exit code in pagemap_ioctl
To: Mark Brown <broonie@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
 Usama Anjum <Usama.Anjum@arm.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-5-kevin.brodsky@arm.com>
 <67e61dd6-2a44-42f5-980e-e9196d672540@sirena.org.uk>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <67e61dd6-2a44-42f5-980e-e9196d672540@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2025 11:08, Mark Brown wrote:
> On Tue, Dec 16, 2025 at 02:26:33PM +0000, Kevin Brodsky wrote:
>> pagemap_ioctl always reports success, whether the tests succeeded or
>> not. Call ksft_finished() to report the right status.
>> While at it also fix the exit code in unexpected situations:
> This is a general sign that you should have muliple patches...

I can reword the commit message so it looks less like it's an unrelated
add-on ;)

>> - Report FAIL if we failed to open /proc/self/pagemap (returning
>>   -EINVAL from main() is meaningless)
> If you do a new version it's probably worth noting that this is a
> non-optional feature introduced a long time ago so the open should never
> fail.

Good point, will do.

- Kevin

