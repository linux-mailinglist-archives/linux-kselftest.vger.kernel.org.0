Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD513742D8
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 May 2021 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhEEQsp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 May 2021 12:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235495AbhEEQqh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 May 2021 12:46:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 302E5613AA;
        Wed,  5 May 2021 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620232594;
        bh=UWpbrYskpnh6yjz5JX5jnlSxDsV2p+ybcsR7Fj3BBc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zj+I0Lg7HTxUhhUFPCfpM3kDhWJAkoTr12eeQQLdrPv1vrq55bw1MC5lYEjBlrmu+
         xdknOfq8Gq2zMWE6aK1h9aW5X+bCEb9lcnpHUChbEvb+Z1aJ/TmN2rsCXKwW/b3qya
         UW1B1oAdJJP3FsOMALA9S4Z7G0JGNf1yScKJk69jB0ZD4397i61XPZGN1XLnQGBZIN
         y4u4D8wXv4dBTqNKafTAmbBuiDpYSzPzY2SAYWX3F2qfp/sOSF8jfTKaXE0twImek3
         JjmGuNgD7lGWKLMV4ziPqmHVuuSoF5hzpc6a/mNd9Zmngj91226NDvA1AtOgb9RO7i
         dJg6EvaRaOhHw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Petr Machata <petrm@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 096/104] selftests: mlxsw: Increase the tolerance of backlog buildup
Date:   Wed,  5 May 2021 12:34:05 -0400
Message-Id: <20210505163413.3461611-96-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163413.3461611-1-sashal@kernel.org>
References: <20210505163413.3461611-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Petr Machata <petrm@nvidia.com>

[ Upstream commit dda7f4fa55839baeb72ae040aeaf9ccf89d3e416 ]

The intention behind this test is to make sure that qdisc limit is
correctly projected to the HW. However, first, due to rounding in the
qdisc, and then in the driver, the number cannot actually be accurate. And
second, the approach to testing this is to oversubscribe the port with
traffic generated on the same switch. The actual backlog size therefore
fluctuates.

In practice, this test proved to be noisier than the rest, and spuriously
fails every now and then. Increase the tolerance to 10 % to avoid these
issues.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Acked-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
index b0cb1aaffdda..33ddd01689be 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
@@ -507,8 +507,8 @@ do_red_test()
 	check_err $? "backlog $backlog / $limit Got $pct% marked packets, expected == 0."
 	local diff=$((limit - backlog))
 	pct=$((100 * diff / limit))
-	((0 <= pct && pct <= 5))
-	check_err $? "backlog $backlog / $limit expected <= 5% distance"
+	((0 <= pct && pct <= 10))
+	check_err $? "backlog $backlog / $limit expected <= 10% distance"
 	log_test "TC $((vlan - 10)): RED backlog > limit"
 
 	stop_traffic
-- 
2.30.2

