Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9590F67D6E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 21:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjAZU5Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 15:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjAZU5Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 15:57:24 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C407534339
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 12:57:23 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id p12so1304005ilq.10
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 12:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8q92vU6FC2OBfigvvadZc6pP7ck9MsJPPUZntKKUy/A=;
        b=DZqV6twI7VDtxWwtbB602B5SBi+EoZE3C2HyPq+uwbkahM3VPw1QtNWS7g9P5EEQQq
         2P1Ij9Xwl4uzPzC/ZUT78vGXyyDU3nFU7OGsfm0KUkbBKPf2ZwK0Uv4fVQ8Mq40wiM8R
         ejCk3AqWm/XyADqZsr5wood3OyIU729juzb+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8q92vU6FC2OBfigvvadZc6pP7ck9MsJPPUZntKKUy/A=;
        b=0KkuQicFiLpueZBWPWaJ2Z8T8EESUSVzebtZrF5MzCK/4pdRRnOesyy8MwMl/fQW7r
         Ug14t7lgmMhcH5Wl39w0s+VOH1e7OyEBwRK9lLQFVKrYWLAXeEsXhk0DDNmTBZHTNdry
         +W5ckL67flu/NebsFr4vcdwiDFFrgIe7mFTIK7I2V5sKnZWe5koeiOovW26IbbCLScJ9
         JBLMe/utUJSwIHcYQPmq4haE+rshorMHMELzlm9gdEhrjRGJtdNdpanBwoV3+jejtisH
         q0BLbCutu/R/NYNtokkfWhnUbdMNfE3sm6hXU5aU/Kgk5pKjuF5ZGjXlfF+gF/E57sVj
         pGNQ==
X-Gm-Message-State: AO0yUKX9+6fFXsOEjdVHhsgsLkDvNQQHDP9y7dYrb7h1wIxXMIDtd1o5
        nUH4NiwTqY9ryw041AVh/MrI+A==
X-Google-Smtp-Source: AK7set/aCj/6RUlMRa8YLjfXNAgQWi6CmMdvODO5LIRSwVpCey+4a2mR0eim95Ix+3SaJyy2MgIchA==
X-Received: by 2002:a92:6810:0:b0:310:9adc:e1bb with SMTP id d16-20020a926810000000b003109adce1bbmr1421856ilc.0.1674766643095;
        Thu, 26 Jan 2023 12:57:23 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f9-20020a022409000000b0039e048ad8e7sm756643jaa.59.2023.01.26.12.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 12:57:22 -0800 (PST)
Message-ID: <7b3cbbd1-8c27-adf9-d2ed-c037f67bd697@linuxfoundation.org>
Date:   Thu, 26 Jan 2023 13:57:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics 
        <aman1.gupta@samsung.com>
Cc:     'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>,
        shradha.t@samsung.com, pankaj.dubey@samsung.com, kishon@ti.com,
        lpieralisi@kernel.org, kw@linux.com, shuah@kernel.org,
        linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
        'Padmanabhan Rajanbabu' <p.rajanbabu@samsung.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230117195903.GA142672@bhelgaas>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230117195903.GA142672@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/17/23 12:59, Bjorn Helgaas wrote:
> On Tue, Dec 27, 2022 at 10:45:26AM +0530, Aman Gupta/FDS SW /SSIR/Engineer/Samsung Electronics wrote:
>> ...
>> Thanks for review and suggestion. I understand that we would like to
>> reuse and preserve the history of tools/pci/pcietest.c. So we have
>> two approaches:
>>
>> 1: Using git mv command move existing code from tools/pci/ to
>> tools/testing/selftest/drivers/pci/ and then update the file to
>> convert to kselftest framework. I thought about this but after
>> movement, when we move it to kselftest format it is going to be huge
>> churn and we will be having modification in almost all lines.
>>
>> 2: Develop kselftest based driver in
>> tools/testing/selftest/drivers/pci/ and eventually delete existing
>> file from tools/pci/ folder providing justification in commit
>> message.
>>
>>  From my viewpoint, going with the second approach makes more sense
>> because if almost complete file is getting modified, and it will
>> make the review process complex and anyways there is not much code
>> reusability.
>>
>> Please let me know if you have any other thought
>> process or if I am missing anything to understand your approach.
> 
> I vote for the first approach, with "git mv" and subsequent conversion
> (in separate patches, of course).  If git knows about the move,
> "git log --follow" will be useful even though the conversion will be a
> big patch.  Adding a new test with the connection to the old one only
> in the commit log makes more work for people who dig through the
> history in the future.
> 

Thanks Bjorn for explaining this in more detail that I did.

Please send revised patches following the first approach.

thanks,
-- Shuah

