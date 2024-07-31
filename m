Return-Path: <linux-kselftest+bounces-14553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3439294312C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D5C1C20CDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8D51B14EE;
	Wed, 31 Jul 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IaZT7uOL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AB816C86F;
	Wed, 31 Jul 2024 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433386; cv=none; b=f2MovbPJeCWgut0k0PqNfA2xvFMrAk2FvMa7TH2YmqSa8f8Bg/dxw5RfMn2Oyp8r0QJodSvGmhPgel0WyOt4AZkabTG78qonjD7XLZusHLXeuRfck3uTYQSBPDR/lnbCeBOhvOlurcKfZ0buXLmXhIoB130nx/QesutezpXp3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433386; c=relaxed/simple;
	bh=zHeptAdNGtEc5AR17eG7LeXKLuycf7xz3ROVCyM5jTU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QPNC6FVUe2xFRkSusafnKWz9bJQNEslb0YPOh6xLj5p66J8+iV6ImGkuIuLa7UaudU9k2Mjt26uPyANtqTEOaHh4Fgoyolg6B22bPk3fuXR7LqGbIYIrZvtzA+bxeZWdyFuE9E26jzt3dg4Bm6zKKGb3yPpDrSDj8ugmekY3ZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IaZT7uOL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722433383;
	bh=zHeptAdNGtEc5AR17eG7LeXKLuycf7xz3ROVCyM5jTU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IaZT7uOLuG1j+E+5nsvWlRUj0Ml6WQHZR6ysZhrjuBbSIR0otARGW+7g6JFlRhc+e
	 uoiCTjqww+9p7L74IOfWf55ltYm1G8OLT536GRE6M1sxSQ0O0esK40QwwO1ovaMifs
	 0eaMlsFHe3bQPFILnaRlsRo9QfYx8eguA2j5jUxkLknyC10fEAIV2I4o/ESDY6Re0B
	 VfU18MUsM26rVFtnE6U3DPAJrKbUE8vo/mKYmD2aTuaubBX6G/q3o98T5utZMF3WNg
	 9P+KZCtminWKlE5tz0r6Mq0Nm4Z5y56P9V7yeYeHlx3GkC/t9FGzr/7F3BesnHlXuy
	 QS9mlIh1Z9CEA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DB86737800DE;
	Wed, 31 Jul 2024 13:42:59 +0000 (UTC)
Message-ID: <3518e3ef-3444-419d-94ce-331f4e7fb391@collabora.com>
Date: Wed, 31 Jul 2024 18:42:39 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH] MAINTAINERS: Add selftests/x86 entry
To: skhan@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240610052810.1488793-1-usama.anjum@collabora.com>
 <83d0c57a-dd87-42eb-935a-e4104c17a5ed@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <83d0c57a-dd87-42eb-935a-e4104c17a5ed@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kind reminder

On 7/2/24 3:17 PM, Muhammad Usama Anjum wrote:
> Kind reminder
> 
> On 6/10/24 10:28 AM, Muhammad Usama Anjum wrote:
>> There are no maintainers specified for tools/testing/selftests/x86.
>> Shuah has mentioned [1] that the patches should go through x86 tree or
>> in special cases directly to Shuah's tree after getting ack-ed from x86
>> maintainers. Different people have been confused when sending patches as
>> correct maintainers aren't found by get_maintainer.pl script. Fix
>> this by adding entry to MAINTAINERS file.
>>
>> [1] https://lore.kernel.org/all/90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 523d84b2d6139..f3a17e5d954a3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -24378,6 +24378,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
>>  F:	Documentation/arch/x86/
>>  F:	Documentation/devicetree/bindings/x86/
>>  F:	arch/x86/
>> +F:	tools/testing/selftests/x86
>>  
>>  X86 ENTRY CODE
>>  M:	Andy Lutomirski <luto@kernel.org>
> 

-- 
BR,
Muhammad Usama Anjum

