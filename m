Return-Path: <linux-kselftest+bounces-4858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E0785813A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 16:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C447F1C20C85
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4DC139584;
	Fri, 16 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbYC0Z07"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A612FF7E
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097335; cv=none; b=fn1YimrHAHRvj0ESDGxJWYYV3mHaz2hDuhOXtCP4tW7sBpc4hPhUwIX98EY5E9RIsBtjKowZCEvuKjsbeN+8GP7rRCGJiYmpbAtOH7A25qdZ7ok2oKiGisFFUTz8w7eEG3gbvBJiMauZtUtOTXcN8m5HdWvZTvwt+M0zv+AEcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097335; c=relaxed/simple;
	bh=9JtqUD4H+QMoMeLgxYvnHUYwZtJRB62zSin+RRdDwvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gwi6oGWcW6sVcmTv7XRErt/X61UoMIF3nCg86Do+hZeseKFjsC3PmZhuyJxPvOaeHIw52Cy+YmzvCFrAfHMXA+M62kucS1WwuK//XxKauI33cN8Wd34Rk4RmKxcs0Mt8IMdikPl3Lmc2i+hqNVQIQxyu0th0Ljai4fkZkuuGlTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FbYC0Z07; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708097332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ACNwUVfeFIqXfix8WcKxa6n3HPWTuOXlQoqaXBS9js=;
	b=FbYC0Z07eWtDzJzJVnn4v/l/zdC1ec1jK7shYg/3hzsXAUQS/rd+ehvNKL3JJy/dXmNT8H
	4kwNXSIs5poXWeKiv7YTKZsVoIia5CwrTSHwMeADlau/dEuKr5vEh8dOpfOXrR12tth4P6
	2wnj9VyyMaaTNM4+/HM1VT87xhgEc0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-FPActdkfOUyvmx_vcIPDZQ-1; Fri, 16 Feb 2024 10:28:49 -0500
X-MC-Unique: FPActdkfOUyvmx_vcIPDZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A074185A781;
	Fri, 16 Feb 2024 15:28:48 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D6BD31C06532;
	Fri, 16 Feb 2024 15:28:47 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Simon Horman <horms@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC 1/7] selftests: openvswitch: add test case error directories to clean list
Date: Fri, 16 Feb 2024 10:28:40 -0500
Message-ID: <20240216152846.1850120-2-aconole@redhat.com>
In-Reply-To: <20240216152846.1850120-1-aconole@redhat.com>
References: <20240216152846.1850120-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Normally, the openvswitch selftests don't keep error files around, but
if debugging, there is an option to keep these files.  The 'clean'
target should be informed that they exist to ensure they are deleted
properly.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/openvswitch/Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/Makefile b/tools/testing/selftests/net/openvswitch/Makefile
index 2f1508abc826..e6c4a89cc14a 100644
--- a/tools/testing/selftests/net/openvswitch/Makefile
+++ b/tools/testing/selftests/net/openvswitch/Makefile
@@ -8,6 +8,16 @@ TEST_PROGS := openvswitch.sh
 
 TEST_FILES := ovs-dpctl.py
 
-EXTRA_CLEAN := test_netlink_checks
+OVS_TESTS := \
+	test_arp_ping \
+	test_ct_connect_v4 \
+	test_connect_v4 \
+	test_nat_connect_v4 \
+	test_nat_related_v4 \
+	test_netlink_checks \
+	test_upcall_interfaces \
+	test_drop_reason
+
+EXTRA_CLEAN := $(OVS_TESTS)
 
 include ../../lib.mk
-- 
2.41.0


