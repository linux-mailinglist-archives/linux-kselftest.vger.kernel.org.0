Return-Path: <linux-kselftest+bounces-18926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F180898E431
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 22:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBFA1F21E8A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 20:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C3B215F75;
	Wed,  2 Oct 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G4NkD68s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353F1D278D
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901218; cv=none; b=WzFfOZTmWWKS3Z95P0jppa9KGvV09p9JKqpgOA6ojb2p6iCdjcoQhlshF4fuoZC1s2/vrq/dqRQ2woJ/jMQuNjHEGdxh2TTGwDcX42NcQW2bNFTmZ8eDXdIBJYUFkz/4CyG2uw4YQLNG3lZJK0KyGhMlS+05vgH7pyItBv6VKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901218; c=relaxed/simple;
	bh=vYFfMsyPD4fdVa42A17PQL3U499ljM3P6ENokeeipcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZwoptwbr/msTmTFUrwGj1gKLN0fMdz1bcXff/gyBEjgP3mzyBRu3ViufXuRqAJWtRZDOLFPh60yjL50tVVKKL73xquguxUOa1IuPvRSiEun7Xm8+3j9xuZeYM2xY2oicJa/wylMYFgEBNzLxiZGA32Niqor7nuqFv7/oPR07iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G4NkD68s; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82fa0ccb0cdso10100039f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727901215; x=1728506015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIV6lH5FyZeIWyK3iBVhKXN6xjSAFCfpXdH8a1hnOqk=;
        b=G4NkD68sVgZzTyLTd99yZPoW4b2ZrdoXzmxUg2fHMVCWA7ywFHw2EaG5F0YCTn4e/S
         uABNn4kh24OQOR9Kpukg2FNYT6ccDOFUmpLvAJhDKMHbPO4nSoHWWCS9b7Wt5HRuEEYb
         6LMRoGVVyQhpSZpwAXNj0OClko1QsjTDGZ6h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727901215; x=1728506015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIV6lH5FyZeIWyK3iBVhKXN6xjSAFCfpXdH8a1hnOqk=;
        b=coVaXcUOM6KwBZ8rFb3bE9cfxyYLCb4Ys0oMWoRj5+ep9Ay1HAHUzry/I2+khBEYJc
         5zGE463+vWRqSWNgKacBKRNMZQE8fyI4HkMWp08A/2zMrOrY+/S/FuQQb/bz25cPO9UI
         eTBrUlo/9kBS6YAJEKr1P6eIQeJkmS/aTobVbWq1+UW2v0ZJnh60ZQ/JqJxC/ZgxqYM1
         9mA/evaq5zR7IlWxdW0blaBkkOMVvseFUQjr31nLskvwjeXgsfH6tWexZ+NODUe+FMOl
         5fcAlz3W95RHyVE9xoi/6oVInV2Lpc71Iw5o5BIM6b0c9DwQfBMzB2NG85J3aM7GLZoC
         OF9g==
X-Gm-Message-State: AOJu0Yxa813QAlidcQhyX3EeAtcF/5zJeF5zWXA8ewNfXfiwQfhQJjmq
	dYNfofBSr33Thg2n+XsK5lX8yrU5mQLe/NMioEl5yqPIS7FLQWmim8RodtbLTik=
X-Google-Smtp-Source: AGHT+IEygY0t3p8+aBjlRGLgdwaDvI7m8LTnpFpkB22i4Op5SN7lXIA0tawLFz19GZDo90hJF54R1Q==
X-Received: by 2002:a05:6e02:1e0d:b0:3a3:49f0:f425 with SMTP id e9e14a558f8ab-3a3658b83d8mr49768945ab.0.1727901215298;
        Wed, 02 Oct 2024 13:33:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d82bb9sm37669425ab.31.2024.10.02.13.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 13:33:34 -0700 (PDT)
Message-ID: <6e023b6a-af3d-4cfc-a956-1e47852adde5@linuxfoundation.org>
Date: Wed, 2 Oct 2024 14:33:33 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kselftest/devices/probe: Fix SyntaxWarning in regex
 strings for Python3
To: Alessandro Zanni <alessandro.zanni87@gmail.com>, shuah@kernel.org,
 gregkh@linuxfoundation.org, nfraprado@collabora.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240806121500.51337-1-alessandro.zanni87@gmail.com>
 <6tlfxlgukpftlfh7z4mwbklcjl74rxixo7xjauyf5dstyhwav2@wvkwd3df5am6>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6tlfxlgukpftlfh7z4mwbklcjl74rxixo7xjauyf5dstyhwav2@wvkwd3df5am6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/2/24 03:00, Alessandro Zanni wrote:
> Hello,
> 
> this email is just a friendly reminder to know if the present patch is going to be applied or not.
> 
> Thank you.
> Best Regards,
> Alessandro Zanni
> 

No top posting please.

> On 24/08/06 02:14, Alessandro Zanni wrote:
>> Insert raw strings to prevent Python3 from interpreting string literals
>> as Unicode strings and "\d" as invalid escaped sequence.
>>
>> Fix the warnings:
>>
>> tools/testing/selftests/devices/probe/test_discoverable_devices.py:48:
>> SyntaxWarning: invalid escape sequence '\d' usb_controller_sysfs_dir =
>> "usb[\d]+"
>>
>> tools/testing/selftests/devices/probe/test_discoverable_devices.py: 94:
>> SyntaxWarning: invalid escape sequence '\d' re_usb_version =
>> re.compile("PRODUCT=.*/(\d)/.*")
>>
>> Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from
>> discoverable buses")
>>

checkpatch complained about

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 160c826b4dd0 ("selftest: hid: add missing run-hid-tools-tests.sh")'
#110:
Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>

Run checkpatch before sending the patch. I fixed the problem
and applied to linux-kselftest fixes branch for next rc.

Sorry for the delay.

thanks,
-- Shuah


