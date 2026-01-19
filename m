Return-Path: <linux-kselftest+bounces-49362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 444CBD3AA5D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 474A03008700
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ACB1E633C;
	Mon, 19 Jan 2026 13:30:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D74935BDB4;
	Mon, 19 Jan 2026 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768829453; cv=none; b=SmgeM6m2KqB2F4Gu4ygsax7sT11QOC2tgyJk4PPhpDtVjtTu937xTcNmy4fQ/R2Vkto5749zW9bCxkCP7ZTsbMIiwU1j6DxYBp2tZ5uHnoIeSr2FfskV46UGq7713S0qbwz4sTPQwh1zBAQaMmBuLj+0LSMqizqS7XuIprOLuLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768829453; c=relaxed/simple;
	bh=1P1nE/rAtWRsTJFlGlwRPm+3eocw/OOTCUMKzo5i0+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBodv1oOluA0cB2NWiRVDgGNHZq+KzBXHEEiT8ptGg6HnaJRi0KcPU6PLHjpJ22MzUp++azyRGbSQkH1n1UesWK9R75V4rEbgQvc7mmZDdjB1082iu9Z0JGn6vv6axDHIXNMcoHqQHT8A2b1Y3cIYB6m78KPxMrrtjYQLU5b7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 251F8497;
	Mon, 19 Jan 2026 05:30:45 -0800 (PST)
Received: from [10.44.160.85] (e126510-lin.lund.arm.com [10.44.160.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39B813F740;
	Mon, 19 Jan 2026 05:30:48 -0800 (PST)
Message-ID: <a78f2fdf-ef4d-4570-b592-b2943b6ac06d@arm.com>
Date: Mon, 19 Jan 2026 14:30:45 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] selftests/mm: fix faulting-in code in
 pagemap_ioctl test
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Shuah Khan <shuah@kernel.org>, Usama Anjum <Usama.Anjum@arm.com>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
 <20260107164842.3289559-7-kevin.brodsky@arm.com>
 <cd9e1fca-81ef-4eaa-aea1-aac6dd00623d@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <cd9e1fca-81ef-4eaa-aea1-aac6dd00623d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/01/2026 12:09, David Hildenbrand (Red Hat) wrote:
> On 1/7/26 17:48, Kevin Brodsky wrote:
>> One of the pagemap_ioctl tests attempts to fault in pages by
>> memcpy()'ing them to an unused buffer. This probably worked
>> originally, but since commit 46036188ea1f ("selftests/mm: build with
>> -O2") the compiler is free to optimise away that unused buffer and
>> the memcpy() with it. As a result there might not be any resident
>> page in the mapping and the test may fail.
>
> Yes, I assume so. Using FORCE_READ() etc is the way to go.
>
>
> Should we add
>
> Fixes: 46036188ea1f ("selftests/mm: build with -O2") 

Yes that seems reasonable, the test was arguably broken to start with
but it is this commit that revealed it ;)

- Kevin

