Return-Path: <linux-kselftest+bounces-7925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D426D8A4330
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 16:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7502818D1
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E5013442C;
	Sun, 14 Apr 2024 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U6WKyjZy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E2E12D771;
	Sun, 14 Apr 2024 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713105569; cv=none; b=idoLk+YHPfHKC0RdhjVIiag0sTIU699bpnlTYIslVV4gq14TX+Z8xJlo73KE4CD0PnY4CsoAEm1aAZ7b5nCq/jepu5zNQOfBNbIwV5HcAX1MhiZWq5Vx3u2VtWJ7CaA2d6wWchHXYqjHfQaU0i0GG3sNYtj3e0Qi4Hm7zoR2Xyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713105569; c=relaxed/simple;
	bh=QnrMKwGOYsOZJ210O+bWTxyLQa0cpJ6kdUhnlA2EYfY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NM4FYOwpy/F6jmZBzdz8t7vmjdjUd/E3J55uimIILmt7HA6oyGjhboBoOL/jXVErh2GFnclfXPAsITESm6IWWqhl3pNozLtFUILMxl52VQ9yf39Q+DJ+Kd1tyeo7RU12JbDYolDLDcCsR7ufIPUSuBLxZRiYnW8NOsz/oVrF5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U6WKyjZy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713105566;
	bh=QnrMKwGOYsOZJ210O+bWTxyLQa0cpJ6kdUhnlA2EYfY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=U6WKyjZyqs+5BMU6c8fF9j2xs3t/zVe7fKj95t0PpCdXG/b6OQxdkECLeL0hWpfl7
	 P1GSsaERrMuMe8Kzzj3v7hg4LBRQEqP83gADAkJ1SQYZEFwiXPGI8hJaiU1yA1tVHC
	 uGfxsBLiKD+qrkteSwGyns7SJEOhCybQJ/HscUb/rtg+tbg4OvUDvZ5qM/K1Z2LlU2
	 FOpcSZaQVoa6H4EVrivon+YK7KV6WembjojYrZSwnAfSByPdsNnfXfBLREAobwZt+b
	 izA6AnZDE+mOC69/trGjFKd3vo3rMwrfjJmcjGSwyZnjki+6n30xSaTfiunn1Biioq
	 USOyaXY5vdedA==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8D4F237809CE;
	Sun, 14 Apr 2024 14:39:23 +0000 (UTC)
Message-ID: <b7c437f5-ac70-4611-908d-b665d8e02679@collabora.com>
Date: Sun, 14 Apr 2024 19:39:58 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
 kernel@collabora.com, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
 <45b4d209-675a-4b42-b62c-6644bafa36c0@collabora.com>
 <20240405001020.GB5792@ziepe.ca>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240405001020.GB5792@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 5:10 AM, Jason Gunthorpe wrote:
> On Mon, Mar 25, 2024 at 02:11:41PM +0500, Muhammad Usama Anjum wrote:
>> On 3/25/24 2:00 PM, Muhammad Usama Anjum wrote:
>>> Add FAULT_INJECTION_DEBUG_FS and FAILSLAB configurations which are
>>> needed by iommufd_fail_nth test.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> While building and running these tests on x86, defconfig had these
>>> configs enabled. But ARM64's defconfig doesn't enable these configs.
>>> Hence the config options are being added explicitly in this patch.
>> Please disregard this extra comment. Overall this patch is needed to enable
>> these config options of x86 and ARM both.
> 
> I picked this and the other patch up, thanks
Not sure why but I'm unable to find this patch in next and in your tree:
https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/?h=for-next

Maybe this patch was missed?


> 
> Jason
> 

-- 
BR,
Muhammad Usama Anjum

