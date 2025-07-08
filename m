Return-Path: <linux-kselftest+bounces-36775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E01AFDA84
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 00:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C27E1BC1398
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 22:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF32550D4;
	Tue,  8 Jul 2025 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWmmj/cO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D425487B;
	Tue,  8 Jul 2025 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012411; cv=none; b=iD+DpDTU+q4GAuXWjGVGrHZgc5Ue8cLnhHfh1hvJgywRaxIrPhI+l88vUcoFGCDKlay5LdXdVpuXH9bo5t+EMR8T1SVD1Tf+1McfxRAs7CjrFEhFO0SsmAJIf7LlojCxBhPA0jLixybfKqF8T1IwkdtArru8JuBDwAvB6ax7ACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012411; c=relaxed/simple;
	bh=5XzxeflMvV9RaOrnlnbP0iR61NvfjDE5LbAAWtXLvzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dn0dDTinH1o3iB/1bZosi5gmSsyux8876ygbaebDapM8Wkm7BD8m2Zry62WRvpQ1RfZWJUNutC/0vc03ddS1UfG4Ze28rHgjKFxKzQzaHo2mQVR2dA0WeMJDsI/8lWJtmC8YJ8TwENvX+LEgNoA+9wVdgJ3fEJvcDZ0WzJqHYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWmmj/cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09744C4CEF7;
	Tue,  8 Jul 2025 22:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752012410;
	bh=5XzxeflMvV9RaOrnlnbP0iR61NvfjDE5LbAAWtXLvzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWmmj/cOjjZjpCE5XS1nU4828rvwQJw3jzUnZWci3rpv6on5BYmdZxwbHRwoeSu1B
	 FeZ9Y37xe8LVcxSd7oKS+2XXKM7J6njmRMNu+Iqkws63oUv9PF7KwX6Ud5dFpFz7Jq
	 Nukb0ByhmX1Xv466g9YJ2Jyz88VpIg25Pd3qu0PqpqRde+p+2HVYTbqtZpKiGofc9C
	 AQzIWGas6MjajLkL1ukMsXiA9BZIvFY2e8IAOHx/tp5kNEDOsDEx4MVIXwqm4h1Bg3
	 F06N7y36mTUBrP+A7EkPiEqFqDNzS7UHYT441ZYSYqfU3h9YzwJf/V8YgfwXHlTm0C
	 VXOPTaYOrgwmg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	maxime.chevallier@bootlin.com,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] ethtool: mark ETHER_FLOW as usable for Rx hash
Date: Tue,  8 Jul 2025 15:06:38 -0700
Message-ID: <20250708220640.2738464-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708220640.2738464-1-kuba@kernel.org>
References: <20250708220640.2738464-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like some drivers (ena, enetc, fbnic.. there's probably more)
consider ETHER_FLOW to be legitimate target for flow hashing.
I'm not sure how intentional that is from the uAPI perspective
vs just an effect of ethtool IOCTL doing minimal input validation.
But Netlink will do strict validation, so we need to decide whether
we allow this use case or not. I don't see a strong reason against
it, and rejecting it would potentially regress a number of drivers.
So update the comments and flow_type_hashable().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/uapi/linux/ethtool.h | 4 ++--
 net/ethtool/ioctl.c          | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 707c1844010c..9e9afdd1238a 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2314,7 +2314,7 @@ enum {
 	IPV6_USER_FLOW	= 0x0e, /* spec only (usr_ip6_spec; nfc only) */
 	IPV4_FLOW	= 0x10, /* hash only */
 	IPV6_FLOW	= 0x11, /* hash only */
-	ETHER_FLOW	= 0x12, /* spec only (ether_spec) */
+	ETHER_FLOW	= 0x12, /* hash or spec (ether_spec) */
 
 	/* Used for GTP-U IPv4 and IPv6.
 	 * The format of GTP packets only includes
@@ -2371,7 +2371,7 @@ enum {
 /* Flag to enable RSS spreading of traffic matching rule (nfc only) */
 #define	FLOW_RSS	0x20000000
 
-/* L3-L4 network traffic flow hash options */
+/* L2-L4 network traffic flow hash options */
 #define	RXH_L2DA	(1 << 1)
 #define	RXH_VLAN	(1 << 2)
 #define	RXH_L3_PROTO	(1 << 3)
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 139f95620cdd..67f6d900a4ee 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -981,6 +981,7 @@ static int ethtool_rxnfc_copy_to_user(void __user *useraddr,
 static bool flow_type_hashable(u32 flow_type)
 {
 	switch (flow_type) {
+	case ETHER_FLOW:
 	case TCP_V4_FLOW:
 	case UDP_V4_FLOW:
 	case SCTP_V4_FLOW:
-- 
2.50.0


