Return-Path: <linux-kselftest+bounces-32648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBD9AAF576
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 10:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523F3189BAA1
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985C22A811;
	Thu,  8 May 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bES1n9Ts"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB42227EBB;
	Thu,  8 May 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692390; cv=none; b=YvpHI3s2YFE3BE9b9c4dxy8NroXli+Wn6NQpPPQ8h100TD0ebQYb8Yt1P6qx8XsqyIkkR8+oxt9h6tnef/7YCs5pdLJjZ+t51HjGniSBPn/KYIFoDddoKcKUflo/jtVnufom2JnQ/XvJsStnNLG+FBmeS9euw1wqSXLab5bK4b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692390; c=relaxed/simple;
	bh=fYBZ3e80lB7pnNPogmHpxRb6JLRnBdbF4Ja5yF5QpuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIchmgnvWzOOGnQkYf0Ji4N/HQJSxdcyWQxDAT5ew4wR6e7qXUv7Bfn06NPbQCajFMHGw1fCHlzejrjnIjyAZY5MGjO2vq9tY9dmywBPZtjtbBwkfCAdpEaJNBqJ6Npjz5Y6yIi+oISMLyPm4Yhz2BWL9jcn7jK8fK/j1fqJSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bES1n9Ts; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736c062b1f5so808449b3a.0;
        Thu, 08 May 2025 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746692388; x=1747297188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYrEDWYc5BP3GcwX3PUi68NFmiVIngMEPgSuDqL8ai8=;
        b=bES1n9TsORKVFFPxoPgaznFDO9sSUuxs2DapApJrzbI+ZKYYtv4zGxyDd1mHD8KFcz
         kDgudzzFYLQguuD217lZg91ezExv/GWGBGz4DuuyFjQot0GS50q+sPliJ7eDk2euohbF
         DROK2OoAIqG0JZA1yCJg4PFDHR8+pONzRGtHgwmKoVmGkV5/hkX+lQKAGVTL06xRFbb0
         B5Dle2EqObeTHIJLjOykNx7nSOWVJKfm6Rr19GhBYiy8b0U/U+Sio5gm+Hz38gqGSmZw
         XITI6zJSyUQDS8F8qlYwIRlj1jkZmAfivAVcx+h5uxgGIiltGQqfYyzIWX9ctMldoIgT
         xcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692388; x=1747297188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYrEDWYc5BP3GcwX3PUi68NFmiVIngMEPgSuDqL8ai8=;
        b=FZY5KoPXxkUx+S6DVCInKajNRmOXlmz+IXaUoRfks88bwpSbDGrBcn+QewBXXyYI72
         SU6YW62uHqhWROHpAvEztVjx5BiZWaRFGlx/2jRUk83ybPdleZQqanpMqIZHWZo87QqW
         Yx9sk4yvce3jSrJfdiA441GhBwnFAC8l6DW7Ezgk/4ERux221r3X6c7ntaTnlACev3FE
         hTX4x0Pbg1n0r557ajTEM+HXR7fnqqR3/MKqiEx32beYglXhBqjIOzFLMES2U7TISsOy
         FKqayqrY6qY0zS3PyFblgK9aUqZOVFWktwuG91Zy0FZHHM/zyb8Iuz+Jz4dnTPrbEQlZ
         uBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVACCOitS1/fJIde3UQGvJpNI4CtRV9PMm5mjSItuW4pozFjEHPvmmzj+AoqBdmFVCXKXyQLSFUYP6ubTBG3HPe@vger.kernel.org, AJvYcCWa9dGD/d6L/18hsHHme/5v+wqCnBHw9jEu33zKAu6jwxUvSF0Owlx2ChlwjYE+mgH+kJCFni2H4SP0lVHRgnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3JDn3d4Wba3BFUmE/k0+rkM0TgI6CJn5MTkHvcpE8aVE/uvz
	C7vjO0QZCOnilJ48hzUD0GBNolB6ZlKn2d42Tyadlk0wWUmQ+0+/g1AZmbLagfM=
X-Gm-Gg: ASbGncus9NFga58lblHQ0yNEbYPCIBQXIFE2hvDKCnII7vhCyxRftVlaWinz9cJLK76
	EUbMf+NYBtLupTOdYzS1gu/uIWmCc4GGNqbJPFjoeNQkMaDf8gIztV8+IVvNges/EXGWC0CeTpe
	/wEarzB/ktX6TzdvuFaAXBFJ8VbyuHblrug/2ePEv31y2ThVOxKNxyap8u52DU0jkM4bzIjlEAm
	/CfNMfSzYssW5X5qMNYxbgoBLM/kmOAjglatL2rnVXzfDwYThdu9HfPLcKIPqHwaWPDlolR49om
	oIqlgARJmsgrMOwPVfw7vL/PcLF2a531/akp66feWFBypjb4nGMq4mXXMMqH
