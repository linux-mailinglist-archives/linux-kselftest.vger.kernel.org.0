Return-Path: <linux-kselftest+bounces-16483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C7B961D3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 05:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB01F23E96
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 03:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0A3142633;
	Wed, 28 Aug 2024 03:57:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AEC69D2B;
	Wed, 28 Aug 2024 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817473; cv=none; b=SI2hrDHb1475mmiI9LmUFT1/TkdIyxnRwx/CSdxxf0WO+ncdPCWjKgPLm1YOmc8OXBE9yL9nT4MQapz4UymWlihgjb3kqgVx1AVbI79jGmH1sudVTH6rnl5Xqa1xsUDssM/hDx5bcgG8OoNxOIxvDXhbSKWrU9HwyyAKaPw/V1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817473; c=relaxed/simple;
	bh=CPMAiQFp/KYtwxkKabr0+fb2+mE9LL/2uAXNpSjde5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEVIyyvTdiY2EtcPe4mgG+ZxP9NVCPRt4m31YgLYxGv8Eyc3PvUuyvaMSAhYQ15g5pxx2qXytJ+ZLbPaJFQcUxRZRsc3x/Aarei0UU9HcabffalFtsm/RL2Agulk+fQLc8HFwSMgypdycxpXqftRdktfEQaqTYB1JJchp6l9218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EDBFDA7;
	Tue, 27 Aug 2024 20:50:06 -0700 (PDT)
Received: from [10.162.42.26] (e116581.arm.com [10.162.42.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 826623F66E;
	Tue, 27 Aug 2024 20:49:36 -0700 (PDT)
Message-ID: <aa014f33-acad-415e-a0fe-66687226e997@arm.com>
Date: Wed, 28 Aug 2024 09:19:29 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/arm64: Fix build warnings for abi
To: Will Deacon <will@kernel.org>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
 broonie@kernel.org, ryan.roberts@arm.com, Anshuman.Khandual@arm.com,
 aneesh.kumar@kernel.org, linux-kernel@vger.kernel.org
References: <20240827051851.3738533-1-dev.jain@arm.com>
 <20240827123347.GC4679@willie-the-truck>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240827123347.GC4679@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/27/24 18:03, Will Deacon wrote:
> On Tue, Aug 27, 2024 at 10:48:51AM +0530, Dev Jain wrote:
>> A "%s" is missing in ksft_exit_fail_msg(); instead, use the newly
>> introduced ksft_exit_fail_perror(). Also, uint64_t corresponds to
>> unsigned 64-bit integer, so use %lx instead of %llx.
> What's wrong with using %llx for a uint64_t? I think that part of the
> code is fine as-is.

I get a lot of warnings like these:
https://www.codedump.xyz/cpp/Zs6d7saC1IRuWV2O

>
> Will

