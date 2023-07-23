Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA3875E43A
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jul 2023 20:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGWSyQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Jul 2023 14:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWSyQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Jul 2023 14:54:16 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E4ADD;
        Sun, 23 Jul 2023 11:54:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B85CC60171;
        Sun, 23 Jul 2023 20:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690138453; bh=HE8dH2TxQcCO0dn0F5uZh3uzgF6puo8d0Es9W0bVdxA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ESZiSEXsSZ8GX0wjE2dPEynswzqG5bnTzdktFz4uBugZUNUbivOuua2l4HkVg7s7P
         C4VXht2g6Nnjs0kTLlfW83qESwv797Nm7OFd7kHMNY/+Z/wJwEda0yg6aIvMguhhoT
         v98EqxkTboyPgR1YplUijS3uexK7VEZnCaCruTIeyn+GfdJgFYWlFq6Gf8tkMzSsc+
         spuyiq26aIdRrSYqi2EuO7dqYVevPtTwg1xM4+b9gGdWdJrxjgZ11VMzm+ObuPTaTt
         6uY4vttihIGjwx8wezTqXFNr9jDJ2//yLXBlFHNbwTTFaJUVjdxUpiW30AILACiny+
         rvwvEkStFxzwg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3F3czHrlMqIT; Sun, 23 Jul 2023 20:54:11 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 052746015F;
        Sun, 23 Jul 2023 20:54:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690138451; bh=HE8dH2TxQcCO0dn0F5uZh3uzgF6puo8d0Es9W0bVdxA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gs4+JUeuK/JAKEj5nSXmcwg6nLBUC/DkvNNdlGQWMv7nSyTURfvQuHYtyyaHqnpyA
         5l/3YqykSvYjUOeYmqA5Q39WjjauTojI6+bniYb+DOb0Dhfb8CjF60yqiQhr64oPsF
         2H9sriEbd+1Lb6rkBbT3XZCDomMdOWdIFO+i6SNwnDnq6tJNvIsA5k/9jLru622PlP
         np6WtK4UkC15YyJlhvIGUivO2Am1n5lnJ8FlUIaIGLikaPk2bo00u/3Fnmhfie0Fdp
         GPxKqaZ2RdUkuZFoxutuDf1A3LhitPJfg7ojHpEu9yotZZb2fJlojFRK3hNI35Ut42
         3mr78NSzxDfFA==
Message-ID: <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
Date:   Sun, 23 Jul 2023 20:54:10 +0200
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
 <ZLzj5oYrbHGvCMkq@shredder>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZLzj5oYrbHGvCMkq@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 7/23/23 10:25, Ido Schimmel wrote:
> On Sat, Jul 22, 2023 at 02:36:00AM +0200, Mirsad Todorovac wrote:
>> Add trap and cleanup for SIGTERM sent by timeout and SIGINT from
>> keyboard, for the test times out and leaves incoherent network stack.
>>
>> Fixes: 511e8db54036c ("selftests: forwarding: Add test for custom multipath hash")
>> Cc: Ido Schimmel <idosch@nvidia.com>
>> Cc: netdev@vger.kernel.org
>> ---
> 
> The patches are missing your Signed-off-by and a cover letter. Anyway,
> please don't send a new version just yet. I'm not sure this is the
> correct approach and I'm looking into it.
> 
> Thanks

Sure thing. What a blunder, just when I thought I had the perfect patches.

Still, I think it is the way da go for all the test programs, to catch the
SIGINT and SIGTERM ...

This way, I need to reboot the system before running the tests on a clean
slate ...

Kind regards,
Mirsad
