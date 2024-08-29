Return-Path: <linux-kselftest+bounces-16656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F1963B86
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 08:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150901C21C4D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 06:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64715AAB6;
	Thu, 29 Aug 2024 06:28:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67201B813;
	Thu, 29 Aug 2024 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912912; cv=none; b=UPvlmZgJlsfd6xB/6Ke1FPNFDsiwsrm/dTiVg4GLaanFL37O0Zy9Jdr2tmdrT6DssMVgxv5BWQ2po3UTxjheOcO445oSMFspCzFBHaQ2ik1PgowbyStLs/j6S8Joy2a2lBvDrvWXa64EFx8tQp+5o870/a59NrhMP3l7o7BImI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912912; c=relaxed/simple;
	bh=u1bZjXEfd4QeR8zYa2+PjCmELtmuLXYSV2CUdufcxlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9NfCOX9uk052dS+/vpAOhRgIAB+pEs0w//YKF7TsbXGr/9Gcy4X0uzTVLwiN7qp9zz+H8xZcs4EZJqk2IT5OQ4kTYa92mkcKmBmkXo5sX772+6F8SgJzLXr02U1hGTvVU3UFtgVRK3cBEzwy48dxliLydGXoKWcKw26n8GKHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59FDADA7;
	Wed, 28 Aug 2024 23:28:55 -0700 (PDT)
Received: from [10.162.41.23] (e116581.arm.com [10.162.41.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E40493F66E;
	Wed, 28 Aug 2024 23:28:25 -0700 (PDT)
Message-ID: <fa7fed62-8049-4e85-8568-f2f1c3a98c02@arm.com>
Date: Thu, 29 Aug 2024 11:58:22 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/arm64: Fix build warnings for abi
To: Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>
Cc: shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
 ryan.roberts@arm.com, Anshuman.Khandual@arm.com, aneesh.kumar@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240827051851.3738533-1-dev.jain@arm.com>
 <20240827123347.GC4679@willie-the-truck>
 <c808efdf-fc78-40c3-90bf-948f65a6d133@sirena.org.uk>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <c808efdf-fc78-40c3-90bf-948f65a6d133@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/28/24 16:31, Mark Brown wrote:
> On Tue, Aug 27, 2024 at 01:33:47PM +0100, Will Deacon wrote:
>> On Tue, Aug 27, 2024 at 10:48:51AM +0530, Dev Jain wrote:
>>> A "%s" is missing in ksft_exit_fail_msg(); instead, use the newly
>>> introduced ksft_exit_fail_perror(). Also, uint64_t corresponds to
>>> unsigned 64-bit integer, so use %lx instead of %llx.
>> What's wrong with using %llx for a uint64_t? I think that part of the
>> code is fine as-is.
> IIRC there's some printf format specifiers specific to uint64_t which
> are probably a better choice here.

Well, then I will just send a patch fixing only the %s thing; I don't
want to get lost into format specifiers right now :)


