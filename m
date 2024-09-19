Return-Path: <linux-kselftest+bounces-18146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5214B97CF38
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 00:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EC5284992
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2024 22:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB9F14E2E1;
	Thu, 19 Sep 2024 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAZx1zpo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E0125A9;
	Thu, 19 Sep 2024 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726784845; cv=none; b=YFubbqRyGeQP/5aaydvlDn1KsenHe/4hpAxb+2LcK1Iul+RTqg/hsBmFfcOmxSHbBBOJghnw7Q6oEDEzh7euRqNgJFnr589MXIYn0O4gUaOWDM6r1xqYKOX6eb40Yei+V+tD+nBWUU+dgXLZ8iDsOXBzwPncHF0MjgHOf5pM5CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726784845; c=relaxed/simple;
	bh=oRJzg1kwhsxCSnRW7MwCpNBYDP9r6n6jt5U+J0pD3sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcA1/zB5VNYotQCtSB0HAtheJM8IOrVb66CPzmP8EIexQUkSJiRAjBu5Lkyo4rjoTArp+8wb3MvlJOiPBlXk2VDJ4+erz7d97fawEX2ssno4Q3IjP5/K2djOisFIoLewD0Psk/ar5Xe0TSm7tIK8wZaNeU5kZ24m21Ep76WFOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAZx1zpo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20573eb852aso16859965ad.1;
        Thu, 19 Sep 2024 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726784843; x=1727389643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IENfLUGq9uNSErtkMZmefbr4+GPLKP9RJBUWADpt4Ic=;
        b=FAZx1zpo7CSFrDPd11xdglTuh0aUD0OPFC9zsVT6w+BKjfOeXNzcVq4dkiYsLBuKXv
         1LIXnEAut4qzcpiR32XMO0WIFd+wB8bb56/GM1WdbRxd/PhRBHOZKHeVA3QTG7+/xWBa
         lpDolmpszt9ZyO3VEsj04RtX8JG61CId/5OVUizQlWWQy/Yq+MrHi9aHSc64yktT4AxI
         r/3FoA12N2L5AU83mMR3bKszkne25ED36G/XDA4f0apmZlFU1qtHUrabLmSmD57IUR/P
         WTssXsBac7OBHddDU/GExZcQG+zH5wFqxOO5NDzOfvZFfxXy4JaoN7HltX9gwDbBGHis
         /JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726784843; x=1727389643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IENfLUGq9uNSErtkMZmefbr4+GPLKP9RJBUWADpt4Ic=;
        b=tAH7Z7Jar75mLaCQ17e2B6hrNPmwn0NuGyArxQ3AboEbn4zrnmBo0x4fn0edQhY1EU
         HZITbLeTfY/awaL86KGf2KeFoAKW+iUIVmbudYLUK/mqGe03uQv84wWlg6PQbcyQuuJT
         LS+6yp7biW1f11rkRqrCIzSW4nT2Ny43+sUTLSoX4Kc0SG5XQELluLH2C80AGs5GW7Kq
         ySHEOLVUC680UvtYNYz3UglwUqg/yzT47bHQPUfYT+W8BzsdHupB0ocB1TtKeCPE6iAQ
         wfFqEY85dX3Jv1v8D/gvG5VKQufxpWvlDTNdXUcS0ldAermlgG/XixKBW/l5//PpBa/I
         denA==
X-Forwarded-Encrypted: i=1; AJvYcCUrNtOeiKV6GpVwPp2lDB9peZ0tIWTMX36paHP9GsaRIxuuwaRif2A+brF0b9COdYNZ/ADsSLttWqZV2gg=@vger.kernel.org, AJvYcCVO8sjUCBBO7W+RA/ZAV+LZ8IvBMOldzClJflVfBL0zbeaDo91HwCx8Q2FjlQsPVmR2DimkZA4eHrxhOaUp6M0y@vger.kernel.org
X-Gm-Message-State: AOJu0YypXL9m6MdPxU76IFRKuep1pvPHx3vczFzxsHOiBpIrid65FQFE
	puJqty3loYfmPKe/i2NE3/zDJIV8oz4CfWhnxff8MXOqIR46qyus
