Return-Path: <linux-kselftest+bounces-8104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F548A66C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 11:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DECA283E04
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 09:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EBC84A5C;
	Tue, 16 Apr 2024 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2Z+YZUN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1384A32
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258574; cv=none; b=qLuIlnn5obPs/u84G49OakdRbQ7n4at49iYCQh7lnX6yqt66kp2EymcGvbwx9m47mS7+6fStknC2FyY7PeDYlBm2OleY0OdVCnBuger64JiCz+Xpvm/oc8tgWpqCObdzGHmyhMfzgLoD1OetZlIo1TIQ9Wv+TTeI8nywMKMJijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258574; c=relaxed/simple;
	bh=xMgY05o4WNcGwMIbf2FoP4hSuwsoezTTxvV9Y0tGpJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmNDmnWcu76N5VUg+pGKCC87rAUl90cgXNTd9ielB3b7xxcTgMYycpm3yuVGfvrsMQ8WQ880YXltdBscgHqwlt0zN4Cnw6dccW7CAk1UxtbCTqWX6w8gEr6z8O5XcJbkIJbpp/tKFRIJuImLCdcBW9tP/3lUwCRzyB4iG03z5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2Z+YZUN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713258568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gSAH6Nk/9SCDTRf8sqeYrw4zixzICDDrHmbedYYm3Os=;
	b=C2Z+YZUN3ihFS+n9vhGBlsuE1lhTdbtM9jTdtTMs/4lFNC54AEeVlvLSIILp1TmhCqsJGO
	ib5N8a6983r2Tlmcz/PypIIqqYsp5HnKgAi90zX9VvMwYyG/6Br2Y4iyPpA3Y3zELf30hS
	q2fJiD2dY84+RjZYnXs2uOV6IRLbjro=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-MD1thbgZOoaGS9oUpN-O5g-1; Tue,
 16 Apr 2024 05:09:22 -0400
X-MC-Unique: MD1thbgZOoaGS9oUpN-O5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79BBB29AC00E;
	Tue, 16 Apr 2024 09:09:21 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.195.33])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A4372026962;
	Tue, 16 Apr 2024 09:09:18 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	dev@openvswitch.org (open list:OPENVSWITCH),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Pravin B Shelar <pshelar@ovn.org>,
	aconole@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>
Subject: [PATCH net-next] selftests: openvswitch: Fix escape chars in regexp.
Date: Tue, 16 Apr 2024 11:09:13 +0200
Message-ID: <20240416090913.2028475-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Character sequences starting with `\` are interpreted by python as
escaped Unicode characters. However, they have other meaning in
regular expressions (e.g: "\d").

It seems Python >= 3.12 starts emitting a SyntaxWarning when these
escaped sequences are not recognized as valid Unicode characters.

An example of these warnings:

tools/testing/selftests/net/openvswitch/ovs-dpctl.py:505:
SyntaxWarning: invalid escape sequence '\d'

Fix all the warnings by flagging literals as raw strings.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py       | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 5e0e539a323d..1dd057afd3fb 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -489,7 +489,7 @@ class ovsactions(nla):
                     actstr, reason = parse_extract_field(
                         actstr,
                         "drop(",
-                        "([0-9]+)",
+                        r"([0-9]+)",
                         lambda x: int(x, 0),
                         False,
                         None,
@@ -502,9 +502,9 @@ class ovsactions(nla):
                     actstr = actstr[len("drop"): ]
                     return (totallen - len(actstr))
 
-            elif parse_starts_block(actstr, "^(\d+)", False, True):
+            elif parse_starts_block(actstr, r"^(\d+)", False, True):
                 actstr, output = parse_extract_field(
-                    actstr, None, "(\d+)", lambda x: int(x), False, "0"
+                    actstr, None, r"(\d+)", lambda x: int(x), False, "0"
                 )
                 self["attrs"].append(["OVS_ACTION_ATTR_OUTPUT", output])
                 parsed = True
@@ -512,7 +512,7 @@ class ovsactions(nla):
                 actstr, recircid = parse_extract_field(
                     actstr,
                     "recirc(",
-                    "([0-9a-fA-Fx]+)",
+                    r"([0-9a-fA-Fx]+)",
                     lambda x: int(x, 0),
                     False,
                     0,
@@ -588,17 +588,17 @@ class ovsactions(nla):
                                 actstr = actstr[3:]
 
                             actstr, ip_block_min = parse_extract_field(
-                                actstr, "=", "([0-9a-fA-F\.]+)", str, False
+                                actstr, "=", r"([0-9a-fA-F\.]+)", str, False
                             )
                             actstr, ip_block_max = parse_extract_field(
-                                actstr, "-", "([0-9a-fA-F\.]+)", str, False
+                                actstr, "-", r"([0-9a-fA-F\.]+)", str, False
                             )
 
                             actstr, proto_min = parse_extract_field(
-                                actstr, ":", "(\d+)", int, False
+                                actstr, ":", r"(\d+)", int, False
                             )
                             actstr, proto_max = parse_extract_field(
-                                actstr, "-", "(\d+)", int, False
+                                actstr, "-", r"(\d+)", int, False
                             )
 
                             if t is not None:
-- 
2.44.0


