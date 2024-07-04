Return-Path: <linux-kselftest+bounces-13185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673AE92727F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 11:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9807A1C24C4F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD41AC451;
	Thu,  4 Jul 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSf6r9VI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E061AB8EC
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Jul 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083518; cv=none; b=T3DummLo29J5b++ecYubOPEY8nQgkmwr92Lp6uimC0EQvMtrL+43+hmvR5QLHE9YEKRSqeEfW2FQyFYGkot2NxdCJpduSkPNS6eIgySxCVfKveE8+xEvEzB0n0uj3WuLQxUx9lKwnUntHFzDqTZsigL3kYxSn7XMJ3zV+SfJzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083518; c=relaxed/simple;
	bh=rhrUK4kSWPb2+QOzvaLUotusmiPqRE5EK/ab8QLEDrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=As7HgK0eB0pRY7XybZGUpGAXhCANTlb4zTunZS5H9WvqRWUD7UVFLCAKqAyti27XvkgCigXPm1Jk39B4aZk197tKG7ovWLp02GoIzvD0987xToQR3Pru1tRaHx/T9rpot9YxOr4Hj4tVxddWJuH5TrkM0JyCCCF97FQbvXcDJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSf6r9VI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720083516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCsarsE51WIWuJR3kqpDN3VLDdV6+uotyzVsuXmGHHw=;
	b=LSf6r9VIemoSpqiKFpNKiH5hGFN4ZJH7E6b3n4xki6In7u/zwQod1u7ZbQtb10j4R1BNzM
	Y45po7MO7/aZiVtkMNK8FkmJYrgO2FgVmVbcW7AAOgTKDIHHtQeH4yacR13F9zh/iXyeBO
	LOUwNmS1PTSoPY7lk6xYmzEJEhfatdk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-SYhQ_q6UNRO4vDgw4xyv9Q-1; Thu,
 04 Jul 2024 04:58:30 -0400
X-MC-Unique: SYhQ_q6UNRO4vDgw4xyv9Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7DE019560B0;
	Thu,  4 Jul 2024 08:58:28 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.59])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6697195605F;
	Thu,  4 Jul 2024 08:58:24 +0000 (UTC)
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
Subject: [PATCH net-next v9 09/10] selftests: openvswitch: parse trunc action
Date: Thu,  4 Jul 2024 10:57:00 +0200
Message-ID: <20240704085710.353845-10-amorenoz@redhat.com>
In-Reply-To: <20240704085710.353845-1-amorenoz@redhat.com>
References: <20240704085710.353845-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The trunc action was supported decode-able but not parse-able. Add
support for parsing the action string.

Reviewed-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../testing/selftests/net/openvswitch/ovs-dpctl.py  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 4ccf26f96327..e8dc9af10d4d 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -863,6 +863,19 @@ class ovsactions(nla):
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
2.45.2


