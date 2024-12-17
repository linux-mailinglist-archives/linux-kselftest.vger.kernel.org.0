Return-Path: <linux-kselftest+bounces-23466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB69F568D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710131893036
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707D71F9A98;
	Tue, 17 Dec 2024 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHTjFztT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B31F9411;
	Tue, 17 Dec 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461539; cv=none; b=qQBp2bb1nTiJ7L7uLCe/uZu/LC/aI5vQAk8MQ1QqJ1c97su9Ldmj34TCumy5izXixxElg7qiel4hhD7smmJPM+Azp8MWXLuCRH681oPKLsm4pTmcvtgh9gHXU+PpQbMD00fFzHFvysm0/HcFJDi8HxIneCbL5NHUBKytmEEFhMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461539; c=relaxed/simple;
	bh=iNjE4sZ1kDql1DGTZ+jmNQE1GlOQ22uGIu2YTY/mNjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dt29/RMSUmAI+hTcuMdwHDvDiQrSV/Jh4GEHKnEV8kEx+A5lccrsb35Ud66T0WshnAcJPaRd493M2wkbDGVrBhy7ZjALQIpW/PAFZWG/qvzXDWAd1MJ1qtidPMw+UTtEVhvIz3PLOK2kxOge1GorxYLqNUWP7Y+QpEt5D0sj7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHTjFztT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2163dc5155fso49556175ad.0;
        Tue, 17 Dec 2024 10:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734461535; x=1735066335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0PRbBT67AMQWPupJ+gwKRks1p54D733VwXE8WQ/tWg=;
        b=dHTjFztTXxnuARwicE/ANl+XtcklDJT8xkQGmIbemmqWTgn9I/Jp9EaxjWTfPhvGRx
         rQl7M3bLf0jgw8p3ivugFsZRFVt9PZ08G9hDDaZmifjXYWvJJqkPp9FqWVb4XJn/m3pT
         MNjNb4cu2fyTlDep7idG4ey39yzzqAED1mmI8PdVfVIHhxyfAp3VyVw3J4Ataxuqtwlk
         ptC0ZDgqK2ItpaLizgTwZPNeIbXei03Bdq2V1dsqM2NNs/bS/QHKF6C95P79F3IydiK+
         IcjgbZeU+6jWLIOBFChncE5HcaOJW2qk5m1kggHcMu64ftRq0ooiw2Me6KuTkNZAkuWO
         X1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734461535; x=1735066335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0PRbBT67AMQWPupJ+gwKRks1p54D733VwXE8WQ/tWg=;
        b=sXWWgzytnXz3rN+Jxt0wEb4nyJkJNzJUOOLpPgLQOYfFs34HwbLD2L1kDagYibzh+J
         CUmt3izFeobFMzjS8YcGSNB4nDqDxGsXTQRvoKGEgTJxbxsXsFNFoajdoX7k6IklOHow
         7wluJ4qXhkGUtpsH9Klt+S9ufRSyYcNBwBmrqp+Mi8vxj0x3SRr934spCxSjjo+yU+Eh
         F8P15cgyo833kPgHynaFJ6nKyqrMMVNAnR3quC1FiV4Lniq/TSDdab4ILHsonFVBhuew
         KF8K4zv3+GC1H9wcir92Pg4zhLvYKw6hnIiM9jNPhhQWGjTWdKptQrXGobb1+lvaFHvt
         bObQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB3g3QcaRpC0k2vA4EimItbEpe6CuJDwt7AvzbuiHa8yZ6q+0PlgdwQcDYelSJzLNRQpYo4+a8tyjV2BhAIwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJrhQ2a90x8Xqw2H7B1CcYtgm1QfnDn1BmIrgndENqqtKOuXZR
	KTSbfpPJSfOR0ZFMDoDqLm8j9EfF7yxLIfwqRLXFt0oNPU99sQlKnnW23FxQD+w=
