Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE3C56BFAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jul 2022 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiGHRaV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 13:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiGHRaV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 13:30:21 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F5613DF4
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 10:30:17 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n68so4263348iod.3
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vOrzN7Uqdgl/cFhlrzD5har4mn0v0Vu68SFM5bgzums=;
        b=JtjiqBN/dO0JCgr4GzlHtgEqo3gowzLBF7UNED/+IujeYxOK+W4C7XhJqU5yeP7tDG
         tO2QsYDqEI3YBBpPGN3tijQnN/nnXjK/JP7ZR3hX1GimcIZiCzk9hIunH1FSm5t0y7Bb
         8MQW5wwyQ3SUZWdLoEoUkbiQvfwBhkVYKXBGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vOrzN7Uqdgl/cFhlrzD5har4mn0v0Vu68SFM5bgzums=;
        b=04C6fyzmvK532il7Mq8pkfkJjpB8OCJ7mLM3H78ywX/8qE9YnCZ4vGw8/twEjLL1nM
         pwVUt6u9hvwotS3phBrz2JJIgbxitn9h/GRwFHywmBjnhgAzwF4OIkzWJnJzO2mvs5RO
         6YQZ3lXGz1JDXNzz4/nzmUliSm1VI6k64n97GlmVCvzO9jbJm0YnAocn4lbR20fsWIFf
         Sq0zoctXtRQDEB3SWQudd0n1MzUnDTrfZV8bVlYdflKQEDROGFWy61/HcS37/EfxQH1z
         BN6qHvNN95yGs2EKkB+JzrJ6oZNllEvYUiI9lnBrjCqTpwJBoN9glZsy7ofgMtl9niKd
         v7qg==
X-Gm-Message-State: AJIora+lZFtJJaJFXZgUgREZmljVYPg6FGVy6y/IGhEWfvR9gfWK7wDz
        DANAjqcSAtMNSMkSdECc79HNyg==
X-Google-Smtp-Source: AGRyM1sCuetchdeUiIDOwah0kWdSOi8konWQDV5pP2Io3vDgB/FJgeKue7VxuReWsyunVvOD59S3Iw==
X-Received: by 2002:a02:a809:0:b0:339:e6ba:dee1 with SMTP id f9-20020a02a809000000b00339e6badee1mr2730125jaj.1.1657301417200;
        Fri, 08 Jul 2022 10:30:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a70-20020a021649000000b0033cd0f5cb36sm11887822jaa.173.2022.07.08.10.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 10:30:16 -0700 (PDT)
Subject: Re: [PATCH 08/12] kunit: test.h: fix a kernel-doc markup
To:     David Gow <davidgow@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1656759988.git.mchehab@kernel.org>
 <32a67e9ee77cc6c435d08a2cb5ef12559b417fee.1656759989.git.mchehab@kernel.org>
 <CABVgOS=W2mPts5uZci3cH7sRetz8ye46THU5U51+roQhuvTfqw@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fcdfd43a-207a-7008-6931-34061c1682b5@linuxfoundation.org>
Date:   Fri, 8 Jul 2022 11:30:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABVgOS=W2mPts5uZci3cH7sRetz8ye46THU5U51+roQhuvTfqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/2/22 7:18 AM, David Gow wrote:
> On Sat, Jul 2, 2022 at 7:07 PM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>>
>> Fix this kernel-doc warning:
>>
>>          Documentation/dev-tools/kunit/api/test:9: ./include/kunit/test.h:323: WARNING: Inline interpreted text or phrase reference start-string without end-string.
>>
>> Functions should use func_name() on kernel-doc markups, as
>> documented at:
>>          Documentation/doc-guide/kernel-doc.rst
>>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>> ---
>>
>> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
>> See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/
>>
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> FYI, this is identical to:
> https://lore.kernel.org/all/20220702051205.3292468-1-davidgow@google.com/
> 
> It doesn't matter which one goes through, so if this patch is applied
> (e.g. to the docs tree as a part of this series), I'll make sure the
> other one doesn't end up in the KUnit tree.
> 
> Cheers,
> -- David
> 

Applied this now to linux-kselftest kunit branch for 5.20-rc1

thanks,
-- Shuah

