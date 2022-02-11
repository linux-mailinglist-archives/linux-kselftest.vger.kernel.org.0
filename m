Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEC84B2B74
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 18:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbiBKRMA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 12:12:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347532AbiBKRMA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 12:12:00 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5AA21F
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 09:11:58 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id m8so7350778ilg.7
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 09:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zjkXwvtCBDId5CtC4jr5PHJd1ckKx2uKu+NSVsZGKoU=;
        b=dReCiEKgX9kIOa267yo4luUrFq2PdntGD/NuFxdqnAErdYhsQzIpRqQfeIawfY/8FI
         Vbj/1gorL0l3SE73ULO+qVu1Z9KYe0T1BlAddLSExUCPv9m6QtJK1EIhMlixBaKDMnX2
         EQY7b6M2ZpxEvwRRIXJ70DpWvA4HvRUiOu1Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zjkXwvtCBDId5CtC4jr5PHJd1ckKx2uKu+NSVsZGKoU=;
        b=J/zJVwMg2rO8b4yDScQEeGvR6qnfdTgcottJ62koLwVzRVpAEM5On23GHRG9x0TQOa
         jG3sOY/Zjy8k2M0k2J03LSoE6fO15BtCIfWG0UMTaKqPebzc+oNvui60Vud4KVRnionk
         dOlUJ4Q0KLWGLKv4bSDfnXahzrUO6ZsC809beevM2DTLNHmNAGIGZmDiuvfGrZ3LjlxV
         Nne9B26GimUXPeUDy9Dxm5ejZZQTi1DbhgKKnLgfWqCP54SBsI8+oAmrNklTbbhpzKF9
         VNrWW0ENV5ffCAfucabwufZ+y3Tv87OsoCK0S2MtG1yGxyLYDNiyFR0URSUHcVcV/PEV
         0CSA==
X-Gm-Message-State: AOAM530AFSLQaiQFRxoLIZWaIMgtbReRd/C3vFciGOdGFpXkgL/tn6Sy
        pvw67etqxz36JJRUJg7HKYrKmg==
X-Google-Smtp-Source: ABdhPJy2keANu+GgfebUDtlUmddy8XYQuxvuMxp/ogCEVf9YPKwhW+PnqNnYu4a+JgLRJis//PxEMA==
X-Received: by 2002:a05:6e02:b25:: with SMTP id e5mr1385991ilu.125.1644599518163;
        Fri, 11 Feb 2022 09:11:58 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id s10sm12724274ild.84.2022.02.11.09.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:11:57 -0800 (PST)
Subject: Re: [PATCH] dma-mapping: benchmark: Extract a common header file for
 map_benchmark definition
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "hch@lst.de" <hch@lst.de>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220211031441.41126-1-tiantao6@hisilicon.com>
 <d3dd5f61efcb41c981b0971e128da907@hisilicon.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <39bd03ff-d083-5f81-d7d0-f40043cc47a5@linuxfoundation.org>
Date:   Fri, 11 Feb 2022 10:11:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d3dd5f61efcb41c981b0971e128da907@hisilicon.com>
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

On 2/10/22 9:22 PM, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: tiantao (H)
>> Sent: Friday, February 11, 2022 4:15 PM
>> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; shuah@kernel.org;
>> chenxiang (M) <chenxiang66@hisilicon.com>
>> Cc: iommu@lists.linux-foundation.org; linux-kselftest@vger.kernel.org;
>> linuxarm@openeuler.org
>> Subject: [PATCH] dma-mapping: benchmark: Extract a common header file for
>> map_benchmark definition
>>
>> kernel/dma/map_benchmark.c and selftests/dma/dma_map_benchmark.c
>> have duplicate map_benchmark definitions, which tends to lead to
>> inconsistent changes to map_benchmark on both sides, extract a
>> common header file to avoid this problem.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> 
> +To: Christoph
> 
> Looks like a right cleanup. This will help decrease the maintain
> overhead in the future. Other similar selftests tools are also
> doing this.
> 
> Acked-by: Barry Song <song.bao.hua@hisilicon.com>
> 

+1 on this cleanup making this code maintainable. We are moving in
the direction of cleaning up defines in selftests for the same
reason.

Let's just make sure this works on older kernels. We do support
mainline kselftest on stable releases. With that:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



