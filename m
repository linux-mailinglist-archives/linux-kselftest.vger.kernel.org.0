Return-Path: <linux-kselftest+bounces-17205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0D296D039
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A75284A7D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D87193074;
	Thu,  5 Sep 2024 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbHlXroJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2B219306B;
	Thu,  5 Sep 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520678; cv=none; b=Ip7DJeJL50VAO6zwIRULZKVqUvoeg5/NNly+rRWXUuQ06qNmpHvbqbNGYXctCEUBPn0vvIddL03OTpxhQIIkHtVPmFGfR8BAUt+DxWbVjig+7XXpzde423W0y1K5sFDdjPgeeiArBbulPjuYJGmaQmNmOC7XgQUKt8NNzFT/aZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520678; c=relaxed/simple;
	bh=pm18LzKuf7Pe/TqQlkff7gRCifSAML3mIMou2tvYhtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfHDd8YtLdRU4Pq8oij1r8PRo02ytyCK9/JzadzAJ/SknDKpcQMYMJm1DH3a6BCCuebKnw6P61O06XInBV2SR9JH77zC2J3OD/YPQSEHQWAdXXbF3HfuD2t3iqnKBGXmMu8zGet2kmESVUqF1RRnoNcumG8b4JSNYRddQsSv7Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbHlXroJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4f6d8c1eeso360101a12.1;
        Thu, 05 Sep 2024 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725520676; x=1726125476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2o2hbaaXm5/I0Rt4fzNJUxwimu3WCgjAFqRCFnWp90=;
        b=HbHlXroJ5YesjTJuXzLS+8kO5FARwVM4PNkyl1EUn1gJsMev2bAhqSyeYudzc2Sq6I
         LrIp+qJTj7vbtiCDdXy43iJuZvOKAsMYuS0ekzJJSVYxbU+iq1gaE0DyPlSQEfEe2o4v
         +bRhQpSOFau9NtPRwAPF5h0k/I1D7bepx89CSGbQ3XhL/7S+ViEsL/3FxlCxo/SPsW+Z
         Ni0aW6cAfInsIeXH4U7VYAO+XqmZbDHsihhdX6jlg2EK0eaRbyN6bRldWvVsQlH0jrjJ
         XsX1PAHDW1KL4ht8zwyPiJHRztA2Cv+/THpRF49K3Az6ala1f1xT7Cj9eGXrW1+8JgNZ
         8eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725520676; x=1726125476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2o2hbaaXm5/I0Rt4fzNJUxwimu3WCgjAFqRCFnWp90=;
        b=Z0/OBnuZgOmbwpSspEcTzAQYs72VOthDpVRKSeZZeAv8j1Jy4JB2VYU1yzF6p/VWpE
         /T4JONyIARoUfkqkMiFfc5oeoYVN1kdyYZmx3q1c4Wji9416ljP3YiZqAc/SdBSlF0wF
         I1LE8YUuuJ8RUGQQZ41qMsIDEm/fJukMni4WuLXaNMpnEAZX5bvsXtcZGFnt3w2PNkbq
         GBd0Mt6W7lbvrrR5SBc1HMToVUDkW9B0R6oQp4sg9TgHljXWv/w0qTQxUFoyTV667sPc
         QJNpMqO+2lfrXEZywAigGND7tCMdaNCG2HNeYtjFskwsKkaILJztqr+AGEgDsxgDzrxp
         1IGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnO8/D3nv4jeeyBBVIdajmWqcDBBm+0EcnDML0N/yH27ryNuaswFr2p4596OnDawazNeHvMoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpTlq6Gr460NVhY8GTVjx74bzucpBon93Jps6Gptn57BoAUJm
	8lPfvFZ/cXnJvK0RD08SJriMoxB8KQSty3glsY7/YtApIgNHZj8C
