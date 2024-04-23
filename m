Return-Path: <linux-kselftest+bounces-8670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5337C8AE053
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17AF1F2201E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69355C33;
	Tue, 23 Apr 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QZp3mbf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5FE335D3;
	Tue, 23 Apr 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862487; cv=none; b=oYIy8A4Wdu2+TjeoIIz9mgRushFNMeyudi7ZhPxRwds86OSRCYDZKUcPBW2vAjB03ZpE14iCjUw7jorAAohn0jknVXW141/fFCoUU+IJLGbBDgEQy0Yec/mN4Ux3wf+LofFA9LO2/NHgThMb9GitbELpI2m6ilZnhOG2O5w+5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862487; c=relaxed/simple;
	bh=vSvOWy+OfKttBBmQ2bfh7dtLqbR6HoSbBlNkHX8qxQQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hnoKJKFavpqVoFydI+VlSpJzxXKAvnPwfirzNFceds8StNSPZdVRsBM0STCWgXBvYRSixW4mYFbbvbCHI9TjlRbhXRLhyintOkXyH+0OxpNUm/yjWZaHx0hYAYHRfYzQLXkONFnSKBd5ugbV5F9jKnMpuJEetw3Iu7K3KKxcdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QZp3mbf9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713862484;
	bh=vSvOWy+OfKttBBmQ2bfh7dtLqbR6HoSbBlNkHX8qxQQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QZp3mbf9a1aq97WHqC5h1z3LTwIyOydN8bnzuK9jwEUA2ptsdJU0nhvxpUQVyx95w
	 lP+DTgijmZSwR6Z7TjO9OGLghsPW7NY3ueZGIkIltRzfsBdD0cb3DKp4AqTY836w0K
	 1fAI9C/idNOOsLUgffNCkWJWit/hCX2CoGmW2YWi5O1AZKAtoZzO/EbNfXOBbHJRLI
	 8T0FZcGSL2BishnUIgCYkSug19QRtEy3Zis6Y80J4yV9x8h8YPhQavFNJ8tkaa3QDb
	 nJkSIJIxGLzYV1aIBaf6jbwqIiTjCVqjZGdj89EamZUWnKESYpP0G8j6y7xuypiK5Y
	 EJ49U5gTW+Qyw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4C7B03781183;
	Tue, 23 Apr 2024 08:54:39 +0000 (UTC)
Message-ID: <78f5ee9a-084f-4a8a-9a22-be031f9baafa@collabora.com>
Date: Tue, 23 Apr 2024 13:55:07 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com,
 suzuki.poulose@arm.com, ryan.roberts@arm.com, rob.herring@arm.com,
 Catalin.Marinas@arm.com, broonie@kernel.org, mark.rutland@arm.com,
 linux@armlinux.org.uk
Subject: Re: [PATCH v2 0/4] A new selftests/ directory for arm compatibility
 testing
To: Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>
References: <20240422070717.2194201-1-dev.jain@arm.com>
 <20240422172108.GD6223@willie-the-truck>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240422172108.GD6223@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/24 10:21 PM, Will Deacon wrote:
> On Mon, Apr 22, 2024 at 12:37:13PM +0530, Dev Jain wrote:
>> This series introduces the selftests/arm directory, which tests 32 and 64-bit
>> kernel compatibility with 32-bit ELFs running on the Aarch platform.
>> The need for this bucket of tests is that 32 bit applications built on legacy
>> ARM architecture must not break on the new Aarch64 platforms and the 64-bit
>> kernel. The kernel must emulate the data structures, system calls and the
>> registers according to Aarch32, when running a 32-bit process; this directory
>> fills that testing requirement.
>>
>> One may find similarity between this directory and selftests/arm64; it is
>> advisable to refer to that since a lot has been copied from there itself.
> 
> Isn't this going to be difficult to maintain if we have two divergent copies
> of the same stuff? From a very quick skim, a bunch of the signals stuff is
> idential to what we have on arm64...
Agreed.

Why don't we follow what x86 suite has been doing? Compile tests for both
arm and arm64, and add conditionals in the tests based on architecture.

If someone has objection that the suite name is arm64, just rename it to
arm which would be a generic name.


> 
> Will
> 

-- 
BR,
Muhammad Usama Anjum

