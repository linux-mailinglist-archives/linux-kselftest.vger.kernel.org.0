Return-Path: <linux-kselftest+bounces-12318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F339104F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 15:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476CB287A2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35F1B151D;
	Thu, 20 Jun 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBOQ+T7E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681431AD9CA
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888180; cv=none; b=uUQ7d26+dL42dCbJMFoaN3GaX1kvvQrKhzBiLx64zL9I+MIfgg+olEhmZmRYKR/rtlIg9wH7a+hwupp3ci8dDICBgyXSJj8bobmit85E13ZVWq1q3jM9ou7jmROuekDS6LzqKzGN3spsGlV/bX3N7LGo4tARJ2RPwG1ToXS4f48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888180; c=relaxed/simple;
	bh=o6RnBTW4s3uiAETke5S5c6fAOu8f+O5tvYrKnMkHzow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2au4ssM+0W72oC8QnfVFU7FwzLj4C80hN/iF4rcvjTu1WmAaPPkhnYm7CFZ/WgliFqzkw2Dn4/zVARsZO4R2Ek3W9Mx4jvgKkSQWJkOAc8Q+Iouip2rR1gClkhPsv+dZu2X+f+eslW1CSFOo3TMc5Qo7nwDzfZQ22yJdOZH6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBOQ+T7E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718888177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZ0rv/2WRMjhZezksPBXgrWYjB1aeegMia2Pp0v5mXA=;
	b=WBOQ+T7EvfaSx4Ut96qL3QaYaYUIElRYpLzBkEEl9uOmrONkvnYoM7FR6JU3pCpJg1gibY
	TTo+TEY/G4D0g8+5uFAz+muRqo4bIe8k2uatzhYh5WVeFKvQQozE6VUilGhv4VkPUA44q/
	LSQtRB9UcJq+oImfNP8AUtpoVSStQ+0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-G5r0Htv1MBqP_61_G5pDxQ-1; Thu,
 20 Jun 2024 08:56:14 -0400
X-MC-Unique: G5r0Htv1MBqP_61_G5pDxQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE98B1955D84;
	Thu, 20 Jun 2024 12:56:12 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.9.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5E0A1956087;
	Thu, 20 Jun 2024 12:56:09 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 2/7] selftests: openvswitch: Refactor actions parsing.
Date: Thu, 20 Jun 2024 08:55:56 -0400
Message-ID: <20240620125601.15755-3-aconole@redhat.com>
In-Reply-To: <20240620125601.15755-1-aconole@redhat.com>
References: <20240620125601.15755-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Until recently, the ovs-dpctl utility was used with a limited actions set
and didn't need to have support for multiple similar actions.  However,
when adding support for tunnels, it will be important to support multiple
set() actions in a single flow.  When printing these actions, the existing
code will be unable to print all of the sets - it will only print the
first.

Refactor this code to be easier to read and support multiple actions of the
same type in an action list.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 8f92215303a3..4db20b38b481 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -439,32 +439,30 @@ class ovsactions(nla):
     def dpstr(self, more=False):
         print_str = ""
 
-        for field in self.nla_map:
+        for field in self["attrs"]:
             if field[1] == "none" or self.get_attr(field[0]) is None:
                 continue
             if print_str != "":
                 print_str += ","
 
-            if field[1] == "uint32":
-                if field[0] == "OVS_ACTION_ATTR_OUTPUT":
-                    print_str += "%d" % int(self.get_attr(field[0]))
-                elif field[0] == "OVS_ACTION_ATTR_RECIRC":
-                    print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
-                elif field[0] == "OVS_ACTION_ATTR_TRUNC":
-                    print_str += "trunc(%d)" % int(self.get_attr(field[0]))
-                elif field[0] == "OVS_ACTION_ATTR_DROP":
-                    print_str += "drop(%d)" % int(self.get_attr(field[0]))
-            elif field[1] == "flag":
-                if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
-                    print_str += "ct_clear"
-                elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
-                    print_str += "pop_vlan"
-                elif field[0] == "OVS_ACTION_ATTR_POP_ETH":
-                    print_str += "pop_eth"
-                elif field[0] == "OVS_ACTION_ATTR_POP_NSH":
-                    print_str += "pop_nsh"
-                elif field[0] == "OVS_ACTION_ATTR_POP_MPLS":
-                    print_str += "pop_mpls"
+            if field[0] == "OVS_ACTION_ATTR_OUTPUT":
+                print_str += "%d" % int(self.get_attr(field[0]))
+            elif field[0] == "OVS_ACTION_ATTR_RECIRC":
+                print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
+            elif field[0] == "OVS_ACTION_ATTR_TRUNC":
+                print_str += "trunc(%d)" % int(self.get_attr(field[0]))
+            elif field[0] == "OVS_ACTION_ATTR_DROP":
+                print_str += "drop(%d)" % int(self.get_attr(field[0]))
+            elif field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
+                print_str += "ct_clear"
+            elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
+                print_str += "pop_vlan"
+            elif field[0] == "OVS_ACTION_ATTR_POP_ETH":
+                print_str += "pop_eth"
+            elif field[0] == "OVS_ACTION_ATTR_POP_NSH":
+                print_str += "pop_nsh"
+            elif field[0] == "OVS_ACTION_ATTR_POP_MPLS":
+                print_str += "pop_mpls"
             else:
                 datum = self.get_attr(field[0])
                 if field[0] == "OVS_ACTION_ATTR_CLONE":
@@ -472,7 +470,10 @@ class ovsactions(nla):
                     print_str += datum.dpstr(more)
                     print_str += ")"
                 else:
-                    print_str += datum.dpstr(more)
+                    try:
+                        print_str += datum.dpstr(more)
+                    except:
+                        print_str += "{ATTR: %s not decoded}" % field[0]
 
         return print_str
 
-- 
2.45.1


