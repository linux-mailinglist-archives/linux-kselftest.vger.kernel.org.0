Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA60754294
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjGNScP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 14:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjGNScP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 14:32:15 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F161BEB
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 11:32:14 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id ca18e2360f4ac-780c89d1998so15686839f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689359533; x=1689964333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GF9dxYmTKLCibQL0gaUTB656F1NwxzcFLCOBufgxglA=;
        b=gKl4JVnWhTJ76Q/j3ve9vyymrgvI6He02kkUFiTmnCkjGxfDD1Mu8NYvTioELhpRiy
         p/VUthXd305fLUNeZHbli6+2mtM+LBMGc6Jd0D1d7qG6YMBAucSD/HjkbIy9dwMEL1lk
         mgM69k8AmICvqQsRi40mtUl3fS5K/mnY4hC0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689359533; x=1689964333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GF9dxYmTKLCibQL0gaUTB656F1NwxzcFLCOBufgxglA=;
        b=g1hfvb7a0uP8DYdtri2uisg0Dk93Ni3zqVpCRVVQIvKCI5+pR9mToA2ksIdaAb8bbU
         SeRONKYYVq+b4o7kVDO4zopF9dX5oo73IYuvGcCT+HuwS/XUcigwspM798+uYl9lWjbk
         Xq4FxIYtQyJQK5yIen/N6YmPEJBYIRfzHusUDBTBSsBWUp22NTm+jNAs2R3D1Dk0bek+
         Bc5NS93aI2EfSnWVDLdjd8OXjVNAwhOm27v6SYAPBUYmCkuCLkN64knfOtwXqL7RUrve
         bjJLLmPV/ZZfbB25iNGu81sOg3QaTCCkwRIzfEK8B2SXch0vzutRiO4hIN3GFzI114Fe
         w7eQ==
X-Gm-Message-State: ABy/qLZU3Gob8oM+yeT9ZvzJvXHICNNangJiH0h8LLTaJR1pa/rw5wg5
        qT0wzHoDewHgTPUzN723mPoAmA==
X-Google-Smtp-Source: APBJJlF6Nt2Zm02mG5/V6CzylthrPYMi1fA0HXqn3sK9D+yzHDeVT+7dzqeCqiZptWWY4LNHXGub2g==
X-Received: by 2002:a05:6602:4887:b0:780:c6bb:ad8d with SMTP id ee7-20020a056602488700b00780c6bbad8dmr26373iob.0.1689359533671;
        Fri, 14 Jul 2023 11:32:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c21-20020a056602335500b0078702f4894asm2863647ioz.9.2023.07.14.11.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 11:32:12 -0700 (PDT)
Message-ID: <68ccfd77-ce2f-857a-37a7-e9b3edcd495d@linuxfoundation.org>
Date:   Fri, 14 Jul 2023 12:32:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
 <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
 <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
 <421bebb3-19e9-47a7-8b2b-f69f125df22f@sirena.org.uk>
 <f479b731-7782-0417-2d4c-31a7c3c9491c@nvidia.com>
 <20230714112653.0b42d3c9818b038d219b5e41@linux-foundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230714112653.0b42d3c9818b038d219b5e41@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/14/23 12:26, Andrew Morton wrote:
> On Fri, 14 Jul 2023 11:19:11 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
> 
>> On 7/14/23 11:09, Mark Brown wrote:
>>> On Fri, Jul 14, 2023 at 11:48:51AM -0600, Shuah Khan wrote:
>>>> On 7/13/23 14:16, John Hubbard wrote:
>>>
>>>>> Actually, I was hoping that my two fixes [1], [2] could be used, instead
>>>>> of reverting the feature.
>>>
>>>> Mark! Are you good with taking these two - do these fix the
>>>> problems you are seeing?
>>>
>>> I reviewed the one that's relevant to me already, the arm64 one, I'd not
>>> seen or tested the RISC-V one but that looks fine too.  I'm pretty sure
>>
>> That riscv patch already has a Tested-by from Alexandre Ghiti:
>>
>> https://lore.kernel.org/f903634d-851f-af64-8d9a-6b13d813587c@ghiti.fr
>>
>>
>>> Andrew queued it already though ICBW.  Either way it'd be good to get
>>> this into -rc2, this is seriously disrupting arm64 CI and I'm guessing
>>> the RISC-V CI too.
>>
> 
> I just dropped
> selftests-arm64-fix-build-failure-during-the-emit_tests-step.patch and
> selftests-fix-arm64-test-installation.patch, as Shuah is merging them.
> 
> This is all rather confusing.  Perhaps a full resend of everything will
> help.  I'll assume that Shuah will be handling them.

Yes. Andrew - I am applying both as we speak. I found the right versions
with Tested-by tags.

These will appear very soon in linux-kselftest fixes and I will send
pull request for rc2.

thanks,
-- Shuah
