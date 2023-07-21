Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C8C75D74A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 00:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjGUWRX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjGUWRX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 18:17:23 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C453AB1;
        Fri, 21 Jul 2023 15:17:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 12A6B6016E;
        Sat, 22 Jul 2023 00:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689977827; bh=TyfslZjfylAlfLVJYBGUmYyDqZRI4hQ8bFlIqzvjNxo=;
        h=Date:To:Cc:From:Subject:From;
        b=Pr4zKEDz8kFfzxMAKHCTppd9HobjOkVZRHjekphc3e/zYh5xnn/LMyzF5PVlrgPVw
         HsstG0m9tqws75R5QKxSZgRkzOp5dA6cV8g9fwG5MdPzMj+fxorZ60iN3dFrOpND8G
         MF1ntgOGjlJvQgeDrk5x+qM5OF8+i3RazIsu1Wi9fba0WZciZVsH4EpVREn0U4x64c
         Lsr+IA9zuAD4SjElp335oXcaPoMyByWq3z9ttkxBL1qGDaTxUvm3SfHgopACdi2gWH
         lq+IbIMM3mJZNJXjrQQkhuYI3u0OLJnqUQKHGAJZZsrXPDpCFef2/mkrsV6DmiB1gY
         mOgrMWZth3GYQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id woRg7Yp1sh6r; Sat, 22 Jul 2023 00:17:04 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id B9C176015F;
        Sat, 22 Jul 2023 00:17:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689977824; bh=TyfslZjfylAlfLVJYBGUmYyDqZRI4hQ8bFlIqzvjNxo=;
        h=Date:To:Cc:From:Subject:From;
        b=f4gGkO9wbAbGLHklMpsQ3n0KU23YOyJuZSj+tAYQV2Qv2//UJSxflpfYep4i0m4Sh
         WLdNgw7jncBscIk/oMPcuyMVs4QKLXjV+ucZqSfFo0lFK7B9eQ/d2nk/GgFDyd6sVZ
         rTqmDRo5CS5z4g+BdF4ervBvswZ5g78RkAigZYmR4uoQ+rn7XVROrgXG4N45wUxxYO
         Q2VgbuW5gj+e37oB2YOpAdEcwpSXFCPpzCNH/93kWuda1TBDXGb0qf+u/2D54qDGWe
         p/ZiW//9oPHXAR1ykaki4EdL+t8e7q+SFw+/rFWliTmZV+egVOENCZ6nPbIJ4XE6FZ
         zPrGwY4OFXI7w==
Message-ID: <829bc9a0-8b6a-f799-8434-7f42e6d7757e@alu.unizg.hr>
Date:   Sat, 22 Jul 2023 00:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Amit Cohen <amcohen@nvidia.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [BUG] sefltests: forwarding: gre_custom_multipath_hash.sh: [FAIL] and
 syntax errors
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

It's me again.

Don't throw things at me, but it is the same old vanilla torvalds tree kernel 6.5-rc2
kselftest run, and after applying the patches I ran into the new problems:

I have been free to add the timeout SIGTERM trap to the test, and this is the only
change, save for the Ido's lib.sh patch (for filling the veth NETIFS array in default
execution case).

Here is the command output:

