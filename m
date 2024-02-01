Return-Path: <linux-kselftest+bounces-3950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E60A846034
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 19:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03550287427
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D2B84FB8;
	Thu,  1 Feb 2024 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaCFjqx9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0485272
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Feb 2024 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813002; cv=none; b=XLpu19snsBaNoQbEpnMKmN6/0Xgsa1608HxUyAbTAxCVVFIeo2PPGJEIMCgHtYBPE6LyGVPiJXmULCXo+vsAbVT9droHfZRLbHBwFcuNsjKCEY6dSL2LVSDohbPqAPxjaNNGluYrKcKr7A8+kjsFBB5XSCVAfalDPDARdDrM1ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813002; c=relaxed/simple;
	bh=njmfFDHza5FwKIEX+Xtcn+kRhhTiFDHfn3anY+3IZJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qepLQ3nXeO0eWvcpBddZ0oOIqcdSVSSSTOCNRuXDo4I35L67U5KrW/+tFCgEmUCfzebIpd/GNKsbU32aNlQMP1HvM4gt1D8oC7d6j9scu6AeCTnXpN9CEv1Gvzoo4ZtF8MHC+5pQC51nVRMrkbgvyg4RDYruGn8XcwZOOJzUQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaCFjqx9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706812999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nr2/V/3YJAy27VTzBsQfBjf8SrcxLvY2acHoCPY4+cs=;
	b=iaCFjqx9yu0kVB4GOS0AGbZNR9D6zLM9DVZYrmbGwWlhrQMRCSUPkEBolpQ+Yz5ZxrqUOw
	uWvniZodzzUf1JqVpVkdjAndqqBOWQcF3dxFPlSe3RPGjjweIlgf4Ieh6z/Q4HiELPxKQb
	ouTKra8PY+1sc/dZq6h/fi8ga2GXOk8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-YxApcKEtP5eY9KVOkte-hQ-1; Thu, 01 Feb 2024 13:43:14 -0500
X-MC-Unique: YxApcKEtP5eY9KVOkte-hQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D1031064C64;
	Thu,  1 Feb 2024 18:43:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE73F111F9;
	Thu,  1 Feb 2024 18:43:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	David Ahern <dsahern@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 net 4/4] selftests: net: avoid just another constant wait
Date: Thu,  1 Feb 2024 19:42:41 +0100
Message-ID: <fd5c745e9bb665b724473af6a9373a8c2a62b247.1706812005.git.pabeni@redhat.com>
In-Reply-To: <cover.1706812005.git.pabeni@redhat.com>
References: <cover.1706812005.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Using hard-coded constant timeout to wait for some expected
event is deemed to fail sooner or later, especially in slow
env.

Our CI has spotted another of such race:
   # TEST: ipv6: cleanup of cached exceptions - nexthop objects          [FAIL]
   #   can't delete veth device in a timely manner, PMTU dst likely leaked

Replace the crude sleep with a loop looking for the expected condition
at low interval for a much longer range.

Fixes: b3cc4f8a8a41 ("selftests: pmtu: add explicit tests for PMTU exceptions cleanup")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/pmtu.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index f0febc19baae..d65fdd407d73 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1957,6 +1957,13 @@ check_command() {
 	return 0
 }
 
+check_running() {
+	pid=${1}
+	cmd=${2}
+
+	[ "$(cat /proc/${pid}/cmdline 2>/dev/null | tr -d '\0')" = "{cmd}" ]
+}
+
 test_cleanup_vxlanX_exception() {
 	outer="${1}"
 	encap="vxlan"
@@ -1987,11 +1994,12 @@ test_cleanup_vxlanX_exception() {
 
 	${ns_a} ip link del dev veth_A-R1 &
 	iplink_pid=$!
-	sleep 1
-	if [ "$(cat /proc/${iplink_pid}/cmdline 2>/dev/null | tr -d '\0')" = "iplinkdeldevveth_A-R1" ]; then
-		err "  can't delete veth device in a timely manner, PMTU dst likely leaked"
-		return 1
-	fi
+	for i in $(seq 1 20); do
+		check_running ${iplink_pid} "iplinkdeldevveth_A-R1" || return 0
+		sleep 0.1
+	done
+	err "  can't delete veth device in a timely manner, PMTU dst likely leaked"
+	return 1
 }
 
 test_cleanup_ipv6_exception() {
-- 
2.43.0


