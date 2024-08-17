Return-Path: <linux-kselftest+bounces-15587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D63955993
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 22:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14B71C20AC5
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 20:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074471553AA;
	Sat, 17 Aug 2024 20:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNoObTmd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290D155337;
	Sat, 17 Aug 2024 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723927021; cv=none; b=uTTBX/RmULVjhOHI5yem3aT2ctHXQDmZYOG1mgh4ipCZxr0HcLOE4x9Pv2t125kqC9mrK4zRZtn7iqy8uldVbrxqWNhBafegWamaByRH6OnavfLdyoHAIalMCS0OUDSpm89a87pGiahO7IvmkL1aUMGSLptp1NYN4mot9PHXcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723927021; c=relaxed/simple;
	bh=MXwbzLyYB0p5K3Jufjy7e8h3D/VBdQMI1clVMp3Vq9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLNtVQ74EqdPfpcnCioTskK+rRCXidZzHoqTBG3Dq+eNTjrMVxpoH8bIdM4hmYN021nkjcop/yxjsGj82OpJyTlTuYL/dWMTyOwhTITg/FeVdE2T46R3K64cM/Fb91qUXN/g7dD9t830wP3RtvbPuiKMlIvbz2B66Ly1bRd9pqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNoObTmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E048DC4AF0B;
	Sat, 17 Aug 2024 20:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723927021;
	bh=MXwbzLyYB0p5K3Jufjy7e8h3D/VBdQMI1clVMp3Vq9c=;
	h=From:To:Cc:Subject:Date:From;
	b=BNoObTmdvTfti18QnqRiFXffSI0jYbddonQugq3vCui2rgSGtjgMZEBfYxXRzvRqX
	 OKhnxYpkjnhoSahpBnLwp6ke6P+xwv+MJ90LaWuFwMZPffBilE52zv1E/l0dQ2KS12
	 ZSusiEOsM+wIqa4t2RxlyNSaNSBPmESNUt4GXL9r9LEx2Tyl5IqdhOy0U2kqPzYsfe
	 5uaO1ANbFgTfC/OUyVQnv4KRvVi6nOUj4gEW/miEq+GFBOEewkEkxyUhvccsXqcGlM
	 rc4Xh0tWz27gI8tMO9NsY4ZCN6PigW/5yMjmb6x3w3CyEw/ZwHunjxrK9XlurHoJRO
	 8tqlqpK+So7tA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	idosch@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net/forwarding: spawn sh inside vrf to speed up ping loop
Date: Sat, 17 Aug 2024 13:36:59 -0700
Message-ID: <20240817203659.712085-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking at timestamped output of netdev CI reveals that
most of the time in forwarding tests for custom route
hashing is spent on a single case, namely the test which
uses ping (mausezahn does not support flow labels).

On a non-debug kernel we spend 714 of 730 total test
runtime (97%) on this test case. While having flow label
support in a traffic gen tool / mausezahn would be best,
we can significantly speed up the loop by putting ip vrf exec
outside of the iteration.

In a test of 1000 pings using a normal loop takes 50 seconds
to finish. While using:

  ip vrf exec $vrf sh -c "$loop-body"

takes 12 seconds (1/4 of the time).

Some of the slowness is likely due to our inefficient virtualization
setup, but even on my laptop running "ip link help" 16k times takes
25-30 seconds, so I think it's worth optimizing even for fastest
setups.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: idosch@nvidia.com
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/net/forwarding/custom_multipath_hash.sh     | 8 ++++----
 .../selftests/net/forwarding/gre_custom_multipath_hash.sh | 8 ++++----
 .../net/forwarding/ip6gre_custom_multipath_hash.sh        | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
index 1783c10215e5..7d531f7091e6 100755
--- a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
@@ -224,10 +224,10 @@ send_dst_ipv6()
 send_flowlabel()
 {
 	# Generate 16384 echo requests, each with a random flow label.
-	for _ in $(seq 1 16384); do
-		ip vrf exec v$h1 \
-			$PING6 2001:db8:4::2 -F 0 -c 1 -q >/dev/null 2>&1
-	done
+	ip vrf exec v$h1 sh -c \
+		"for _ in {1..16384}; do \
+			$PING6 2001:db8:4::2 -F 0 -c 1 -q >/dev/null 2>&1; \
+		done"
 }
 
 send_src_udp6()
diff --git a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
index 9788bd0f6e8b..dda11a4a9450 100755
--- a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
@@ -319,10 +319,10 @@ send_dst_ipv6()
 send_flowlabel()
 {
 	# Generate 16384 echo requests, each with a random flow label.
-	for _ in $(seq 1 16384); do
-		ip vrf exec v$h1 \
-			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1
-	done
+	ip vrf exec v$h1 sh -c \
+		"for _ in {1..16384}; do \
+			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1; \
+		done"
 }
 
 send_src_udp6()
diff --git a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
index 2ab9eaaa5532..e28b4a079e52 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
@@ -321,10 +321,10 @@ send_dst_ipv6()
 send_flowlabel()
 {
 	# Generate 16384 echo requests, each with a random flow label.
-	for _ in $(seq 1 16384); do
-		ip vrf exec v$h1 \
-			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1
-	done
+	ip vrf exec v$h1 sh -c \
+		"for _ in {1..16384}; do \
+			$PING6 2001:db8:2::2 -F 0 -c 1 -q >/dev/null 2>&1; \
+		done"
 }
 
 send_src_udp6()
-- 
2.46.0