# selftests: net/forwarding: gre_custom_multipath_hash.sh
# TEST: ping                                                          [ OK ]
# TEST: ping6                                                         [ OK ]
# INFO: Running IPv4 overlay custom multipath hash tests
# TEST: Multipath hash field: Inner source IP (balanced)              [ OK ]
# INFO: Packets sent on path1 / path2: 6760 / 5859
# TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
# INFO: Packets sent on path1 / path2: 2 / 12603
# TEST: Multipath hash field: Inner destination IP (balanced)         [ OK ]
# INFO: Packets sent on path1 / path2: 5850 / 6750
# TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
# INFO: Packets sent on path1 / path2: 12602 / 1
# TEST: Multipath hash field: Inner source port (balanced)            [ OK ]
# INFO: Packets sent on path1 / path2: 16411 / 16364
# TEST: Multipath hash field: Inner source port (unbalanced)          [ OK ]
# INFO: Packets sent on path1 / path2: 32773 / 3
# TEST: Multipath hash field: Inner destination port (balanced)       [ OK ]
# INFO: Packets sent on path1 / path2: 16410 / 16362
# TEST: Multipath hash field: Inner destination port (unbalanced)     [ OK ]
# INFO: Packets sent on path1 / path2: 32770 / 0
# INFO: Running IPv6 overlay custom multipath hash tests
# TEST: Multipath hash field: Inner source IP (balanced)              [ OK ]
# INFO: Packets sent on path1 / path2: 6150 / 6452
# TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 12600
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# TEST: Multipath hash field: Inner destination IP (balanced)         [FAIL]
# 	Expected traffic to be balanced, but it is not
# INFO: Packets sent on path1 / path2: -129763 / -77050
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Invalid VRF name
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Runtime error (func=(main), adr=3): Divide by zero
# (standard_in) 1: syntax error
# TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 0
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Runtime error (func=(main), adr=3): Divide by zero
# (standard_in) 1: syntax error
# TEST: Multipath hash field: Inner flowlabel (balanced)              [FAIL]
# 	Expected traffic to be balanced, but it is not
# INFO: Packets sent on path1 / path2: 0 / 0
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Invalid VRF name
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Runtime error (func=(main), adr=3): Divide by zero
# (standard_in) 1: syntax error
# TEST: Multipath hash field: Inner flowlabel (unbalanced)            [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 0
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Invalid VRF name
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Runtime error (func=(main), adr=3): Divide by zero
# (standard_in) 1: syntax error
# TEST: Multipath hash field: Inner source port (balanced)            [FAIL]
# 	Expected traffic to be balanced, but it is not
# INFO: Packets sent on path1 / path2: 0 / 0
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Invalid VRF name
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Runtime error (func=(main), adr=3): Divide by zero
# (standard_in) 1: syntax error
# TEST: Multipath hash field: Inner source port (unbalanced)          [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 0
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Invalid VRF name
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Runtime error (func=(main), adr=3): Divide by zero
# (standard_in) 1: syntax error
# TEST: Multipath hash field: Inner destination port (balanced)       [FAIL]
# 	Expected traffic to be balanced, but it is not
# INFO: Packets sent on path1 / path2: 0 / 0
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Invalid VRF name
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# jq: error (at <stdin>:1): Cannot iterate over null (null)
# Runtime error (func=(main), adr=3): Divide by zero
# (standard_in) 1: syntax error
# TEST: Multipath hash field: Inner destination port (unbalanced)     [ OK ]
# INFO: Packets sent on path1 / path2: 0 / 0
# Error: argument "vveth9" is wrong: Invalid VRF
#
# Error: argument "vveth9" is wrong: Invalid VRF
#
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: No such process
# RTNETLINK answers: No such process
# Cannot find device "vveth9"
# Error: argument "vveth8" is wrong: Invalid VRF
#
# Error: argument "vveth8" is wrong: Invalid VRF
#
# Error: argument "vveth8" is wrong: Invalid VRF
#
# Cannot find device "g2"
# Cannot find device "g2"
# Cannot find device "g2"
# Cannot find device "g2"
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: No such process
# RTNETLINK answers: No such process
# Cannot find device "vveth8"
# Error: Invalid handle.
# Error: argument "vveth6" is wrong: Invalid VRF
#
# Error: argument "vveth6" is wrong: Invalid VRF
#
# Cannot find device "veth5.222"
# Cannot find device "veth5.111"
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: No such process
# RTNETLINK answers: No such process
# Cannot find device "vveth6"
# Error: argument "vveth3" is wrong: Invalid VRF
#
# Error: argument "vveth3" is wrong: Invalid VRF
#
# Cannot find device "veth4.222"
# Cannot find device "veth4.111"
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: No such process
# RTNETLINK answers: No such process
# Cannot find device "vveth3"
# Error: argument "vveth1" is wrong: Invalid VRF
#
# Error: argument "vveth1" is wrong: Invalid VRF
#
# Error: argument "vveth1" is wrong: Invalid VRF
#
# Cannot find device "g1"
# Cannot find device "g1"
# Cannot find device "g1"
# Cannot find device "g1"
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: No such process
# RTNETLINK answers: No such process
# Cannot find device "vveth1"
# Error: argument "vveth0" is wrong: Invalid VRF
#
# Error: argument "vveth0" is wrong: Invalid VRF
#
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: Cannot assign requested address
# RTNETLINK answers: No such process
# RTNETLINK answers: No such process
# Cannot find device "vveth0"
# RTNETLINK answers: File exists
# RTNETLINK answers: No such file or directory
# RTNETLINK answers: File exists
# RTNETLINK answers: No such file or directory
#
not ok 18 selftests: net/forwarding: gre_custom_multipath_hash.sh # TIMEOUT 240 seconds

Those things like RTNETLINK errors probably mess up things beyond what cleanup
does, so the reproducer might not be that easy to devise.

I have tried to reduce the complexity by adding:

trap cleanup INT TERM EXIT

to the tests that timed out.

Kind regards,
Mirsad
