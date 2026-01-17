Return-Path: <linux-kselftest+bounces-49237-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28935D38E74
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 13:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A0973019B86
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 12:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62BC26FA77;
	Sat, 17 Jan 2026 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="BQQkQGQ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89C19AD5C;
	Sat, 17 Jan 2026 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768652312; cv=none; b=W+PiZSrw2MSqPsrqfL4rux/0Jzd9HJNraMUt1XDFtdbIV62j0gwDCYMZ0jI2XV03fiAupnfthMg7w9c5nAmdA48dFOfVrxrlac6OFXCK4tyEkNLAVKSkG0yqazxoxeNH4tBExGTWfPKpT24A35/opNLa7zCTl1h4dlRNyNRlECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768652312; c=relaxed/simple;
	bh=CEA5X5I9dYJRJbwA5W1tdwz3sR7/Lb+Wsf4HwGnbfk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXRN9bpEDyeHwykVhamwUTY7Cy/YSrlUpJ8JemlOw76oVmiB8Cw57wTcJMzf4qXEXGW27CR+HVQ8cku/1EB+j9Wn1N20Jx7DPCfqsVt6vjgRbH/bTF/i1M567Lb7T1pW2y6f7jHzUd12W/nh+lP8Vf0MwB4SXFCOOFP63SacZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=BQQkQGQ/; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
	:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=6EFyn2hQKPIzazpqhjSkl8Aa3lbprmZzu8tqRSNVvkM=; t=1768652309;
	x=1769257109; b=BQQkQGQ/KvC4JYUPoeF3nmyjR7uknWTDheHbiHiPxD6DqHbIylR5Ilb/oXRVn
	6hgAchOXPhedAXia3w+5Omqdh77M3kB6V3GRpKIJxtXGrq5DhOYht0gn81x5SW1bswcesCFu7WoXC
	ughHXWmCxHD/uTkyt4T3ripjVJD47dX664usQ1/d/9hpn2WKYaMXIbpIR9o7NMBENPbz9jBftyxfR
	Rwiys92DU1Knv9yBsv8NvsEYN1DV28MLoFAIJnyxF0X7rL54mL2fb4RGcjUKKHbqdkok8Jl5B+0ef
	XIX8fYekwR78we7IfzDNKF+cscXIB1y9yXdH7q/gRuYheahrVQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1vh5G5-00000003IAB-2fvT; Sat, 17 Jan 2026 13:18:25 +0100
Received: from pd9f63c1f.dip0.t-ipconnect.de ([217.246.60.31] helo=[192.168.144.87])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1vh5G5-00000002YHF-1gJR; Sat, 17 Jan 2026 13:18:25 +0100
Message-ID: <f532a6e4-8c1c-46ec-8b11-9e5bd462497a@mkarcher.dialup.fu-berlin.de>
Date: Sat, 17 Jan 2026 13:18:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sparc: Synchronize user stack on fork and clone
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Ludwig Rydberg <ludwig.rydberg@gaisler.com>, davem@davemloft.net,
 andreas@gaisler.com, brauner@kernel.org, shuah@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de, geert@linux-m68k.org,
 schuster.simon@siemens-energy.com
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
 <20260116153051.21678-2-ludwig.rydberg@gaisler.com>
 <e4eb5ddf57ef5f3a01ee76fe397c5f714a9d7626.camel@physik.fu-berlin.de>
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <e4eb5ddf57ef5f3a01ee76fe397c5f714a9d7626.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

Am 17.01.2026 um 07:57 schrieb John Paul Adrian Glaubitz:
> On Fri, 2026-01-16 at 16:30 +0100, Ludwig Rydberg wrote:
>> From: Andreas Larsson <andreas@gaisler.com>
>>
>> Flush all uncommitted user windows before calling the generic syscall
>> handlers for clone, fork, and vfork.
>>
>> [...]
>>
>> Signed-off-by: Andreas Larsson<andreas@gaisler.com>
>> Signed-off-by: Ludwig Rydberg<ludwig.rydberg@gaisler.com>
> I have tested the patch with the following test program written by Michael Karcher
> on a Sun Netra 240 running kernel version 6.19-rc5 by applying the patch on top:
>
> [...]
>
> I can therefore confirm that this patch fixes the bug.
>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks to both Andreas Larsson and Ludwig Rydberg for fixing this long-standing
issue, and thanks to Adrian Glaubitz for verifying that the fix works as intended!

It is great to see that there still are people around that improve SPARC support
in the Linux kernel. Keep up the good work.

Kind regards,
   Michael Karcher


