Return-Path: <linux-kselftest+bounces-47686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC99CCAC9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 09:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C42F03061A61
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A4D2BDC16;
	Thu, 18 Dec 2025 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoK3iru5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B728371;
	Thu, 18 Dec 2025 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045239; cv=none; b=EqMjM3i+CEXrtlIDISfDQIl5n+gUD30s1JfQdd9HB8zsCvCTjURLurZrX079GurlA3QG1c/hPHWPLtOG/CjtfIQojd/Drt9P0VBmHdLpVSTvI8gfHpH5Q5Ch9un6IfmIeS8X0vk1R25jxPrsqbWJKtnPPfr8lREyrh5TCrxyxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045239; c=relaxed/simple;
	bh=7dWSzjDl2OvquTZJCFjqZOIC5C2h/Vvu8Kmi5EBUTyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZztt4yFq3FQPXiUO5nN8FI7d3kwdrUSO/ipm0jd8o7qsV/X9kDbP3qw6tCnCTK9taFqBUILZIf2B26jDk556GfMx0Keq5J49VcZBFRTZzytO/nQYNiTbWw7MJ1UyrqhSNzn32hyUFjXfW/o0dUHg/rb7GOA62fQO7f60dovEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoK3iru5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC6BC4CEFB;
	Thu, 18 Dec 2025 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766045239;
	bh=7dWSzjDl2OvquTZJCFjqZOIC5C2h/Vvu8Kmi5EBUTyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AoK3iru57iwXJUgXmzUrESwqpHMKFDM63dAp+QrzgS3KYicSmPljHFlfikA+sY5nZ
	 5ambzJOY0arKaW1/GXZiqr6AxFSBrYt4QkbZ1ZW622jFgzzWD/0OR8AtyFPJN3Hs6f
	 yq9JACWR866aJJKGmoS3/cYhQmKrjssqZBeMLwmvjHoz0g7+auocmIGbYv6kzukjsc
	 mzHClOoehR9zgBen2HPbx2uoV+I6ctpKTc+RNJC9Np7H5l6KnoOWp4HokkQNUlaai7
	 NU8l7kEViAS1LpkuYVd2gpmnQCRzvmTSZjpvqU9/OWcB2NH3zN6HQGobrxd/o1CQ6A
	 ycoRTqOsttC2A==
Message-ID: <7d59597c-5a32-4c97-93ef-feb8dc15b674@kernel.org>
Date: Thu, 18 Dec 2025 09:07:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/mm: fix exit code in pagemap_ioctl
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Shuah Khan <shuah@kernel.org>, Usama Anjum <Usama.Anjum@arm.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-5-kevin.brodsky@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251216142633.2401447-5-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 15:26, Kevin Brodsky wrote:
> pagemap_ioctl always reports success, whether the tests succeeded or
> not. Call ksft_finished() to report the right status.
> 
> While at it also fix the exit code in unexpected situations:
> 
> - Report SKIP if userfaultfd isn't available (in line with other
>    tests)
> 
> - Report FAIL if we failed to open /proc/self/pagemap (returning
>    -EINVAL from main() is meaningless)
> 
> Cc: Usama Anjum <Usama.Anjum@arm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

Fine for me to fix return handling for the overall test in a single patch

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

