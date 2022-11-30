Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A496063D03E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 09:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiK3IST (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 03:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiK3ISI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 03:18:08 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE8150D7C;
        Wed, 30 Nov 2022 00:18:07 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d6so15935830pll.7;
        Wed, 30 Nov 2022 00:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9sMTxC8II1dCsJCjBXb3maOeenY72L6eiTYH4CMWYE=;
        b=fNgVyKAMXNAgexRoxHMRD+C1AHD6NkAy6KFbRWt6SZIG5ws1j7R+eLixqtGrT4xKE/
         W7vfxb9XHXyAfxQqASunsEyugTX7odam4s6e0ZWxIg/hOGR6PmMmn8VLelTV2Qzac1cp
         ivpV6fJYwu694O5BzNGAl/KA7Pj+H0B41r8u8gmCZhkai003PYQiefdjgyzRq/SAJVF/
         iAahRhQ44EuXtk9GSp4mckaFF4x3gg3nkpYYg0HOBSG0fARKlvE60H0IgEbtNiKq/Flt
         cvgAI//RIwx6P5YshrBQ69ZNIWUGzJ7P84hKJYDIyedlUURsLWG4EiEGBhJpz2hUHWrG
         v46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9sMTxC8II1dCsJCjBXb3maOeenY72L6eiTYH4CMWYE=;
        b=yVMv9CfeN/O6n2RZ/LCIRDuYC4BMjcl3uwf3nTr/7eRs0T81f5x0pdgKg8oVlWHi0c
         G4y+iDeuHdnnv/CrwOMrWdfIwklee1EM0NqC4ghtfYN8Rs9WnRzlYVJblEDKAmbeljFv
         PcYK+5FSXPaYzbZut+b6J3bHR+hzSn3F+ZWh57SkR0MnYTRKzjEiIx+L8/qmcskXDGkP
         0DzWe7R25TnyZBb8KKuPfQ9rpKOmJeiKlO1qhoJr+jY/NX+nniC/jMrwlKD+SeJCvj2l
         hnQI3yzNMSOka1mfHAMcEgf6ILzF4fM19yz0CHjyoRLL5GPddNvRLctziNNM3Izjw4PZ
         VyOg==
X-Gm-Message-State: ANoB5pnRxQ6p3CSyxqJwbKJaR0ZbM2TrYV3yuNe8s/kNosVBR6UJh02T
        LFqL6pSVBXlsFt7e5XXK354xYoV+2fs=
X-Google-Smtp-Source: AA0mqf77narn1YWb6xAoj/for2X8JOJ/M+lM6+Re/861YZHQGTtKuHYCAQX8dt3geaBfwKbitnVLxg==
X-Received: by 2002:a17:902:82c2:b0:189:a208:d124 with SMTP id u2-20020a17090282c200b00189a208d124mr4820626plz.143.1669796287104;
        Wed, 30 Nov 2022 00:18:07 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id z30-20020aa7991e000000b0056da2bf607csm780533pff.214.2022.11.30.00.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:18:06 -0800 (PST)
Message-ID: <cfa439e1-e216-8285-8283-1664453ac337@gmail.com>
Date:   Wed, 30 Nov 2022 15:18:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Documentation: kunit: Fix "How Do I Use This" / "Next
 Steps" sections
To:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Sadiya Kazi <sadiyakazi@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221129094732.306449-1-davidgow@google.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221129094732.306449-1-davidgow@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/29/22 16:47, David Gow wrote:
> The 'index' and 'start' pages end with very similar "How Do I Use This"
> / "Next Steps" sections respectively, which link to the other
> documentation pages. This wasn't updated when the tips.rst page was
> removed.
> 
> Remove the reference to tips.rst, as well as tidy up the descriptions on
> all of the links (especially given that sphinx gives the page titles
> anyway.
> 

While this patch is LGTM, what about simply drop these sections and
replace with "see the sidebar for other KUnit documentations"?

-- 
An old man doll... just what I always wanted! - Clara

