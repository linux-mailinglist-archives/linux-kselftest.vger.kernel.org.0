Return-Path: <linux-kselftest+bounces-11444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED69A900D33
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891651F285B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB2215442B;
	Fri,  7 Jun 2024 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hGsO3Qlr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519A14E2FF
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793536; cv=none; b=a+0BLK0v54U5dz7F9da2x6lB1OVgczxbnxYWP20JT73ONWV3wNTDjPBJG8WclCZ9caCyt8zOvCLMWjbPWJZROVgB/OH6ukcTAjK1Jdea4/i9FPVzHHd5i3u51Zq/BH/3rAA0kXqtWeAPuxE3rZfTZ6w4XFJqZNiGdqRUm5KxgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793536; c=relaxed/simple;
	bh=SZ6Wc5Vq8jwCEgLW64CL8jql1u90RGIlvXFNkn1siwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNj8+XwvgAIPu/IRLBxYMUABi37ndopiWXjDKee6je0arQ6CbwGlduczg+lc0AGJ/z6qI3cWrTkLOnBPr/USvpnTxX3zVlU1wIX7XNkpf9cByQER9P4aOhS5W3kNdetz/NBbt/sRGNmknXhCwCWE6fhyRyh7Gy2+POIPnLL6oTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hGsO3Qlr; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7eb41831704so5900139f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717793534; x=1718398334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJaJkiWYiViUf/fnTVHHvyeYTFZz48/UDD814ZGGe2s=;
        b=hGsO3QlrKyXfpXOuJr+0arRkoUWYY9oDy+GuPOq2NtwwTS0r6JVgrDnuSkgMFlHkcy
         ZoCB3F1IjSecmDhuOJjXuVTkLjK9vewEw0HV8u5k6l7PGDFEj2V6er0czr/E/XwGZ5xI
         Hb7iZlhHX2dJOHJztpuNPEehkQCGc6KuGcO5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717793534; x=1718398334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJaJkiWYiViUf/fnTVHHvyeYTFZz48/UDD814ZGGe2s=;
        b=nVZVmToW6cRzQ085WCpy4CF1oFd35NAaVNxCjHsr8Gsy7x2Yf/BpDM7UtEbecxYVCf
         RTEcaWvGNycIPHkxeOMcUj164Bs9+njk2/KN2VPLfEKv2DWBOu+bIWrj33ZY91Txgq+w
         y2isDqTuOBt7crCbgwM90H0fm3Nuy7oFu7EuS2mk5eVuHP5MtkEs+i3QGdsqIHi9lY1/
         tMtRcBdbMmNBg6/kMpM+7VZwZtkIaHbsE+UsWBiSkAaijaw5mmw+ezAInqJWF2NLG7s8
         mbs4fVHlf08inaZvw+4wJibNG28RleYpKpIfHPMO/JVx4VcSgLNv/oM9LdjQFQvQMeM0
         viyA==
X-Forwarded-Encrypted: i=1; AJvYcCUum8oYDPeexZju8LLfKs4FZngKwO/0UjUeFyL9RAzDgWH9ZwiO8sqbjcBHga9HDiulq9ETw3HlqJFX7ZPjEMQZ7oloMNfqaPZXhD/CFHd2
X-Gm-Message-State: AOJu0Yz8V5HcjAoaGZWx/dNkfg7UjhIHiYnqOzJpXHDJe6W8U8XThXWm
	zH/yMR0h3Tmn1Z4uWQC0PKkdYNZSuFGRTgHgggULRzCYMLQg3NEz2t+FWZXdSSu+Z6Zaj2puf2a
	B
X-Google-Smtp-Source: AGHT+IEwyNkUhgFCMEL2V3lKkmLRF1SDEdrxPDCpCkbfuJ3PZjTBFOKh0XicN33feeiX7FEx4xTs7g==
X-Received: by 2002:a05:6602:8ca:b0:7eb:2c80:5354 with SMTP id ca18e2360f4ac-7eb5712c5a8mr370364639f.0.1717793533991;
        Fri, 07 Jun 2024 13:52:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a227d79dsm1013349173.77.2024.06.07.13.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:52:13 -0700 (PDT)
Message-ID: <90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org>
Date: Fri, 7 Jun 2024 14:52:12 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] selftest: x86: conform tests to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
 <dd277b6b-b28e-4860-b285-e89fd5fd3d41@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <dd277b6b-b28e-4860-b285-e89fd5fd3d41@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 23:04, Muhammad Usama Anjum wrote:
> Kind reminder
> 
> On 4/14/24 6:18 PM, Muhammad Usama Anjum wrote:
>> In this series, 4 tests are being conformed to TAP.
>>
>> Muhammad Usama Anjum (4):
>>    selftests: x86: check_initial_reg_state: conform test to TAP format
>>      output
>>    selftests: x86: corrupt_xstate_header: conform test to TAP format
>>      output
>>    selftests: fsgsbase_restore: conform test to TAP format output
>>    selftests: entry_from_vm86: conform test to TAP format output
>>
>>   .../selftests/x86/check_initial_reg_state.c   |  24 ++--
>>   .../selftests/x86/corrupt_xstate_header.c     |  30 +++--
>>   tools/testing/selftests/x86/entry_from_vm86.c | 109 ++++++++--------
>>   .../testing/selftests/x86/fsgsbase_restore.c  | 117 +++++++++---------
>>   4 files changed, 139 insertions(+), 141 deletions(-)
>>
> 

These patches usually go through x86 repo to avoid merge conflicts.

I need ack from x86 maintainers to take these. I don't see x86 list
cc'ed.

Please make sure to include everybody on these threads to get quicker
response.

thanks,
-- Shuah


