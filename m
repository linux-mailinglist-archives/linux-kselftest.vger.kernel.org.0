Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDC75B0F71
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 23:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiIGVsJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 17:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiIGVsI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 17:48:08 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB6F8053D
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Sep 2022 14:48:06 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y187so12665585iof.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Sep 2022 14:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fAydycLqaO3jFV4fR1Wdk90vSWTWgJ5zAjLFA3gPnS4=;
        b=EvOQg/vkoBaEeRbDpRcJ62gD/W0ariid7C2Kx4wFueOXvuWEZBlUPUiHwQwwmPtgUJ
         3I+4j4qethB3P6HkollfLox3XCM1XHq1frRCEMs1o5zoBx7N/GBK2i4IjdZTLOkn4Gvf
         2ifFGvGAxj9Pkb7OfbQpOzitYTOyETsNHBadY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fAydycLqaO3jFV4fR1Wdk90vSWTWgJ5zAjLFA3gPnS4=;
        b=zDzGOPhPKow2JWGlxe2jwRubHD0nWa2j1TvCFPFqNtxtfPyarpCRb8Je93MsBqdGRb
         2PcpBExgP3Xm2dFAz1pQxKX5n1isPzf+wfENSgBGImd1kSihcV6PQBGQ3eN0nyS7ZQUN
         Xy103MkRDqPkZO0M3Q9l8Hb8qJNrUUnU/EOq9/CvwMaX8nuW19AmrdrrpQdd2BP+/t7j
         nled1YBvPYAcvLHp6NdnlYGx5FaDifmZAJvs69Wieks5uxvfWyEcvEqNdPaEW54OxiBQ
         HzdAiRk/ED02sdFIgoO9aE0APnnqO4c5swncVSlvvgoWPx20OIlMHMhDbya8CKeq/iLp
         Gqpg==
X-Gm-Message-State: ACgBeo17gWP23duc+ww8lNbNP2aStiNsBeNFpxn0Rp2TNuqcGdVFFC5a
        kcB2y7XvZ0dFJbkrcSngrJKDtg==
X-Google-Smtp-Source: AA6agR54ZY7lzCC7n0WJ8yS9srIyKejGgGJKAmWxRhvwYxC+sOWzorjp56lg2g3iig2QiHW7EaTjBQ==
X-Received: by 2002:a05:6638:38a9:b0:34e:932f:d37d with SMTP id b41-20020a05663838a900b0034e932fd37dmr3057757jav.285.1662587286263;
        Wed, 07 Sep 2022 14:48:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n29-20020a02a19d000000b0034a56f2f120sm7576174jah.155.2022.09.07.14.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 14:48:05 -0700 (PDT)
Message-ID: <4c16c943-3768-9430-c82e-00563607fe89@linuxfoundation.org>
Date:   Wed, 7 Sep 2022 15:48:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next v3 0/5] Optimize and bugfix for cpu-on-off-test.sh
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, akpm@linux-foundation.org,
        akinobu.mita@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220905133615.139026-1-zhaogongyi@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220905133615.139026-1-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/5/22 07:36, Zhao Gongyi wrote:
> 1. Correct log info
> 2. Replace exit with return to make the test exit gracefully
> 3. Delete fault injection related code
> 4. Reserve one cpu online when the test offline all cpus
> 5. Add log info when run full test successfully
> 
> Changes in v3:
>    - Remove config file for patch 2
>    - Update information of cover letter
> 

Thank you fixing the issues in v2. Now applied to linux-kselftest next

thanks,
-- Shuah
