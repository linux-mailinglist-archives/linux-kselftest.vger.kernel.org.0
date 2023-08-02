Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027B576CB72
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjHBLHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 07:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjHBLHR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 07:07:17 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D886B1FC3;
        Wed,  2 Aug 2023 04:07:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2F32160186;
        Wed,  2 Aug 2023 13:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690974421; bh=2C5V+v7TSwCU3tZ8DYUFlQXrNKHTQT/mQ0pFAl/qtAY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vHT5nsl/KKpbCxoOJ0l2M/cFG+MhTIauHqiRY48Uru3aDDA/FdpeCAsFb6Zi64agE
         29+VB3a2uzs+tI+I/QZZkBIwF9ITYgN8QeFM+diyDT/X9cNei0RwcCYycoN+dj6Ple
         4g7jeqAbQKDswWladWte9RYD1d5I9bWsygg0xA5p48Ks8LWDleUE8Aj+NR8KPxPVVh
         dPdG1asMzqkRYvFb15/Y8lHJHxfulUTESWp308bI5GEJoEL/WgM7fE38/OIOmuv6tJ
         yItqPJcOX5vi9xq268BReI+Nv/3gT8jeI/pjdFXk4xQn5uKKJ7eMLveq8WIlsncR9a
         ne1uxeB1cJXTQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PCV1y5omr7Cf; Wed,  2 Aug 2023 13:06:59 +0200 (CEST)
Received: from [10.0.2.76] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id E42C66017F;
        Wed,  2 Aug 2023 13:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690974419; bh=2C5V+v7TSwCU3tZ8DYUFlQXrNKHTQT/mQ0pFAl/qtAY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k8SE7QOGYjN0yHU68s+PINA8cr3Uq0gWbV4lxPhet3wfco106PNBVOFiHRsyfwI5R
         a4Ok3J11YzZqvcEQHf9fkD+bsIca/jTkQ+pUZs6fPR1AcSwnozzUX0MtKRKc9gjlby
         U0LOdVo46TxNOjIb0Q6ND07jBZJMkENPf7GBLzuz7hclcQlTxIww+yE5KpUOUmerFv
         Lx+o3CmC/mg2iewC3Q9gt9H2gdjdR0GEXfVpKm3fG3bxJF8twX8qx9yKls/tF/uO6C
         kv4oa/mOs8m4od4sf084+qr/PlbagmZlWZw0FnlismL4RWNB/ussEa536Uf8kzX/qr
         Dbf3jPda3b/iA==
Message-ID: <ed25e9f5-c98c-4c72-b3f3-6db7bf395459@alu.unizg.hr>
Date:   Wed, 2 Aug 2023 13:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 01/11] selftests: forwarding: custom_multipath_hash.sh:
 add cleanup for SIGTERM sent by timeout
Content-Language: en-US, hr
To:     Petr Machata <petrm@nvidia.com>
Cc:     Ido Schimmel <idosch@idosch.org>, razor@blackwall.org,
        Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder>
 <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
 <ZMYXABUN9OzfN5D3@shredder> <875y5zf27p.fsf@nvidia.com>
 <304ba960-0214-82d4-05be-e5956baa64c7@alu.unizg.hr>
 <87o7jpenpd.fsf@nvidia.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <87o7jpenpd.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2.8.2023. 12:33, Petr Machata wrote:
> 
> Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> writes:
> 
>> On 8/1/23 13:08, Petr Machata wrote:
>>> diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
>>> b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
>>> index aff88f78e339..5ea9d63915f7 100755
>>> --- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
>>> +++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
>>> @@ -72,7 +72,8 @@ test_span_gre_ttl()
>>>      	RET=0
>>>    -	mirror_install $swp1 ingress $tundev "matchall $tcflags"
>>> +	mirror_install $swp1 ingress $tundev \
>>> +		"prot ip flower $tcflags ip_prot icmp"
>>>    	tc filter add dev $h3 ingress pref 77 prot $prot \
>>>    		flower skip_hw ip_ttl 50 action pass
>>>    
>>
>> The problem seems to be fixed in the test run:
>>
>> root@defiant:tools/testing/selftests/net/forwarding# ./mirror_gre_changes.sh
>> TEST: mirror to gretap: TTL change (skip_hw)                        [ OK ]
>> TEST: mirror to ip6gretap: TTL change (skip_hw)                     [ OK ]
>> TEST: mirror to gretap: tunnel down/up (skip_hw)                    [ OK ]
>> TEST: mirror to ip6gretap: tunnel down/up (skip_hw)                 [ OK ]
>> TEST: mirror to gretap: egress down/up (skip_hw)                    [ OK ]
>> TEST: mirror to ip6gretap: egress down/up (skip_hw)                 [ OK ]
>> TEST: mirror to gretap: remote address change (skip_hw)             [ OK ]
>> TEST: mirror to ip6gretap: remote address change (skip_hw)          [ OK ]
>> TEST: mirror to gretap: tunnel deleted (skip_hw)                    [ OK ]
>> TEST: mirror to ip6gretap: tunnel deleted (skip_hw)                 [ OK ]
>> TEST: mirror to gretap: underlay route removal (skip_hw)            [ OK ]
>> TEST: mirror to ip6gretap: underlay route removal (skip_hw)         [ OK ]
>> WARN: Could not test offloaded functionality
>> root@defiant:tools/testing/selftests/net/forwarding#
> 
> OK, I'll add your Tested-by, let it pass through our regression and send
> upstream.

Great stuff.

Though, all these were incompatibilities in the testing scripts, not really a bug
in the kernel proper ...

Have a nice day!

Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

