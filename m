Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9F2CED9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfE1Sou (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 May 2019 14:44:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43560 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfE1Sou (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 May 2019 14:44:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so11498272pgv.10
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2019 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ze8jepWGPJAMG1ZkYXRAZC7ie5pYIznlEj3Thcizxdc=;
        b=Lk2CACNhUfJOlEsrpdkwp3TsobL5jgP8Odt2x4Yhj04b/CWFh9hbjkadTy5/1DdxIc
         YdHZJFey0T9ojsU6acWxmLHbDbw431gfyYpW884YqAgrL3pUfynITUIe+O6ChdzRkSBL
         LV3eTFqCrxTqPn08pzYOyNA4mzpUkSJYnk0zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ze8jepWGPJAMG1ZkYXRAZC7ie5pYIznlEj3Thcizxdc=;
        b=P3PFoT7npXwVyuGYoMffSDmEg3sJXJAfNcnAbeOiLILo44fTsH14h2o9aElqTED/P6
         Ep0zJWb4CWvDyGyMdM2iFLDjkjVigDHhB3sObAC/CzzZfi5zpnVJNzvHG1um4caPtiXj
         vy32bVqLu/4ks1FCE66gAdy5P8/Uo9AAFOxA7NdmVFfi45pDyr5QcTxw+YIq5JMB2ajG
         MjLF1VcP7l9BcQVOOiB/TdAUQu0Q/dtQ7KaKlAa2MxvVF94tQGJn2NxSQc4s4OTvTkwt
         YEQHPyQtnjh3e7WR3b1ny3EPqnORJpAueQsJJEdP13Q+8vmxebuov9MlzyPoHY/hbB50
         tqTg==
X-Gm-Message-State: APjAAAVinEvO3XBTebrO9Isy8Ek6JKP+nMC0rn7ZUyo7zQSkxyN8h2cW
        4LaEXwGLgu80F80BHaqNcZ8Dtg==
X-Google-Smtp-Source: APXvYqwRIFHxCOzNUoN9Zu949YKegjPx4slN0w0F1ZPNzNriC5ijJegKz8DEZgkpbW3xbpluDZlVsQ==
X-Received: by 2002:a63:2315:: with SMTP id j21mr39559244pgj.414.1559069089903;
        Tue, 28 May 2019 11:44:49 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id j72sm3534085pje.12.2019.05.28.11.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:44:49 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v3 1/1] net/udp_gso: Allow TX timestamp with UDP GSO
Date:   Tue, 28 May 2019 11:44:15 -0700
Message-Id: <20190528184415.16020-2-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190528184415.16020-1-fklassen@appneta.com>
References: <20190528184415.16020-1-fklassen@appneta.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fixes an issue where TX Timestamps are not arriving on the error queue
when UDP_SEGMENT CMSG type is combined with CMSG type SO_TIMESTAMPING.
This can be illustrated with an updated updgso_bench_tx program which
includes the '-T' option to test for this condition.

    ./udpgso_bench_tx -4ucTPv -S 1472 -l2 -D 172.16.120.18
    poll timeout
    udp tx:      0 MB/s        1 calls/s      1 msg/s

The "poll timeout" message above indicates that TX timestamp never
arrived.

It also appears that other TX CMSG types cause similar issues, for
example trying to set SOL_IP/IP_TOS.

    ./udpgso_bench_tx -4ucPv -S 1472 -q 182 -l2 -D 172.16.120.18
    poll timeout
    udp tx:      0 MB/s        1 calls/s      1 msg/s

This patch preserves tx_flags for the first UDP GSO segment.

v2: Remove tests as noted by Willem de Bruijn <willemb@google.com>
    Moving tests from net to net-next

v3: Update only relevant tx_flag bits as per
    Willem de Bruijn <willemb@google.com>

Fixes: ee80d1ebe5ba ("udp: add udp gso")
Signed-off-by: Fred Klassen <fklassen@appneta.com>
---
 net/ipv4/udp_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 065334b41d57..de8ecba42d55 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -228,6 +228,11 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	seg = segs;
 	uh = udp_hdr(seg);
 
+	/* preserve TX timestamp and zero-copy info for first segment */
+	skb_shinfo(seg)->tskey = skb_shinfo(gso_skb)->tskey;
+	skb_shinfo(seg)->tx_flags |=
+			(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP);
+
 	/* compute checksum adjustment based on old length versus new */
 	newlen = htons(sizeof(*uh) + mss);
 	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
-- 
2.11.0