X-Gm-Gg: ASbGncvF4QZh5ow4UNBXwChoololSEfjTVLMT32DmMsyqjwW4ta9YlSAtK2niXiAdfK
	6ATB1JGjgbi1/TWfYM2cPOPEOW4g0IKkSKTqVOjMnVfJ3hNfZc0LM4/vvUTYklW477KYASiIHSE
	r6tmpZf5EntihlKH3sctmG3UaxXhvMS33sb0pJU4hwMFhLh5j/fzntb+g22jcPQfeioOoxyGNGK
	1U3i+xWN7w+yX8h3fs4uWloY1OhNvwx5e7Kdw7NwLSgY8Dqy+Z/yC5MfXosxb9gtYDS92RblqZ+
	TSVnHlgRjxXZxgcmp3vS1CdhAVUX4Tw/TrPMBPKtDZq1H63cazAkl93xDA==
X-Google-Smtp-Source: AGHT+IGWjTBAggxlYOhca+mmaXzqYmutnQWH338iqDJEIm7WyB5NMxjVXsnL8RcFVV3rxqsARYqldA==
X-Received: by 2002:a17:902:d4c8:b0:216:554a:212c with SMTP id d9443c01a7336-218c90099cbmr58724245ad.46.1734461535007;
        Tue, 17 Dec 2024 10:52:15 -0800 (PST)
Received: from sohamch-kvm.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dbb079sm62307715ad.31.2024.12.17.10.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:52:14 -0800 (PST)
From: Soham Chakradeo <sohamch.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Soham Chakradeo <sohamch@google.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/4] selftests/net: packetdrill: import tcp/fast_recovery, tcp/nagle, tcp/timestamping
Date: Tue, 17 Dec 2024 18:51:59 +0000
Message-ID: <20241217185203.297935-3-sohamch.kernel@gmail.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241217185203.297935-1-sohamch.kernel@gmail.com>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Soham Chakradeo <sohamch@google.com>

Use the standard import and testing method, as described in the
import of tcp/ecn , tcp/close , tcp/sack , tcp/tcp_info.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Soham Chakradeo <sohamch@google.com>
---
 .../tcp_fast_recovery_prr-ss-10pkt-lost-1.pkt |  72 +++++++++
 ...t_recovery_prr-ss-30pkt-lost-1_4-11_16.pkt |  50 ++++++
 ...tcp_fast_recovery_prr-ss-30pkt-lost1_4.pkt |  43 ++++++
 ...ecovery_prr-ss-ack-below-snd_una-cubic.pkt |  41 +++++
 .../packetdrill/tcp_nagle_https_client.pkt    |  40 +++++
 .../tcp_nagle_sendmsg_msg_more.pkt            |  66 ++++++++
 .../tcp_nagle_sockopt_cork_nodelay.pkt        |  43 ++++++
 ...tcp_timestamping_client-only-last-byte.pkt |  92 +++++++++++
 .../packetdrill/tcp_timestamping_partial.pkt  |  91 +++++++++++
 .../packetdrill/tcp_timestamping_server.pkt   | 145 ++++++++++++++++++
 10 files changed, 683 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-10pkt-lost-1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost-1_4-11_16.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost1_4.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-ack-below-snd_una-cubic.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_nagle_https_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_nagle_sendmsg_msg_more.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_nagle_sockopt_cork_nodelay.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_client-only-last-byte.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_partial.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_server.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-10pkt-lost-1.pkt b/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-10pkt-lost-1.pkt
