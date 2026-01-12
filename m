Return-Path: <linux-kselftest+bounces-48734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8554BD11DAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC04F305BD76
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117792C3259;
	Mon, 12 Jan 2026 10:25:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72562C15BA;
	Mon, 12 Jan 2026 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213552; cv=none; b=VsYzUVytt3TJLbE35VS33ZANLZ+JFANqBc684S7ykheH1oCxdjnV3qW57aeTIjeatrWmugIx8eHibU5m2RrKHjA/BmS19qIregoyT5OyDTknqTMByeZqGoFCp6CLk7LWn9vDTtx2YlBjqxtb2PulqXtFkLxSUFUsnmmf3a56Ylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213552; c=relaxed/simple;
	bh=xrRmS3T3nCUUQRW5Kv8mdKswTxqe7zwOip7zbjK2m+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kX/5xvJroSRiIaERJfsjx9834pwBfbicRm641mKjDVxWR0EFOCr+HTjOt0t0NjYYam8tU23gdoUKbO5cpfBhYbIvsTgGtmqpLMIRX1YtmP2FJJTttcfaDqfHahR4MLFAAkkKwroyJ8HM+yOVxjpMmcGzuK06woLYeSrkJu1HFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66F8D497;
	Mon, 12 Jan 2026 02:25:43 -0800 (PST)
Received: from [10.57.95.123] (unknown [10.57.95.123])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8833F59E;
	Mon, 12 Jan 2026 02:25:48 -0800 (PST)
Message-ID: <ac7ca47b-3ef7-4b54-8539-c75871ed7472@arm.com>
Date: Mon, 12 Jan 2026 10:25:47 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] selftests/mm: report SKIP in pfnmap if a check
 fails
Content-Language: en-GB
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
 <20260107164842.3289559-9-kevin.brodsky@arm.com>
 <315a7239-f5ce-474e-bd0d-f1deca3a7b26@arm.com>
 <105c747f-5721-4ee8-8eb2-1bf298de9adf@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <105c747f-5721-4ee8-8eb2-1bf298de9adf@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2026 10:03, Kevin Brodsky wrote:
> On 12/01/2026 10:34, Ryan Roberts wrote:
>>> -	if (!check_vmflag_pfnmap(self->addr1))
>>> -		SKIP(return, "Invalid file: '%s'. Not pfnmap'ed\n", file);
>> I wonder if we still want this check per-fd, but upgraded to a fail?
> 
> It seems very unlikely to fail though, I can only think of the
> underlying file having changed in between but I really wouldn't expect
> that for such special files. I was trying not to duplicate the checks
> too much.

Fair enough. No strong opinion from me. I just thought that given this is a test
that claims to be checking the behaviour of pfnmaps, then we ought to be pretty
sure we have a pfnmap.

> 
> - Kevin


