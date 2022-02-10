Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B814B19A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 00:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345766AbiBJXj3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 18:39:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345717AbiBJXj0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 18:39:26 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB85F5F6C;
        Thu, 10 Feb 2022 15:39:26 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 71so6635142qkf.4;
        Thu, 10 Feb 2022 15:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pVRlINwh23rrkJKDcUCZ68/wHKReRIgiYQJNpacX/d0=;
        b=kg0XYo7sGZilM2G15LVyGnlyqPPgokawSzwBSgv9BkIH7RP8Gd6/jSpfrv2IoxygoK
         9FBQ0paJQuW7vsgBs690FAg+yUGAWs2h4fxjM4Q28yFXOtlLTAQPlhOTl0wxwFENaSf0
         QqrK4U8WuCVIipHbW+D9p9J+6fZX3IXKK+wZtJ2YSG7afAm9Ja5FFhR7OT/vBtLRPmFJ
         LmvPNUXnJjlaUbTzZ1UXpVW2w17cnpx0jd0wYTwROIzhEK2zxxr7C1YUF2Gg01HVMd4C
         yMWTTKrAPMBM5aolRdt9xKX65h90+tmxaaNynSuOrQE962ijhNP/v46dum/azD8+6Ol3
         iEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pVRlINwh23rrkJKDcUCZ68/wHKReRIgiYQJNpacX/d0=;
        b=x9tDvDnjCDvle8T7DpCeAIKhtV+hlN4zvPd+CeC12OQkVKHaC2XLco4jA+vu0whE96
         UC6Ptm3KjfCRWowiUTA/GRHAE22milJ4jtPM64SqbGS6EwrzlGBFmmjriLRFdoGLAzRg
         d8TjCiTTKUmKPhs0ng3sV3twFakaFpTfNfEQtRuMtW5Ed2Bz4urAmfhOv2Ts8PwjrphC
         wad9y6jXhTsUc6AhHiSm03nvtDkEEDSzQQ/v1LRMwypKA+lHFIS3E9BQXqaA/KjjC3Kg
         UztV9m80jLEipUUEbX8fh+3YsHky0VygeGd6+TZnIAZFFZFSgeSY6mDfmnYRyAevx7Xx
         8vDg==
X-Gm-Message-State: AOAM532Am1ouEwmimTPND6/2kvtGGRZmvqnPQ0nxBBprFmeTCO+Ctf4j
        QzvmrTQXtNOlJsiltdM1tSw=
X-Google-Smtp-Source: ABdhPJwekNBLjAHygRo+WiYjR4A6S0B+in5FJxhn+v5Hw3sYJDJH+z7r+dVavjTx2JxMSXrTfvzHHQ==
X-Received: by 2002:a05:620a:853:: with SMTP id u19mr5126700qku.188.1644536365899;
        Thu, 10 Feb 2022 15:39:25 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id g14sm1830050qtk.59.2022.02.10.15.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 15:39:25 -0800 (PST)
Subject: Re: [PATCH v5 1/1] Documentation: dev-tools: clarify KTAP
 specification wording
From:   Frank Rowand <frowand.list@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        Tim.Bird@sony.com, Brendan Higgins <brendanhiggins@google.com>
Cc:     rmr167@gmail.com, guillaume.tucker@collabora.com,
        dlatypov@google.com, kernelci@groups.io,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220210233630.3304495-1-frowand.list@gmail.com>
Message-ID: <370340a9-26cf-cbb2-5990-14e37b40f668@gmail.com>
Date:   Thu, 10 Feb 2022 17:39:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220210233630.3304495-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/10/22 5:36 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>

< snip >

> Fixes to code-block directives in version 3 were also submitted by
                                    ^^^^^^^^^  version 4

> Randy Dunlap in:
> https://lore.kernel.org/lkml/20220131003637.14274-1-rdunlap@infradead.org/T/

< snip >
