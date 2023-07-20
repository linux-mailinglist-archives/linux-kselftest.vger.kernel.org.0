Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85675A574
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 07:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjGTFZa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 01:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGTFZ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 01:25:29 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76872110;
        Wed, 19 Jul 2023 22:25:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id E1FBB6015E;
        Thu, 20 Jul 2023 07:25:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689830726; bh=ZAqMkp/DBdBOVwAIRGxyUnAmmHO14ggEbQ2+58ks12M=;
        h=Date:From:Subject:To:Cc:From;
        b=ndEDIfTFmAXE3038XelV1l6726OsL9C7du/DHTl8UMre6qLqYIUjeZYJAG6xOL/YO
         V5oCy6RtbFczI8g28yaujW2CTSX3FuDMiS7JFaiWE1NHLwF9H2UQRJyTGaJhjaocrU
         yizqoiCp8ZE3rEDknvq2W6G6PuDKU7oTTXGTqrHMdhUPqFtiCuvgcYd35vpdQ/KDsZ
         s0RcTJktsbS+jlOpEAw/s28KwD9qZLZJwJMY3ktnj9WAxTc0jPqKQbEDHWqhnJjR+2
         hPnidbECAl18gpfq3d67D3LhlLJUhljG8gIof5SOfOl7WpoZmAwaeLUeAm7Rp19+KL
         dK2wCAVewnTIg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WAdvw5bmmGMH; Thu, 20 Jul 2023 07:25:24 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 0D65060157;
        Thu, 20 Jul 2023 07:25:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689830724; bh=ZAqMkp/DBdBOVwAIRGxyUnAmmHO14ggEbQ2+58ks12M=;
        h=Date:From:Subject:To:Cc:From;
        b=w07Z0lK/eFvU4p+LHAbjGiDrEQ034nxCqSeO5TSTzLA6kCSI2f4MwfoZA4CTdnTdZ
         mWp/5/CO8SUl1Kf6hEEmyvFwpuMzLXKMK4AaicwU/Sh9wG+eDOkZjTaK0NbCc+HQCp
         0j9GChGeejRNM/Xa4Pu8jkfNkVKwgH57nRvaFVjMTRDFnDIDsW2AQjho/kYFeeqopE
         rpxSx3fZeo85de8FVk7CDlfK5mSpDzjKHhl86VsoFz8JzfOenjqDIW7PPC55YAaQHl
         Y+/G8xVkqKhe9LinsNHR32+S6f7fVDwXfCgSZ2LP4ZhZW56UjbOnlo8vRyHwjqYIjj
         g/0q7E4CgFuiA==
Message-ID: <759fe934-2e43-e9ff-8946-4fd579c09b05@alu.unizg.hr>
Date:   Thu, 20 Jul 2023 07:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PROBLEM] seltests: net/forwarding/sch_ets.sh [HANG]
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Using the same config for 6.5-rc2 on Ubuntu 22.04 LTS and 22.10, the execution
stop at the exact same line on both boxes (os I reckon it is more than an
accident):

# selftests: net/forwarding: sch_ets.sh
# TEST: ping vlan 10                                                  [ OK ]
# TEST: ping vlan 11                                                  [ OK ]
# TEST: ping vlan 12                                                  [ OK ]
# Running in priomap mode
# Testing ets bands 3 strict 3, streams 0 1
# TEST: band 0                                                        [ OK ]
# INFO: Expected ratio >95% Measured ratio 100.00
# TEST: band 1                                                        [ OK ]
# INFO: Expected ratio <5% Measured ratio 0
# Testing ets bands 3 strict 3, streams 1 2
# TEST: band 1                                                        [ OK ]
# INFO: Expected ratio >95% Measured ratio 100.00
# TEST: band 2                                                        [ OK ]
# INFO: Expected ratio <5% Measured ratio 0
# Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1
# TEST: band 0                                                        [ OK ]
# INFO: Expected ratio >95% Measured ratio 100.00
# TEST: band 1                                                        [ OK ]
# INFO: Expected ratio <5% Measured ratio 0
# Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 1 2
# TEST: bands 1:2                                                     [ OK ]
# INFO: Expected ratio 2.00 Measured ratio 1.99
# Testing ets bands 3 quanta 3300 3300 3300, streams 0 1 2
# TEST: bands 0:1                                                     [ OK ]
# INFO: Expected ratio 1.00 Measured ratio .99
# TEST: bands 0:2                                                     [ OK ]
# INFO: Expected ratio 1.00 Measured ratio 1.00
# Testing ets bands 3 quanta 5000 3500 1500, streams 0 1 2
# TEST: bands 0:1                                                     [ OK ]
# INFO: Expected ratio 1.42 Measured ratio 1.42
# TEST: bands 0:2                                                     [ OK ]
# INFO: Expected ratio 3.33 Measured ratio 3.33
# Testing ets bands 3 quanta 5000 8000 1500, streams 0 1 2
# TEST: bands 0:1                                                     [ OK ]
# INFO: Expected ratio 1.60 Measured ratio 1.59
# TEST: bands 0:2                                                     [ OK ]
# INFO: Expected ratio 3.33 Measured ratio 3.33
# Testing ets bands 2 quanta 5000 2500, streams 0 1
# TEST: bands 0:1                                                     [ OK ]
# INFO: Expected ratio 2.00 Measured ratio 1.99
# Running in classifier mode
# Testing ets bands 3 strict 3, streams 0 1
# TEST: band 0                                                        [ OK ]
# INFO: Expected ratio >95% Measured ratio 100.00
# TEST: band 1                                                        [ OK ]
# INFO: Expected ratio <5% Measured ratio 0
# Testing ets bands 3 strict 3, streams 1 2
# TEST: band 1                                                        [ OK ]
# INFO: Expected ratio >95% Measured ratio 100.00
# TEST: band 2                                                        [ OK ]
# INFO: Expected ratio <5% Measured ratio 0
# Testing ets bands 4 strict 1 quanta 5000 2500 1500, streams 0 1

I tried to run 'set -x' enabled version standalone, but that one finished
correctly (?).

It could be something previous scripts left, but right now I don't have a clue.
I can attempt to rerun all tests with sch_ets.sh bash 'set -x' enabled later today.

Best regards,
Mirsad Todorovac
