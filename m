Return-Path: <linux-kselftest+bounces-17383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1F496F0A5
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 11:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9554BB2249D
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 09:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384E1C9DCB;
	Fri,  6 Sep 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqgIk0sn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654423B1A2;
	Fri,  6 Sep 2024 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616615; cv=none; b=cg5PEKnOY9DSMJ94/wXh+qG4UXvem1E+YQwecvbTBV+Vu0FQpas9YynukXRCnUTGc353E6J2ihSICI2vpPqs+RuQXP35bbp7PqT6e1fJdk+MEeDQ9tkTfzMTPwd2i78MpJnp7NNu9XTP9+2kVF73ankDLGpoHByYEQ4KebNFdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616615; c=relaxed/simple;
	bh=Gg/cFI4uLlqsVbnZaoEm8EdIUALzwgRPjjBkwowQQYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=enXfWMYIQ/czdH8cy2y0YF596sgzgJgLsMbyGqCK6u2dasJv/aXZWGz1vI9X7kOBFRuaeOycQvqYwbP0fzePAdYdykL6kXqUds6XNVtNE1kLPnxZcSkqnvcnaySHV9Jm4Ks5PNyG8rRoz6RNBJTlxVlGWqzD5fWevsEPKvBP+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqgIk0sn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-206f9b872b2so2271895ad.3;
        Fri, 06 Sep 2024 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725616613; x=1726221413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BxxaI5LPZkABtslo3wKELpnxyTLvGZ8594bDUzf9kY=;
        b=OqgIk0snrOLTMxOvVSJwhfrEQCS9/ZQI8xTA5XuDA2eZpy83FSV2BQCJFIDYe7ltmd
         726aA+zVVqeHUK3yKC8DIJvwvlQpXMGt50jmmb+w1TpBJ6NDJ4QCPzf32H/SZpj/0RaJ
         fMZd0fEvbIs/Z8RTYegoaR8Ay12aaBsWenNMtQEQLhu1vytmaSkmQWqm8oqrvh7iksWE
         TsjrrsHtmck0WtAQLNvKQ7K3X5F3ycHMyQVJ7nzBuRT3jRuWn7MM21W2cPqGHNHAQFn4
         9TI4mIq4ruzaWNXtflflKAFt+xozWQX1prMf/UN5ZA0Cck2Li+vmXttMcbas1UqT57E8
         NXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616613; x=1726221413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BxxaI5LPZkABtslo3wKELpnxyTLvGZ8594bDUzf9kY=;
        b=D4qx/V1/S2fSILeNiond3nar0UdbNt7UUNHuQTbaJRyL6N4iM18O33OVBiqehj0BK6
         cwakZVDx8Vmnt0ueLxucoN7UEHM7rgJbjXWtw7T9+hbwcyeYVDOiwmHibEhpIZN/yTFr
         rAp5T4tFZTJE7sovj7FVNlu5stvqWBmAPOzE0ytzZGJ52eRoop9zpQX7Vbrx3QT4y/+5
         OscVBg80QQerpHAiSE/LTVfz9F69F97/TR7AAWjC/K++Pxvv1ITRbs3PWjl2V/j0hviJ
         075KvNBCD49ULBgi9aSElHfegk98FcEth1olj00ZxPvCQhqRp56Ray+V7SQgnpH/V7vz
         5aZA==
X-Forwarded-Encrypted: i=1; AJvYcCXR8Vijy/Y2hLcoPrP4IsmOEceHp4lhdTMKCXLGFedqxevccxjb9Bl31cbVJZ4K2orQTJdJEAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvJ5LjInMCErxycjRVZCxKePbQr97MYJvHL1vYdpMqSdgDd3b
	Ppg+RKGRAeiSgLYRcqQSyUKOMZok/SwhaxeqmZUQXDSsW2lYoGI3WPMLmyjkqh4=
X-Google-Smtp-Source: AGHT+IGz4kWsb/kpQ1FmXy6H6E3rDazo3LGK+vvo3d4cxRzz7d0SDPuRCJngWXpTPDt3PvstwLzo5w==
X-Received: by 2002:a17:903:1c5:b0:206:fd9b:f4f1 with SMTP id d9443c01a7336-206fd9bf52dmr3689035ad.56.1725616612490;
        Fri, 06 Sep 2024 02:56:52 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea5582csm39982595ad.221.2024.09.06.02.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:56:52 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	willemb@google.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 1/2] net-timestamp: introduce SOF_TIMESTAMPING_OPT_RX_FILTER flag
Date: Fri,  6 Sep 2024 17:56:39 +0800
Message-Id: <20240906095640.77533-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240906095640.77533-1-kerneljasonxing@gmail.com>
References: <20240906095640.77533-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the receive
path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
out rx software timestamp report, especially after a process turns on
netstamp_needed_key which can time stamp every incoming skb.

Previously, we found out if an application starts first which turns on
netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOFTWARE
could also get rx timestamp. Now we handle this case by introducing this
new flag without breaking users.

Quoting Willem to explain why we need the flag:
"why a process would want to request software timestamp reporting, but
not receive software timestamp generation. The only use I see is when
the application does request
SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."

Similarly, this new flag could also be used for hardware case where we
can set it with SOF_TIMESTAMPING_RAW_HARDWARE, then we won't receive
hardware receive timestamp.

Another thing about errqueue in this patch I have a few words to say:
In this case, we need to handle the egress path carefully, or else
reporting the tx timestamp will fail. Egress path and ingress path will
finally call sock_recv_timestamp(). We have to distinguish them.
Errqueue is a good indicator to reflect the flow direction.

