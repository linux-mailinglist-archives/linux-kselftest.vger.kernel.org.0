Return-Path: <linux-kselftest+bounces-27943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FD3A4A098
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 18:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEFF188EDA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443311AB6FF;
	Fri, 28 Feb 2025 17:38:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F231F4C83;
	Fri, 28 Feb 2025 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764282; cv=none; b=dMzWdqTwbYTPi9PA3wXDeKpLJwsN/4VkNvYfHoPu1uGOuzCpCh6T8TjKIg2oi7xqnus+kHI7dkTJfUJDH/jgWBA+aMCstloo4ta5RuxrDBxKR5O6mxk/3FCmJO/xBAfikrnW5I34Tu73p96YWbEMI4iuPQ2gJDHkTNNAE7c7EVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764282; c=relaxed/simple;
	bh=SA0RC7kf4CsS5bAun1FM+VziZZ6BzHtIUNfIuiovJuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbM7WDJSnZNFG4x2qnL5+N37D926EGUVmLqwmwQyAgYDWMSO4UarPGEMTqYgLdIIZqfGSK5LolfZHp4g9O/lUtRCpAlnV5Jd/dyz5/KUK4qmsA2WGOTQ8b5mSztfAGS6xGG8ylAmtGiEsNsZIou7FPtjzJms07NUyBXqbjfdNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DB1B150C;
	Fri, 28 Feb 2025 09:38:15 -0800 (PST)
Received: from [10.163.40.175] (unknown [10.163.40.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8874D3F6A8;
	Fri, 28 Feb 2025 09:37:55 -0800 (PST)
Message-ID: <1c3003a7-5dce-45a5-a4a8-32349ff7f06d@arm.com>
Date: Fri, 28 Feb 2025 23:07:52 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] selftests/mm: Don't fail uffd-stress if too many
 CPUs
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-6-958e3b6f0203@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250228-mm-selftests-v3-6-958e3b6f0203@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/02/25 10:24 pm, Brendan Jackman wrote:
> This calculation divides a fixed parameter by an environment-dependent
> parameter i.e. the number of CPUs.
> 
> The simple way to avoid machine-specific failures here is to just put a
> cap on the max value of the latter.
> 
> Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


