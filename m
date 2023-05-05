Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0C6F7B6A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 May 2023 05:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEEDVM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 May 2023 23:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEEDVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 May 2023 23:21:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D49F8A4E
        for <linux-kselftest@vger.kernel.org>; Thu,  4 May 2023 20:20:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so1431262b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 May 2023 20:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683256843; x=1685848843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uab202Dnn1eDz/nkCMc9/SGSJeF/RNG3IPLG0FHPpw8=;
        b=YCMjZUIiDAdnuEBEXUnQSQDHdx4wWbeCnwCDg8iLh9HUR7ntN9nch50UknFKVbzOiD
         kckoNO9AJgAY4kVvTE2rcpTBWfZK1Z2/dXW7GSprkY/xxEpGaAyioyoHsGKG4nCrtgqg
         8YPZRvyrNlh9KKKjazPvJEeRxzF2J2S9WLH02PRzpltcDm+i0zE6u5f6PRZFep09No5a
         L45aZEHjZM7iDzi+EY+aHX/vzTYIv5gQrM8OjMCRiErzop2frYe1QpFdFzSXD/7mPdYP
         g1Cqwh+dfaYBl6sJHM30I0mdv2qAYE1p30VqXOEhj04fFQyIar5pYexfGu8qLZi579vL
         MiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683256843; x=1685848843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uab202Dnn1eDz/nkCMc9/SGSJeF/RNG3IPLG0FHPpw8=;
        b=mDSdKauNyZF444GNlI7K3UEeqUJjr25J5HX7qukEX5vYuWy3B1X6CMeGwMBGhOkyiZ
         3546YcBvPSAbuD38cihnCUgmynAJkokTVSZSD62p3mSp+L6OSL2eHE688CdTiUrKO6Bi
         xjp6vnWaO94v/Xr8+h4eAtmqT0kdACZFJjr89yX4Actyn4xeDJ29uANw08xyKuq6E36p
         m1kux0WYfbxGHFTtI7zDNZRnGwabxu6uiygy8YqzyO2sL8a1KW9gyLPTQvy3DVByA4J+
         UbR3RNYkuG5YhFfudZw20jN8EnHJQijjpHWhEKA60Z8ak7+HXvuuVTadenDQVKJW6kix
         h+Jw==
X-Gm-Message-State: AC+VfDy4AkXOA05iqb+FFaMYeE2Mz6Y5p0InjGkI9sB0GwwDiVcgwxMA
        R9Mqx2PhMNUU88aS787uV9RIlA==
X-Google-Smtp-Source: ACHHUZ53rIrj3+Txx+pQYi8n4x9Lolh+e+lbTw2OhE8kPCx9X7XF68GeoKW0zb+xh+zhbNBkTcXgKg==
X-Received: by 2002:a05:6a00:1346:b0:63b:4313:f8b5 with SMTP id k6-20020a056a00134600b0063b4313f8b5mr401131pfu.23.1683256842747;
        Thu, 04 May 2023 20:20:42 -0700 (PDT)
Received: from [10.71.57.173] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id r16-20020a62e410000000b006258dd63a3fsm465264pfh.56.2023.05.04.20.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 20:20:42 -0700 (PDT)
Message-ID: <1fd91fcf-f5b8-48af-f4d3-dfaf3a4f7c86@bytedance.com>
Date:   Fri, 5 May 2023 11:20:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: Re: [PATCH bpf-next v5 1/2] bpf: Add bpf_task_under_cgroup()
 kfunc
To:     Yonghong Song <yhs@meta.com>, martin.lau@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20230504031513.13749-1-zhoufeng.zf@bytedance.com>
 <20230504031513.13749-2-zhoufeng.zf@bytedance.com>
 <72f73a40-d793-11dd-af34-f1491312d3b5@meta.com>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <72f73a40-d793-11dd-af34-f1491312d3b5@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

在 2023/5/4 22:29, Yonghong Song 写道:
> 
> 
> On 5/3/23 8:15 PM, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> Add a kfunc that's similar to the bpf_current_task_under_cgroup.
>> The difference is that it is a designated task.
>>
>> When hook sched related functions, sometimes it is necessary to
>> specify a task instead of the current task.
>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> You can carry my Ack from previous revision since there
> is no change to the patch.
> 
> Acked-by: Yonghong Song <yhs@fb.com>

Will do
