Return-Path: <linux-kselftest+bounces-3748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C8842B28
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 18:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8012C1F2511B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4DC14E2E4;
	Tue, 30 Jan 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JApBfsOf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ECB1292D2
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636859; cv=none; b=JEWvnvK2nUMFkmmd3H7k/lR2vYnzY8l7IGRxM+h5nLCKlio/uV0ZAElHD6mSXjyc0wCpT4WZ0KQVY+LfpfDK7B2TiMm2trA/iUU8bHO848U+VXtOvtgwk9FekULuIa4iDZD6RMgSaZ3hZ1QAUrW/n6Tqya7GX+yemh2cjar4X3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636859; c=relaxed/simple;
	bh=MEl8CPiOuY1tks9ueB3sGU7Ik86ZGWf2m1FebpQirqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJPL21uDbPGBoGdFU2xY5EXlvoBWhQ0gtmDLnkrxJ8JueQqQVr94QJtd8QM30QF5gtuOJEbZvrVfSQ5M9bDNny4V8N0N2ppD3SOseQm94DYRkkdHxkT+Nemp4cwwTdo38QvZFMmP76I8CfMqxD5/GryV8ugeifG+Zjiaj2YeNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JApBfsOf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706636856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYj6xTzMCH10S7zOOl6kjPIi8isOKaiYRJLNg2w77L4=;
	b=JApBfsOfsqRNM42I8jvmG7ntkHRav/hi+M0hNN41+wiLTgShVD1iM34GtbcstfN9WLqDvE
	HMEHQaMMC7pxYI1UN4zI+EDPJwLw7G1BAGZhOea+Dm2Wu2rV3h7ofgsD4c+7M3B8ugl1uk
	5EeMvRWk67tdGRAacVqhE5XrBwLJB1c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-U9dn9QEAOOCLxjEXdeKhMw-1; Tue,
 30 Jan 2024 12:47:35 -0500
X-MC-Unique: U9dn9QEAOOCLxjEXdeKhMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CFD73812010;
	Tue, 30 Jan 2024 17:47:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.163])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE8DB1121306;
	Tue, 30 Jan 2024 17:47:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Florian Westphal <fw@strlen.de>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 2/3] selftests: net: fix available tunnels detection
Date: Tue, 30 Jan 2024 18:47:17 +0100
Message-ID: <cab10e75fda618e6fff8c595b632f47db58b9309.1706635101.git.pabeni@redhat.com>
In-Reply-To: <cover.1706635101.git.pabeni@redhat.com>
References: <cover.1706635101.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The pmtu.sh test tries to detect the tunnel protocols available
in the running kernel and properly skip the unsupported cases.

In a few more complex setup, such detection is unsuccessful, as
the script currently ignores some intermediate error code at
setup time.

Before:
  # which: no nettest in (/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)
  # TEST: vti6: PMTU exceptions (ESP-in-UDP)                            [FAIL]
  #   PMTU exception wasn't created after creating tunnel exceeding link layer MTU
  # ./pmtu.sh: line 931: kill: (7543) - No such process
  # ./pmtu.sh: line 931: kill: (7544) - No such process

After:
  #   xfrm4 not supported
  # TEST: vti4: PMTU exceptions                                         [SKIP]

Fixes: ece1278a9b81 ("selftests: net: add ESP-in-UDP PMTU test")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/pmtu.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index f10879788f61..31892b366913 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -707,23 +707,23 @@ setup_xfrm6() {
 }
 
 setup_xfrm4udp() {
-	setup_xfrm 4 ${veth4_a_addr} ${veth4_b_addr} "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 4 4500
+	setup_xfrm 4 ${veth4_a_addr} ${veth4_b_addr} "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 4 4500
 }
 
 setup_xfrm6udp() {
-	setup_xfrm 6 ${veth6_a_addr} ${veth6_b_addr} "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 6 4500
+	setup_xfrm 6 ${veth6_a_addr} ${veth6_b_addr} "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 6 4500
 }
 
 setup_xfrm4udprouted() {
-	setup_xfrm 4 ${prefix4}.${a_r1}.1 ${prefix4}.${b_r1}.1 "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 4 4500
+	setup_xfrm 4 ${prefix4}.${a_r1}.1 ${prefix4}.${b_r1}.1 "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 4 4500
 }
 
 setup_xfrm6udprouted() {
-	setup_xfrm 6 ${prefix6}:${a_r1}::1 ${prefix6}:${b_r1}::1 "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 6 4500
+	setup_xfrm 6 ${prefix6}:${a_r1}::1 ${prefix6}:${b_r1}::1 "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 6 4500
 }
 
 setup_routing_old() {
-- 
2.43.0


