Return-Path: <linux-kselftest+bounces-6585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A224588B315
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 22:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E900BC40DAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65509129E79;
	Mon, 25 Mar 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXne0SNI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242F129E67;
	Mon, 25 Mar 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391226; cv=none; b=TJH4ZjQ0Kj0ejdoEabOVOc+ic8qt2FznKnkEA5ClHhlP9hxr35NF+dhfP9Y7EXfb+gnvNXHjsi2KapfjAvF89IOP+tNXpzF2Pq5vhCMo3MAknZ+HY7PPmMW1qcovpPtD359JkEeRHoRCmfV4wOWR5U1T5BhkERa9SYPSlJBze7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391226; c=relaxed/simple;
	bh=NrcAerk47w27oWd1NCrR1BDGPLWNDfTO1kj4vuxU04c=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P9VXsGoM7oCzcYJtu5etBfRfxm73Qffcfe8aL9Pw2nd2iOrMO0HO5FsHxABMmclBQ451eG1xxZQLPWE1P/XyJ7iVd4rpbxZEmftio+gr/zLHTrWGnxSst5S/QCD4RVSI8PtW8xLLrQUyh/Drbtm/wOI/1zdrdG/Nfp6MdoDP6QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXne0SNI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4148c95db1fso1909935e9.0;
        Mon, 25 Mar 2024 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711391223; x=1711996023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fjur1Hg//VxIhCvXN4J/88F6wnM642w5BcLBrjCUoY0=;
        b=fXne0SNIKAmtMVUO/DUtvKfM5srsT9ZHA0AaJfwgwXausdNr6LfVrrW7uLd/FfY/N9
         93S+in5bc5j04hOnm0NO3wJB0TyxqknKOyn91Rd7QOl32C3HeDSR6CLBLfFJ+VZbya+I
         hNB+x8H4g1ujYHLDOtRAHFcRQibp4XOnNKt3lqA7Oli8qlwCbE0lkrYW4i5pQSi2PJ1t
         D0RuDGpzjVQzNkH4sVXsjDhv0mp7g68KcSULBI/Xdy37/6WEXyLBGTslPCGKOJe09BF7
         UbYowS2DhOB5pWaCFkFGt2YTSbMFHslKL4v7tCVU7STQ8sBKz3IMZ8uAi4JXpfnGCfgz
         4pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391223; x=1711996023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fjur1Hg//VxIhCvXN4J/88F6wnM642w5BcLBrjCUoY0=;
        b=Z6HFQlBaA2GVWErqm8feAiYZ0bYfw8TYUXJMysT5uJI7bnR4ydikYPpc0pRhPEoFMm
         RH+O8tZE7CYjOU9bgvH+YqiMj0LZcZM+T0l60w3dSLLnJC6l0EDbJ+pWInRyR0Xku3Sp
         IhJ1x99g1gCfKvSXBxHxDNMkbaKQvAI+uckGDo+5egf2yIkFLksjb9o0pLUdCw80shK3
         CSS1Yirt67mGQnVXLohUr+0INviEJG2NyL3POr/LVYXoVR17VVISgtYqyQW0dL8m4YzO
         rbVlzc1enqbestn9o+KenWPPW0ZkNPZvrrlHUWv1JU9sbU1xEzJFQPGHvZbUqif1FsIK
         m+Og==
X-Forwarded-Encrypted: i=1; AJvYcCWQU1PhwyuRlci3QTUxgcmuaW2a9I+lO+ZHgEff7Y+1Un9SF8mJRZLv4PEh3rdWRteLUDvM7nFmfi6niIYRyzC92mi/zV4wzA24CTLIpFbZcKSYVi8KgJUYF0EL5WrY0AXMc6UJdcpt2VpYhCVPnHymGQNOEttW5iT8k4cgmnWaPRT6Litx
X-Gm-Message-State: AOJu0YxDVjqJ8rrLziDIemVsmj1xnk+rhe3TFLOmiBtT5XTdJx8JRwWy
	YTw4UmSsICotjTwSYg0AOKjrHl6pE07C4iNvXSvK2vedyqwRUOje
X-Google-Smtp-Source: AGHT+IG4X6gQBBS5WMmkuTXpBuhscwtyPphY8z0vjMtllUvIPwyGhqcvpadmfaGOQWCnYo0h2XxdkQ==
X-Received: by 2002:a05:600c:3582:b0:414:8889:5a65 with SMTP id p2-20020a05600c358200b0041488895a65mr3677558wmq.30.1711391223005;
        Mon, 25 Mar 2024 11:27:03 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b00414896b61e4sm4233172wmo.16.2024.03.25.11.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:27:02 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	xeb@mail.ru,
	shuah@kernel.org,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	petrm@nvidia.com,
	jbenc@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	liujian56@huawei.com,
	horms@kernel.org,
	linyunsheng@huawei.com,
	richardbgobert@gmail.com,
	therbert@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 2/4] selftests/net: add local address bind in vxlan selftest
Date: Mon, 25 Mar 2024 19:25:41 +0100
Message-Id: <20240325182543.87683-3-richardbgobert@gmail.com>
In-Reply-To: <20240325182543.87683-1-richardbgobert@gmail.com>
References: <20240325182543.87683-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add local address bind support to existing udpgro_fwd.sh vxlan selftest, to
ensure UDP socket lookup in GRO is working.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 tools/testing/selftests/net/udpgro_fwd.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 380cb15e942e..0541c5da571d 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -62,11 +62,13 @@ create_vxlan_endpoint() {
 	local -r bm_rem_addr=$3
 	local -r vxlan_dev=$4
 	local -r vxlan_id=$5
+	local -r bm_local_addr=$6
 	local -r vxlan_port=4789
 
 	ip -n $netns link set dev $bm_dev up
 	ip -n $netns link add dev $vxlan_dev type vxlan id $vxlan_id \
-				dstport $vxlan_port remote $bm_rem_addr
+				dstport $vxlan_port local $bm_local_addr \
+				remote $bm_rem_addr
 	ip -n $netns link set dev $vxlan_dev up
 }
 
@@ -77,11 +79,13 @@ create_vxlan_pair() {
 
 	for ns in $SRC $DST; do
 		# note that 3 - $SRC == $DST and 3 - $DST == $SRC
-		create_vxlan_endpoint $BASE$ns veth$ns $BM_NET_V4$((3 - $ns)) vxlan$ns 4
+		create_vxlan_endpoint $BASE$ns veth$ns $BM_NET_V4$((3 - $ns)) \
+					vxlan$ns 4 $BM_NET_V4$ns
 		ip -n $BASE$ns addr add dev vxlan$ns $OL_NET_V4$ns/24
 	done
 	for ns in $SRC $DST; do
-		create_vxlan_endpoint $BASE$ns veth$ns $BM_NET_V6$((3 - $ns)) vxlan6$ns 6
+		create_vxlan_endpoint $BASE$ns veth$ns $BM_NET_V6$((3 - $ns)) \
+					vxlan6$ns 6 $BM_NET_V6$ns
 		ip -n $BASE$ns addr add dev vxlan6$ns $OL_NET_V6$ns/24 nodad
 	done
 
-- 
2.36.1


