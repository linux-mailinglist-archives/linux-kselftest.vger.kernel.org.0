Return-Path: <linux-kselftest+bounces-24220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B1A0964A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 16:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7D53A59C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA487211A1F;
	Fri, 10 Jan 2025 15:47:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B8B2116EE;
	Fri, 10 Jan 2025 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524033; cv=none; b=dH+NRzeeb8gD/Ei/fF3mQhKmOURQ62X8EFW1QeXKw+f7Idptabm8q9Y5v/UygLE4gklyZMUL299R2U4asP7BV1QI6Ev/kFI7NpTja9DzAoTr3Uj0xHCir5cLcE5IHZ4R2yqoXj+NZq89r1odQQ+h6sXmRyifdswUFgAhv5bMtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524033; c=relaxed/simple;
	bh=qI8Cs7JZ8lbhqQdiFoYEeBLRDdSyFDxvl2oCVCC1mvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4hY9u6LrHCviT/Yp+ygTbA1GWLVcibV6im5AWEodraYEx1MXTLGM1YFhPN85pd/Avy7kTA9yfLgeKXo4ChDmUHbiNDq2dzV52UDAMRQhYvHTw+yRFtLqLkhNa1p0DehPHHRFQcRmTPrigTrZJyvS3PH2FB0JIm7t811yKEme7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C7741477;
	Fri, 10 Jan 2025 07:47:39 -0800 (PST)
Received: from [10.50.66.95] (unknown [10.50.66.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF14A3F59E;
	Fri, 10 Jan 2025 07:47:06 -0800 (PST)
Message-ID: <9ed49333-b5fc-40c9-a8e4-fb3fc4af9089@arm.com>
Date: Fri, 10 Jan 2025 21:17:01 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/mm: virtual_address_range: mmap()
 without PROT_WRITE
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
 <20250110-virtual_address_range-tests-v2-1-262a2bf3c3d0@linutronix.de>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250110-virtual_address_range-tests-v2-1-262a2bf3c3d0@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/01/25 6:35 pm, Thomas Weißschuh wrote:
> When mapping a larger chunk than physical memory is available with
> PROT_WRITE and overcommit is disabled, the mapping will fail.
> This will prevent the test from running on systems with less then ~1GiB
> of memory and triggering an inscrutinable test failure.
> As the mappings are never written to anyways, the flag can be removed.
> 
> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Thanks! FWIW:

Acked-by: Dev Jain <dev.jain@arm.com>

