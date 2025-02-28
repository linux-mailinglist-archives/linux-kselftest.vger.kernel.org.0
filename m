Return-Path: <linux-kselftest+bounces-27940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF885A4A053
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 18:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C1F3AF7F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978EC1F4CBC;
	Fri, 28 Feb 2025 17:26:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79D71F4CB4;
	Fri, 28 Feb 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763575; cv=none; b=dEhr0jJ8Ikc49BRPKtKOLRiAjye5QhRdsN6Q4hRWhySJ4uldhObey9+zkDpuAJFQyGq8E+USGQfieMPvH2FwW8wp78J3lDwtivykP9MWkDwTmb/m0V3Osx5ANk+MMYvClrP3+hXMwTxZFTcM54gFKBI6lDks2X8Aqow1+oqq8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763575; c=relaxed/simple;
	bh=QQmtaeu/7A/WHDsx0quTVXtZCxQY5w8RG3KUuVRDORk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjyFDbm0d7nMVeas53YHKrSrwsNUYO20gGfYbxaj6ksd3bIAw/LD0g6Rk+hie1xHYmAI3DFWT5Iuajm6INmRAwvMCHwKQz/51wiQBvmPZgHZuQFj0xIBtBn/WkXsM7kFVCMp87nHqmFTJDTRCYMaslrwhbJE08KnweVvv0N22w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 565E8150C;
	Fri, 28 Feb 2025 09:26:28 -0800 (PST)
Received: from [10.163.40.175] (unknown [10.163.40.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC5143F6A8;
	Fri, 28 Feb 2025 09:26:08 -0800 (PST)
Message-ID: <d160d756-656e-4f57-966a-f11894c85c4c@arm.com>
Date: Fri, 28 Feb 2025 22:56:04 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] selftests/mm: Print some details when
 uffd-stress gets bad params
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-5-958e3b6f0203@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250228-mm-selftests-v3-5-958e3b6f0203@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/02/25 10:24 pm, Brendan Jackman wrote:
> So this can be debugged more easily.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by: Dev Jain <dev.jain@arm.com>