Suggested-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v5
Link: https://lore.kernel.org/all/20240905071738.3725-1-kerneljasonxing@gmail.com/
1. squash the hardware case patch into this one (Willem)
2. update corresponding commit message and doc (Willem)
3. remove the limitation in sock_set_timestamping() and restore the
simplification branches. (Willem)

v4
Link: https://lore.kernel.org/all/20240830153751.86895-2-kerneljasonxing@gmail.com/
1. revise the commit message and doc (Willem)
2. simplify the test statement (Jakub)
3. add Willem's reviewed-by tag (Willem)

v3
1. Willem suggested this alternative way to solve the issue, so I
added his Suggested-by tag here. Thanks!
---
 Documentation/networking/timestamping.rst | 27 +++++++++++++++++++++++
 include/uapi/linux/net_tstamp.h           |  3 ++-
 net/ethtool/common.c                      |  1 +
 net/ipv4/tcp.c                            |  9 ++++++--
 net/socket.c                              | 10 +++++++--
 5 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 9c7773271393..ae122ae3df72 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -267,6 +267,33 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
   two separate messages will be looped to the socket's error queue,
   each containing just one timestamp.
 
+SOF_TIMESTAMPING_OPT_RX_FILTER:
+  Used to filter out software/hardware receive timestamps. Existing
+  applications can 1) set SOF_TIMESTAMPING_SOFTWARE only, or 2) set
+  SOF_TIMESTAMPING_RAW_HARDWARE only because they implicitly came to
+  depend on another (usually daemon) process to enable receive
+  timestamps systemwide. Enabling the flag along with
+  SOF_TIMESTAMPING_SOFTWARE or SOF_TIMESTAMPING_RAW_HARDWARE will not
+  report the software or hardware receive timestamp to the userspace
+  so that it can filter out the cases where 1) one process starts
+  first which turns on netstamp_needed_key through setting generation
+  flags like SOF_TIMESTAMPING_RX_SOFTWARE, or 2) similarly one process
+  enables generating the hardware timestamp first like setting
+  SOF_TIMESTAMPING_RX_HARDWARE, then another one only passing report
+  flag could also get the receive timestamp.
+
+  If the new applications 1) enable the flag along with
+  SOF_TIMESTAMPING_SOFTWARE and SOF_TIMESTAMPING_TX_SOFTWARE, or
+  2) enable it with SOF_TIMESTAMPING_RAW_HARDWARE and
+  SOF_TIMESTAMPING_TX_HARDWARE, they will only receive software or
+  hardware transmit timestamp respectively.
+
+  If the new applications 1) enable the flag along with
+  SOF_TIMESTAMPING_SOFTWARE and SOF_TIMESTAMPING_RX_SOFTWARE, or
+  2) enable it with SOF_TIMESTAMPING_RAW_HARDWARE and
+  SOF_TIMESTAMPING_RX_HARDWARE, they will still receive software or
+  hardware receive timestamp respectively.
+
 New applications are encouraged to pass SOF_TIMESTAMPING_OPT_ID to
 disambiguate timestamps and SOF_TIMESTAMPING_OPT_TSONLY to operate
 regardless of the setting of sysctl net.core.tstamp_allow_data.
diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/net_tstamp.h
index a2c66b3d7f0f..858339d1c1c4 100644
--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -32,8 +32,9 @@ enum {
 	SOF_TIMESTAMPING_OPT_TX_SWHW = (1<<14),
 	SOF_TIMESTAMPING_BIND_PHC = (1 << 15),
 	SOF_TIMESTAMPING_OPT_ID_TCP = (1 << 16),
+	SOF_TIMESTAMPING_OPT_RX_FILTER = (1 << 17),
 
-	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_ID_TCP,
+	SOF_TIMESTAMPING_LAST = SOF_TIMESTAMPING_OPT_RX_FILTER,
 	SOF_TIMESTAMPING_MASK = (SOF_TIMESTAMPING_LAST - 1) |
 				 SOF_TIMESTAMPING_LAST
 };
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 781834ef57c3..6c245e59bbc1 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -427,6 +427,7 @@ const char sof_timestamping_names[][ETH_GSTRING_LEN] = {
 	[const_ilog2(SOF_TIMESTAMPING_OPT_TX_SWHW)]  = "option-tx-swhw",
 	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     = "bind-phc",
 	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   = "option-id-tcp",
+	[const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] = "option-rx-filter",
 };
 static_assert(ARRAY_SIZE(sof_timestamping_names) == __SOF_TIMESTAMPING_CNT);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a5680b4e786..e359a9161445 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			struct scm_timestamping_internal *tss)
 {
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
+	u32 tsflags = READ_ONCE(sk->sk_tsflags);
 	bool has_timestamping = false;
 
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
@@ -2274,14 +2275,18 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			}
 		}
 
-		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
+		if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+		    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
+		     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
 			has_timestamping = true;
 		else
 			tss->ts[0] = (struct timespec64) {0};
 	}
 
 	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
-		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_RAW_HARDWARE)
+		if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
+		    (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
+		     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER)))
 			has_timestamping = true;
 		else
 			tss->ts[2] = (struct timespec64) {0};
diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..1c2fd1a317af 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -946,11 +946,17 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 	memset(&tss, 0, sizeof(tss));
 	tsflags = READ_ONCE(sk->sk_tsflags);
-	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+	     (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
+	     skb_is_err_queue(skb) ||
+	     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
 	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
 		empty = 0;
 	if (shhwtstamps &&
-	    (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
+	    (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
+	    (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
+	    skb_is_err_queue(skb) ||
+	    !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
 	    !skb_is_swtx_tstamp(skb, false_tstamp)) {
 		if_index = 0;
 		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
-- 
2.37.3


