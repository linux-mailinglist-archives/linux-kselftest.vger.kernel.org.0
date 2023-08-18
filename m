Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431F5780FFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378472AbjHRQMG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 12:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378603AbjHRQMC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 12:12:02 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E4D3C21
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 09:11:56 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-790af3bfa5cso13850839f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692375116; x=1692979916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgOUhrzygLSqZdauIc0uVm9MlbbDR2SIBt1AEcio6xE=;
        b=RjgLNxjyYy4EB/PEs0GWly50tA3Mc6O+p3KRLXDartocn3ajnzKW+O6Wj9lWK/ukUX
         5GgloCF5lD65JykgEYfBnpT4e/M3xTcBuRqwCiC89AViJVElf7Y8bfEI7Ja5E+a+3N7q
         L1GYNCv7JeBeBQ2SUBaLgtEQ1MOcZLNfGocLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375116; x=1692979916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgOUhrzygLSqZdauIc0uVm9MlbbDR2SIBt1AEcio6xE=;
        b=jViDlnqXG9ua12uDVqerdiDNPpLk+GLux49HU5zqd6sWDNDMjxnvb7neN1Keem3XOu
         K4Kb7v2dIr/JBgI/nMJFZXCkaQqmG2ZvT3QgptjqJlhA9RxPAtmFVn5YowhAGUcPPqDp
         OhMUO3DvXfNv9RgZchG9iYpd3PqydxGIpl3okkEIrvapBJHUreZ9xsJUhj5ygUajKeHC
         SqTZsnKgUUN+PPmHKxe++nMqzgeN9WhT91OWNJXvES5Argezp86uzJHt0+o1GsqwII/J
         Tl8cOhMum4UqgGgSShvKlplTtB0Zw8WJQ7WC7aL/bS+qPKOKF5eS+pZ5OtZnSLLjDnxT
         ul4g==
X-Gm-Message-State: AOJu0YyPNtFoOaUceZtx3zuHIiG4FUlI3d7aGS80AVFpVz97sj/SdDHK
        7SRlkIRhoj9U2gK3aYIl8QXx+cWeSo5lFrjPiiI=
X-Google-Smtp-Source: AGHT+IEcNw1RSnNlbNsCdDxT7TVaSrBRorddbxy54Y3BOOfQrA79h8aB0G9+LlR9q9CnCMMbIYPWMQ==
X-Received: by 2002:a5d:9d8b:0:b0:791:ad39:660b with SMTP id ay11-20020a5d9d8b000000b00791ad39660bmr4992529iob.0.1692375116181;
        Fri, 18 Aug 2023 09:11:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v19-20020a02cbb3000000b0042b265bf3besm603455jap.115.2023.08.18.09.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 09:11:55 -0700 (PDT)
Message-ID: <54fe5a4b-e0eb-b2e2-e39a-fc840acac70e@linuxfoundation.org>
Date:   Fri, 18 Aug 2023 10:11:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/3] kselftest: Add new test for detecting unprobed
 Devicetree devices
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>, kernelci@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230817233635.2306377-1-nfraprado@collabora.com>
 <20230817233635.2306377-4-nfraprado@collabora.com>
 <69848238-17d8-4b87-8bc1-474cae127410@sirena.org.uk>
 <bdd6da06-d790-42c1-a5ea-372d38bf0ea7@notapiano>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <bdd6da06-d790-42c1-a5ea-372d38bf0ea7@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/18/23 09:08, Nícolas F. R. A. Prado wrote:
> On Fri, Aug 18, 2023 at 01:54:21PM +0100, Mark Brown wrote:
>> On Thu, Aug 17, 2023 at 07:35:27PM -0400, Nícolas F. R. A. Prado wrote:
>>
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/dt/ktap_helpers.sh
>>> @@ -0,0 +1,57 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +#
>>> +# Copyright (c) 2023 Collabora Ltd
>>> +#
>>> +# Helpers for outputting in KTAP format
>>> +#
>>
>> These look generic so could be at the top level kselftest directory in
>> case any other tests want to use them?
> 
> Yes, they're generic. And sure, we can move it up. The tests using it will need
> to source it at run-time, so we can either update the kselftest Makefile to
> always copy this helper when installing, or each test's Makefile can
> make its own copy during build.
> 

Moving this up would require the above changes. I prefer
making these later after this test goes in to avoid conflicts
with linux-kselftest next and Rob's dt as this one depends
on  patches 1&2 which aren't in my Inbox.

I would like also  to see a common solution that works for C
and shell tests. Sourcing works just for shell tests.

>>
>> The test itself looks good in so far as I can read shell.
> 
> Thanks for the feedback!
>
Rob, Are you planning to take this through your tree. If you
do, here is my Reviewed-by

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

