Return-Path: <linux-kselftest+bounces-3869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DD284468E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 18:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE2E1C2286B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241F012F5B4;
	Wed, 31 Jan 2024 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjAdit5K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3712F5A8
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723575; cv=none; b=oKJkhNW4TrLf1YamTLLjFKhCpnUslLRJj5mIP96OhtTL/D3OgOf6V2GWvBPe2pfuKof2RPWbV2zqT4oe8rtlS0lvD0GjA+T/liyb7EXD5uywn3++sfY7g3Y5UzLcjzMrDXx1OvpaCbe/XWvjvlYQwakBOAn922RRmoLxrN8uO90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723575; c=relaxed/simple;
	bh=Qg8AC94AxLgLa00pIFlhPMC8HUBpT8abDKjjTF6QyjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/k3uWjR9ioY7XuR0880jMQMGdIVk465fVPkGfMQXAUp4CQ4uMnBSALMSw8GGFK6Fb9qspykMpijugpDYduynBkFAqUOQu8oufq0J5s5/ryJyUcp+tdxl7PaJU9H6ZM+pNkumL/m4qyCH8vdg0/O2jKMeZDTz1ZzXPaFb2/Ygrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjAdit5K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706723572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApLuvJx7GG0VnUkJhZsWzSarM2Zh0s+HKxXIR157Ly0=;
	b=TjAdit5KTgPHWheIsbffOtGYklWuwsnpbuptR1Ci+p+xnHcfbsgvuCLgpNRmBaVueleHF6
	Bh+xonX+kMXJNl/ATTMMsjivCa0exwASTDKpkKq685PaGlW2Ytb0Cw/myPJMnPPIjbH/mW
	aISl9cKSMz0tZcHyb2ZwmsAlrdWLkE0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-ds0zxfpFNda3a-1RPqkk8Q-1; Wed, 31 Jan 2024 12:52:47 -0500
X-MC-Unique: ds0zxfpFNda3a-1RPqkk8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9D5610650E0;
	Wed, 31 Jan 2024 17:52:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.202])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3AE048B;
	Wed, 31 Jan 2024 17:52:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 3/3] selftests: net: enable some more knobs
Date: Wed, 31 Jan 2024 18:52:29 +0100
Message-ID: <9048ca58e49b962f35dba1dfb2beaf3dab3e0411.1706723341.git.pabeni@redhat.com>
In-Reply-To: <cover.1706723341.git.pabeni@redhat.com>
References: <cover.1706723341.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The rtnetlink tests require additional options currently
off by default.

Fixes: 2766a11161cc ("selftests: rtnetlink: add ipsec offload API test")
Fixes: 5e596ee171ba ("selftests: add xfrm state-policy-monitor to rtnetlink.sh")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 58a716a6bf2a..a50b96bb3d80 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -21,6 +21,8 @@ CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_VLAN_8021Q=y
 CONFIG_IFB=y
 CONFIG_INET_DIAG=y
+CONFIG_INET_ESP=y
+CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_IP_GRE=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
@@ -91,3 +93,4 @@ CONFIG_IP_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
 CONFIG_CRYPTO_ARIA=y
 CONFIG_XFRM_INTERFACE=m
+CONFIG_XFRM_USER=m
-- 
2.43.0


