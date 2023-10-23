Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DA07D36C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 14:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjJWMeh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 08:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjJWMeg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 08:34:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52934FF;
        Mon, 23 Oct 2023 05:34:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cace3e142eso16473355ad.3;
        Mon, 23 Oct 2023 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698064474; x=1698669274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCfeGAPmI/1C6hVy3j5HY6SeWT2q6xH+8rq3JEHka0s=;
        b=L5ixgswJLEDr2m2u2dG+LgKdftPbLwF2n2vApNX6Ci+Hv2f9LBwaXVXQU2LAhWasFD
         oXP0a8+C0jJOB2jtB9C56tkdt/CkaDOdGJcjLm7bUxoenMznTXHf4R/w9i6ITH/eliB/
         vHUY9VB7AmiSZRWmAosbXlfg3f8rS+szw74e9GVCfia6WLJ7Av96tQePL37SnuIhI/Qv
         HB8OHqWG+bdcpWEz9V7F2Z2EACXnHi/ZmzL7JNyhSgcdfPv5zSp332jvxdvaC09jVsJK
         2yt4TJhlkAziJNCpB6w/Tj8yZXpxMLsLUEgdyCUkw7mEj1iSUiNtWvuPPfmlB4gUaE13
         ZzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698064474; x=1698669274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCfeGAPmI/1C6hVy3j5HY6SeWT2q6xH+8rq3JEHka0s=;
        b=rtkY/MKMWIRrx3WJFeqKA8YzcYLaG0BtKPz1YLpOGNfK9CckGTJ70iAInMqgw+2ytb
         n0FXWq2hUSJTtzIT83XCW1JsTV13uplUWHb6uiRQsyW6TEJifB0PUOq+QMsVJn/K7ZKj
         waXgQTc//HvALlGSxqYhfimxicGND/aeREdORGqx6/DTtqoL0pWe3Ggi7Hd0diQoSIeM
         tTQwjoNZ2tUjkOQ+3W/Am/F6vU+VkPlbr3h5UnOKlAjGqBQtUueQ8zovoPie+FM8YEUd
         O7Ex6l6RLZZurLhnyH8uPkjudXbfC/bmlFNgMKhmXkcqDf5rqHYK/kFIVHCQTFZKzpqn
         VTaA==
X-Gm-Message-State: AOJu0YyWbi3LeyJVIN6ay8ogZIfqOFOMCEaycmK2HQqZAdnKaoa62nCs
        hnrWhhZrBm/PGmKLfice/zQ=
X-Google-Smtp-Source: AGHT+IH1wbasmBNgondsuKTvzLHD5UV7liWemEtyM+fqBb/NsiHuIK/oggwkA7jK0980y2/7I2tSkw==
X-Received: by 2002:a17:902:efd1:b0:1c9:ba77:b27e with SMTP id ja17-20020a170902efd100b001c9ba77b27emr6801484plb.46.1698064473560;
        Mon, 23 Oct 2023 05:34:33 -0700 (PDT)
Received: from swarup-virtual-machine.localdomain ([171.76.85.44])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001c9ab91d3d7sm5799275plz.37.2023.10.23.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:34:33 -0700 (PDT)
From:   Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To:     davem@davemloft.net, jiri@resnulli.us, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Subject: [PATCH v2] selftests:net change ifconfig with ip command
Date:   Mon, 23 Oct 2023 18:04:22 +0530
Message-Id: <20231023123422.2895-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZTYc04N9VK7EarHY@nanopsycho>
References: <ZTYc04N9VK7EarHY@nanopsycho>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Change ifconfig with ip command,
on a system where ifconfig is
not used this script will not
work correcly.

Test result with this patchset:

sudo make TARGETS="net" kselftest
....
TAP version 13
1..1
 timeout set to 1500
 selftests: net: route_localnet.sh
 run arp_announce test
 net.ipv4.conf.veth0.route_localnet = 1
 net.ipv4.conf.veth1.route_localnet = 1
 net.ipv4.conf.veth0.arp_announce = 2
 net.ipv4.conf.veth1.arp_announce = 2
 PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84)
  bytes of data.
 64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.038 ms
 64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.068 ms
 64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.068 ms
 64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.068 ms
 64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.068 ms

 --- 127.25.3.14 ping statistics ---
 5 packets transmitted, 5 received, 0% packet loss, time 4073ms
 rtt min/avg/max/mdev = 0.038/0.062/0.068/0.012 ms
 ok
 run arp_ignore test
 net.ipv4.conf.veth0.route_localnet = 1
 net.ipv4.conf.veth1.route_localnet = 1
 net.ipv4.conf.veth0.arp_ignore = 3
 net.ipv4.conf.veth1.arp_ignore = 3
 PING 127.25.3.14 (127.25.3.14) from 127.25.3.4 veth0: 56(84)
  bytes of data.
 64 bytes from 127.25.3.14: icmp_seq=1 ttl=64 time=0.032 ms
 64 bytes from 127.25.3.14: icmp_seq=2 ttl=64 time=0.065 ms
 64 bytes from 127.25.3.14: icmp_seq=3 ttl=64 time=0.066 ms
 64 bytes from 127.25.3.14: icmp_seq=4 ttl=64 time=0.065 ms
 64 bytes from 127.25.3.14: icmp_seq=5 ttl=64 time=0.065 ms

 --- 127.25.3.14 ping statistics ---
 5 packets transmitted, 5 received, 0% packet loss, time 4092ms
 rtt min/avg/max/mdev = 0.032/0.058/0.066/0.013 ms
 ok
ok 1 selftests: net: route_localnet.sh
...

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
---
 tools/testing/selftests/net/route_localnet.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/route_localnet.sh b/tools/testing/selftests/net/route_localnet.sh
index 116bfeab72fa..e08701c750e3 100755
--- a/tools/testing/selftests/net/route_localnet.sh
+++ b/tools/testing/selftests/net/route_localnet.sh
@@ -18,8 +18,10 @@ setup() {
     ip route del 127.0.0.0/8 dev lo table local
     ip netns exec "${PEER_NS}" ip route del 127.0.0.0/8 dev lo table local
 
-    ifconfig veth0 127.25.3.4/24 up
-    ip netns exec "${PEER_NS}" ifconfig veth1 127.25.3.14/24 up
+    ip address add 127.25.3.4/24 dev veth0
+    ip link set dev veth0 up
+    ip netns exec "${PEER_NS}" ip address add 127.25.3.14/24 dev veth1
+    ip netns exec "${PEER_NS}" ip link set dev veth1 up
 
     ip route flush cache
     ip netns exec "${PEER_NS}" ip route flush cache
-- 
2.34.1

