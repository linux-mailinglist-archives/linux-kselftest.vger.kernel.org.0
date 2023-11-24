Return-Path: <linux-kselftest+bounces-533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF23A7F6FC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D0D1C21019
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ABF156E4;
	Fri, 24 Nov 2023 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0NN7SJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42C1D6F;
	Fri, 24 Nov 2023 01:30:06 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cf50cc2f85so13552555ad.1;
        Fri, 24 Nov 2023 01:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818206; x=1701423006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci5yrPXMK7JbDee2XoLENdxUuJ5NU/YtY7hyLE1ocaI=;
        b=m0NN7SJVWzK3NnPeLhGiBmp3yjN8zLeaJ8BuBJ4T+baQO1NROM6uSOOzwb2qn1pIHU
         LGCr01bUvHnq1++8X0L+UN6pxpKjlTB6nhy6bgiAj+vl8MT5+hEdtf6Mvn8X9UngJRgX
         3dSYe5u7gJXvHfqIIIS5zJiDe+ZCrf1lwMMEeuWEiIjJHqGnfeXaC76zRy+tA9UdczdL
         Wzef/QyGiU1t2WHd5+MHDW6cVKVTM+NP21aHNfQjd5xdBekZYsqaTSJP0mpxdTmbT++o
         fOzi4jJjdxFpltW6PUj7JYtwpO1IjNxn6kO1REjOAfnhZ6XjLpEbgHQtcR5x9CIP+FU3
         PBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818206; x=1701423006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ci5yrPXMK7JbDee2XoLENdxUuJ5NU/YtY7hyLE1ocaI=;
        b=L8nogUQ1URAJ7G2mlhiauIFYlr0YKSFgC3Y+mrPbYAqpeziF8rczLya/4GIhG1zZJo
         e4XxoYgn8bKG4e92jO4sOp1b6ONoSv6t4Qon5oOpWHRgH77piaaOvd/t3vX0zmXMIou3
         9mmuxEk9GKzQ7JNWR5ZxIP+zC9aI0WxSAbeKUrB03trAACKmNNGFzdEZbxs4FcRAlnbo
         D8Coj9hFzMOu2QW+eRCbSYnhmwusjevWlbf+f2qGMQ2J1MoULwBGsTOiyrapzPAwGE0G
         g/RctEgRBJ1e2S01g0bPPntIsgWNqP/peVPeLqlGmruKrmfiEleHmPIQdnDmiVCfiJRu
         C/lQ==
X-Gm-Message-State: AOJu0YwcW9nXIIZeBGW75oY3JF+FNP8Vdts0SeIy8MRZ7MnRjK215AMk
	cagmRN56rpm38nOZeutBw+VrHKgl0hfzWNz5
X-Google-Smtp-Source: AGHT+IEXEfQe9hlVgUhwd3FdvXAjbiYKqpwhOiXcxB5RE4LP1IKW3QBruAckNKh2o2MpWYdYVlLymQ==
X-Received: by 2002:a17:903:2003:b0:1ca:57ff:9bfa with SMTP id s3-20020a170903200300b001ca57ff9bfamr1758717pla.24.1700818205846;
        Fri, 24 Nov 2023 01:30:05 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:30:05 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 31/38] selftests/net: convert toeplitz.sh to run it in unique namespace
Date: Fri, 24 Nov 2023 17:27:29 +0800
Message-ID: <20231124092736.3673263-32-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231124092736.3673263-1-liuhangbin@gmail.com>
References: <20231124092736.3673263-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have no valid NIC for testing, but the result looks good.

]# ./toeplitz.sh -i eno1 -t -6
carrier ready
count: pass=0 nohash=0 fail=0
./toeplitz: too few frames for verification
setup_loopback.sh: line 68: 902542 Killed                  ip netns exec $client_ns ./toeplitz_client.sh "${PROTO_FLAG}" "${IP_FLAG}" "${SERVER_IP%%/*}" "${PORT}"
carrier ready

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/toeplitz.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/toeplitz.sh b/tools/testing/selftests/net/toeplitz.sh
index da5bfd834eff..4a70c9c6ad1c 100755
--- a/tools/testing/selftests/net/toeplitz.sh
+++ b/tools/testing/selftests/net/toeplitz.sh
@@ -12,6 +12,7 @@
 # [(-rss -irq_prefix <irq-pattern-prefix>)|(-rps <rps_map>)]
 
 source setup_loopback.sh
+source lib.sh
 readonly SERVER_IP4="192.168.1.200/24"
 readonly SERVER_IP6="fda8::1/64"
 readonly SERVER_MAC="aa:00:00:00:00:02"
@@ -146,15 +147,16 @@ parse_opts() {
 setup() {
 	setup_loopback_environment "${DEV}"
 
+	setup_ns server_ns client_ns
 	# Set up server_ns namespace and client_ns namespace
-	setup_macvlan_ns "${DEV}" server_ns server \
+	setup_macvlan_ns "${DEV}" $server_ns server \
 	"${SERVER_MAC}" "${SERVER_IP}"
-	setup_macvlan_ns "${DEV}" client_ns client \
+	setup_macvlan_ns "${DEV}" $client_ns client \
 	"${CLIENT_MAC}" "${CLIENT_IP}"
 }
 
 cleanup() {
-	cleanup_macvlan_ns server_ns server client_ns client
+	cleanup_macvlan_ns $server_ns server $client_ns client
 	cleanup_loopback "${DEV}"
 }
 
@@ -170,22 +172,22 @@ if [[ "${TEST_RSS}" = true ]]; then
 	# RPS/RFS must be disabled because they move packets between cpus,
 	# which breaks the PACKET_FANOUT_CPU identification of RSS decisions.
 	eval "$(get_disable_rfs_cmd) $(get_disable_rps_cmd)" \
-	  ip netns exec server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
+	  ip netns exec $server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
 	  -d "${PORT}" -i "${DEV}" -k "${KEY}" -T 1000 \
 	  -C "$(get_rx_irq_cpus)" -s -v &
 elif [[ ! -z "${RPS_MAP}" ]]; then
 	eval "$(get_disable_rfs_cmd) $(get_set_rps_bitmaps_cmd ${RPS_MAP})" \
-	  ip netns exec server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
+	  ip netns exec $server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
 	  -d "${PORT}" -i "${DEV}" -k "${KEY}" -T 1000 \
 	  -r "0x${RPS_MAP}" -s -v &
 else
-	ip netns exec server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
+	ip netns exec $server_ns ./toeplitz "${IP_FLAG}" "${PROTO_FLAG}" \
 	  -d "${PORT}" -i "${DEV}" -k "${KEY}" -T 1000 -s -v &
 fi
 
 server_pid=$!
 
-ip netns exec client_ns ./toeplitz_client.sh "${PROTO_FLAG}" \
+ip netns exec $client_ns ./toeplitz_client.sh "${PROTO_FLAG}" \
   "${IP_FLAG}" "${SERVER_IP%%/*}" "${PORT}" &
 
 client_pid=$!
-- 
2.41.0


