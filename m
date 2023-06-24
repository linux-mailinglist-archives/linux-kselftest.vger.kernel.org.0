Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D2073C5FE
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 03:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFXBqL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 21:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFXBqK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 21:46:10 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D6626B0;
        Fri, 23 Jun 2023 18:46:09 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5700b37da3fso11960747b3.1;
        Fri, 23 Jun 2023 18:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687571168; x=1690163168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76JpghSzqxpkmUMEkAEWsCp3Rh8C6sYcv5A/KZzk8E8=;
        b=iDurpGnRl0819ENTtN4y48rldrg6A9SdwD4pWSYwryoE+MRrnkbfSQ/Vx4Mo1+ZB0F
         pROIuW4Db8rBIwU2x7XHqectYTc7lor+/+rBHS5UjLnufoTtVzPfEeqsGMJgczpyzC6z
         QxxTFSYoVfR/bO0o+/1Ve+5ps9dmsmbB0+ju9V4KiTU5gr3xueo0YuZ7q5mCa/O+MA4j
         y4mpKI0VNVezWTKJkIMoOgHVEcaEDDQdHTH63iFWM3dJxRdvc9Xt04rNU9yFXqHVJWOG
         FdhcmBDDeHI4FIZnVa4hxeO8SGTTGFTQ6OzMjCYu3s3XYO25zRwKckVI/enSD6IDsBUM
         jv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687571168; x=1690163168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76JpghSzqxpkmUMEkAEWsCp3Rh8C6sYcv5A/KZzk8E8=;
        b=GniWX2sSEPzR593rbYasnOmRT0l60WfDVITZmlK/ufc6jBBRz0keM6JWiymYJb/mZ7
         8WgtqnZz5AzK1u+4T/8RiLLR0tfNwyH5WrKUUHIxox3nWhpBu39H6wW3v6Wbt0SYbAvd
         HNsojP7KyTotdZKhV+8AWf8oqwhvsgRyHbQoD6Gb3ynP8Rts6Tm6pBBjhKKHnMDx8zIR
         zkbyI62OP2L5/bXhc7y+K2dpnlEB4IuVenoIXanyin/uZW9Lgb/YYnX9GgZcpMZhKy6g
         brOMfjApbyl+/TzJ03cCNsYSMbBWyvRMJutPbEWvauRs5vr3bDqPK8f+Ptg8J4GUlO/X
         +hCg==
X-Gm-Message-State: AC+VfDx1cs7aDCgDhRbzTuCx5P6kununXcm5Y1ootsFpIXu6RGGT7zGM
        n514UXJ3aEhMkZlNQDSkmWqErTV7VrYWzA==
X-Google-Smtp-Source: ACHHUZ4RM/VQxfKMSuU+bvWKDxEDiR437qgUg8Y5x+aDVH5+hHJAhvn7gD0EZxFhnlPwzp1/nz9w+Q==
X-Received: by 2002:a81:8450:0:b0:561:9082:8039 with SMTP id u77-20020a818450000000b0056190828039mr16258862ywf.38.1687571167745;
        Fri, 23 Jun 2023 18:46:07 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d5fe:ab6b:8508:3503])
        by smtp.gmail.com with ESMTPSA id b126-20020a816784000000b005731f3c8989sm107916ywc.62.2023.06.23.18.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 18:46:07 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, kpsingh@kernel.org,
        shuah@kernel.org, john.fastabend@gmail.com, sdf@google.com,
        mykolal@fb.com, linux-kselftest@vger.kernel.org, jolsa@kernel.org,
        haoluo@google.com, netdev@vger.kernel.org
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v4 1/2] net: bpf: Check SKB ownership against full socket.
Date:   Fri, 23 Jun 2023 18:45:59 -0700
Message-Id: <20230624014600.576756-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230624014600.576756-1-kuifeng@meta.com>
References: <20230624014600.576756-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check SKB ownership of an SKB against full sockets instead of request_sock.

The filters were called only if an SKB is owned by the sock that the SKB is
sent out through.  In another words, skb->sk should point to the sock that
it is sending through its egress.  However, the filters would miss SYN/ACK
SKBs that they are owned by a request_sock but sent through the listener
sock, that is the socket listening incoming connections.

However, the listener socket is also the full socket of the request socket.
We should use the full socket as the owner socket of an SKB instead.

What is the ownership check for?
====================================

BPF_CGROUP_RUN_PROG_INET_EGRESS() checked sk == skb->sk to ensure the
ownership of an SKB. Alexei referred to a mailing list conversation that
took place a few years ago. [1] In that conversation, Daniel Borkmann
stated that:

    Wouldn't that mean however, when you go through stacked devices that
    you'd run the same eBPF cgroup program for skb->sk multiple times?

