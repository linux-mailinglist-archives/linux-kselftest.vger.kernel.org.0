Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B54A77F6
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 19:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiBBSae (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 13:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346593AbiBBSae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 13:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643826633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VxSphhwkRTd5EsHLOOcvZP0sk5rc5kz4nLvAGye4isI=;
        b=TMdULIE0hw4oa6SCEajgnlNmyaifXAzrCjFH9zX3t77VIJ4m4bdNhmOv6A6K7Fqc82qEPN
        DxpeWkoFRWbCkFRiE3GSb6c+QLntKYKI3PsvFXtcKpenpvk3wzTwvoetJ0qcLuwrR8KCHb
        wK50nsb6UwxB+raatMvD6AepYNtUe0I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-eAcCfFg7NvOEiLeWGANLfg-1; Wed, 02 Feb 2022 13:30:32 -0500
X-MC-Unique: eAcCfFg7NvOEiLeWGANLfg-1
Received: by mail-wm1-f69.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso130926wmb.6
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 10:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=VxSphhwkRTd5EsHLOOcvZP0sk5rc5kz4nLvAGye4isI=;
        b=Q+H+iq4p0q93l32knaKzvlMTwlBZZZkMKBgpbj7HVTJl2iuZ6RZHR9bjAW6EfK0xZV
         YU6Ps3VkCpS/LJwzDekDMYrYWUjl2EL3rbd53Zun8/qtO4Fxx0U0L2+/R7aZN0/Yu/fS
         Ff7UvDF+hMARBN+opsR5GDB3qCgLDSVsHrmNbXJJ6cj3fdKblwFBxs86WzgifGi4lZKe
         JIsEKtulS4dBLt8odLMMY4IXJb0cZxV6f9TLYUyMWfemvKvTMQTtm4vdeH1qfqwAp1Bl
         ayWy5ULhdbov0h9sh6sHLsWDCMmu7UB82R0xaDbkh58jOxUxuX7cl+5PEyHjCRZhbgDw
         wauQ==
X-Gm-Message-State: AOAM532FPCdhcRhF7/b1oNLLjJJNJqhl7rwDpUsRzbU7Iw+dBATNsWdN
        9RHKLqGFaXfbBtT/Cxc0RmmIW+k5E3lxH0K82sg8aMA0kW9B9moi46kOR+IqLpLcsShFaQD2FK1
        ZWIMh0I5O0K68TO7//FjIl4QdrwTi
X-Received: by 2002:a05:600c:4f84:: with SMTP id n4mr7320055wmq.106.1643826631333;
        Wed, 02 Feb 2022 10:30:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhD8sTsx9eQnXlioUloGmSteV3B4XUzje0NCeKuYa6y9Qof9hYUm0WZtNSoEMdZVPHwHFBwA==
X-Received: by 2002:a05:600c:4f84:: with SMTP id n4mr7320037wmq.106.1643826631142;
        Wed, 02 Feb 2022 10:30:31 -0800 (PST)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id o21sm5374675wmh.36.2022.02.02.10.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 10:30:30 -0800 (PST)
Date:   Wed, 2 Feb 2022 19:30:28 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>
Subject: [PATCH net-next] selftests: fib offload: use sensible tos values
Message-ID: <5e43b343720360a1c0e4f5947d9e917b26f30fbf.1643826556.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Although both iproute2 and the kernel accept 1 and 2 as tos values for
new routes, those are invalid. These values only set ECN bits, which
are ignored during IPv4 fib lookups. Therefore, no packet can actually
match such routes. This selftest therefore only succeeds because it
doesn't verify that the new routes do actually work in practice (it
just checks if the routes are offloaded or not).

It makes more sense to use tos values that don't conflict with ECN.
This way, the selftest won't be affected if we later decide to warn or
even reject invalid tos configurations for new routes.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 .../selftests/net/forwarding/fib_offload_lib.sh      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/fib_offload_lib.sh b/tools/testing/selftests/net/forwarding/fib_offload_lib.sh
index e134a5f529c9..1b3b46292179 100644
--- a/tools/testing/selftests/net/forwarding/fib_offload_lib.sh
+++ b/tools/testing/selftests/net/forwarding/fib_offload_lib.sh
@@ -99,15 +99,15 @@ fib_ipv4_tos_test()
 	fib4_trap_check $ns "192.0.2.0/24 dev dummy1 tos 0 metric 1024" false
 	check_err $? "Route not in hardware when should"
 
-	ip -n $ns route add 192.0.2.0/24 dev dummy1 tos 2 metric 1024
-	fib4_trap_check $ns "192.0.2.0/24 dev dummy1 tos 2 metric 1024" false
+	ip -n $ns route add 192.0.2.0/24 dev dummy1 tos 8 metric 1024
+	fib4_trap_check $ns "192.0.2.0/24 dev dummy1 tos 8 metric 1024" false
 	check_err $? "Highest TOS route not in hardware when should"
 
 	fib4_trap_check $ns "192.0.2.0/24 dev dummy1 tos 0 metric 1024" true
 	check_err $? "Lowest TOS route still in hardware when should not"
 
-	ip -n $ns route add 192.0.2.0/24 dev dummy1 tos 1 metric 1024
-	fib4_trap_check $ns "192.0.2.0/24 dev dummy1 tos 1 metric 1024" true
+	ip -n $ns route add 192.0.2.0/24 dev dummy1 tos 4 metric 1024
+	fib4_trap_check $ns "192.0.2.0/24 dev dummy1 tos 4 metric 1024" true
 	check_err $? "Middle TOS route in hardware when should not"
 
 	log_test "IPv4 routes with TOS"
@@ -277,11 +277,11 @@ fib_ipv4_replay_tos_test()
 	ip -n $ns link set dev dummy1 up
 
 	ip -n $ns route add 192.0.2.0/24 dev dummy1 tos 0
-	ip -n $ns route add 192.0.2.0/24 dev dummy1 tos 1
+	ip -n $ns route add 192.0.2.0/24 dev dummy1 tos 4
 
 	devlink -N $ns dev reload $devlink_dev
 
-	fib4_trap_check $ns "192.0.2.0/24 dev dummy1 tos 1" false
+	fib4_trap_check $ns "192.0.2.0/24 dev dummy1 tos 4" false
 	check_err $? "Highest TOS route not in hardware when should"
 
 	fib4_trap_check $ns "192.0.2.0/24 dev dummy1 tos 0" true
-- 
2.21.3

