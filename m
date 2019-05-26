Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8898F2AA6D
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 May 2019 17:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfEZPfv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 May 2019 11:35:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38422 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEZPfv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 May 2019 11:35:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so6050166plb.5
        for <linux-kselftest@vger.kernel.org>; Sun, 26 May 2019 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0l7QFOq9rpOhcfdcebxs2xSgloj45bF1H4poSZVVNXU=;
        b=fqBXmSi5i7K6JXD15jMSMBLJMxPKC3oMoCeeErPhCrD52WoGCKhw9TAw513pXSev1F
         +N1RK50nt7uAQTZikeAi59ZVuec9Ea6SUO/0V8G2lc9wE66o6gNb913uyM0gmgrUpBZW
         0GgmwXMxXUQ+opscuQCcwRZMYQGZ/dCfaW9pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0l7QFOq9rpOhcfdcebxs2xSgloj45bF1H4poSZVVNXU=;
        b=CYAybnjBweBt2bIVWh6McghA9l1czdKufOrWau7zRC5FlAcvYKRFUAq+3pvAQjleVg
         0NYlbTd2ZKB+qc0s9cYI6hKjf7BIOiRoWfR3sxbWFJo89n3AjZ+MsdLARfZZ7a7tucoA
         IW+7NEAjghlrLKcuOX6cK2v3WAfJ2SKVQDl5w7FRwRlebxFIMfVsZnxx8K4Ey3hHPsSn
         M6sWsamWHxTec2vUXPPJH53b0+sA+UzorCDVbCPVaBpDVt3mV1I7bownuhX3nJrw4q8a
         l/zgd5KgCzm6ZXK2VW/g/jgiMS4NUWqqBsxNp+giznknyVDDV42ZJeTwwzTZt6AL6Kvm
         Iy7A==
X-Gm-Message-State: APjAAAXDd9XdNGZXhk01QdQ3EvgkHVZkOgcLkSiLizz52GoqGz4tJJr9
        q1k7N750dtuaUW+XzbFJc3Gk4A==
X-Google-Smtp-Source: APXvYqzZL52EThif+oVPOrW5FnO/OwTkSeTsr1RTnmUwagyhIU9kunR8h/ekeCWlGniwHWnqabpKHg==
X-Received: by 2002:a17:902:201:: with SMTP id 1mr76787907plc.263.1558884950639;
        Sun, 26 May 2019 08:35:50 -0700 (PDT)
Received: from localhost.localdomain (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.googlemail.com with ESMTPSA id y25sm10523637pfp.182.2019.05.26.08.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 08:35:49 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net v2 1/1] net/udp_gso: Allow TX timestamp with UDP GSO
Date:   Sun, 26 May 2019 08:33:57 -0700
Message-Id: <20190526153357.82293-2-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190526153357.82293-1-fklassen@appneta.com>
References: <20190526153357.82293-1-fklassen@appneta.com>
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

This patch preserves tx_flags for the first UDP GSO segment. This
mirrors the stack's behaviour for IPv4 fragments.

Fixes: ee80d1ebe5ba ("udp: add udp gso")
Signed-off-by: Fred Klassen <fklassen@appneta.com>
---
 net/ipv4/udp_offload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 065334b41d57..33de347695ae 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -228,6 +228,10 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	seg = segs;
 	uh = udp_hdr(seg);
 
+	/* preserve TX timestamp and zero-copy info for first segment */
+	skb_shinfo(seg)->tskey = skb_shinfo(gso_skb)->tskey;
+	skb_shinfo(seg)->tx_flags = skb_shinfo(gso_skb)->tx_flags;
+
 	/* compute checksum adjustment based on old length versus new */
 	newlen = htons(sizeof(*uh) + mss);
 	check = csum16_add(csum16_sub(uh->check, uh->len), newlen);
-- 
2.11.0

