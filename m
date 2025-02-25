Return-Path: <linux-kselftest+bounces-27402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A38A43300
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93436189816C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 02:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2107E13DDAE;
	Tue, 25 Feb 2025 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/3/fG2v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6067112EBE7;
	Tue, 25 Feb 2025 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450279; cv=none; b=opfiAc4/aKnKDbpXU50L4EEf3Bj9CfenDFhoj6tpMw0uTCpBynwBatmknUWPH1gc7TIek1ZqnWkYBS1QBo18Q4w7RlipeNKQERpV7MxPEHtdUw8nzN95lGqUuBgREm8WIuhodYq0mYDlo3TykzRcrhk7kGy3CRKII3PzCVV3JnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450279; c=relaxed/simple;
	bh=38PmCjELOXpq99eCBzMiLwN/UfCC74U6qfz7/q8RtS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpdKEtaAt82BANk4+BIzotZa/vAuTfWYsl9lwXItRk0nOSLXou3ZE+qejcsh0Kxmnsw5h+nk1qb8Fx8uTAe/aKRttAVovGCfAREsrFRyhPUXbf6iGmIOqFrZAYRBgz6A28DQUJLTg8KCgSPEO6IO5OvcmeiBJdRuPa7wXXbrWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/3/fG2v; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e65e0a3f7eso23427536d6.0;
        Mon, 24 Feb 2025 18:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740450276; x=1741055076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRiaOBsQHuFXfngFpQveqo7YufU4TbS+G+vYc7HzHAA=;
        b=X/3/fG2vrRDt9o2rixkJEsEWd7ySrOiBDyvcrY5bOdzFYfl0Oe0sskVVVM9mDe4g0B
         UBwh5F+7bjsWqSGwdN0RqxSpPFyqjMjJ3LcPtr850unP+DjJEeHkZYlnHTanPwFiIZLn
         a5utxe95dbzJUrlgCdK4ZrHuI5/xaNj4nDbXrc2ot6H3eYCsd316X8jsyJ7ZpKpCAlCE
         D0iGEV5upUxiUFHyrSWhKbSoWLxRj48WZu1IWpDljxt4TCbpdRHAS3DuZTg+lAO+Atlj
         njFRGTSh0kLMkgLKvxdzR/mH2qHQNskLnw5gxWGjRKsf/5H1Rm3hXwoEKoWZfKjuv23g
         4zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740450276; x=1741055076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRiaOBsQHuFXfngFpQveqo7YufU4TbS+G+vYc7HzHAA=;
        b=nslZiTdJEe82DhJBsIuR34b/mqqnzneHJX0RdoquWx8ZbohIwcZxdKtX/4m1Y/ceMS
         UCDpB9876fa8vt1GT7WXccYVUtiv3cubFExgQhmbnktB1yP2F1XejrWsDvbxm6KglkAR
         KGBX9JerGObux5WxCOvBAW+vbk1DvJJQPF2GiQcKCQrU6SkDCMjovU/AwASl4IPbjd4B
         LffZ8TDKStj1LgJKCjjbeNVb70uaM5wW+0G0+kjdDf1J1aagqSzrLx9cpcJ1pV6FhO7M
         pjvhegohsjD5iEVc63H/wsn4+EXcwHqV2TmZqCX9XM32Qqi53HIbzkL3pNF2KB+kqkSO
         d4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4Df41JfOcKjCsy9YThkUuTvQeqqRp53VSsSY61Qu6da0+D3kdLudxN6T1a1f/pvGUqN77AHHc7CzyTNhLvyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTnWc/acNew2CLWhMLSGJDhhvj/wSmJQhOVhBJvhLTF3k7BDC
	LaYnAwKduH4QKa+MsPljXWICIBi2PDvUqBSla9rHkgi+9j4n/WBVVtTPAg==
X-Gm-Gg: ASbGncvEX5Bt12+D+J8h2Xo4g+fSLlxCEQzGQGHKZ1SaTesr7S4ysqW6C6oppUvBCeT
	5kfhcy0ZglePFnfHAxTABN70XqXNMmKrSGfjq52GlTdYvZR5puU241MBWGOXTY9EGau30HAtkfN
	ZAJiiHPf482+mEnKEvTXf3YFEO1VWHIXCq9Cn51OCZ1YPNLD2gTx5Me1Zq3vhm6gm7poPhEoC19
	Hri1F4yT80A71JkxiCR6IZuzKtNkzS5eTDqgL9pl3bTvOR5riX0hWnFLds7oKNfMtL3Q75AuGzB
	Kz+VOi13Kl6ORlk+RAyO7vzIq2PnH98EkhYrIvyeg6jZtuzqCle4uMKtkrq9oGYJ0tUalpm75Ie
	GAWxEvox4Fkl3BqlL0kKYdZGpjA==
