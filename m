Return-Path: <linux-kselftest+bounces-11675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076990398E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 13:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B08286E77
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 11:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68017967F;
	Tue, 11 Jun 2024 11:02:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EF17B4FC;
	Tue, 11 Jun 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103736; cv=none; b=GjGvTXEPMaj2c+AL3yy62T3O1dS+DL5w+VPTy9CWk4+rpHYsEcNawmDdtJU5/hrwVRUY46IYcpMbzNaxiOq2tD65ZInFFVFX0tztF+iIpJT1gzYxRRcYzSnueqeY0FHXeSl29O2Mg4Wnk9sjzKK+7aPiEYAYiZqRxmJCFv/WkZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103736; c=relaxed/simple;
	bh=FkEqDypJsvCjoLDctfdedTpHjOn5E73IEktJ+zQG6f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFHFUGmFl19nZsAFXN//d2xvaFabfFjcVcHn/NoK0Zw/MB0b2I9U+y5r67MZNNf01Le4VhlLuylXp8UUbp/GaOUQ6RVH0G7GIiWRCtZb5A3PxR1LbXiHzl7DjPnBlhTqY8PALTGfIE8z1XKRKkfPab6wC5Xqd0fgo94EYrvHvc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1696A1424;
	Tue, 11 Jun 2024 04:02:38 -0700 (PDT)
Received: from [10.162.41.16] (e116581.arm.com [10.162.41.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED5093F64C;
	Tue, 11 Jun 2024 04:02:08 -0700 (PDT)
Message-ID: <a154a0e1-c7e7-4818-96ec-9cbb42734ef0@arm.com>
Date: Tue, 11 Jun 2024 16:32:05 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests: Rename sigaltstack to generic signal
To: Mark Brown <broonie@kernel.org>
Cc: shuah@kernel.org, oleg@redhat.com, stsp2@yandex.ru, mingo@kernel.org,
 tglx@linutronix.de, mark.rutland@arm.com, ryan.roberts@arm.com,
 suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
 DeepakKumar.Mishra@arm.com, AneeshKumar.KizhakeVeetil@arm.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240611075650.814397-1-dev.jain@arm.com>
 <20240611075650.814397-2-dev.jain@arm.com>
 <ZmgtA_GW_GPgPM1E@finisterre.sirena.org.uk>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ZmgtA_GW_GPgPM1E@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/11/24 16:24, Mark Brown wrote:
> On Tue, Jun 11, 2024 at 01:26:49PM +0530, Dev Jain wrote:
>> Rename sigaltstack to signal, and rename the existing test to
>> sigaltstack.c.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
> If people review patches and give a tag for them you should carry the
> tag forward to avoid having to duplicate the review.  From v1:
>
> I think this is reasonable if we're going to add more generic signal
> tests - sigaltstack is a fairly small bit of functionality and having it
> covered as part of a broader signal suite and the overhead of setting up
> the suite separately is probably not worth it.
>
> Reviewed-by: Mark Brown <broonie@kernel.org>


Ah yes, I did know it, I forgot. Shall take care.