new file mode 100644
index 000000000000..0d3c8077e830
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-10pkt-lost-1.pkt
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test PRR-slowstart implementation.
+// In this variant we test a simple case where in-flight == ssthresh
+// all the way through recovery, so during fast recovery we send one segment
+// for each segment SACKed/ACKed.
+
+// Set up config.
+`./defaults.sh`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+  +.1 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+// RTT 100ms
+  +.1 < . 1:1(0) ack 1 win 320
+   +0 accept(3, ..., ...) = 4
+
+// Send 10 data segments.
+   +0 write(4, ..., 10000) = 10000
+   +0 > P. 1:10001(10000) ack 1
+
+// Lost packet 1:1001.
+ +.11 < . 1:1(0) ack 1 win 320 <sack 1001:2001,nop,nop>
+ +.01 < . 1:1(0) ack 1 win 320 <sack 1001:3001,nop,nop>
+ +.01 < . 1:1(0) ack 1 win 320 <sack 1001:4001,nop,nop>
+// Enter fast recovery.
+   +0 > . 1:1001(1000) ack 1
+ +.01 %{
+assert tcpi_ca_state == TCP_CA_Recovery, tcpi_ca_state
+assert tcpi_snd_cwnd == 7, tcpi_snd_cwnd
+assert tcpi_snd_ssthresh == 7, tcpi_snd_ssthresh
+}%
+
+// Write some more, which we will send 1 MSS at a time,
+// as in-flight segments are SACKed or ACKed.
+ +.01 write(4, ..., 7000) = 7000
+
+ +.01 < . 1:1(0) ack 1 win 320 <sack 1001:5001,nop,nop>
+   +0 > . 10001:11001(1000) ack 1
+
+ +.01 < . 1:1(0) ack 1 win 320 <sack 1001:6001,nop,nop>
+   +0 > . 11001:12001(1000) ack 1
+
+ +.01 < . 1:1(0) ack 1 win 320 <sack 1001:7001,nop,nop>
+   +0 > . 12001:13001(1000) ack 1
+
+ +.01 < . 1:1(0) ack 1 win 320 <sack 1001:8001,nop,nop>
+   +0 > . 13001:14001(1000) ack 1
+
+ +.01 < . 1:1(0) ack 1 win 320 <sack 1001:9001,nop,nop>
+   +0 > . 14001:15001(1000) ack 1
+
+ +.01 < . 1:1(0) ack 1 win 320 <sack 1001:10001,nop,nop>
+   +0 > . 15001:16001(1000) ack 1
+
+ +.02 < . 1:1(0) ack 10001 win 320
+   +0 > P. 16001:17001(1000) ack 1
+// Leave fast recovery.
+ +.01 %{
+assert tcpi_ca_state == TCP_CA_Open, tcpi_ca_state
+assert tcpi_snd_cwnd == 7, tcpi_snd_cwnd
+assert tcpi_snd_ssthresh == 7, tcpi_snd_ssthresh
+}%
+
+ +.03 < . 1:1(0) ack 12001 win 320
+ +.02 < . 1:1(0) ack 14001 win 320
+ +.02 < . 1:1(0) ack 16001 win 320
+ +.02 < . 1:1(0) ack 17001 win 320
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost-1_4-11_16.pkt b/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost-1_4-11_16.pkt
new file mode 100644
index 000000000000..7842a10b6967
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost-1_4-11_16.pkt
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test PRR-slowstart implementation. The sender sends 20 packets. Packet
+// 1 to 4, and 11 to 16 are dropped.
+`./defaults.sh`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+ +.01 < . 1:1(0) ack 1 win 320
+   +0 accept(3, ..., ...) = 4
+
+// Write 20 data segments.
+   +0 write(4, ..., 20000) = 20000
+   +0 > P. 1:10001(10000) ack 1
+
+// Receive first DUPACK, entering PRR part
+ +.01 < . 1:1(0) ack 1 win 320 <sack 4001:5001,nop,nop>
+   +0 > . 10001:11001(1000) ack 1
++.002 < . 1:1(0) ack 1 win 320 <sack 4001:6001,nop,nop>
+   +0 > . 11001:12001(1000) ack 1
++.002 < . 1:1(0) ack 1 win 320 <sack 4001:7001,nop,nop>
+   +0 > . 1:1001(1000) ack 1
++.002 < . 1:1(0) ack 1 win 320 <sack 4001:8001,nop,nop>
+   +0 > . 1001:2001(1000) ack 1
++.002 < . 1:1(0) ack 1 win 320 <sack 4001:9001,nop,nop>
+   +0 > . 2001:3001(1000) ack 1
++.002 < . 1:1(0) ack 1 win 320 <sack 4001:10001,nop,nop>
+   +0 > . 3001:4001(1000) ack 1
+// Enter PRR CRB
++.002 < . 1:1(0) ack 1 win 320 <sack 4001:11001,nop,nop>
+   +0 > . 12001:13001(1000) ack 1
++.002 < . 1:1(0) ack 1 win 320 <sack 4001:12001,nop,nop>
+   +0 > . 13001:14001(1000) ack 1
+// Enter PRR slow start
+ +.01 < . 1:1(0) ack 1001 win 320 <sack 4001:12001,nop,nop>
+   +0 > P. 14001:16001(2000) ack 1
++.002 < . 1:1(0) ack 1001 win 320 <sack 2001:12001,nop,nop>
+   +0 > . 1001:2001(1000) ack 1
+   +0 > . 16001:17001(1000) ack 1
+// inflight reaches ssthresh, goes into packet conservation mode
++.002 < . 1:1(0) ack 1001 win 320 <sack 2001:13001,nop,nop>
+   +0 > . 17001:18001(1000) ack 1
++.002 < . 1:1(0) ack 1001 win 320 <sack 2001:14001,nop,nop>
+   +0 > . 18001:19001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost1_4.pkt b/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost1_4.pkt
new file mode 100644
index 000000000000..b66d7644c3b6
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-30pkt-lost1_4.pkt
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test PRR-slowstart implementation. The sender sends 20 packets. Packet
+// 1 to 4 are lost. The sender writes another 10 packets.
+`./defaults.sh`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+ +.01 < . 1:1(0) ack 1 win 320
+   +0 accept(3, ..., ...) = 4
+
+// Send 20 data segments.
+   +0 write(4, ..., 10000) = 10000
+   +0 > P. 1:10001(10000) ack 1
+
+// Lost packet 1,2,3,4
+ +.01 < . 1:1(0) ack 1 win 320 <sack 4001:5001,nop,nop>
++.002 < . 1:1(0) ack 1 win 320 <sack 4001:6001,nop,nop>
+   +0 < . 1:1(0) ack 1 win 320 <sack 4001:7001,nop,nop>
+   +0 > . 1:1001(1000) ack 1
+   +0 < . 1:1(0) ack 1 win 320 <sack 4001:8001,nop,nop>
+   +0 > . 1001:2001(1000) ack 1
+   +0 < . 1:1(0) ack 1 win 320 <sack 4001:9001,nop,nop>
+   +0 > . 2001:3001(1000) ack 1
+   +0 < . 1:1(0) ack 1 win 320 <sack 4001:10001,nop,nop>
+   +0 > . 3001:4001(1000) ack 1
+
+// Receiver ACKs all data.
+ +.01 < . 1:1(0) ack 1001 win 320 <sack 4001:10001,nop,nop>
+   +0 < . 1:1(0) ack 2001 win 320 <sack 4001:10001,nop,nop>
+   +0 < . 1:1(0) ack 3001 win 320 <sack 4001:10001,nop,nop>
+   +0 < . 1:1(0) ack 10001 win 320
+
+// Writes another 10 packets, which the ssthresh*mss amount
+// should be sent right away
+ +.01 write(4, ..., 10000) = 10000
+   +0 > . 10001:17001(7000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-ack-below-snd_una-cubic.pkt b/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-ack-below-snd_una-cubic.pkt
new file mode 100644
index 000000000000..8e87bfecabb5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fast_recovery_prr-ss-ack-below-snd_una-cubic.pkt
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test PRR-slowstart implementation.
+// In this variant we verify that the sender uses SACK info on an ACK
+// below snd_una.
+
+// Set up config.
+`./defaults.sh`
+
+// Establish a connection.
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 8>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+// RTT 10ms
+ +.01 < . 1:1(0) ack 1 win 320
+   +0 accept(3, ..., ...) = 4
+
+// Send 10 data segments.
+   +0 write(4, ..., 10000) = 10000
+   +0 > P. 1:10001(10000) ack 1
+
+// Lost packet 1:1001,4001:5001,7001:8001.
+ +.01 < . 1:1(0) ack 1 win 320 <sack 1001:2001,nop,nop>
+   +0 < . 1:1(0) ack 1 win 320 <sack 1001:3001,nop,nop>
+   +0 < . 1:1(0) ack 1 win 320 <sack 1001:3001 8001:9001,nop,nop>
+   +0 > . 1:1001(1000) ack 1
+
++.012 < . 1:1(0) ack 4001 win 320 <sack 8001:9001,nop,nop>
+   +0 > . 4001:7001(3000) ack 1
+
+   +0 write(4, ..., 10000) = 10000
+
+// The following ACK was reordered - delayed so that it arrives with
+// an ACK field below snd_una. Here we check that the newly-SACKed
+// 2MSS at 5001:7001 cause us to send out 2 more MSS.
++.002 < . 1:1(0) ack 3001 win 320 <sack 5001:7001,nop,nop>
+   +0 > . 7001:8001(1000) ack 1
+   +0 > . 10001:11001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_nagle_https_client.pkt b/tools/testing/selftests/net/packetdrill/tcp_nagle_https_client.pkt
new file mode 100644
index 000000000000..7adae7a9ef4a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_nagle_https_client.pkt
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+// This is a test inspired by an Android client app using SSL. This
+// test verifies using TCP_NODELAY would save application latency
+// (Perhaps even better with TCP_NAGLE).
+//
+`./defaults.sh
+ethtool -K tun0 tso off gso off
+./set_sysctls.py /proc/sys/net/ipv4/tcp_timestamps=0`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
+   +0 fcntl(4, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+   +0 setsockopt(4, SOL_TCP, TCP_NODELAY, [1], 4) = 0
+
+   +0 connect(4, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0 > S 0:0(0) <mss 1460,nop,nop,sackOK,nop,wscale 8>
+  +.1 < S. 0:0(0) ack 1 win 5792 <mss 974,nop,nop,sackOK,nop,wscale 7>
+   +0 > . 1:1(0) ack 1
+
+// SSL handshake (resumed session)
+   +0 write(4, ..., 517) = 517
+   +0 > P. 1:518(517) ack 1
+  +.1 < . 1:1(0) ack 518 win 229
+
+   +0 < P. 1:144(143) ack 1 win 229
+   +0 > . 518:518(0) ack 144
+   +0 read(4, ..., 1000) = 143
+
+// Application POST header (51B) and body (2002B)
+   +0 write(4, ..., 51) = 51
+   +0 > P. 518:569(51) ack 144
+ +.03 write(4, ..., 2002) = 2002
+   +0 > . 569:1543(974) ack 144
+   +0 > P. 1543:2517(974) ack 144
+// Without disabling Nagle, this packet will not happen until the remote ACK.
+   +0 > P. 2517:2571(54) ack 144
+
+  +.1 < . 1:1(0) ack 2571 win 229
+
+// Reset sysctls
+`/tmp/sysctl_restore_${PPID}.sh`
diff --git a/tools/testing/selftests/net/packetdrill/tcp_nagle_sendmsg_msg_more.pkt b/tools/testing/selftests/net/packetdrill/tcp_nagle_sendmsg_msg_more.pkt
new file mode 100644
index 000000000000..fa9c01813996
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_nagle_sendmsg_msg_more.pkt
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test the MSG_MORE flag will correctly corks the tiny writes
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 8>
+ +.01 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+// Disable Nagle by default on this socket.
+   +0 setsockopt(4, SOL_TCP, TCP_NODELAY, [1], 4) = 0
+
+// Test the basic case: MSG_MORE overwrites TCP_NODELAY and enables Nagle.
+   +0 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{..., 40}], msg_flags=0}, MSG_MORE) = 40
+ +.21~+.215 > P. 1:41(40) ack 1
+ +.01 < . 1:1(0) ack 41 win 257
+
+// Test unsetting MSG_MORE releases the packet
+   +0 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{..., 100}], msg_flags=0}, MSG_MORE) = 100
++.005 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{..., 160}], msg_flags=0}, MSG_MORE) = 160
+ +.01 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(3)=[{..., 100}, {..., 200}, {..., 195}],
+		  msg_flags=0}, MSG_MORE) = 495
++.008 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{..., 5}], msg_flags=0}, 0) = 5
+   +0 > P. 41:801(760) ack 1
+ +.02 < . 1:1(0) ack 801 win 257
+
+
+// Test >MSS write will unleash MSS packets but hold on the remaining data.
+  +.1 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{..., 3100}], msg_flags=0}, MSG_MORE) = 3100
+   +0 > . 801:3801(3000) ack 1
++.003 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{..., 50}], msg_flags=0}, MSG_MORE) = 50
+
+ +.01 < . 1:1(0) ack 2801 win 257
+// Err... we relase the remaining right after the ACK? note that PUSH is reset
+   +0 > . 3801:3951(150) ack 1
+
+// Test we'll hold on the subsequent writes when inflight (3801:3951) > 0
++.001 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{..., 1}], msg_flags=0}, MSG_MORE) = 1
++.002 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{..., 2}], msg_flags=0}, MSG_MORE) = 2
++.003 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{..., 3}], msg_flags=0}, MSG_MORE) = 3
++.004 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{..., 4}], msg_flags=0}, MSG_MORE) = 4
+ +.02 < . 1:1(0) ack 3951 win 257
+   +0 > . 3951:3961(10) ack 1
+ +.02 < . 1:1(0) ack 3961 win 257
+
+
+// Test the case a MSG_MORE send followed by a write flushes the data
+   +0 sendmsg(4, {msg_name(...)=...,
+                  msg_iov(1)=[{..., 20}], msg_flags=0}, MSG_MORE) = 20
+ +.05 write(4, ..., 20) = 20
+   +0 > P. 3961:4001(40) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_nagle_sockopt_cork_nodelay.pkt b/tools/testing/selftests/net/packetdrill/tcp_nagle_sockopt_cork_nodelay.pkt
new file mode 100644
index 000000000000..0ddec5f7dc1a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_nagle_sockopt_cork_nodelay.pkt
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test TCP_CORK and TCP_NODELAY sockopt behavior
+`./defaults.sh`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 8>
+ +.01 < . 1:1(0) ack 1 win 257
+   +0 accept(3, ..., ...) = 4
+// Set TCP_CORK sockopt to hold small packets
+   +0 setsockopt(4, SOL_TCP, TCP_CORK, [1], 4) = 0
+
+   +0 write(4, ..., 40) = 40
+ +.05 write(4, ..., 40) = 40
+
+// Unset TCP_CORK should push pending bytes out
+ +.01 setsockopt(4, SOL_TCP, TCP_CORK, [0], 4) = 0
+   +0 > P. 1:81(80) ack 1
+ +.01 < . 1:1(0) ack 81 win 257
+
+// Set TCP_CORK sockopt to hold small packets
+   +0 setsockopt(4, SOL_TCP, TCP_CORK, [1], 4) = 0
+
+   +0 write(4, ..., 40) = 40
+ +.05 write(4, ..., 40) = 40
+
+// Set TCP_NODELAY sockopt should push pending bytes out
+   +0 setsockopt(4, SOL_TCP, TCP_NODELAY, [1], 4) = 0
+   +0 > P. 81:161(80) ack 1
+ +.01 < . 1:1(0) ack 161 win 257
+
+// Set MSG_MORE to hold small packets
+   +0 send(4, ..., 40, MSG_MORE) = 40
+ +.05 send(4, ..., 40, MSG_MORE) = 40
+
+// Set TCP_NODELAY sockopt should push pending bytes out
+ +.01 setsockopt(4, SOL_TCP, TCP_NODELAY, [1], 4) = 0
+   +0 > . 161:241(80) ack 1
+ +.01 < . 1:1(0) ack 241 win 257
diff --git a/tools/testing/selftests/net/packetdrill/tcp_timestamping_client-only-last-byte.pkt b/tools/testing/selftests/net/packetdrill/tcp_timestamping_client-only-last-byte.pkt
new file mode 100644
index 000000000000..2087ec0c746a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_timestamping_client-only-last-byte.pkt
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test that tx timestamping sends timestamps only for
+// the last byte of each sendmsg.
+`./defaults.sh
+`
+
+// Create a socket and set it to non-blocking.
+    0	socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0	fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
+   +0	fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+
+// Establish connection and verify that there was no error.
+   +0	connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0 > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+ +.01 < S. 0:0(0) ack 1 win 20000 <mss 1000,nop,nop,sackOK>
+   +0 > . 1:1(0) ack 1
+   +0	getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
+   +0	fcntl(3, F_SETFL, O_RDWR) = 0   // set back to blocking
+
+   +0	setsockopt(3, SOL_SOCKET, SO_TIMESTAMPING,
+		   [SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_SOFTWARE |
+		    SOF_TIMESTAMPING_TX_ACK | SOF_TIMESTAMPING_SOFTWARE |
+		    SOF_TIMESTAMPING_OPT_ID], 4) = 0
+
+   +0	write(3, ..., 11000) = 11000
+   +0	> P. 1:10001(10000) ack 1
+ +.01	< . 1:1(0) ack 10001 win 4000
+   +0	> P. 10001:11001(1000) ack 1
+ +.01	< . 1:1(0) ack 11001 win 4000
+
+// Make sure that internal TCP timestamps are not overwritten and we have sane
+// RTT measurement.
+   +0	%{
+assert 5000 <= tcpi_rtt <= 20000, 'srtt=%d us' % tcpi_rtt
+}%
+
+// SCM_TSTAMP_SCHED for the last byte should be received almost immediately
+// once 10001 is acked at t=20ms.
+// setsockopt(..., [SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_OPT_ID], ...)
+// is called after when SYN is acked. So, we expect the last byte of the first
+// chunk to have a timestamp key of 10999 (i.e., 11000 - 1).
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=20000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_SCHED,
+				    ee_data=10999}}
+		    ]}, MSG_ERRQUEUE) = 0
+// SCM_TSTAMP_SND for the last byte should be received almost immediately
+// once 10001 is acked at t=20ms.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=20000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_SND,
+				    ee_data=10999}}
+		    ]}, MSG_ERRQUEUE) = 0
+// SCM_TSTAMP_ACK for the last byte should be received at t=30ms.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=30000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_ACK,
+				    ee_data=10999}}
+		    ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_timestamping_partial.pkt b/tools/testing/selftests/net/packetdrill/tcp_timestamping_partial.pkt
new file mode 100644
index 000000000000..876024a31110
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_timestamping_partial.pkt
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test tx timestamping for partial writes (IPv4).
+`./defaults.sh
+`
+
+// Create a socket and set it to non-blocking.
+    0	socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0	fcntl(3, F_GETFL) = 0x2 (flags O_RDWR)
+   +0	fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0
+
+// Establish connection and verify that there was no error.
+   +0	connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)
+   +0	> S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+ +.01	< S. 0:0(0) ack 1 win 2000 <mss 1000,sackOK,TS val 700 ecr 100,nop,wscale 7>
+   +0	> . 1:1(0) ack 1 <nop,nop,TS val 200 ecr 700>
+   +0	getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
+
+   +0	setsockopt(3, SOL_SOCKET, SO_SNDBUF, [1000], 4) = 0
+   +0	setsockopt(3, SOL_SOCKET, SO_TIMESTAMPING,
+		   [SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_SOFTWARE |
+		    SOF_TIMESTAMPING_TX_ACK | SOF_TIMESTAMPING_SOFTWARE |
+		    SOF_TIMESTAMPING_OPT_ID], 4) = 0
+
+// We have a partial write.
+   +0	write(3, ..., 10000) = 2964
+   +0	> . 1:989(988) ack 1 <nop,nop,TS val 110 ecr 700>
+   +0	> P. 989:1977(988) ack 1 <nop,nop,TS val 110 ecr 700>
+ +.01	< . 1:1(0) ack 1977 win 92 <nop,nop,TS val 800 ecr 200>
+   +0	> P. 1977:2965(988) ack 1 <nop,nop,TS val 114 ecr 800>
+ +.01	< . 1:1(0) ack 2965 win 92 <nop,nop,TS val 800 ecr 200>
+
+// Make sure that internal TCP timestamps are not overwritten and we have sane
+// RTT measurement.
+   +0	%{
+assert 5000 <= tcpi_rtt <= 20000, 'srtt=%d us' % tcpi_rtt
+}%
+
+// SCM_TSTAMP_SCHED for the first chunk should be received almost immediately
+// after the first ack at t=20ms.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=20000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_SCHED,
+				    ee_data=2963}}
+		    ]}, MSG_ERRQUEUE) = 0
+// SCM_TSTAMP_SND for the first chunk should be received almost immediately
+// after the first ack at t=20ms.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=20000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_SND,
+				    ee_data=2963}}
+		    ]}, MSG_ERRQUEUE) = 0
+// SCM_TSTAMP_ACK for the first chunk should be received after the last ack at
+// t=30ms.
+   +0	recvmsg(3, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=30000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_ACK,
+				    ee_data=2963}}
+		    ]}, MSG_ERRQUEUE) = 0
diff --git a/tools/testing/selftests/net/packetdrill/tcp_timestamping_server.pkt b/tools/testing/selftests/net/packetdrill/tcp_timestamping_server.pkt
new file mode 100644
index 000000000000..84d94780e6be
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_timestamping_server.pkt
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+// Test tx timestamping for server-side (IPv4).
+`./defaults.sh
+`
+
+// Initialize connection
+    0	socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0	setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0	bind(3, ..., ...) = 0
+   +0	listen(3, 1) = 0
+
+   +0	< S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 10>
+   +0	> S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+ +.01	< . 1:1(0) ack 1 win 514
+
+   +0	accept(3, ..., ...) = 4
+   +0	setsockopt(4, SOL_SOCKET, SO_TIMESTAMPING,
+		   [SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_SOFTWARE |
+		    SOF_TIMESTAMPING_TX_ACK | SOF_TIMESTAMPING_SOFTWARE |
+		    SOF_TIMESTAMPING_OPT_ID], 4) = 0
+
+// Write two 2KB chunks.
+// setsockopt(..., [SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_OPT_ID], ...)
+// is called after when SYN is acked. So, we expect the last byte of the first
+// and the second chunks to have timestamp keys of 1999 (i.e., 2000 - 1) and
+// 3999 (i.e., 4000 - 1) respectively.
+   +0	write(4, ..., 2000) = 2000
+   +0	write(4, ..., 2000) = 2000
+   +0	> P. 1:2001(2000) ack 1
+   +0	> P. 2001:4001(2000) ack 1
+ +.01	< .  1:1(0) ack 2001 win 514
+ +.01	< .  1:1(0) ack 4001 win 514
+
+// Make sure that internal TCP timestamps are not overwritten and we have sane
+// RTT measurement.
+   +0	%{
+assert 5000 <= tcpi_rtt <= 20000, 'srtt=%d us' % tcpi_rtt
+}%
+
+// SCM_TSTAMP_SCHED for the first chunk should be received almost immediately
+// after write at t=10ms.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=10000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_SCHED,
+				    ee_data=1999}}
+		    ]}, MSG_ERRQUEUE) = 0
+// SCM_TSTAMP_SND for the first chunk should be received almost immediately
+// after write at t=10ms.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=10000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_SND,
+				    ee_data=1999}}
+		    ]}, MSG_ERRQUEUE) = 0
+// SCM_TSTAMP_SCHED for the second chunk should be received almost immediately
+// after that at t=10ms.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=10000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_SCHED,
+				    ee_data=3999}}
+		    ]}, MSG_ERRQUEUE) = 0
+// SCM_TSTAMP_SND for the second chunk should be received almost immediately
+// after that at t=10ms.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=10000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_SND,
+				    ee_data=3999}}
+		    ]}, MSG_ERRQUEUE) = 0
+// SCM_TSTAMP_ACK for the first chunk should be received at t=20ms.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=20000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_ACK,
+				    ee_data=1999}}
+		    ]}, MSG_ERRQUEUE) = 0
+// SCM_TSTAMP_ACK for the second chunk should be received at t=30ms.
+   +0	recvmsg(4, {msg_name(...)=...,
+		    msg_iov(1)=[{...,0}],
+                    msg_flags=MSG_ERRQUEUE|MSG_TRUNC,
+                    msg_control=[
+			{cmsg_level=SOL_SOCKET,
+			 cmsg_type=SCM_TIMESTAMPING,
+			 cmsg_data={scm_sec=0,scm_nsec=30000000}},
+			{cmsg_level=CMSG_LEVEL_IP,
+			 cmsg_type=CMSG_TYPE_RECVERR,
+			 cmsg_data={ee_errno=ENOMSG,
+				    ee_origin=SO_EE_ORIGIN_TIMESTAMPING,
+				    ee_type=0,
+				    ee_code=0,
+				    ee_info=SCM_TSTAMP_ACK,
+				    ee_data=3999}}
+		    ]}, MSG_ERRQUEUE) = 0
-- 
2.47.1.613.gc27f4b7a9f-goog


