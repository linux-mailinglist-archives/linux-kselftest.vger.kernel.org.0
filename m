Return-Path: <linux-kselftest+bounces-3749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E757842B2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 18:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E1A1F24036
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FE514E2C9;
	Tue, 30 Jan 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KT3NXcFm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98714E2F5
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636864; cv=none; b=XwdLvJyveTQU0WpD2xTdMsDIwd8HIWtF28vRqjL3d4HZSypSjTSJhBWs8Eh95wN3hqHF2cXAMSl8Zyf15+xujbb0BDqfyKFKHat8duXOxpk5IDxWNa4H2hyTjS1frUhzbfimQhM8KHfchdYvnfQA+IQaHcquc2Ztbn1HoHZN9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636864; c=relaxed/simple;
	bh=nmg8BG7Wj6893TtvTYSkBz2olN9XWtaafMYLwVb8GWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0iNwfc5MHj5eOspOnWyNiigGSAA7U4Jh1jiQyMNYdxswiyw5XHAr0Wjb53sILYq4ACwlVaBi0eXW99KgisSf7kBqj+cTjUabBwuorQXwYibGf20outpcp14Eb2pL+PvoLLPNDABqs11+EhHwvInN0pv6O+l4wHvvQ933t1FoaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KT3NXcFm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706636861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyDqsnQp33xq6MYOJ0mCpgN6Y5betKaIxLa4qrXBatc=;
	b=KT3NXcFmw8/xiZwfWu9H6Lbo27/yTN3i3a2f7iyWKnfZu2SFcH+v7ddHHuVawpAnUv6Zqf
	dDI8GE/oJuXEX28Eso+fdaDzUoFbpN73P7QPlEHKIYgMHXvRlg8P145sRlwk6w+aqcPqWR
	GLH+g5MlwaiCe7+u9YB6t9oKaVzMK84=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-p3CpwX4UPBOgNJSjfzHYxA-1; Tue,
 30 Jan 2024 12:47:37 -0500
X-MC-Unique: p3CpwX4UPBOgNJSjfzHYxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B47451C0513E;
	Tue, 30 Jan 2024 17:47:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.163])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E67E41121306;
	Tue, 30 Jan 2024 17:47:34 +0000 (UTC)
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
Subject: [PATCH net 3/3] selftests: net: don't access /dev/stdout in pmtu.sh
Date: Tue, 30 Jan 2024 18:47:18 +0100
Message-ID: <23d7592c5d77d75cff9b34f15c227f92e911c2ae.1706635101.git.pabeni@redhat.com>
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

When running the pmtu.sh via the kselftest infra, accessing
/dev/stdout gives unexpected results:
  # dd: failed to open '/dev/stdout': Device or resource busy
  # TEST: IPv4, bridged vxlan4: PMTU exceptions                         [FAIL]

Let dd use directly the standard output to fix the above:
  # TEST: IPv4, bridged vxlan4: PMTU exceptions - nexthop objects       [ OK ]

Fixes: 136a1b434bbb ("selftests: net: test vxlan pmtu exceptions with tcp")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 31892b366913..3f118e3f1c66 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1339,7 +1339,7 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
 
 		sleep 1
 
-		dd if=/dev/zero of=/dev/stdout status=none bs=1M count=1 | ${target} socat -T 3 -u STDIN $TCPDST,connect-timeout=3
+		dd if=/dev/zero status=none bs=1M count=1 | ${target} socat -T 3 -u STDIN $TCPDST,connect-timeout=3
 
 		size=$(du -sb $tmpoutfile)
 		size=${size%%/tmp/*}
-- 
2.43.0