X-Google-Smtp-Source: AGHT+IF3P19sPUd0ouuwNRSN9DiPnMWG75Vzki1Vpej8NwUZMf3dRz+Aacb9hECi2eUzY0s1F+RbsA==
X-Received: by 2002:a17:902:e804:b0:1fc:568d:5f05 with SMTP id d9443c01a7336-205472c61acmr190174145ad.8.1725520676022;
        Thu, 05 Sep 2024 00:17:56 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae913b19sm22929425ad.61.2024.09.05.00.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:17:55 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/4] net-timestamp: filter out report when setting SOF_TIMESTAMPING_SOFTWARE
Date: Thu,  5 Sep 2024 15:17:34 +0800
Message-Id: <20240905071738.3725-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240905071738.3725-1-kerneljasonxing@gmail.com>
References: <20240905071738.3725-1-kerneljasonxing@gmail.com>
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

In this way, we have two kinds of combination:
1. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_RX_SOFTWARE, it
will surely allow users to get the rx software timestamp report.
2. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_OPT_RX_FILTER
while the skb is timestamped, it will stop reporting the rx software
timestamp.

Another thing about errqueue in this patch I have a few words to say:
In this case, we need to handle the egress path carefully, or else
reporting the tx timestamp will fail. Egress path and ingress path will
finally call sock_recv_timestamp(). We have to distinguish them.
Errqueue is a good indicator to reflect the flow direction.

Suggested-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v4
Link: https://lore.kernel.org/all/20240830153751.86895-2-kerneljasonxing@gmail.com/
1. revise the commit message and doc (Willem)
2. simplify the test statement (Jakub)
3. add Willem's reviewed-by tag (Willem)

v3
1. Willem suggested this alternative way to solve the issue, so I
added his Suggested-by tag here. Thanks!
---
 Documentation/networking/timestamping.rst | 12 ++++++++++++
 include/uapi/linux/net_tstamp.h           |  3 ++-
 net/core/sock.c                           |  4 ++++
 net/ethtool/common.c                      |  1 +
 net/ipv4/tcp.c                            |  6 ++++--
 net/socket.c                              |  4 +++-
 6 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 5e93cd71f99f..37ead02be3b1 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -266,6 +266,18 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
   two separate messages will be looped to the socket's error queue,
   each containing just one timestamp.
 
+SOF_TIMESTAMPING_OPT_RX_FILTER:
+  Used in the receive software timestamp. Enabling the flag along with
+  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp to the
+  userspace so that it can filter out the case where one process starts
+  first which turns on netstamp_needed_key through setting generation
+  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one only passing
+  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx timestamp.
+
+  SOF_TIMESTAMPING_OPT_RX_FILTER prevents the application from being
+  influenced by others and let the application choose whether to report
+  the timestamp in the receive path or not.
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
diff --git a/net/core/sock.c b/net/core/sock.c
index 468b1239606c..6a93344e21cf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -908,6 +908,10 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	    !(val & SOF_TIMESTAMPING_OPT_ID))
 		return -EINVAL;
 
+	if (val & SOF_TIMESTAMPING_RX_SOFTWARE &&
+	    val & SOF_TIMESTAMPING_OPT_RX_FILTER)
+		return -EINVAL;
+
 	if (val & SOF_TIMESTAMPING_OPT_ID &&
 	    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
 		if (sk_is_tcp(sk)) {
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
index 8a5680b4e786..a0c57c8b77bd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			struct scm_timestamping_internal *tss)
 {
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
+	u32 tsflags = READ_ONCE(sk->sk_tsflags);
 	bool has_timestamping = false;
 
 	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
@@ -2274,14 +2275,15 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			}
 		}
 
-		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
+		if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+		    !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))
 			has_timestamping = true;
 		else
 			tss->ts[0] = (struct timespec64) {0};
 	}
 
 	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
-		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_RAW_HARDWARE)
+		if (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
 			has_timestamping = true;
 		else
 			tss->ts[2] = (struct timespec64) {0};
diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..f8609d649ed3 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -946,7 +946,9 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 	memset(&tss, 0, sizeof(tss));
 	tsflags = READ_ONCE(sk->sk_tsflags);
-	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+	     (skb_is_err_queue(skb) ||
+	     !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
 	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
 		empty = 0;
 	if (shhwtstamps &&
-- 
2.37.3


