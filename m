Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD76E57A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 04:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjDRCyP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 22:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjDRCyO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 22:54:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B626618A
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 19:54:10 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b62d2f729so1059733b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Apr 2023 19:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681786449; x=1684378449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI8CSW8wZY6h2DetmThed8bwX0CVp8MeiGi3ooxUQA0=;
        b=H+aEpkToTaqeRZMoNe5U647O5kYJ1IqlYabxWBmtbtWHnfrsp7FBJSyhjgGneIyc5X
         csQLFLvJhDJVW2KFJrN+/e2D77QfJd6toFrE64v4EDK9N20OWmC1v58XBX4KImHw5H3y
         h13jgJtHlNd7uTOSunITpA9tqXgqggbEYlfg8FsyLrDZHjouUFzRTtOXih85qjLuEndk
         wmbU/raenCrq8HqGisML+MEOiZJvfmqeRvGbM4/9T9bHl2Ub4pGWxsZtB5Lemx/BqMio
         SMn1S3ki+4Y4GBfexFR9UXeVuQ8DRhr/p7h+49fpKXh6LHFspnLtU904my5R/S9i/M0v
         FLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681786449; x=1684378449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rI8CSW8wZY6h2DetmThed8bwX0CVp8MeiGi3ooxUQA0=;
        b=YLm1qLLImk1wOjd7jRUUe3MfSphwtrBR+UhOnLjqBX9WnRFChtsUZo03eKuex91fWW
         uIwNIF5evAYNQXMRe9btKA7KH5nbGh7nv4erOwtjFgcXx96GiPC07uB+v+dKr7QOwjc7
         p34nj3H9ALSwQUjl/vGC/QqSuM6PwawuQPy74HAah0d+8oq3ZsE0oMXy3YdFpVD/foSF
         8cfkQ+HqZrPrzkymAZoVq6FpL1QXngikZJlIHKyEBg6k+b8O9Q3a9lEK+znIQ3iTiuc1
         igDNizwNae3CIFUHnG/ItdGjxgvz/9waP8jYjXCCudu7o5dnt5QHWVBMSICiKiBf0RU+
         fytg==
X-Gm-Message-State: AAQBX9fp/+2aDLrwsRfUNCRlWVUd3jSf87bED8EuTlhHqY1PimfjeIaF
        hmgX8QhnK/HWUxV83mTVMr98/w==
X-Google-Smtp-Source: AKy350YpQrpKPDJGeX+yABq7FPc9EADNX5sZ8C+tl27EDJLN7iicddp5XLV7FcqMPPxIZ7AK4Evc+A==
X-Received: by 2002:a05:6a00:cc7:b0:637:920c:25fd with SMTP id b7-20020a056a000cc700b00637920c25fdmr26555641pfv.17.1681786449272;
        Mon, 17 Apr 2023 19:54:09 -0700 (PDT)
Received: from [10.71.57.173] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a8-20020a62bd08000000b0062dd993fdfcsm8194548pff.105.2023.04.17.19.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 19:54:08 -0700 (PDT)
Message-ID: <0460e6ac-40f9-6e47-e121-87c824658482@bytedance.com>
Date:   Tue, 18 Apr 2023 10:53:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: Re: [PATCH 1/2] bpf: support access variable length array of
 integer type
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com, zhouchengming@bytedance.com
References: <20230417080749.39074-1-zhoufeng.zf@bytedance.com>
 <20230417080749.39074-2-zhoufeng.zf@bytedance.com>
 <20230418000833.keqhb7kdpibgaodt@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <20230418000833.keqhb7kdpibgaodt@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

在 2023/4/18 08:08, Alexei Starovoitov 写道:
> On Mon, Apr 17, 2023 at 04:07:48PM +0800, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> After this commit:
>> bpf: Support variable length array in tracing programs (9c5f8a1008a1)
>> Trace programs can access variable length array, but for structure
>> type. This patch adds support for integer type.
>>
>> Example:
>> Hook load_balance
>> struct sched_domain {
>> 	...
>> 	unsigned long span[];
>> }
>>
>> The access: sd->span[0].
> The use case makes sense.
> Please add it as a selftest. Either combine it with patch 2 or another patch 3.
> and then resubmit.
> Make sure to use [PATCH bpf-next] subject, so BPF CI knows how to test it.

Will do, thanks.

