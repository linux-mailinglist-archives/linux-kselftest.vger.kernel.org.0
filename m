Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9D6552DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 17:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiLWQe6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Dec 2022 11:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiLWQb0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Dec 2022 11:31:26 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17D61112
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 08:31:25 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id o13so2670760ilc.7
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIeqnV74AwuRk7r8TOoasYJ76RTjL+agKCQ9LEalU4M=;
        b=OeVW7MtnEDNGgy1/bURGkOEdhXzvEAHAqq5HKpimHHgIp+V1JFjjuYxbNHcxBEUtzc
         DD2NflD7UhQbSYNpkrHfzZPhI4iOj2SrtDu5IHjzo3Y7PxYRwdcMMlB/dS1GMb3jEZ11
         LHqXkm6eIhuQaueQUJADXQbT0zRwzhhZv/X4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIeqnV74AwuRk7r8TOoasYJ76RTjL+agKCQ9LEalU4M=;
        b=y8F6nRch06CerATb/nOsNtLtk6JdYGzY6aASGycO+ekoCF6fNCztqra7/gU5MggZHV
         o118dPdqfRODJSHVQ8DO6PtJtjyFYoilkIxtPE7pEJiVsdkUbLdDdsH3arCD3qD+/xBJ
         fds3XQGj6bq7TcIsbkhVyrmpe5pwsyhgd6pjET+EuIaIy0FMvbjjIrZjU6MYqjzI4Adt
         nTGo5WkvQOoJw5HuOYl9MjGrf8mVKgyQ7Rtf7xSgtsIWpcA/xrpjuEKtXpVDF8eBfYiO
         J9SZfkrCpoCUsdUJr6vHQf9BbJ/aUESS0F8lsZlnF75vtk+x4ydWHVe3UQMPeIyRoFQR
         mw/A==
X-Gm-Message-State: AFqh2kojpJxcFhm6jlSz25KIlruL0gYERCzJ7/+asveKmeoiOGmUmD00
        1wgGKpYecDF/cLP8Cq+na7lKAA==
X-Google-Smtp-Source: AMrXdXuLBZH3Xbh5KNh2CUg+8Iei84e6JhS6SvjROlma/Q/xZEYy0eJgGwCOYltgFum3SRGojbi0Kw==
X-Received: by 2002:a92:d189:0:b0:309:2fa4:d45 with SMTP id z9-20020a92d189000000b003092fa40d45mr1396923ilz.0.1671813085166;
        Fri, 23 Dec 2022 08:31:25 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g15-20020a02a08f000000b0039c2ceb6bbbsm1025092jah.113.2022.12.23.08.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 08:31:24 -0800 (PST)
Message-ID: <7dcefe25-d31c-bc26-4910-e53bed6eb01c@linuxfoundation.org>
Date:   Fri, 23 Dec 2022 09:31:23 -0700
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
 <b2a5db97-dc59-33ab-71cd-f591e0b1b34d@linuxfoundation.org>
 <20221223150211.GC4587@thinkpad>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221223150211.GC4587@thinkpad>
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

On 12/23/22 08:02, Manivannan Sadhasivam wrote:
> On Thu, Dec 22, 2022 at 10:49:48AM -0700, Shuah Khan wrote:
>> On 12/22/22 10:45, Manivannan Sadhasivam wrote:
>>> On Thu, Dec 22, 2022 at 09:58:30AM -0700, Shuah Khan wrote:
>>>> On 10/6/22 23:39, Aman Gupta wrote:
>>>>> This patch enables the support to perform selftest on PCIe endpoint
>>>>> driver present in the system. The following tests are currently
>>>>> performed by the selftest utility
>>>>>
>>>>> 1. BAR Tests (BAR0 to BAR5)
>>>>> 2. MSI Interrupt Tests (MSI1 to MSI32)
>>>>> 3. Read Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
>>>>> 4. Write Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
>>>>> 5. Copy Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
>>>>>
>>>>> Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
>>>>> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
>>>>
>>>> Adding Bjorn Helgaas to the thread.
>>>>
>>>> Adding pcit test under selftests is good. There is another pcitest
>>>> under tools/pci. I would like to see if the existing code in
>>>> tools/pci/pcitest.c can be leveraged.
>>>>
>>>> As part of this test work, also look into removing tools/pci so
>>>> we don't have to maintain duplicate code in two places.
>>>>
>>>
>>> It has been agreed in a thread with Greg [1] to {re}move the tests under
>>> tools/pci and utilize the kselftest.
>>>
>>
>> Inline with what I am suggesting. However, I don't see either move or
>> delete of tools/pci in the patch?
>>
>> The first patch could start with git mv of the existing files and then
>> make changes to preserver the history.
>>
> 
> Right. This patch was posted independently of the series [1] that I submitted to
> fix the return values of IOCTL calls used in drivers/misc/pci_endpoint_test.c
> driver.
> 
> Then in that series, it was decided to move the existing test to kselftest. So,
> I suggested Aman Gupta [2] to integrate my latest patches, add the kselftest
> patch on top, then remove the existing test under tools/pci.
> 
> The kselftest patch can also move the driver first and then make the change as
> you suggested. Either way it is fine by me.
> 

As I mentioned in my previous email, I prefer to see the move as the first
patch and then changes on top. This preserves the history and cleaner.

thanks,
-- Shuah



