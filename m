Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B756BD76F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 18:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjCPRtN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 13:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCPRtL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 13:49:11 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A69510EAB6;
        Thu, 16 Mar 2023 10:49:07 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t9so2652421qtx.8;
        Thu, 16 Mar 2023 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678988946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/8oanUDBfexi57TtNYFoXvyhgYE0G1VxW08obb6zv0=;
        b=p4vnGUY743AOhUMkm8wnCrCYQoHvHVq/5Gc2UVPYtsBRP0x+RPhjx9WHa3sMOg35ec
         3pZjChHYQnHk+izqXVDj7yf0v4bYiFwOiV8ko4wiEuua79cSADPTSK0XLeL4Gf8MMWOp
         9MwaGHD2ZwcmgbO0AbGKj0FbHpeszR13ziPAskRc9z+Ne/GEvImVZ2HFyGOjhvesjIKV
         XnOsdDSMR5/R4ZjcPt83Gaiza+vfvjqBc1ycSzyumPij50bXV74ZDlEq1ELNlGcX4CzA
         jEdRXHLHqz3K1sC7QNGo1g4EdftwV0DRA2TdcA6Z/Na1MXcuKcIseEPxCvWKsQtycD+J
         B5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/8oanUDBfexi57TtNYFoXvyhgYE0G1VxW08obb6zv0=;
        b=r59IzIXwKgWQvL3MqonfHfOGWb5sd1Sf7IGHB77lkNwgS5M15nWg3vnbVI+WFpPuGt
         xjCLWqGCJJe07DFWJZjiweZ6pqzAlIfXNZO56eAKmcYPZAmHQmvwR+dgxZxjYLjrTr6B
         YSEFn8sv34YnzaZzVo3UWaSOUvkABcL2rYeTXGbDdYlQZzxQU4tKtCodpBtAi28Bw+k7
         wCiFsmn9dFv0oivsobWvF/yG1kxY5UEwxLnDRH/jfMBjB1q8hLTDXeG0kLPiUnczRNbd
         uM+6dAYe9FcfXd00AtscKEkmkZjugXcGAoIBG1wy61dWJf+x6rdhpEySc8oc4pnnyCkS
         KTzQ==
X-Gm-Message-State: AO0yUKW0e/jrsVBnKtxR2iaT9nBzEHlirB3XO4VGz6A/CaVmfDGY5t1u
        x6wkaGFrVbvf5B8JM8ikGlA=
X-Google-Smtp-Source: AK7set94ojwRNEXu+PkhVIjglP3EHECiU+kHNr269KiCcOr5bb0A3bfMKFkyD7iiQuOn5DFCI/J8Hw==
X-Received: by 2002:a05:622a:8:b0:3bf:d13f:30ae with SMTP id x8-20020a05622a000800b003bfd13f30aemr6369522qtw.54.1678988945908;
        Thu, 16 Mar 2023 10:49:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:2cd2:a240:3730:1959? ([2600:1700:2442:6db0:2cd2:a240:3730:1959])
        by smtp.gmail.com with ESMTPSA id i18-20020ac84f52000000b003d621964626sm65723qtw.8.2023.03.16.10.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:49:05 -0700 (PDT)
Message-ID: <462cee8c-c946-4483-98f0-cb8491d9a87c@gmail.com>
Date:   Thu, 16 Mar 2023 12:49:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [KTAP V2 PATCH] ktap_v2: add skip test result
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     kernelci@groups.io, rmoar@google.com,
        "Bird, Tim" <Tim.Bird@sony.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>,
        "dlatypov@google.com" <dlatypov@google.com>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230310222002.3633162-1-rmoar@google.com>
 <BYAPR13MB2503C590A2AE6FEF6BCAC529FDBB9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <CA+GJov5O6hGdjYMXjRd34MEZuyBuukyJCOsS=HeO30h43eLQbQ@mail.gmail.com>
 <4568b302-2a5a-4499-b2f7-12f89c031495@sirena.org.uk>
 <155efcdb-2be6-16c4-42bc-37930639060a@gmail.com>
 <ad7e6e40-6542-4439-8199-d46a6fc91364@sirena.org.uk>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <ad7e6e40-6542-4439-8199-d46a6fc91364@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/16/23 06:33, Mark Brown wrote:
> On Wed, Mar 15, 2023 at 04:45:29PM -0500, Frank Rowand wrote:
> 
>> Yes, there is no need to do a single specification change that results
>> in incompatibility.  But given the previous discussions there seem to
>> be plenty of other desired changes that will result in incompatibility.
> 
> Do you have a pointer to that previous discussion?

There are links to a few threads at:

   https://elinux.org/Test_Results_Format_Notes#KTAP_version_1

And I am tracking KTAP Specification version 2 activity in the
next section of that web page (not much yet, but hopefully
becoming more active).

-Frank
