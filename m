Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4FA3B8277
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jun 2021 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhF3MyQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Jun 2021 08:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234784AbhF3MyP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Jun 2021 08:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625057506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sn7TKI5Mx5TAJsiknVFxBxXEEbE3nLFgAMZhZMxyZAE=;
        b=UsEhDqhIh65LqRGAgfDLj8+WgwNKWOc7mNzhOa1rc1wsxw1naj7gSHNLH6L7xTudiG7Tq+
        trbebWSrC0XYstkAcmZOBfM5OPfpD0mgmHH9TyHBZlKIQlInsr5LNx1Wd34zKMsOWtV3Ou
        kTTmmgl9L+KyU4ChfPxku5pax/EzFts=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-livTQvWfOoiOxPHh45mN3w-1; Wed, 30 Jun 2021 08:51:45 -0400
X-MC-Unique: livTQvWfOoiOxPHh45mN3w-1
Received: by mail-wr1-f71.google.com with SMTP id u7-20020a5d46870000b029012786ba1bc9so906532wrq.21
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Jun 2021 05:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sn7TKI5Mx5TAJsiknVFxBxXEEbE3nLFgAMZhZMxyZAE=;
        b=lSp48x6VBX2r+ZIgjKVXgFAoHZwrTvIDQ2zUAdQmROETTJQBdhf6jTswQfyplhzuv9
         v3PJItcnZTDBkLR7KIyF5ZpVvmeUeIknTl/AZd3VclCIa5O+pmHiJ8QBV+GS1km6TPrb
         eSkkNdOJl9305zIeryTCI2voYlSbaAXrE23h5tzGz0Ta7EpuAnquMMBkMzJhEHagFVZj
         rRyn8YV4n9/QnR7n9uqDacycDCcCrVFPfIe5sqK6m5pqRRv6QYFefh8qs4fkdUxrL/vu
         gMLJ7Eup0zisemTpo6YSfPS7e1DKXcbW5DsGOH6QTBZKINLRD8g0YH3dh1HUELRzbjfg
         Gtog==
X-Gm-Message-State: AOAM533sxIBXENi708Dt/H7ToLFzl27yEJN2GyI1xx6P4migWsWO7+m1
        steV39NikvdxKpWu0zoSrHCpvRFdcXiHJBA9fDx1xL0cnc1k4OLaaoJuXuTWY4rIrkKUFzMq4Hg
        GA1zTFaz6EHf8GMo/aq2GOi2wW5TZ
X-Received: by 2002:adf:fc82:: with SMTP id g2mr38708274wrr.323.1625057504143;
        Wed, 30 Jun 2021 05:51:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaXcOOTEBKJdcSkD486sAmCbe/C0JMrtnBBw42wyuGW4g/AxS2h0I+O1iSJoiNAwMlUWJGEw==
X-Received: by 2002:adf:fc82:: with SMTP id g2mr38708257wrr.323.1625057504014;
        Wed, 30 Jun 2021 05:51:44 -0700 (PDT)
Received: from pc-23.home (2a01cb058d44a7001b6d03f4d258668b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d44:a700:1b6d:3f4:d258:668b])
        by smtp.gmail.com with ESMTPSA id h10sm6412159wmq.0.2021.06.30.05.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:51:43 -0700 (PDT)
Date:   Wed, 30 Jun 2021 14:51:41 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/4] selftests: forwarding: Test redirecting sit
 packets to Ethernet
Message-ID: <7c2846f575b3477a12022b30dde5bb05dab9b065.1625056665.git.gnault@redhat.com>
References: <cover.1625056665.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1625056665.git.gnault@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add selftests for the following commit:
  * 730eed2772e7 ("sit: allow redirecting ip6ip, ipip and mplsip
    packets to eth devices").

In collect_md mode, if a fallback sit tunnel is already created, the
script can't create its own sit device (EEXIST). Therefore, we have to
skip this test when such fallback tunnels are created automatically in
new network namespaces.

Also, sit devices in ip6ip mode don't work in collect_md mode. Skip the
test for the moment.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 tools/testing/selftests/net/forwarding/config |  1 +
 .../net/forwarding/tc_redirect_l2l3.sh        | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index 9d28f801866f..c543b441a8b5 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -18,3 +18,4 @@ CONFIG_NAMESPACES=y
 CONFIG_NET_NS=y
 CONFIG_NET_IPGRE=m
 CONFIG_NET_IPIP=m
+CONFIG_IPV6_SIT=m
diff --git a/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh b/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh
index 3e69b5deb608..fd9e15a6417b 100755
--- a/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh
+++ b/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh
@@ -24,6 +24,7 @@
 ALL_TESTS="
 	redir_gre
 	redir_ipip
+	redir_sit
 "
 
 NUM_NETIFS=0
@@ -226,6 +227,39 @@ ping_test()
 	set -e
 }
 
+# Inform the user and the kselftest infrastructure that a test has been
+# skipped.
+#
+# Parameters:
+#
+#   $1: Description of the reason why the test was skipped.
+#
+skip_test()
+{
+	echo "SKIP: $1"
+
+	# Do not override KSFT_FAIL
+	if [ "${KSFT_RET}" -eq "${KSFT_PASS}" ]; then
+		KSFT_RET="${KSFT_SKIP}"
+	fi
+}
+
+# Check that no fallback tunnels are automatically created in new network
+# namespaces.
+#
+has_fb_tunnels()
+{
+	local FB_TUNNELS
+
+	FB_TUNNELS=$(sysctl -n net.core.fb_tunnels_only_for_init_net 2>/dev/null || echo 0);
+
+	if [ "${FB_TUNNELS}" -ne 0 ]; then
+		return 1
+	else
+		return 0
+	fi
+}
+
 redir_gre()
 {
 	setup_tunnel "ipv4" "classical" "gre"
@@ -258,6 +292,32 @@ redir_ipip()
 	cleanup_tunnel
 }
 
+redir_sit()
+{
+	setup_tunnel "ipv4" "classical" "sit" "mode any"
+	ping_test ipv4 "SIT, classical mode: IPv4 / IPv4"
+	ping_test ipv6 "SIT, classical mode: IPv4 / IPv6"
+	ping_test ipv4-mpls "SIT, classical mode: IPv4 / MPLS / IPv4"
+	ping_test ipv6-mpls "SIT, classical mode: IPv4 / MPLS / IPv6"
+	cleanup_tunnel
+
+	if has_fb_tunnels; then
+		skip_test "SIT, can't test the external mode, fallback tunnels are enabled: try \"sysctl -wq net.core.fb_tunnels_only_for_init_net=2\""
+		return 0
+	fi
+
+	setup_tunnel "ipv4" "collect_md" "sit" "mode any external"
+	ping_test ipv4 "SIT, external mode: IPv4 / IPv4"
+
+	# ip6ip currently doesn' work in collect_md mode
+	skip_test "SIT, ip6ip is known to fail in external mode (at least on Linux 5.13 and earlier versions)"
+	#ping_test ipv6 "SIT, external mode: IPv4 / IPv6"
+
+	ping_test ipv4-mpls "SIT, external mode: IPv4 / MPLS / IPv4"
+	ping_test ipv6-mpls "SIT, external mode: IPv4 / MPLS / IPv6"
+	cleanup_tunnel
+}
+
 exit_cleanup()
 {
 	if [ "${TESTS_COMPLETED}" = "no" ]; then
-- 
2.21.3

