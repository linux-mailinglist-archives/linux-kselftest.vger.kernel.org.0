Return-Path: <linux-kselftest+bounces-15299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014AF9515F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 09:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2BC1F21235
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 07:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C113CA8D;
	Wed, 14 Aug 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCtj5pom"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BE86126;
	Wed, 14 Aug 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622308; cv=none; b=ghXC+iiPrZHjazcVxf/374A9Km4vIjzfAhyZxPbSguX7cQfUtPVkfVRg9Mts293hjKFAVbr16qVM8XBF0Zgr2ww9fnskPKghBTd0bzi7u/J33h16SOb6uPl8J+g50kTQbxO4c5NkOmpaXSwshB/jUcTM7ySSssNrlhUGRTndy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622308; c=relaxed/simple;
	bh=XA4FuhAbYIR72eTUkVqKk9ZGeMdoU6XigImPQRHsckU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4oQEefFsJpDDHmLs0gOq914WLRpjuLSjbBkPBizctzr3GClAQe5dWXjrmJYVEWOTsWGNbz8XfBLNjr7S8oUYG1mf4vczV6+nKwklgM7cLf/uU5JjJwvPHjX2Mx0/Og5Ifh1EcTBHBfeLosUbmB6WcIdcvHcrXG+ajo4xfbhK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCtj5pom; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fed72d23a7so49438695ad.1;
        Wed, 14 Aug 2024 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723622306; x=1724227106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTAuy4aMmf6dNIOMUBBz92urtgYt3g8K39lJ/9I+Ys8=;
        b=SCtj5pomK3REVEHbAOPDSCxbhNRrd9UmIIq6iptE8cIja+wg9tPSw9jBn38L0hNxcv
         yZTik1NCGb74BGT2pur5TgTQJCDnsFDHOqF3R+K4K1ogixOSmYtNLSlj4gacnHSpB7/G
         wzBEDdde/UEMw16usxW8Pc/7GQMFFmzEtnSXYKwJ5wSiCpH62ePB8pRCwwhZxPA5jjND
         oJA7YLvwgC3zGSIHUImEVAz9ojtXikbUnhwgRa2oKNLzud0OT9RG9Y3YAK3J85iPYomJ
         ou2mhg6/EVy1dF/gZ1WugTQnVFFP0vEGF3LQQd0DbCUOuIyMfZSO3wNfn8mUgAbYxJq6
         xerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622306; x=1724227106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTAuy4aMmf6dNIOMUBBz92urtgYt3g8K39lJ/9I+Ys8=;
        b=dsyvCxO1PDuUX+adtiuKWSxWuDSqaG6qdfealCfrUGw1NG8EtnhrTvVER6Ks7vvlKh
         5llQLV2DQcAcwE/5Z+7s0wxrRsdxXByE4suWxKSRnwA6AWHc2rQmkAGcPU/BwikxSiLM
         n2oFyOrHTJpAsYRIUrcB+BM5mS5nwXZtwRxOY3y4APxsXjl40/6d9CjLYC7xhpCzeIMC
         GwwTyYZR9cIPzf2BNovLoVg7AVz7bb/NpS6gotC/Z9458p8mSq7xe0/mN8a/sGPgcI2U
         vnX0a8DZXa5HX09a9j97QN1n2LyDANggq28QQkXqfr/M7WtiHJSYjhHSlu7lR6c9ZeVN
         cLtA==
X-Forwarded-Encrypted: i=1; AJvYcCUHrrIee5ni6Byrffm7VIiJfzC55StZaGwPXibHmBUK4MID04oQkeVconH546PAnI8RLk/SPBqL1yDcDwQ3c45C@vger.kernel.org, AJvYcCXi7FOWeiTPD/i48v5iZ1s3+Fj8OP89gYXZ8wLx8QQXISBD0/Hrtqc+j3lQkIcChTQYLA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+diLyQipUdmAVt/uPA7A38s7MD/pCXz3acECtdt2WN1bF3MG
	li/ENG9SFsXvytwPYpZd38iaP8MUTmZlW6ksVwaq7nBt5OazuvlkJ7sWbuiMOAOxcQ==
X-Google-Smtp-Source: AGHT+IEEqCGDP+e5jNYfjRLigIHq/wRzyFGv0oor8MDcG4YJpbEvlZx4bFoO9OKcgn1YhMx6wu3F7Q==
X-Received: by 2002:a17:902:ec89:b0:1ff:5049:7353 with SMTP id d9443c01a7336-201d641e7b1mr24774595ad.19.1723622305756;
        Wed, 14 Aug 2024 00:58:25 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1ba02bsm24475865ad.229.2024.08.14.00.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:58:25 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Yi Chen <yiche@redhat.com>
Subject: [PATCH net 2/2] selftests: udpgro: no need to load xdp for gro
Date: Wed, 14 Aug 2024 15:57:58 +0800
Message-ID: <20240814075758.163065-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240814075758.163065-1-liuhangbin@gmail.com>
References: <20240814075758.163065-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit d7db7775ea2e ("net: veth: do not manipulate GRO when using
XDP"), there is no need to load XDP program to enable GRO. On the other
hand, the current test is failed due to loading the XDP program. e.g.

 # selftests: net: udpgro.sh
 # ipv4
 #  no GRO                                  ok
 #  no GRO chk cmsg                         ok
 #  GRO                                     ./udpgso_bench_rx: recv: bad packet len, got 1472, expected 14720
 #
 # failed

 [...]

 #  bad GRO lookup                          ok
 #  multiple GRO socks                      ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
 #
 # ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
 #
 # failed
 ok 1 selftests: net: udpgro.sh

After fix, all the test passed.

 # ./udpgro.sh
 ipv4
  no GRO                                  ok
  [...]
  multiple GRO socks                      ok

Fixes: d7db7775ea2e ("net: veth: do not manipulate GRO when using XDP")
Reported-by: Yi Chen <yiche@redhat.com>
Closes: https://issues.redhat.com/browse/RHEL-53858
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/udpgro.sh | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index 7e0164247b83..180b337c8345 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -7,8 +7,6 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="xdp_dummy.bpf.o"
-
 # set global exit status, but never reset nonzero one.
 check_err()
 {
@@ -38,7 +36,7 @@ cfg_veth() {
 	ip -netns "${PEER_NS}" addr add dev veth1 192.168.1.1/24
 	ip -netns "${PEER_NS}" addr add dev veth1 2001:db8::1/64 nodad
 	ip -netns "${PEER_NS}" link set dev veth1 up
-	ip -n "${PEER_NS}" link set veth1 xdp object ${BPF_FILE} section xdp
+	ip netns exec "${PEER_NS}" ethtool -K veth1 gro on
 }
 
 run_one() {
@@ -203,11 +201,6 @@ run_all() {
 	return $ret
 }
 
-if [ ! -f ${BPF_FILE} ]; then
-	echo "Missing ${BPF_FILE}. Run 'make' first"
-	exit -1
-fi
-
 if [[ $# -eq 0 ]]; then
 	run_all
 elif [[ $1 == "__subprocess" ]]; then
-- 
2.45.0


