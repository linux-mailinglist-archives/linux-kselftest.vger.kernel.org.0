Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4421E76C5B8
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjHBGwg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 02:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjHBGwU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 02:52:20 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE962D53;
        Tue,  1 Aug 2023 23:51:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbd2761f1bso54462795ad.2;
        Tue, 01 Aug 2023 23:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690959102; x=1691563902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ZOYz5tJWIm5wwiu4clNWQAkqTwhMrt2CWLKqUdg8b0=;
        b=IzeHwt2JyZr1omnyxl/9LlDPoarPSoZBsZtf6OM5pnMbxIsuze+GLyevO8tgqGqZ/2
         dK4ubBy95WuUpzappL98/g6mN2HXuvZw9m7kv6ySU2eYa3pQ3y7o3uRuxoEzVyApW56Y
         HOeO9G+M8qSJkVOHsRIa2Ofvrl6n2Fz6Obb7I5fiJamdEE0ffosKXAwT+YZBDhGGMEcb
         H6abgTo8k1KZJ5K9oKQntO/ARoDtc+Rerdvb+xQAIUsF76Atq3xe9JeoH1pfUWYpqeIz
         g4N7+mgwH3CfTTBmcIfgO8/toINwvbh1V+3QtFzTzz5rigL8Ia3lGCGe8vDYzIIHl6I6
         xhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959102; x=1691563902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZOYz5tJWIm5wwiu4clNWQAkqTwhMrt2CWLKqUdg8b0=;
        b=ANURGCDyaETQAX4QJrBcWZQ3iQhl9MFMmNce/W4xagrfuqlEC83mXJm1d6X/7f1MLm
         oU1rXSLq7Ib5koA3qyw0SVu/oolL7sZ5IysTShsWqXZIcxdna6K0PattyDS2Hn7bIr3y
         HvxiOQMV6uZ039B6BZ8mLbH2X+rIfbsVllGTNgOvAlEh7PQXb1k+PZzEzUqtaKwE0doU
         k4Bgo/zrKOGz0p9s5px9zkNYgEctNN5MVHyfX7tTPNxCmVj6qx/UitKLJkI6M4SQKVys
         UwF2OmVni+10yGf/LGPvqygBhcGpgQfrnZwwSdwA3B1twZ3bH8hCG7b3z/GyRtFGch7A
         s3XA==
X-Gm-Message-State: ABy/qLYQZ5CTRhzuN73oqmVwy+sAV1PL8iraYZ72FSlpUVr+LjY1Ir9M
        H5zQwYXivfFfqhR8j2/I6hA/JdaCI94D2I9W
X-Google-Smtp-Source: APBJJlHPUMf6CpGNUzLl+072yFaIiU/Vjiu2Lyni6TT2M0vLzGFtjD/rY1bYh8RKhME4IwbsD7lD6g==
X-Received: by 2002:a17:902:c20c:b0:1b8:adc:7c3d with SMTP id 12-20020a170902c20c00b001b80adc7c3dmr15322879pll.40.1690959102532;
        Tue, 01 Aug 2023 23:51:42 -0700 (PDT)
Received: from [10.22.68.111] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id g8-20020a1709029f8800b001a80ad9c599sm11496477plq.294.2023.08.01.23.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 23:51:42 -0700 (PDT)
Message-ID: <1483f6db-35a8-849b-9bda-00ad5aa81eff@gmail.com>
Date:   Wed, 2 Aug 2023 14:51:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v5 1/2] bpf, xdp: Add tracepoint to xdp attaching
 failure
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        hawk@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mykolal@fb.com, shuah@kernel.org, tangyeechou@gmail.com,
        kernel-patches-bot@fb.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20230801142621.7925-1-hffilwlqm@gmail.com>
 <20230801142621.7925-2-hffilwlqm@gmail.com>
 <20230801150826.6f617919@kernel.org>
From:   Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20230801150826.6f617919@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2/8/23 06:08, Jakub Kicinski wrote:
> On Tue,  1 Aug 2023 22:26:20 +0800 Leon Hwang wrote:
>> When error happens in dev_xdp_attach(), it should have a way to tell
>> users the error message like the netlink approach.
>>
>> To avoid breaking uapi, adding a tracepoint in bpf_xdp_link_attach() is
>> an appropriate way to notify users the error message.
>>
>> Hence, bpf libraries are able to retrieve the error message by this
>> tracepoint, and then report the error message to users.
> 
> Whatevered-by: Jakub Kicinski <kuba@kernel.org> ?

Oh, it's not responsible for libraries to retrieve the error message. It
should be users' responsibility.

Sorry for the misguiding text.

In the previous patch[0], which changes uapi, it's able to back-propagate
the error message from dev_xdp_attach() to userspace through BPF syscall.
Then, tracepoint idea is suggested to avoid changing uapi. I do agree to
implement a tracepoint to avoid changing uapi.

[0] bpf: Introduce user log
https://lore.kernel.org/bpf/20230708040750.72570-1-hffilwlqm@gmail.com/

Thanks,
Leon
