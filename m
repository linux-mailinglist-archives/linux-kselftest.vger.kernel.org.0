Return-Path: <linux-kselftest+bounces-12544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F539914276
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 08:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5B01C212A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 06:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACBC21340;
	Mon, 24 Jun 2024 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQMmIajA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C03208B6;
	Mon, 24 Jun 2024 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719209029; cv=none; b=aXuMNd16uQVy+CQsW4ppOWycSWRxp1j0mrYOBMGdaL6nSMVwbzoVZOh9xsWyXkkDXN3tjnMIE/NIZ6Uc4eOBQ00/Ok17XEjEW5ljMaMyIWX9IxkZFzQzkUlX8jGOLdborN34hM5Xl93kecVb6XtS2BGp7Qlr+3rsZEBm9RgHodI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719209029; c=relaxed/simple;
	bh=4MJAvZidXD59taQAHgNZO5Zgziq/Q/mwSOxc7RqrgI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=djTURJhbk3SycfCEdjwHMkfCJAg5YaN+xYzCWpwkdz0ZtKRxeiSeuO+6mfKkQpx6H9WuOh7nauHQQ42yk2zBqOHJTAMHX//aaybfn59wGo77+kRxH8XenePhZ4FSrRfbniV76j7VdCmK3AC+nT4qWEo66h0ZCbkFpQl0JL/6xKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQMmIajA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719209027; x=1750745027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4MJAvZidXD59taQAHgNZO5Zgziq/Q/mwSOxc7RqrgI4=;
  b=cQMmIajAA3y8scZfU6/JVdV/copf3sluSwItQbidk1pXufb1oDnoTssY
   TBmNiM7h035DjiRVlt0HMIk/0k9C5lxL7QLxbywWP8DRq9MsEs//pBvc3
   lOsOOGUSOdwNfHiKihlGUmC3nFgRmwvMQ3B+mNcX4JAPPJn29ijqANLCy
   vY+YG4VaM6SLrERBqP8sICZ4z1Eywxim1BlFWjpnlwkroDFv/5tMZ4z6C
   WSCPcyJB8LZ2AjmR2eaYTJ0dXJRhz3KlDkupruSJxV5q1zXBtggvgu7Pm
   tSJmkLmest9GVQQ/k42lp9/O6pwhxtFNTzhnScWbBWItVPgV97H7qvYNN
   w==;
X-CSE-ConnectionGUID: eohXCTClSbCCi+qJn4cYYg==
X-CSE-MsgGUID: T5XZQr0HScmp14Z8OmSEbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="19979355"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="19979355"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 23:03:46 -0700
X-CSE-ConnectionGUID: Y6zBlsyOQruZLaa+3/nJJg==
X-CSE-MsgGUID: FUBJrCxISx+Z8BjVWr3htQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43090360"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 23:03:44 -0700
From: Yujie Liu <yujie.liu@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net] selftests: net: remove unneeded IP_GRE config
Date: Mon, 24 Jun 2024 13:55:39 +0800
Message-Id: <20240624055539.2092322-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that there is no definition for config IP_GRE, and it is not a
dependency of other configs, so remove it.

linux$ find -name Kconfig | xargs grep "IP_GRE"
<-- nothing

There is a IPV6_GRE config defined in net/ipv6/Kconfig. It only depends
on NET_IPGRE_DEMUX but not IP_GRE.

Fixes: 04fe7c5029cb ("selftests: fill in some missing configs for net")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 tools/testing/selftests/net/config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index d4891f7a2bfa..f46e27cd1e70 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -26,7 +26,6 @@ CONFIG_INET_ESP=y
 CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_NET_FOU=y
 CONFIG_NET_FOU_IP_TUNNELS=y
-CONFIG_IP_GRE=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NF_CONNTRACK=m
-- 
2.34.1


