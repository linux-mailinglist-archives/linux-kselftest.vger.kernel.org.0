Return-Path: <linux-kselftest+bounces-48733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD19D11B77
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 11:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF713027E0E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B1928CF49;
	Mon, 12 Jan 2026 10:03:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173B1283CAF;
	Mon, 12 Jan 2026 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212208; cv=none; b=uIc3D0OVPh4vXFwwCfoTGuZFs+kYeBRiL0ZCWOrOgU02Oq1QHHXM0+GHPgYBIOUT8LEP8Jdgzm+8fDjdOa4F7P7IKuwxcXQFh4h2X515h/dioPBfT0Zx7alqHAiJzKc4FFlIWp60LkHvpGaFPSl1HJyIytIQnuKNmRPgLKEA6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212208; c=relaxed/simple;
	bh=2hwa90UgToQrVmzPirT22Gya/9/OG+JYZteFkbxgYOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgAv7r8c8YoOqZtYr/P77iPKRJiUesKKKMGElrlxUxND7bvGb+flsttk/UVshBHcyuWQyzc35kmlmPn+GTMo4GigRLeEQr95WO++Mz2n+nwzsY1DqPPyR53touoX4PsYAep1wAdNCbNbDKzJsqja5z7rJG8Cxl5S9wpu324d2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85A27497;
	Mon, 12 Jan 2026 02:03:18 -0800 (PST)
Received: from [10.57.48.185] (unknown [10.57.48.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 738883F5A1;
	Mon, 12 Jan 2026 02:03:23 -0800 (PST)
Message-ID: <105c747f-5721-4ee8-8eb2-1bf298de9adf@arm.com>
Date: Mon, 12 Jan 2026 11:03:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] selftests/mm: report SKIP in pfnmap if a check
 fails
To: Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
 <20260107164842.3289559-9-kevin.brodsky@arm.com>
 <315a7239-f5ce-474e-bd0d-f1deca3a7b26@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <315a7239-f5ce-474e-bd0d-f1deca3a7b26@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2026 10:34, Ryan Roberts wrote:
>> -	if (!check_vmflag_pfnmap(self->addr1))
>> -		SKIP(return, "Invalid file: '%s'. Not pfnmap'ed\n", file);
> I wonder if we still want this check per-fd, but upgraded to a fail?

It seems very unlikely to fail though, I can only think of the
underlying file having changed in between but I really wouldn't expect
that for such special files. I was trying not to duplicate the checks
too much.

- Kevin

