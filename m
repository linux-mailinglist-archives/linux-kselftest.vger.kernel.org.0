Return-Path: <linux-kselftest+bounces-3593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3972483CA91
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 19:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F089228BC85
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC92133983;
	Thu, 25 Jan 2024 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWL5D/75"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B8132C04
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206162; cv=none; b=eKrjSPCWSIxbmQ04kKoGGfO7T+FUZ+P0jpDFOUL98FcAptwAz86kAY9X0nFQ1N6DqKcwR5TPRnIPbLNk/WHT4fpRjmGcQs9SEgZir5IfI1Uyj8kRCyUsw4rU0MkdZvr5u6inxfYHH8PTtH7yFraYb7d2HckrKmqVdIi8capfKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206162; c=relaxed/simple;
	bh=x9sRqV3hC/XcuQMwTaODTmd26LK5jjkv/G5dMeLV0+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gkb/c5axllxs0rbTA3NRu9tGobtZirESHZdH/9MDYq69qZjzHIZJoI9faIyQoze3KLUmkYNxveWotYi5IsI+P6I2zQ+NYL/TVlRThfMYQknkNr7nIG9niRH/pAMH1zfLWkaRnEqQvpVHDjtcxT5+xKPcsDkfKzKrGyORVNgj4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWL5D/75; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706206159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sg9+ktb/HYu5+TMU9uhf3pyyy7AvynDtYCcoVozMG5w=;
	b=iWL5D/75NL63IlfHTSqhgj31qt6NCZR7SLFgx6FxUK0kXf57MEBdCpqyI7np2CqsDY2RnD
	QphK/beTqymG4QidZrlnTJ1Mfo6thFI6DlmkkteHaHGRyWDlSWj2Ply3S4Y3DJg4KCySk1
	aSOnY2Mbm44eNxi9ZwTU3B+1i/Z3b1A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-3aUVE1o5PzuHawXYkyvY1g-1; Thu,
 25 Jan 2024 13:09:15 -0500
X-MC-Unique: 3aUVE1o5PzuHawXYkyvY1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 009F31C0BA49;
	Thu, 25 Jan 2024 18:09:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B87B62166B32;
	Thu, 25 Jan 2024 18:09:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: give more time for GRO aggregation
Date: Thu, 25 Jan 2024 19:09:06 +0100
Message-ID: <bffec2beab3a5672dd13ecabe4fad81d2155b367.1706206101.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The gro.sh test-case relay on the gro_flush_timeout to ensure
that all the segments belonging to any given batch are properly
aggregated.

The other end, the sender is a user-space program transmitting
each packet with a separate write syscall. A busy host and/or
stracing the sender program can make the relevant segments reach
the GRO engine after the flush timeout triggers.

Give the GRO flush timeout more slack, to avoid sporadic self-tests
failures.

Fixes: 9af771d2ec04 ("selftests/net: allow GRO coalesce test on veth")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/setup_veth.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/selftests/net/setup_veth.sh
index a9a1759e035c..1f78a87f6f37 100644
--- a/tools/testing/selftests/net/setup_veth.sh
+++ b/tools/testing/selftests/net/setup_veth.sh
@@ -11,7 +11,7 @@ setup_veth_ns() {
 	local -r ns_mac="$4"
 
 	[[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name}"
-	echo 100000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
+	echo 1000000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
 	ip link set dev "${ns_dev}" netns "${ns_name}" mtu 65535
 	ip -netns "${ns_name}" link set dev "${ns_dev}" up
 
-- 
2.43.0


