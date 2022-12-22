Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569926545BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 18:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiLVRtw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 12:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLVRtv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 12:49:51 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B9F28E09
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 09:49:50 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y4so1380978iof.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 09:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqHEp9ox4TOhI9Z8ZKpq+s6nfolOdpEjmtrAzmdooGQ=;
        b=T19EbH9yM68PlmesobZUAHslWbqvnsdofXAWYkoDd21ytKCO7eQFuyzCWQe/JwZBQ+
         A0IoWhpwaqh4h8Te6ARx1LUIrDQQLaCYTYXZHR0o+gO4t2LPVM216LtHwjPgZlYnWNXA
         S/DV3Ac/UgXZQYpU56t2bCBZd0rVC1aDxErjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqHEp9ox4TOhI9Z8ZKpq+s6nfolOdpEjmtrAzmdooGQ=;
        b=o3gVOUT1Msuhc9DRgQV5Tj3a1iCOOZzKH9LUJ6lc+HVled2it2uldL1r8WNXxErkd9
         MGbhkRXWo7vVMSCRKdqVDHTYAOTeKI2PMpSOn9EQalXMEGAdlCcxxMYvvhx/ms/YN/pK
         wDArW3U4yGP7NE6Z77EsyBcR+afDU/n7MgR3GcDGTT/qkPcwAp39/ClkY9hIn5tgVFrh
         9C2T/r3w7uewDhK6eDmUOU0vGCgV4kCGeoUBO/pqiOqjnh3ZLeiMVevNm115dq8huMPY
         ETCDeEcHJZgPwjDJbMkeFe+FTdmCodH3zUCFczuyEX0s/aNkKiMaeZWEKMct2CebRZho
         Fe+Q==
X-Gm-Message-State: AFqh2kplNuWnTeoGdhKyjntOaF6kRi/DrHR3vVN8pEjssS8+9gPkeDss
        w+EpE3wl2Q3xzC1jmifq+nZMwQ==
X-Google-Smtp-Source: AMrXdXuhKYNoiXTT7XUOvJZmZbDPvd6cMep5zuvCJkKBZuDodE2fssf0IDpYGFVCpWA50TPp+E1nCg==
X-Received: by 2002:a6b:410f:0:b0:6e2:d6ec:21f8 with SMTP id n15-20020a6b410f000000b006e2d6ec21f8mr880549ioa.2.1671731389989;
        Thu, 22 Dec 2022 09:49:49 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u24-20020a02b1d8000000b0038a5b48f3d4sm268386jah.3.2022.12.22.09.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 09:49:49 -0800 (PST)
Message-ID: <b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org>
Date:   Thu, 22 Dec 2022 10:49:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Aman Gupta <aman1.gupta@samsung.com>, shradha.t@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, shuah@kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
 <20221007053934.5188-1-aman1.gupta@samsung.com>
 <641d1e50-a9d0-dc15-be76-07b8ace25dae@linuxfoundation.org>
 <20221222174532.GA59500@thinkpad>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221222174532.GA59500@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/22/22 10:45, Manivannan Sadhasivam wrote:
> On Thu, Dec 22, 2022 at 09:58:30AM -0700, Shuah Khan wrote:
>> On 10/6/22 23:39, Aman Gupta wrote:
>>> This patch enables the support to perform selftest on PCIe endpoint
>>> driver present in the system. The following tests are currently
>>> performed by the selftest utility
>>>
>>> 1. BAR Tests (BAR0 to BAR5)
>>> 2. MSI Interrupt Tests (MSI1 to MSI32)
>>> 3. Read Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
>>> 4. Write Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
>>> 5. Copy Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
>>>
>>> Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
>>> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
>>
>> Adding Bjorn Helgaas to the thread.
>>
>> Adding pcit test under selftests is good. There is another pcitest
>> under tools/pci. I would like to see if the existing code in
>> tools/pci/pcitest.c can be leveraged.
>>
>> As part of this test work, also look into removing tools/pci so
>> we don't have to maintain duplicate code in two places.
>>
> 
> It has been agreed in a thread with Greg [1] to {re}move the tests under
> tools/pci and utilize the kselftest.
> 

Inline with what I am suggesting. However, I don't see either move or
delete of tools/pci in the patch?

The first patch could start with git mv of the existing files and then
make changes to preserver the history.

> 
> [1] https://lore.kernel.org/lkml/Y2FTWLw0tKuZ9Cdl@kroah.com/
> 

thanks,
-- Shuah