X-Google-Smtp-Source: AGHT+IGcWaIsQCr5SuxGD2Fly/59duBGOBMgR1HZn+CK7bi9YK9haPiqoLBuDItgVVWUUHrJ++V/ZQ==
X-Received: by 2002:ad4:5bea:0:b0:6e6:4969:f005 with SMTP id 6a1803df08f44-6e6ae994f63mr148032356d6.30.1740450276118;
        Mon, 24 Feb 2025 18:24:36 -0800 (PST)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b09c5b8sm4368996d6.55.2025.02.24.18.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:24:35 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 1/2] selftests/net: prepare cmsg_ipv6.sh for ipv4
Date: Mon, 24 Feb 2025 21:23:58 -0500
Message-ID: <20250225022431.2083926-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250225022431.2083926-1-willemdebruijn.kernel@gmail.com>
References: <20250225022431.2083926-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Move IPV6_TCLASS and IPV6_HOPLIMIT into loops, to be able to use them
for IP_TOS and IP_TTL in a follow-on patch.

Indentation in this file is a mix of four spaces and tabs for double
indents. To minimize code churn, maintain that pattern.

Very small diff if viewing with -w.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/cmsg_ipv6.sh | 109 ++++++++++++-----------
 1 file changed, 59 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_ipv6.sh b/tools/testing/selftests/net/cmsg_ipv6.sh
index 8bc23fb4c82b..51132c26e9b5 100755
--- a/tools/testing/selftests/net/cmsg_ipv6.sh
+++ b/tools/testing/selftests/net/cmsg_ipv6.sh
@@ -64,76 +64,85 @@ for ovr in setsock cmsg both diff; do
 done
 
 # IPV6_TCLASS
-TOS=0x10
-TOS2=0x20
 
-ip -6 -netns $NS rule add tos $TOS lookup 300
-ip -6 -netns $NS route add table 300 prohibit any
+test_dscp() {
+    local -r TOS=0x10
+    local -r TOS2=0x20
 
-for ovr in setsock cmsg both diff; do
-    for p in u i r; do
-	[ $p == "u" ] && prot=UDP
-	[ $p == "i" ] && prot=ICMP
-	[ $p == "r" ] && prot=RAW
+    ip -6 -netns $NS rule add tos $TOS lookup 300
+    ip -6 -netns $NS route add table 300 prohibit any
 
-	[ $ovr == "setsock" ] && m="-C"
-	[ $ovr == "cmsg" ]    && m="-c"
-	[ $ovr == "both" ]    && m="-C $((TOS2)) -c"
-	[ $ovr == "diff" ]    && m="-C $((TOS )) -c"
+    for ovr in setsock cmsg both diff; do
+	for p in u i r; do
+	    [ $p == "u" ] && prot=UDP
+	    [ $p == "i" ] && prot=ICMP
+	    [ $p == "r" ] && prot=RAW
 
-	$NSEXE nohup tcpdump --immediate-mode -p -ni dummy0 -w $TMPF -c 4 2> /dev/null &
-	BG=$!
-	sleep 0.05
+	    [ $ovr == "setsock" ] && m="-C"
+	    [ $ovr == "cmsg" ]    && m="-c"
+	    [ $ovr == "both" ]    && m="-C $((TOS2)) -c"
+	    [ $ovr == "diff" ]    && m="-C $((TOS )) -c"
 
-	$NSEXE ./cmsg_sender -6 -p $p $m $((TOS2)) $TGT6 1234
-	check_result $? 0 "TCLASS $prot $ovr - pass"
+	    $NSEXE nohup tcpdump --immediate-mode -p -ni dummy0 -w $TMPF -c 4 2> /dev/null &
+	    BG=$!
+	    sleep 0.05
 
-	while [ -d /proc/$BG ]; do
 	    $NSEXE ./cmsg_sender -6 -p $p $m $((TOS2)) $TGT6 1234
-	done
+	    check_result $? 0 "TCLASS $prot $ovr - pass"
 
-	tcpdump -r $TMPF -v 2>&1 | grep "class $TOS2" >> /dev/null
-	check_result $? 0 "TCLASS $prot $ovr - packet data"
-	rm $TMPF
+	    while [ -d /proc/$BG ]; do
+	        $NSEXE ./cmsg_sender -6 -p $p $m $((TOS2)) $TGT6 1234
+	    done
 
-	[ $ovr == "both" ]    && m="-C $((TOS )) -c"
-	[ $ovr == "diff" ]    && m="-C $((TOS2)) -c"
+	    tcpdump -r $TMPF -v 2>&1 | grep "class $TOS2" >> /dev/null
+	    check_result $? 0 "TCLASS $prot $ovr - packet data"
+	    rm $TMPF
 
-	$NSEXE ./cmsg_sender -6 -p $p $m $((TOS)) -s $TGT6 1234
-	check_result $? 1 "TCLASS $prot $ovr - rejection"
+	    [ $ovr == "both" ]    && m="-C $((TOS )) -c"
+	    [ $ovr == "diff" ]    && m="-C $((TOS2)) -c"
+
+	    $NSEXE ./cmsg_sender -6 -p $p $m $((TOS)) -s $TGT6 1234
+	    check_result $? 1 "TCLASS $prot $ovr - rejection"
+	done
     done
-done
+}
 
