Return-Path: <linux-kselftest+bounces-20144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C739A4245
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7A1282436
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9552022DD;
	Fri, 18 Oct 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YlCmhHxs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED82022EE
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265034; cv=none; b=jEixaWYZMVmSpK8Fl9EPw4iTLlIxqdp5otSGkghtmEpX2YPrYK8Xq/BgOC3dcuthuF7a7cDveXqWhlI0Vghul586oMpIgy/G5KTDhZfGWgg/3+wgS6BVY+M7MSC2sv4xK8jsbpiNIxAYkq4hEopv+6E81w+Dbwmb0OAgw/UZPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265034; c=relaxed/simple;
	bh=aw4TvXBRoxS1QLVyOhClwUJogFEDYLW7y7nKYmwBT08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfr3Rn7oDqsMfxdgnJolNspcm0QSm1iKxWsTuZ20pKVLnS9O2ii6svyPE3oeI9HAnVqCIH5TaOz9BEWrciJFxx7RkkMuNxIbpPFaON2DiuxJnqLL/Wm7S30XRHtBypk4sOqUHkdKapAkhf9p2j1DNhyN+x6VSe2AUEy+Pq257YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YlCmhHxs; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a39cabb9faso7896705ab.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729265031; x=1729869831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ujG7zA5UqO+FYt2O4Y3HH9GYNxBYa4vCv9rOHMB0kI=;
        b=YlCmhHxs3MovcboipEg2j6YCyIODMKgNj5hW4qPOUTL8Ttf+42kML4rO9dJh0skxCQ
         LwT5o1vWN+ZAXQt21jdlHTC4TbreaBOqx/0iQdauk4QLcMw0+yxCsNnhC2n/L6m51U1o
         dc13pNamqmyvvym/hO8aQFCp6A5V2IJoXue2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729265031; x=1729869831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ujG7zA5UqO+FYt2O4Y3HH9GYNxBYa4vCv9rOHMB0kI=;
        b=lAh8ZrjTK4G4PRT64goaWYtWCpUBxIjfwsYF7RARPVtX2GM9fektEi8CZEz7swRVPJ
         wD0Q3z8DLedtqpsNbdnZ+zoMoEVuRsyhTvktKtiHz3ou4+pAefv7VgJhG7o6P5HkCYrY
         dmuJQzqBOpWPuyUA54/ljUHaYjlXtcvqACo5zg85rWziZBFwtj8yhnEvK3pWqefmR+MI
         Oh3tmrjL5VfDL4SDY07l5ETqxKnRdLaExNa8cPuE7i722KlCpWRxxsfCSypSvdd8Fuyz
         bfMEq9MrOHGp+Xob8cxkpJaXjkDI2PSmSVHiosQE3t18T7VhEZOUsJBRMAYwznccYt2P
         BLPw==
X-Forwarded-Encrypted: i=1; AJvYcCWOL23r+I5cEpcq5Y8kWrW+cP1XbLn9zVOUZoDupCXHNrbyRSROv1wrU0CrCf7Qp8WGligG6fQ4D0JV2UPX/+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7wr5Tt41GVg7g+VT+nozjqSQso0gSoeMoqdbgxsD7fwKoMjp
	NCwqQBeHyVDfGkPyBpS1h5d+e8QqnP+PvykNFslYxqnNqF4bOSH5JWvU2bgudYI=
X-Google-Smtp-Source: AGHT+IE9lYlbu2klSew/sozdMK+w2vL/0RkYMdMpgfnkCRFosAwu6PfGf4y0odXrA8wa/bMYfWTccQ==
X-Received: by 2002:a05:6e02:178b:b0:3a0:9fa5:8f1 with SMTP id e9e14a558f8ab-3a3f40bac08mr30599885ab.24.1729265030742;
        Fri, 18 Oct 2024 08:23:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3f814d63csm1219055ab.65.2024.10.18.08.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 08:23:50 -0700 (PDT)
Message-ID: <2cda7742-d454-4dc3-83f3-2a2abf4cc4d6@linuxfoundation.org>
Date: Fri, 18 Oct 2024 09:23:49 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: drivers: Add support to check duplicate hwirq
To: Joseph Jang <jjang@nvidia.com>, shuah@kernel.org, tglx@linutronix.de,
 helgaas@kernel.org, mochs@nvidia.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240904014426.3404397-1-jjang@nvidia.com>
 <533eb948-a061-4d62-8d89-5edbdaf785e6@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <533eb948-a061-4d62-8d89-5edbdaf785e6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/24 22:29, Joseph Jang wrote:
