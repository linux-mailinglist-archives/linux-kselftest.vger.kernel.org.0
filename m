Return-Path: <linux-kselftest+bounces-26783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28819A385F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 15:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053511882558
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CE12248AF;
	Mon, 17 Feb 2025 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzDTMiZo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB42248AC;
	Mon, 17 Feb 2025 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801858; cv=none; b=tc+is4th8AmJHOiEzjTAALc2mWMr4fgzR6Sa77lMkyhg41PFU4xBw63Robve3cQizKgSkbftI3uCp92JD/gEgIsSFNX4KMuomUByzuduUE+Z0peuVctRLsXL3nCQ6s/GEJpn+EU9VeYadO+4ilc9eZ+oFGhyJQiETlgbst8GU+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801858; c=relaxed/simple;
	bh=o39YROBuVbA6O3ko9Qq4yI5dRM0+WT1BVbhUu9uV5uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNTx65Gn2qy6qoMWmsn9p9YG/QAxI/HuXSwO6kbuyGZk+VKMX9XcEJjh0Z9j4DUu+xo1AwEOYlQBLRCocvbD9mqncZniXaJBrVCiL2dDHLfbQtMvpyzU0VW5fPa3j5L74kodIdqZ+9d+ksOdmxdCfm1B362GthZpz80AzX9OhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzDTMiZo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21c2f1b610dso110864635ad.0;
        Mon, 17 Feb 2025 06:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739801856; x=1740406656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=euGD3DtL6BCGM+b7jkbY7enHbQAEo+xzdmRvXrR2nc0=;
        b=FzDTMiZo8/oAVe9Hd0uk1REysvhn++aw2bT7qFeoyp0MskM6JrJSeryanqpvODJ+0J
         kIOR27hemeg53WmxgsHaukYzTjKkHL7lHVhkUguzNpuELph9NgemPTkZLMq1YC5dgEBK
         wVr1FzxCHLuyxqWwLJU5KHbG9uyF0kftD+2nO8M/dhm5s/7d2+dB/UYarCmhsdMghS/u
         4c5R3b3zV3iqV0A728ofUXsZAGQNOa6DO/vevondDQiVLGN/92WTrwfeDAVcmfK8HQrl
         6AJpOTuVNfo/2jAHGKi3t9le08l9oaTdS2rOrzoeqJQ6W17JiTB+YrFm2ZrV3Dh9XHlQ
         NRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801856; x=1740406656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euGD3DtL6BCGM+b7jkbY7enHbQAEo+xzdmRvXrR2nc0=;
        b=PLVz9SE9ilvDrGivRPmDfgUvdKPs3ImUSGp5BsUV4o1S/DB2091GZDDanUe6ZQWC51
         wYwl8AQo3fdUR/EC6uPxuGkQ9l4KOkQT7QTo5CNhn9LltWWbuTSrC4Vjfo/dtL55B91i
         TCgqCPL2DJm0NpqNjG78XYRM5SQFsxJcCcdksChiuMnKyrRdyJnB5nMhsa7ty8CArCUe
         Ex1xH1RFOqzoVLEuFxICn9PKzTGEVPjHpOaNZhjvkBf6v1BoUjJ/+CYv5EJ84WtElB6w
         fqvKVf2br3Pwp5zzX4S8BN3oR3D3Df2THrBoI6ZHMcd3guNUx82ddgNQAmM00BIovTH6
         rO9A==
X-Forwarded-Encrypted: i=1; AJvYcCVG9yLppmEmXwelKlu68whs8TAZDAx8X4WsCiObQpYx406U5Y0TFgcZg5Dg+9J+AiFiZHjn6/0xEhxMjuMcgMU=@vger.kernel.org, AJvYcCXAUaAVoh36wjUF0w48lu6PYy3SGytGyI2yruJYuL0FBIn9VQ+S1bkoqov7S31PLTVwfeX9xepd@vger.kernel.org
X-Gm-Message-State: AOJu0YyftSJCf1OVFigyPasIg++x7EYXlChhNeqtZXMxhQ+T4ihg7ELu
	lnS0iONpJhMIrhrQhJl7ZF7EAl1f/6Qk+o589IE4x147qZRifxeZ
