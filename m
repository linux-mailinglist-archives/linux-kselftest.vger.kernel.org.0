Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A23C62A309
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 21:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbiKOUf7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 15:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiKOUfk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 15:35:40 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E1031DFF
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 12:32:39 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i5so8019308ilc.12
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 12:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1T3eKoU26XdaUJb1umtAE8UhKjbjYlGNkOGfdBCz+LE=;
        b=Ym/qLhVMH79ruzntue74DVruMMpM4CiNLMrptmBOT1keP8sCYhBGtdDcNnt6iTsOWc
         UIjIOCL3Nk0nd4tAp0W03wuNWchVBUS0dxl1eMNMykQBBCIz4ECj71L0OteC8XLOfK7R
         l6/7WuaWvrR3uSQ3hwa58aQmOfTgnisbJC398=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1T3eKoU26XdaUJb1umtAE8UhKjbjYlGNkOGfdBCz+LE=;
        b=Uv+L023rIlgcPN2c1ePx2nrnZKZ+gdErOyrrCQcxdKPegeuIzwinideRft/4lPQ4Pu
         K+0ZZkE9hMDtrx8VR9Om5IC6lFJ62k6jgDZ46/VxXd7zXTBS1s9mfZG9z4EYKRKZ3b9X
         8L/H0v9ZgrBvr74+jl1TJqeF2tOydJc83iv1YslEm7U2eoz27HKzG4QQZTgq1zHToSi6
         GVntNTKCoTHRpFdVQ54wJUZEyHPtiv2HWfv/3O9kzzknWmI0IrKR4iSoPxoIQwdpIcho
         yyzPZ2zjKGIxWEsa9OHF/compaVnRa7iucb+U5z0iq9qIZdH/eof11AF8Zj/XJCrP+zA
         B7+A==
X-Gm-Message-State: ANoB5pnQRY5An6Mqbf3fwd6KehfTAbvpm5cBMBcZFM9Nr3Qx6iwjdN3O
        eLqHFC7+7IsIT5h8AbSLfd1L4w==
X-Google-Smtp-Source: AA0mqf45tJRQw/LnKQBewXOHzL0KcJ02sWaxx5HcSxBI5CGrjfw1qsXjE7dBWxiEdQtQo2CB3+tNqg==
X-Received: by 2002:a05:6e02:1026:b0:300:d831:8c90 with SMTP id o6-20020a056e02102600b00300d8318c90mr9051464ilj.21.1668544359088;
        Tue, 15 Nov 2022 12:32:39 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p7-20020a02b007000000b003762a346160sm487444jah.84.2022.11.15.12.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 12:32:38 -0800 (PST)
Message-ID: <a484bb98-4a12-1b3d-a488-0bbbb529b723@linuxfoundation.org>
Date:   Tue, 15 Nov 2022 13:32:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] selftests: rtc: skip when RTC is not present
Content-Language: en-US
To:     alexandre.belloni@bootlin.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Shuah Khan <shuah@kernel.org>
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221115202105.2309859-1-alexandre.belloni@bootlin.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221115202105.2309859-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/15/22 13:21, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> There is no point in failing the tests when RTC is not present.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Tested-by:  Daniel Diaz <daniel.diaz@linaro.org>
> ---
> Changes in v2:
>   - reworded commit message
> 

Thank you. Applied to linux-kselftest next for Linux 6.2

thanks,
-- Shuah

