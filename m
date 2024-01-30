Return-Path: <linux-kselftest+bounces-3747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80CD842B27
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 18:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60F0B228CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081CA14E2DA;
	Tue, 30 Jan 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qb4ebnzx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B09E14E2C6
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636858; cv=none; b=KTbKjN6DfXnUz9Mq9OFwcvaVm5E6pAeWSdhvmoA6AtdkrlwtQoR2V+N9dhliOSp3nlzUvVRO6FHnJX2PtwWThfrYYCr1XOY+QWOnCdTHxgFDqHiIbKvyFtAlItQhx/BHyENO2t5xSNbb6xkTDpNG0t7m999VSipxR8ID1wHkxFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636858; c=relaxed/simple;
	bh=WELECx4Ua/9rAN4tOy0gsg5OugK3kgeZ30JBEeLHYp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q32iE5iEE3F08lk+nhXeXTm/lIg8YzTD5/WPpjP8/zOxpAy6/NTVu+po/3jF4KghYYNtj6PlMUskYdmKoOdvK9glZBYKBymOcAyDj3gVxzRrA+qTg3r2xWZ6iEuWGjr07ArPvSccPNnFcvao8vbVLk48U2MQ5ZA2ImzdRn/tiMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qb4ebnzx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706636856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXkkE7oCS29AOLfd575Wq0/x8oQtcl0G+71XUaBu5Mk=;
	b=Qb4ebnzxJY4xWabw7dmSpETj7alglcP66t9Eaw0ET9Dc8EdtsMC9hj3JbKC/IyALz26z+D
	2Qh/MrDd5BCV5ajWZaP+z7ssJvDZLQwIP0Pw3evetWStbdwW2WoGrfHUmNP8zY8rdPjvoA
	9j7SQYML/fQBYeNIuvFgkclQNoDygYI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-rp7Weh4sPlOsVZn63-JbCA-1; Tue,
 30 Jan 2024 12:47:33 -0500
X-MC-Unique: rp7Weh4sPlOsVZn63-JbCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 848BE29AC033;
	Tue, 30 Jan 2024 17:47:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.163])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B68381121306;
	Tue, 30 Jan 2024 17:47:30 +0000 (UTC)
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
Subject: [PATCH net 1/3] selftests: net: add missing config for pmtu.sh tests
Date: Tue, 30 Jan 2024 18:47:16 +0100
Message-ID: <8d27bf6762a5c7b3acc457d6e6872c533040f9c1.1706635101.git.pabeni@redhat.com>
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

The mentioned test uses a few Kconfig still missing the
net config, add them.

Before:
  # Error: Specified qdisc kind is unknown.
  # Error: Specified qdisc kind is unknown.
  # Error: Qdisc not classful.
  # We have an error talking to the kernel
  # Error: Qdisc not classful.
  # We have an error talking to the kernel
  #   policy_routing not supported
  # TEST: ICMPv4 with DSCP and ECN: PMTU exceptions                     [SKIP]

After:
  # TEST: ICMPv4 with DSCP and ECN: PMTU exceptions                     [ OK ]

Fixes: ec730c3e1f0e ("selftest: net: Test IPv4 PMTU exceptions with DSCP and ECN")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d4b38177ed04..88835cdbf0ea 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -60,6 +60,7 @@ CONFIG_NET_SCH_HTB=m
 CONFIG_NET_SCH_FQ=m
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_NETEM=y
+CONFIG_NET_SCH_PRIO=m
 CONFIG_NFT_COMPAT=m
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_PSAMPLE=m
@@ -77,6 +78,8 @@ CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_ACT_TUNNEL_KEY=m
 CONFIG_NET_ACT_MIRRED=m
+CONFIG_NET_ACT_PEDIT=m
+CONFIG_NET_ACT_CSUM=m
 CONFIG_BAREUDP=m
 CONFIG_IPV6_IOAM6_LWTUNNEL=y
 CONFIG_CRYPTO_SM4_GENERIC=y
-- 
2.43.0


