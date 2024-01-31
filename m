Return-Path: <linux-kselftest+bounces-3859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AF084454A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 17:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761C31F21B37
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E512BE9D;
	Wed, 31 Jan 2024 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIIEDBLy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5BB12BF05;
	Wed, 31 Jan 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720174; cv=none; b=Y86HL2ZPSWK/T/sO1tSPNR9m0zYuROKsuDJwXJ3WmEb+70sYMboUEE6aSqGwaEDJ3A2m9i0X93qiIMADxik4PLiNIwZIV+oSCVsfPvUgZtgDE+3HnpEIbA6X+rOB/7ieQg+j4Ld26qAnJXjeF05HbKFBW0FVohOywDnLCF7Y+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720174; c=relaxed/simple;
	bh=wLme8vAvs0RMuOnrRSdLTDj5Z4kr76/vqvQSAHIKS+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3In044JJNIw0SzyG3P28ARgcDL6LfyTXUbvcC/8rD17pyTeLME4LxNpOeODSlZSWDgzM0n4aomxL3+28QhRRCiskA/+mzM8PJggBSkfa9uTDJgZh1bhzzKFwIwnnTGTXi3DfCBKkcEbslJVuEUjfO4CRu0eNH8O05wkVp8nIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIIEDBLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFE4C433F1;
	Wed, 31 Jan 2024 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706720173;
	bh=wLme8vAvs0RMuOnrRSdLTDj5Z4kr76/vqvQSAHIKS+4=;
	h=From:To:Cc:Subject:Date:From;
	b=rIIEDBLya2evSWafTcS8vHu2XIh/GyvEF2rGVFNMlxweYvqJ1cWrpQC3dbuoGqaiY
	 dOK31okDJ8KxhJoFca43l3PlAK2T0liB0eURGes13XnICeAWSpHzixiwvIFJdNKPON
	 f2JZlCo4fHkKIP3fw/yRl8zdqUD5CAdYJr+IZMYbkdXvUFJZ234HOTuYR1CWO/XV7e
	 kVD6/+r1bCnblVlDducPH9XQI59MvrWGrsbZOAMOCb2dRzihWmJFn46GZkDA77poiA
	 x+f2/qjACW3SeqlHoiEZ7fCx0qxduBkENDHNdyykHwLoD3pYj8qKotvN4W22F07+Hh
	 0+fQJBcJK0L+Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	ap420073@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: add missing config for NF_TARGET_TTL
Date: Wed, 31 Jan 2024 08:56:05 -0800
Message-ID: <20240131165605.4051645-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt test uses the TTL iptables module:

  ip netns exec "${RELAY}" iptables -t mangle -I PREROUTING \
  	-d 239.0.0.1 -j TTL --ttl-set 2

Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: ap420073@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 77a173635a29..69f0cbd19d35 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -33,6 +33,7 @@ CONFIG_IP6_NF_NAT=m
 CONFIG_IP6_NF_RAW=m
 CONFIG_IP_NF_NAT=m
 CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IPV6_GRE=m
 CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_L2TP_ETH=m
-- 
2.43.0