-# IPV6_HOPLIMIT
-LIM=4
+test_dscp
 
-for ovr in setsock cmsg both diff; do
-    for p in u i r; do
-	[ $p == "u" ] && prot=UDP
-	[ $p == "i" ] && prot=ICMP
-	[ $p == "r" ] && prot=RAW
+# IPV6_HOPLIMIT
+test_hoplimit() {
+    local -r LIM=4
 
-	[ $ovr == "setsock" ] && m="-L"
-	[ $ovr == "cmsg" ]    && m="-l"
-	[ $ovr == "both" ]    && m="-L $LIM -l"
-	[ $ovr == "diff" ]    && m="-L $((LIM + 1)) -l"
+    for ovr in setsock cmsg both diff; do
+	for p in u i r; do
+	    [ $p == "u" ] && prot=UDP
+	    [ $p == "i" ] && prot=ICMP
+	    [ $p == "r" ] && prot=RAW
 
-	$NSEXE nohup tcpdump --immediate-mode -p -ni dummy0 -w $TMPF -c 4 2> /dev/null &
-	BG=$!
-	sleep 0.05
+	    [ $ovr == "setsock" ] && m="-L"
+	    [ $ovr == "cmsg" ]    && m="-l"
+	    [ $ovr == "both" ]    && m="-L $LIM -l"
+	    [ $ovr == "diff" ]    && m="-L $((LIM + 1)) -l"
 
-	$NSEXE ./cmsg_sender -6 -p $p $m $LIM $TGT6 1234
-	check_result $? 0 "HOPLIMIT $prot $ovr - pass"
+	    $NSEXE nohup tcpdump --immediate-mode -p -ni dummy0 -w $TMPF -c 4 2> /dev/null &
+	    BG=$!
+	    sleep 0.05
 
-	while [ -d /proc/$BG ]; do
 	    $NSEXE ./cmsg_sender -6 -p $p $m $LIM $TGT6 1234
-	done
+	    check_result $? 0 "HOPLIMIT $prot $ovr - pass"
 
-	tcpdump -r $TMPF -v 2>&1 | grep "hlim $LIM[^0-9]" >> /dev/null
-	check_result $? 0 "HOPLIMIT $prot $ovr - packet data"
-	rm $TMPF
+	    while [ -d /proc/$BG ]; do
+	        $NSEXE ./cmsg_sender -6 -p $p $m $LIM $TGT6 1234
+	    done
+
+	    tcpdump -r $TMPF -v 2>&1 | grep "hlim $LIM[^0-9]" >> /dev/null
+	    check_result $? 0 "HOPLIMIT $prot $ovr - packet data"
+	    rm $TMPF
+	done
     done
-done
+}
+
+test_hoplimit
 
 # IPV6 exthdr
 for p in u i r; do
-- 
2.48.1.658.g4767266eb4-goog


