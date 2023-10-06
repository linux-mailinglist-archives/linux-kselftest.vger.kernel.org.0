Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237377BBB78
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjJFPOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjJFPN4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 11:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF5AE4
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Oct 2023 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696605188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3BtezrsO4g/f4wdN64oWX3Tfa1nQARVL1ef9IRoW74=;
        b=NJ7EybVb4xtq77p5zhy4xcHJt29QbTD1gBzEvb1Id6GC/UKDkyR2hx6V1rctMoh14wMBJk
        4SHiPQhgdjsWJQBFymUx+tL9YqrABum6zK4+JFXhlrN4jl6UWX5yUGWa7QofOF4M7kD2Kd
        Nz5yGqeahDjkS5edxyP68FZCT+/k7Sg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-ocmP3CosMayolbt9PTMNog-1; Fri, 06 Oct 2023 11:13:02 -0400
X-MC-Unique: ocmP3CosMayolbt9PTMNog-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A290811E88;
        Fri,  6 Oct 2023 15:13:00 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C017940D1EA;
        Fri,  6 Oct 2023 15:12:59 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Adrian Moreno <amorenoz@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>
Subject: [PATCH net 1/4] selftests: openvswitch: Add version check for pyroute2
Date:   Fri,  6 Oct 2023 11:12:55 -0400
Message-Id: <20231006151258.983906-2-aconole@redhat.com>
In-Reply-To: <20231006151258.983906-1-aconole@redhat.com>
References: <20231006151258.983906-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Paolo Abeni reports that on some systems the pyroute2 version isn't
new enough to run the test suite.  Ensure that we support a minimum
version of 0.6 for all cases (which does include the existing ones).
The 0.6.1 version was released in May of 2021, so should be
propagated to most installations at this point.

The alternative that Paolo proposed was to only skip when the
add-flow is being run.  This would be okay for most cases, except
if a future test case is added that needs to do flow dump without
an associated add (just guessing).  In that case, it could also be
broken and we would need additional skip logic anyway.  Just draw
a line in the sand now.

Fixes: 25f16c873fb1 ("selftests: add openvswitch selftest suite")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/lkml/8470c431e0930d2ea204a9363a60937289b7fdbe.camel@redhat.com/
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/openvswitch/openvswitch.sh | 2 +-
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py   | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 9c2012d70b08e..220c3356901ef 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -525,7 +525,7 @@ run_test() {
 	fi
 
 	if python3 ovs-dpctl.py -h 2>&1 | \
-	     grep "Need to install the python" >/dev/null 2>&1; then
+	     grep -E "Need to (install|upgrade) the python" >/dev/null 2>&1; then
 		stdbuf -o0 printf "TEST: %-60s  [PYLIB]\n" "${tdesc}"
 		return $ksft_skip
 	fi
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 912dc8c490858..9686ca30d516d 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -28,6 +28,8 @@ try:
     from pyroute2.netlink import nlmsg_atoms
     from pyroute2.netlink.exceptions import NetlinkError
     from pyroute2.netlink.generic import GenericNetlinkSocket
+    import pyroute2
+
 except ModuleNotFoundError:
     print("Need to install the python pyroute2 package.")
     sys.exit(0)
@@ -1998,6 +2000,12 @@ def main(argv):
     nlmsg_atoms.ovskey = ovskey
     nlmsg_atoms.ovsactions = ovsactions
 
+    # version check for pyroute2
+    prverscheck = pyroute2.__version__.split(".")
+    if int(prverscheck[0]) == 0 and int(prverscheck[1]) < 6:
+        print("Need to upgrade the python pyroute2 package.")
+        sys.exit(0)
+
     parser = argparse.ArgumentParser()
     parser.add_argument(
         "-v",
-- 
2.40.1

