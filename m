Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5BF4EB0D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 17:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238826AbiC2PjC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 11:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbiC2PjB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 11:39:01 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BA423EC70
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 08:37:18 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id x4so21413473iop.7
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gLd51ggOlUdHIwZ00EZlLb4mWuNUvjnU3+SzIZdxmOk=;
        b=K57WW/FddBde/rRXMUA9BaYE3N0lAuDneUX1KCIBFxf4CXh4Z4eKQOUqC788YMGaXX
         MQF7yOu4tf8KM9LcmtcceBE2QTiyQQM/8vESJFK5zLjXOr7BViiSBXqZ/+143NMwIIdc
         orlNUiAl/hdFW4dDa9vE//ejvyaewYcHdewJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gLd51ggOlUdHIwZ00EZlLb4mWuNUvjnU3+SzIZdxmOk=;
        b=THNdAzLilrVE/yJRfA/yfSyilYURHbSrl3b329mszwabYnypycY1PL19sMm031YhNd
         70psjC2/Kr53PnR9eSvQR2v/Ry3EfO3QzItCGcRcpo5TzMHnpXFT0IBpvV4xkZVZRDTV
         1WeJAXUW3QNLl3TJe6yFTxb+yac0eLyxJ8nG+sShIKl0T2Q/13Vq3xalz0FlLCTbuKkO
         9ITXVlO4eIw/Kj8RKLIpBZPw897ve/4vGar/5jOQx3qZOIojRL0BCRJ3IG1w4dPmVD2d
         yXGtqiNB6glQz6ThAt8i3CwEf//SXT81IIRzbjKwHOJAnqj5Fi/q6xB3NOXxXJL4NFmP
         hH9Q==
X-Gm-Message-State: AOAM533FugnhYry2Sq5OXVzZg4ow99z6zL44CvXuLZHXewFF/lZrs5C/
        9CoKPUpeUsDfM90ngPhR7DhDAzqkseOa+w==
X-Google-Smtp-Source: ABdhPJwCzXCHjBRdz35SXshxWvTj2yFFE0frjiP5HGkRVMCtMtFRNLjnUjRXfQCtSR1PiZiMusPBYg==
X-Received: by 2002:a6b:400b:0:b0:64c:77aa:40a6 with SMTP id k11-20020a6b400b000000b0064c77aa40a6mr5480515ioa.101.1648568237910;
        Tue, 29 Mar 2022 08:37:17 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id f20-20020a6be814000000b00649d9a4db2asm9706513ioh.27.2022.03.29.08.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:37:17 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] selftests/resctrl: Print a message if the result
 of MBM&CMT tests is failed on Intel CPU
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220323080928.1586408-1-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1920a6b6-bc1b-31db-4c1b-efccc189daa5@linuxfoundation.org>
Date:   Tue, 29 Mar 2022 09:37:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220323080928.1586408-1-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/23/22 2:09 AM, Shaopeng Tan wrote:
> Hello,
> 
> The aim of this series is to print a message to let users know a possible
> cause of failure, if the result of MBM&CMT tests is failed on Intel CPU.
> In order to detect Intel vendor, I extended AMD vendor detect function.
> 
> Difference from v4:
> - Fixed the typos.
> - Changed "get_vendor() != ARCH_AMD" to "get_vendor() == ARCH_INTEL".
> - Reorder the declarations based on line length from longest to shortest.
> https://lore.kernel.org/lkml/20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com/ [PATCH v4]
> 
> This patch series is based on v5.17.
> 
> Shaopeng Tan (2):
>    selftests/resctrl: Extend CPU vendor detection
>    selftests/resctrl: Print a message if the result of MBM&CMT tests is
>      failed on Intel CPU
> 
>   tools/testing/selftests/resctrl/cat_test.c    |  2 +-
>   tools/testing/selftests/resctrl/resctrl.h     |  5 ++-
>   .../testing/selftests/resctrl/resctrl_tests.c | 45 +++++++++++++------
>   tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
>   4 files changed, 37 insertions(+), 17 deletions(-)
> 

I can queue this up for Linux 5.18-rc2. Thanks for fixing the error
path with clear messages for failures.

thanks,
-- Shuah
