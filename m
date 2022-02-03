Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1304A8238
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Feb 2022 11:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350172AbiBCKRh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Feb 2022 05:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350071AbiBCKRN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Feb 2022 05:17:13 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FF5C06173D
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Feb 2022 02:17:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so1454313wms.3
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Feb 2022 02:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=o3foges394i2Torrv4y+TkfDP2u0wbyz9Waj/q2IzPs=;
        b=YyabZF+bAVlRUnVwcDYtoiQuljWP8JdqwJ197sAprqEqfy3sUeWGBzBPvbwHfkl+yZ
         TkJGHXhhiT5XFU426aMqKd26Wm2OXpj189RZW8qlgUtSlUi+vhD9tCJOHGpTeKywBbKw
         HSJL167+DsD/m0oJweA4wrMli+DLoY+pvjeT+CvAIph+m6vRg61PadA+baeDyqBGbF8L
         Hx0rga7a23FFBBJMmTj1ZCIWyuMFPgZCPm9Fa5pznlV9aI0hcVw4YBPsSuOAhQsfAiBO
         8ACnLygQxPst0fyQh2dJKFgePAomhNsXXXNmexztTCkC0vRhUvQpoQie/Nn9Ai2tkrsF
         eGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=o3foges394i2Torrv4y+TkfDP2u0wbyz9Waj/q2IzPs=;
        b=Rljsb7bbSjgOx9koWG50noY70UsB/6GoSPW0uF/epC3iVp7bDRlhoqq1j6q/ytoucl
         rVxjfFIwfodkQg3urHFWljF1eSl8gT+SzpKidOsjkSgg5U/9CfyEU9B/4fifMPeuLz22
         6PeEEzdiApxwaauCBnaQS53YlVQ+sUzqxjOEDbwmYYTZOhZIUHHDDQoTjqlmYCQxgWpa
         5KUF86F95PToELZOabi6Ef1NZhOHqrDddZg6xngj4MuLS79yox/70FkHuDm0bKHLw4Ow
         Lw7rzecPatHg+gb9++hJz5IYNHe+zUDrq8r2+Qq4epv6d0NNd729Z1JaAbzdOblfgChy
         Hb3g==
X-Gm-Message-State: AOAM531bn85IHZVoatZMkyf/ZkVJCNnrkjsVh+raXAM551FdVXAMCO8C
        sIWTrdBOQaLNnvPGUZVH9R7Nqw==
X-Google-Smtp-Source: ABdhPJwfmVyB651XY0XDybKU/UHpoCzbXoGWw23cPBIU7I1BHaIU8CTvE8YL95uSIy3eRic/tsKSgA==
X-Received: by 2002:a05:600c:3392:: with SMTP id o18mr9769405wmp.59.1643883431935;
        Thu, 03 Feb 2022 02:17:11 -0800 (PST)
Received: from veiron.westermo.com (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id g6sm19017148wrq.97.2022.02.03.02.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 02:17:11 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Amit Cohen <amcohen@nvidia.com>,
        Guillaume Nault <gnault@redhat.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        Baowen Zheng <baowen.zheng@corigine.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 5/5] selftests: net: bridge: Parameterize ageing timeout
Date:   Thu,  3 Feb 2022 11:16:57 +0100
Message-Id: <20220203101657.990241-6-tobias@waldekranz.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203101657.990241-1-tobias@waldekranz.com>
References: <20220203101657.990241-1-tobias@waldekranz.com>
MIME-Version: 1.0
Organization: Westermo
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow the ageing timeout that is set on bridges to be customized from
forwarding.config. This allows the tests to be run on hardware which
does not support a 10s timeout (e.g. mv88e6xxx).

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh  | 5 +++--
 .../testing/selftests/net/forwarding/bridge_vlan_unaware.sh  | 5 +++--
 .../selftests/net/forwarding/forwarding.config.sample        | 2 ++
 tools/testing/selftests/net/forwarding/lib.sh                | 1 +
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
index b90dff8d3a94..64bd00fe9a4f 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh
@@ -28,8 +28,9 @@ h2_destroy()
 
 switch_create()
 {
-	# 10 Seconds ageing time.
-	ip link add dev br0 type bridge vlan_filtering 1 ageing_time 1000 \
+	ip link add dev br0 type bridge \
+		vlan_filtering 1 \
+		ageing_time $LOW_AGEING_TIME \
 		mcast_snooping 0
 
 	ip link set dev $swp1 master br0
diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
index c15c6c85c984..1c8a26046589 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
@@ -27,8 +27,9 @@ h2_destroy()
 
 switch_create()
 {
-	# 10 Seconds ageing time.
-	ip link add dev br0 type bridge ageing_time 1000 mcast_snooping 0
+	ip link add dev br0 type bridge \
+		ageing_time $LOW_AGEING_TIME \
+		mcast_snooping 0
 
 	ip link set dev $swp1 master br0
 	ip link set dev $swp2 master br0
diff --git a/tools/testing/selftests/net/forwarding/forwarding.config.sample b/tools/testing/selftests/net/forwarding/forwarding.config.sample
index b0980a2efa31..4a546509de90 100644
--- a/tools/testing/selftests/net/forwarding/forwarding.config.sample
+++ b/tools/testing/selftests/net/forwarding/forwarding.config.sample
@@ -41,6 +41,8 @@ NETIF_CREATE=yes
 # Timeout (in seconds) before ping exits regardless of how many packets have
 # been sent or received
 PING_TIMEOUT=5
+# Minimum ageing_time (in centiseconds) supported by hardware
+LOW_AGEING_TIME=1000
 # Flag for tc match, supposed to be skip_sw/skip_hw which means do not process
 # filter by software/hardware
 TC_FLAG=skip_hw
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 7da783d6f453..e7e434a4758b 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -24,6 +24,7 @@ PING_COUNT=${PING_COUNT:=10}
 PING_TIMEOUT=${PING_TIMEOUT:=5}
 WAIT_TIMEOUT=${WAIT_TIMEOUT:=20}
 INTERFACE_TIMEOUT=${INTERFACE_TIMEOUT:=600}
+LOW_AGEING_TIME=${LOW_AGEING_TIME:=1000}
 REQUIRE_JQ=${REQUIRE_JQ:=yes}
 REQUIRE_MZ=${REQUIRE_MZ:=yes}
 
-- 
2.25.1