X-Google-Smtp-Source: AGHT+IHENbB3TgQ3LOgaK4Q960apkR7DveKJLPI4JJlhe0bvbyCtz2iBqzQCh+/fgCjCQ8ME3zJZ5g==
X-Received: by 2002:a17:902:e888:b0:205:4d27:616e with SMTP id d9443c01a7336-208d7853c46mr17427035ad.22.1726784843365;
        Thu, 19 Sep 2024 15:27:23 -0700 (PDT)
Received: from [192.168.244.40] (ime-gw.unicamp.br. [143.106.1.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079472e1a3sm84966935ad.246.2024.09.19.15.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 15:27:23 -0700 (PDT)
Message-ID: <bcd02805-5262-4d44-9528-64c63a55e8b6@gmail.com>
Date: Thu, 19 Sep 2024 19:27:16 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Add KUnit tests for llist
To: Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: n@nfraprado.net, andrealmeid@riseup.net, vinicius@nukelet.com,
 diego.daniel.professional@gmail.com
References: <20240917005116.304090-1-arturacb@gmail.com>
 <bd5eb792-124f-4eaa-9ff9-a99765d1ef73@linuxfoundation.org>
Content-Language: en-US
From: Artur Alves Cavalcante de Barros <arturacb@gmail.com>
In-Reply-To: <bd5eb792-124f-4eaa-9ff9-a99765d1ef73@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/19/24 1:01 PM, Shuah Khan wrote:
> On 9/16/24 18:51, Artur Alves wrote:
>> Hi all,
>>
>> This is part of a hackathon organized by LKCAMP[1], focused on writing
>> tests using KUnit. We reached out a while ago asking for advice on what
>> would be a useful contribution[2] and ended up choosing data structures
>> that did not yet have tests.
>>
>> This patch adds tests for the llist data structure, defined in
>> include/linux/llist.h, and is inspired by the KUnit tests for the doubly
>> linked list in lib/list-test.c[3].
>>
>> It is important to note that this patch depends on the patch referenced
>> in [4], as it utilizes the newly created lib/tests/ subdirectory.
>>
>> [1] https://lkcamp.dev/about/
>> [2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
>> [3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
>> [4] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
>>
>> ---
>> Changes in v3:
>>      - Resolved checkpatch warnings:
>>          - Renamed tests for macros starting with 'for_each'
> 
> Shouldn't this a separate patch to make it easy to review?
> 
>>          - Removed link from commit message
>>      - Replaced hardcoded constants with ENTRIES_SIZE
> 
> Shouldn't this a separate patch to make it easy to review?
> 
>>      - Updated initialization of llist_node array
>>      - Fixed typos
>>      - Update Kconfig.debug message for llist_kunit
> 
> Are these changes to existing code or warnings on your added code?
>>
>> Changes in v2:
>>      - Add MODULE_DESCRIPTION()
>>      - Move the tests from lib/llist_kunit.c to lib/tests/llist_kunit.c
>>      - Change the license from "GPL v2" to "GPL"
>>
>> Artur Alves (1):
>>    lib/llist_kunit.c: add KUnit tests for llist
>>
>>   lib/Kconfig.debug       |  11 ++
>>   lib/tests/Makefile      |   1 +
>>   lib/tests/llist_kunit.c | 358 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 370 insertions(+)
>>   create mode 100644 lib/tests/llist_kunit.c
>>
> 
> You are combining lot of changes in one single patch. Each change as a 
> separate
> patch will help reviewers.
> 
> Adding new test should be a separate patch.
> 
> - renaming as a separate patch
> 
> thanks,
> -- Shuah

Hi, thanks for the reply!

I'm not sure if I understood your concerns ...

In this patch, I'm adding the entire test suite for the lock-less list 
data structure, which is the primary reason for its larger size. The 
changes in V2 and V3 were made in response to code review suggestions 
from previous iterations.

However, as a big patch I see how this cause an annoyance to review. I'm 
open to any suggestions on how I can reduce its size or make the review 
process more manageable.

Best regards,
- Artur

