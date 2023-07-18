Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812EE758547
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 21:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGRTCj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 15:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGRTCj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 15:02:39 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACBBF0;
        Tue, 18 Jul 2023 12:02:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id BA80760173;
        Tue, 18 Jul 2023 21:02:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689706954; bh=oOp9GOBt7dGLDZev6mjA2E8gLrnDmnMsc86ZWopvLRs=;
        h=Date:To:Cc:From:Subject:From;
        b=zt1bSAbAq7PTNBJ4LktA7jN0Q7caUe3IIYGimjm/YL+RAAGVFbe3MoPthCj4pn1O4
         G/uRb1KR5WMFw0pnd2GCGMqHTXHn89/Bekk7Tzs6T8BnOUTMfgD2Mx/u3gK18+yA/+
         6/4qjOZfZZddOEvBb0Rps5VveKv5gn8sepXMi6VY8vQegapY9tZazyarMZ7eh1QiK3
         jGSy8d+XX/Shw/Nzl212tStNHKVvlsKP0Nt9VG8Szv3bsisvv94iOefBthqbjQeS31
         hkQUQbR1BCWDsNf/NeM3MUoEVvXDlWg1jawT3QXF8Fwq38ihCvB1OvoS/dyO1Uin9a
         pKELNltHcQBnw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2qCcU3mQkzED; Tue, 18 Jul 2023 21:02:32 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 6A29560171;
        Tue, 18 Jul 2023 21:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689706952; bh=oOp9GOBt7dGLDZev6mjA2E8gLrnDmnMsc86ZWopvLRs=;
        h=Date:To:Cc:From:Subject:From;
        b=m1dF4U9hBzPILv/EBb3gNQOtcluD6sjl8UzvCkfTMTPwcwYfgHG5vafT5W4DnTE3M
         TVkqiRtxmFnLuQIllSVtXGhr4dxZCR192BnysWfdzh/oXRis4nJf5DvzbM1ve/faYw
         0rMqRU15fHmq2T0RN+Mje2dXeC7r0WbRLRc1zOfGhW/gpW4Pwgt1C5xxIkOhA6aOIH
         pHUxbGkVo24kmTRolSFxsgN9FxbNDMaPgssXBz90japnd5Vko1e3n3El99w66EHSVO
         PS1pdVTTAHXilCXSI4P8RExP32vw3KYoX9QDSHFAqokY4llvbd1TINu24CuE/+tVF9
         0PU/XXmL5kRyQ==
Message-ID: <6b04b2ba-2372-6f6b-3ac8-b7cba1cfae83@alu.unizg.hr>
Date:   Tue, 18 Jul 2023 21:02:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PROBLEM] selftests: net/forwarding/bridge_mdb.sh: 'Command "replace"
 is unknown, try "bridge mdb help"'
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Consequential to the previous problem report, this one addresses almost the very
next test script.

The testing environment is the same: 6.5-rc2 vanilla Torvalds tree on Ubuntu 22.04 LTS.

The used config is the same, please find it with the bridge_mdb.sh normal and "set -x"
output on this link (too large to attach):

https://domac.alu.unizg.hr/~mtodorov/linux/selftests/net-forwarding/bridge_mdb.sh/

root@defiant:# ./bridge_mdb.sh

INFO: # Host entries configuration tests
TEST: Common host entries configuration tests (IPv4)                [FAIL]
	Managed to add IPv4 host entry with a filter mode
TEST: Common host entries configuration tests (IPv6)                [FAIL]
	Managed to add IPv6 host entry with a filter mode
TEST: Common host entries configuration tests (L2)                  [FAIL]
	Managed to add L2 host entry with a filter mode

INFO: # Port group entries configuration tests - (*, G)
Command "replace" is unknown, try "bridge mdb help".
TEST: Common port group entries configuration tests (IPv4 (*, G))   [FAIL]
	Failed to replace IPv4 (*, G) entry
