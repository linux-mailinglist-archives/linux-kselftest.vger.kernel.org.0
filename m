Return-Path: <linux-kselftest+bounces-23471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C23649F58B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 22:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2EC189658E
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6ED1FA830;
	Tue, 17 Dec 2024 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8c8kQXB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE231FA149
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2024 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470234; cv=none; b=c0/sW6rd+7+AXMCJgopYqk/XiFrgfaGSQWQwJsRj5To5w2+EvM72G+o5DyBl5GBPS/kI7IgzAtOeICHXvSUnQkqB+ce9HAC/pxmbLueRdefzVPqLZ1THA4rKEnwedSSD752wf4Kqhuoz/pQuE+jy79N/Z6QxhzBrsRv/K1D8YtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470234; c=relaxed/simple;
	bh=XQqcSXCS7+3yXeFhYE/LHLIlCgVev1+/ITPt3X/ZZ0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSgf9US4OebfRrip/UegrbAiygCszdeKXWxooORtwyiVucMLPCxYXdBH4ozLkJnPiZzRH5D7T0/LlvgDVFWHAMuPmPqBhpVN/JlHXVY7kDysVB3l+1fOm5S0gIXSAHiYwmPDCEmtsylfTGZIJPvmtHItTeCTFRIUijS3svPEM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8c8kQXB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734470231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PORQUlxGEfR5cpiw3XNjF5GcFo76IHLBJiTCdzbzG9A=;
	b=L8c8kQXBDwrFqMBYxfd9fza39i/tv+0di4Z9T3WO0aqKkcyPRukC4xJZLp8F0z9sq/tgv8
	ffcflfUuflhcHIBPSXK5s3pbzEF1mAkJjwITXhokD+UY8Eef4FKybfO50NAnXUId//ywsf
	hoPYOLiBIhb9f97c71ZlMRc/7ebddUw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-SC-GqNSmPEexydsu2nAyJg-1; Tue,
 17 Dec 2024 16:17:08 -0500
X-MC-Unique: SC-GqNSmPEexydsu2nAyJg-1
X-Mimecast-MFC-AGG-ID: SC-GqNSmPEexydsu2nAyJg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29EDD1955F66;
	Tue, 17 Dec 2024 21:17:06 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.221])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B00419560A2;
	Tue, 17 Dec 2024 21:17:00 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] selftests: openvswitch: fix tcpdump execution
Date: Tue, 17 Dec 2024 22:16:51 +0100
Message-ID: <20241217211652.483016-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix the way tcpdump is executed by:
- Using the right variable for the namespace. Currently the use of the
  empty "ns" makes the command fail.
- Waiting until it starts to capture to ensure the interesting traffic
  is caught on slow systems.
- Using line-buffered output to ensure logs are available when the test
  is paused with "-p". Otherwise the last chunk of data might only be
  written when tcpdump is killed.

Fixes: 74cc26f416b9 ("selftests: openvswitch: add interface support")
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 tools/testing/selftests/net/openvswitch/openvswitch.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index cc0bfae2bafa..960e1ab4dd04 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -171,8 +171,10 @@ ovs_add_netns_and_veths () {
 		ovs_add_if "$1" "$2" "$4" -u || return 1
 	fi
 
-	[ $TRACING -eq 1 ] && ovs_netns_spawn_daemon "$1" "$ns" \
-			tcpdump -i any -s 65535
+	if [ $TRACING -eq 1 ]; then
+		ovs_netns_spawn_daemon "$1" "$3" tcpdump -l -i any -s 6553
+		ovs_wait grep -q "listening on any" ${ovs_dir}/stderr
+	fi
 
 	return 0
 }
-- 
2.47.1