X-Gm-Gg: ASbGncubaqit+zjyMQrcbmNT3MR2z3IEtTK6lS6awgAMqQ1Oo2aV6oAuf9zD/xhHpzq
	X/u500nNKZX6ysrdOAAePZITaSWFmCRL7uJD9ZElddgmb9YpVd2+TVSpBsIKocmQIuo7i3t2/UB
	Ga24Pj9seluCsEh8T10kg+A5c5HwwCcTNyw4UqB8jz/w19T92gLdoUCIZz65kU/aUYkFAExhL35
	yb/mEUecS/yccYPehkzEX+R17MU1DyAljQUrw7991PGybVHsMYxZDPNsyb1P2s3Lp1oLJBtipyB
	YJL3Vd/8yd1ImZfyg4d3dCbpoXxIyEwspEHiyLcI
X-Google-Smtp-Source: AGHT+IFpFeBSNuUJ9Jopviu3/MljT4Y04e+Tksr52wJhW7iAizRMSd95PeaL9LxYgEEhXppqNW6Htg==
X-Received: by 2002:a17:903:1a0e:b0:220:f1a1:b6e1 with SMTP id d9443c01a7336-22104028854mr164379845ad.19.1739801856490;
        Mon, 17 Feb 2025 06:17:36 -0800 (PST)
Received: from localhost.localdomain ([122.171.19.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm71648185ad.113.2025.02.17.06.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:17:36 -0800 (PST)
From: Chandra Mohan Sundar <chandru.dav@gmail.com>
To: skhan@linuxfoundation.org,
	shuah@kernel.org
Cc: Chandra Mohan Sundar <chandru.dav@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] selftests: net : Fix few spelling mistakes
Date: Mon, 17 Feb 2025 19:45:16 +0530
Message-ID: <20250217141520.81033-1-chandru.dav@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix few spelling mistakes in net selftests

Signed-off-by: Chandra Mohan Sundar <chandru.dav@gmail.com>
---
 tools/testing/selftests/net/fcnal-test.sh   | 4 ++--
 tools/testing/selftests/net/fdb_flush.sh    | 2 +-
 tools/testing/selftests/net/fib_nexthops.sh | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 899dbad0104b..4fcc38907e48 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -3667,7 +3667,7 @@ ipv6_addr_bind_novrf()
 	# when it really should not
 	a=${NSA_LO_IP6}
 	log_start
-	show_hint "Tecnically should fail since address is not on device but kernel allows"
+	show_hint "Technically should fail since address is not on device but kernel allows"
 	run_cmd nettest -6 -s -l ${a} -I ${NSA_DEV} -t1 -b
 	log_test_addr ${a} $? 0 "TCP socket bind to out of scope local address"
 }
@@ -3724,7 +3724,7 @@ ipv6_addr_bind_vrf()
 	# passes when it really should not
 	a=${VRF_IP6}
 	log_start
-	show_hint "Tecnically should fail since address is not on device but kernel allows"
+	show_hint "Technically should fail since address is not on device but kernel allows"
 	run_cmd nettest -6 -s -l ${a} -I ${NSA_DEV} -t1 -b
 	log_test_addr ${a} $? 0 "TCP socket bind to VRF address with device bind"
 
diff --git a/tools/testing/selftests/net/fdb_flush.sh b/tools/testing/selftests/net/fdb_flush.sh
index d5e3abb8658c..9931a1e36e3d 100755
--- a/tools/testing/selftests/net/fdb_flush.sh
+++ b/tools/testing/selftests/net/fdb_flush.sh
@@ -583,7 +583,7 @@ vxlan_test_flush_by_remote_attributes()
 	$IP link del dev vx10
 	$IP link add name vx10 type vxlan dstport "$VXPORT" external
 
-	# For multicat FDB entries, the VXLAN driver stores a linked list of
+	# For multicast FDB entries, the VXLAN driver stores a linked list of
 	# remotes for a given key. Verify that only the expected remotes are
 	# flushed.
 	multicast_fdb_entries_add
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 77c83d9508d3..bea1282e0281 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -741,7 +741,7 @@ ipv6_fcnal()
 	run_cmd "$IP nexthop add id 52 via 2001:db8:92::3"
 	log_test $? 2 "Create nexthop - gw only"
 
-	# gw is not reachable throught given dev
+	# gw is not reachable through given dev
 	run_cmd "$IP nexthop add id 53 via 2001:db8:3::3 dev veth1"
 	log_test $? 2 "Create nexthop - invalid gw+dev combination"
 
-- 
2.43.0