Command "replace" is unknown, try "bridge mdb help".
TEST: Common port group entries configuration tests (IPv6 (*, G))   [FAIL]
	Failed to replace IPv6 (*, G) entry
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
RTNETLINK answers: Invalid argument
Error: bridge: (*, G) group is already joined by port.
Error: bridge: (*, G) group is already joined by port.
TEST: IPv4 (*, G) port group entries configuration tests            [FAIL]
	(S, G) entry not created
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
RTNETLINK answers: Invalid argument
Error: bridge: (*, G) group is already joined by port.
Error: bridge: (*, G) group is already joined by port.
TEST: IPv6 (*, G) port group entries configuration tests            [FAIL]
	(S, G) entry not created

INFO: # Port group entries configuration tests - (S, G)
Command "replace" is unknown, try "bridge mdb help".
TEST: Common port group entries configuration tests (IPv4 (S, G))   [FAIL]
	Failed to replace IPv4 (S, G) entry
Command "replace" is unknown, try "bridge mdb help".
TEST: Common port group entries configuration tests (IPv6 (S, G))   [FAIL]
	Failed to replace IPv6 (S, G) entry
Error: bridge: (S, G) group is already joined by port.
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
TEST: IPv4 (S, G) port group entries configuration tests            [FAIL]
	Managed to add an entry with a filter mode
Error: bridge: (S, G) group is already joined by port.
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
Command "replace" is unknown, try "bridge mdb help".
TEST: IPv6 (S, G) port group entries configuration tests            [FAIL]
	"temp" entry has an unpending group timer

INFO: # Port group entries configuration tests - L2
Command "replace" is unknown, try "bridge mdb help".
TEST: Common port group entries configuration tests (L2 (*, G))     [FAIL]
	Failed to replace L2 (*, G) entry
TEST: L2 (*, G) port group entries configuration tests              [FAIL]
	Managed to add an entry with a filter mode

INFO: # Large scale dump tests
TEST: IPv4 large scale dump tests                                   [ OK ]
TEST: IPv6 large scale dump tests                                   [ OK ]
TEST: L2 large scale dump tests                                     [ OK ]

INFO: # Forwarding tests
Error: bridge: Group is already joined by host.
TEST: IPv4 host entries forwarding tests                            [FAIL]
	Packet not locally received after adding a host entry
Error: bridge: Group is already joined by host.
TEST: IPv6 host entries forwarding tests                            [FAIL]
	Packet locally received after flood
TEST: L2 host entries forwarding tests                              [FAIL]
	Packet not locally received after flood
Command "replace" is unknown, try "bridge mdb help".
TEST: IPv4 port group "exclude" entries forwarding tests            [FAIL]
	Packet from valid source not received on H2 after adding entry
Command "replace" is unknown, try "bridge mdb help".
TEST: IPv6 port group "exclude" entries forwarding tests            [FAIL]
	Packet from invalid source received on H2 after adding entry
Command "replace" is unknown, try "bridge mdb help".
TEST: IPv4 port group "include" entries forwarding tests            [FAIL]
	Packet from valid source not received on H2 after adding entry
Command "replace" is unknown, try "bridge mdb help".
TEST: IPv6 port group "include" entries forwarding tests            [FAIL]
	Packet from invalid source received on H2 after adding entry
TEST: L2 port entries forwarding tests                              [ OK ]

INFO: # Control packets tests
Command "replace" is unknown, try "bridge mdb help".
TEST: IGMPv3 MODE_IS_INCLUDE tests                                  [FAIL]
	Source not add to source list
Command "replace" is unknown, try "bridge mdb help".
TEST: MLDv2 MODE_IS_INCLUDE tests                                   [FAIL]
	Source not add to source list
root@defiant:# bridge mdb show
root@defiant:#

NOTE that several "sleep 10" command looped in the script can easily exceed
the default timeout of 45 seconds, and SIGTERM to the script isn't processed,
so it leaves the system in an unpredictable state from which even
"systemctl restart networking" didn't bail out.

Setting tools/testing/selftests/net/forwarding/settings:timeout=150 seemed enough.

Best regards,
Mirsad Todorovac
