Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCFD6C99A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 04:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjC0Cod (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 22:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjC0Cod (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 22:44:33 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D08F44B1;
        Sun, 26 Mar 2023 19:44:32 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17ab3a48158so7843614fac.1;
        Sun, 26 Mar 2023 19:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679885071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/IehCeOspUlraWZ1AW390EFHJWuA8vsflh6eGOs0IcA=;
        b=BbckQad35hdIB9AdNC5ttGTvQW6Ag3M3+i/mD07LFEO0/0OG5KtWfja/NltAxlqblv
         W92Ozr9ODRVfHcOKuSZFQOVApstuOaJaf1jfJ2Lb64GtA5L8Zs8Ncwz+ZzsvXcEaf9xQ
         1O9LmIc5OyhrV6BFndIQzeXEsoOw4wst4uSqrcBB2hyi3vtYpe9ZVlgK3kkFMoItAtXn
         nvx6hdyvAmpXTM8c/4eqqzuqC/nQAqSoRHvc+LVCw5YsKeqfUwGZJhDPbPqkdim9W6RY
         3/3eA9eY7BTV6QZ1PpgZ6vQXSiVkIwJhgicoiU2WbmnsJ1Uwc4U1WbcczpXFcXMPXnzw
         8otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679885072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IehCeOspUlraWZ1AW390EFHJWuA8vsflh6eGOs0IcA=;
        b=lv9aPTlO1IBbFr7R9krKvRsqzwHLwLJ+mXP11socjR2o/fRwHgl+hslsEZLfFQm0l4
         9XzwVSkF+kSY79OoScJWe4TkziaSuRw/EDP3zu20GbIDzvEH783KWhs0H8mKUMfAj0mh
         782OYd/vk4YnIM4lga1+72UPE601wuSpOfcvSM9sxwkKLgUxsyWNaVGFwmeXm3yy/VcW
         VbXZf4kqWXz0a3O1ya2Lf5qysoJCdgmH2aPehgtzfccHVsiVefausqIcE3+USzJ3NPDj
         c/B+YaYldFj2Q6O5HAkJLMG61d+Brhje2e+uSux2c2u5s33BDvJqQVImr3B+sPKelbS0
         MJHA==
X-Gm-Message-State: AO0yUKWRbeLnb91bFQG8H6cPauM3NamIlfWTdz7iEwRAU8uBZDanVprr
        0H67QfC0+TXsDr1y1QxYiJc=
X-Google-Smtp-Source: AKy350bKgFENzE6qQyN7mlnvfyBQfZAEoRGTFjt+++dpuLKoa54K7yO5TvsNKRANtW4od3i3j1/FfQ==
X-Received: by 2002:a05:6870:3396:b0:17e:8ac6:5399 with SMTP id w22-20020a056870339600b0017e8ac65399mr7726353oae.0.1679885071798;
        Sun, 26 Mar 2023 19:44:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:988b:7dda:764e:c744? ([2600:1700:2442:6db0:988b:7dda:764e:c744])
        by smtp.gmail.com with ESMTPSA id vh22-20020a0568710d1600b00177c21c3ae1sm9429423oab.54.2023.03.26.19.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 19:44:31 -0700 (PDT)
Message-ID: <3a4ed4a0-5694-ba59-a141-26e37576ff67@gmail.com>
Date:   Sun, 26 Mar 2023 21:44:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [KTAP V2 PATCH] ktap_v2: add recognized test name line
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>, Rae Moar <rmoar@google.com>
Cc:     davidgow@google.com, skhan@linuxfoundation.org,
        keescook@chromium.org, Tim.Bird@sony.com,
        brendanhiggins@google.com, corbet@lwn.net,
        guillaume.tucker@collabora.com, kernelci@lists.linux.dev,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316225915.494688-1-rmoar@google.com>
 <CAGS_qxp2u3F4abmYgN+XwCG8CJN37NSqWSC===SWLCjZG8HYBw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAGS_qxp2u3F4abmYgN+XwCG8CJN37NSqWSC===SWLCjZG8HYBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/20/23 14:21, Daniel Latypov wrote:
> On Thu, Mar 16, 2023 at 3:59 PM Rae Moar <rmoar@google.com> wrote:
>>
>> Add recognition of the test name line ("# Subtest: <name>") to the KTAP v2
>> spec.
>>
>> The purpose of this line is to declare the name of a test before its
>> results. This functionality is especially useful when trying to parse test
>> results incrementally and when interpretting results after a crash.
>>
>> This line is already compliant with KTAP v1 as it is interpretted as a
> 
> minor nit for if there's a v2, s/interprett/interpret (here and above)
> 
> Also, I want to elaborate on the previous paragraph a bit more, in
> case the motivation isn't clear.
> The problem with TAP and KTAP as-is is that the name of a test case is
> only known *after* it completes.
> 
> So the scenario being referred to is
> 
> KTAP version 1
> 1..1
> <lots of output>
> <kernel crash, no more output>
> 
> It would be nice if parsers could report "test FOO caused a crash" as
> opposed to "the first test case caused a crash, good luck figuring out
> which one that was"
> 
> Daniel

It would be useful to take some of the motivation explanation from TAP14,
which says (everything to the end of this email):

Commented Subtests are encouraged, as they provide the following benefits:

Easier for humans to read. For example:

  TAP version 14
              1..1
              ok 1 - hmm, what level is this?
vs:

  TAP version 14
  # Subtest: level 1
      # Subtest: level 2
          # Subtest: level 3
              1..1
              ok 1 - clearly level 3

Additional strictness around matching the Test Point description to Subtest Name can catch errors and detect accidentally interleaved output.
