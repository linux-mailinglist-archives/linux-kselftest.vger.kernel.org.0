Return-Path: <linux-kselftest+bounces-3629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB483DD8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 16:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FD51C211FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750381CF94;
	Fri, 26 Jan 2024 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+BqYuY/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37795179B2
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283169; cv=none; b=S8Ula9xX6CaURe2Yn082qwIk1SsDkdH3wWsQJgVF2YWLyPviU18kgKE/pdq/ZNDgPGHWoL7c5bjVdHs/70WWIUiNvs78SC2yQ8Nl89Nb9hdQSYWeQD7L1DWiZf9bEeD8ZBmMkDAcHUOKm2aYWHxJ0VZwnmv53a9MEoN1RnK2V14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283169; c=relaxed/simple;
	bh=FxtrTLuAtobU9c5Uuzr2k+Bt7kukoAuCqMt/p1GBekw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKXJNQrQJLb1nBZ8tdxs6lrM/53DKHhZ3En7skZzTJXROsPpocZMyoIn9B0dMtloZ5mHyEJAu7N3SfU3HhnCs/nvxBjOEzVkubAeQpR2Lo1AjNp2aI3XlX+lwpJR7CZXbeon1HttggPA8V8A9Ka2QDV3mwE5tB0CJQZKzJILU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+BqYuY/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706283165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jlScfBpbgS69/8IaB6mNjO+RqTpFY3VAGajIs+lucxw=;
	b=P+BqYuY/kB1zX8GkvpbfbybMU6usv9vGi3RcCI3JNiQsOP9C6B72k3QHuWvKIhyQiOxVjb
	9x+iGrdoPZJkatAlAyENYKYmyfByTUV+vFdNIHVQ/3qYBuUJufK6iM8OGUv7dgTYscMerf
	zhNv9SWx5ojFUp0j6DxpFRc7HkkbflQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-u7TQBo5bOQupqDM2VCqIUw-1; Fri, 26 Jan 2024 10:32:43 -0500
X-MC-Unique: u7TQBo5bOQupqDM2VCqIUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4D8488FC31;
	Fri, 26 Jan 2024 15:32:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.112])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE652166B33;
	Fri, 26 Jan 2024 15:32:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Xin Long <lucien.xin@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Aaron Conole <aconole@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: add missing config for big tcp tests
Date: Fri, 26 Jan 2024 16:32:36 +0100
Message-ID: <21630ecea872fea13f071342ac64ef52a991a9b5.1706282943.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The big_tcp test-case requires a few kernel knobs currently
not specified in the net selftests config, causing the
following failure:

  # selftests: net: big_tcp.sh
  # Error: Failed to load TC action module.
  # We have an error talking to the kernel
...
  # Testing for BIG TCP:
  # CLI GSO | GW GRO | GW GSO | SER GRO
  # ./big_tcp.sh: line 107: test: !=: unary operator expected
...
  # on        on       on       on      : [FAIL_on_link1]

Add the missing configs

Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index b511f43cd197..c0e8482f82d3 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -29,6 +29,7 @@ CONFIG_NF_NAT=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP6_NF_NAT=m
+CONFIG_IP6_NF_RAW=m
 CONFIG_IP_NF_NAT=m
 CONFIG_IPV6_GRE=m
 CONFIG_IPV6_SEG6_LWTUNNEL=y
@@ -41,9 +42,11 @@ CONFIG_MACVLAN=y
 CONFIG_MACVTAP=y
 CONFIG_MPLS=y
 CONFIG_MPTCP=y
+CONFIG_IP_NF_RAW=m
 CONFIG_NF_TABLES=m
 CONFIG_NF_TABLES_IPV6=y
 CONFIG_NF_TABLES_IPV4=y
+CONFIG_NF_FLOW_TABLE=m
 CONFIG_NFT_NAT=m
 CONFIG_NET_ACT_GACT=m
 CONFIG_NET_CLS_BASIC=m
@@ -71,6 +74,7 @@ CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_CLS_BPF=m
 CONFIG_NET_ACT_TUNNEL_KEY=m
 CONFIG_NET_ACT_MIRRED=m
+CONFIG_NET_ACT_CT=m
 CONFIG_BAREUDP=m
 CONFIG_IPV6_IOAM6_LWTUNNEL=y
 CONFIG_CRYPTO_SM4_GENERIC=y
@@ -79,5 +83,6 @@ CONFIG_TUN=y
 CONFIG_VXLAN=m
 CONFIG_IP_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
+CONFIG_NETFILTER_XT_MATCH_LENGTH=m
 CONFIG_CRYPTO_ARIA=y
 CONFIG_XFRM_INTERFACE=m
-- 
2.43.0