X-Google-Smtp-Source: AGHT+IHd7oaveLaD1WpCZJtWDo3JJSOim6lGQAp0CwnAyt1bRUpsQR18gKlfMWUpXmh87Fxwt7cV4A==
X-Received: by 2002:a05:6a20:cf90:b0:1f5:619a:8f75 with SMTP id adf61e73a8af0-2159af284d6mr3334817637.2.1746692388068;
        Thu, 08 May 2025 01:19:48 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7406a36c523sm10907408b3a.144.2025.05.08.01.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:19:47 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 3/6] selftests: net: use setup_ns for bareudp testing
Date: Thu,  8 May 2025 08:19:07 +0000
Message-ID: <20250508081910.84216-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250508081910.84216-1-liuhangbin@gmail.com>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch bareudp testing to use setup_ns, which sets up rp_filter by default.
This allows us to remove the manual rp_filter configuration from the script.

Additionally, since setup_ns handles namespace naming and cleanup, we no
longer need a separate cleanup function. We also move the trap setup earlier
in the script, before the test setup begins.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/bareudp.sh | 49 ++++----------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/net/bareudp.sh b/tools/testing/selftests/net/bareudp.sh
index f366cadbc5e8..4046131e7888 100755
--- a/tools/testing/selftests/net/bareudp.sh
+++ b/tools/testing/selftests/net/bareudp.sh
@@ -106,26 +106,16 @@
 # |                                                                       |
 # +-----------------------------------------------------------------------+
 
+. ./lib.sh
+
 ERR=4 # Return 4 by default, which is the SKIP code for kselftest
 PING6="ping"
 PAUSE_ON_FAIL="no"
 
-readonly NS0=$(mktemp -u ns0-XXXXXXXX)
-readonly NS1=$(mktemp -u ns1-XXXXXXXX)
-readonly NS2=$(mktemp -u ns2-XXXXXXXX)
-readonly NS3=$(mktemp -u ns3-XXXXXXXX)
-
 # Exit the script after having removed the network namespaces it created
-#
-# Parameters:
-#
-#   * The list of network namespaces to delete before exiting.
-#
 exit_cleanup()
 {
-	for ns in "$@"; do
-		ip netns delete "${ns}" 2>/dev/null || true
-	done
+	cleanup_all_ns
 
 	if [ "${ERR}" -eq 4 ]; then
 		echo "Error: Setting up the testing environment failed." >&2
@@ -140,17 +130,7 @@ exit_cleanup()
 # namespaces created by this script are deleted.
 create_namespaces()
 {
-	ip netns add "${NS0}" || exit_cleanup
-	ip netns add "${NS1}" || exit_cleanup "${NS0}"
-	ip netns add "${NS2}" || exit_cleanup "${NS0}" "${NS1}"
-	ip netns add "${NS3}" || exit_cleanup "${NS0}" "${NS1}" "${NS2}"
-}
-
-# The trap function handler
-#
-exit_cleanup_all()
-{
-	exit_cleanup "${NS0}" "${NS1}" "${NS2}" "${NS3}"
+	setup_ns NS0 NS1 NS2 NS3 || exit_cleanup
 }
 
 # Configure a network interface using a host route
@@ -188,10 +168,6 @@ iface_config()
 #
 setup_underlay()
 {
-	for ns in "${NS0}" "${NS1}" "${NS2}" "${NS3}"; do
-		ip -netns "${ns}" link set dev lo up
-	done;
-
 	ip link add name veth01 netns "${NS0}" type veth peer name veth10 netns "${NS1}"
 	ip link add name veth12 netns "${NS1}" type veth peer name veth21 netns "${NS2}"
 	ip link add name veth23 netns "${NS2}" type veth peer name veth32 netns "${NS3}"
@@ -234,14 +210,6 @@ setup_overlay_ipv4()
 	ip netns exec "${NS2}" sysctl -qw net.ipv4.ip_forward=1
 	ip -netns "${NS1}" route add 192.0.2.100/32 via 192.0.2.10
 	ip -netns "${NS2}" route add 192.0.2.103/32 via 192.0.2.33
-
-	# The intermediate namespaces don't have routes for the reverse path,
-	# as it will be handled by tc. So we need to ensure that rp_filter is
-	# not going to block the traffic.
-	ip netns exec "${NS1}" sysctl -qw net.ipv4.conf.all.rp_filter=0
-	ip netns exec "${NS2}" sysctl -qw net.ipv4.conf.all.rp_filter=0
-	ip netns exec "${NS1}" sysctl -qw net.ipv4.conf.default.rp_filter=0
-	ip netns exec "${NS2}" sysctl -qw net.ipv4.conf.default.rp_filter=0
 }
 
 setup_overlay_ipv6()
@@ -521,13 +489,10 @@ done
 
 check_features
 
-# Create namespaces before setting up the exit trap.
-# Otherwise, exit_cleanup_all() could delete namespaces that were not created
-# by this script.
-create_namespaces
-
 set -e
-trap exit_cleanup_all EXIT
+trap exit_cleanup EXIT
+
+create_namespaces
 
 setup_underlay
 setup_overlay_ipv4
-- 
2.46.0


