Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88F6772EFA
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 21:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjHGTiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 15:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjHGTiS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 15:38:18 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1E7198D;
        Mon,  7 Aug 2023 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1691437083;
        bh=1guEDll9h1wN1L9V3kLsxr8T2FFUdKFvpqggbyfqqO0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LNwyM6GML+F0UEISwhFOm8lG8w5go+IkS6bk3xzOD6oxhWR9MFTxybmAAf9E5Wjf3
         AViw7drWtBR+44Qrrrc07Umr2rZdhzknyUsRQU148e+Vk4Dt4HqVE6m7JbyCLxHKOg
         XFTm7HFR7OkF0rJON6y7W4ITkyP8zLaPKw/8IdYcoCs5mubHwINUKecFo7Og0zB5oU
         rzvwOIyDOJHYNyDMHipmJyjWwJfIFw58U9tmZNy37y/oOrI+OQ2q5kFAJBvLJZ+DfW
         8778otuGCQ/JC5cAM0ap3MqC9hhHboJteVb7BTE9QXs0VcZN9kt71Ts6rpf4i6eNvJ
         NvpofuJWFKqTQ==
Received: from [IPV6:2605:59c8:2711:c800::c66] (unknown [IPv6:2605:59c8:2711:c800::c66])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RKRSB5RPPz1Kqp;
        Mon,  7 Aug 2023 15:38:02 -0400 (EDT)
Message-ID: <4fb64f73-12eb-d6a6-6f84-97e6195d7a5b@efficios.com>
Date:   Mon, 7 Aug 2023 15:38:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] RSEQ selftests updates
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20230515135801.15220-1-mathieu.desnoyers@efficios.com>
 <fd64bf35-8e18-8da7-d83c-882fdc60a87d@efficios.com>
 <f0fdf470-f25d-b51f-8a2d-f891ea7b94b1@linuxfoundation.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <f0fdf470-f25d-b51f-8a2d-f891ea7b94b1@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/7/23 14:53, Shuah Khan wrote:
> On 6/6/23 07:36, Mathieu Desnoyers wrote:
>> Hi Peter,
>>
>> Can you queue those fixes through your tree ?
>>
> 
> 
> Peter, Mathieu,
> 
> Doesn't look like this series has been pickedup?

Not AFAIK. Peter, if you have this somewhere in your tip queue, please 
let us know.

> 
> I can take these in for 6.6-rc1 if there are no dependencies
> on other trees.

It should not have dependencies with other trees.

Thanks,

Mathieu

> 
> thanks,
> -- Shuah
> 
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

