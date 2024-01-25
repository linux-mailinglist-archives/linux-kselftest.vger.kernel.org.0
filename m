Return-Path: <linux-kselftest+bounces-3551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B2783BBCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 09:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B37B253A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA8175BC;
	Thu, 25 Jan 2024 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYO+CH9p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69439175A5
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170997; cv=none; b=VrvSCI8BVGWrs0jrBEIFHlxVtJALXk79NykgotY8r+advyKfTLnXtnq3N1ZfQYzKV9/py+Vo2fe2S6Bz4AnRgOJDVr1gjaPoepFMBW+Nch584/TTBEi/Mv1w6q0WSGKC282vRjqiyCRt6INQv1k3x5jpgJKBrpNjmidk+iXfxbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170997; c=relaxed/simple;
	bh=6ij1nPsqsLT0aiLZc+qpWehy7jFch9bLHlKcgWHJR7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZlJao9XiOQ9xsCoo6xmGV96zplW41xVr/6Kfy7CMe2NHfg4pJBZF+C/mevaYX3w4L9McmaYt8HIgvz8zkp3V/Z7pH7wsBl7x8nniOCKXVB0qFKshQnP6WtStOgxZmhgfnZvyaKO7XKG/CjDdli5VXINZBrJ/8Axa4y7RZEZW4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYO+CH9p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706170995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SnCvL7ZAoQrqIVXvpy75zP/zLF9aHXV+3CjMG/egejE=;
	b=fYO+CH9pwlgnRI1dih9JazsfPVguWK2mUZ7Zdr2gl8WILMZR8jDQRqP0NGRJjvDFvbJfIf
	95ipc/pqkXjZH5AfvQ1paMBwJqxWWM4s4n7ZmjLPUl6BTRLc0E+WLUPXydaQqG273Y3KCU
	Y+D9uERKvjI8XkOjL5AJRqV5F4B/CJo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-XmBiM_X6NA2iTe4BqmPlxg-1; Thu, 25 Jan 2024 03:23:09 -0500
X-MC-Unique: XmBiM_X6NA2iTe4BqmPlxg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C49E885A58B;
	Thu, 25 Jan 2024 08:23:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3168948B;
	Thu, 25 Jan 2024 08:23:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Maciej enczykowski <maze@google.com>,
	Lina Wang <lina.wang@mediatek.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: add missing required classifier
Date: Thu, 25 Jan 2024 09:22:50 +0100
Message-ID: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

the udpgro_fraglist self-test uses the BPF classifiers, but the
current net self-test configuration does not include it, causing
CI failures:

 # selftests: net: udpgro_frglist.sh
 # ipv6
 # tcp - over veth touching data
 # -l 4 -6 -D 2001:db8::1 -t rx -4 -t
 # Error: TC classifier not found.
 # We have an error talking to the kernel
 # Error: TC classifier not found.
 # We have an error talking to the kernel

Add the missing knob.

Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-tests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 8da562a9ae87..ca4423ee6dc9 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -42,6 +42,7 @@ CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_CLS_BPF=m
 CONFIG_NET_ACT_TUNNEL_KEY=m
 CONFIG_NET_ACT_MIRRED=m
 CONFIG_BAREUDP=m
-- 
2.43.0


