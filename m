Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2805E5A58FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 03:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiH3Bso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 21:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiH3Bsl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 21:48:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155698E4EB;
        Mon, 29 Aug 2022 18:48:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso7207107pjd.2;
        Mon, 29 Aug 2022 18:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oWRjAoIaNlvdmLgKZycNNcfP1/D8Ayewqywa9DRQlk0=;
        b=O4dLmmX7YLVw0az9Yp2rt5msHE4Ki55aS6v/djl/z6QNnJLaQvR1oavdPwZU8IMNDN
         CkCnh1iFH1TA8llLbYtEYKur6bCNuqGcojzMivNV12bgD87vK8naSwa8vXMXvHrpslFw
         Z0lHGqSLEjjzZGd36B9KAazOrumUCVv5gL2nRKpRuHtNDeASBm3dDDHQm+zbplDghmjl
         RNkdn3HKpKurjRFUyBTRNCTnDdREjim734yHSDkMudXOP6V22shM3yiCqiYVCd/qbnmD
         tFoKmrh0a5Lch1q39JrzWQV35Eg87r9gzFja7BWXgK510rbKVwN/lPEMgvuLLsM/JtQs
         LyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oWRjAoIaNlvdmLgKZycNNcfP1/D8Ayewqywa9DRQlk0=;
        b=Q/XQfJxoHBmzbgTEoklq1l8vb+7zEg9c5xmYIWXySfwwXv3bQmt6UUNfgVGcJylK4z
         DPTCjFPSqYCwW4J28c9P49i5PYStMYYtJv6lBE/daccpX2unNjZlf3LmiUB0nqePQEKK
         xJ+JV5ttHDFFuINOSyOSr6j4fw/ruttW9riLNjYSZdF/NIPAvLllKTLsLgMyWe/sHYAM
         5vG+ggl0mEs3kQtu5YkseAk6WObeZU0ITvJub7TWbiQlfjxCZwBomB/wB/eCuCytYZGU
         wNhRfiS4+DHh3APzgYLKKat5q5JdpVsV2OrrWZMhWU+Y8hwhjamUHbDD9SNJyW9nUxvc
         liaQ==
X-Gm-Message-State: ACgBeo38VKjwuDU0RFE4R/HgC72I+lclKAldUgYfrw9/7lLDjGsyY5mK
        HBf9AzpXrBqYI4G4Y6CVl0E=
X-Google-Smtp-Source: AA6agR6GNAplD0brROKngQhSCYkkCE/mWRRADuQJpXk+CTtGyDr7TLlfQ6Euy/rMgaGtimJiUChUmw==
X-Received: by 2002:a17:90a:e4cb:b0:1fd:9626:c7cf with SMTP id e11-20020a17090ae4cb00b001fd9626c7cfmr13752581pju.103.1661824119128;
        Mon, 29 Aug 2022 18:48:39 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-91.three.co.id. [180.214.232.91])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b0016cf3f124e1sm8277871plk.234.2022.08.29.18.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 18:48:38 -0700 (PDT)
Message-ID: <eaf6c56b-c329-2d02-7599-ca83dbe20b0b@gmail.com>
Date:   Tue, 30 Aug 2022 08:48:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/2] ktap_v2: change version to 2-rc in KTAP
 specification
Content-Language: en-US
To:     frowand.list@gmail.com, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220829233150.3564612-1-frowand.list@gmail.com>
 <20220829233150.3564612-2-frowand.list@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220829233150.3564612-2-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/30/22 06:31, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Prepare KTAP Specification for the process of creating version 2.
> 
> The version will remain "2-rc" until the final commit to complete
> Version 2.  Adding the "-rc" ensures that none of the development
> versions will be mistaken for the completed version 2.
> 
> After this commit, Sphinx complains that we now need more '=' signs:
> 
>   Documentation/dev-tools/ktap.rst:3: WARNING: Title overline too short.
>   ===================================================
>   The Kernel Test Anything Protocol (KTAP), version 2-rc
>   ===================================================
> 
> This warning will disappear in the final commit for the release of
> version 2, when the "-rc" is removed.
> 

I don't see that -rc stripping in patch [2/2], so please fix the Sphinx
warning above in this patch.

-- 
An old man doll... just what I always wanted! - Clara
