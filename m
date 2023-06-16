Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804B4733AA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 22:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjFPUQL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jun 2023 16:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjFPUQK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jun 2023 16:16:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A93A89
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jun 2023 13:16:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30fb7be435dso871420f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jun 2023 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686946566; x=1689538566;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vPnF45lwmBQE4hlXIcf9QZ1ECe0DnRUytPjxgA+AQk=;
        b=sUGdkeuqPEE2kSpld6ncDRKJ6+AC1LNRuuN0SYX3zIXn54/gPZRGJRLMaMUDKYm7Dq
         Qm3lBulGHA0F0NePogIXO0LKEZ30+KHhr20mDtez/n3mWueIXFuWsSbbuWx1YTiiY0NG
         3bSqVkHI2ySmGrlsHwmD7PTAzYSeUCe4MLJI2dztws7394v4C42As2HtiQK4a9FIVbyz
         1QZyAgkkZCltHOAL34PwIo4YsYIZ3qNkHPrbqpRu/I6CEkng4oXjsMbIekaDZP9ex81U
         otgJ8MOy7oim5IqIkFVGaS5ka8jw1bZPHYrYsFM8mrh2Lettv0SZrfPmzQzcQ2LRkpe8
         bg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686946566; x=1689538566;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vPnF45lwmBQE4hlXIcf9QZ1ECe0DnRUytPjxgA+AQk=;
        b=G4F1LOL5RpXg2LvylP+qszWKSsbKKzE85h6cI3XUwk4jgrRVkZSmQUygpbH6uIufBY
         hvKD/vggK8DloErqXXKHXWc4qknAHJy+6tlBOIvQFRy08b8VLNGphvklx0tLcg2H7fXA
         GCSz3CQY31w3QTIYPe0hEs8a6tldyyCZrv8QwQkDxEbUlPC87Bl486jWVSLUV941ZJOW
         tPfwk+VdLP9qNzz7+4zIeacMCokRwYkL5oM+PPu/bOZKlxR+r5gNbo8e/ht1Z4iN8q28
         kwQTQSupVo1U9BkyHs7H/wsiJ4cZRcWAJBWzIH9fd797cRsnAM+UcFDMDOXFXE4zuzHQ
         un0Q==
X-Gm-Message-State: AC+VfDzfbi8jpnN/pLT69ByoL31ZfiBLeVmyZetfU2x4iffOZNAF7ALs
        FriejOtsHfoLNUa0f2xxarcGBA==
X-Google-Smtp-Source: ACHHUZ5OzMuNb5xcKMSIbAKpHDQpCrRDCcux6ViOZUhjyjCD5lDQKaAxLzKc4F9Z03JahPsdXu/s/g==
X-Received: by 2002:adf:fe11:0:b0:30f:cc8f:e48c with SMTP id n17-20020adffe11000000b0030fcc8fe48cmr2182422wrr.25.1686946566146;
        Fri, 16 Jun 2023 13:16:06 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a4fb:308c:d9af:9b31? ([2a02:578:8593:1200:a4fb:308c:d9af:9b31])
        by smtp.gmail.com with ESMTPSA id v18-20020adfebd2000000b0030789698eebsm24445924wrn.89.2023.06.16.13.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 13:16:05 -0700 (PDT)
Message-ID: <83e6e41e-f665-0923-c723-be318987816c@tessares.net>
Date:   Fri, 16 Jun 2023 22:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 4/4] selftests: net: fcnal-test: check if FIPS mode is
 enabled: manual merge
Content-Language: en-GB
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Jakub Kicinski <kuba@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        shuah@kernel.org, dsahern@gmail.com, andrei.gherzan@canonical.com,
        netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Magali Lemes <magali.lemes@canonical.com>,
        Guillaume Nault <gnault@redhat.com>
References: <20230613123222.631897-1-magali.lemes@canonical.com>
 <20230613123222.631897-5-magali.lemes@canonical.com>
 <5007b52c-dd16-dbf6-8d64-b9701bfa498b@tessares.net>
In-Reply-To: <5007b52c-dd16-dbf6-8d64-b9701bfa498b@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jakub, Stephen,

On 16/06/2023 21:33, Matthieu Baerts wrote:
> Hi Magali,
> 
> On 13/06/2023 14:32, Magali Lemes wrote:
>> There are some MD5 tests which fail when the kernel is in FIPS mode,
>> since MD5 is not FIPS compliant. Add a check and only run those tests
>> if FIPS mode is not enabled.
>>
>> Fixes: f0bee1ebb5594 ("fcnal-test: Add TCP MD5 tests")
>> Fixes: 5cad8bce26e01 ("fcnal-test: Add TCP MD5 tests for VRF")
>> Reviewed-by: David Ahern <dsahern@kernel.org>
>> Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
> 
> Thank you for your patch!
> 
> FYI, we got a small conflict when merging 'net' in 'net-next' in the
> MPTCP tree due to this patch applied in 'net':

Just in case, I'm starting to publish the Git rerere resolutions for the
conflicts we have when syncing the MPTCP trees with Netdev's "net" and
"net-next" trees. They are available there:

  https://github.com/multipath-tcp/mptcp-upstream-rr-cache

For this specific conflict, the new files are available there:

  https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/5091dd

Don't hesitate to tell me if I need to change anything to this repo.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
