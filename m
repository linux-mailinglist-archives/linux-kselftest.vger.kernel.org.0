Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554D575BB87
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jul 2023 02:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGUA2r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 20:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGUA2q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 20:28:46 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D312D71;
        Thu, 20 Jul 2023 17:28:20 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b9f3b57c4fso1083684a34.1;
        Thu, 20 Jul 2023 17:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689899269; x=1690504069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnlM7bXY3igGuWTJwFezoqiRo91fGD1ITq/KKVdjdQg=;
        b=OF2BWAb8Of84aZqVSe5kOiy5umpEJQ4Sacf+JLxzY6imPfN1O+snIH/QWsdV+yPZlj
         e9Eq3WJr989aCEDVPCxqXXj4W9eeS7m1VDDcXn4qRm/HS4UOF95cRcZ6itEzV1z4mPyT
         6H0G/H8usF3URbSDVAkvDI7vG8hotHN86H1xtH+pcEJ94eENpadvx6r0DBzA3gIoeum7
         qEuksjcXk5GKbfjD4eV6IZTlnO7xgNwLr2X9aHdcNST/0QDo1Tkv0iT8DfGcpJ3+TsEG
         1yNYm2dwMLKIiUxQWmfhlGPkEFn5Ww/PoWo8wB7NnPCGKX0yTmyAzxHm6ts9bNDvtcnQ
         8yOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899269; x=1690504069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lnlM7bXY3igGuWTJwFezoqiRo91fGD1ITq/KKVdjdQg=;
        b=LOByD5cUoNFHnHyMkAm6u/3vEzj23QpV0A+qXK0GOijaaeAjnmsBJy6lAJYmUDnSG7
         YFb3xs72zZYsl6FQn5gaziU59Kowths9cIDkHibQgEBuebiR2a4OPcItfbadKKH8+FdX
         5PcLhyMp0ptx36GykdUYprrQnqoski5bxyvUMsY0JU3iYnnkdbnlj//8qXiUycXdWmrO
         4eV+zUDcqu/0IVnUA03MqzF3S9lrmTl1QxkrHafRwjlediCPrRS8KyQE02K/Ul47PZUU
         oXIAWkRLkIAWXgIC2JjW3Dsoan2unY7C8oX8dCUFXlGPqDo+t/rVWFpdUF+4FhQcvWnT
         +VLg==
X-Gm-Message-State: ABy/qLb6ZTwiFQ/9T/KNN1unX6nITJ/iZaJBPkXhWLX0k3zhv+BoISbD
        LixBC97HVZ6tQsrElHU2XlU=
X-Google-Smtp-Source: APBJJlHUzP+ZHzljtTFXKrRrAU6CvEERwpEcD9VeUn9iVvieyjKnGF8Ns6X2b09K4ITukvbWkN+4rA==
X-Received: by 2002:a05:6830:1409:b0:6b9:9b41:fbf6 with SMTP id v9-20020a056830140900b006b99b41fbf6mr454699otp.0.1689899269303;
        Thu, 20 Jul 2023 17:27:49 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l7-20020a9d7a87000000b006b9b6aea237sm939676otn.80.2023.07.20.17.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 17:27:48 -0700 (PDT)
Message-ID: <d3aa8c48-9f47-cead-aaa7-3ea796b91810@gmail.com>
Date:   Thu, 20 Jul 2023 21:27:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: doctests: Use tabs for indentation in generated C
 code
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230720062939.2411889-1-davidgow@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230720062939.2411889-1-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/20/23 03:29, David Gow wrote:
> While Rust uses 4 spaces for indentation, we should use tabs in the
> generated C code. This does result in some scary-looking tab characters
> in a .rs file, but they're in a string literal, so shouldn't make
> anything complain too much.
> 
> Fixes: a66d733da801 ("rust: support running Rust documentation tests as KUnit ones")
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> [...]
I find it weird to mix indentations in one file, but if it leaves a
good result then I'll hold my tongue.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
