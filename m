Return-Path: <linux-kselftest+bounces-49356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37691D3A9E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94BF230074AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F1364E81;
	Mon, 19 Jan 2026 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="QS3Maq7f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E236164E;
	Mon, 19 Jan 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827958; cv=none; b=nT3Owovy4iWSp/iaHzJAnv/TRUas4DUJ7YFGTBgrgO80K8YVBocTzITBNYL/giWfWOgEiUCP+g9mRKhQ69bBB8Ta6gs0W64l+OolA4opfddbxptONYAOiB5WO4X/sA5WwAU9JWZul8ekJoEuC1JI41Qla3h0zNg3Kf3VClK/r2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827958; c=relaxed/simple;
	bh=Y1Dw0RygWernBN/CdSA6ArknprV8veITfT7mtiNjAh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PirUGOdUwRvx8RDHXvyJcRG+0GAitBFvfegTbnr8HzhA0l5HSWhdfupp8ftf/EwGZrq/ffxOPkTVB7eH5sFK6FPiRcW1ADirACaQqEL/rnr6180jmOR8sL6QsIYXcT4xYYiefgCW9FWDltVqdPl9g3UuM+rdakQdfT3MSQ/qs0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=QS3Maq7f reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dvrLB4BpKz1Fg0H;
	Mon, 19 Jan 2026 14:05:54 +0100 (CET)
Received: from [10.10.15.12] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4dvrLB1PFdz1Fbb9;
	Mon, 19 Jan 2026 14:05:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768827954;
	bh=QBkGG5TltECxBfEph/oWhLZb1rZA+T3kwhm6HqOMIcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QS3Maq7f555S1wjNg+orqU1WcdNPPoBmNlcAS+2VQXL10v9eJ3BvmTxwEQTv6KY1u
	 VVRAHOUYV5bh+FrnjBgblPmhwiObRAPOV+BtwiqL92HJUW6+E7GCisvZJvOy6x9/vQ
	 Au7AtTK9s60XhHLQsSNnw1/T267JzcyXTtVDi2ATobrcRySAN1iF/4Ck7f5L+Cwhrc
	 gbkdOKj/VZdYoOP1bxhDXHuUed/bqMqkaBwhvX8rDGqDQaOYZLNY9III0DD9AZnqIq
	 sy2GHYEk+Km1Mzsri89tiVYQaJt4+YN0sJ91E8pN6Emyyvv2xR9DzFkmk6RIBTcdFl
	 CpXHkaJeu+1NA==
Message-ID: <ed3c9379-55e3-43bb-b2f0-9d51d44a2e40@gaisler.com>
Date: Mon, 19 Jan 2026 14:05:53 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sparc: Synchronize user stack on fork and clone
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 kernel@mkarcher.dialup.fu-berlin.de
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de, geert@linux-m68k.org,
 schuster.simon@siemens-energy.com, davem@davemloft.net, andreas@gaisler.com,
 brauner@kernel.org, shuah@kernel.org
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
 <20260116153051.21678-2-ludwig.rydberg@gaisler.com>
 <e4eb5ddf57ef5f3a01ee76fe397c5f714a9d7626.camel@physik.fu-berlin.de>
 <6529fbe6e6af7b87fdc92912b0b6a8878796bb6e.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
In-Reply-To: <6529fbe6e6af7b87fdc92912b0b6a8878796bb6e.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Adrian,

>>
>> I can therefore confirm that this patch fixes the bug.
>>
>> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 

Thank you for testing the patches. Appreciate it!

The test program from Michael was of great help when
I analyzed the root cause. Thanks for sharing it on the list.

I'll send a new version of the series (this patch will however
remain unchanged, so I'll pick up your test tag).
If you have the possibility to re-run the clone3-tests on it
would be great. Thanks!

Best regards,
// Ludwig



