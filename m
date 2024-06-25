Return-Path: <linux-kselftest+bounces-12747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 575269172C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 22:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBEE28594D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82B41836C2;
	Tue, 25 Jun 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieysEWwC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E5717DE33
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348800; cv=none; b=Nk6wh1pQgyVb1Qt7MqeSSxU3qvQlvzsWPbOzU/UmLH/g81q6WNTDgGKWNwC4o0xMPaiF8WaVjQAu31/NwwIUFLqGzATeg3V1Ogxw1gVsAnZewplaOHiEPmA41uiorTT/8HkfTi+kDmFZSc3rZZmYB0fEsZyxQ+vSvOISlvSakog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348800; c=relaxed/simple;
	bh=s+46G/HTgSaAvzWEPRF8IdXtAuOgoUmoSsA67yBkcHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pb4mbrinx9hbWO5owFOafeA5P7JXd3WwMiobQbSUqGI58pk44dzPMBpXm/yGjn6+/TZmrgaKWwVKid01EkdrhhIlNOV7ZAcpOMhw04UiuFw4f2kmHxoZt9bAyLAaABWSWl48CIOYrV/zmf5dVWKQATioF9TqY2/saCoLRV3RAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieysEWwC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719348798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAes/b2lFjyrQBJvsuBEssQ0NLIE1Z/gUqbX5ekLpT4=;
	b=ieysEWwCLdRc2mKk9js/z8XubTUYq3vqOhhdwQmIHkf42vzDeqAGmLhpApuiZ0jAq22T8n
	FlU4nZFBLpVls5Sh9B1fwjcupDIs8Lw61VLtBYT/+IxwZoczjbzT9XKNFA5EQnxMyRLsXv
	iYMb9Nwyt8fdm2DX4kwo8mfAzj/m4yg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-Xl46B-wZPR2yJlVBgxxsyA-1; Tue,
 25 Jun 2024 16:53:15 -0400
X-MC-Unique: Xl46B-wZPR2yJlVBgxxsyA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C81A19560B0;
	Tue, 25 Jun 2024 20:53:13 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.93])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49AFC19560BF;
	Tue, 25 Jun 2024 20:53:08 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 09/10] selftests: openvswitch: parse trunc action
Date: Tue, 25 Jun 2024 22:51:52 +0200
Message-ID: <20240625205204.3199050-10-amorenoz@redhat.com>
In-Reply-To: <20240625205204.3199050-1-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The trunc action was supported decode-able but not parse-able. Add
support for parsing the action string.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../testing/selftests/net/openvswitch/ovs-dpctl.py  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 071309289cff..a3c26ddac42f 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -817,6 +817,19 @@ class ovsactions(nla):
                 self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
                 parsed = True
 
+            elif parse_starts_block(actstr, "trunc(", False):
+                parencount += 1
+                actstr, val = parse_extract_field(
+                    actstr,
+                    "trunc(",
+                    r"([0-9]+)",
+                    int,
+                    False,
+                    None,
+                )
+                self["attrs"].append(["OVS_ACTION_ATTR_TRUNC", val])
+                parsed = True
+
             actstr = actstr[strspn(actstr, ", ") :]
             while parencount > 0:
                 parencount -= 1
-- 
2.45.1