According to what Daniel said, the ownership check mentioned earlier
presumably prevents multiple calls of egress filters caused by an skb.

A test that reproduce this scenario shows that the BPF cgroup egress
programs can be called multiple times for one SKB if this ownership
check is not there.  So, we can not just remove this check.

Test Stacked Devices
=======================

We use L2TP to build an environment of stacked devices. L2TP (Layer 2
Tunneling Protocol) is a tunneling protocol used to support virtual private
networks (VPNs). It relays encapsulated packets; for example in UDP, to its
peer by using a socket.

Using L2TP, packets are first sent through the IP stack and should then
arrive at an L2TP device. The device will expand its SKB header to
encapsulate the packet. The SKB will be sent back to the IP stack using the
socket that was made for the L2TP session. After that, the routing process
will occur once more, but this time for a new destination.

We changed tools/testing/selftests/net/l2tp.sh to set up a test environment
using L2TP.  The run_ping() function in l2tp.sh is where the main change
occurred.

    run_ping()
    {
        local desc="$1"

        sleep 10
        run_cmd host-1 ${ping6} -s 227 -c 4 -i 10 -I fc00:101::1
        fc00:101::2
        log_test $? 0 "IPv6 route through L2TP tunnel ${desc}"
        sleep 10

    }

The test will use L2TP devices to send PING messages. These messages will
have a message size of 227 bytes as a special label to distinguish them.
This is not an ideal solution, but works.

During the execution of the test script, bpftrace was attached to
ip6_finish_output() and l2tp_xmit_skb(). BPF

    bpftrace -e '
      kfunc:ip6_finish_output {
        time("%H:%M:%S: ");
        printf("ip6_finish_output skb=%p skb->len=%d cgroup=%p sk=%p
                skb->sk=%p\n", args->skb, args->skb->len,
               args->sk->sk_cgrp_data.cgroup, args->sk, args->skb->sk); }
      kfunc:l2tp_xmit_skb {
        time("%H:%M:%S: ");
        printf("l2tp_xmit_skb skb=%p sk=%p\n", args->skb,
	       args->session->tunnel->sock); }'

The following is part of the output messages printed by bpftrace.

    16:35:20: ip6_finish_output skb=0xffff888103d8e600 skb->len=275
              cgroup=0xffff88810741f800 sk=0xffff888105f3b900
              skb->sk=0xffff888105f3b900

    16:35:20: l2tp_xmit_skb skb=0xffff888103d8e600 sk=0xffff888103dd6300

    16:35:20: ip6_finish_output skb=0xffff888103d8e600 skb->len=337
              cgroup=0xffff88810741f800 sk=0xffff888103dd6300
              skb->sk=0xffff888105f3b900

    16:35:20: ip6_finish_output skb=0xffff888103d8e600 skb->len=337
              cgroup=(nil) sk=(nil) skb->sk=(nil)

    16:35:20: ip6_finish_output skb=0xffff888103d8e000 skb->len=275
              cgroup=0xffffffff837741d0 sk=0xffff888101fe0000
              skb->sk=0xffff888101fe0000

    16:35:20: l2tp_xmit_skb skb=0xffff888103d8e000 sk=0xffff888103483180

    16:35:20: ip6_finish_output skb=0xffff888103d8e000 skb->len=337
              cgroup=0xffff88810741f800 sk=0xffff888103483180
              skb->sk=0xffff888101fe0000

    16:35:20: ip6_finish_output skb=0xffff888103d8e000 skb->len=337
              cgroup=(nil) sk=(nil) skb->sk=(nil)

The first four entries describe a PING message that was sent using the ping
command, whereas the following four entries describe the response received.
Multiple sockets are used to send one skb, including the socket used by the
L2TP session. This can be observed.

Based on this information, it seems that the ownership check is designed to
avoid multiple calls of egress filters caused by a single skb.

[1] https://lore.kernel.org/all/58193E9D.7040201@iogearbox.net/,

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf-cgroup.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..8506690dbb9c 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -199,9 +199,9 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)			       \
 ({									       \
 	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk && sk == skb->sk) { \
+	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {		       \
 		typeof(sk) __sk = sk_to_full_sk(sk);			       \
-		if (sk_fullsock(__sk) &&				       \
+		if (sk_fullsock(__sk) && __sk == skb_to_full_sk(skb) &&	       \
 		    cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))	       \
 			__ret = __cgroup_bpf_run_filter_skb(__sk, skb,	       \
 						      CGROUP_INET_EGRESS); \
-- 
2.34.1

