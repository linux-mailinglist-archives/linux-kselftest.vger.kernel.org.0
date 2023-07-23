Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABCC75E435
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jul 2023 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjGWSus (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Jul 2023 14:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWSur (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Jul 2023 14:50:47 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E13F3;
        Sun, 23 Jul 2023 11:50:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id EEF6460171;
        Sun, 23 Jul 2023 20:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690138231; bh=eNrWuD560AZswhvCgLs7uptVHWEPszV5AXkZsEm1AFc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kKtW7zkPlbVYiEjfq2pAyG9eTvXD/dWqB/mgDKPn5grVXsvg1pj/XFfGqBgpgsR+y
         N/62sf7AOkcvHooutHKix2yXbdfjEDXbdXfW27hDJRQ0qjWis8qb9buthEXVx8mSsV
         jt02bHWDdNTjO57PQuGxmBbqi74QU/V73L2pr4L4mYMgFj1IqPg5s86Y59CN/fX++p
         q9cXBGoccxd+DY6f/wPcze/U8GT6eZGlG5/shi8clMXmL8HMpXCSPpEYNab8jouJwW
         lkQ6zxPE4g+9gNwa/pGZNJE7f9U9L6s0YkB7iUcW/rkiflIgMn0b6xMmEgucpLuYus
         QcP27dxQET2YQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oBXA4NpgkQJv; Sun, 23 Jul 2023 20:50:29 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 3B3406015F;
        Sun, 23 Jul 2023 20:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690138229; bh=eNrWuD560AZswhvCgLs7uptVHWEPszV5AXkZsEm1AFc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OB5bpdEebStwgkNUwbQbvwyYjaNk2cxHv0UmILS6m2DSDFp7ALM9qZFAbejPhRy6C
         2etVBk8UGrY1+gWFUBJIRJVnWd5uRyLn63lb4/PKNiIATHs6W5I36jOhV1dw5GdrWL
         RR3IfSTFTg2bxjy7fFYnZQkmen+t+b2mXeU0OqOfgT8dvwCeiEohkve8IHhFCMurud
         OvD6ptdv8uQ4/ciiAzn/puBTbbrEf71BEGVNNmkiOmQ0+J5/2C4Hp5Am+oerLT00VZ
         wsop0c950e/OqgDVAPp5D/BW+AjaXEN8PZnFn6wNdsmSAEjvRyaVWKR6j1ZWGa5ZNU
         uUmHfKYHE3Clw==
Message-ID: <2004b5c6-6bff-88a8-a3f2-cfe95f12996b@alu.unizg.hr>
Date:   Sun, 23 Jul 2023 20:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 01/11] selftests: forwarding: custom_multipath_hash.sh:
 add cleanup for SIGTERM sent by timeout
Content-Language: en-US
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder> <ZL1jFk1z3zDH7dUM@shredder>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZL1jFk1z3zDH7dUM@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/23/23 19:27, Ido Schimmel wrote:
> On Sun, Jul 23, 2023 at 11:25:16AM +0300, Ido Schimmel wrote:
>> On Sat, Jul 22, 2023 at 02:36:00AM +0200, Mirsad Todorovac wrote:
>>> Add trap and cleanup for SIGTERM sent by timeout and SIGINT from
>>> keyboard, for the test times out and leaves incoherent network stack.
>>>
>>> Fixes: 511e8db54036c ("selftests: forwarding: Add test for custom multipath hash")
>>> Cc: Ido Schimmel <idosch@nvidia.com>
>>> Cc: netdev@vger.kernel.org
>>> ---
>>
>> The patches are missing your Signed-off-by and a cover letter. Anyway,
>> please don't send a new version just yet. I'm not sure this is the
>> correct approach and I'm looking into it.
> 
> Please test with the following four patches on top of net.git:
> 
> https://github.com/idosch/linux/commits/submit/sefltests_fix_v1

Will do. Just applying.

However, I have upgraded to iproute2-next, maybe the error message should
give a hint on that, too ... That might relieve the pressure on developers
answering always the same questions ...

Kind regards,
Mirsad
