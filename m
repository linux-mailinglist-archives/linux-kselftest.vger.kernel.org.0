Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F6F598B00
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 20:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbiHRSU4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 14:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiHRSUz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 14:20:55 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00CECE317;
        Thu, 18 Aug 2022 11:20:54 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id q190so2307154vsb.7;
        Thu, 18 Aug 2022 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:reply-to:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=lMF2ztp3tPvmby8RlqQj2pCwCgvYCLFHjZJy/lMPygI=;
        b=F+V9f9AfmeMaTMaR6bbmTZRw7iJsPm6daOVlefQqb8iDYLt19HnlWEqxmP6oZsbVrO
         VpWYs6iV+IuE3juZKHOvAKL4sT9ebM5eyBMnC9n1SZScDFVGW+4gn5RdXUvMpvIuuQQT
         1NvnE310e1UDeYdaslidCU35zwVLaLoJLIqkIapWSTvDdkGdVXnjq3rJMLYeqmBhqeBm
         tlEIEHOTDgJTgQRy0ACxXUFXYBXrVIaW8gpTMorWg/yHuz4MZK/H98V8aMxkWuv/Hx44
         vRc9CsF08kgPYh6zBTbMRoKQ1r50I+LH9Xf0rFjkm3XauuNgluEft5t2MBybDfqm0xO7
         xPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:reply-to:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lMF2ztp3tPvmby8RlqQj2pCwCgvYCLFHjZJy/lMPygI=;
        b=NtFjuNSWRsHv8KmFwNzQzDMBVBvbwnmOtg5Ir9gBIRVSxP2CedRZhlh47we+wQVGIc
         XiXLr9MwpEATgv1DFFHQ1xUI8j9R5YpFgopf9PURm23ok7bJl4zVtBMtEjDlKcHyzoG8
         pc9h0M4zlvY8BteGelXIS7pkq+8kA6Cg37pVjpgu4knHpmyZNs4GL/8HmAQhUPk17fyA
         eHbDal6nuJ3gd9KcdjyR4dBG1baa1iUlilMJbfs0G1/DgVxKVvNjb9QYPZwk9utggsuo
         gVHwZrldOYFLmKa6oRQztwW6554MvvaCJ5p0UwwCAsMsmroOOuj3ydgnN5nEHX1pd9rK
         djlQ==
X-Gm-Message-State: ACgBeo27BIWfUyXTi6ilFDFiQPX3NNPxX2ZrTVUO39jwWV2ooPrqie2B
        I1TvqlhNRL5fM1bMcO5McHk=
X-Google-Smtp-Source: AA6agR7pHn9a5z1VdEGpR+unUU53VkoOXBQlOhLjONOkYOp2+qLbnAk6K7e214bOfFMokyobiK3qzA==
X-Received: by 2002:a67:b003:0:b0:35a:1d46:16d with SMTP id z3-20020a67b003000000b0035a1d46016dmr1659968vse.21.1660846853933;
        Thu, 18 Aug 2022 11:20:53 -0700 (PDT)
Received: from ?IPV6:2804:14c:4c2:8202::1001? ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id e21-20020a67eb95000000b0038dee4ac58csm1156087vso.25.2022.08.18.11.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 11:20:53 -0700 (PDT)
Message-ID: <03535c9e-d3e7-eeca-2650-2ecf7ab4c34e@gmail.com>
Date:   Thu, 18 Aug 2022 15:20:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/4] Documentation: KUnit: minor fixes
Content-Language: en-US
To:     Sadiya Kazi <sadiyakazi@google.com>,
        David Gow <davidgow@google.com>
Cc:     Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        brendanhiggins@google.com, corbet@lwn.net
References: <20220813042055.136832-1-tales.aparecida@gmail.com>
Reply-To: 20220813042055.136832-1-tales.aparecida@gmail.com
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
In-Reply-To: <20220813042055.136832-1-tales.aparecida@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/08/2022 01:20, Tales Aparecida wrote:
> Hi,
> 
> This is a short series of minor fixes to the Kunit documentation,
> they probably can be squashed but I suppose it's easier
> to review them individually.
> 
> Thanks for any feedbacks,
> Tales
> 
> Tales Aparecida (4):
>    Documentation: kunit: fix trivial typo
>    Documentation: Kunit: Fix inconsistent titles
>    Documentation: KUnit: Fix non-uml anchor
>    Documentation: Kunit: Add ref for other kinds of tests
> 
>   Documentation/dev-tools/kunit/architecture.rst | 4 ++--
>   Documentation/dev-tools/kunit/faq.rst          | 8 +++++---
>   Documentation/dev-tools/kunit/index.rst        | 2 ++
>   Documentation/dev-tools/kunit/run_wrapper.rst  | 4 +++-
>   Documentation/dev-tools/kunit/usage.rst        | 4 ++--
>   5 files changed, 14 insertions(+), 8 deletions(-)
> 

Hello,

Thanks for the reviews, everyone!
Should I send a V2 with squashed commits or will a committer handle that?

Kind regards,
Tales