> 
> 
> On 2024/9/4 9:44 AM, Joseph Jang wrote:
>> Validate there are no duplicate hwirq from the irq debug
>> file system /sys/kernel/debug/irq/irqs/* per chip name.
>>
>> One example log show 2 duplicated hwirq in the irq debug
>> file system.
>>
>> $ sudo cat /sys/kernel/debug/irq/irqs/163
>> handler:  handle_fasteoi_irq
>> device:   0019:00:00.0
>>       <SNIP>
>> node:     1
>> affinity: 72-143
>> effectiv: 76
>> domain:  irqchip@0x0000100022040000-3
>>   hwirq:   0xc8000000
>>   chip:    ITS-MSI
>>    flags:   0x20
>>
>> $ sudo cat /sys/kernel/debug/irq/irqs/174
>> handler:  handle_fasteoi_irq
>> device:   0039:00:00.0
>>      <SNIP>
>> node:     3
>> affinity: 216-287
>> effectiv: 221
>> domain:  irqchip@0x0000300022040000-3
>>   hwirq:   0xc8000000
>>   chip:    ITS-MSI
>>    flags:   0x20
>>
>> The irq-check.sh can help to collect hwirq and chip name from
>> /sys/kernel/debug/irq/irqs/* and print error log when find duplicate
>> hwirq per chip name.
>>
>> Kernel patch ("PCI/MSI: Fix MSI hwirq truncation") [1] fix above issue.
>> [1]: https://lore.kernel.org/all/20240115135649.708536-1-vidyas@nvidia.com/
>>
>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> ---
>>   tools/testing/selftests/drivers/irq/Makefile  |  5 +++
>>   tools/testing/selftests/drivers/irq/config    |  2 +
>>   .../selftests/drivers/irq/irq-check.sh        | 39 +++++++++++++++++++
>>   3 files changed, 46 insertions(+)
>>   create mode 100644 tools/testing/selftests/drivers/irq/Makefile
>>   create mode 100644 tools/testing/selftests/drivers/irq/config
>>   create mode 100755 tools/testing/selftests/drivers/irq/irq-check.sh
>>
>> diff --git a/tools/testing/selftests/drivers/irq/Makefile b/tools/testing/selftests/drivers/irq/Makefile
>> new file mode 100644
>> index 000000000000..d6998017c861
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/irq/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +TEST_PROGS := irq-check.sh
>> +
>> +include ../../lib.mk
>> diff --git a/tools/testing/selftests/drivers/irq/config b/tools/testing/selftests/drivers/irq/config
>> new file mode 100644
>> index 000000000000..a53d3b713728
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/irq/config
>> @@ -0,0 +1,2 @@
>> +CONFIG_GENERIC_IRQ_DEBUGFS=y
>> +CONFIG_GENERIC_IRQ_INJECTION=y
>> diff --git a/tools/testing/selftests/drivers/irq/irq-check.sh b/tools/testing/selftests/drivers/irq/irq-check.sh
>> new file mode 100755
>> index 000000000000..e784777043a1
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/irq/irq-check.sh
>> @@ -0,0 +1,39 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +# This script need root permission
>> +uid=$(id -u)
>> +if [ $uid -ne 0 ]; then
>> +    echo "SKIP: Must be run as root"
>> +    exit 4
>> +fi
>> +
>> +# Ensure debugfs is mounted
>> +mount -t debugfs nodev /sys/kernel/debug 2>/dev/null
>> +if [ ! -d "/sys/kernel/debug/irq/irqs" ]; then
>> +    echo "SKIP: irq debugfs not found"
>> +    exit 4
>> +fi
>> +
>> +# Traverse the irq debug file system directory to collect chip_name and hwirq
>> +hwirq_list=$(for irq_file in /sys/kernel/debug/irq/irqs/*; do
>> +    # Read chip name and hwirq from the irq_file
>> +    chip_name=$(cat "$irq_file" | grep -m 1 'chip:' | awk '{print $2}')
>> +    hwirq=$(cat "$irq_file" | grep -m 1 'hwirq:' | awk '{print $2}' )
>> +
>> +    if [ -z "$chip_name" ] || [ -z "$hwirq" ]; then
>> +        continue
>> +    fi
>> +
>> +    echo "$chip_name $hwirq"
>> +done)
>> +
>> +dup_hwirq_list=$(echo "$hwirq_list" | sort | uniq -cd)
>> +
>> +if [ -n "$dup_hwirq_list" ]; then
>> +    echo "ERROR: Found duplicate hwirq"
>> +    echo "$dup_hwirq_list"
>> +    exit 1
>> +fi
>> +
>> +exit 0
> 
> Hi Tglx,
> 
> I follow your suggestions https://www.mail-archive.com/linux-kselftest@vger.kernel.org/msg16952.html to enable IRQ DEBUG_FS and create a new script to scan duplicated hwirq. If you have available time, would you please help to take a look at new patch again ?
> 
> 
> https://lore.kernel.org/all/20240904014426.3404397-1-jjang@nvidia.com/T/
> 
> 
> Hi Shuah,
> 
> If you have time, could you help to take a look at the new patch ?
> 

Once Thomas reviews this and gives me okay - I will accept the patch.

thanks,
-- Shuah



